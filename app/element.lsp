; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:element:align:horizontal:SS (/ osval activeSS baseBlock blockToAlign baseY 
                                       blockX blockY
                                      ) 

  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (setq i 0)
  (print "Wybierz elementy do pozycjonowania")
  (setq activeSS (ssget))

  (print "Wybierz element wzgledem ktorego wyrownac")
  (setq baseBlock (car (entsel)))
  (repeat (sslength activeSS) 
    (setq blockToAlign (ssname activeSS i))

    (if (fl:block:is blockToAlign) 
      (progn 
        (setq baseY (cadr (fl:block:position:get baseBlock)))
        (setq blockX (car (fl:block:position:get blockToAlign)))
        (setq blockY (cadr (fl:block:position:get blockToAlign)))

        (command "._move" 
                 blockToAlign
                 ""
                 (list blockX blockY)
                 (list blockX baseY)
        )
      )
    )
    (setq i (+ 1 i))
  )

  (setvar "OSMODE" osval)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:element:align:vertical:SS (/ osval activeSS baseBlock blockToAlign baseX 
                                     blockX blockY
                                    ) 

  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (setq i 0)
  (print "Wybierz elementy do pozycjonowania")
  (setq activeSS (ssget))

  (print "Wybierz element wzgledem ktorego wyrownac")
  (setq baseBlock (car (entsel)))
  (repeat (sslength activeSS) 
    (setq blockToAlign (ssname activeSS i))

    (if (fl:block:is blockToAlign) 
      (progn 
        (setq baseX (car (fl:block:position:get baseBlock)))
        (setq blockX (car (fl:block:position:get blockToAlign)))
        (setq blockY (cadr (fl:block:position:get blockToAlign)))

        (command "._move" 
                 blockToAlign
                 ""
                 (list blockX blockY)
                 (list baseX blockY)
        )
      )
    )
    (setq i (+ 1 i))
  )

  (setvar "OSMODE" osval)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:element:pair:vertical:SS (/ osval ActiveSel) 
  (setq ActiveSel (cadr (ssgetfirst)))
  (if (and ActiveSel (= (sslength ActiveSel) 2)) 
    (progn 
      (setq osval (getvar "OSMODE"))
      (setvar "OSMODE" 0)
      (command "._move" 
               (ssname ActiveSel 1)
               ""
               (fl:block:position:get (ssname ActiveSel 1))
               (fl:block:position:get (ssname ActiveSel 0))
      )
      (command "._move" 
               (ssname ActiveSel 1)
               ""
               "non"
               "0,0"
               "non"
               (list 0 
                     (* CONF_ATTRIB_PAIR_VERTICAL 
                        (fl:block:scale:get (ssname ActiveSel 1))
                     )
               )
      )

      (fl:attrib:location:set (ssname ActiveSel 0) "CENTRALA" "UC")
      (fl:attrib:location:set (ssname ActiveSel 1) "CENTRALA" "DC")

      (setvar "OSMODE" osval)
    )
    (print "Nic nie wybrano albo wybrano za zle")
  )
)

; --------------------------------------------------------------------------------------------------------

(defun fl:element:pair:horizontal:SS (/ osval ActiveSel) 
  (setq ActiveSel (cadr (ssgetfirst)))
  (if (and ActiveSel (= (sslength ActiveSel) 2)) 
    (progn 
      (setq osval (getvar "OSMODE"))
      (setvar "OSMODE" 0)
      (command "._move" 
               (ssname ActiveSel 1)
               ""
               (fl:block:position:get (ssname ActiveSel 1))
               (fl:block:position:get (ssname ActiveSel 0))
      )
      (command "._move" 
               (ssname ActiveSel 1)
               ""
               "non"
               "0,0"
               "non"
               (list 
                 (* CONF_ATTRIB_PAIR_HORIZONTAL 
                    (fl:block:scale:get (ssname ActiveSel 1))
                 )
                 0
               )
      )
      (fl:attrib:location:set (ssname ActiveSel 0) "CENTRALA" "MLW")
      (fl:attrib:location:set (ssname ActiveSel 1) "CENTRALA" "MR")
      (setvar "OSMODE" osval)
    )
    (print "Nic nie wybrano albo wybrano za zle")
  )
)

; --------------------------------------------------------------------------------------------------------

(defun fl:element:insert:wz (/ osval ActiveSel block) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (setq ActiveSel (ssget))
  (setq i 0)

  (if ActiveSel 
    (progn 
      (repeat (sslength ActiveSel) 
        (setq block (ssname ActiveSel i))
        (if (fl:block:is block) 
          (progn 
            (setq entity (entget block))

            (setq blockX     (nth 1 (assoc 10 entity))
                  blockY     (nth 2 (assoc 10 entity))
                  blockScale (cdr (assoc 41 entity))
                  blockAngle (cdr (assoc 50 entity))
                  blockLayer (cdr (assoc 8 entity))
            )

            (setq wzPosition (list blockX blockY))

            (fl:block:insert 
              "DUW"
              "SSP_WZ_SUFIT"
              wzPosition
              blockScale
              (rad2deg blockAngle)
            )

            (setq wzEntityName (entlast))
            (setq wz (entget wzEntityName))

            (entmod 
              (subst (cons 8 blockLayer) 
                     (assoc 8 wz)
                     wz
              )
            )
            
            (setq blockCentrala (fl:attrib:content:get block "CENTRALA"))
            (fl:attrib:content:set wzEntityName "CENTRALA" blockCentrala)
            (print blockCentrala)
          )
        )
        (setq i (+ i 1))
      )
    )
    (print "Nic nie wybrano")
  )
  (print)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:element:insert (blockGroup blockName) 
  (fl:block:insert blockGroup blockName NIL CONF_SCALE_DEFAULT 0)
)

(defun fl:element:rotate (entityName angle) 
  (setq currentAngle (fl:block:angle:get entityName))
  (setq newAngle (+ currentAngle angle))
  (fl:block:angle:set entityName newAngle)
)
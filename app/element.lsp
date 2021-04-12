(defun fl:Polylinia1 (x1 y1 x3 y3 / osval) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (setq p1 (list x1 y1))
  (setq p3 (list x3 y3))

  (setq x2 x3)
  (setq y2 y1)

  (setq p2 (list x2 y2))

  (command "_pline" p1 p2 p3 "")

  (setvar "OSMODE" osval)
)


(defun fl:Polylinia2 (x1 y1 x4 y4 / osval) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)
  
  (setq p1 (list x1 y1))
  (setq p4 (list x4 y4))

  (setq x2 (+ x1 (/ (- x4 x1) 2)))
  (setq y2 y1)
  (setq x3 x2)
  (setq y3 (cadr p4))

  (setq p2 (list x2 y2))
  (setq p3 (list x3 y3))

  (command "_pline" p1 p2 p3 p4 "")

  (setvar "OSMODE" osval)
)


(defun fl:element:connect (startEntity endEntity) 
  (setq startX (car (fl:block:position:get startEntity)))
  (setq startY (cadr (fl:block:position:get startEntity)))
  (setq endX (car (fl:block:position:get endEntity)))
  (setq endY (cadr (fl:block:position:get endEntity)))
  (setq blockScale (fl:block:scale:get startEntity))
  
  (setq startX (+ startX (* blockScale 200)))
  (setq endY (+ endY (* blockScale 200)))
  
  (fl:Polylinia1 startX startY endX endY)
)

(defun fl:element:locateAnchor () 
  (setq anchor (getpoint))
)


(defun fl:element:connect2 () 
  (setq activeSS (cadr (ssgetfirst)))
  (if activeSS 
    (progn 
      (if (= (sslength activeSS) 2) 
        (progn 
          (print "niby dwa")
          (fl:layer:on "__ELEMENT_UCHWYT")
          (setq ptS getpoint)
          (setq ptE getpoint)

          (fl:layer:off "__ELEMENT_UCHWYT")
        )
        (progn 
          (print "Zle wybrano")
        )
      )
    )
    (progn 
      (print "Nic nie wybrano")
      (setq activeSS nil)
    )
  )
)


(defun fl:element:align:horizontal:ss (/ osval activeSS baseBlock blockToAlign baseY 
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

        (command "._move" blockToAlign "" (list blockX blockY) (list blockX baseY))
      )
    )
    (setq i (+ 1 i))
  )

  (setvar "OSMODE" osval)
)


(defun fl:element:align:vertical:ss (/ osval activeSS baseBlock blockToAlign baseX 
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

        (command "._move" blockToAlign "" (list blockX blockY) (list baseX blockY))
      )
    )
    (setq i (+ 1 i))
  )

  (setvar "OSMODE" osval)
)



(defun fl:element:pair:vertical:SS (/ ActiveSel) 
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
      (setvar "OSMODE" osval)
    )
    (print "Nic nie wybrano albo wybrano za zle")
  )
)


(defun fl:element:pair:horizontal:SS (/ ActiveSel) 
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
      (setvar "OSMODE" osval)
    )
    (print "Nic nie wybrano albo wybrano za zle")
  )
)
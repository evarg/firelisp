(setq VIS_ON 0)
(setq VIS_OFF 1)

; =============================================================================================================
; | Funkcja       | fl:attrib:content:get                                                                     |
; |============================================================================================================
; | Atrybuty      | entityName - nazwa                                                                                           |
; |               |                                                                                           |
; |============================================================================================================
; | Przeznaczenie | Funkcja wyświetla okno dialogowe About                                                    |
; =============================================================================================================

(defun fl:attrib:content:get (entityName attribName / enx exitValue) 
  (if (entnext entityName) 
    (while 
      (and 
        (null end)
        (= "ATTRIB" 
           (cdr 
             (assoc 0 (setq enx (entget (setq entityName (entnext entityName)))))
           )
        )
      ) ;and

      (if (= (strcase attribName) (strcase (cdr (assoc 2 enx)))) 
        (setq exitValue (cdr (assoc 1 enx)))
      ) ;if
    ) ;while
    (setq exitValue nil)
  )
  exitValue
)

(defun fl:attrib:content:set (entityName attribName value) 
  (fl:attrib:parametr:set entityName attribName 1 value)
)

(defun fl:attrib:visibility (entityName attribName visibility)
  (fl:attrib:parametr:set entityName attribName 70 visibility)
)

(defun fl:attrib:global:visibility (attribName visibility / i ssAllBlocks) 
  (setq ssAllBlocks (ssget "_X" '((0 . "INSERT"))))

  (setq i 0)
  (repeat (sslength ssAllBlocks) 
    (progn 
      (fl:attrib:visibility (ssname ssAllBlocks i) attribName visibility)
      (setq i (+ i 1))
    )
  )
)

(defun fl:attrib:font:size:set (entityName attribName textHeight) 
  (fl:attrib:parametr:set entityName attribName 40 textHeight)
)

(defun fl:attrib:global:font:size (attribName textHeight / i ssAllBlocks) 
  (setq ssAllBlocks (ssget "_X" '((0 . "INSERT"))))

  (setq i 0)
  (repeat (sslength ssAllBlocks) 
    (progn 
      (fl:attrib:font:size:set (ssname ssAllBlocks i) attribName textHeight)
      (setq i (+ i 1))
    )
  )
)

(defun fl:attrib:parametr:set (entityName attribName parametrNumber value / enx 
                               entityDXFpopr
                              ) 
  (setq end T)

  (while end 
    (if (null entityName) 
      (progn 
        (setq end NIL)
      )
      (progn 
        (if 
          (= 
            (cdr 
              (assoc 2 (entget entityName))
            )
            attribName
          )
          (setq entityName (entnext entityName))
        )
      )
    )
  ) ;defun
)

(defun orgfl:attrib:parametr:set (entityName attribName parametrNumber value / enx 
                                  entityDXFpopr
                                 ) 
  (while 
    (and 
      (null end)
      (= "ATTRIB" 
         (cdr 
           (assoc 0 (setq enx (entget (setq entityName (entnext entityName)))))
         )
      )
    ) ;and

    (if (= (strcase attribName) (strcase (cdr (assoc 2 enx)))) 
      (setq entityDXFpopr (subst (cons parametrNumber value) 
                                 (assoc parametrNumber enx)
                                 enx
                          )
      )
    ) ;if
  ) ;while
  (entmod entityDXFpopr)
) ;defun




  ;
  ; entityName - musi byc: (car (entsel))
  ;
(defun fl:attrib:justify:set (entityName attribName horizontal vertical) 
  (fl:attrib:parametr:set entityName attribName 72 horizontal)
  (fl:attrib:parametr:set entityName attribName 74 vertical)
) ;defun
(defun fl:attrib:position:set (entityName attribName diffX diffY / enx blockPosition 
                               blockScale attribPosition
                              ) 
  (setq blockPosition (fl:block:position:get entityName))
  (setq blockScale (fl:block:scale:get entityName))

  (setq attribPosition (list 
                         (+ (car blockPosition) (* blockScale diffX))
                         (+ (cadr blockPosition) (* blockScale diffY))
                       )
  )

  (fl:attrib:parametr:set 
    entityName
    attribName
    11
    attribPosition
  )
) ;defun
(defun fl:attrib:location:setSS (location / block ActiveSel i) 
  (setq ActiveSel (cadr (ssgetfirst)))
  (setq i 0)
  (if ActiveSel 
    (progn 
      (repeat (sslength ActiveSel) 
        (setq block (ssname ActiveSel i))
        (if (fl:block:is block) 
          (progn 
            (setq skalaBloku (fl:block:scale:get block))
            (fl:attrib:location:set 
              block
              CONF_ATTRIB_OPERATION
              location
            )
          )
        )
        (setq i (+ i 1))
      )
    )
    (print "Nic nie wybrano")
  )
)

  ;
  ; pozycjonowanie atrybutu
  ; location: UL UC UR ML MC MR DL DC DR MLW
  ;
(defun fl:attrib:location:set (entityName attribName location / blockScale) 
  (setq blockScale (fl:block:scale:get entityName))

  (if (= location "UL") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_RIGHT J_DOWN)
      (fl:attrib:position:set 
        entityName
        attribName
        CONF_ATTRIB_POSITION_L
        CONF_ATTRIB_POSITION_U
      )
    )
  )

  (if (= location "UC") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_CENTER J_DOWN)
      (fl:attrib:position:set 
        entityName
        attribName
        0
        CONF_ATTRIB_POSITION_U
      )
    )
  )

  (if (= location "UR") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_LEFT J_DOWN)
      (fl:attrib:position:set 
        entityName
        attribName
        CONF_ATTRIB_POSITION_R
        CONF_ATTRIB_POSITION_U
      )
    )
  )

  (if (= location "ML") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_RIGHT J_MIDDLE)
      (fl:attrib:position:set 
        entityName
        attribName
        CONF_ATTRIB_POSITION_L
        0
      )
    )
  )

  (if (= location "MLW") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_RIGHT J_MIDDLE)
      (fl:attrib:position:set 
        entityName
        attribName
        (+ CONF_ATTRIB_POSITION_L CONF_ATTRIB_POSITION_WZ)
        0
      )
    )
  )

  (if (= location "MC") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_CENTER J_MIDDLE)
      (fl:attrib:position:set 
        entityName
        attribName
        0
        0
      )
    )
  )

  (if (= location "MR") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_LEFT J_MIDDLE)
      (fl:attrib:position:set 
        entityName
        attribName
        CONF_ATTRIB_POSITION_R
        0
      )
    )
  )

  (if (= location "DL") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_RIGHT J_UP)
      (fl:attrib:position:set 
        entityName
        attribName
        CONF_ATTRIB_POSITION_L
        CONF_ATTRIB_POSITION_D
      )
    )
  )

  (if (= location "DC") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_CENTER J_UP)
      (fl:attrib:position:set 
        entityName
        attribName
        0
        CONF_ATTRIB_POSITION_D
      )
    )
  )

  (if (= location "DR") 
    (progn 
      (fl:attrib:justify:set entityName attribName J_LEFT J_UP)
      (fl:attrib:position:set 
        entityName
        attribName
        CONF_ATTRIB_POSITION_R
        CONF_ATTRIB_POSITION_D
      )
    )
  )
)
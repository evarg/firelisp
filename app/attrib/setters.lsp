; =================================================================================================
; | Start informations                                                                            |
; =================================================================================================

(print "Load: attrib\\setters")


; =================================================================================================
; | Functions                                                                                     |
; =================================================================================================

(defun fl:attrib:content:set (entityName attribName value) 
  (fl:attrib:parametr:set entityName attribName 1 value)
)

; -------------------------------------------------------------------------------------------------

(defun fl:attrib:visibility (entityName attribName visibility) 
  (fl:attrib:parametr:set entityName attribName 70 visibility)
)

; -------------------------------------------------------------------------------------------------

(defun fl:attrib:font:size:set (entityName attribName textHeight) 
  (fl:attrib:parametr:set entityName attribName 40 textHeight)
)

; -------------------------------------------------------------------------------------------------

(defun fl:attrib:parametr:set (entityName attribName parametrNumber value / enx 
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
    )

    (if (= (strcase attribName) (strcase (cdr (assoc 2 enx)))) 
      (setq entityDXFpopr (subst (cons parametrNumber value) 
                                 (assoc parametrNumber enx)
                                 enx
                          )
      )
    )
  )
  (entmod entityDXFpopr)
)

; -------------------------------------------------------------------------------------------------

(defun fl:attrib:justify:set (entityName attribName horizontal vertical) 
  (fl:attrib:parametr:set entityName attribName 72 horizontal)
  (fl:attrib:parametr:set entityName attribName 74 vertical)
)

; -------------------------------------------------------------------------------------------------

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
)

; -------------------------------------------------------------------------------------------------

(defun fl:attrib:location:setSS (location / block ActiveSel i) 
  (setq ActiveSel (cadr (ssgetfirst)))
  (setq i 0)
  (if ActiveSel 
    (progn 
      (repeat (sslength ActiveSel) 
        (setq block (ssname ActiveSel i))
        (if (fl:block:is block) 
          (progn 
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

; -------------------------------------------------------------------------------------------------

(defun old:fl:attrib:location:set (entityName attribName location) 
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

; -------------------------------------------------------------------------------------------------

(defun fl:attrib:location:set (entityName attribName location / justifyHorizontal 
                               justifyVertical positionHorizontal positionVertical
                              ) 

  (cond 
    ((= location "UL")
     (setq justifyHorizontal  J_RIGHT
           justifyVertical    J_DOWN
           positionHorizontal CONF_ATTRIB_POSITION_L
           positionVertical   CONF_ATTRIB_POSITION_U
     )
    )

    ((= location "UC")
     (setq justifyHorizontal  J_CENTER
           justifyVertical    J_DOWN
           positionHorizontal 0
           positionVertical   CONF_ATTRIB_POSITION_U
     )
    )

    ((= location "UR")
     (setq justifyHorizontal  J_LEFT
           justifyVertical    J_DOWN
           positionHorizontal CONF_ATTRIB_POSITION_R
           positionVertical   CONF_ATTRIB_POSITION_U
     )
    )

    ((= location "ML")
     (setq justifyHorizontal  J_RIGHT
           justifyVertical    J_MIDDLE
           positionHorizontal CONF_ATTRIB_POSITION_L
           positionVertical   0
     )
    )

    ((= location "MLW")
     (setq justifyHorizontal  J_RIGHT
           justifyVertical    J_MIDDLE
           positionHorizontal (+ CONF_ATTRIB_POSITION_L CONF_ATTRIB_POSITION_WZ)
           positionVertical   0
     )
    )

    ((= location "MC")
     (setq justifyHorizontal  J_CENTER
           justifyVertical    J_MIDDLE
           positionHorizontal 0
           positionVertical   0
     )
    )

    ((= location "MR")
     (setq justifyHorizontal  J_LEFT
           justifyVertical    J_MIDDLE
           positionHorizontal CONF_ATTRIB_POSITION_R
           positionVertical   0
     )
    )

    ((= location "DL")
     (setq justifyHorizontal  J_RIGHT
           justifyVertical    J_UP
           positionHorizontal CONF_ATTRIB_POSITION_L
           positionVertical   CONF_ATTRIB_POSITION_D
     )
    )

    ((= location "DC")
     (setq justifyHorizontal  J_CENTER
           justifyVertical    J_UP
           positionHorizontal 0
           positionVertical   CONF_ATTRIB_POSITION_D
     )
    )

    ((= location "DR")
     (setq justifyHorizontal  J_LEFT
           justifyVertical    J_UP
           positionHorizontal CONF_ATTRIB_POSITION_R
           positionVertical   CONF_ATTRIB_POSITION_D
     )
    )

    (t
     (setq justifyHorizontal  J_CENTRER
           justifyVertical    J_UP
           positionHorizontal 0
           positionVertical   CONF_ATTRIB_POSITION_D
     )
    )
  )

  (fl:attrib:justify:set entityName attribName justifyHorizontal justifyVertical)
  (fl:attrib:position:set 
    entityName
    attribName
    positionHorizontal
    positionVertical
  )
)


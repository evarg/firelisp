(defun fl:attrib:content:get (entityName attribName / enx exitValue) 
  (while 
    (and 
      (null end)
      (= "ATTRIB" 
         (cdr (assoc 0 (setq enx (entget (setq entityName (entnext entityName))))))
      )
    ) ;and

    (if (= (strcase attribName) (strcase (cdr (assoc 2 enx)))) 
      (setq exitValue (cdr (assoc 1 enx)))
    ) ;if
  ) ;while
  exitValue
)


(defun fl:attrib:content:set (entityName attribName value) 
  (fl:attrib:parametr:set entityName attribName 1 value)
)


(defun fl:attrib:parametr:set (entityName attribName parametrNumber value / enx 
                               entityDXFpopr
                              ) 
  (while 
    (and 
      (null end)
      (= "ATTRIB" 
         (cdr (assoc 0 (setq enx (entget (setq entityName (entnext entityName))))))
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
);defun


;
; entityName - musi byc: (car (entsel))
;
(defun fl:attrib:justify:set (entityName attribName horizontal vertical) 
  (fl:attrib:parametr:set entityName attribName 72 horizontal)
  (fl:attrib:parametr:set entityName attribName 74 vertical)
);defun


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
);defun


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

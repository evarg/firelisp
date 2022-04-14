; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:element:connect (/ ee pt1 pt2 block1 block2 blockScale anchor1 startPoint 
                           endPoint anchor2 posStart posEnd
                          ) 

  (setvar "OSMODE" 1)
  (fl:layer:on "__ELEMENT_UCHWYT")

  ; pobranie pierwszego uchwytu
  (setq ee T)
  (while ee 
    (setq pt1 (getpoint "Wybierz uchwyt poprzedniego elementu"))
    (setq block1 (car (nth 3 (nentselp pt1))))
    (if (fl:block:is block1) 
      (setq ee nil)
    )
  )

  ; pobranie pierwszego uchwytu
  (setq ee T)
  (while ee 
    (setq pt2 (getpoint "Wybierz uchwyt nastepnego elementu"))
    (setq block2 (car (nth 3 (nentselp pt2))))
    (if (fl:block:is block2) 
      (setq ee nil)
    )
  )

  (fl:layer:off "__ELEMENT_UCHWYT")

  (setq blockScale (fl:block:scale:get block1))

  (setq anchor1 (fl:element:locateConnect 
                  (fl:block:position:get block1)
                  pt1
                  blockScale
                )
  )
  (setq anchor2 (fl:element:locateConnect 
                  (fl:block:position:get block2)
                  pt2
                  blockScale
                )
  )

  (setq startPoint (fl:element:calculateOffset block1 anchor1))
  (setq endPoint (fl:element:calculateOffset block2 anchor2))

  (setq posStart (substr anchor1 1 1))
  (setq posEnd (substr anchor2 1 1))

  (if (= posStart "L") 
    (progn 
      (if (= posEnd "R") (fl:polyline2H startPoint endPoint))
      (if (= posEnd "U") (fl:polyline1H startPoint endPoint))
      (if (= posEnd "D") (fl:polyline1h startPoint endPoint))
    )
  )

  (if (= posStart "R") 
    (progn 
      (if (= posEnd "L") (fl:polyline2H startPoint endPoint))
      (if (= posEnd "U") (fl:polyline1H startPoint endPoint))
      (if (= posEnd "D") (fl:polyline1H startPoint endPoint))
    )
  )

  (if (= posStart "U") 
    (progn 
      (if (= posEnd "L") (fl:polyline1V startPoint endPoint))
      (if (= posEnd "R") (fl:polyline1V startPoint endPoint))
      (if (= posEnd "D") (fl:polyline2V startPoint endPoint))
    )
  )

  (if (= posStart "D") 
    (progn 
      (if (= posEnd "L") (fl:polyline1V startPoint endPoint))
      (if (= posEnd "R") (fl:polyline1V startPoint endPoint))
      (if (= posEnd "U") (fl:polyline2V startPoint endPoint))
    )
  )
)

; --------------------------------------------------------------------------------------------------------

(defun fl:element:locateConnect (blockPoint connectPoint blockScale / location diffX 
                                 diffY
                                ) 

  (setq diffX (atof (rtos (- (car connectPoint) (car blockPoint)) 2 4)))
  (setq diffX (atoi (rtos (/ diffX blockScale) 2 0)))
  (setq diffY (atof (rtos (- (cadr connectPoint) (cadr blockPoint)) 2 4)))
  (setq diffY (atoi (rtos (/ diffY blockScale) 2 0)))

  (setq location "dupa")

  (if (and (= diffX -250.0) (= diffY 50)) (setq location "LU"))
  (if (and (= diffX -250.0) (= diffY 0)) (setq location "LM"))
  (if (and (= diffX -250.0) (= diffY -50)) (setq location "LD"))

  (if (and (= diffX 250.0) (= diffY 50)) (setq location "RU"))
  (if (and (= diffX 250.0) (= diffY 0)) (setq location "RM"))
  (if (and (= diffX 250.0) (= diffY -50)) (setq location "RD"))

  (if (and (= diffX -50.0) (= diffY 250)) (setq location "UL"))
  (if (and (= diffX 0.0) (= diffY 250)) (setq location "UC"))
  (if (and (= diffX 50.0) (= diffY 250)) (setq location "UR"))

  (if (and (= diffX -50.0) (= diffY -250)) (setq location "DL"))
  (if (and (= diffX 0.0) (= diffY -250)) (setq location "DC"))
  (if (and (= diffX 50.0) (= diffY -250)) (setq location "DR"))

  location
)

; --------------------------------------------------------------------------------------------------------

(defun fl:element:calculateOffset (entityName location / point) 
  (setq blockPoint (fl:block:position:get entityName))
  (setq blockScale (fl:block:scale:get entityName))

  (if (= location "LU") 
    (setq point (list 
                  (+ (car blockPoint) (* -200 blockScale))
                  (+ (cadr blockPoint) (* 50 blockScale))
                )
    )
  )

  (if (= location "LM") 
    (setq point (list 
                  (+ (car blockPoint) (* -200 blockScale))
                  (+ (cadr blockPoint) (* 0 blockScale))
                )
    )
  )

  (if (= location "LD") 
    (setq point (list 
                  (+ (car blockPoint) (* -200 blockScale))
                  (+ (cadr blockPoint) (* -50 blockScale))
                )
    )
  )

  (if (= location "RU") 
    (setq point (list 
                  (+ (car blockPoint) (* 200 blockScale))
                  (+ (cadr blockPoint) (* 50 blockScale))
                )
    )
  )

  (if (= location "RM") 
    (setq point (list 
                  (+ (car blockPoint) (* 200 blockScale))
                  (+ (cadr blockPoint) (* 0 blockScale))
                )
    )
  )

  (if (= location "RD") 
    (setq point (list 
                  (+ (car blockPoint) (* 200 blockScale))
                  (+ (cadr blockPoint) (* -50 blockScale))
                )
    )
  )

  (if (= location "UL") 
    (setq point (list 
                  (+ (car blockPoint) (* -50 blockScale))
                  (+ (cadr blockPoint) (* 200 blockScale))
                )
    )
  )

  (if (= location "UC") 
    (setq point (list 
                  (+ (car blockPoint) (* 0 blockScale))
                  (+ (cadr blockPoint) (* 200 blockScale))
                )
    )
  )

  (if (= location "UR") 
    (setq point (list 
                  (+ (car blockPoint) (* 50 blockScale))
                  (+ (cadr blockPoint) (* 200 blockScale))
                )
    )
  )

  (if (= location "DL") 
    (setq point (list 
                  (+ (car blockPoint) (* -50 blockScale))
                  (+ (cadr blockPoint) (* -200 blockScale))
                )
    )
  )

  (if (= location "DC") 
    (setq point (list 
                  (+ (car blockPoint) (* 0 blockScale))
                  (+ (cadr blockPoint) (* -200 blockScale))
                )
    )
  )

  (if (= location "DR") 
    (setq point (list 
                  (+ (car blockPoint) (* 50 blockScale))
                  (+ (cadr blockPoint) (* -200 blockScale))
                )
    )
  )

  point
)

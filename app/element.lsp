(defun fl:polyline1V (startPoint endPoint / osval midPoint1) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (setq midPoint1 (list 
                    (car startPoint)
                    (cadr endPoint)
                  )
  )

  (command "_pline" startPoint midPoint1 endPoint "")

  (setvar "OSMODE" osval)
)


(defun fl:polyline1H (startPoint endPoint / osval midPoint1) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (setq midPoint1 (list 
                    (car endPoint)
                    (cadr startPoint)
                  )
  )

  (command "_pline" startPoint midPoint1 endPoint "")

  (setvar "OSMODE" osval)
)

(defun fl:polyline2H (startPoint endPoint / osval midPoint1 midPoint2 x) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (setq x (+ (car startPoint) (/ (- (car endPoint) (car startPoint)) 2)))

  (setq midPoint1 (list 
                    x
                    (cadr startPoint)
                  )
  )

  (setq midPoint2 (list 
                    x
                    (cadr endPoint)
                  )
  )

  (command "_pline" startPoint midPoint1 midPoint2 endPoint "")

  (setvar "OSMODE" osval)
)


(defun fl:polyline2V (startPoint endPoint / osval midPoint1 midPoint2 y) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (setq y (+ (cadr startPoint) (/ (- (cadr endPoint) (cadr startPoint)) 2)))

  (setq midPoint1 (list 
                    (car startPoint)
                    y
                  )
  )

  (setq midPoint2 (list 
                    (car endPoint)
                    y
                  )
  )

  (command "_pline" startPoint midPoint1 midPoint2 endPoint "")

  (setvar "OSMODE" osval)
)


(defun fl:element:locateConnect (blockPoint connectPoint blockScale / location diffX 
                                 diffY
                                ) 
  (setq diffX (atof (rtos (- (car connectPoint) (car blockPoint)) 2 4)))
  (setq diffY (atof (rtos (- (cadr connectPoint) (cadr blockPoint)) 2 4)))
  (print "diff from locateConnect")
  (setq diffX (atoi (rtos (/ diffX blockScale) 2 0)))
  (setq diffY (atoi (rtos (/ diffY blockScale) 2 0)))

  (setq location "dupa")

  (print diffX)
  (print diffY)

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


(defun fl:element:connect (/ pt1 pt2) 
  ;  (setq selectedBlock (car (nth 3 (nentselp pt))))

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

  (setq block1Point (fl:block:position:get block1))
  (setq block2Point (fl:block:position:get block2))
  (setq block1Scale (fl:block:scale:get block1))
  (setq block2Scale (fl:block:scale:get block2))

  (setq anchor1 (fl:element:locateConnect block1Point pt1 block1Scale))
  (setq anchor2 (fl:element:locateConnect block2Point pt2 block2Scale))

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


(defun fl:element:calculateOffset (entityName location) 
  (setq blockPoint (fl:block:position:get entityName))

  (if (= location "LU") 
    (setq point (list 
                  (+ (car blockPoint) -200)
                  (+ (cadr blockPoint) 50)
                )
    )
  )

  (if (= location "LM") 
    (setq point (list 
                  (+ (car blockPoint) -200)
                  (+ (cadr blockPoint) 0)
                )
    )
  )

  (if (= location "LD") 
    (setq point (list 
                  (+ (car blockPoint) -200)
                  (+ (cadr blockPoint) -50)
                )
    )
  )

  (if (= location "RU") 
    (setq point (list 
                  (+ (car blockPoint) 200)
                  (+ (cadr blockPoint) 50)
                )
    )
  )

  (if (= location "RM") 
    (setq point (list 
                  (+ (car blockPoint) 200)
                  (+ (cadr blockPoint) 0)
                )
    )
  )

  (if (= location "RD") 
    (setq point (list 
                  (+ (car blockPoint) 200)
                  (+ (cadr blockPoint) -50)
                )
    )
  )

  (if (= location "UL") 
    (setq point (list 
                  (+ (car blockPoint) -50)
                  (+ (cadr blockPoint) 200)
                )
    )
  )

  (if (= location "UC") 
    (setq point (list 
                  (+ (car blockPoint) 0)
                  (+ (cadr blockPoint) 200)
                )
    )
  )

  (if (= location "UR") 
    (setq point (list 
                  (+ (car blockPoint) 50)
                  (+ (cadr blockPoint) 200)
                )
    )
  )

  (if (= location "DL") 
    (setq point (list 
                  (+ (car blockPoint) -50)
                  (+ (cadr blockPoint) -200)
                )
    )
  )

  (if (= location "DC") 
    (setq point (list 
                  (+ (car blockPoint) 0)
                  (+ (cadr blockPoint) -200)
                )
    )
  )

  (if (= location "DR") 
    (setq point (list 
                  (+ (car blockPoint) 50)
                  (+ (cadr blockPoint) -200)
                )
    )
  )

  point
)


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
(defun fl:element:connect4 (startEntity endEntity) 
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
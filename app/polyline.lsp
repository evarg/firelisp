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
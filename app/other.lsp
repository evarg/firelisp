(defun fl:string2list (str separator / pos len lst) 
  (setq len (1+ (strlen separator)))
  (while (setq pos (vl-string-search separator str)) 
    (setq lst (cons (substr str 1 pos) lst)
          str (substr str (+ pos len))
    )
  )
  (reverse (cons str lst))
)


(defun fl:list2string (lst separator / str itm) 
  (setq str (car lst))
  (foreach itm (cdr lst) (setq str (strcat str separator itm)))
  str
)


(defun fl:uuid.old (/ auuid) 
  (setq aauid (substr (rtos (fl:random) 2 6) 3 4))
  (setq aauid (strcat aauid "-" (substr (rtos (fl:random) 2 6) 3 6)))
  (setq aauid (strcat aauid "-" (substr (rtos (fl:random) 2 6) 3 4)))
  aauid
)


(defun fl:uuid (/ rv) 
  (setq rv (strcat 
             (substr (rtos (fl:random) 2 6) 3 4)
             "-"
             (substr (rtos (fl:random) 2 6) 3 6)
             "-"
             (substr (rtos (fl:random) 2 6) 3 4)
           )
  )
  rv
)


(defun fl:random (/ a c m) 
  (setq m   4294967296.0
        a   1664525.0
        c   1013904223.0
        $xn (rem (+ c (* a (cond ($xn) ((getvar 'date))))) m)
  )
  (/ $xn m)
)
(defun fl:Polylinia2 (cid1 cid2) 
  (setq pt001 (fl:block:position:get (fl:block:searchByFID cid1)))
  (setq pt100 (fl:block:position:get (fl:block:searchByFID cid2)))
  
  (setq pt002 (list (car pt100) (cadr pt001)) )
  
  (command "_pline" pt001 pt002 pt100 "")
)


(defun pl:Polylinia2 (x1 y1 x4 y4) 
  (setq p1 (list x1 y1))
  (setq p4 (list x2 y2))

  (setq x2 (+ x1 (/ (- x4 x1) 2)))
  (setq y2 y1)
  (setq x3 x2)
  (setq y3 (cadr p4))

  (setq p2 (list x2 y2))
  (setq p3 (list x3 y3))

  (command "_pline" p1 p2 p3 p4 "")
)

(defun fl:string2list (str separator / pos len lst) 
  (setq len (1+ (strlen separator)))
  (while (setq pos (vl-string-search separator str)) 
    (setq lst (cons (substr str 1 pos) lst)
          str (substr str (+ pos len))
    )
  )
  (reverse (cons str lst))
)

(defun fl:list2string (lst separator / str) 
  (setq str (car lst))
  (foreach itm (cdr lst) (setq str (strcat str separator itm)))
  str
)

(defun fl:uuid (/ auuid) 
  (setq aauid (substr (rtos (fl:random) 2 6) 3 4))
  (setq aauid (strcat aauid "-" (substr (rtos (fl:random) 2 6) 3 6)))
  (setq aauid (strcat aauid "-" (substr (rtos (fl:random) 2 6) 3 4)))
  aauid
)

(defun fl:random (/ a c m) 
  (setq m   4294967296.0
        a   1664525.0
        c   1013904223.0
        $xn (rem (+ c (* a (cond ($xn) ((getvar 'date))))) m)
  )
  (/ $xn m)
)
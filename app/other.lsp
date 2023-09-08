; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun deg2rad (angle) 
  (setq rad (* angle (/ pi 180.0)))
)

(defun rad2deg (angle) 
  (setq deg (/ (* angle 180) pi))
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

; --------------------------------------------------------------------------------------------------------

(defun fl:list2string (lst separator / str itm) 
  (setq str (car lst))
  (foreach itm (cdr lst) (setq str (strcat str separator itm)))
  str
)

; --------------------------------------------------------------------------------------------------------

(defun fl:uuid.old (/ auuid) 
  (setq aauid (substr (rtos (fl:random) 2 6) 3 4))
  (setq aauid (strcat aauid "-" (substr (rtos (fl:random) 2 6) 3 6)))
  (setq aauid (strcat aauid "-" (substr (rtos (fl:random) 2 6) 3 4)))
  aauid
)

; --------------------------------------------------------------------------------------------------------

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

; --------------------------------------------------------------------------------------------------------

(defun fl:random (/ a c m) 
  (setq m   4294967296.0
        a   1664525.0
        c   1013904223.0
        $xn (rem (+ c (* a (cond ($xn) ((getvar 'date))))) m)
  )
  (/ $xn m)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:deleteNoConfirm (/ entityName) 
  (setq entityName (car (entsel)))
  (entdel entityName)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:deleteNoConfirmLoop (/ entityName) 
  (while T 
    (progn 
      (setq entitySS (car (entsel "Wybierz encje do usuniecia")))
      (if entityName 
        (entdel entityName)
      )
    )
  )
)


(defun c:lineang (/ ename pt1 pt2) 
  (while (not (setq ename (entsel "\nPick line: "))))
  (setq ename (car ename))
  (setq pt1 (cdr (assoc 10 (entget ename))))
  (setq pt2 (cdr (assoc 11 (entget ename))))
  (angtos (angle pt1 pt2))
)

(defun c:textang (/ ename pt1 pt2) 
  (while (not (setq ename (entsel "\nPick line: "))))
  (setq ename (car ename))
  (setq a (atof (cdr (assoc 1 (entget ename)))))
  (print (- a 270))
)


(defun CreatBlock (BlkNme) 
  (entmake 
    (list '(0 . "BLOCK") 
          '(100 . "AcDbEntity")
          '(67 . 0)
          '(8 . "0")
          '(100 . "AcDbBlockReference")
          '(cons 2 BlkNme)
          '(10 0 0 0)
          '(70 . 0)
    )
  )
)

(defun fl:duw:insert (blok pa ln da plan raw) 
  (setq x (* 80 da))
  (setq y (+ (* 1000 pa) (* 100 ln)))

  (setq position (list x y))

  (fl:block:insert "DUW" blok position 0.1 0)
  (fl:attrib:content:set (entlast) "centrala" plan)
  (fl:attrib:content:set (entlast) "raw" raw)
)

(defun fl:duw:insert:circle (blok pa ln da plan raw) 
  (setq x (* 150 da))
  (setq y (+ (* 1000 pa) (* 100 ln)))

  (setq position (list x y))

  (fl:block:insert "DUW" blok position 0.1 0)
  (fl:attrib:content:set (entlast) "centrala" plan)
  (fl:attrib:content:set (entlast) "raw" raw)
)




(defun fl:duw:mtext2text (/ blok pa ln da plan raw) 
  (setq e (entget (car (entsel))))

  (setq angle (cdr (assoc 50 e)))
  (setq angle 777)

  (setq ne '((0 . "TEXT") ; Object type
             (8 . "dupa") ; Layer
             (410 . "Model")
             (10 -24200.0 257200.0 0.0)
             (40 . 1000.0)
             (1 . "Katownika")
             (50 . 0)
            )
  )

  (setq ne1 (subst (cons 50 angle) 
                   (assoc 50 ne)
                   ne
            )
  )

  (setq ne5 (list (cons 1 "te") (cons 1 "te")))

  (print ne5)
  (print)
)


;; Move to Top  -  Lee Mac
;; Moves a set of objects to the top of the draw order.
;; obs - [lst/sel] Selection set or list of objects with same owner
;; Returns: T if successful, else nil

(defun LM:movetotop (obs / tab) 
  (if 
    (and (or (= 'list (type obs)) (setq obs (LM:ss->vla obs))) 
         (setq tab (LM:sortentstable (LM:getowner (car obs))))
    )
    (not (vla-movetotop tab (LM:safearrayvariant vlax-vbobject obs)))
  )
)

;; Move to Bottom  -  Lee Mac
;; Moves a set of objects to the bottom of the draw order.
;; obs - [lst/sel] Selection set or list of objects with same owner
;; Returns: T if successful, else nil

(defun LM:movetobottom (obs / tab) 
  (if 
    (and (or (= 'list (type obs)) (setq obs (LM:ss->vla obs))) 
         (setq tab (LM:sortentstable (LM:getowner (car obs))))
    )
    (not (vla-movetobottom tab (LM:safearrayvariant vlax-vbobject obs)))
  )
)

;; Move Above  -  Lee Mac
;; Moves a set of objects above a supplied object in the draw order.
;; obs - [lst/sel] Selection set or list of objects with same owner
;; obj - [vla] Object above which to move supplied objects
;; Returns: T if successful, else nil

(defun LM:moveabove (obs obj / tab) 
  (if 
    (and (or (= 'list (type obs)) (setq obs (LM:ss->vla obs))) 
         (setq tab (LM:sortentstable (LM:getowner (car obs))))
    )
    (not (vla-moveabove tab (LM:safearrayvariant vlax-vbobject obs) obj))
  )
)

;; Move Below  -  Lee Mac
;; Moves a set of objects below a supplied object in the draw order.
;; obs - [lst/sel] Selection set or list of objects with same owner
;; obj - [vla] Object below which to move supplied objects
;; Returns: T if successful, else nil

(defun LM:movebelow (obs obj / tab) 
  (if 
    (and (or (= 'list (type obs)) (setq obs (LM:ss->vla obs))) 
         (setq tab (LM:sortentstable (LM:getowner (car obs))))
    )
    (not (vla-movebelow tab (LM:safearrayvariant vlax-vbobject obs) obj))
  )
)

;; Swap Order  -  Lee Mac
;; Swaps the draw order of two objects (may require regen).
;; ob1,ob2 - [vla] Objects to swap
;; Returns: T if successful, else nil

(defun LM:swaporder (ob1 ob2 / tab) 
  (if (setq tab (LM:sortentstable (LM:getowner ob1))) 
    (not (vla-swaporder tab ob1 ob2))
  )
)

;; Get Owner -  Lee Mac
;; A wrapper for the objectidtoobject method & ownerid property to enable
;; compatibility with 32-bit & 64-bit systems

(defun LM:getowner (obj) 
  (eval 
    (list 'defun 
          'LM:getowner
          '(obj)
          (if (vlax-method-applicable-p obj 'ownerid32) 
            (list 'vla-objectidtoobject32 (LM:acdoc) '(vla-get-ownerid32 obj))
            (list 'vla-objectidtoobject (LM:acdoc) '(vla-get-ownerid obj))
          )
    )
  )
  (LM:getowner obj)
)

;; Catch Apply  -  Lee Mac
;; Applies a function to a list of parameters and catches any exceptions.
 
(defun LM:catchapply (fnc prm / rtn) 
  (if (not (vl-catch-all-error-p (setq rtn (vl-catch-all-apply fnc prm)))) 
    rtn
  )
)

;; Sortents Table  -  Lee Mac
;; Retrieves the Sortents Table object.
;; obj - [vla] Block Container Object

(defun LM:sortentstable (obj / dic) 
  (cond 
    ((LM:catchapply 
       'vla-item
       (list (setq dic (vla-getextensiondictionary obj)) "acad_sortents")
     )
    )
    ((LM:catchapply 'vla-addobject (list dic "acad_sortents" "AcDbSortentsTable")))
  )
)

;; Selection Set to VLA Objects  -  Lee Mac
;; Converts a Selection Set to a list of VLA Objects
;; sel - [sel] Selection set (pickset)

(defun LM:ss->vla (sel / idx lst) 
  (if (= 'pickset (type sel)) 
    (repeat (setq idx (sslength sel)) 
      (setq lst (cons (vlax-ename->vla-object (ssname sel (setq idx (1- idx)))) 
                      lst
                )
      )
    )
  )
)

;; Safearray Variant  -  Lee Mac
;; Returns a populated safearray variant of a specified data type
;; typ - [int] Variant type enum (e.g. vlax-vbdouble)
;; lst - [lst] List of static type data

(defun LM:safearrayvariant (typ lst) 
  (vlax-make-variant 
    (vlax-safearray-fill 
      (vlax-make-safearray typ (cons 0 (1- (length lst))))
      lst
    )
  )
)

;; Active Document  -  Lee Mac
;; Returns the VLA Active Document Object

(defun LM:acdoc nil 
  (eval (list 'defun 
              'LM:acdoc
              'nil
              (vla-get-activedocument (vlax-get-acad-object))
        )
  )
  (LM:acdoc)
)


(defun c:layertop (/ ent) 
  (if (setq ent (car (entsel "\nSelect object on layer to move to top: "))) 
    (LM:movetotop 
      (ssget "_X" 
             (list 
               (assoc 8 (entget ent))
               (if (= 1 (getvar 'cvport)) 
                 (cons 410 (getvar 'ctab))
                 '(410 . "Model")
               )
             )
      )
    )
  )
  (princ)
)

(defun fl:attrib:content:copy (entityName fromName toName) 
  (fl:attrib:content:set en toName (fl:attrib:content:get entityName fromName))
)


(defun fl:attrib:copy:layer (layerName attribFrom attribTo / ss i ent) 

  (if (setq ss (ssget "_x" (list (cons 8 layerName)))) 
    (repeat (setq i (sslength ss)) 
      (setq ent (ssname ss (setq i (1- i))))
      (setq sourceValue (fl:attrib:content:get ent attribFrom))
      (fl:attrib:content:set ent attribTo sourceValue)
      (print centrala)
    )
  )
)

(defun fl:num:layer:random (layerList prefix suffix / ss i ent, newValue) 
  (setq counter 1)
  (setq ss (fl:ss:layer:list layerList))
  (repeat (setq i (sslength ss)) 
    (setq ent (ssname ss (setq i (1- i))))

    (if (/= "WZ" (assoc 1 (entget ent))) 
      (progn 
        (setq newValue (strcat prefix (fl:lead:zero counter 3) suffix))
        (setq counter (+ 1 counter))
        (fl:attrib:content:set ent "centrala" newValue)
        (print newValue)
      )
    )
  )
)


(defun fl:lead:zero (number stringWidth) 
  (setq number (itoa number))
  (setq return "")
  (setq zeroCount (- stringwidth (strlen number)))
  (repeat zeroCount 
    (setq return (strcat return "0"))
  )
  (strcat return number)
)

(defun LM:getattributevalue (blk tag / enx) 
  (if (= "ATTRIB" (cdr (assoc 0 (setq enx (entget (setq blk (entnext blk))))))) 
    (if (= (strcase tag) (strcase (cdr (assoc 2 enx)))) 
      (cdr (assoc 1 enx))
    )
  )
)

(defun fl:ss:layer:list (layerList) 
  (setq ll '((-4 . "OR>")))
  (foreach l layerlist (setq ll (cons (cons 8 l) ll)))
  (setq ll (cons '(-4 . "<OR") ll))
  (setq ss (ssget "X" ll))
)

(defun fl:layer:block:list (layerList / ss i ent, newValue) 
  (setq ss (fl:ss:layer:list layerList))
  (repeat (setq i (sslength ss)) 
    (setq ent (ssname ss (setq i (1- i))))
    ;    (print (entget ent))

    (if (= (cdr (assoc 0 (entget ent))) "INSERT") 
      (progn 
        (setq centrala (fl:attrib:content:get ent "centrala"))
        (if (null centrala) 
          (setq centrala "")
        )

        (setq plan (fl:attrib:content:get ent "plan"))
        (if (null plan) 
          (setq plan "")
        )

        ;(print (entget ent))
        ;(setq newValue (strcat centrala ";" ))
        (setq newValue (strcat (cdr (assoc 8 (entget ent))) 
                               ";"
                               (cdr (assoc 2 (entget ent)))
                               ";"
                               centrala
                               ";"
                               plan
                               ";"
                       )
        )
        (print newValue)
      )
    )
  )
)

(defun c:hatch_sel (/ obj selset setlen thisobj entname) 
  (princ)
  (princ)

  (princ "\nSelect objects to hatch:")
  (setq selset (ssget))

  (if selset 
    (progn 
      (setq thisobj 0)
      (setq setlen (sslength selset))
      (princ "\nRunning while loop...")
      (while (< thisobj setlen) 
        (setq entname (ssname selset thisobj))
        (command "-bhatch" "solid" entname) ; <--- HATCH HERE
        (setq thisobj (+ thisobj 1))
      ) ; end while
    ) ; end progn
    (princ "\nNo objects selected.")
  ) ; end if

  (princ)
) ; end func
(defun c:HatchRecreatePolylineBoudary (/ s i e l f) 

  (if (setq s (ssget "_:L" '((0 . "HATCH")))) 
    (repeat (setq i (sslength s)) 
      (setq e (ssname s (setq i (1- i))))
      (setq l (entlast))
      (command "_.HATCHEDIT" e "_B" "_P" "_N")
      (if 
        (and (setq f (entnext l)) 
             (= "SPLINE" (cdr (assoc 0 (entget f))))
        )
        (command "_.PEDIT" f 1 "")
      )
      (setq f (entlast))
      (command "_.BHATCH" "_P" "_S" "_S" f "" "")
      (setpropertyvalue (entlast) "LayerId" (getpropertyvalue e "LayerId"))
      (setpropertyvalue (entlast) "Color" (getpropertyvalue e "Color"))
      (entdel e)
      (entdel f)
    )
  )
  (princ)
)
(defun c:ropy (layerName / ss i ent, newValue) 
  (setq ss (ssget "_x" (list (cons 8 layerName))))

  (repeat (setq i (sslength ss)) 
    (setq ent (ssname ss (setq i (1- i))))

    (print (cdr (assoc 2 (entget ent))))

    (if (= "ROP" (cdr (assoc 2 (entget ent)))) 
      (progn 
        (setq coor (cdr (assoc 10 (entget ent))))
        (command "_circle" coor "30000")
        (setq f (entlast))
        (command "_.BHATCH" "_P" "_S" "_S" f "" "")
      )
    )
  )
)

(defun fl:get:date (/ cdate ye mo da) 
  (setq cdate (rtos (getvar "CDATE") 2 6)
        ye    (substr cdate 3 2)
        mo    (substr cdate 5 2)
        da    (substr cdate 7 2)
  )

  (if (= (strlen mo) 1) (setq mo (strcat mo "0")))
  (if (= (strlen da) 1) (setq da (strcat da "0")))

  (strcat ye "-" mo "-" da)
)

(defun fl:get:time (/ cdate hr mi se) 
  (setq cdate (rtos (getvar "CDATE") 2 6)
        hr    (substr cdate 10 2)
        mi    (substr cdate 12 2)
        se    (substr cdate 14 2)
  )

  (if (= (strlen hr) 0) (setq hr "00"))
  (if (= (strlen hr) 1) (setq hr (strcat hr "0")))

  (if (= (strlen mi) 0) (setq mi "00"))
  (if (= (strlen mi) 1) (setq mi (strcat mi "0")))

  (if (= (strlen se) 0) (setq se "00"))
  (if (= (strlen se) 1) (setq se (strcat se "0")))

  (strcat hr "." mi "." se)
)

(defun c:status_to_file (layersList) 
  (setq openFileName (strcat 
                       "c:\\__E\\"
                       "Raport - "
                       "("
                       (getvar "dwgname")
                       ")"
                       " "
                       "["
                       (fl:get:date)
                       " "
                       (fl:get:time)
                       "]"
                       ".txt"
                     )
  )

  (setq ss (fl:ss:layer:list layersList))

  (if (setq des (open openFileName "w")) 
    (progn 
      (repeat (setq i (sslength ss)) 
        (setq ent (ssname ss (setq i (1- i))))

        (if (= (cdr (assoc 0 (entget ent))) "INSERT") 
          (progn 
            (setq centrala (fl:attrib:content:get ent "centrala"))
            (if (null centrala) 
              (setq centrala "")
            )

            (setq plan (fl:attrib:content:get ent "plan"))
            (if (null plan) 
              (setq plan "")
            )

            (setq newValue (strcat (cdr (assoc 8 (entget ent))) 
                                   ";"
                                   (cdr (assoc 2 (entget ent)))
                                   ";"
                                   centrala
                                   ";"
                                   plan
                                   ";"
                           )
            )
            (print newValue)
            (write-line newValue des)
          )
        )
      )
      (close des)
    )
  )
)

(defun c:blokowy (layersList) 

  (setq layerName "___BLOKOWY___")

  (fl:layout:new layerName)
  (fl:layout:setActive layerName)

  ; usuniecie rzutni z layoutu
  (entdel (ssname (ssget "_X" '((0 . "VIEWPORT") (410 . "___BLOKOWY___"))) 0))

  (setq ss (fl:ss:layer:list layersList))

  (repeat (setq i (sslength ss)) 
    (setq ent (ssname ss (setq i (1- i))))

    (if (= (cdr (assoc 0 (entget ent))) "INSERT") 
      (progn 
        (setq centrala (fl:attrib:content:get ent "centrala"))
        (if (null centrala) 
          (setq centrala "0:0:0")
        )

        (setq plan (fl:attrib:content:get ent "plan"))
        (if (null plan) 
          (setq plan "")
        )

        (setq values (fl:string2list centrala ":"))
        (setq elementName (cdr (assoc 2 (entget ent))))

        (print (length values))

        (setq elementPanel (atoi (nth 0 values)))
        (setq elementLoop (atoi (nth 1 values)))
        (setq elementDevice (atoi (nth 2 values)))

        (print elementPanel)
        (fl:duw:insert 
          elementName
          elementPanel
          elementLoop
          elementDevice
          (itoa elementDevice)
          ""
        )
      )
    )
  )
)
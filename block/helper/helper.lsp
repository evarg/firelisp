; Funcja pobiera wszystkie bloki z rysunku i zastepuje je
; innymi w zaleznosci od warunku, dodatkowo kopiuje atrybut
; ze znalezionego bloku do nowego

(defun HelperKopiujBloki () 
  (setq ssWszystkieBloki (ssget "_X" '((0 . "INSERT"))))
  (setq liczbaBlokow (sslength ssWszystkieBloki))
  (print (strcat "Wczytano blokow:" (itoa liczbaBlokow)))

  (setq plik (open "d:\\lista.lsp.txt" "w"))
  (setq i 0)
  (repeat liczbaBlokow 
    (progn 
      (setq blok (ssname ssWszystkieBloki i))

      (setq nazwaBloku (fl:block:name:get blok))
      (setq pozycjaBloku (fl:block:position:get blok))
      (setq numerElementu (fl:attrib:content:get blok "NR_ELEMENTU"))

      (if (= numerElementu NIL) 
        (setq numerElementu "BRAK")
      )

      (setq pozX (car pozycjaBloku))
      (setq pozY (+ (car (cdr pozycjaBloku)) 225.7))
      (setq position (list pozX pozY))

      (setq nowyAtrybut "PLAN")

      (if (= nazwaBloku "Czujka_Optyczna") 
        (progn 
          (fl:block:insert "BOSCH" "BOSCH_DO" position 1.14 0)
          (fl:attrib:content:set (entlast) nowyAtrybut numerElementu)
        )
      )

      (if (= nazwaBloku "CZUJKA_OPTYCZNA_1") 
        (progn 
          (fl:block:insert "BOSCH" "BOSCH_FNS" position 1.14 0)
          (fl:attrib:content:set (entlast) nowyAtrybut numerElementu)
        )
      )

      (if (= nazwaBloku "Reczny_Ostrzegacz_Pozarowy") 
        (progn 
          (fl:block:insert "BOSCH" "BOSCH_DM" position 1.14 0)
          (fl:attrib:content:set (entlast) nowyAtrybut numerElementu)
        )
      )

      (if (= nazwaBloku "CZUJKA_OPTYCZNA_WZ") 
        (progn 
          (fl:block:insert "BOSCH" "BOSCH_DO" position 1.14 0)
          (fl:attrib:content:set (entlast) nowyAtrybut numerElementu)
          (setq position_wz (list (- pozX 228) (+ 228 pozY)))
          (fl:block:insert "SSP" "WZ" position_wz 1.14 0)
        )
      )


      (setq i (+ i 1))
    )
  )
  (close plik)
)


(defun PobierzBloki () 
;  (setq ssWszystkieBloki (ssget "_X" '((0 . "INSERT"))))
  (setq ssWszystkieBloki (ssget))
  (setq liczbaBlokow (sslength ssWszystkieBloki))
  (print (strcat "Wczytano blokow:" (itoa liczbaBlokow)))

  (setq plik (open "d:\\lista.lsp.txt" "w"))
  (setq i 0)
  (repeat liczbaBlokow 
    (progn 
      (setq blok (ssname ssWszystkieBloki i))

      (setq nazwaBloku (fl:block:name:get blok))
      (setq pozycjaBloku (fl:block:position:get blok))


      
      (print (strcat (itoa i) ";" nazwaBloku))
      
(print (entget blok))

      (write-line (strcat (itoa i) ";" nazwaBloku) plik)
       
      (setq i (+ i 1))
    )
  )
  (close plik)
)


(defun HelperAtrybutOn (nazwaAtrybutu) 
  (setq ssWszystkieBloki (ssget "_X" '((0 . "INSERT"))))
  (setq liczbaBlokow (sslength ssWszystkieBloki))
  (print (strcat "Wczytano blokow:" (itoa liczbaBlokow)))

  (setq i 0)
  (repeat liczbaBlokow 
    (progn 
      (setq blok (ssname ssWszystkieBloki i))

      (fl:attrib:on blok nazwaAtrybutu)

      (setq i (+ i 1))
    )
  )
)

(defun LM:rand (/ a c m) 
  (setq m   4294967296.0
        a   1664525.0
        c   1013904223.0
        $xn (rem (+ c (* a (cond ($xn) ((getvar 'date))))) m)
  )
  (/ $xn m)
)

(defun HaloMarian () 
  (setq ssWszystkieBloki (ssget "_X" '((0 . "INSERT"))))
  (setq liczbaBlokow (sslength ssWszystkieBloki))

  (repeat 1 
    (progn 
      (setq i 0)
      (repeat liczbaBlokow 
        (progn 
          (setq enx (entget (ssname ssWszystkieBloki i)))
          (setq start 0)
          (repeat 10 
            (progn 
              (setq kat (* (LM:rand) 6.28))
              (print kat)
              (sleep 5)
              (setq start (+ start 1))
              (setq entityDXFpopr (subst (cons 50 kat) (assoc 50 enx) enx))
              (entmod entityDXFpopr)
            )
          )
          (setq i (+ i 1))
        )
      )
    )
  )
)


(defun HaloM2 () 
  (setq ssWszystkieBloki (ssget "_X" '((0 . "INSERT"))))
  (setq liczbaBlokow (sslength ssWszystkieBloki))

  (repeat 30 
    (progn 
      (setq i 0)
      (repeat liczbaBlokow 
        (progn 
          (setq enx (entget (ssname ssWszystkieBloki i)))
          (setq start 0)
          (repeat 1 
            (progn 
              (setq kat (* (LM:rand) 6.28))
              (setq start (+ start 1))
              (setq entityDXFpopr (subst (cons 50 kat) (assoc 50 enx) enx))
              (entmod entityDXFpopr)
            )
          )
          (setq i (+ i 1))
        )
      )
    )
    (sleep 5)
  )
)

(defun pilka () 
  (fl:block:insert "BOSCH" "BOSCH_DO" '(0 0) 1 0)
  (setq pilka (entlast))
  (setq pozycjaNowa (list 100 100))

  (setq x 0)
  (setq y 0)

  (repeat 100 
    (progn 
      (command "_move" pilka "" '(0 0) pozycjaNowa)
      setq
    )
  )
)

(defun et () 
  (setq end NIL)
  (setq en (entnext))

  (while en 
    (progn 
      (print "=======================================")
      (print en)
      (print 
        (cdr 
          (assoc 0 (entget en))
        )
      )
      ;(print (entget en))
      (setq en (entnext en))
    )
  )
)

(defun ett (entityName attribName paramNumber value / end) 
  (setq end NIL)

  (while entityName 
    (progn 
      (setq entityAttribName (cdr (assoc 2 (entget en))))
      (if (= entityAttribName attribName)
        (progn
        
        )
      )
      (if (= "SEQEND" (cdr (assoc 0 (entget entityName)))) 
        (setq end NIL)
        (setq entityName (entnext entityName))
      )
    )
  )
)
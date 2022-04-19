(defun fl:app:dlg_numberingSetup (/ returnDialog zero step matrix actualValue dclID) 
  (setq returnDialog 999)
  (setq zero globalNumberingZero)
  (setq step globalNumberingStep)
  (setq matrix globalNumberingMatrix)
  (setq actualValue globalNumberingNextValue)

  (fl:log:header "KONFIGURACJA NUMEROWANIA")

  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\numbering\\dialogs\\setup.dcl")))

  (start_dialog)

  (while (> returnDialog 1) 
    (new_dialog "DCLnumberingSetup" dclID)

    (action_tile "cancel" "(done_dialog 1)")

    (action_tile "bSave" 
                 "
        (setq zero (get_tile \"eZero\"))
        (setq step (get_tile \"eStep\"))
        (setq matrix (get_tile \"eMatrix\"))
        (done_dialog 101)
                   "
    )

    (action_tile "bStart" 
                 "
        (setq zero (get_tile \"eZero\"))
        (setq step (get_tile \"eStep\"))
        (setq matrix (get_tile \"eMatrix\"))
        (done_dialog 102)
                   "
    )

    (action_tile "bPlus" 
                 "
        (setq actualValue (get_tile \"eActualValue\"))
        (done_dialog 103)
                   "
    )

    (action_tile "bMinus" 
                 "
        (setq actualValue (get_tile \"eActualValue\"))
        (done_dialog 104)
                   "
    )

    (set_tile "eZero" zero)
    (set_tile "eStep" step)
    (set_tile "eMatrix" matrix)
    (set_tile "eActualValue" actualValue)

    (setq returnDialog (start_dialog))

    (if (= 1 returnDialog) 
      (fl:log:info "Anulowano")
    )

    (if (= 101 returnDialog) 
      (cond 
        ((= zero "") (fl:log:error "Nie podano liczby zer wiodacych"))
        ((null (numberp (read zero))) (fl:log:error "Nieprawidlowa wartosc liczby zer wiodacych"))
        ((< (atoi zero) 0) (fl:log:error "Liczba zer wiodacych nie moze byc mniejsza od zera"))

        ((= step "") (fl:log:error "Nie podano kroku"))
        ((null (numberp (read step))) (fl:log:error "Nieprawidlowa wartosc krok"))

        ((= matrix "") (fl:log:error "Matryca nie moze byc pusta"))

        (t
         (progn 
           (setq globalNumberingZero (atoi zero))
           (setq globalNumberingStep (atoi step))
           (setq globalNumberingMatrix matrix)
           (fl:log:info "Pomyslnie zapisano")
         )
        )
      )
    )


    (if (= 102 returnDialog) 
      (cond 
        ((= zero "") (fl:log:error "Nie podano liczby zer wiodacych"))
        ((null (numberp (read zero))) (fl:log:error "Nieprawidlowa wartosc liczby zer wiodacych"))
        ((< (atoi zero) 0) (fl:log:error "Liczba zer wiodacych nie moze byc mniejsza od zera"))

        ((= step "") (fl:log:error "Nie podano kroku"))
        ((null (numberp (read step))) (fl:log:error "Nieprawidlowa wartosc krok"))

        ((= matrix "") (fl:log:error "Matryca nie moze byc pusta"))

        (t
         (progn 
           (fl:log:info "Uruchomienie numerowania")
           (fl:numbering)
           (setq returnDialog 1)
         )
        )
      )
    )

    (if (= 103 returnDialog) 
      (cond 
        ((= actualValue "") (fl:log:error "Nie podano wartosci aktualnej"))
        ((null (numberp (read actualValue))) (fl:log:error "Nieprawidlowa wartosc aktualna"))
        ((< (atoi actualValue) 0) (fl:log:error "Licznik nie moze byc ujemny"))

        (t
         (progn 
           (setq globalNumberingNextValue (+ (atoi actualValue) 1))
           (setq actualValue (itoa globalNumberingNextValue))
         )
        )
      )
    )

    (if (= 104 returnDialog) 
      (cond 
        ((= actualValue "") (fl:log:error "Nie podano wartosci aktualnej"))
        ((null (numberp (read actualValue))) (fl:log:error "Nieprawidlowa wartosc aktualna"))
        ((<= (atoi actualValue) 0) (fl:log:error "Licznik nie moze byc ujemny"))

        (t
         (progn 
           (setq globalNumberingNextValue (- (atoi actualValue) 1))
           (setq actualValue (itoa globalNumberingNextValue))
         )
        )
      )
    )
  )
  (unload_dialog dclID)
  (fl:log:footer)
)
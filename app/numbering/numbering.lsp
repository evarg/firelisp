; ========================================================================================================
; | Includes                                                                                            |
; ========================================================================================================

(load (strcat PATH_SCRIPT "app\\numbering\\dialogs.lsp"))


; ========================================================================================================
; | Global variables                                                                                            |
; ========================================================================================================

(setq globalNumberingNextValue 1)
(setq globalNumberingMatrix "1/##")
(setq globalNumberingZero 1)
(setq globalNumberingStep 1)


; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:numbering (/ entityName entity value) 
  (setq entity (car (entsel "* Wybierz blok: ")))
  (print)

  (while entity 
    (setq value (fl:numbering:generate))
    (fl:attrib:content:set entity "centrala" value)

    (setq globalNumberingNextValue (+ globalNumberingNextValue globalNumberingStep))

    (fl:log:info (strcat "Przypisano wartosc: " value ", nastepny indeks: " (itoa globalNumberingNextValue)))
    (setq entity (car (entsel "* Wybierz blok: ")))
    (print)
  )
)

(defun fl:numbering:generate (/ value) 
  (setq value (itoa globalNumberingNextValue))

  (repeat (- globalNumberingZero (strlen value))
    (setq value (strcat "0" value ))
  )

  (strcat (vl-string-subst value "##" globalNumberingMatrix))
)


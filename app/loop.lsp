;
; RAW = panelNumber
;


(defun fl:loop:new (loopName loopNumber panelFID / position panelNumber) 
  (setq panelNumber (fl:panel:number:get (fl:block:searchByFID panelFID)))

  (setq position (list (+ 37 (* (- panelNumber 1) 40)) 
                       (- 167 (* (- loopNumber 1) 5))
                 )
  )

  (fl:block:insert "FIRE" "SYSTEM_POZAROWY_PETLA" position 0.01 0)

  (fl:attrib:content:set (entlast) "CENTRALA" loopName)
  (fl:attrib:content:set (entlast) "FID" (fl:uuid))
  (fl:attrib:content:set (entlast) "OWNER_FID" panelFID)
  (fl:attrib:content:set (entlast) "RAW" (itoa loopNumber))
  (fl:attrib:location:set (entlast) "CENTRALA" "MR")

  ;rysowanie polaczenia
  (setq startPoint (fl:element:calculateOffset 
                     (fl:block:searchByFID panelFID)
                     "DC"
                   )
  )
  (fl:polyline1V startPoint (fl:element:calculateOffset (entlast) "LM"))
)


(defun fl:loop:new:dlg (/ dclID entityName panelName panelFID loopName loopNumber 
                        returnDialog
                       ) 

  (setq panelFID "brak")
  (setq panelName "brak")
  (setq loopName "brak")
  (setq loopNumber "brak")

  (setq returnDialog 2)
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\loopNew.dcl")))

  (while (> returnDialog 1) 
    (progn 
      (new_dialog "DCLloopNew" dclID)

      (set_tile "Text1" "asdasd")

      (set_tile "TpanelFID" panelFID)
      (set_tile "TpanelName" panelName)
      (set_tile "EloopName" loopName)
      (set_tile "EloopNumber" loopNumber)

      (action_tile "BselectPanel" "(done_dialog 2)")
      (action_tile "accept" 
                   "
                   (setq panelFID (get_tile \"TpanelFID\"))
                   (setq panelName (get_tile \"TpanelName\"))
                   (setq loopName (get_tile \"EloopName\"))
                   (setq loopNumber (get_tile \"EloopNumber\"))
                   (done_dialog 1)
        "
      )

      (setq returnDialog (start_dialog))

      ; wcisniety button wyboru fire
      (if (= returnDialog 2) 
        (progn 
          (setq entityName (car (entsel)))
          (if (fl:panel:is entityName) 
            (progn 
              (setq panelName (fl:panel:name:get entityName))
              (setq panelFID (fl:panel:FID:get entityName))
              (setq loopNumber (itoa 
                                 (+ 1 
                                    (length 
                                      (fl:panel:getAllLoops 
                                        (fl:panel:FID:get entityName)
                                      )
                                    )
                                 )
                               )
              )
              (setq loopName (strcat "Petla " loopNumber))
            )
          )
        )
      )

      ; wcisniety klawisz OK
      (if (= returnDialog 1) 
        (progn 
          (fl:loop:new loopName (atoi loopNumber) panelFID)
        )
      )
    )
  )
  (unload_dialog dclID)

  (print returnDialog)
)
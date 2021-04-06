;
; RAW = panelNumber
;


(defun fl:panel:new (panelName panelNumber fireFID / position) 
  (setq position (list (+ 32 (* (- panelNumber 1) 50)) 174))

  (fl:block:insert "FIRE" "SYSTEM_POZAROWY_CENTRALA" position 0.01 0)

  (fl:attrib:content:set (entlast) "CENTRALA" panelName)
  (fl:attrib:content:set (entlast) "FID" (fl:uuid))
  (fl:attrib:content:set (entlast) "OWNER_FID" fireFID)
  (fl:attrib:content:set (entlast) "RAW" (itoa panelNumber))
  (fl:attrib:location:set (entlast) "CENTRALA" "MR")
)


(defun fl:panel:new:dlg (/ dclID entityName panelNumber panelName fireFID fireName 
                          returnDialog
                         ) 

  (setq fireFID "brak")
  (setq fireName "brak")
  (setq panelNumber "brak")
  (setq panelName "brak")

  (setq returnDialog 2)
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\panelNew.dcl")))

  (while (> returnDialog 1) 
    (progn 
      (new_dialog "DCLpanelNew" dclID)

      (set_tile "Text1" "asdasd")

      (set_tile "tFireName" fireName)
      (set_tile "tFireFID" fireFID)
      (set_tile "ePanelNumber" panelNumber)
      (set_tile "ePanelName" panelName)
      ;  (set_tile "ePanelName" (strcat "Centrala " (itoa panelNumber)))

      (action_tile "bSelectFire" "(done_dialog 2)")
      (action_tile "accept" 
                   "
                   (setq fireName (get_tile \"tFireName\"))
                   (setq fireFID (get_tile \"tFireFID\"))
                   (setq panelNumber (get_tile \"ePanelNumber\"))
                   (setq panelName (get_tile \"ePanelName\"))
                   (done_dialog 1)
        "
      )

      (setq returnDialog (start_dialog))

      ; wcisniety button wyboru fire
      (if (= returnDialog 2) 
        (progn 
          (setq entityName (car (entsel)))
          (if (fl:fire:is entityName) 
            (progn 
              (setq fireName (fl:fire:name:get entityName))
              (setq fireFID (fl:fire:FID:get entityName))
              (setq panelNumber (itoa 
                                  (+ 1 
                                     (length 
                                       (fl:fire:getAllPanels 
                                         (fl:fire:FID:get entityName)
                                       )
                                     )
                                  )
                                )
              )
              (setq panelName (strcat "Centrala " panelNumber))
            )
          )
        )
      )

      ; wcisniety klawisz OK
      (if (= returnDialog 1) 
        (progn 
          (fl:panel:new panelName (atoi panelNumber) fireFID)
        )
      )
    )
  )
  (unload_dialog dclID)

  (print returnDialog)
)
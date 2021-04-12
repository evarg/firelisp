;
; RAW = panelNumber
;

(defun fl:panel:name:get (entityName / rv) 
  (setq rv nil)
  (setq rv (fl:attrib:content:get entityName "CENTRALA"))
  rv
)


(defun fl:panel:FID:get (entityName / rv) 
  (setq rv nil)
  (setq rv (fl:attrib:content:get entityName "FID"))
  rv
)


(defun fl:panel:is (entityName / rv) 
  (setq rv nil)
  (if (= (fl:block:name:get entityName) "SYSTEM_POZAROWY_CENTRALA") 
    (progn 
      (setq rv T)
    )
  )
  rv
)

(defun fl:panel:number:get (entityName / rv raw) 
  (setq rv nil)
  (setq raw (fl:attrib:content:get entityName "RAW"))
  (setq rv (atoi (nth 0 (fl:string2list raw ";"))))
  rv
)


(defun fl:panel:getAllLoops (fireFID) 
  (fl:block:searchByOwnerFID fireFID)
)


(defun fl:panel:new (panelName panelNumber fireFID / position) 
  (setq position (list (+ 32 (* (- panelNumber 1) 40)) 174))

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
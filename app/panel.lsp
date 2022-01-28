;
; RAW = panelNumber
;

(defun fl:panel:name:get (entityName / rv) 
  (setq rv nil)
  (setq rv (fl:attrib:content:get entityName "CENTRALA"))
  rv
)


(defun fl:panel:name:set (panelFID value) 
  (fl:attrib:content:set (fl:block:searchByFID panelFID) "CENTRALA" value)
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
  (fl:layout:setActive LAYOUT_FIRE_NAME)
  (fl:layer:setActive LAYOUT_FIRE_NAME)
  
  (setq position (list (+ 32 (* (- panelNumber 1) 40)) 174))

  (fl:block:insert "FIRE" "SYSTEM_POZAROWY_CENTRALA" position 0.01 0)

  (fl:attrib:content:set (entlast) "CENTRALA" panelName)
  (fl:attrib:content:set (entlast) "FID" (fl:uuid))
  (fl:attrib:content:set (entlast) "OWNER_FID" fireFID)
  (fl:attrib:content:set (entlast) "RAW" (itoa panelNumber))
  (fl:attrib:location:set (entlast) "CENTRALA" "MR")
  
  ;rysowanie polaczenia
  (fl:polyline1H (list 20 180) (fl:element:calculateOffset (entlast) "UC"))
)


(defun fl:panel:new:dlg (/ dclID entityName panelNumber panelName fireFID fireName 
                         returnDialog
                        ) 
  (fl:layout:setActive LAYOUT_FIRE_NAME)
  (fl:layer:setActive LAYOUT_FIRE_NAME)

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


(defun fl:panel:change:dlg (/ dclID entityName panelName panelFID loopName loopNumber 
                           returnDialog
                          ) 
  (fl:layout:setActive LAYOUT_FIRE_NAME)
  (fl:layer:setActive LAYOUT_FIRE_NAME)

  (setq returnDialog 999)
  (setq panelName "brak")
  (setq panelNumber "brak")
  (setq panelFID "brak")

  (setq returnDialog 2)
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\panelChange.dcl")))

  (while (> returnDialog 1) 
    (progn 
      (new_dialog "DCLpanelChange" dclID)

      (set_tile "tLoopFID" panelFID)
      (set_tile "ePanelName" panelName)
      (set_tile "ePanelNumber" panelNumber)

      (action_tile "BselectPanel" "(done_dialog 101)")
      (action_tile "accept" 
                   "
                   (setq loopFID (get_tile \"tLoopFID\"))
                   (setq loopName (get_tile \"eLoopName\"))
                   (setq loopNumber (get_tile \"eLoopNumber\"))
                   (setq loopNumberView (get_tile \"eLoopNumberView\"))
                   (done_dialog 1)
        "
      )

      (setq returnDialog (start_dialog))

      (if (= 101 returnDialog) 
        (progn 
          (setq entityName (car (entsel)))
          (if (fl:panel:is entityName) 
            (progn 
              (setq panelFID (fl:block:FID:get entityName))
              (setq panelName (fl:panel:name:get entityName))
              (setq panelNumber (fl:panel:number:get entityName))
            )
          )
        )
      )

      ; wcisniety klawisz OK
      (if (= returnDialog 1) 
        (progn 
          (fl:panel:name:set loopFID panelName)
          (fl:panel:number:set loopFID panelNumber)
        )
      )
    )
  )
  (unload_dialog dclID)

  (print returnDialog)
)
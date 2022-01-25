(defun fl:loop:is (entityName / rv) 
  (setq rv nil)
  (if (= (fl:block:name:get entityName) "SYSTEM_POZAROWY_PETLA") 
    (setq rv T)
  )
  rv
)


(defun fl:loop:nameView:calculate (loopNumber loopName loopNumberView) 
  (setq loopNameView (strcat (itoa loopNumber) 
                             " - "
                             loopName
                             " ("
                             loopNumberView
                             ")"
                     )
  )
  loopNameView
)


(defun fl:loop:name:get (loopFID) 
  (fl:attrib:content:get (fl:block:searchByFID loopFID) "NAZWA")
)


(defun fl:loop:name:set (loopFID value) 
  (fl:attrib:content:set (fl:block:searchByFID loopFID) "NAZWA" value)
)


(defun fl:loop:nameView:get (loopFID) 
  (fl:attrib:content:get (fl:block:searchByFID loopFID) "NAZWA_WYSWIETLANA")
)


(defun fl:loop:nameView:set (loopFID value) 
  (fl:attrib:content:set (fl:block:searchByFID loopFID) "NAZWA_WYSWIETLANA" value)
)


(defun fl:loop:number:get (loopFID) 
  (fl:attrib:content:get (fl:block:searchByFID loopFID) "NUMER_KOLEJNY")
)


(defun fl:loop:number:set (loopFID value) 
  (fl:attrib:content:set (fl:block:searchByFID loopFID) "NUMER_KOLEJNY" value)
)


(defun fl:loop:numberView:get (loopFID) 
  (fl:attrib:content:get (fl:block:searchByFID loopFID) "NUMER_WYSWIETLANY")
)


(defun fl:loop:numberView:set (loopFID value) 
  (fl:attrib:content:set (fl:block:searchByFID loopFID) "NUMER_WYSWIETLANY" value)
)


(defun fl:loop:new (loopName loopNumber loopNumberView panelFID / position 
                    panelNumber
                   ) 
  (fl:layout:setActive LAYOUT_FIRE_NAME)

  (setq panelNumber (fl:panel:number:get (fl:block:searchByFID panelFID)))

  (setq loopNameView (fl:loop:nameView:calculate 
                       loopNumber
                       loopName
                       loopNumberView
                     )
  )

  (setq position (list (+ 37 (* (- panelNumber 1) 40)) 
                       (- 167 (* (- loopNumber 1) 5))
                 )
  )

  (fl:block:insert "FIRE" "SYSTEM_POZAROWY_PETLA" position 0.01 0)

  (fl:attrib:content:set (entlast) "NAZWA" loopName)
  (fl:attrib:content:set (entlast) "FID" (fl:uuid))
  (fl:attrib:content:set (entlast) "OWNER_FID" panelFID)
  (fl:attrib:content:set (entlast) "NUMER_KOLEJNY" (itoa loopNumber))
  (fl:attrib:content:set (entlast) "NUMER_WYSWIETLANY" loopNumberView)
  (fl:attrib:content:set (entlast) "NAZWA_WYSWIETLANA" loopNameView)

  (fl:attrib:location:set (entlast) "NAZWA_WYSWIETLANA" "MR")

  ;rysowanie polaczenia
  (setq startPoint (fl:element:calculateOffset 
                     (fl:block:searchByFID panelFID)
                     "DC"
                   )
  )
  (fl:polyline1V startPoint (fl:element:calculateOffset (entlast) "LM"))

  ;utworzenie warstw dla petli
  (setq panelName "")
  (if CONF_PANEL_ADD 
    (setq panelName (strcat "_" (itoa panelNumber)))
  )

  (fl:layer:new (strcat "__SAP" panelName "_" loopNumberView "_DETEKCJA"))
  (fl:layer:new (strcat "__SAP" panelName "_" loopNumberView "_PETLA"))
  (fl:layer:new (strcat "__SAP" panelName "_" loopNumberView "_STEROWANIE"))
)


(defun fl:loop:new:dlg (/ dclID entityName panelName panelFID loopName loopNumber 
                        returnDialog
                       ) 
  (fl:layout:setActive LAYOUT_FIRE_NAME)
  (fl:layer:setActive LAYOUT_FIRE_NAME)

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
      (set_tile "eLoopName" loopName)
      (set_tile "eLoopNumber" loopNumber)
      (set_tile "eLoopNumberView" loopNumber)

      (action_tile "BselectPanel" "(done_dialog 2)")
      (action_tile "accept" 
                   "
                   (setq panelFID (get_tile \"TpanelFID\"))
                   (setq panelName (get_tile \"TpanelName\"))
                   (setq loopName (get_tile \"eLoopName\"))
                   (setq loopNumber (get_tile \"eLoopNumber\"))
                   (setq loopNumberView (get_tile \"eLoopNumberView\"))
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
          (fl:loop:new loopName (atoi loopNumber) loopNumberView panelFID)
        )
      )
    )
  )
  (unload_dialog dclID)

  (print returnDialog)
)

(defun fl:loop:change:dlg (/ dclID entityName panelName panelFID loopName loopNumber 
                           returnDialog
                          ) 
  (fl:layout:setActive LAYOUT_FIRE_NAME)
  (fl:layer:setActive LAYOUT_FIRE_NAME)

  (setq loopName "brak")
  (setq loopNumber "brak")
  (setq loopNumberView "brak")
  (setq loopFID "brak")

  (setq returnDialog 2)
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\loopChange.dcl")))

  (while (> returnDialog 1) 
    (progn 
      (new_dialog "DCLloopChange" dclID)

      (set_tile "tLoopFID" loopFID)
      (set_tile "eLoopName" loopName)
      (set_tile "eLoopNumber" loopNumber)
      (set_tile "eLoopNumberView" loopNumberView)

      (action_tile "BselectLoop" "(done_dialog 2)")
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

      ; wcisniety button wyboru fire
      (if (= returnDialog 2) 
        (progn 
          (setq entityName (car (entsel)))
          (if (fl:loop:is entityName) 
            (progn 
              (setq loopFID (fl:block:FID:get entityName))
              (setq loopName (fl:loop:name:get loopFID))
              (setq loopNumber (fl:loop:number:get loopFID))
              (setq loopNumberView (fl:loop:numberView:get loopFID))
            )
          )
        )
      )

      ; wcisniety klawisz OK
      (if (= returnDialog 1) 
        (progn 
          (fl:loop:name:set loopFID loopName)
          (fl:loop:numberView:set loopFID loopNumberView)
          (fl:loop:nameView:set loopFID
            (fl:loop:nameView:calculate 
              (atoi loopNumber)
              loopName
              loopNumberView
            )
          )
        )
      )
    )
  )
  (unload_dialog dclID)

  (print returnDialog)
)



(defun fl:fire:dlg_options (/ dclID) 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\fireOptions.dcl")))
  (new_dialog "DCLfireOptions" dclID)

  (set_tile "tPanelNumber" "0")
  (if CONF_PANEL_ADD 
    (set_tile "tPanelNumber" "1")
  )

  (action_tile "accept" 
               "
                (setq CONF_PANEL_ADD nil) 
                (if (= (get_tile \"tPanelNumber\") \"1\" )
                  (setq CONF_PANEL_ADD T)
                )
              
               (done_dialog 0)
			"
  )

  (action_tile "bDefaultPLAN" 
               "
               (set_tile \"eAttribName\" \"PLAN\")
			"
  )

  (action_tile "bDefaultCENTRALA" 
               "
               (set_tile \"eAttribName\" \"CENTRALA\")
			"
  )

  (action_tile "bDefaultRAW" 
               "
               (set_tile \"eAttribName\" \"RAW\")
			"
  )

  (start_dialog)
  (unload_dialog dclID)
)
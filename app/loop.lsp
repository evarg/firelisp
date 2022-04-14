; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:loop:is (entityName / rv) 
  (setq rv nil)
  (if (= (fl:block:name:get entityName) "SYSTEM_POZAROWY_PETLA") 
    (setq rv T)
  )
  rv
)

; --------------------------------------------------------------------------------------------------------

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

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:layer:calculate (panelName loopNumberView) 
  (setq panelName "")
  (if CONF_PANEL_ADD 
    (setq panelName (strcat "_" (itoa panelNumber)))
  )
  (setq layerName (strcat "__SAP" panelName "_" loopNumberView ""))
  layerName
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:layer:get (loopFID) 
  (fl:attrib:content:get (fl:block:searchByFID loopFID) "WARSTWA")
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:layer:set (loopFID value) 
  (fl:attrib:content:set (fl:block:searchByFID loopFID) "WARSTWA" value)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:name:get (loopFID) 
  (fl:attrib:content:get (fl:block:searchByFID loopFID) "NAZWA")
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:name:set (loopFID value) 
  (fl:attrib:content:set (fl:block:searchByFID loopFID) "NAZWA" value)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:nameView:get (loopFID) 
  (fl:attrib:content:get (fl:block:searchByFID loopFID) "NAZWA_WYSWIETLANA")
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:nameView:set (loopFID value) 
  (fl:attrib:content:set (fl:block:searchByFID loopFID) "NAZWA_WYSWIETLANA" value)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:number:get (loopFID) 
  (fl:attrib:content:get (fl:block:searchByFID loopFID) "NUMER_KOLEJNY")
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:number:set (loopFID value) 
  (fl:attrib:content:set (fl:block:searchByFID loopFID) "NUMER_KOLEJNY" value)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:numberView:get (loopFID) 
  (fl:attrib:content:get (fl:block:searchByFID loopFID) "NUMER_WYSWIETLANY")
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:numberView:set (loopFID value) 
  (fl:attrib:content:set (fl:block:searchByFID loopFID) "NUMER_WYSWIETLANY" value)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:new (loopName loopNumber loopNumberView panelFID layerName / position 
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
  (fl:attrib:content:set (entlast) "WARSTWA" layerName)

  (fl:attrib:location:set (entlast) "NAZWA_WYSWIETLANA" "MR")

  ;rysowanie polaczenia
  (setq startPoint (fl:element:calculateOffset 
                     (fl:block:searchByFID panelFID)
                     "DC"
                   )
  )
  (fl:polyline1V startPoint (fl:element:calculateOffset (entlast) "LM"))

  (fl:loop:layers:create layerName)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:layers:create (layerName) 
  ;utworzenie warstw dla petli
  (fl:layer:new (strcat layerName "_DETEKCJA"))
  (fl:layer:new (strcat layerName "_PETLA"))
  (fl:layer:new (strcat layerName "_STEROWANIE"))

  (fl:layer:color:set (strcat layerName "_DETEKCJA") 1)
  (fl:layer:color:set (strcat layerName "_PETLA") 3)
  (fl:layer:color:set (strcat layerName "_STEROWANIE") 5)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:loop:layers:modify (oldLoopNumberView panelName loopNumberView) 
  ;utworzenie warstw dla petli
  (setq panelName "")
  (if CONF_PANEL_ADD 
    (setq panelName (strcat "_" (itoa panelNumber)))
  )

  (fl:layer:name:set (strcat "__SAP" panelName "_" loopNumberView "_DETEKCJA"))
  (fl:layer:name:set (strcat "__SAP" panelName "_" loopNumberView "_PETLA"))
  (fl:layer:name:set (strcat "__SAP" panelName "_" loopNumberView "_STEROWANIE"))
)

; --------------------------------------------------------------------------------------------------------

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
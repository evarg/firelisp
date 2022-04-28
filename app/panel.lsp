; ========================================================================================================
; | Includes                                                                                            |
; ========================================================================================================

(load (strcat PATH_SCRIPT "app\\panel\\getters.lsp"))
(load (strcat PATH_SCRIPT "app\\panel\\setters.lsp"))
(load (strcat PATH_SCRIPT "app\\panel\\dialogs.lsp"))

; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:panel:new (panelName panelNumber panelNumberView fireFID / position 
                     entityName
                    ) 
  (fl:layout:setActive LAYOUT_FIRE_NAME)
  (fl:layer:setActive LAYOUT_FIRE_NAME)

  (setq position (list (+ 32 (* (- panelNumber 1) 40)) 174))

  (fl:block:insert "FIRE" CONF_BLOCK_PANEL position 0.01 0)

  (setq entityName (entlast))

  (fl:panel:FID:set entityName  (fl:uuid))
  (fl:panel:ownerFID:set entityName fireFID)
  (fl:panel:name:set entityName panelName)
  (fl:panel:nameView:set 
    entityName
    (fl:panel:nameView:calculate panelNumber panelName panelNumberView)
  )
  (fl:panel:number:set entityName (itoa panelNumber))
  (fl:panel:numberView:set entityName panelNumberView)
  (fl:attrib:location:set entityName "NAZWA_WYSWIETLANA" "MR")

  ;rysowanie polaczenia
  (fl:polyline1H (list 20 180) (fl:element:calculateOffset entityName "UC"))
)

; --------------------------------------------------------------------------------------------------------

(defun fl:panel:nameView:calculate (panelNumber panelName panelNumberView / panelNameView) 
  (setq panelNameView (strcat (itoa panelNumber) 
                             " - "
                             panelName
                             " ("
                             panelNumberView
                             ")"
                     )
  )
  panelNameView
)


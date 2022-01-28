(load (strcat PATH_SCRIPT "app\\panel\\getters.lsp"))
(load (strcat PATH_SCRIPT "app\\panel\\setters.lsp"))
(load (strcat PATH_SCRIPT "app\\panel\\dialogs.lsp"))
(load (strcat PATH_SCRIPT "app\\panel\\models.lsp"))


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



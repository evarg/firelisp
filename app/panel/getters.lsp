(defun fl:panel:name:get (entityName / rv) 
  (setq rv (fl:attrib:content:get entityName "NAZWA"))
  rv
)


(defun fl:panel:nameView:get (entityName / rv) 
  (setq rv (fl:attrib:content:get entityName "NAZWA_WYSWIETLANA"))
  rv
)


(defun fl:panel:Number:get (entityName / rv) 
  (setq rv (fl:attrib:content:get entityName "NUMER_KOLEJNY"))
  rv
)


(defun fl:panel:NumberView:get (entityName / rv) 
  (setq rv (fl:attrib:content:get entityName "NUMER_WYSWIETLANY"))
  rv
)


(defun fl:panel:name:getByFID (panelFID / rv) 
  (setq rv (fl:attrib:content:get (fl:block:searchByFID panelFID) "NAZWA"))
  rv
)


(defun fl:panel:nameView:getByFID (panelFID / rv) 
  (setq rv (fl:attrib:content:get (fl:block:searchByFID panelFID) "NAZWA_WYSWIETLANA"))
  rv
)


(defun fl:panel:number:getByFID (panelFID / rv) 
  (setq rv (fl:attrib:content:get (fl:block:searchByFID panelFID) "NAZWA"))
  rv
)


(defun fl:panel:numberView:getByFID (panelFID / rv) 
  (setq rv (fl:attrib:content:get (fl:block:searchByFID panelFID) "NUMER_WYSWIETLANY"))
  rv
)


(defun fl:panel:FID:get (entityName / rv) 
  (setq rv (fl:attrib:content:get entityName "FID"))
  rv
)


(defun fl:panel:is (entityName / rv) 
  (if (= (fl:block:name:get entityName) "SYSTEM_POZAROWY_CENTRALA") 
    (progn 
      (setq rv T)
    )
  )
  rv
)

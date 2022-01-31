(defun fl:panel:name:set (entityName value) 
  (fl:attrib:content:set entityName "NAZWA" value)
)


(defun fl:panel:nameView:set (entityName value) 
  (fl:attrib:content:set 
    entityName
    "NAZWA_WYSWIETLANA"
    (fl:panel:nameView:calculate panelNumber panelName panelNumberView)
  )
)


(defun fl:panel:FID:set (entityName value) 
  (fl:attrib:content:set entityName "FID" (fl:uuid))
)


(defun fl:panel:ownerFID:set (entityName value) 
  (fl:attrib:content:set entityName "OWNER_FID" value)
)


(defun fl:panel:number:set (entityName value) 
  (fl:attrib:content:set entityName "NUMER_KOLEJNY" value)
)


(defun fl:panel:numberView:set (entityName value) 
  (fl:attrib:content:set entityName "NUMER_WYSWIETLANY" value)
)


(defun fl:panel:name:setByFID (FID value) 
  (fl:attrib:content:set (fl:block:searchByFID FID) "NAZWA" value)
)


(defun fl:panel:nameView:setByFID (FID value) 
  (fl:attrib:content:set 
    (fl:block:searchByFID FID)
    "NAZWA_WYSWIETLANA"
    (fl:panel:nameView:calculate panelNumber panelName panelNumberView)
  )
)


(defun fl:panel:FID:setByFID (FID value) 
  (fl:attrib:content:set (fl:block:searchByFID FID) "FID" (fl:uuid))
)


(defun fl:panel:ownerFID:setByFID (FID value) 
  (fl:attrib:content:set (fl:block:searchByFID FID) "OWNER_FID" value)
)


(defun fl:panel:number:setByFID (FID value) 
  (fl:attrib:content:set (fl:block:searchByFID FID) "NUMER_KOLEJNY" value)
)


(defun fl:panel:numberView:setByFID (FID value) 
  (fl:attrib:content:set (fl:block:searchByFID FID) "NUMER_WYSWIETLANY" value)
)
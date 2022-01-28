(defun fl:panel:name:setByFID (panelFID value) 
  (fl:attrib:content:set (fl:block:searchByFID panelFID) "CENTRALA" value)
)

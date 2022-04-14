; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:fire:name:get (entityName / rv) 
  (setq rv nil)
  (setq rv (fl:attrib:content:get entityName "CENTRALA"))
  rv
)

; --------------------------------------------------------------------------------------------------------

(defun fl:fire:FID:get (entityName / rv) 
  (setq rv nil)
  (setq rv (fl:attrib:content:get entityName "FID"))
  rv
)

; --------------------------------------------------------------------------------------------------------

(defun fl:fire:is (entityName / rv) 
  (setq rv nil)
  (if (= (fl:block:name:get entityName) "SYSTEM_POZAROWY") 
    (progn 
      (setq rv T)
    )
  )
  rv
)

; --------------------------------------------------------------------------------------------------------

(defun fl:fire:getAllPanels (fireFID) 
  (fl:block:searchByOwnerFID fireFID)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:fire:getAllLoops (panelFID) 
  (fl:block:searchByOwnerFID panelFID)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:fire:new (systemName listObjectS listObjectA / fileName osval position) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (setq fileName (strcat PATH_SYSTEM "\\SYSTEM_POZAROWY.dwg"))

  (fl:layout:new LAYOUT_FIRE_NAME)
  (fl:layout:setActive LAYOUT_FIRE_NAME)

  ; usuniecie rzutni z layoutu
  (entdel (ssname (ssget "_X" '((0 . "VIEWPORT") (410 . "SP"))) 0))

  (setq position (list 18 180))

  (fl:block:insert "FIRE" "SYSTEM_POZAROWY" position 0.01 0)

  ;(command "_insert" fileName position 0.01 0.01 0)
  ;(command "._move" (entlast) "" "P" '(18 180))

  (fl:attrib:content:set (entlast) "LISTA_ELEMENTOW" listObjectS)
  (fl:attrib:content:set (entlast) "LISTA_ELEMENTOW_PETLOWYCH" listObjectA)
  (fl:attrib:content:set (entlast) "NAZWA" systemName)
  (fl:attrib:content:set (entlast) "CENTRALA" systemName)
  (fl:attrib:content:set (entlast) "FID" (fl:uuid))
  (fl:attrib:location:set (entlast) "CENTRALA" "UC")
  (setvar "OSMODE" osval)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:fire:dlg_new (/ dclID) 
  (setq dclID (load_dialog 
                (strcat PATH_SCRIPT "app\\views\\fireNew.dcl")
              )
  )

  (new_dialog "DCLfireNew" dclID)

  (action_tile "bSave" 
               "
                (setq FIRE_LIST_OBJECT_S (get_tile \"eListObjectS\"))
                (setq FIRE_LIST_OBJECT_A (get_tile \"eListObjectA\"))
                (setq FIRE_NAME (get_tile \"eSystemName\"))
                (done_dialog 2)
                (fl:fire:new FIRE_NAME FIRE_LIST_OBJECT_S FIRE_LIST_OBJECT_A)
               "
  )

  (action_tile "bCancel" 
               "
				(done_dialog 1)
			"
  )

  (action_tile "bSystemAWEX" 
               "
               (set_tile \"eListObjectS\" (fl:list2string LIST_OBJECT_S_AWEX \";\"))
               (set_tile \"eListObjectA\" (fl:list2string LIST_OBJECT_A_AWEX \";\"))
               (set_tile \"eSystemName\" \"AWEX\")
 			"
  )

  (action_tile "bSystemBOSCH" 
               "
               (set_tile \"eListObjectS\" (fl:list2string LIST_OBJECT_S_BOSCH \";\"))
               (set_tile \"eListObjectA\" (fl:list2string LIST_OBJECT_A_BOSCH \";\"))
               (set_tile \"eSystemName\" \"BOSCH\")
 			"
  )

  (action_tile "bSystemESSER" 
               "
               (set_tile \"eListObjectS\" (fl:list2string LIST_OBJECT_S_ESSER \";\"))
               (set_tile \"eListObjectA\" (fl:list2string LIST_OBJECT_A_ESSER \";\"))
               (set_tile \"eSystemName\" \"ESSER\")
 			"
  )
  (action_tile "bSystemEST3" 
               "
               (set_tile \"eListObjectS\" (fl:list2string LIST_OBJECT_S_EST3 \";\"))
               (set_tile \"eListObjectA\" (fl:list2string LIST_OBJECT_A_EST3 \";\"))
               (set_tile \"eSystemName\" \"EST3\")
 			"
  )

  (action_tile "bSystemFP2000" 
               "
               (set_tile \"eListObjectS\" (fl:list2string LIST_OBJECT_S_FP2000 \";\"))
               (set_tile \"eListObjectA\" (fl:list2string LIST_OBJECT_A_FP2000 \";\"))
               (set_tile \"eSystemName\" \"FP2000\")
 			"
  )

  (action_tile "bSystemPOLON4000" 
               "
               (set_tile \"eListObjectS\" (fl:list2string LIST_OBJECT_S_POLON4000 \";\"))
               (set_tile \"eListObjectA\" (fl:list2string LIST_OBJECT_A_POLON4000 \";\"))
               (set_tile \"eSystemName\" \"POLON4000\")
 			"
  )

  (start_dialog)
  (unload_dialog dclID)
)

; --------------------------------------------------------------------------------------------------------

(defun fg:fire:dlg_new2 (/ dclID nastepny blokSP cur_ss) 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "App\\Views\\fireNew.dcl")))

  (setq nastepny 1)
  (setq cur_ss (cadr (ssgetfirst)))

  (print cur_ss)

  ;  (while (not (>= 0 nastepny))
  (new_dialog "DCLfireNew" dclID)
  ;    (setq blokSP (pl:czyZaznaczonyBlokWgNazwy cur_ss "SYSTEM_POZAROWY"))
  ;    (if blokSP
  ;      (progn
  ;        (setq rawSP (pl:string2list (pl:AtrybutWartoscGet blokSP "RAW") ";"))
  ;        (set_tile "spNazwa" (nth 0 rawSP))
  ;        (set_tile "spUUID" (nth 1 rawSP))
  ;
  ;        (print rawSP)
  ;      )
  ;      (PRINT "NIE ZAZNACZONY SP")
  ;    )

  (action_tile "wsp" 
               "
				(setq nastepny 1)
				(done_dialog 2)
        (setq cur_ss (ssget))
			"
  )

  (action_tile "bCancel" 
               "
				(setq nastepny 0)
				(done_dialog 1)
			"
  )

  (action_tile "bSave" 
               "
        (pl:UtworzCentrale (get_tile \"nazwaCentrali\") (get_tile \"numerCentrali\") (get_tile \"spUUID\")))
				(setq nastepny 0)
				(done_dialog 1)
			"
  )

  (start_dialog)
  ;)
  (unload_dialog dclID)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:fire:search () 
  (setq ssAllBlocks (ssget "_X" '((0 . "INSERT") (410 . "SP"))))

  (if ssAllBlocks 
    (progn 
      (setq i 0)
      (repeat (sslength ssAllBlocks) 
        (progn 
          (setq blockName (fl:block:name:get (ssname ssAllBlocks i)))
          (if (= blockName "SYSTEM_POZAROWY") 
            (setq fireFID (fl:block:FID:get (ssname ssAllBlocks i)))
          )
          (setq i (+ 1 i))
        )
      )
    )
    (progn 
      (setq fireFID nil)
    )
  )
  fireFID
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
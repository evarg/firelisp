;
; RAW = panelNumber
;


(defun fl:panel:new (panelName panelNumber fireFID / position) 
  (setq position (list (+ 32 (* (- panelNumber 1) 50)) 174))

  (fl:block:insert "FIRE" "SYSTEM_POZAROWY_CENTRALA" position 0.01 0)

  (fl:attrib:content:set (entlast) "CENTRALA" panelName)
  (fl:attrib:content:set (entlast) "FID" (fl:uuid))
  (fl:attrib:content:set (entlast) "OWNER_FID" fireFID)
  (fl:attrib:content:set (entlast) "RAW" (itoa panelNumber))
  (fl:attrib:location:set (entlast) "CENTRALA" "MR")
)



(defun fl:panel:new:dlg (/ dclID panelName fireFID entityName panelNumber) 
  (print "Wybierz system pozarowy")
  (setq entityName (car (entsel)))
  (setq fireFID (fl:attrib:content:get entityName "FID"))
  (setq panelNumber (+ 1 (length (fl:fire:getAllPanels fireFID))))

  (setq dclID (load_dialog 
                (strcat PATH_SCRIPT "app\\views\\panelNew.dcl")
              )
  )

  (new_dialog "DCLpanelNew" dclID)

  (set_tile "eFireName" (fl:attrib:content:get entityName "CENTRALA"))
  (set_tile "eFireFID" (fl:attrib:content:get entityName "FID"))
  (set_tile "ePanelNumber" panelNumber)
  (set_tile "ePanelName" (strcat "Centrala " (itoa panelNumber)))

  (action_tile "bSave" 
               "
               (setq panelName (get_tile \"ePanelName\")) 
               (setq fireFID (get_tile \"eFireFID\")) 
               (done_dialog 2)
               (fl:panel:new panelName panelNumber fireFID)
               "
  )

  (action_tile "bCancel" 
               "
				(done_dialog 1)
			"
  )

  (start_dialog)
  (unload_dialog dclID)
)


(defun fg:panel:dlg_new2 (/ dclID nastepny blokSP cur_ss) 
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

; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:border:is (entityName / rv) 
  (setq rv nil)
  (if (= (substr (fl:block:name:get entityName) 1 9) "FL_RAMKA_") 
    (progn 
      (setq rv T)
    )
  )
  rv
)

; --------------------------------------------------------------------------------------------------------

(defun fl:print:is (entityName / rv) 
  (setq rv nil)
  (if (= (substr (fl:block:name:get entityName) 1 9) "FL_WYDRUK") 
    (progn 
      (setq rv T)
    )
  )
  rv
)

; --------------------------------------------------------------------------------------------------------

(defun fl:border:getByFID (borderFID paramName) 
  (fl:attrib:content:get (fl:block:searchByFID borderFID) paramName)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:border:setByFID (borderFID paramName value) 
  (fl:attrib:content:set (fl:block:searchByFID borderFID) paramName value)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:border:icon:getByFID (borderFID paramName) 
  (fl:attrib:content:get (fl:block:searchByFID borderFID) paramName)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:border:icon:setByFID (borderFID paramName value) 
  (fl:attrib:content:set (fl:block:searchByFID borderFID) paramName value)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:print:getByFID (printFID paramName) 
  (fl:attrib:content:get (fl:block:searchByFID printFID) paramName)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:print:setByFID (printFID paramName value) 
  (fl:attrib:content:set (fl:block:searchByFID printFID) paramName value)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:border:FID:get (entityName / rv) 
  (setq rv (fl:attrib:content:get entityName "FID"))
  rv
)

; --------------------------------------------------------------------------------------------------------

(defun fl:border:layout:getByFID (borderFID) 
  (fl:block:layer:get (fl:block:searchByFID borderFID))
)

; --------------------------------------------------------------------------------------------------------

(defun fl:print:new:dlg (/ dclID returnDialog printFID dlcProjekt1 dlcProjekt2 
                         dlcProjekt3 dlcProjekt4 dlcOpracowanie1 dlcProjektowal1 
                         dlcProjektowal1upr dlcOpracowal1 dlcOpracowal1upr 
                         dlcOpracowal2 dlcOpracowal2upr dlcFaza dlcBranza dlcData
                        ) 

  (if (setq printFID (fl:print:exists)) 
    (progn 
      (setq dlcProjekt1 (fl:print:getByFID printFID "PROJEKT1"))
      (setq dlcProjekt2 (fl:print:getByFID printFID "PROJEKT2"))
      (setq dlcProjekt3 (fl:print:getByFID printFID "PROJEKT3"))
      (setq dlcProjekt4 (fl:print:getByFID printFID "PROJEKT4"))
      (setq dlcOpracowanie1 (fl:print:getByFID printFID "OPRACOWANIE"))
      (setq dlcProjektowal1 (fl:print:getByFID printFID "PROJEKTOWAL1"))
      (setq dlcProjektowal1upr (fl:print:getByFID printFID "PROJEKTOWAL1_UPR"))
      (setq dlcOpracowal1 (fl:print:getByFID printFID "OPRACOWAL1"))
      (setq dlcOpracowal1upr (fl:print:getByFID printFID "OPRACOWAL1_UPR"))
      (setq dlcOpracowal2 (fl:print:getByFID printFID "OPRACOWAL2"))
      (setq dlcOpracowal2upr (fl:print:getByFID printFID "OPRACOWAL2_UPR"))
      (setq dlcFaza (fl:print:getByFID printFID "FAZA"))
      (setq dlcBranza (fl:print:getByFID printFID "BRANZA"))
      (setq dlcData (fl:print:getByFID printFID "DATA_OPRACOWANIA"))
    )
    (progn 
      (setq dlcProjekt1 "")
      (setq dlcProjekt2 "")
      (setq dlcProjekt3 "")
      (setq dlcProjekt4 "")
      (setq dlcOpracowanie1 "")
      (setq dlcProjektowal1 "")
      (setq dlcProjektowal1upr "")
      (setq dlcOpracowal1 "")
      (setq dlcOpracowal1upr "")
      (setq dlcOpracowal2 "")
      (setq dlcOpracowal2upr "")
      (setq dlcFaza "")
      (setq dlcBranza "")
      (setq dlcData "")
    )
  )

  (setq returnDialog 999)

  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\printNew.dcl")))

  (while (> returnDialog 1) 
    (progn 
      (new_dialog "DCLprintNew" dclID)

      (set_tile "eProjekt1" dlcProjekt1)
      (set_tile "eProjekt2" dlcProjekt2)
      (set_tile "eProjekt3" dlcProjekt3)
      (set_tile "eProjekt4" dlcProjekt4)
      (set_tile "eOpracowanie1" dlcOpracowanie1)
      (set_tile "eProjektowal1" dlcProjektowal1)
      (set_tile "eProjektowal1UPR" dlcProjektowal1upr)
      (set_tile "eOpracowal1" dlcOpracowal1)
      (set_tile "eOpracowal1UPR" dlcOpracowal1upr)
      (set_tile "eOpracowal2" dlcOpracowal2)
      (set_tile "eOpracowal2UPR" dlcOpracowal2upr)
      (set_tile "eFaza" dlcFaza)
      (set_tile "eBranza" dlcBranza)
      (set_tile "eData" dlcData)

      (action_tile "bSelectFire" "(done_dialog 101)")
      (action_tile "accept" 
                   "
          (setq dlcProjekt1 (get_tile \"eProjekt1\"))
          (setq dlcProjekt2 (get_tile \"eProjekt2\"))
          (setq dlcProjekt3 (get_tile \"eProjekt3\"))
          (setq dlcProjekt4 (get_tile \"eProjekt4\"))
          (setq dlcOpracowanie1 (get_tile \"eOpracowanie1\"))
          (setq dlcProjektowal1 (get_tile \"eProjektowal1\"))
          (setq dlcProjektowal1upr (get_tile \"eProjektowal1UPR\"))
          (setq dlcOpracowal1 (get_tile \"eOpracowal1\"))
          (setq dlcOpracowal1upr (get_tile \"eOpracowal1UPR\"))
          (setq dlcOpracowal2 (get_tile \"eOpracowal2\"))
          (setq dlcOpracowal2upr (get_tile \"eOpracowal2UPR\"))
          (setq dlcFaza (get_tile \"eFaza\"))
          (setq dlcBranza (get_tile \"eBranza\"))
          (setq dlcData (get_tile \"eData\"))
          (done_dialog 1)
        "
      )

      (setq returnDialog (start_dialog))

      (if (= 101 returnDialog) 
        (progn)
      )

      (if (= 1 returnDialog) 
        (progn 
          (if (null printFID) 
            (setq printFID (fl:print:new))
          )
          (fl:print:setByFID printFID "PROJEKT1" dlcProjekt1)
          (fl:print:setByFID printFID "PROJEKT2" dlcProjekt2)
          (fl:print:setByFID printFID "PROJEKT3" dlcProjekt3)
          (fl:print:setByFID printFID "PROJEKT4" dlcProjekt4)
          (fl:print:setByFID printFID "OPRACOWANIE" dlcOpracowanie1)
          (fl:print:setByFID printFID "PROJEKTOWAL1" dlcProjektowal1)
          (fl:print:setByFID printFID "PROJEKTOWAL1_UPR" dlcProjektowal1upr)
          (fl:print:setByFID printFID "OPRACOWAL1" dlcOpracowal1)
          (fl:print:setByFID printFID "OPRACOWAL1_UPR" dlcOpracowal1upr)
          (fl:print:setByFID printFID "OPRACOWAL2" dlcOpracowal2)
          (fl:print:setByFID printFID "OPRACOWAL2_UPR" dlcOpracowal2upr)
          (fl:print:setByFID printFID "FAZA" dlcFaza)
          (fl:print:setByFID printFID "BRANZA" dlcBranza)
          (fl:print:setByFID printFID "DATA_OPRACOWANIA" dlcData)
        )
      )
    )
  )
  (unload_dialog dclID)

  (print returnDialog)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:print:new () 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (fl:layout:new LAYOUT_BORDER_NAME)
  (fl:layout:setActive LAYOUT_BORDER_NAME)

  ; usuniecie rzutni z layoutu
  (entdel (ssname (ssget "_X" '((0 . "VIEWPORT") (410 . "WYDRUK"))) 0))

  (setq position (list 2 168))

  (fl:block:insert "SSP" "FL_WYDRUK" position 0.5 0)
  (fl:attrib:content:set (entlast) "FID" (fl:uuid))

  (setq printFID (fl:block:FID:get (entlast)))

  (setvar "OSMODE" osval)
  printFID
)

; --------------------------------------------------------------------------------------------------------

(defun fl:border:new:dlg (/ dclID returnDialog borderFID) 
  (progn 
    (setq dclNazwaRysunku "nar")
    (setq dclNazwaArkusza "naa")
    (setq dclSkala "ska")
    (setq dclNumerRysunku "nrr")
    (setq dclRamka "FL_RAMKA_A3_POZIOM")
  )

  (setq returnDialog 999)

  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\borderNew.dcl")))

  (while (> returnDialog 1) 
    (progn 
      (new_dialog "DCLborderNew" dclID)

      (set_tile "dclNazwaRysunku" dclNazwaRysunku)
      (set_tile "dclNazwaArkusza" dclNazwaArkusza)
      (set_tile "dclSkala" dclSkala)
      (set_tile "dclNumerRysunku" dclNumerRysunku)
      (set_tile "dclRamka" dclRamka)

      (action_tile "bSelectFire" "(done_dialog 101)")
      (action_tile "accept" 
                   "
          (setq dclNazwaRysunku (get_tile \"dclNazwaRysunku\"))
          (setq dclNazwaArkusza (get_tile \"dclNazwaArkusza\"))
          (setq dclSkala (get_tile \"dclSkala\"))
          (setq dclNumerRysunku (get_tile \"dclNumerRysunku\"))
          (done_dialog 1)
        "
      )

      (setq returnDialog (start_dialog))

      (if (= 101 returnDialog) 
        (progn)
      )

      (if (= 1 returnDialog) 
        (progn 
          ; utworzenie ikony na WYDRUK
          (setq printFID (fl:print:exists))
          (setq borderIconFID (fl:border:icon:new printFID))
          (fl:border:icon:setByFID borderIconFID "NAZWA_RYSUNKU" dclNazwaRysunku)
          (fl:border:icon:setByFID borderIconFID "NAZWA_ARKUSZA" dclNazwaArkusza)
          (fl:border:icon:setByFID borderIconFID "SKALA" dclSkala)
          (fl:border:icon:setByFID borderIconFID "NUMER_RYSUNKU" dclNumerRysunku)
          (fl:border:icon:setByFID borderIconFID "RAMKA" dclRamka)

          ; utworzenie arkusza i wstawienie ramki
          (setq borderFID (fl:border:new printFID dclNazwaArkusza dclRamka))
          (fl:border:setByFID borderFID "NAZWA_RYSUNKU" dclNazwaRysunku)
          (fl:border:setByFID borderFID "NAZWA_ARKUSZA" dclNazwaArkusza)
          (fl:border:setByFID borderFID "SKALA" dclSkala)
          (fl:border:setByFID borderFID "NUMER_RYSUNKU" dclNumerRysunku)
        )
      )
    )
  )
  (unload_dialog dclID)

  (print returnDialog)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:border:icon:new (printFID) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (fl:layout:setActive LAYOUT_BORDER_NAME)

  (setq position (list 22 168))

  (fl:block:insert "SSP" "FL_WYDRUK_ARKUSZ" position 0.5 0)
  (fl:attrib:content:set (entlast) "FID" (fl:uuid))
  (fl:attrib:content:set (entlast) "OWNER_FID" printFID)

  (setq borderFID (fl:block:FID:get (entlast)))

  (setvar "OSMODE" osval)
  borderFID
)

; --------------------------------------------------------------------------------------------------------

(defun fl:border:new (ownerFID layoutName borderName / osval borderFID) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (fl:layout:new layoutName)
  (fl:layout:setActive layoutName)

  (fl:block:insert "SSP" borderName '(0 0) 1 0)
  (fl:attrib:content:set (entlast) "FID" (fl:uuid))
  (fl:attrib:content:set (entlast) "OWNER_FID" ownerFID)

  (setq borderFID (fl:block:FID:get (entlast)))

  (setvar "OSMODE" osval)
  borderFID
)

; --------------------------------------------------------------------------------------------------------

(defun fl:print:borders:position:set () 
  (setq printFID (fl:print:exists))

  (if (setq borderList (fl:block:searchByOwnerFID printFID)) 
    (foreach border borderList (progn))
  )


  (print borderList)
)

; --------------------------------------------------------------------------------------------------------

(defun ZERUJLinie () 
  (setq suma 0)
  (setq i 0)
  (setq all (ssget "_X" '((0 . "LINE") (8 . "__DP_SAP_STER_HDGS"))))

  (repeat (sslength all) 
    (setq line (entget (ssname all i)))
    (setq pos1 (assoc 10 line))
    (setq pos2 (assoc 11 line))

    (setq pos1n (list (nth 1 pos1) (nth 2 pos1) 0))
    (setq pos2n (list (nth 1 pos2) (nth 2 pos2) 0))
    
    (setq linen1 (subst (cons 10 pos1n) 
                       (assoc 10 line)
                       line
                )
    )
    (setq line2n (subst (cons 11 pos2n) 
                       (assoc 11 line)
                       linen1
                )
    )
    (entmod line2n)
    (print line2n)
    
    (setq i (+ 1 i))
  )
)

; --------------------------------------------------------------------------------------------------------

(defun listaLini () 
  (setq suma 0)
  (setq i 0)
  (setq all (ssget "_X" '((0 . "LINE") (8 . "__DP_SAP_STER_HDGS"))))

  (repeat (sslength all) 
    (setq line (entget (ssname all i)))
    (setq pos1 (assoc 10 line))
    (setq pos2 (assoc 11 line))

    (princ pos1)
    (princ " - ")
    (princ pos2)
    (print)
  )
)

; --------------------------------------------------------------------------------------------------------

(defun liczlinie (warstwa) 
  (setq suma 0)
  (setq i 0)
  (setq all (ssget "_X" '((0 . "LINE") (8 . "__DP_SAP_STER_HDGS"))))

  (repeat (sslength all) 
    (print (lineLength (ssname all i)))

    (setq suma (+ suma (lineLength (ssname all i))))

    (setq i (+ i 1))
  )
  (print (strcat "LINII: " (rtos i)))
  (print (strcat "SUMA: " (rtos suma)))
)

; --------------------------------------------------------------------------------------------------------

(defun lineLength (entityName) 
  (distance (cdr (assoc 10 (entget entityName))) 
            (cdr (assoc 11 (entget entityName)))
  )
)

; --------------------------------------------------------------------------------------------------------

(defun liczbloki2 (/ i all) 
  (setq i 0)
  (setq all (ssget "_X" '((0 . "INSERT") (8 . "__DP_SAP_STER_HDGS"))))

  (repeat (sslength all) 
    (princ (LM:al-effectivename (ssname all i)))
    (princ ";")
    (princ (fl:attrib:content:get (ssname all i) "PETLA"))
    (princ "/")
    (princ (fl:attrib:content:get (ssname all i) "ELEM"))
    (print)
    (setq i (+ i 1))
  )
  (print (strcat "LINII: " (rtos i)))
)

; --------------------------------------------------------------------------------------------------------

(defun liczbloki (/ i all) 
  (setq i 0)
  (setq all (ssget "_X" '((0 . "INSERT") (8 . "__DP_SAP_STER_YNTKSY"))))

  (repeat (sslength all) 
    (princ (LM:al-effectivename (ssname all i)))
    (princ ";")
    (princ (fl:attrib:content:get (ssname all i) "PETLA"))
    (princ "/")
    (princ (fl:attrib:content:get (ssname all i) "ELEM"))
    (print)
    (setq i (+ i 1))
  )
  (print (strcat "LINII: " (rtos i)))
)

; --------------------------------------------------------------------------------------------------------

(defun getblockname (blk / res) 
  (if blk 
    (progn 
      (if (= (type blk) 'ename) 
        (setq blk (vlax-ename->vla-object blk))
      ) ;_ end of if
      (setq res (if (vlax-property-available-p blk 'effectivename) 
                  (vla-get-effectivename blk)
                  (vla-get-name blk)
                ) ;_ end of if
      ) ;_ end of setq
    ) ;_ end of progn
  ) ;_ end of if
) ;_ end of defun

; --------------------------------------------------------------------------------------------------------

(defun LM:al-effectivename (ent / blk rep) 
  (if (wcmatch (setq blk (cdr (assoc 2 (entget ent)))) "`**") 
    (if 
      (and 
        (setq rep (cdadr 
                    (assoc -3 
                           (entget 
                             (cdr 
                               (assoc 330 
                                      (entget 
                                        (tblobjname "block" blk)
                                      )
                               )
                             )
                             '("AcDbBlockRepBTag")
                           )
                    )
                  )
        )
        (setq rep (handent (cdr (assoc 1005 rep))))
      )
      (setq blk (cdr (assoc 2 (entget rep))))
    )
  )
  blk
)
; =============================================================================================================
; | Funkcja       | fl:app:dlg_about                                                                          |
; |============================================================================================================
; | Atrybuty      |                                                                                           |
; |============================================================================================================
; | Przeznaczenie | Funkcja wyświetla okno dialogowe About                                                    |
; =============================================================================================================

(defun fl:app:dlg_about (/ dclID) 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\appAbout.dcl")))
  (new_dialog "DCL_appAbout" dclID)

  (action_tile "cancel" 
               "
				(done_dialog 1)
			"
  )

  (start_dialog)
  (unload_dialog dclID)
)


; =============================================================================================================
; | Funkcja       | fl:app:dlg_defaultOptions                                                                 |
; |============================================================================================================
; | Atrybuty      |                                                                                           |
; |============================================================================================================
; | Przeznaczenie | Funkcja wyświetla okno dialogowe dedykowane ustawieniu domyslnych wartosci dla niektorych |
; |               | operacji.                                                                                 |
; =============================================================================================================

(defun fl:app:dlg_defaultOptions (/ dclID) 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\defaultOptions.dcl")))
  (new_dialog "DCLdefaultOptions" dclID)

  (set_tile "eBlockScale" (rtos CONF_SCALE_DEFAULT))
  (set_tile "eAttribName" CONF_ATTRIB_OPERATION)

  (action_tile "accept" 
               "
               (setq CONF_SCALE_DEFAULT (atof (get_tile \"eBlockScale\")))
				       (setq CONF_ATTRIB_OPERATION (get_tile \"eAttribName\"))
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


(defun fl:app:dlg_attribVisibility () 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\attribVisibility.dcl")))
  (new_dialog "DCLattribVisibility" dclID)

  (set_tile "eBlockScale" (rtos CONF_SCALE_DEFAULT))

  (action_tile "cancel" 
               "
				(done_dialog 1)
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

  (action_tile "bAttribON" 
               "
               (fl:attrib:global:visibility (get_tile \"eAttribName\") VIS_ON)
			"
  )

  (action_tile "bAttribOFF" 
               "
               (fl:attrib:global:visibility (get_tile \"eAttribName\") VIS_OFF)
			"
  )

  (start_dialog)
  (unload_dialog dclID)
)


(defun fl:app:edit_attribContent () 
  (while T 
    (progn 
      (setq element (car (entsel)))
      (if element 
        (progn 
          (setq attribContent (fl:attrib:content:get element CONF_ATTRIB_OPERATION))
          (if (null attribContent) (setq attribContent ""))
          (print (strcat "Aktualna wartosc: " attribContent " Nowa wartosc: "))
          (setq attribContent (getstring))
          (if (/= attribContent "") 
            (fl:attrib:content:set element CONF_ATTRIB_OPERATION attribContent)
          )
        )
      )
    )
  )
)


(defun fl:app:dlg_blockXChange () 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\blockXChange.dcl")))
  (new_dialog "DCLblockXChange" dclID)

  (if (null G_blockNameS) (setq G_blockNameS ""))
  (if (null G_blockGroupD) (setq G_blockGroupD ""))
  (if (null G_blockNameD) (setq G_blockNameD ""))
  (if (null G_scale) (setq G_scale ""))
  (if (null G_diffX) (setq G_diffX ""))
  (if (null G_diffY) (setq G_diffY ""))
  (if (null G_attribS) (setq G_attribS ""))
  (if (null G_attribD) (setq G_attribD ""))

  (set_tile "eBlockS" G_blockNameS)
  (set_tile "eBlockGroupD" G_blockGroupD)
  (set_tile "eBlockD" G_blockNameD)
  (set_tile "eScale" G_scale)
  (set_tile "eDiffX" G_diffX)
  (set_tile "eDiffY" G_diffY)
  (set_tile "eAttribS" G_attribS)
  (set_tile "eAttribD" G_attribD)

  (action_tile "accept" 
               "
               (setq G_blockNameS (get_tile \"eBlockS\"))
               (setq G_blockGroupD (get_tile \"eBlockGroupD\"))
               (setq G_blockNameD (get_tile \"eBlockD\"))
               (setq G_scale (get_tile \"eScale\"))
               (setq G_diffX (get_tile \"eDiffX\"))
               (setq G_diffY (get_tile \"eDiffY\"))
               (setq G_attribS (get_tile \"eAttribS\"))
               (setq G_attribD (get_tile \"eAttribD\"))
               (setq attribPositionD (get_tile \"pAttribPositionD\"))
               (done_dialog 2)
			"
  )

  (start_list "pAttribPositionD")
  (mapcar 'add_list '("Gora" "Lewo" "Prawo" "Dol" "Lewo + WZ"))
  (end_list)


  (action_tile "cancel" "(done_dialog 1)")

  (setq returnDialog (start_dialog))
  (unload_dialog dclID)

  (if (= returnDialog 2) 
    (progn 
      (if (= G_scale "") 
        (setq G_scale 1)
        (setq G_scale (atof G_scale))
      )
      (if (= G_diffX "") 
        (setq G_diffX 0)
        (setq G_diffX (atof G_diffX))
      )
      (if (= G_diffY "") 
        (setq G_diffY 0)
        (setq G_diffY (atof G_diffY))
      )

      (cond 
        ((= attribPositionD "0") (setq attribPositionD "UC"))
        ((= attribPositionD "1") (setq attribPositionD "ML"))
        ((= attribPositionD "2") (setq attribPositionD "MR"))
        ((= attribPositionD "3") (setq attribPositionD "DC"))
        ((= attribPositionD "4") (setq attribPositionD "MLW"))
      )

      (fl:block:xchange G_blockNameS G_blockGroupD G_blockNameD G_scale G_diffX 
                        G_diffY G_attribS G_attribd attribPositionD
      )
    )
  )
)


(defun fl:app:dlg_attribFontSize (/ returnDialog fontSize attribName dclID) 
  (setq returnDialog 999)
  (setq fontSize 0)
  (setq fontWeight 0)
  (setq fontAngle 0)
  (setq attribName "")

  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\attribFontSize.dcl")))

  (start_dialog)

  (while (> returnDialog 1) 
    (progn 
      (new_dialog "DCLattribFontSize" dclID)
      (action_tile "bDefaultPLAN" "(set_tile \"eAttribName\" \"PLAN\")")
      (action_tile "bDefaultCENTRALA" "(set_tile \"eAttribName\" \"CENTRALA\")")
      (action_tile "bDefaultRAW" "(set_tile \"eAttribName\" \"RAW\")")
      (action_tile "cancel" "(done_dialog 1)")
      (action_tile "bAttribGet" 
                   "
        (setq attribName (get_tile \"eAttribName\"))
        (done_dialog 101)"
      )
      (action_tile "bAttribSet" 
                   "
                   (setq fontSize (atof (get_tile \"eFontSize\")))
                   (setq fontWeight (atof (get_tile \"eFontWeight\")))
                   (setq fontAngle (atof (get_tile \"eFontAngle\")))
                  
        (done_dialog 102)"
      )

      (if fontSize (set_tile "eFontSize" (rtos fontSize)))
      (if fontWeight (set_tile "eFontWeight" (rtos fontWeight)))
      (if fontAngle (set_tile "eFontAngle" (rtos fontAngle)))

      (set_tile "eAttribName" attribName)
      (set_tile "eFontSize" fontSize)
      (set_tile "eFontWeight" fontWeight)
      (set_tile "eFontAngle" fontAngle)

      (setq returnDialog (start_dialog))

(print returnDialog)      
      
      (if (= 101 returnDialog) 
        (progn 
          (setq entityName (car (entsel)))
          (if (fl:block:is entityName) 
            (progn 
              (setq fontSize (fl:attrib:parametr:get entityName attribName 40))
              (setq fontWeight (fl:attrib:parametr:get entityName attribName 41))
              (setq fontAngle (fl:attrib:parametr:get entityName attribName 51))
              (print fontWeight)
            )
          )
        )
      )
      (if (= 102 returnDialog) 
        (progn 
          (fl:attrib:global:parametr:set attribName 40 fontSize)
          (fl:attrib:global:parametr:set attribName 41 fontWeight)
          (fl:attrib:global:parametr:set attribName 51 fontAngle)
          (print attribName)
        )
      )
    )
  )

  (unload_dialog dclID)
)



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


(defun fl:app:dlg_attribFontSize () 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\attribFontSize.dcl")))
  (new_dialog "DCLattribFontSize" dclID)

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
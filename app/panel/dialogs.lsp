; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:panel:new:dlg (/ dclID entityName panelNumber panelName fireFID fireName 
                         returnDialog
                        ) 
  (fl:layout:setActive LAYOUT_FIRE_NAME)
  (fl:layer:setActive LAYOUT_FIRE_NAME)

  (setq fireName "brak")
  (setq fireFID "brak")
  (setq panelNumber "brak")
  (setq panelNumberView "brak")
  (setq panelName "brak")

  (setq returnDialog 999)

  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\panelNew.dcl")))

  (while (> returnDialog 1) 
    (progn 
      (new_dialog "DCLpanelNew" dclID)

      (set_tile "tFireName" fireName)
      (set_tile "tFireFID" fireFID)
      (set_tile "ePanelNumber" panelNumber)
      (set_tile "ePanelName" panelName)
      (set_tile "ePanelNumberView" panelNumberView)

      (action_tile "bSelectFire" "(done_dialog 101)")
      (action_tile "accept" 
                   "
                   (setq fireName (get_tile \"tFireName\"))
                   (setq fireFID (get_tile \"tFireFID\"))
                   (setq panelNumber (atoi (get_tile \"ePanelNumber\")))
                   (setq panelNumberView (get_tile \"ePanelNumberView\"))
                   (setq panelName (get_tile \"ePanelName\"))
                   (done_dialog 1)
        "
      )

      (setq returnDialog (start_dialog))

      (if (= 101 returnDialog) 
        (progn 
          (setq entityName (car (entsel)))
          (print entityNAme)
          (if (fl:fire:is entityName) 
            (progn 
              (setq fireName (fl:fire:name:get entityName))
              (setq fireFID (fl:fire:FID:get entityName))
              (setq panelNumber (itoa 
                                  (+ 1 
                                     (length 
                                       (fl:fire:getAllPanels 
                                         (fl:fire:FID:get entityName)
                                       )
                                     )
                                  )
                                )
              )
              (setq panelName (strcat "Centrala " panelNumber))
              (setq panelNumberView panelNumber)
            )
          )
        )
      )

      ; wcisniety klawisz OK
      (if (= 1 returnDialog) 
        (progn 
          (fl:panel:new panelName panelNumber panelNumberView fireFID)
        )
      )
    )
  )
  (unload_dialog dclID)

  (print returnDialog)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:panel:change:dlg (/ dclID entityName panelName panelFID loopName loopNumber 
                            returnDialog
                           ) 
  (fl:layout:setActive LAYOUT_FIRE_NAME)
  (fl:layer:setActive LAYOUT_FIRE_NAME)

  (setq returnDialog 999)
  (setq panelName "brak1")
  (setq panelNumber "brak")
  (setq panelNumberView "brak")
  (setq panelFID "brak")

  (setq returnDialog 2)
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\panelChange.dcl")))

  (while (> returnDialog 1) 
    (progn 
      (new_dialog "DCLpanelChange" dclID)

      (set_tile "tLoopFID" panelFID)
      (set_tile "ePanelName" panelName)
      (set_tile "ePanelNumber" panelNumber)
      (set_tile "ePanelNumberView" panelNumberView)

      (action_tile "BselectPanel" "(done_dialog 101)")
      (action_tile "accept" 
                   "
                   (setq panelFID (get_tile \"tPanelFID\"))
                   (setq panelName (get_tile \"ePanelName\"))
                   (setq panelNumber (get_tile \"ePanelNumber\"))
                   (setq panelNumberView (get_tile \"ePanelNumberView\"))
                   (done_dialog 1)
        "
      )

      (setq returnDialog (start_dialog))

      (if (= 1 returnDialog) 
        (progn 
          (fl:panel:name:set entityName panelName)
          (fl:panel:nameView:set 
            entityName
            (fl:panel:nameView:calculate (itoa panelNumber) panelName panelNumberView)
          )
          (fl:panel:number:set entityName panelNumber)
          (fl:panel:numberView:set entityName panelNumberView)
        )
      )

      (if (= 101 returnDialog) 
        (progn 
          (setq entityName (car (entsel)))
          (if (fl:panel:is entityName) 
            (progn 
              (setq panelFID (fl:block:FID:get entityName))
              (setq panelName (fl:panel:name:get entityName))
              (setq panelNumber (fl:panel:number:get entityName))
              (setq panelNumberView (fl:panel:numberView:get entityName))
            )
          )
        )
      )
    )
  )
  (unload_dialog dclID)

  (print returnDialog)
)
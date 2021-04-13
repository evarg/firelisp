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


(defun fl:app:dlg_defaultOptions (/ dclID) 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\views\\defaultOptions.dcl")))
  (new_dialog "DCLdefaultOptions" dclID)

  (set_tile "eBlockScale" (rtos CONF_SCALE_DEFAULT))

  (action_tile "cancel" 
               "
				(done_dialog 1)
			"
  )

  (action_tile "accept" 
               "
               (setq CONF_SCALE_DEFAULT (atof (get_tile \"eBlockScale\")))
				       (done_dialog 0)
			"
  )


  (start_dialog)
  (unload_dialog dclID)
)
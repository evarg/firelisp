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
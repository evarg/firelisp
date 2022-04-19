; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================


; --------------------------------------------------------------------------------------------------------

(defun fl:log (text / exitValue) 
  (setq exitValue (strcat "* " text " "))
  (repeat (- LOG_WIDTH (strlen exitValue)) 
    (setq exitValue (strcat exitValue " "))
  )
  (setq exitValue (strcat exitValue "    "))
  (princ exitValue)
  (print)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:log:return (text / exitValue) 
  (setq exitValue (strcat "* " text " "))
  (repeat (- LOG_WIDTH (strlen exitValue)) 
    (setq exitValue (strcat exitValue " "))
  )
  (setq exitValue (strcat exitValue "    "))
  (princ exitValue)
  (print)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:log:header (text) 
  (print)
  (print)
  (fl:log:line)
  (fl:log text)
  (fl:log:empty)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:log:footer () 
  (fl:log:line)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:log:empty () 
  (fl:log " ")
)

; --------------------------------------------------------------------------------------------------------

(defun fl:log:error (text) 
  (fl:log (strcat " !! ERROR !!  " text))
)

; --------------------------------------------------------------------------------------------------------

(defun fl:log:info (text) 
  (fl:log (strcat " -- INFO  --  " text))
)

; --------------------------------------------------------------------------------------------------------

(defun fl:log:line (/ exitValue) 
  (setq exitValue "")
  (repeat LOG_WIDTH 
    (setq exitValue (strcat exitValue "*"))
  )
  (setq exitValue (strcat exitValue "  "))
  (princ exitValue)
  (print)
)

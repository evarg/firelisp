(defun fl:layout:new (layoutName) 
  (command "_layout" "_N" layoutName)
)

(defun fl:layout:setActive (layoutName) 
  (setvar "ctab" layoutName)
)


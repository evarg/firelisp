


(defun fl:block:position:get (entityName) 
  (cdr (assoc 10 (entget entityName)))
)


(defun fl:block:position:set (entityName position / osval) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (command "_move" entityName "" (fl:block:position:get entityName) position)

  (setvar "OSMODE" osval)
)


(defun fl:block:scale:get (entityName) 
  (cdr (assoc 41 (entget entityName)))
)


(defun fl:block:insert (blockGroup blockName position scale rotate / fileName osval) 
  (setq osval (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  (if (tblsearch "BLOCK" blockName) 
    (progn 
      (if position 
        (command "_insert" blockName "S" scale "O" rotate position)
        (command "_insert" blockName "S" scale "O" rotate)
      )
    )
    (progn 
      (setq fileName (strcat PATH_BLOCK blockGroup "\\" blockName ".dwg"))
      (print (strcat "Wczytanie z dysku: " fileName))
      (if position 
        (command "_insert" fileName "S" scale "O" rotate position)
        (command "_insert" fileName "S" scale "O" rotate)
      )
    )
  )
  (setvar "OSMODE" osval)
)
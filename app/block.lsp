(defun fl:block:FID:get (entityName / rv) 
  (setq rv nil)
  (setq rv (fl:attrib:content:get entityName "FID"))
  rv
)


(defun fl:block:is (entityName / rv) 
  (setq rv nil)
  (if entityName 
    (progn 
      (if (= (cdr (assoc 0 (entget entityName))) "INSERT") 
        (setq rv T)
      )
    )
  )
  rv
)


(defun fl:block:name:get (entityName / rv) 
  (setq rv nil)
  (if (fl:block:is entityName) 
    (progn 
      (setq rv (cdr (assoc 2 (entget entityName))))
    )
  )
  rv
)


(defun fl:block:searchByFID (fid / ssBlocks i blockFID returnValue) 
  (setq ssBlocks (ssget "_X" '((0 . "INSERT"))))
  (setq i 0)

  (repeat (sslength ssBlocks) 
    (progn 
      (setq entityName (ssname ssBlocks i))
      (setq blockFID (fl:attrib:content:get entityName "FID"))
      (if (= blockFID fid) 
        (progn 
          (setq returnValue entityName)
        )
      )
      (setq i (+ i 1))
    )
  )
  returnValue
)


(defun fl:block:searchByOwnerFID (fid / ssBlocks i blockFID blockOwnerFID returnValue 
                                  entityName
                                 ) 

  (setq returnValue (list))

  (setq ssBlocks (ssget "_X" '((0 . "INSERT"))))
  (setq i 0)

  (repeat (sslength ssBlocks) 
    (progn 
      (setq entityName (ssname ssBlocks i))
      (setq blockFID (fl:attrib:content:get entityName "FID"))
      (setq blockOwnerFID (fl:attrib:content:get entityName "OWNER_FID"))
      (if (= blockOwnerFID fid) 
        (progn 
          (setq returnValue (cons blockFID returnValue))
        )
      )
      (setq i (+ i 1))
    )
  )
  returnValue
)


(defun fl:block:generateFID:ss (/ entityName ssActive i) 
  (setq ssActive (cadr (ssgetfirst)))
  (setq i 0)
  (if ssActive 
    (progn 
      (repeat (sslength ssActive) 
        (setq entityName (ssname ssActive i))
        (fl:attrib:content:set entityName "FID" (fl:uuid))
        (setq i (+ i 1))
      )
    )
    (print "Nic nie wybrano")
  )
)


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


(defun fl:block:xchange (blockNameS blockGroupD blockNameD scale diffX diffY attribS 
                         attribD attribPositionD
                        ) 
  (setq ssAllBlocks (ssget "_X" '((0 . "INSERT"))))
  (setq countBlocks (sslength ssAllBlocks))

  (setq i 0)
  (repeat countBlocks 
    (progn 
      (setq blockS (ssname ssAllBlocks i))

      (if (= (fl:block:name:get blockS) blockNameS) 
        (progn 
          (setq positionD (list (+ (car (fl:block:position:get blockS)) diffX) 
                                (+ (car (cdr (fl:block:position:get blockS))) 
                                   diffY
                                )
                          )
          )

          (fl:block:insert blockGroupD blockNameD positionD scale 0)

          (if (or (= attribS "") (= attribD "")) 
            (print "Brak kopiowania atrybutow")
            (progn 
              (setq attribContentS (fl:attrib:content:get blockS attribS))
              (if (= attribContentS NIL) 
                (setq attribContentS "BRAK")
              )
              (fl:attrib:content:set (entlast) attribD attribContentS)
              (fl:attrib:location:set (entlast) attribD attribPositionD)
            )
          )
        )
      )
      (setq i (+ i 1))
    )
  )
)
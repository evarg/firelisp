; =============================================================================
; | Functions                                                                 |
; =============================================================================

(defun fl:attrib:global:visibility (attribName visibility / i ssAllBlocks) 
  (setq ssAllBlocks (ssget "_X" '((0 . "INSERT"))))

  (setq i 0)
  (repeat (sslength ssAllBlocks) 
    (progn 
      (fl:attrib:visibility (ssname ssAllBlocks i) attribName visibility)
      (setq i (+ i 1))
    )
  )
)

; --------------------------------------------------------------------------------------------------------

(defun fl:attrib:global:font:size (attribName textHeight / i ssAllBlocks) 
  (setq ssAllBlocks (ssget "_X" '((0 . "INSERT"))))

  (setq i 0)
  (repeat (sslength ssAllBlocks) 
    (progn 
      (fl:attrib:font:size:set (ssname ssAllBlocks i) attribName textHeight)
      (setq i (+ i 1))
    )
  )
)

; --------------------------------------------------------------------------------------------------------

(defun fl:attrib:global:parametr:set (attribName parametrNumber value / i ssAllBlocks) 
  (setq ssAllBlocks (ssget "_X" '((0 . "INSERT"))))
  (if ssAllBlocks 
    (progn 
      (setq i 0)
      (repeat (sslength ssAllBlocks) 
        (progn 
          (fl:attrib:parametr:set 
            (ssname ssAllBlocks i)
            attribName
            parametrNumber
            value
          )
          (setq i (+ i 1))
        )
      )
    )
  )
)

; --------------------------------------------------------------------------------------------------------

(defun fl:attrib:parametr:get (entityName attribName parametrNumber / enx exitValue) 
  (if (entnext entityName) 
    (while 
      (and 
        (null end)
        (= "ATTRIB" 
           (cdr 
             (assoc 0 (setq enx (entget (setq entityName (entnext entityName)))))
           )
        )
      ) ;and

      (if (= (strcase attribName) (strcase (cdr (assoc 2 enx)))) 
        (setq exitValue (cdr (assoc parametrNumber enx)))
      ) ;if
    ) ;while
    (setq exitValue nil)
  )
  exitValue
)

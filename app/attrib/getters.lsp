; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:attrib:content:get (entityName attribName / enx exitValue) 
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
        (setq exitValue (cdr (assoc 1 enx)))
      ) ;if
    ) ;while
    (setq exitValue nil)
  )
  exitValue
)

; --------------------------------------------------------------------------------------------------------

(defun fl:entity:type:get (entityName / exitValue) 
  (setq exitValue (cdr 
                    (assoc 0 (setq enx (entget entityName)))
                  )
  )
  exitValue
)

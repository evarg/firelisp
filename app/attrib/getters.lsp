; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:attrib:content:get (entityName attribName / enx exitValue) 
  (setq exitValue nil)
  (setq entityName (entnext entityName))

  (if entityName 
    (progn 
      (while 
        (= "ATTRIB" 
           (cdr (assoc 0 (entget entityName)))
        )
        (progn 
          (if 
            (= (strcase attribName) (strcase (cdr (assoc 2 (entget entityName)))))
            (setq exitValue (cdr (assoc 1 (entget entityName))))
          )
          (setq entityName (entnext entityName))
        )
      )
    )
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
(defun fl:copy:text:to:block (/ exitValue) 
  (while T 
    (progn 
      (setq text (cdr (assoc 1 (entget (car (entsel "Wybierz TEXT --->"))))))

      (fl:attrib:content:set 
        (car (entsel "Wstaw text do BLOKU <---"))
        "centrala"
        text
      )
    )
  )
)
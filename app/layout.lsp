; ========================================================================================================
; | Functions                                                                                            |
; ========================================================================================================

(defun fl:layout:new (layoutName) 
  (command "_layout" "_N" layoutName)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:layout:setActive (layoutName) 
  (setvar "ctab" layoutName)
)

; --------------------------------------------------------------------------------------------------------

(defun fl:print:exists ( / rv ssBlocks entityName i) 
  (setq ssBlocks (ssget "_X" '((0 . "INSERT"))))
  (setq i 0)

  (if ssBlocks 
    (progn 
      (repeat (sslength ssBlocks) 
        (progn 
          (setq entityName (ssname ssBlocks i))

          (if (fl:print:is entityName) 
            (setq rv (fl:block:FID:get entityName))
          )

          (setq i (+ i 1))
        )
      )
    )
  )
  rv
)
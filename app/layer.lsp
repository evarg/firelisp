(defun fl:layer:off (layerName) 
  (command "_layer" "_off" layerName "")
)


(defun fl:layer:on (layerName) 
  (command "_layer" "_on" layerName "")
)

(defun fl:layer:new (layerName) 
  (command "_layer" "_new" layerName "")
)


(defun fl:layer:setActive (layerName) 
  (command "_layer" "s" layerName "")
)

(defun fl:layer:getByName (layerName) 
  (setq ssBlocks (ssget "_X" '((0 . "LAYER"))))
  (setq i 0)

  (repeat (sslength ssBlocks) 
    (progn 
      (setq entityName (ssname ssBlocks i))
      (print entityName)
      ;      (setq blockFID (fl:attrib:content:get entityName "FID"))
      ;      (if (= blockFID fid)
      ;        (progn
      ;          (setq returnValue entityName)
      ;        )
      ;      )
      (setq i (+ i 1))
    )
  )
  returnValue
)


(defun fl:layer:name:set (layerName layerNameNew / obj state) 
  (if (setq obj (tblobjname "Layer" layerName)) 
    (progn 
      (setq state (cdr (assoc 2 (entget obj))))
      (entmod 
        (subst 
          (cons 2 layerNameNew)
          (assoc 2 (entget obj))
          (entget obj)
        )
      )
    )
  )
)


(defun fl:layer:color:set (layerName color / obj state) 
  (if (setq obj (tblobjname "Layer" layerName)) 
    (progn 
      (setq state (cdr (assoc 62 (entget obj))))
      (entmod 
        (subst 
          (cons 62 color)
          (assoc 62 (entget obj))
          (entget obj)
        )
      )
    )
  )
)

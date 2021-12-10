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


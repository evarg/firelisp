(defun fl:layer:off (layerName)
  (command "_layer" "_off" layerName "")
)


(defun fl:layer:on (layerName)
  (command "_layer" "_on" layerName "")
)
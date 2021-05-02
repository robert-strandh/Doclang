(cl:in-package #:doclang)

(defun make-unique-id ()
  (logior (ash (get-universal-time) 16)
          (random (ash 1 16))))

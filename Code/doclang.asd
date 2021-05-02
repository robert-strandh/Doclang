(cl:in-package #:asdf-user)

(defsystem #:doclang
  :depends-on ()
  :serial t
  :components
  ((:file "packages")
   (:file "utilities")
   (:file "input-output")
   (:file "stuff")))

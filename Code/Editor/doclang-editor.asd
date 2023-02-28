(cl:in-package #:asdf-user)

(defsystem #:doclang-editor
  :depends-on (#:mcclim
               #:doclang)
  :serial t
  :components
  ((:file "packages")
   (:file "gui")
   (:file "commands")
   (:file "output-records")))

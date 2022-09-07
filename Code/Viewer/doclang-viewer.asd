(cl:in-package #:asdf-user)

(defsystem #:doclang-viewer
  :depends-on (#:mcclim)
  :serial t
  :components
  ((:file "packages")
   (:file "viewer")))

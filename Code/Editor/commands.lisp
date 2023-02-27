(cl:in-package #:doclang-editor)

(define-editor-command
    (com-quit :name t)
    ()
  (clim:frame-exit clim:*application-frame*))

(esa:set-key `(com-quit)
             'editor
             '((#\x :control) (#\c :control)))


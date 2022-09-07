(cl:in-package #:common-lisp-user)

(defpackage #:doclang
  (:use #:common-lisp)
  (:export
   #:chunk #:unique-id
   #:word-component-chunk #:characters
   #:compound-object
   #:compound-chunk #:children
   #:phrase
   #:terminator
   #:sentence
   #:paragraph
   #:itemize
   #:section
   #:title
   #:author
   #:document
   #:emphasize
   #:read-model
   #:write-model))


(cl:in-package #:common-lisp-user)

(defpackage #:doclang
  (:use #:common-lisp)
  (:export
   #:chunk #:unique-id
   #:word-component-chunk #:characters
   #:compound-chunk #:children
   #:word-chunk
   #:phrase-chunk
   #:sentence-chunk
   #:paragraph-chunk
   #:indirect-chunk
   #:inline-chunk
   #:reference-chunk
   #:read-model
   #:write-model))


(cl:in-package #:doclang)

(defclass unique-id-mixin ()
  ((%unique-id :initform nil :initarg :unique-id :reader unique-id)))

(defclass chunk (unique-id-mixin)
  ((%contents :initarg :contents :accessor contents)))

(define-save-info chunk
 ((:unique-id unique-id)
  (:contents contents)))

(defclass compound-object ()
  ((%children :initarg :children :accessor children)))

(define-save-info compound-object
 ((:children children)))

(defclass sentence (compound-object)
  ())

(defclass paragraph (compound-object)
  ())

(defclass itemize (compound-object)
  ())

(defclass section (compound-object)
  ((%title :initarg :title :accessor title)))

(define-save-info section
  ((:title title)))

(defclass document (compound-object)
  ((%title :initarg :title :accessor title)
   (%author :initarg :author :accessor author)))

(define-save-info document
  ((:title title)
   (:author author)))

(defclass emphasize (compound-object)
  ())

(defclass chunk-inline (unique-id-mixin)
  ())

(defclass chunk-reference (unique-id-mixin)
  ())

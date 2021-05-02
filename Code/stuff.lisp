(cl:in-package #:doclang)

(defclass chunk ()
  ((%unique-id :initform nil :initarg :unique-id :reader unique-id)))

(define-save-info chunk
  ((:unique-id unique-id)))
  

(defclass word-component-chunk (chunk)
  ((%characters :initarg :characters :reader characters)))

(define-save-info word-component-chunk
 ((:characters characters)))

(defclass compound-chunk (chunk)
  ((%children :initarg :children :reader children)))

(define-save-info compound-chunk
  ((:children children)))

(defclass word-chunk (compound-chunk)
  ())

(defclass phrase-chunk (compound-chunk)
  ())

(defclass sentence-chunk (compound-chunk)
  ())

(defclass paragraph-chunk (compound-chunk)
  ())

(defclass indirect-chunk (chunk)
  ((%indirect-id :initarg :indirect-id :reader indirect-id)))

(define-save-info indirect-chunk
  ((:indirect-id indirect-id)))

(defclass inline-chunk (indirect-chunk)
  ())

(defclass reference-chunk (indirect-chunk)
  ())



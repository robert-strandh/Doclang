(cl:in-package #:doclang-editor)

(defclass record (clim:output-record)
  ((%parent :initarg :parent :accessor parent)
   (%x-position :initarg :x-position :accessor x-position)
   ;; This slot contains a factor to be applied to the text size of
   ;; the parent record in order to obtain the text size to be used
   ;; for this record and its children.
   (%text-size-factor :initarg :text-size-factor :reader text-size-factor)
   ;; This slot contains a CLIM text family to be used for this record
   ;; and its children.
   (%text-family :initarg :text-family :reader text-family)
   ;; This slot contains a CLIM text face to be used for this record
   ;; and its children.
   (%text-face :initarg :text-face :reader text-face)))

;;; The CLIM specification says we must handle initargs :Y-POSITION,
;;; and :SIZE in addition to :X-POSITION and :PARENT, so we handle
;;; them in this method, which does not do anything with them.
(defmethod initialize-instance :after
    ((record record) &key y-position size)
  (declare (ignore y-position size))
  nil)

(defclass word-record
    (record clim:displayed-output-record)
  ((%contents :initarg :contents :reader contentes)))

(defclass compound-record (record)
  ((%contents :initarg :contents :accessor contents)))

(defclass line-record (compound-record)
  ())

(defclass paragraph-record (compound-record)
  ())

(defclass page-record (compound-record)
  ())

(cl:in-package #:doclang-editor)

(defclass record (clim:output-record)
  ((%parent :initarg :parent :accessor parent)
   (%x-position :initarg :x-position :accessor x-position)))

;;; The CLIM specification says we must handle initargs :Y-POSITION,
;;; and :SIZE in addition to :X-POSITION and :PARENT, so we handle
;;; them in this method, which does not do anything with them.
(defmethod initialize-instance :after
    ((record record) &key y-position size)
  nil)

(defclass word-record (record clim:displayed-output-record)
  ((%contents :initarg :contents :reader contents)))

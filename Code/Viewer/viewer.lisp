(cl:in-package #:doclang-viewer)

(clim:define-application-frame viewer ()
  ((%model :initform nil :initarg :model :accessor model)
   (%current-directory
    :initarg :current-directory
    :accessor current-directory))
  (:panes (application :application
		       :height 1000 :width 1500
		       :display-function 'display-doclang-pane)
	  (interactor :interactor :height 100))
  (:layouts (default (clim:vertically ()
		       application interactor))))

(defvar *left-margin*)
(defvar *right-margin*)

(defun newline (pane &optional (count 1))
  (loop repeat count
        do (format pane "~%"))
  (clim:stream-increment-cursor-position pane *left-margin* 0))

(defgeneric display-element (frame pane element))

(defmethod display-element
    (frame pane (element doclang:compound-object))
  (loop for child in (doclang:children element)
        do (display-element frame pane child)))

(defmethod display-element
    (frame pane (element doclang:document))
  (clim:with-text-size (pane :huge)
    (display-element frame pane (doclang:title element))
    (newline pane)
    (format pane "~a" (doclang:author element))
    (newline pane))
  (loop for child in (doclang:children element)
        do (display-element frame pane child)
           (newline pane 2)))

(defvar *section-numbers*)

(defmethod display-element
    (frame pane (element doclang:section))
  (clim:with-text-size (pane :very-large)
    (loop for (section-number next) on (reverse *section-numbers*)
          do (format pane "~a" section-number)
             (unless (null next)
               (format pane ".")))
    (display-element frame pane (doclang:title element)))
  (newline pane 2)
  (let ((*section-numbers* (cons 1 *section-numbers*)))
    (loop for child in (doclang:children element)
          do (display-element frame pane child)
             (newline pane 2)))
  (incf (first *section-numbers*)))

(defmethod display-element
    (frame pane (element doclang:paragraph))
  (clim:stream-increment-cursor-position
   pane
   (- *left-margin* (clim:stream-cursor-position pane))
   0)
  (loop for child in (doclang:children element)
        do (display-element frame pane child)
           (format pane " ")))

(defmethod display-element
    (frame pane (element doclang:itemize))
  (let ((*left-margin* (+ *left-margin* 50)))
    (loop for child in (doclang:children element)
          do (clim:draw-circle*
              pane
              (- *left-margin* 15)
              (+ (nth-value 1 (clim:stream-cursor-position pane)) 10)
              5
              :filled t)
             (display-element frame pane child)
             (newline pane 2))))

(defmethod display-element
    (frame pane (element doclang:sentence))
  (loop for child in (doclang:children element)
        do (display-element frame pane child))
  (format pane " "))

(defmethod display-element
    (frame pane (element string))
  (declare (ignore frame))
  (unless (member (char element 0) '(#\, #\: #\; #\.))
    (cond ((> (clim:stream-cursor-position pane) *right-margin*)
           (newline pane))
          ((> (clim:stream-cursor-position pane)
              (+ *left-margin* 0.01))
           (format pane " "))
          (t
           nil)))
  (format pane "~a" element))

(defmethod display-element
    (frame pane (element doclang:emphasize))
  (clim:with-text-face (pane :italic)
    (loop for child in (doclang:children element)
          do (display-element frame pane child))))

(defun display-doclang-pane (frame pane)
  (unless (null (model frame))
    (let ((*section-numbers* (list 1))
          (*left-margin* 0)
          (*right-margin* 900))
      (display-element frame pane (model frame)))))

(defun view ()
  (clim:run-frame-top-level
   (clim:make-application-frame 'viewer
     :current-directory *default-pathname-defaults*)))

(define-viewer-command (com-quit :name t) ()
  (clim:frame-exit clim:*application-frame*))

(define-viewer-command (com-cd :name t)
    ((filename 'pathname
               :default (namestring (current-directory clim:*application-frame*))
               :default-type 'clim:pathname
               :insert-default t))
  (setf (current-directory clim:*application-frame*)
        (pathname filename)))

(define-viewer-command (com-read-document :name t)
    ((filename 'pathname
               :default (namestring (current-directory clim:*application-frame*))
               :default-type 'clim:pathname
               :insert-default t))
  (setf (model clim:*application-frame*)
        (doclang:read-model filename '("V1"))))

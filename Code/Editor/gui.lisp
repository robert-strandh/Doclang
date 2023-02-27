(cl:in-package #:doclang-editor)

(defparameter *info-pane-text-style*
  (clim:make-text-style :fix :roman 14))

(defclass info-pane (esa:info-pane)
  ()
  (:default-initargs
   :height 20 :max-height 20 :min-height 20
   :text-style *info-pane-text-style*
   :display-function 'display-info
   :incremental-redisplay t))

(defun display-info (frame info-pane)
  (declare (ignore frame))
  (format info-pane
          " ~a (~a)"
          "buffer"
          "stuff"))

(defparameter *minibuffer-pane-text-style*
  (clim:make-text-style :fix :roman 14))

(defclass minibuffer-pane (esa:minibuffer-pane)
  ()
  (:default-initargs
   :text-style *minibuffer-pane-text-style*
   :height 20 :max-height 20 :min-height 20))

(defparameter *default-text-style*
  (clim:make-text-style :fix :roman 14))

(defclass text-pane (esa:esa-pane-mixin
                     clim:application-pane)
  ()
  (:default-initargs
   :background clim:+white+
   :text-style *default-text-style*))

(defun make-text-pane ()
  (clim:make-pane 'text-pane
                  :name 'stuff
                  :default-view clim:+textual-view+
                  :width 900 :height 900
                  :display-time nil))

(clim:define-application-frame editor
    (esa:esa-frame-mixin
     clim:standard-application-frame)
  ()
  (:menu-bar nil)
  (:panes
   (window
    (let* ((my-pane (make-text-pane))
           (my-info-pane (clim:make-pane 'info-pane
                                         :master-pane my-pane
                                         :width 900)))
      (setf (clim:stream-recording-p my-pane) nil)
      (setf (clim:stream-end-of-line-action my-pane) :allow)
      ;; Unfortunately, the ESA top-level accesses the slot
      ;; named WINDOWS directly (using WITH-SLOTS) rather than
      ;; using the accessor, so we must initialize this slot
      ;; by using the slot writer provided by ESA.
      (setf (esa:windows clim:*application-frame*) (list my-pane))
      (clim:vertically ()
        my-pane
        my-info-pane)))
   (minibuffer (clim:make-pane 'minibuffer-pane :width 900)))
  (:layouts
   (default (clim:vertically ()
              window
              minibuffer)))
  (:top-level (esa:esa-top-level)))

(defun editor (&key new-process (process-name "Doclang editor"))
  (with-open-file (stream
                   (uiop:xdg-config-home "doclang-editor" "init.lisp")
                   :if-does-not-exist nil)
    (unless (null stream)
      (load stream)))
  (let ((frame (clim:make-application-frame 'editor)))
    (flet ((run () (clim:run-frame-top-level frame)))
      (if new-process
          (clim-sys:make-process #'run :name process-name)
          (run)))))

(defmethod esa:find-applicable-command-table ((frame editor))
  (clim:find-command-table 'editor))

(defmethod clim:frame-standard-input ((frame editor))
  (clim:find-pane-named frame 'minibuffer))

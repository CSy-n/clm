
;;;###autoload
(define-minor-mode command-log-mode
  "Toggle keyboard command logging."
  :init-value nil
  :lighter "clm"
  :keymap nil
  (if command-log-mode
      (when (and
             command-log-mode-auto-show
             (not (get-buffer-window clm/command-log-buffer)))
        (clm/open-command-log-buffer))
      ;; We can close the window though
      (clm/close-command-log-buffer)))

(define-global-minor-mode global-command-log-mode command-log-mode
  command-log-mode)



(defun clm/log-command ()
  (let ((inhibit-message t)
    (b (get-buffer-create "*commands*")))
    (with-current-buffer b
      (goto-char (point-max))
      (insert (format "%-16s%s\n"
              (key-description (recent-keys))
              (symbol-name this-command)))
      (let ((w (get-buffer-window b)))
	(if w
	    (set-window-point w (point))
	  nil))
      (clear-this-command-keys))))

(add-hook 'post-command-hook 'clm/log-command)





(provide 'clm)

;;; command-log-mode.el ends here

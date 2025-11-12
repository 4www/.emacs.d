;;; package --- My interface
(message "loading my/interface")

(defun my/menu ()
  "Create a transiant menu for my emacs interface"
  (interactive)
  (my/transient))

(transient-define-prefix my/transient ()
  "My Transient"
  ["Commands" ("m" "message" my/message-from-transient)])

(defun my/message-from-transient ()
  "Just a quick testing function."
  (interactive)
  (message "Hello Transient!"))

(provide 'init)
;;; init.el ends here

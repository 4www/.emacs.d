;;; init.el --- load the literate config -*- lexical-binding: t -*-
(require 'org)
(org-babel-load-file (expand-file-name "readme.org" user-emacs-directory))
(put 'dired-find-alternate-file 'disabled nil)

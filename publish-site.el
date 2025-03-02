;; publish.el --- Publish org-mode project on Gitlab Pages
;; Author: Rasmus

;;; Commentary:
;; This script will convert the org-mode files in this directory into
;; html.

;;; Code:

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-refresh-contents)
(package-install 'org-plus-contrib)
(package-install 'htmlize)

;; load a theme, to inherit some styles (html source blocks?)
(load-theme 'leuven)

;; require org-mode, and org-publish, to export org to html
(require 'org)
(require 'ox-publish)

;; custom variables

(defvar-local ssg-base-path (getenv "SSG_BASE_PATH")
	"emacs-ssg base path for static assets linking")

;; setting to nil, avoids "Author: x" at the bottom
(setq user-full-name nil)

;; preserve indentation in src block (for html export)
(setq org-src-preserve-indentation 1)

(setq org-export-with-section-numbers nil
	    org-export-with-smart-quotes t
	    org-export-with-toc t)

(setq org-html-divs '((preamble "header" "top")
											(content "main" "content")
											(postamble "footer" "postamble"))
	    org-html-head-include-default-style nil
	    org-html-head (format "<link href='%s/styles.css' rel='stylesheet' type='text/css'/>"
									          (if ssg-base-path (format "/%s" ssg-base-path) ""))
	    org-html-head-include-scripts nil
	    org-html-container-element "section"
	    org-html-metadata-timestamp-format "%Y-%m-%d"
	    org-html-checkbox-type 'html
	    org-html-html5-fancy t
	    org-html-validation-link nil
	    org-html-doctype "html5")

(defvar site-attachments
	(regexp-opt '("jpg" "jpeg" "gif" "png" "svg"
								"ico" "cur" "css" "js" "woff" "html" "pdf"))
	"File types that are published as static files.")

(setq org-publish-project-alist
	    (list
		   (list "site-org"
			       :base-directory "."
			       :base-extension "org"
			       :recursive t
			       :publishing-function '(org-html-publish-to-html)
			       :publishing-directory "./public"
			       :auto-sitemap nil
			       :with-autor nil
			       :with-creator nil
			       :with-date nil
			       :section-number nil
			       :time-stamp-file nil
			       )
		   (list "site-static"
			       :base-directory "."
			       :exclude "public/"
			       :recursive t
			       :base-extension site-attachments
			       :publishing-directory "./public"
			       :publishing-function 'org-publish-attachment
			       )
		   (list "site" :components '("site-org"))))

(provide 'publish)
;;; publish.el ends here

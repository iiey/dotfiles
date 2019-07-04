;; -*- mode: elisp -*-

;;load custom junk separately don't litter init file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;;config package.el to include some repositories
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;;add ~/.emacs/lisp to list where emacs can find other .el scripts
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq package-enable-at-startup nil)
(package-initialize)

;;it's likely a fresh installation, if use-package not installed
;;in that case we update package sources and install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;uncomment this line if encounter emacs26+ bug where emacs cannot reach elpa
;(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;;load literate configuration in ~/.emacs.d/config.org
(setq emacs-config-file (expand-file-name "config.org" user-emacs-directory))
(org-babel-load-file emacs-config-file)

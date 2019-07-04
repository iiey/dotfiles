;;;Prepare essential theme for using

;;add loading path where custom themes can be found. E.g. ~/.emacs/themes
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

;;install some favorite themes if not there
(use-package color-theme-sanityinc-tomorrow :ensure t)
(use-package nord-theme :ensure t)
(use-package solarized-theme :ensure t)
(use-package zenburn-theme :ensure t)

(provide 'init-theme)

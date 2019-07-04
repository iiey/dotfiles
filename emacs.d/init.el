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


;;;===========================================================================================================
;;;DEFAULT BEHAVIOUR
;;fullscreen on default. Alternative: fullwidth, fullheight, maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;;highligh current line
(global-hl-line-mode 1)
;;show line number
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
;;hide gui toolbar 'M-x name-bar-mode' to toggle on/off
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
;;do not show startup screen
(setq   inhibit-splash-screen t
        inhibit-startup-message t)
;;coding style C
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)
;;margin to top/bottom page when scrolling
(setq scroll-margin 3)


;;;===========================================================================================================
;;;MAPPING
;;scroll screen up/down by multiline
(global-set-key [(control j)]  (lambda () (interactive) (scroll-up   5)))
(global-set-key [(control k)]  (lambda () (interactive) (scroll-down 5)))
;;resize splits with Alt keys
(global-set-key (kbd "M-<down>") 'enlarge-window)
(global-set-key (kbd "M-<up>") 'shrink-window)
(global-set-key (kbd "M-<left>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<right>") 'shrink-window-horizontally)
(autoload 'View-scroll-half-page-forward "view")
(autoload 'View-scroll-half-page-backward "view")
(global-set-key (kbd "M-u") 'View-scroll-half-page-backward)
(global-set-key (kbd "M-d") 'View-scroll-half-page-forward)
;;neotree
(global-set-key [f2] 'neotree-toggle)
(global-set-key [f4] 'create-tags)


;;;===========================================================================================================
;;;MODES
;;===================================
;;EVIL
(use-package evil
    :ensure t
    :init
    (setq evil-want-C-u-scroll t)                       ;fix scroll up in evil mode
    :config
    (evil-mode 1)

    ;;fix tab: not indent in evil mode
    (setq evil-want-C-i-jump nil)
    ;;fix tab: give back org-mode bad functionality

    (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
    (define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)
    (define-key evil-insert-state-map (kbd "C-e") 'end-of-line)

    (use-package evil-leader
        :ensure t
        :config
        (global-evil-leader-mode)
        ;(evil-define-key 'normal evil-mode-map (kdb "C-a") 'evil-begining-of-line)
        ;(evil-define-key 'normal evil-mode-map (kdb "C-e") 'evil-end-of-line)
        ;;default key as vim '/'
        (evil-leader/set-leader "[")
        (evil-leader/set-key
            "f" 'helm-find-files
            "b" 'helm-buffers-list
            "i" 'helm-imenu
            "k" 'kill-buffer
            "g" 'magit-status
            "x" 'helm-M-x))

    (use-package evil-surround
        :ensure t
        :config
        (global-evil-surround-mode))
)


;;===================================
;;HELM
(use-package helm
    :ensure t
    :config
    ;enable helm-mode
    (helm-mode 1)

    ;after enable autoresize min-/max-height (in %) can be specified
    (helm-autoresize-mode 1)
    (setq   helm-autoresize-max-height              40  ;limit size of helm window
            helm-autoresize-min-height              40  ;set fix size when both enabled
    )

    ;;enable fuzzy helm
    (setq   helm-mode-fuzzy-match                   t
            helm-completion-in-region-fuzzy-match   t
            helm-M-x-fuzzy-match                    t   ;not belong to helm-mode need to set explicitly
            ;helm-candidate-number-limit             50  ;for faster fuzzy set smaller limit. Default 100
            ;helm-split-window-in-side-p             t   ; open buffer inside current window, not occupy other
    )

    ;;split behaviour using C-c o (helm switch other window)
    (setq   split-height-threshold  60  ;split to below if only current frame height at least 60
            split-width-threshold   200 ;split to the right if only current frame width at least 200
    )
)


;;===================================
;;CONFIG LISP
;;install packages for easy working with lisp and scheme syntax
;(use-package paredit :ensure t)
(use-package rainbow-delimiters :ensure t)

;;use hook (same as autocmd in vim) to detect mode
;;define list lispy
(setq lispy-mode-hooks
    '(emacs-lisp-mode-hook
      lisp-mode-hook
      scheme-mode-hook)
)
;;dolist loop through defined list
;;enable above features only on lisp-/scheme-mode
(dolist (hook lispy-mode-hooks)
    (add-hook hook (lambda ()
;        (paredit-mode)
        (rainbow-delimiters-mode)))
)


;;===================================
;;MAGIT
(use-package magit
    :ensure t
    :config
    (global-set-key (kbd "C-x g") 'magit-status)
)


;;===================================
;;NEOTREE
(use-package neotree
    :ensure t
    :config
    ;;fonts files of this package need to be installed into ~/.fonts manually to get it works
    (use-package all-the-icons
        :ensure t
        :config
        (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
    )
)


;;===================================
;;ORG-MODE
(use-package org
    :ensure t
    :config
    (setq org-src-fontify-natively t)
    (setq org-src-window-setup 'current-window)
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

    (use-package org-bullets
        :ensure t
        :init
        (add-hook 'org-mode-hook 'org-bullets-mode))
)


;;===================================
;;THEME
;;ensure favorite themes installed
;;available: tomorrow, solarized, nord, zenburn
(require 'init-theme)
(load-theme 'sanityinc-tomorrow-night t)


;;;===================================
;;OWN FEATURES
;;load own features which previously added into load-path
(require 'create-ctags)
(require 'file-line)


;;TODO write config in Org and load it with Babel

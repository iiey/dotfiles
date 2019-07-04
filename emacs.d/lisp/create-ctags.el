;;;provide function to generate ctags in emacs format under vc root-dir

;;;1. find root directory of current version control project
;;other solution (only for git with magit installed)
;(setq tags-table-list (list (expand-file-name ".tags" (magit-toplevel))))
;;enable builtin version control package
(require 'vc)
;;get root directory using vc
(defun get-root-dir ()
    (let ((backend (vc-deduce-backend)))
        (and backend
            (ignore-errors (vc-call-backend backend 'root default-directory)))
    )
)
;;emacs searchs auto for 'TAGS', if only directory specified
(setq tags-table-list (list (expand-file-name ".TAGS" (get-root-dir))))

;;;2. create function to generate hidden etags in root dir
(defun create-tags ()
    "Create tags file."
    (interactive)
    (shell-command
        (format "cd %s && rm .TAGS >/dev/null 2>&1; \
                 ctags -e -R -f .TAGS . && echo '.TAGS created'" (get-root-dir)))
)

;;;3. bind function to a default key
(global-set-key [f4] 'create-tags)

(provide 'create-ctags)

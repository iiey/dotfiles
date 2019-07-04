;;;allow open filename with syntax: emacs file:line

;;TODO support file[:line[:col]]
(defadvice find-file-noselect (around find-file-noselect-at-line
                                      (filename &optional nowarn rawfile wildcards)
                                      activate)
    "Turn file.ext:num into file.ext and going to the num-th line."
    (save-match-data
        (let* ((matched (string-match "^\\(.*\\):\\([0-9]+\\):?$" filename))
            (line-number (and matched (match-string 2 filename)
                    (string-to-number (match-string 2 filename))))
                (filename (if matched (match-string 1 filename) filename))
                (buffer-name ad-do-it))
            (when line-number
                (with-current-buffer buffer-name
                    (goto-char (point-min))
                    (forward-line (1- line-number))))
        )
    )
)

(provide 'file-line)

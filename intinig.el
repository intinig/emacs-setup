;; My personal configuration on top of emacs-starter-kit

;; sets the default font to menlo
(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Menlo Regular-14"))
(fontify-frame nil)
(push 'fontify-frame after-make-frame-functions)

;; default window size
(setq default-frame-alist '((width . 105) (height . 38) ))

;; remove trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; we go for light color this time
(load-theme 'adwaita)

;; a bit of slime
;; I don't like that it references something that I can't be sure
;; Emacs has by default, but this is currently the best way to have
;; SLIME work seamlessly.
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/local/bin/ccl") ; your Lisp system

;; Yasnippet
(setq yas/snippet-dirs "~/.emacs.d/snippets")
(yas/load-directory yas/snippet-dirs)

;; Apply shell environment to emacs
(require 'cl)
(defun env-line-to-cons (env-line)
  "Convert a string of the form \"VAR=VAL\" to a cons cell containing (\"VAR\" . \"VAL\")."
  (if (string-match "\\([^=]+\\)=\\(.*\\)" env-line)
      (cons (match-string 1 env-line) (match-string 2 env-line))))

(defun interactive-env-alist (&optional shell-cmd env-cmd)
  "Launch /usr/bin/env or the equivalent from a login shell, parsing and returning the
environment as an alist."
  (let ((cmd (concat (or shell-cmd "$SHELL -lc")
                     " "
                     (or env-cmd "/usr/bin/env"))))
    (mapcar 'env-line-to-cons
            (remove-if
             (lambda (str)
               (string-equal str ""))
             (split-string (shell-command-to-string cmd) "[\r\n]")))))

(defun setenv-from-cons (var-val)
  "Set an environment variable from a cons cell containing
two strings, where the car is the variable name and cdr is
the value, e.g. (\"VAR\" . \"VAL\")"
  (setenv (car var-val) (cdr var-val)))

(defun setenv-from-shell-environment (&optional shell-cmd env-cmd)
  "Apply the environment reported by `/usr/bin/env' (or env-cmd)
as launched by `$SHELL -lc' (or shell-cmd) to the current
environment."
  (mapc 'setenv-from-cons (interactive-env-alist shell-cmd env-cmd)))

(setenv-from-shell-environment)
(setq exec-path (split-string (getenv "PATH") path-separator))

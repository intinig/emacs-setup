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

;; Change this to whatever you use. It's necessary on osx not to get
;; errors with M-x dired
(setq insert-directory-program "/usr/local/bin/gls")

;; Comment this if you want to stick to ispell in place of aspell
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra"))

;; Erlang initialization
;; Set the variables to your taste and needs
(setq load-path (cons  "/usr/local/Cellar/erlang/R15B01/lib/erlang/lib/tools-2.6.7/emacs"
                       load-path))
(setq erlang-root-dir "/usr/local/Cellar/erlang/R15B01")
(setq exec-path (cons "/usr/local/Cellar/erlang/R15B01/bin" exec-path))
(require 'erlang-start)

;; Textline behavior for CMD + Enter
(defun textmate-next-line ()
  "Inserts an indented newline after the current line and moves the point to it."
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key (kbd "<s-return>") 'textmate-next-line)

;; Experimental campfire stuff
(add-to-list 'load-path "~/.emacs.d/packages/campfire")
(require 'campfire)
(setq campfire-domains
      '(((domain . "mikamai.campfirenow.com")
         (token . "d2811743406b01292a57d02a7cbfc8dca41f1e96")
         (ssl . t))))


(setq debug-on-error t)

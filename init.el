(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-bindings starter-kit-eshell starter-kit-js starter-kit-lisp  starter-kit-ruby yasnippet yasnippet-bundle)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; io-mode for io language
(add-to-list 'load-path "~/.emacs.d/packages/io-mode")
(require 'io-mode)

;; Yasnippet
(setq yas/snippet-dirs "~/.emacs.d/snippets")
(yas/load-directory yas/snippet-dirs)

;; Bootstrapping ELPA
(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

;;; Bootstrapping el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;;; Package list
(setq packages
      (append
       '(rainbow-delimiters
         paredit
         autopair
         smex
         slime
         find-file-in-project
         auto-complete
         zencoding-mode
         rinari
         rvm
         yaml-mode)))
(el-get 'sync packages)

;;; Slime
(setq inferior-lisp-program "sbcl")

;;; Org Mode
(require 'org-install)
(setq org-export-html-validation-link nil)
(setq org-export-html-postamble nil)
(setq org-export-html-postamble-format
      '(("en" "<p>Created by %c on %d</p>")))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   (scheme . t)))
(define-skeleton org-skeleton "Header for Tangled Scheme" "Title: "
  "#+TITLE:" str "\n"
  "#+AUTHOR: Nathan Burgers\n"
  "#+EMAIL: nateburgers@gmail.com\n"
  "#+BABEL: :session *scheme* :cache yes :results output :exports both :tangle yes\n"
  "-----")

;;; System Configuration
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)
(setq linum-format "%d ")

;;; Modes
(delete-selection-mode t)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(show-paren-mode t)
(column-number-mode t)
(global-linum-mode t)
(paredit-mode t)
(autopair-mode t)
(global-rainbow-delimiters-mode t)
(ido-mode t)
(global-rinari-mode t)

;;; Keyboard Bindings
(global-set-key (kbd "M-o") 'org-skeleton)
(global-set-key (kbd "C-x C-l") 'goto-line)
(global-set-key (kbd "C-x C-g") 'find-file-in-project)
(global-set-key (kbd "C-x C-z") 'magit-status)
(global-set-key (kbd "M-z") 'smex)
(global-set-key (kbd "M-h") 'windmove-left)          
(global-set-key (kbd "M-l") 'windmove-right)        
(global-set-key (kbd "M-k") 'windmove-up)              
(global-set-key (kbd "M-j") 'windmove-down)          

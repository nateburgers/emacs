;;; Declaring Package List
(setq packages
      '(paredit
	autopair
	rainbow-delimiters
	find-file-in-project
	auto-complete
	zencoding-mode
	htmlize
	smex
	clojure-mode
	nrepl
	markdown-mode
	haskell-mode))

;;; Bootstrapping El-Get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/4.stable/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(el-get 'sync packages)

;;; Slime hack
(add-to-list 'load-path "~/.emacs.d/slime")
(require 'slime)
(slime-setup '(slime-fancy slime-banner))

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
  "#+TITLE: " str "\n"
  "#+AUTHOR: Nathan Burgers\n"
  "#+EMAIL: nateburgers@gmail.com\n"
  "#+BABEL: :session *scheme* :cache yes :results output :exports both :tangle yes\n"
  "-----")

;;; Config
(setq make-backup-files nil)
(setq ido-enable-flex-matching t)
(setq inhibit-startup-message t)
(setq auto-save-default nil)
(setq backup-inhibited t)
(setq linum-format "%d ")

;;; Modes
(global-ede-mode t)
(global-rainbow-delimiters-mode t)
(global-auto-revert-mode t)
(global-linum-mode t)
(delete-selection-mode t)
(autopair-mode t)
(ido-mode t)
(menu-bar-mode 0)
(column-number-mode t)
(show-paren-mode t)
(paredit-mode t)

;;; Scheme
(add-to-list 'load-path "/usr/lib/chicken/6/")
(autoload 'chicken-slime "chicken-slime" "Chicken Slime Client" t)

;;; Keybindings
(global-set-key (kbd "M-1") 'org-skeleton)
(global-set-key (kbd "M-j") 'org-insert-heading)
(global-set-key (kbd "M-S-j") 'org-insert-heading-after-current)
(global-set-key (kbd "M-z") 'smex)
(global-set-key (kbd "C-x C-g") 'find-file-in-project)
(global-set-key (kbd "M-p") 'windmove-up)
(global-set-key (kbd "M-n") 'windmove-down)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "M-S-p") 'enlarge-window)
(global-set-key (kbd "M-S-n") 'shrink-window)
(global-set-key (kbd "M-S-h") 'enlarge-window-horizontally)
(global-set-key (kbd "M-S-l") 'shrink-window-horizonatally)

;;; Language Hooks
(add-hook 'scheme-mode-hook (lambda ()
			      (paredit-mode t)
			      (rainbow-delimiters-mode t)))
(add-hook 'clojure-mode-hook (lambda () (paredit-mode t)
			       (rainbow-delimiters-mode t)
			       (pretty-mode t)))
(add-hook 'ruby-mode-hook '(lambda () (autopair-mode +1)
			    (rainbow-delimiters-mode +1)))


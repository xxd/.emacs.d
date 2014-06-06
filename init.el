;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

(setq dotfiles-dir (file-name-directory (or load-file-name (buffer-file-name))))

(add-to-list 'load-path (expand-file-name
                         "lisp" (expand-file-name
                                 "org" (expand-file-name
                                        "src" dotfiles-dir))))
;; Load up Org Mode and Babel
;;(require 'org-install)
(require 'org)
;; load up the main file
(org-babel-load-file (expand-file-name "starter-kit.org" dotfiles-dir))

;;textmate-mode
(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)

;;git-emacs
(add-to-list 'load-path "~/.emacs.d/git-emacs/")
(require 'git-emacs)

;;font size
(set-face-attribute 'default nil :height 130)

;;replace the auto-save files
(setq backup-directory-alist `(("." . "~/.emacs.d/emacs_backup")))

;;Org Mode Setting
(setq org-startup-indented t)

;;设置备份策略
(setq make-backup-files t)    ;;启用备份功能
(setq vc-make-backup-files t)    ;;使用版本控制系统的时候也启用备份功能
(setq version-control t)    ;;启用版本控制，即可以备份多次
(setq kept-old-versions 2)    ;;备份最原始的版本两次，即第一次编辑前的文档，和第二次编
                ;;辑前的文档
(setq kept-new-versions 6)    ;;备份最新的版本6次，理解同上
(setq delete-old-versions t)    ;;删掉不属于以上3种版本的版本
(setq backup-directory-alist '(("." . "~/.saves")));;设置备份文件的路径到~/.saves中
(setq backup-by-copying t)    ;;备份设置方法，直接拷贝

(setq backup-enable-predicate 'ecm-backup-enable-predicate);;设置备份条件
;;关闭匹配下列目录或文件的备份功能
(defun ecm-backup-enable-predicate (filename)
(and (not (string= "/tmp/" (substring filename 0 5)))
(not (string-match "semanticdb" filename))
))

;;Mac meta键的设置
(setq mac-command-modifier 'meta)
(setq mac-control-modifier 'control)
(setq mac-option-modifier 'alt)

;;关闭自动保存模式
;(setq auto-save-mode nil)
;;不生成 #filename# 临时文件
(setq auto-save-default nil)

;;自动的在文件末增加一新行
(setq require-final-newline t)
;;当光标在行尾上下移动的时候，始终保持在行尾。
(setq track-eol t)

;;;Package system
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))

(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-arjen)

;;newlisp
(require 'newlisp-mode)
(add-to-list 'auto-mode-alist '("\\.lsp$" . newlisp-mode))

;;;; Things that might make life easier:

;; Make Emacs' "speedbar" recognize newlisp files
(eval-after-load "speedbar" '(speedbar-add-supported-extension ".lsp"))

;; Another way to use C-x C-e to eval stuff and doesn't jump to next
;; function
(define-key newlisp-mode-map [(control x) (control e)] 'newlisp-evaluate-prev-sexp)

;; I think I got tired of typing 'newlisp-show-interpreter' all the
;; time.
(defun start-newlisp ()
  "Starts newlisp interpreter/or shows if already running.  Requires newlisp-mode to be loaded."
  (interactive)
  (newlisp-show-interpreter))

;;; init.el ends here


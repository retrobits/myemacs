;(custom-set-variables 
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;  '(nxhtml-load t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "SystemWindow" :foreground "SystemWindowText" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :family "Consolas")))))

(put 'dired-find-alternate-file 'disabled nil)
;;(add-to-list 'load-path "~/elisp/ruby")

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq resize-minibuffer-mode t)
;(setq resize-minibuffer-window-max-height 4)

(defun w32-restore-frame ()
    "Restore a minimized frame"
     (interactive)
     (w32-send-sys-command 61728))

(defun w32-maximize-frame ()
    "Maximize the current frame"
     (interactive)
     (w32-send-sys-command 61488))

(setq compilation-scroll-output t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)

(setq scroll-step 1)
(setq scroll-conservatively 5)

;(highlight-current-line-on t)

;(global-set-key [delete] 'delete-char)

;(set-background-color "dark slate gray")
;(set-foreground-color "blanched almond") 

(defalias 'qrr 'query-replace-regexp)
(defalias 'lml 'list-matching-lines)

(add-hook 'window-setup-hook 'w32-maximize-frame t)

;(setq initial-frame-alist
;      `((left . 0) (top . 0)
;        (width . 140) (height . 42)))

(when (eql system-type 'windows-nt) ; Windows
      (when (eq (shell-command "ruby") 0) 
        ; !WARNING! ugly hack because of 1.8.4-20
        ;(setq config-rubyelispdir
    	;  "misc" ) 
        ; get the installation directory
        ;(setq config-rubydir "/cygwin/usr/src/ruby-1.8.6")
    	;  (substring 
    	;   (shell-command-to-string
    	;    "ruby -rrbconfig -e 'puts Config::CONFIG[ \"exec_prefix\"]'") 0 -1)) 
        ; add the emacs lisp directory so emacs acan find it
        (add-to-list 'load-path "/cygwin/usr/src/ruby-1.8.6-1/misc")
	      ;(append
    	;	     (list (expand-file-name 
    		;	   config-rubyelispdir config-rubydir))
    		 ;    load-path))
        ;; define autoloads
        ;; from inf-ruby.el
        (autoload 'ruby-mode "ruby-mode" 
          "Mode for editing ruby source files" t)
        (setq auto-mode-alist
    	  (append '(("\\.rb$" . ruby-mode)
    		    ("[Rr]akefile" . ruby-mode))
    		  auto-mode-alist))
        (setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
    					 interpreter-mode-alist))
        (autoload 'run-ruby "inf-ruby"
          "Run an inferior Ruby process")
        (autoload 'inf-ruby-keys "inf-ruby"
          "Set local key defs for inf-ruby in ruby-mode")
        (add-hook 'ruby-mode-hook
    	      '(lambda ()
    		 (inf-ruby-keys)))))

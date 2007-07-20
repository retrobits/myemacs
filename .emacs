(require 'cl)

;;--------------------------------------------------------------------- 
;; load path
;;---------------------------------------------------------------------

(defvar emacs-root (if (or (eq system-type 'windows-nt))
		     "c:/cygwin/home/dxvern/"
		     "~/")) 

(labels ((add-path (p)
	 (add-to-list 'load-path
		      (concat emacs-root p))))
  (add-path "emacs/mylisp") 
  (add-path "emacs/elisp") 
  (add-path "emacs/misc")
  (add-path "emacs/cedet/common")
  (add-path "emacs/ecb")
  (add-path "emacs/slime")
  (add-path "emacs/color-theme")
 ;(add-path "emacs/calc-2.02f") ;; fix for M-x calc on NT Emacs
 ;(add-path "emacs/site-lisp/nxml-mode") ;; XML support
 ;(add-path "emacs/site-lisp/tuareg-mode-1.41.5") ;; OCaml support
  )

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "SystemWindow" :foreground "SystemWindowText" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :family "Consolas")))))

(put 'dired-find-alternate-file 'disabled nil)
;;(add-to-list 'load-path "~/elisp/ruby")

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

;(setq highlight-current-line-on t)
;(global-set-key [delete] 'delete-char)

(defalias 'qrr 'query-replace-regexp)
(defalias 'lml 'list-matching-lines)

(add-hook 'window-setup-hook 'w32-maximize-frame t)

;;---------------------------------------------------------------------
;; dev tools: cedet, ecb, ruby, slime 
;;---------------------------------------------------------------------

;(load-file 
(load-library "cedet")
(load-library "ecb")

;
; lisp mode (slime)
;
(if (eq system-type 'mac-intel)
    (setq inferior-lisp-program "~/code/osx/acl80_express/alisp") 
  )
(require 'slime)
(slime-setup)

(setq slime-multiprocessing t)
(setq *slime-lisp* "mlisp.exe")
(setq *slime-port* 4006)

(defun slime ()
  (print "this is my slime")
  (interactive)
  (shell-command 
   (format "%s +B +cm -L c:/cygwin/home/dxvern/emacs/misc/slime.lisp -- -p %s --ef %s --sl %s &"
	   *slime-lisp* *slime-port*
	   slime-net-coding-system
	   "c:/cygwin/home/dxvern/emacs/slime/"))
  (delete-other-windows)
  (while (not (ignore-errors (slime-connect "localhost" *slime-port*)))
    (sleep-for 0.2)))

;
; ruby mode
;

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


;;---------------------------------------------------------------------
;; keyboard
;;---------------------------------------------------------------------

(if (eq system-type 'mac-intel)
;;option as meta
    (setq mac-option-modifier 'meta)
  ) 

;; remap M-x to C-x C-m and C-c C-m
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; remap C-w to kill word, remap C-x C-k to kill region 
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;---------------------------------------------------------------------
;; tweaks
;;---------------------------------------------------------------------

(put 'dired-find-alternate-file 'disabled nil) 

;;---------------------------------------------------------------------
;; general appearance: fonts, colors, frame
;;---------------------------------------------------------------------

(if (eq system-type 'mac-intel)
(if (t)
(custom-set-variables 
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right. 
 '(ecb-options-version "2.32")
 '(mac-allow-anti-aliasing t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful. 
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :family "apple-monaco"))))) 
)
)

(require 'color-theme)
(color-theme-initialize)
;(color-theme-subtle-hacker)
(color-theme-sitaramv-solaris)

;; resize frame

(if (eq system-type 'mac-intel)
(setq initial-frame-alist
      `((left . 0) (top . 0)
    (width . 172) (height . 45))) 
)

;; lose the bars...
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; junk

;; w3m stuff
;(setq load-path (cons "/usr/share/emacs/site-lisp/w3m" load-path))
;(setq load-path (cons "~/code/emacs-load" load-path))
;(setq load-path (cons "~/code/emacs-load/g-client" load-path)) 

;(require 'w3m-load)
;(load-library "g")
;(setq g-user-email "dtvernon@gmail.com")
;(setq g-html-handler 'w3m-buffer)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.32")
 '(ecb-wget-setup (quote cons)))

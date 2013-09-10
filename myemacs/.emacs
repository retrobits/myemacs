(require 'cl)

; try to improve slow performance on windows.
(setq w32-get-true-file-attributes nil)

(defvar *darwin* (eql system-type 'darwin))
(defvar *windows-nt* (eql system-type 'windows-nt))

;;--------------------------------------------------------------------- 
;; load path
;;---------------------------------------------------------------------

(defvar emacs-root (if *windows-nt*
		       "c:/Users/dxvern/myemacs/myemacs/emacs"
		     "~/emacs")) 

(labels ((add-path (p)
		   (add-to-list 'load-path
				(concat emacs-root p))))
  (add-path "/mylisp") 
  (add-path "/elisp") 
  (add-path "/misc")
;;  (add-path "/cedet/common")
;;  (add-path "/ecb")
  (add-path "/slime")
  (add-path "/ruby")
  (add-path "/psgml")
  (add-path "/color-theme")
  ;;(add-path "calc-2.02f") ;; fix for M-x calc on NT Emacs
  ;;(add-path "site-lisp/nxml-mode") ;; XML support
  )


;;---------------------------------------------------------------------
;; w3m
;;---------------------------------------------------------------------

(when ()			       ; this is under construction...
  (setq load-path (cons "/usr/share/emacs/site-lisp/w3m" load-path))
  (setq load-path (cons "~/code/emacs-load" load-path))
  (setq load-path (cons "~/code/emacs-load/g-client" load-path)) 

  (require 'w3m-load)
  (load-library "g")
  (setq g-user-email "dtvernon@gmail.com")
  (setq g-html-handler 'w3m-buffer))


;;---------------------------------------------------------------------
;; dev tools: cedet, ecb, slime, ruby 
;;---------------------------------------------------------------------

;;(load-library "cedet")
;;(load-library "ecb")
(require 'psgml)

(require 'ido)
(ido-mode t)

;; lisp mode (slime)
(require 'slime)
(slime-setup)
(when *darwin*
  (setq inferior-lisp-program "~/code/osx/acl80_express/alisp")) ;todo: add to path
(when *windows-nt* 
  (setq slime-multiprocessing t)
  (setq *slime-lisp* "mlisp.exe")
  (setq *slime-port* 4006)
  (defun slime ()
    (print "this is my slime")
    (interactive)
    (shell-command 
     (format "%s +B +cm -L %s/mylisp/slime.lisp -- -p %s --ef %s --sl %s/slime/ &"
	     *slime-lisp*
	     emacs-root
	     *slime-port*
	     slime-net-coding-system
	     emacs-root))
    (delete-other-windows)
    (while (not (ignore-errors (slime-connect "localhost" *slime-port*)))
      (sleep-for 0.2))))


;; powershell-mode

(autoload 'powershell-mode "powershell-mode" "A editing mode for Microsoft PowerShell." t)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode)) ; PowerShell script   


(autoload 'visual-basic-mode "visual-basic-mode"
  "Mode for editing VB source files" t)
  
;; ruby mode

(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
   				     interpreter-mode-alist))

;; set to load inf-ruby and set inf-ruby key definition in ruby-mode.

(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (inf-ruby-keys)
	     ))

;;todo (require 'ruby-electric)

;; (when *windows-nt* ;; Windows
;;   (when (eq (shell-command "ruby") 0) 
;;     ;; !WARNING! ugly hack because of 1.8.4-20
;;     ;;(setq config-rubyelispdir
;;     ;;  "misc" ) 
;;     ;; get the installation directory
;;     ;;(setq config-rubydir "/cygwin/usr/src/ruby-1.8.6")
;;     ;;  (substring 
;;     ;;   (shell-command-to-string
;;     ;;    "ruby -rrbconfig -e 'puts Config::CONFIG[ \"exec_prefix\"]'") 0 -1)) 
;;     ;; add the emacs lisp directory so emacs acan find it
;;     (add-to-list 'load-path "/cygwin/usr/src/ruby-1.8.6-1/misc")
;;     ;;(append
;;     ;;	     (list (expand-file-name 
;;     ;;	   config-rubyelispdir config-rubydir))
;;     ;;    load-path))
;;     ;; define autoloads
;;     ;; from inf-ruby.el
;;     (autoload 'ruby-mode "ruby-mode" 
;;       "Mode for editing ruby source files" t)
;;     (setq auto-mode-alist
;;     	  (append '(("\\.rb$" . ruby-mode)
;;     		    ("[Rr]akefile" . ruby-mode))
;;     		  auto-mode-alist))
;;     (setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
;;     					 interpreter-mode-alist))
;;     (autoload 'run-ruby "inf-ruby"
;;       "Run an inferior Ruby process")
;;     (autoload 'inf-ruby-keys "inf-ruby"
;;       "Set local key defs for inf-ruby in ruby-mode")
;;     (add-hook 'ruby-mode-hook
;;     	      '(lambda ()
;;     		 (inf-ruby-keys)))))

(defun xml-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "xmllint " (buffer-name) t)
	;;(shell-command-on-region (mark) (point) "xmllint --format -" (buffer-name) t)
  )
)

;;---------------------------------------------------------------------
;; cygwin
;;---------------------------------------------------------------------

;;(setenv "PATH" (concat "c:/cygwin/bin;" (getenv "PATH")))
;;(setq exec-path (cons "c:/cygwin/bin/" exec-path))

;;(require 'setup-cygwin)
;;(require 'cygwin-mount)

;; (cygwin-mount-activate)

;; (add-hook 'comint-output-filter-functions
;;     'shell-strip-ctrl-m nil t)
;; (add-hook 'comint-output-filter-functions
;;     'comint-watch-for-password-prompt nil t)
;; (setq explicit-shell-file-name "bash.exe")
;; ;; For subprocesses invoked via the shell
;; ;; (e.g., "shell -c command")
;; (setq shell-file-name explicit-shell-file-name)

;; (Defun cygwin-shell ()
;;   "Run cygwin bash in shell mode."
;;   (interactive)
;;   (let 
;; 	((explicit-shell-file-name "C:/cygwin/bin/bash"))
;; 	(setq binary-process-input t) 
;; 	(setq w32-quote-process-args ?\") 
;; 	(setq explicit-bash-args '("--login" "--noediting" "-i"))
;;     (call-interactively 'shell)))

;;---------------------------------------------------------------------
;; keyboard
;;---------------------------------------------------------------------

;; remap M-x to C-x C-m and C-c C-m
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; remap C-w to kill word, remap C-x C-k to kill region 
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(setq mac-option-modifier 'meta)


;;---------------------------------------------------------------------
;; tweaks
;;---------------------------------------------------------------------

;; not scattered all over the file system!
(defvar backup-dir "~/.backups/")
(setq backup-directory-alist (list (cons "." backup-dir)))
(defvar autosave-dir "~/.autosaves/")
(make-directory autosave-dir t)
(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))
(defun make-auto-save-file-name ()
  (concat autosave-dir
	  (if buffer-file-name
	      (concat "#" (file-name-nondirectory buffer-file-name) "#")
	    (expand-file-name
	     (concat "#%" (buffer-name) "#")))))

(setq resize-minibuffer-mode t)
;;(setq resize-minibuffer-window-max-height 4)

(put 'dired-find-alternate-file 'disabled nil) 

(setq compilation-scroll-output t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)

(setq scroll-step 1)
(setq scroll-conservatively 5)

(defalias 'qrr 'query-replace-regexp)
(defalias 'lml 'list-matching-lines)

;;(global-set-key [delete] 'delete-char)


;;---------------------------------------------------------------------
;; general appearance: fonts, colors, frame
;;---------------------------------------------------------------------

;; resize frame
(when *darwin*
  (setq initial-frame-alist
	`((left . 0) (top . 0)
	  (width . 172) (height . 45))))
(when *windows-nt* 
  (defun w32-restore-frame ()
    "Restore a minimized frame"
    (interactive)
    (w32-send-sys-command 61728))
  (defun w32-maximize-frame ()
    "Maximize the current frame"
    (interactive)
    (w32-send-sys-command 61488))
  (add-hook 'window-setup-hook 'w32-maximize-frame t))

;; lose the bars...
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; desktop saving
;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-save 'if-exists)
(desktop-save-mode 1)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 50)
                (file-name-history        . 100)
                (grep-history             . 50)
                (compile-history          . 50)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))

(require 'color-theme)
(require 'color-theme-sons-of-obsidian)
(require 'color-theme-dawn-night)

(color-theme-initialize)
;;(color-theme-subtle-hacker)
;;(color-theme-sitaramv-solaris)
(color-theme-sons-of-obsidian)
(add-hook 'window-setup-hook #'(lambda () (message "happy hacking!")) t)


;;(global-hl-line-mode 1)
;;(set-face-background 'hl-line "#466")
;;(set-face-foreground 'hl-line "#fff")

(setq-default c-basic-offset 4)
(setq-default tab-width 4)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-cache-directory-contents (quote ((".*" . 500))))
 '(ecb-cache-directory-contents-not nil)
 '(ecb-compile-window-height 6)
 '(ecb-compile-window-temporally-enlarge (quote after-selection))
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-layout-name "left13")
 '(ecb-layou t-window-sizes (quote (("left13" (0.20279720279720279 . 0.9787234042553191)))))
 '(ecb-options-version "2.32")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-path (quote ("~/" "c:/projects" ("c:/projects/pep/Exceed/CommFW/commfw.war/xsl" "xsl"))))
 '(ecb-tip-of-the-day nil)
 '(ecb-vc-supported-backends (quote ((ecb-vc-dir-managed-by-SVN . ecb-vc-state))))
 '(ecb-wget-setup (if *darwin* (quote ("wget" . other)) (quote ("c:/projects/pep/tools/bin/wget.exe" . windows))))
 '(ido-rotate-file-list-default nil)
 '(mac-allow-anti-aliasing t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "Consolas"))))
 '(ido-first-match-face ((t (:foreground "lightblue" :weight bold)))))

;; `(default ((t (:height ,(if *darwin* 120 100) 
;;		:family ,(if *darwin* "apple-monaco" "Consolas")))))


;; start the server
(server-start)






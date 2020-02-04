;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments. TODO: 
(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))


(setq apropos-sort-by-scores t)

(setq custom-file (concat user-emacs-directory "custom.el"))

(setq local-vars-file (concat user-emacs-directory "vars.el"))
(when (file-exists-p local-vars-file)
  (load local-vars-file))
(if (boundp 'df-local-dropbox-path) (setq df-dropbox-path df-local-dropbox-path) (setq df-dropbox-path "~/Dropbox"))

(when (file-exists-p custom-file)
  (load custom-file))

(setq df-default-font
      (cond ((boundp 'df-local-default-font) df-local-default-font)
	    ((eq system-type 'windows-nt) "Consolas-10")
	    ("Fira Mono-10")))

(require 'darcula-theme)
(require 'solarized-theme)
(require 'magit)
(require 'magit-gitflow)
(require 'drag-stuff)
(require 'projectile)
(require 'csharp-mode)
(require 'markdown-mode)
(require 'hl-todo)
(require 'editorconfig)
(require 'web-mode)
(require 'rjsx-mode)
(require 'use-package)
(require 'typescript-mode)
;; (require 'tide)
(require 'company)
(require 'add-node-modules-path)
(require 'deft)
(require 'org-download)
(require 'shader-mode)
(require 'omnisharp)
(require 'ivy)
(require 'counsel-projectile)
;; (require 'helm-company)

(editorconfig-mode t)
(global-hl-line-mode t)
;; (load-theme 'leuven t)
(load-theme 'sanityinc-tomorrow-eighties)

(setq-default fill-column 90)
;; (add-hook 'text-mode-hook (lambda () (hl-todo-mode t)))

;; (add-hook 'after-init-hook (lambda () (load-theme 'leuven)))



(drag-stuff-mode t)
;(drag-stuff-define-keys)


(defun end-of-line-and-indented-new-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key (kbd "<S-return>") 'end-of-line-and-indented-new-line)

;(global-set-key (kbd "C-b") 'ido-switch-buffer)
;(global-set-key (kbd "C-f") 'ido-find-file)
(global-set-key (kbd "M-<down>") 'drag-stuff-down)
(global-set-key (kbd "M-<up>") 'drag-stuff-up)
(global-set-key (kbd "M-/") 'hippie-expand)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )
(global-set-key (kbd "C-c d") 'duplicate-line)	

(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(ido-mode t)
(global-display-line-numbers-mode)
(ido-mode t)
(winner-mode t)
(global-hl-todo-mode t)
;; (global-subword-mode t)
;; (global-superword-mode t)
(electric-pair-mode t)
(setq visible-bell 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen 1)

;; (global-set-key (kbd "M-o") 'other-window)
;; (global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "M-<right>") (lambda () (interactive) (other-window 1)))
(global-set-key (kbd "M-<left>") (lambda () (interactive) (other-window -1)))

(defun kill-whole-word ()
  (interactive)
  (backward-kill-word 1)
  (kill-word 1))

(global-set-key (kbd "C-c w") 'kill-whole-word)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

(global-set-key (kbd "C-<f5>") (lambda () (interactive) (ff-find-other-file 1 1)))
(global-set-key (kbd "C-<f4>") 'ff-find-other-file)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;; HELM
;; TODO: Configure helm
;; (require 'helm-config)
;; (helm-mode 1)

;; (add-hook 'org-mode-hook
;; 	  (lambda () (add-to-list 'helm-completing-read-handlers-alist '(org-set-tags))))
;; (global-set-key [remap execute-extended-command] 'helm-M-x)
;; (global-set-key [remap find-file] 'helm-find-files)
;; (global-set-key [remap occur] 'helm-occur)
;; (global-set-key [remap list-buffers] 'helm-mini)

;; END HELM



;; IVY
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(counsel-projectile-mode)

;; END IVY


;;(split-window-horizontally)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(show-paren-mode 1)

;;(if (eq system-type 'gnu/linux) (setq tide-node-executable "/home/dmbfm/.nvm/versions/node/v12.13.1/bin/node"))
;; (if (eq system-type 'gnu/linux)  (setq exec-path (append exec-path '("/home/dmbfm/.nvm/versions/node/v12.13.1/bin"))))


(add-to-list 'default-frame-alist `(font ., df-default-font))
(set-face-attribute 'default t :font df-default-font)

;; Change to a variable in vars
;; (if (eq system-type 'windows-nt)
;;     (progn
;;       (add-to-list 'default-frame-alist '(font . "Consolas-10" ))
;;       (set-face-attribute 'default t :font "Consolas-10" ))
;;   (progn
;;     (add-to-list 'default-frame-alist '(font . "Fira Mono-10"))
;;     (set-face-attribute 'default t :font "Fira Mono-10")
;;     ))

(setq c-default-style "linux"
      c-basic-offset 4)

(defun my-projectile-run-project (&optional prompt)
  (interactive "P")
  (let ((compilation-read-command
         (or (not (projectile-run-command (projectile-compilation-dir)))
             prompt)))
    (projectile-run-project prompt)))

(global-set-key (kbd "C-c C-d") 'my-projectile-run-project)


;; C-SHARP
(add-hook 'csharp-mode-hook (lambda () (c-set-style "c#")))
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(eval-after-load
 'company
 '(add-to-list 'company-backends 'company-omnisharp))

;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-mode-map (kbd "C-:") 'helm-company)
;;      (define-key company-active-map (kbd "C-:") 'helm-company)))


(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'counsel-company)
     (define-key company-active-map (kbd "C-:") 'counsel-company)))


(add-hook 'csharp-mode-hook #'company-mode)

(setq company-idle-delay nil)

					; (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

;; (use-package tide
;;   :ensure t
;;   :after (typescript-mode company flycheck)
;;   :hook ((typescript-mode . tide-setup)
;;          (typescript-mode . tide-hl-identifier-mode)
;;          (before-save . tide-format-before-save)))


(defun setup-tide-mode ()
  (add-node-modules-path)
  (tide-setup)
;;  (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
  
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; (flycheck-add-next-checker 'typescript-tide '(t . typescript-tslint) 'append)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  ;; (company-mode +1)
  )

(use-package tide
  :hook ((typescript-mode . setup-tide-mode)
	 (before-save . tide-format-before-save)))
  ;; :config
  ;; (add-hook 'before-save-hook #'tide-format-before-save)
  ;; (add-hook 'typescript-mode-hook #'my-setup-tide-mode))


(setq deft-extensions '("org" "txt"))
(setq deft-default-extension "org")
(setq df-deft-notes-dir (concat (file-name-as-directory df-dropbox-path) "notes"))
(setq df-deft-notes-images-dir (concat (file-name-as-directory df-deft-notes-dir) "images"))
(setq deft-directory df-deft-notes-dir)
(global-set-key [f8] 'deft)
(setq deft-use-filename-as-title nil)
(setq deft-use-filter-string-for-filename 1)
(setq deft-file-naming-rules
      '((noslash . "-")
        (nospace . "-")
        (case-fn . downcase)))

(add-hook 'dired-mode-hook 'org-download-enable)

(setq org-download-image-dir df-deft-notes-images-dir)

(global-set-key (kbd "C-c l") 'org-store-link)
(setq org-link-search-must-match-exact-headline nil)


(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))

(global-set-key (kbd "M-]") 'delete-indentation)

(setq org-log-done t)
(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE")
	(sequence "NEXT(n)" "REPORTED(r)" "NEEDS_INVESTIGATION(n)" "IN_PROGRESS(p)" "|" "DONE(d)")))

(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
	("REPORTED" :foreground "orange" :weight bold)
	("NEEDS_INVESTIGATION" :foreground "salmon1" :weight bold)
	("IN_PROGRESS" :foreground "SeaGreen3" :weight bold)
	("DONE" :foreground "DodgerBlue1" :weight bold)
	))

(setq org-blank-before-new-entry '((heading) (plain-list-item)))

(setq org-agenda-files `(,df-deft-notes-dir))

(global-set-key (kbd "C-c m")  'magit)
(global-set-key (kbd "C-c a")  'org-agenda)

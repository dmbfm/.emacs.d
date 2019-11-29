;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments. TODO: 
(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))


(setq apropos-sort-by-scores t)

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

(editorconfig-mode t)
(global-hl-line-mode t)
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


;;(split-window-horizontally)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(show-paren-mode 1)

;;(if (eq system-type 'gnu/linux) (setq tide-node-executable "/home/dmbfm/.nvm/versions/node/v12.13.1/bin/node"))
;; (if (eq system-type 'gnu/linux)  (setq exec-path (append exec-path '("/home/dmbfm/.nvm/versions/node/v12.13.1/bin"))))


(if (eq system-type 'windows-nt)
    (progn
      (add-to-list 'default-frame-alist '(font . "Consolas-10" ))
      (set-face-attribute 'default t :font "Consolas-10" ))
  (progn
    (add-to-list 'default-frame-alist '(font . "Fira Mono-10"))
    (set-face-attribute 'default t :font "Fira Mono-10")
    ))

(setq c-default-style "linux"
      c-basic-offset 4)

(defun my-projectile-run-project (&optional prompt)
  (interactive "P")
  (let ((compilation-read-command
         (or (not (projectile-run-command (projectile-compilation-dir)))
             prompt)))
    (projectile-run-project prompt)))

(global-set-key (kbd "C-c C-d") 'my-projectile-run-project)

(add-hook 'csharp-mode-hook (lambda () (c-set-style "c#")))
;(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
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


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    (quote
;;     ("14f13fee1792f44c448df33e3d3a03ce9adbf1b47da8be490f604ac7ae6659b9" "9271c0ad73ef29af016032376d36e8aed4e89eff17908c0b578c33e54dfa1da1" "41c8c11f649ba2832347fe16fe85cf66dafe5213ff4d659182e25378f9cfc183" default)))
;;  '(package-selected-packages
;;    (quote
;;     (solarized-theme markdown-mode csharp-mode hl-todo projectile expand-region drag-stuff magit-gitflow magit darcula-theme)))
;;  '(safe-local-variable-values
;;    (quote
;;     ((projectile-project-compilation-cmd . "build.bat")
;;      (projectile-enable-caching . t)
;;      (projectile-project-compilation-dir . "")
;;      (projectile-project-name . "handmade-hero")))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "#2B2B2B" :foreground "#a9b7c6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "CTDB" :family "Fira Mono")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (darcula)))
 '(custom-safe-themes
   (quote
    ("85d1dbf2fc0e5d30f236712b831fb24faf6052f3114964fdeadede8e1b329832" "41c8c11f649ba2832347fe16fe85cf66dafe5213ff4d659182e25378f9cfc183" "5dbdb4a71a0e834318ae868143bb4329be492dd04bdf8b398fb103ba1b8c681a" "9271c0ad73ef29af016032376d36e8aed4e89eff17908c0b578c33e54dfa1da1" default)))
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#9876aa" :underline
	  (:style wave :color "yellow"))
     (val :foreground "#9876aa")
     (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (implicitConversion :underline
			 (:color "#808080"))
     (implicitParams :underline
		     (:color "#808080"))
     (operator :foreground "#cc7832")
     (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832")
     (deprecated :strike-through "#a9b7c6"))))
 '(fci-rule-color "#073642")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(hl-sexp-background-color "#efebe9")
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (add-node-modules-path company tide typescript-mode use-package rjsx-mode web-mode editorconfig leuven-theme solarized-theme projectile markdown-mode magit-gitflow hl-todo expand-region drag-stuff darcula-theme csharp-mode)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#ca7966832090")
     (60 . "#c05578c91534")
     (80 . "#b58900")
     (100 . "#a6088eed0000")
     (120 . "#9e3a91a60000")
     (140 . "#9628943b0000")
     (160 . "#8dc596ad0000")
     (180 . "#859900")
     (200 . "#76ef9b6045e8")
     (220 . "#6cd69ca95b9d")
     (240 . "#5f5f9e06701f")
     (260 . "#4c1a9f778424")
     (280 . "#2aa198")
     (300 . "#3002984eaf4d")
     (320 . "#2f6f93e8bae0")
     (340 . "#2c598f79c66f")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

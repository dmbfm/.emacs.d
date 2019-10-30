;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))


(setq apropos-sort-by-scores t)

(require 'darcula-theme)
(require 'magit)
(require 'magit-gitflow)
(require 'drag-stuff)
(require 'projectile)

(require 'hl-todo)
(add-hook 'text-mode-hook (lambda () (hl-todo-mode t)))

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

(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq create-lockfiles nil)


(ido-mode t)
(global-display-line-numbers-mode)
(ido-mode t)
(winner-mode t)
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


(global-set-key (kbd "C-<f5>") (lambda () (interactive) (ff-find-other-file 1 1)))
(global-set-key (kbd "C-<f4>") 'ff-find-other-file)


(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;;(split-window-horizontally)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(when (eq system-type 'windows-nt)
  (add-to-list 'default-frame-alist '(font . "Consolas-10" ))
  (set-face-attribute 'default t :font "Consolas-10" ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (hl-todo projectile expand-region drag-stuff magit-gitflow magit darcula-theme)))
 '(safe-local-variable-values
   (quote
    ((projectile-project-compilation-cmd . "build.bat")
     (projectile-enable-caching . t)
     (projectile-project-compilation-dir . "")
     (projectile-project-name . "handmade-hero")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2B2B2B" :foreground "#a9b7c6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "CTDB" :family "Fira Mono")))))

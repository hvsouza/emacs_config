(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)


(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; to try packages
(use-package try
  :ensure t)

;; to show options after starting typing a command
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Org-mode stuff
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; to show completion for buffers and files
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; make buffer C-x C-b much better
(defalias 'list-buffers 'ibuffer-other-window)

;; allow to undo buffer stuffs... C-c left
(winner-mode 1)

;; counsel for file
(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))

;; ivy for swiper (i dont really know)
(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy)
  )


;; for searching
(use-package swiper
  :ensure try
  :bind (("C-f" . swiper)
	 ("C-r" . swiper)
	 ("C-s" . swiper)
	 ("C-x C-f" . counsel-find-file)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 )
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-alt-done)
    ;; (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    (setq ivy-sort-matches-functions-alist '((t . nil)
                                         (ivy-switch-buffer . ivy-sort-function-buffer)
                                         (counsel-find-file . ivy-sort-function-buffer)))

    ))

  

;; well.. auto-complete
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;; best thing in emacs..
(use-package nyan-mode
  :ensure t
  :init
    (setq nyan-animate-nyancat t)
  :config
  (nyan-mode)
  (nyan-toggle-wavy-trail)
  )


;; flycheck for completion and correction
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))





(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages
   '(nyan-mode auto-complete counsel swiper org-bullets which-key whick-key try zygospore projectile company use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Line numbering
(global-display-line-numbers-mode)
;; (setq display-line-numbers-type 'relative)


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )


(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))

(add-hook 'c++-mode-hook
	  (lambda () (local-set-key (kbd "C-d") #'comment-or-uncomment-region-or-line)))
(global-set-key (kbd "C-d") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-S-d") 'comment-or-uncomment-region-or-line)


(global-set-key (kbd "C-b") 'duplicate-line)

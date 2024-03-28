;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 01 Emacs package management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(material))
 '(custom-safe-themes
   '("db86c52e18460fe10e750759b9077333f9414ed456dc94473f9cf188b197bc74" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(dumb-jump prettier-js lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode zenburn-theme json-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Condensed" :foundry "DAMA" :slant normal :weight regular :height 158 :width normal)))))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(which-key-mode)
(helm-mode)

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package prettier-js
  :ensure t
  :hook (
	  (js-ts-mode . prettier-js-mode)
	  (js2-mode . prettier-js-mode)
	  (web-mode . prettier-js-mode)
	  )
  )

(use-package python-black
  :ensure t
  :after python
  :hook (python-ts-mode . python-black-on-save-mode))

(use-package eglot
  :ensure t
  :hook (
	 (prog-mode . eglot-ensure)
	 (prog-mode . hs-minor-mode)
	 (prog-mode . global-company-mode)
	 (prog-mode . yas-global-mode)
     	 )
  )

(setq python-indent-level 4)
(setq js-indent-level 2)

(use-package helm-xref
  :ensure t
  :bind (
	 ([remap find-file] . helm-find-files)
	 ([remap execute-extended-command] . helm-M-x)
	 ([remap switch-to-buffer] . helm-mini)
	 )
  )

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      create-lockfiles nil) ;; lock files will kill `npm start'


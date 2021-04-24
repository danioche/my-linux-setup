;;
;;   _____     __          _          __      
;;  / ___ \___/ /__ ____  (_)__  ____/ /  ___ 
;; / / _ `/ _  / _ `/ _ \/ / _ \/ __/ _ \/ -_)
;; \ \_,_/\_,_/\_,_/_//_/_/\___/\__/_//_/\__/ 
;;  \___/                                     
;;
;; .emacs file config
;;
;; My mains:
;; - One file to rule them all
;; - Keep it simple, fast and self-documented!
;; - Not need of extra add-on to read this file
;;
;; References:
;;   - [1] I grabbed some configs and tricks from Tecosaur's Doom config and I modified to this
;;         plain config:
;;          -> https://github.com/tecosaur/emacs-config/blob/master/config.org#splash-screen
;;

;; -------------------------------------------------------------------------
;; 0 - General - Custom - EMACS 
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9685cefcb4efd32520b899a34925c476e7920725c8d1f660e7336f37d6d95764" default))
 '(package-selected-packages
   '(magit helm dashboard folding treemacs emojify evil haskell-mode markdown-mode ox-hugo org-bullets org-beautify-theme zenburn-theme org)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 0.1 - Packages configuration
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; 0.2 - User customization
;;
;;
(setq user-full-name "Dani Pedroche"
      user-mail-address "daniel.pedroche@gmail.com")


;; 1.1 - VISUALIZATION - General
;; ----------------------------------------------------------------------

;; Theme
;; (!) You fool! install first this: M-x package-install zenburn-theme
(load-theme 'zenburn t)

;; Transparency
;;
(set-frame-parameter (selected-frame) 'alpha '(95 . 80))
(add-to-list 'default-frame-alist '(alpha . (95 . 80)))

;; Hide menu and initial message
;;
(setq inhibit-startup-message t)
(progn
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (scroll-bar-mode -1))

;; Hide toolbar and menu bar
;;
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Title with full path and file
(setq-default frame-title-format
	      (list '((buffer-file-name " %f"
					(dired-directory
					 dired-directory
					 (revert-buffer-function " %b"
								 ("%b - Dir:  " default-directory)))))))

;; Emoji visualization with emojify :) 
;;  - https://github.com/iqbalansari/emacs-emojify
;;
(add-hook 'after-init-hook #'global-emojify-mode)


;; 1.2 - VISUALIZATION - Editor main functions
;; ----------------------------------------------------------------------


;; Defaults
;; 
(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

;; Cursor color
;;
(set-cursor-color "red")

;; Line numbers
;;
(require 'display-line-numbers)
(defcustom display-line-numbers-exempt-modes '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode)
  "Major modes on which to disable the linum mode, exempts them from global requirement"
  :group 'display-line-numbers
  :type 'list
  :version "green")

(defun display-line-numbers--turn-on ()
  "turn on line numbers but excempting certain majore modes defined in `display-line-numbers-exempt-modes'"
  (if (and
       (not (member major-mode display-line-numbers-exempt-modes))
       (not (minibufferp)))
      (display-line-numbers-mode)))

(global-display-line-numbers-mode)

;; Resaltado de línea y paréntisis
;;
(global-hl-line-mode 1)
(show-paren-mode 1)

;; Treemacs - Project folder navigator
;;  - https://github.com/Alexander-Miller/treemacs
;; (!) Config modified sightly, activate by mode
;;
(setq treemacs-collapse-dirs                 0 ;; set to 0
      treemacs-deferred-git-apply-delay      0.5
      treemacs-directory-name-transformer    #'identity
      treemacs-display-in-side-window        t
      treemacs-eldoc-display                 t
      treemacs-file-event-delay              5000
      ;;treemacs-file-extension-regex          treemacs-last-period-regex-value
      treemacs-file-follow-delay             0.2
      treemacs-file-name-transformer         #'identity
      treemacs-follow-after-init             t
      treemacs-git-command-pipe              ""
      treemacs-goto-tag-strategy             'refetch-index
      treemacs-indentation                   2
      treemacs-indentation-string            " "
      treemacs-is-never-other-window         nil
      treemacs-max-git-entries               5000
      treemacs-missing-project-action        'ask
      treemacs-move-forward-on-expand        nil
      treemacs-no-png-images                 nil
      treemacs-no-delete-other-windows       t
      treemacs-project-follow-cleanup        nil
      treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
      treemacs-position                      'left
      treemacs-read-string-input             'from-child-frame
      treemacs-recenter-distance             0.1
      treemacs-recenter-after-file-follow    nil
      treemacs-recenter-after-tag-follow     nil
      treemacs-recenter-after-project-jump   'always
      treemacs-recenter-after-project-expand 'on-distance
      treemacs-show-cursor                   nil
      treemacs-show-hidden-files             t
      treemacs-silent-filewatch              nil
      treemacs-silent-refresh                nil
      treemacs-sorting                       'alphabetic-asc
      treemacs-space-between-root-nodes      t
      treemacs-tag-follow-cleanup            t
      treemacs-tag-follow-delay              1.5
      treemacs-user-mode-line-format         nil
      treemacs-user-header-line-format       nil
      treemacs-width                         35
      treemacs-workspace-switch-cleanup      nil)

;; Fold
;; - https://www.emacswiki.org/emacs/FoldingMode
(if (require 'folding nil 'noerror)
        (folding-mode-add-find-file-hook)
      (message "Library `folding' not found"))

;; Helm
;; Extended config from:
;;  -> http://tuhdo.github.io/helm-intro.html
;;
(require 'helm)
(require 'helm-config)
(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)
(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)


;; 2.  ORG config
;;
;; 2.0 Languages
;; (!) Haskell => M-x package-install RET haskell-mode

;; 2.1 BABEL

;; Babel languages
;;
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (emacs-lisp . t)
   (python . t)
   ))

;; 2.2 Bullets
;;
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; 2.3 Ox-hugo
;;
(with-eval-after-load 'ox
  (require 'ox-hugo))

;; - Just in case you want your todo list at the beginning
;; (org-agenda nil "t") 

;; 3.0 Start / Home page

;; 3.1 - Dashboard
;; (!) - dashboard package needed
;; -> https://github.com/emacs-dashboard/emacs-dashboard
;;
    (setq dashboard-banner-logo-title "I can't believe today was a good day.")
    (setq dashboard-startup-banner "~/Imágenes/emacsHole.png")
    (setq dashboard-items '((recents  . 3)
                            (bookmarks . 3)
			    ))

    (dashboard-setup-startup-hook)

    (add-to-list 'dashboard-items '(agenda) t)

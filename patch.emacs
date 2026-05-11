--- ./dotfiles/emacs/.emacs	2022-02-26 11:29:15.392041316 +0100
+++ /home/danioche/.emacs	2022-12-10 11:55:54.928115716 +0100
@@ -30,7 +30,7 @@
  '(custom-safe-themes
    '("9685cefcb4efd32520b899a34925c476e7920725c8d1f660e7336f37d6d95764" default))
  '(package-selected-packages
-   '(projectile typescript-mode magit helm dashboard folding treemacs emojify evil haskell-mode markdown-mode ox-hugo org-bullets org-beautify-theme zenburn-theme org)))
+   '(auto-complete gherkin-mode dockerfile-mode docker eink-theme projectile typescript-mode magit helm dashboard folding treemacs emojify evil haskell-mode markdown-mode ox-hugo org-bullets org-beautify-theme zenburn-theme org)))
 (custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
@@ -84,7 +84,6 @@
 (setq user-full-name "Dani Pedroche"
       user-mail-address "daniel.pedroche@gmail.com")
 
-
 ;; 1.1 - VISUALIZATION - General
 ;; ----------------------------------------------------------------------
 
@@ -138,25 +137,6 @@
 ;;
 (set-cursor-color "red")
 
-;; Line numbers with linum
-;; -> reference on different approaches here: https://www.emacswiki.org/emacs/LineNumbers
-(require 'display-line-numbers)
-
-(defcustom display-line-numbers-exempt-modes
-  '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode)
-  "Major modes on which to disable line numbers."
-  :group 'display-line-numbers
-  :type 'list
-  :version "gray")
-
-(defun display-line-numbers--turn-on ()
-  "Turn on line numbers except for certain major modes.
-Exempt major modes are defined in `display-line-numbers-exempt-modes'."
-  (unless (or (minibufferp)
-              (member major-mode display-line-numbers-exempt-modes))
-    (display-line-numbers-mode)))
-
-(global-display-line-numbers-mode)
 
 ;; Resaltado de línea y paréntisis
 ;;
@@ -236,6 +216,26 @@
 
 (helm-mode 1)
 
+;; 1.2.1 Nice Writing font and visual
+;;
+(defun my-nice-writing ()
+   "Sets different font for writing."
+   (interactive)
+   (load-theme 'eink t) 
+   (setq buffer-face-mode-face '(:family "Prociono" :background "#eee" :foreground "#000"))
+   (global-hl-line-mode 0)
+   (show-paren-mode 0)
+   (buffer-face-mode))
+
+(defun rollback-nice-writing ()
+   "Rollback current set for writing."
+   (interactive)
+   (load-theme 'zenburn t)
+   (setq buffer-face-mode-face '(:family "Source Code Pro" :background "#444" :foreground "#fff" ))
+   (global-hl-line-mode 1)
+   (show-paren-mode 1)
+   (buffer-face-mode))
+
 
 ;; 2.  ORG config
 ;;
@@ -253,17 +253,30 @@
    (python . t)
    ))
 
-;; 2.2 Bullets
+;; 2.2 Tangle Conf files
+;; -> https://systemcrafters.cc/emacs-from-scratch/configure-everything-with-org-babel/
+;;
+;; Tangle and config files
+;; 
+(push '("conf-unix" . conf-unix) org-src-lang-modes)
+;; Templates
+;; This is needed as of Org 9.2
+(require 'org-tempo)
+(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
+(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
+(add-to-list 'org-structure-template-alist '("py" . "src python"))
+
+;; 2.3 Bullets
 ;;
 (require 'org-bullets)
 (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
 
-;; 2.3 Ox-hugo
+;; 2.4 Ox-hugo
 ;;
 (with-eval-after-load 'ox
   (require 'ox-hugo))
 
-;; 2.4 Org-crypt
+;; 2.5 Org-crypt
 (require 'org-crypt)
 (org-crypt-use-before-save-magic)
 (setq org-tags-exclude-from-inheritance (quote ("crypt")))
@@ -278,14 +291,14 @@
 ;; (!) - dashboard package needed
 ;; -> https://github.com/emacs-dashboard/emacs-dashboard
 ;;
-    (setq dashboard-banner-logo-title "I can't believe today was a good day.")
-    (setq dashboard-startup-banner "~/Imágenes/art/linuxIsFun.png")
-    (setq dashboard-items '(
-			    (projects . 2)
-			    (recents  . 3)
-                            (bookmarks . 3)
-			    ))
+(setq dashboard-banner-logo-title "I can't believe today was a good day.")
+(setq dashboard-startup-banner "~/Imágenes/art/linuxIsFun.png")
+(setq dashboard-items '(
+			(projects . 2)
+			(recents  . 3)
+                        (bookmarks . 3)
+			))
 
-    (dashboard-setup-startup-hook)
+(dashboard-setup-startup-hook)
 
-    (add-to-list 'dashboard-items '(agenda) t)
+(add-to-list 'dashboard-items '(agenda) t)

--- ./dotfiles/emacs/.emacs	2021-12-29 18:18:07.024308364 +0100
+++ /home/danioche/.emacs	2022-02-23 22:46:39.524152828 +0100
@@ -30,7 +30,7 @@
  '(custom-safe-themes
    '("9685cefcb4efd32520b899a34925c476e7920725c8d1f660e7336f37d6d95764" default))
  '(package-selected-packages
-   '(typescript-mode magit helm dashboard folding treemacs emojify evil haskell-mode markdown-mode ox-hugo org-bullets org-beautify-theme zenburn-theme org)))
+   '(projectile typescript-mode magit helm dashboard folding treemacs emojify evil haskell-mode markdown-mode ox-hugo org-bullets org-beautify-theme zenburn-theme org)))
 (custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
@@ -163,8 +163,6 @@
 (global-hl-line-mode 1)
 (show-paren-mode 1)
 
-
-
 ;; Treemacs - Project folder navigator
 ;;  - https://github.com/Alexander-Miller/treemacs
 ;; (!) Config modified sightly, activate by mode
@@ -211,6 +209,9 @@
       treemacs-width                         35
       treemacs-workspace-switch-cleanup      nil)
 
+;; avoid showing line numbers on treemacs
+(add-hook 'treemacs-mode-hook (lambda() (display-line-numbers-mode -1)))
+
 ;; Fold
 ;; - https://www.emacswiki.org/emacs/FoldingMode
 (if (require 'folding nil 'noerror)
@@ -262,6 +263,15 @@
 (with-eval-after-load 'ox
   (require 'ox-hugo))
 
+;; 2.4 Org-crypt
+(require 'org-crypt)
+(org-crypt-use-before-save-magic)
+(setq org-tags-exclude-from-inheritance (quote ("crypt")))
+;; GPG key to use for encryption
+;; Either the Key ID or set to nil to use symmetric encryption.
+(setq org-crypt-key "845AED494CCA194348E2A473C88416C503929ADB")
+
+
 ;; 3.0 Start / Home page
 
 ;; 3.1 - Dashboard
@@ -270,7 +280,9 @@
 ;;
     (setq dashboard-banner-logo-title "I can't believe today was a good day.")
     (setq dashboard-startup-banner "~/Imágenes/art/linuxIsFun.png")
-    (setq dashboard-items '((recents  . 3)
+    (setq dashboard-items '(
+			    (projects . 2)
+			    (recents  . 3)
                             (bookmarks . 3)
 			    ))
 

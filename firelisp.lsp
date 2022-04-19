; sciezka dostepu do skryptu
(setq PATH_SCRIPT "c:\\firelisp\\")

; includowanie konfiguracji
(load (strcat PATH_SCRIPT "config.lsp"))

; includowanie
(load (strcat PATH_SCRIPT "app\\other.lsp"))

(load (strcat PATH_SCRIPT "app\\app.lsp"))
(load (strcat PATH_SCRIPT "app\\attrib\\main.lsp"))
(load (strcat PATH_SCRIPT "app\\block\\block.lsp"))
(load (strcat PATH_SCRIPT "app\\connect.lsp"))
(load (strcat PATH_SCRIPT "app\\document.lsp"))
(load (strcat PATH_SCRIPT "app\\fire.lsp"))
(load (strcat PATH_SCRIPT "app\\panel.lsp"))
(load (strcat PATH_SCRIPT "app\\layout.lsp"))
(load (strcat PATH_SCRIPT "app\\loop.lsp"))
(load (strcat PATH_SCRIPT "app\\element.lsp"))
(load (strcat PATH_SCRIPT "app\\layer.lsp"))
(load (strcat PATH_SCRIPT "app\\polyline\\polyline.lsp"))
(load (strcat PATH_SCRIPT "app\\border.lsp"))
(load (strcat PATH_SCRIPT "app\\numbering\\numbering.lsp"))
(load (strcat PATH_SCRIPT "app\\logger.lsp"))


(print)
(princ "  88888888b dP  888888ba   88888888b    dP        dP .d88888b   888888ba   ")
(print)
(princ " 88        88  88    `8b  88           88        88 88.    \"'  88    `8b  ")
(print)
(princ "a88aaaa    88 a88aaaa8P' a88aaaa       88        88 `Y88888b. a88aaaa8P'   ")
(print)
(princ " 88        88  88   `8b.  88           88        88       `8b  88          ")
(print)
(princ " 88        88  88     88  88           88        88 d8'   .8P  88    ...loaded      ")
(print)
(princ " dP        dP  dP     dP  88888888P    88888888P dP  Y88888P   dP    version ")
(princ (strcat APP_VERSION " @ " APP_DATE))
(print)

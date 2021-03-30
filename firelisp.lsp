; sciezka dostepu do skryptu
(setq PATH_SCRIPT "c:\\firegrave\\")

; includowanie konfiguracji
(load (strcat PATH_SCRIPT "config.lsp"))

; includowanie
(load (strcat PATH_SCRIPT "app\\app.lsp"))
(load (strcat PATH_SCRIPT "app\\attrib.lsp"))
(load (strcat PATH_SCRIPT "app\\block.lsp"))
(load (strcat PATH_SCRIPT "app\\connect.lsp"))
(load (strcat PATH_SCRIPT "app\\document.lsp"))
(load (strcat PATH_SCRIPT "app\\fire.lsp"))
(load (strcat PATH_SCRIPT "app\\object.lsp"))
(load (strcat PATH_SCRIPT "app\\panel.lsp"))
(load (strcat PATH_SCRIPT "app\\sheet.lsp"))
(load (strcat PATH_SCRIPT "app\\symbol.lsp"))
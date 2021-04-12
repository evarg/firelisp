; sciezka dostepu do skryptu
(setq PATH_SCRIPT "c:\\firelisp\\")

; includowanie konfiguracji
(load (strcat PATH_SCRIPT "config.lsp"))

; includowanie
(load (strcat PATH_SCRIPT "app\\other.lsp"))

(load (strcat PATH_SCRIPT "app\\app.lsp"))
(load (strcat PATH_SCRIPT "app\\attrib.lsp"))
(load (strcat PATH_SCRIPT "app\\block.lsp"))
(load (strcat PATH_SCRIPT "app\\connect.lsp"))
(load (strcat PATH_SCRIPT "app\\document.lsp"))
(load (strcat PATH_SCRIPT "app\\fire.lsp"))
(load (strcat PATH_SCRIPT "app\\object.lsp"))
(load (strcat PATH_SCRIPT "app\\panel.lsp"))
(load (strcat PATH_SCRIPT "app\\layout.lsp"))
(load (strcat PATH_SCRIPT "app\\symbol.lsp"))
(load (strcat PATH_SCRIPT "app\\loop.lsp"))
(load (strcat PATH_SCRIPT "app\\element.lsp"))
(load (strcat PATH_SCRIPT "app\\layer.lsp"))
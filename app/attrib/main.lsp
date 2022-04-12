; =============================================================================
; | Start informations                                                        |
; =============================================================================

(print "Load: attrib")


; =============================================================================
; | Loadings                                                                  |
; =============================================================================

(load (strcat PATH_SCRIPT "app\\attrib\\getters.lsp"))
(load (strcat PATH_SCRIPT "app\\attrib\\setters.lsp"))
(load (strcat PATH_SCRIPT "app\\attrib\\globals.lsp"))


; =============================================================================
; | Constans                                                                  |
; =============================================================================

(setq VIS_ON 0)
(setq VIS_OFF 1)


; =============================================================================
; | Functions                                                                 |
; =============================================================================



  ;
  ; pozycjonowanie atrybutu
  ; location: UL UC UR ML MC MR DL DC DR MLW
  ;

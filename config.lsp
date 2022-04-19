(setq APP_VERSION "v.1.1")
(setq APP_DATE "2022-04-14")

(setq PATH_BLOCK (strcat PATH_SCRIPT "block\\"))
(setq PATH_SYSTEM (strcat PATH_SCRIPT "systems\\"))

; nazwy blokow dla systemu pozarowego
(setq CONF_BLOCK_FIRE "SYSTEM_POZAROWY")
(setq CONF_BLOCK_PANEL "SYSTEM_POZAROWY_CENTRALA")
(setq CONF_BLOCK_LOOP "SYSTEM_POZAROWY_PETLA")

; nazwa arkusza dla ramek z arkuszy wydruku
(setq LAYOUT_BORDER_NAME "WYDRUK")

; nazwa arkusza dla fire
(setq LAYOUT_FIRE_NAME "SP")

; nazwa systemu
(setq FIRE_NAME "")

; lista elementow systemu
(setq FIRE_LIST_OBJECT_S "")
       
; lista elemtow systemu adresowalnych
(setq FIRE_LIST_OBJECT_A "")

; jesli jest T to dla warstwy tworzonej dla petli dodawany jest numer centrali
(setq CONF_PANEL_ADD nil)

; stale do pozycjonowania
(defconstant J_LEFT 0)
(defconstant J_CENTER 1)
(defconstant J_RIGHT 2)
(defconstant J_UP 3)
(defconstant J_MIDDLE 2)
(defconstant J_DOWN 1)

; domyslny atrybut do operacji
(setq CONF_ATTRIB_OPERATION "CENTRALA")

; domyslny atrybut do operacji
(setq CONF_SCALE_DEFAULT 1)

; do pozycjonowania atrybutow
(setq CONF_ATTRIB_POSITION_L -230)
(setq CONF_ATTRIB_POSITION_R 220)
(setq CONF_ATTRIB_POSITION_U 170)
(setq CONF_ATTRIB_POSITION_D -240)
(setq CONF_ATTRIB_POSITION_WZ -100)
(setq CONF_ATTRIB_PAIR_HORIZONTAL 500)
(setq CONF_ATTRIB_PAIR_VERTICAL -500)

; konfiguracja AWEX
(setq LIST_OBJECT_S_AWEX '("AWEX_MUL" "AWEX_OPT" "AWEX_ROP" "AWEX_TERM" "AWEX_022"))
(setq LIST_OBJECT_A_AWEX '("AWEX_MUL" "AWEX_OPT" "AWEX_ROP" "AWEX_TERM" "AWEX_022"))

; konfiguracja BOSCH
(setq LIST_OBJECT_S_BOSCH '("BOSCH_8IR1" "BOSCH_AF" "BOSCH_CON" "BOSCH_DM" "BOSCH_DO" 
                            "BOSCH_DOT" "BOSCH_DT" "BOSCH_I2" "BOSCH_NAC" "BOSCH_RHV" 
                            "BOSCH_RLV1" "BOSCH_RLV8"
                           )
)

(setq LIST_OBJECT_A_BOSCH '("BOSCH_8IR1" "BOSCH_AF" "BOSCH_CON" "BOSCH_DM" "BOSCH_DO" 
                            "BOSCH_DOT" "BOSCH_DT" "BOSCH_I2" "BOSCH_NAC" "BOSCH_RHV" 
                            "BOSCH_RLV1" "BOSCH_RLV8"
                           )
)

; konfiguracja ESSER
(setq LIST_OBJECT_S_ESSER '("ESSER_12R" "ESSER_4G2R" "ESSER_FCT" "ESSER_MCP" 
                            "ESSER_O" "ESSER_O2T" "ESSER_O2TW" "ESSER_OT" "ESSER_TAL" 
                            "ESSER_TD" "ESSER_Wireless"
                           )
)

(setq LIST_OBJECT_A_ESSER '("ESSER_12R" "ESSER_4G2R" "ESSER_FCT" "ESSER_MCP" 
                            "ESSER_O" "ESSER_O2T" "ESSER_OT" "ESSER_TAL" "ESSER_TD" 
                            "ESSER_Wireless"
                           )
)

; konfiguracja EST3
(setq LIST_OBJECT_S_EST3 '("EST3_271" "EST3_CC1" "EST3_CC2" "EST3_CR" "EST3_CT1" 
                           "EST3_CT2" "EST3_H" "EST3_IO" "EST3_IZ" "EST3_PHS" 
                           "EST3_PS"
                          )
)

(setq LIST_OBJECT_A_EST3 '("EST3_271" "EST3_CC1" "EST3_CC2" "EST3_CR" "EST3_CT1" 
                           "EST3_CT2" "EST3_H" "EST3_IO" "EST3_IZ" "EST3_PHS" 
                           "EST3_PS"
                          )
)

; konfiguracja FP2000
(setq LIST_OBJECT_S_FP2000 '("FP2000_AS2363" "FP2000_ICC" "FP2000_IO2014C" 
                             "FP2000_IO2031C" "FP2000_IO2032C" "FP2000_IO2034C" 
                             "FP2000_IU2055C" "FP2000_MUL" "FP2000_OPT" "FP2000_ROP" 
                             "FP2000_TERM"
                            )
)

(setq LIST_OBJECT_A_FP2000 '("FP2000_AS2363" "FP2000_ICC" "FP2000_IO2014C" 
                             "FP2000_IO2031C" "FP2000_IO2032C" "FP2000_IO2034C" 
                             "FP2000_IU2055C" "FP2000_MUL" "FP2000_OPT" "FP2000_ROP" 
                             "FP2000_TERM"
                            )
)

; konfiguracja POLON4000
(setq LIST_OBJECT_S_POLON4000 '("POLON4000_ACR" "POLON4000_DIO" "POLON4000_DOR" 
                                "POLON4000_DOT" "POLON4000_DUR" "POLON4000_EKS" 
                                "POLON4000_EWK" "POLON4000_EWS" "POLON4000_RADIO" 
                                "POLON4000_ROP" "POLON4000_SAL" "POLON4000_TUN" 
                                "POLON4000_UCS"
                               )
)

(setq LIST_OBJECT_A_POLON4000 '("POLON4000_ACR" "POLON4000_DIO" "POLON4000_DOR" 
                                "POLON4000_DOT" "POLON4000_DUR" "POLON4000_EKS" 
                                "POLON4000_EWK" "POLON4000_EWS" "POLON4000_ROP" 
                                "POLON4000_SAL" "POLON4000_TUN" "POLON4000_UCS"
                               )
)

; szerokosc gwiazdek od logowania
(setq LOG_WIDTH 100)

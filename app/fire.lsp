(defun fg:fire:dlg_new (/ nazwaPliku dclID nazwaSystemu) 
  (setq dclID (load_dialog 
                (strcat PATH_SCRIPT "app\\views\\fireNew.dcl")
              )
  )

  (new_dialog "DCLfireNew" dclID)

  (action_tile "bSave" 
               "
                (setq KONF_LISTA_ELEMENTOW (get_tile \"listaElementow\"))
                (setq KONF_LISTA_ELEMENTOW_PETLOWYCH (get_tile \"listaElementowPetlowych\"))
                (setq KONF_NAZWA_SYSTEMU (get_tile \"nazwaSystemu\"))
                (done_dialog 2)
                (pl:UtworzSystemPozarowy KONF_NAZWA_SYSTEMU KONF_LISTA_ELEMENTOW KONF_LISTA_ELEMENTOW_PETLOWYCH)
               "
  )

  (action_tile "bCancel" 
               "
				(done_dialog 1)
			"
  )

  (action_tile "utworzSystemAwex" 
               "
               (set_tile \"listaElementow\" (pl:list2string LISTA_ELEMENTOW_AWEX \";\"))
               (set_tile \"listaElementowPetlowych\" (pl:list2string LISTA_ELEMENTOW_PETLOWYCH_AWEX \";\"))
               (set_tile \"nazwaSystemu\" \"AWEX\")
 			"
  )

  (action_tile "utworzSystemBosch" 
               "
               (set_tile \"listaElementow\" (pl:list2string LISTA_ELEMENTOW_BOSCH \";\"))
               (set_tile \"listaElementowPetlowych\" (pl:list2string LISTA_ELEMENTOW_PETLOWYCH_BOSCH \";\"))
               (set_tile \"nazwaSystemu\" \"BOSCH\")
 			"
  )

  (action_tile "utworzSystemEsser" 
               "
               (set_tile \"listaElementow\" (pl:list2string LISTA_ELEMENTOW_ESSER \";\"))
               (set_tile \"listaElementowPetlowych\" (pl:list2string LISTA_ELEMENTOW_PETLOWYCH_ESSER \";\"))
               (set_tile \"nazwaSystemu\" \"ESSER\")
 			"
  )
  (action_tile "utworzSystemEST3" 
               "
               (set_tile \"listaElementow\" (pl:list2string LISTA_ELEMENTOW_EST3 \";\"))
               (set_tile \"listaElementowPetlowych\" (pl:list2string LISTA_ELEMENTOW_PETLOWYCH_EST3 \";\"))
               (set_tile \"nazwaSystemu\" \"EST3\")
 			"
  )

  (action_tile "utworzSystemFP2000" 
               "
               (set_tile \"listaElementow\" (pl:list2string LISTA_ELEMENTOW_FP2000 \";\"))
               (set_tile \"listaElementowPetlowych\" (pl:list2string LISTA_ELEMENTOW_PETLOWYCH_FP2000 \";\"))
               (set_tile \"nazwaSystemu\" \"FP2000\")
 			"
  )

  (action_tile "utworzSystemPOLON4000" 
               "
               (set_tile \"listaElementow\" (pl:list2string LISTA_ELEMENTOW_POLON4000 \";\"))
               (set_tile \"listaElementowPetlowych\" (pl:list2string LISTA_ELEMENTOW_PETLOWYCH_POLON4000 \";\"))
               (set_tile \"nazwaSystemu\" \"POLON4000\")
 			"
  )


  (start_dialog)
  (unload_dialog dclID)
)




(defun fg:fire:dlg_new2 (/ dclID nastepny blokSP cur_ss) 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "App\\Views\\fireNew.dcl")))

  (setq nastepny 1)
  (setq cur_ss (cadr (ssgetfirst)))

  (print cur_ss)

  ;  (while (not (>= 0 nastepny))
  (new_dialog "DCLfireNew" dclID)
  ;    (setq blokSP (pl:czyZaznaczonyBlokWgNazwy cur_ss "SYSTEM_POZAROWY"))
  ;    (if blokSP
  ;      (progn
  ;        (setq rawSP (pl:string2list (pl:AtrybutWartoscGet blokSP "RAW") ";"))
  ;        (set_tile "spNazwa" (nth 0 rawSP))
  ;        (set_tile "spUUID" (nth 1 rawSP))
  ;
  ;        (print rawSP)
  ;      )
  ;      (PRINT "NIE ZAZNACZONY SP")
  ;    )

  (action_tile "wsp" 
               "
				(setq nastepny 1)
				(done_dialog 2)
        (setq cur_ss (ssget))
			"
  )

  (action_tile "bCancel" 
               "
				(setq nastepny 0)
				(done_dialog 1)
			"
  )

  (action_tile "bSave" 
               "
        (pl:UtworzCentrale (get_tile \"nazwaCentrali\") (get_tile \"numerCentrali\") (get_tile \"spUUID\")))
				(setq nastepny 0)
				(done_dialog 1)
			"
  )

  (start_dialog)
  ;)
  (unload_dialog dclID)
)

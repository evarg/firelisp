dclAtrybutSetup : dialog { 
	label = "Konfiguracja pracy z atrybutami";
 
	: row {
		label = "Domyslny atrybut do operacji";

		:edit_box {
			key = "atrybutDefault";
			label = "Nazwa atrybutu";
			value = "";
			mnemonic = "D";
			edit_limit = 10;
			edit_width = 20;
      fixed_width = false;
		}
  }
	: row {
		label = "Wartosc przesuniecia atrybutu wzgledem srodka bloku";

		:edit_box {
			key = "atrybutPozycjaL";
			label = "Lewo";
			value = "";
			mnemonic = "D";
			edit_limit = 10;
			edit_width = 5;
      fixed_width = false;
		}
		:edit_box {
			key = "atrybutPozycjaR";
			label = "Prawo";
			value = "";
			mnemonic = "D";
			edit_limit = 10;
			edit_width = 5;
      fixed_width = false;
		}
		:edit_box {
			key = "atrybutPozycjaU";
			label = "Gora";
			value = "";
			mnemonic = "D";
			edit_limit = 10;
			edit_width = 5;
      fixed_width = false;
		}
		:edit_box {
			key = "atrybutPozycjaD";
			label = "Dol";
			value = "";
			mnemonic = "D";
			edit_limit = 10;
			edit_width = 5;
      fixed_width = false;
		}
  }
  :row{
    : spacer {
    }
    : button {
      label = "Zapisz"; 
      key = "zapisz";	
      mnemonic = "O";
      alignment = centered; 
      width = 12;
      fixed_width = true;
    }
    : button {
      label = "Anuluj"; 
      key = "anuluj";	
      mnemonic = "O";
      alignment = centered; 
      width = 12;
      fixed_width = true;
    }
    : spacer {
    }
  }

	: row {
		label = "Widocznosc atrybutow";

    :boxed_column{
      label = "CENTRALA";
      :button{
        label = "On"; 
        key = "centralaOn";	
        mnemonic = "O";
        alignment = centered; 
        width = 12;
        fixed_width = true;        
      }
      :button{
        label = "Off"; 
        key = "centralaOff";	
        mnemonic = "O";
        alignment = centered; 
        width = 12;
        fixed_width = true;        
      }
    }

    :boxed_column{
      label = "PLAN";
      :button{
        label = "On"; 
        key = "planOn";	
        mnemonic = "O";
        alignment = centered; 
        width = 12;
        fixed_width = true;        
      }
      :button{
        label = "Off"; 
        key = "planOff";	
        mnemonic = "O";
        alignment = centered; 
        width = 12;
        fixed_width = true;        
      }
    }

    :boxed_column{
      label = "RAW";
      :button{
        label = "On"; 
        key = "rawOn";	
        mnemonic = "O";
        alignment = centered; 
        width = 12;
        fixed_width = true;        
      }
      :button{
        label = "Off"; 
        key = "rawOff";	
        mnemonic = "O";
        alignment = centered; 
        width = 12;
        fixed_width = true;        
      }
    }
  }
}  

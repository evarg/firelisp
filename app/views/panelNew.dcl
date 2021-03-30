dclUtworzCentrale : dialog { 
	label = "Utworz centrale";

	: row {
		label = "Nazwa centrali";

		:edit_box {
			key = "nazwaCentrali";
			value = "";
			edit_limit = 100;
			edit_width = 10;
      fixed_width = true;      
		}
	}
 
	: row {
		label = "Numer centrali";

		:edit_box {
			key = "numerCentrali";
			value = "";
			edit_limit = 4;
			edit_width = 4;
      fixed_width = true;
		}
	}

	: row {
		label = "System pozarowy (NIE ZMIENIAC NIC!!!)";

		:edit_box {
			key = "spNazwa";
			value = "";
			edit_limit = 40;
			edit_width = 20;
      fixed_width = true;
		}
		:edit_box {
			key = "spUUID";
			value = "";
			edit_limit = 40;
			edit_width = 20;
      fixed_width = true;
		}
    : button {
      label = "Wybierz system pozarowy"; 
      key = "wsp";	
      mnemonic = "O";
      alignment = centered; 
      width = 12;
      fixed_width = true;
    }
	}

  :row{
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
  }
 
}
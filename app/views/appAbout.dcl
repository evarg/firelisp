DCL_appAbout : dialog { 
	  label = "About";
    width = 50;

    : text {
	    key = "txt1";
	    value = "FireGrave";
      alignment = centered;
      is_bold = true;
	  }

    : text {
	    key = "txt2";
	    value = "Aplikacja pozwalajaca ulatwic prace podczas";
	  }

    : text {
	    key = "txt3";
	    value = "projektowania i uruchamiania systemow p.poz.";
	  }

    : text {
	    key = "txt4";
	    value = "Autor: Bartosz Grabski bartoszagrabski@gmail.com";
	  }

 		: button {
				label = "Zamknij"; 
				key = "cancel";	
				mnemonic = "O";
				alignment = centered; 
				width = 12;
				is_default = true;
        fixed_width = true;
		}
}
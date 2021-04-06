DCLpanelNew : dialog { 
  label = "Nowa centrala";

  : row {
      label = "Centrala pozarowa";
      : row {
        :edit_box {
          label = "Nazwa centrali";
          key = "ePanelName";
          value = "";
          edit_limit = 100;
          edit_width = 30;
        }
      }
  }

  : row {
    label = "System pozarowy (nic nie zmieniac!!!)";
    : row {
      :edit_box {
        label = "Nazwa systemu";
        key = "eFireName";
        value = "";
        edit_limit = 20;
        edit_width = 20;
      }
      :edit_box {
        label = "System FID";
        key = "eFireFID";
        value = "";
        edit_limit = 20;
        edit_width = 20;
      }
      :edit_box {
        label = "Numer centrali";
        key = "ePanelNumber";
        value = "";
        edit_limit = 20;
        edit_width = 5;
      }
    }
  }
  		
  :row{
    : button {
      label = "Zapisz"; 
      key = "bSave";	
      alignment = centered; 
      width = 12;
      is_default = true;
      fixed_width = true;
            
    }
    : button {
      label = "Anuluj"; 
      key = "bCancel";	
      alignment = centered; 
      width = 12;
      fixed_width = true;
    }
  }
 
	}


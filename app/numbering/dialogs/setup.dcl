DCLnumberingSetup : dialog {
  key = "Title";
  label = "Numerowanie blokow";
  spacer;

  : boxed_row {
    label = "Aktualna wartosc licznika";
    width = 30;
    
    : button {
      label = " - "; 
      key = "bMinus";	
      alignment = centered; 
      width = 8;
    } 
    : edit_box {
      key = "eActualValue";
      value = "";
      edit_limit = 10;
      edit_width = 10;
      alignment = "centered";
      fixed_width = true;
    }
    : button {
      label = " + "; 
      key = "bPlus";	
      alignment = centered; 
      width = 8;
    } 
  }
  : boxed_row {
    label = "Matryca numerowania";
    width = 30;
    : edit_box {
      key = "eMatrix";
      value = "";
      edit_limit = 20;
      edit_width = 27;
      fixed_width = true;
    }
  }
  : boxed_row {
    label = "Konfiguracja";
    width = 30;
    : edit_box {
      key = "eZero";
      label = "zera wiodace";
      value = "";
      edit_limit = 20;
      edit_width = 5;
      fixed_width = true;
    }
    : edit_box {
      key = "eStep";
      label = "krok";
      value = "";
      edit_limit = 20;
      edit_width = 5;
      fixed_width = true;
    }
  }

  : boxed_row {
    label = "Operacja";
    width = 30;
    : button {
      label = "Zapisz"; 
      key = "bSave";	
      alignment = centered; 
      width = 12;
    }  
    : button {
      label = "Rozpocznij"; 
      key = "bStart";	
      alignment = centered; 
      width = 12;
    }  
  }

  spacer;
  :button {
    key="canselobj";
    label="&Anuluj";
    is_default=true;
    is_cancel=true;
    fixed_width=true;
    alignment=centered;
  }
}
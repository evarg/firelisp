DCLattribFontSize : dialog {
  key = "Title";
  label = "Parametry czcionki atrybutow";
  spacer;

  : boxed_row {
    label = "Domyslne atrybuty";
    width = 30;
    : button {
      label = "PLAN"; 
      key = "bDefaultPLAN";	
      alignment = centered; 
      width = 12;
    }  
    : button {
      label = "RAW"; 
      key = "bDefaultRAW";	
      alignment = centered; 
      width = 12;
    }  
    : button {
      label = "CENTRALA"; 
      key = "bDefaultCENTRALA";	
      alignment = centered; 
      width = 12;
    }  
  }
  
  : boxed_row {
    label = "Nazwa atrybutu";
    width = 30;
    : edit_box {
      key = "eAttribName";
      value = "";
      edit_limit = 20;
      edit_width = 20;
      fixed_width = true;
    }
  }
  : boxed_row {
    label = "Parametry czcionki";
    width = 30;
    : edit_box {
      key = "eFontSize";
      label = "wysokosc";
      value = "";
      edit_limit = 20;
      edit_width = 5;
      fixed_width = true;
    }
    : edit_box {
      key = "eFontWeight";
      label = "wspolczynnik";
      value = "";
      edit_limit = 20;
      edit_width = 5;
      fixed_width = true;
    }
    : edit_box {
      key = "eFontAngle";
      label = "kat nachylenia";
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
      label = "Pobierz"; 
      key = "bAttribGet";	
      alignment = centered; 
      width = 12;
    }  
    : button {
      label = "Ustaw"; 
      key = "bAttribSet";	
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
}//MyPickButton
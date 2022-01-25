DCLfireOptions : dialog {
  key = "Title";
  label = "Opcje domyslne";
  spacer;

  : boxed_row {
    label = "Numer centrali";
    width = 30;
    : toggle {
      label = "Dodawanie numeru centrali do czujki i warstwy";
      key = "tPanelNumber";
      value = nil;
      fixed_width = true;
    }
  }

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
    label = "Atrybut dla operacji";
    width = 30;
    : edit_box {
      key = "eAttribName";
      value = "";
      edit_limit = 20;
      edit_width = 20;
      fixed_width = true;
    }
  }

  spacer;
  ok_cancel;
}//MyPickButton
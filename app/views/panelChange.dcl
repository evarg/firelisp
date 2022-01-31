DCLpanelChange : dialog {
  key = "Title";
  label = "Zmien ustawienia centrali";
  spacer;
  : boxed_column {
    label = "Centrala";
    width = 60;
    :row {
      : edit_box {
        label = "Nazwa";
        key = "ePanelName";
        value = "";
        edit_limit = 20;
        edit_width = 20;
        fixed_width = true;
      }
      : edit_box {
        label = "Numer centrali";
        key = "ePanelNumber";
        value = "";
        edit_limit = 20;
        edit_width = 3;
        fixed_width = true;
      }
      : edit_box {
        label = "Numer wyswietlany";
        key = "ePanelNumberView";
        value = "";
        edit_limit = 20;
        edit_width = 3;
        fixed_width = true;
      }
    }
  }
  
  : boxed_row {
    label = "Centrala";
    width = 60;
    fixed_width = true;
    : row {
      : button {
        label = "Wybierz"; 
        key = "BselectPanel";	
        alignment = centered; 
        width = 12;
        is_default = true;
        fixed_width = true;
      }          
    }
    : row {
      : paragraph {
        label = "FID centrali:";
        : text_part {
          key = "tLoopFID";
          label = "";
          width = 30;
        }
      }
    }
  }
  
  spacer;
  ok_cancel;
}
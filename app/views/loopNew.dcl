DCLloopNew : dialog {
  key = "Title";
  label = "Nowa petla";
  spacer;
  : boxed_column {
    label = "Petla";
    width = 60;
    :row {
      : edit_box {
        label = "Nazwa";
        key = "eLoopName";
        value = "";
        edit_limit = 20;
        edit_width = 20;
        fixed_width = true;
      }
      : edit_box {
        label = "Numer petli";
        key = "eLoopNumber";
        value = "";
        edit_limit = 20;
        edit_width = 3;
        fixed_width = true;
      }
    }
    :row {
      : edit_box {
        label = "Numer wyswietlany";
        key = "eLoopNumberView";
        value = "";
        edit_limit = 9;
        edit_width = 9;
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
        label = "Nazwa centrali:";
        : text_part {
          key = "TpanelName";
          label = "";
        }
      }
      : paragraph {
        label = "FID centrali:";
        : text_part {
          key = "TpanelFID";
          label = "";
          width = 30;
        }
      }
    }
  }
  spacer;
  ok_cancel;
}
DCLpanelNew : dialog {
  key = "Title";
  label = "Nowa centrala";
  spacer;
  : boxed_row {
    label = Centrala;
    width = 60;
    : edit_box {
      label = "Nazwa centrali";
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
  
  : boxed_row {
    label = "System pozarowy";
    width = 60;
    fixed_width = true;
    : row {
      : button {
        label = "Wybierz"; 
        key = "bSelectFire";	
        alignment = centered; 
        width = 12;
        is_default = true;
        fixed_width = true;
      }          
    }
    : row {
      : paragraph {
        label = "Nazwa systemu:";
        : text_part {
          key = "tFireName";
          label = "";//Text1$ from lsp file
        }
      }
      : paragraph {
        label = "FID systemu:";
        : text_part {
          key = "tFireFID";
          label = "";//Text2$ from lsp file
          width = 30;
        }
      }
    }
  }
  spacer;
  ok_cancel;
}//MyPickButton
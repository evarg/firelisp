DCLloopNew : dialog {
  key = "Title";
  label = "Nowa petla";
  spacer;
  : boxed_row {
    label = Centrala;
    width = 60;
    : edit_box {
      label = "Nazwa petli";
      key = "EloopName";
      value = "";
      edit_limit = 20;
      edit_width = 20;
      fixed_width = true;
    }
    : edit_box {
      label = "Numer petli";
      key = "EloopNumber";
      value = "";
      edit_limit = 20;
      edit_width = 3;
      fixed_width = true;
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
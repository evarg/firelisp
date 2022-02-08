DCLborderNew : dialog {
  key = "Title";
  label = "Nowy arkusz";
  spacer;
  : boxed_column {
    label = "Nazwa rysunku";
    width = 60;
    : edit_box {
      key = "dclNazwaRysunku";
      value = "";
      edit_limit = 100;
      edit_width = 60;
      fixed_width = true;
    }
  }

  : boxed_column {
    label = "Nazwa arkusza";
    width = 60;
    : edit_box {
      key = "dclNazwaArkusza";
      value = "";
      edit_limit = 100;
      edit_width = 60;
      fixed_width = true;
    }
  }

  : row {
    : boxed_column {
      label = "Skala";
      width = 16;
      : edit_box {
        label = "";
        key = "dclSkala";
        value = "";
        edit_limit = 100;
        edit_width = 14;
        fixed_width = true;
      }
    }
    : boxed_column {
      label = "Numer rysunku";
      width = 10;
      : edit_box {
        label = "";
        key = "dclNumerRysunku";
        value = "";
        edit_limit = 100;
        edit_width = 14;
        fixed_width = true;
      }
    }
  }

  : boxed_column {
    label = "Nazwa ramki";
    width = 60;
    : edit_box {
      key = "dclRamka";
      value = "";
      edit_limit = 100;
      edit_width = 60;
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
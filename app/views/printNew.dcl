DCLprintNew : dialog {
  key = "Title";
  label = "Nowy plan wydruku";
  spacer;
  : boxed_column {
    label = "Projekt";
    width = 60;
    : edit_box {
      label = "Linia 1";
      key = "eProjekt1";
      value = "";
      edit_limit = 100;
      edit_width = 60;
      fixed_width = true;
    }
    : edit_box {
      label = "Linia 2";
      key = "eProjekt2";
      value = "";
      edit_limit = 100;
      edit_width = 60;
      fixed_width = true;
    }
    : edit_box {
      label = "Linia 3";
      key = "eProjekt3";
      value = "";
      edit_limit = 100;
      edit_width = 60;
      fixed_width = true;
    }
    : edit_box {
      label = "Linia 4";
      key = "eProjekt4";
      value = "";
      edit_limit = 100;
      edit_width = 60;
      fixed_width = true;
    }
  }

  : boxed_column {
    label = "Opracowanie";
    width = 60;
    : edit_box {
      label = "Linia 1";
      key = "eOpracowanie1";
      value = "";
      edit_limit = 100;
      edit_width = 60;
      fixed_width = true;
    }
  }

  : row {
    : boxed_column {
      label = "Projektowal";
      width = 30;
      : edit_box {
        label = "";
        key = "eProjektowal1";
        value = "";
        edit_limit = 100;
        edit_width = 40;
        fixed_width = true;
      }
    }
    : boxed_column {
      label = "Uprawnienia";
      width = 10;
      : edit_box {
        label = "";
        key = "eProjektowal1UPR";
        value = "";
        edit_limit = 100;
        edit_width = 20;
        fixed_width = true;
      }
    }
  }

  : row {
    : boxed_column {
      label = "Opracowal";
      width = 30;
      : edit_box {
        label = "";
        key = "eOpracowal1";
        value = "";
        edit_limit = 100;
        edit_width = 40;
        fixed_width = true;
      }
    }
    : boxed_column {
      label = "Uprawnienia";
      width = 10;
      : edit_box {
        label = "";
        key = "eOpracowal1UPR";
        value = "";
        edit_limit = 100;
        edit_width = 20;
        fixed_width = true;
      }
    }
  }

  : row {
    : boxed_column {
      label = "Opracowal";
      width = 30;
      : edit_box {
        label = "";
        key = "eOpracowal2";
        value = "";
        edit_limit = 100;
        edit_width = 40;
        fixed_width = true;
      }
    }
    : boxed_column {
      label = "Uprawnienia";
      width = 10;
      : edit_box {
        label = "";
        key = "eOpracowal2UPR";
        value = "";
        edit_limit = 100;
        edit_width = 20;
        fixed_width = true;
      }
    }
  }

  : row {
    : boxed_column {
      label = "Faza";
      width = 10;
      : edit_box {
        label = "";
        key = "eFaza";
        value = "";
        edit_limit = 100;
        edit_width = 10;
        fixed_width = true;
      }
    }
    : boxed_column {
      label = "Branza";
      width = 10;
      : edit_box {
        label = "";
        key = "eBranza";
        value = "";
        edit_limit = 100;
        edit_width = 20;
        fixed_width = true;
      }
    }
    : boxed_column {
      label = "Data opracowania";
      width = 10;
      : edit_box {
        label = "";
        key = "eData";
        value = "";
        edit_limit = 100;
        edit_width = 25;
        fixed_width = true;
      }
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
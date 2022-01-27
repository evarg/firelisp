DCLblockXChange : dialog { 
  label = "Podmiana blokow";

  :row {
    : boxed_row {
      label = "Blok zrodlowy";
      :edit_box {
        key = "eBlockS";
        value = "";
        edit_limit = 30;
        edit_width = 20;
      }
    }
    : boxed_row {
      label = "Grupa";
      :edit_box {
        key = "eBlockGroupD";
        value = "";
        edit_limit = 30;
        edit_width = 10;
      }
    }
    : boxed_row {
      label = "Blok docelowy";
      :edit_box {
        key = "eBlockD";
        value = "";
        edit_limit = 30;
        edit_width = 20;
      }
    }
  }

  : row {
    :boxed_row {
      alignment = left;
      label = "Skala";
      :edit_box {
        key = "eScale";
        value = "";
        edit_limit = 10;
        edit_width = 10;
      }
    }
    :boxed_row {
      label = "Korekcja X";
      :edit_box {
        key = "eDiffX";
        value = "";
        edit_limit = 10;
        edit_width = 10;
      }
    }
    :boxed_row {
      label = "Korekcja Y";
      :edit_box {
        key = "eDiffY";
        value = "";
        edit_limit = 10;
        edit_width = 10;
      }
    }
    :boxed_row {
      label = "Pozycja";
     	: popup_list {
        key = "pAttribPositionD";
        value = "1";
      }
    }
  }

  :row {
    : boxed_row {
      label = "Atrybut zrodlowy";
      :edit_box {
        key = "eAttribS";
        value = "";
        edit_limit = 30;
        edit_width = 30;
      }
    }
    : boxed_row {
      label = "Atrybut docelowy";
      :edit_box {
        key = "eAttribD";
        value = "";
        edit_limit = 30;
        edit_width = 30;
      }
    }
  }

  spacer;
  ok_cancel;
}
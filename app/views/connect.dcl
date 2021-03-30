dclPolaczCzujki : dialog {
  label = "Polaczenie czujek" ;		//give it a label

  :row {
    :column{
      label = "Czujka lewa";
      width = 20;
      : row {
        : spacer { width = 3; fixed_width = true; }
        : button { label = "UL"; key = "ul1"; width = 3; fixed_width = true; }
        : button { label = "UC"; key = "uc1"; width = 3; fixed_width = true; }
        : button { label = "UR"; key = "ur1"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
      }
      : row {
        : button { label = "LU"; key = "lu1"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
        : button { label = "RU"; key = "ru1"; width = 3; fixed_width = true; }
      }
      : row {
        : button { label = "LC"; key = "lc1"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
        : button { label = "RC"; key = "rc1"; width = 3; fixed_width = true; }
      }
      : row {
        : button { label = "LD"; key = "ld1"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
        : button { label = "RD"; key = "rd1"; width = 3; fixed_width = true; }
      }
      : row {
        : spacer { width = 3; fixed_width = true; }
        : button { label = "DL"; key = "dl1"; width = 3; fixed_width = true; }
        : button { label = "DC"; key = "dc1"; width = 3; fixed_width = true; }
        : button { label = "DR"; key = "dr1"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
      }
    }
    
    :column{
      label = "Czujka lewa";
      width = 20;
      : row {
        : spacer { width = 3; fixed_width = true; }
        : button { label = "UL"; key = "ul2"; width = 3; fixed_width = true; }
        : button { label = "UC"; key = "uc2"; width = 3; fixed_width = true; }
        : button { label = "UR"; key = "ur2"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
      }
      : row {
        : button { label = "LU"; key = "lu2"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
        : button { label = "RU"; key = "ru2"; width = 3; fixed_width = true; }
      }
      : row {
        : button { label = "LC"; key = "lc2"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
        : button { label = "RC"; key = "rc2"; width = 3; fixed_width = true; }
      }
      : row {
        : button { label = "LD"; key = "ld2"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
        : button { label = "RD"; key = "rd2"; width = 3; fixed_width = true; }
      }
      : row {
        : spacer { width = 3; fixed_width = true; }
        : button { label = "DL"; key = "dl2"; width = 3; fixed_width = true; }
        : button { label = "DC"; key = "dc2"; width = 3; fixed_width = true; }
        : button { label = "DR"; key = "dr2"; width = 3; fixed_width = true; }
        : spacer { width = 3; fixed_width = true; }
      }
    }
  }

  ok_cancel ;
}
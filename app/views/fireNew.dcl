DCLfireNew : dialog { 
	  label = "Nowy system pozarowy";
 
	  : column {
    		label = "System pozarowy";
        : row {
          : button {
            label = "AWEX"; 
            key = "bSystemAWEX";	
            alignment = centered; 
            width = 12;
          }
  
          : button {
            label = "BOSCH"; 
            key = "bSystemBOSCH";	
            alignment = centered; 
            width = 12;
          }

          : button {
            label = "ESSER"; 
            key = "bSystemESSER";	
            alignment = centered; 
            width = 12;
          }

          : button {
            label = "EST3"; 
            key = "bSystemEST3";	
            alignment = centered; 
            width = 12;
          }

          : button {
            label = "FP2000"; 
            key = "bSystemFP2000";	
            alignment = centered; 
            width = 12;
          }

          : button {
            label = "POLON4000"; 
            key = "bSystemPOLON4000";	
            alignment = centered; 
            width = 12;
          }
        }
    }

	: row {
		label = "Lista elementow";

		:edit_box {
			key = "eListObjectS";
			value = "";
			edit_limit = 100;
			edit_width = 100;
		}
	}
 
	: row {
		label = "Lista elementow adresowalnych";

		:edit_box {
			key = "eListObjectA";
			value = "";
			edit_limit = 100;
			edit_width = 100;
		}
	}

	: row {
		label = "Nazwa systemu";

		:edit_box {
			key = "eSystemName";
			value = "";
			edit_limit = 100;
			edit_width = 100;
		}
	}
  		
		:row{
 			: button {
				label = "Zapisz"; 
				key = "bSave";	
				alignment = centered; 
				width = 12;
				is_default = true;
        fixed_width = true;
        			
      }
 			: button {
				label = "Anuluj"; 
				key = "bCancel";	
				alignment = centered; 
				width = 12;
        fixed_width = true;
			}
		}
 
	}


}
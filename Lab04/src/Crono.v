`include "freq_div.v"

module Crono (sdcm, SSeg, an);

  
  input [1:0] sdcm;
  output reg [0:6] SSeg;
  output [3:0] an;
  reg [3:0] an_reg;

  assign an = an_reg;

  always @ (*) begin
    
    case(sdcm)
        2'b00: an_reg = 4'b1110; //Segundos (se enciende 1 solo 7seg)
        2'b01: an_reg = 4'b1100; //Decisegundos (se encienden 2 7seg)
        2'b10: an_reg = 4'b1000; //Centisegundos (se encienden 3 7seg)
        2'b11: an_reg = 4'b0000; //Milisegundos (se encienden los 4 7seg )
        default:
        an_reg=4'b1110; //Muestra solo los segundos por default.
    endcase
    


    

  end





endmodule
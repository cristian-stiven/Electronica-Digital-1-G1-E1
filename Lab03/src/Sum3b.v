`include "Sum1b.v"

module sum3b(A, B, Ci, SSeg, an);

input [2:0] A;
input [2:0] B;
input Ci;
wire [3:0] S;  
output reg [0:6] SSeg;
output [3:0] an; 

assign an = 4'b0111;

wire C1;
wire C2;

sum1b sum0(.a(A[0]), .b(B[0]), .ci(1'b0), .s(S[0]), .co(C1));
sum1b sum1(.a(A[1]), .b(B[1]), .ci(C1), .s(S[1]), .co(C2));
sum1b sum2(.a(A[2]), .b(B[2]), .ci(C2), .s(S[2]), .co(S[3]));

always @ ( * ) begin
  case (S)

   // abcdefg
   4'b0000: SSeg = 7'b0000001; // "0"  
	 4'b0001: SSeg = 7'b1001111; // "1" 
	 4'b0010: SSeg = 7'b0010010; // "2" 
	 4'b0011: SSeg = 7'b0000110; // "3" 
	 4'b0100: SSeg = 7'b1001100; // "4" 
	 4'b0101: SSeg = 7'b0100100; // "5" 
	 4'b0110: SSeg = 7'b0100000; // "6" 
	 4'b0111: SSeg = 7'b0001111; // "7" 
	 4'b1000: SSeg = 7'b0000000; // "8"  
	 4'b1001: SSeg = 7'b0000100; // "9" 
   4'ha: SSeg = 7'b0001000;  
   4'hb: SSeg = 7'b1100000;
   4'hc: SSeg = 7'b0110001;
   4'hd: SSeg = 7'b1000010;
   4'he: SSeg = 7'b0110000;
   4'hf: SSeg = 7'b0111000;
    default:
    SSeg = 0;
  endcase
end

endmodule


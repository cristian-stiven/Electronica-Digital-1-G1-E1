module Compuertas(
	input A,
	input B,
	input c,
	
	output S1,
	output S2
	);
	
	assign S1 = A | B;
	assign S2 = -C;
	
endmodule
module Compuertas(
	input A,
	input B,
	input C,
	
	output S1,
	output S2
	);
	
	assign S1 = A | B;
	assign S2 = ~C;
	
endmodule
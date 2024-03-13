module Compuertas(
	
	//declaración de entradas y salids

	input A,
	input B,
	input C,
	
	output S1,
	output S2,
	output S3,
	output S4
	);

	//Compuertas:

	//Compuerta OR:
	
	assign S1 = A | B;
	
	//Compuerta NOT:

	assign S2 = ~C;

	//Compuerta AND:

	assign S3 = A & B;

	//Compuerta XOR:

	assign S4 = A ^ B;
	
endmodule
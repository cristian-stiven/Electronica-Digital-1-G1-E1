//Declaración del módulo de trabajo.

module Compuertas(

	//Declaración de variables
	input A,
	input B,
	input C,
	
	//Declaración de salidas.
	output S1,
	output S2
	);
	
	//Asignación de operaciones a las salidas.
	assign S1 = A | B; // Operación OR.
	assign S2 = ~C; // Operación NOT
	
endmodule
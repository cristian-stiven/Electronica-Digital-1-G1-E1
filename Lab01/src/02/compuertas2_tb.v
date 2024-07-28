//  TESTBENCH

`include "compuertas2.v" //Inclusión del archivo a simular.
`timescale 1ps/1ps  //Declaración de escala de tiempo.


module compuertas2_tb ();
    //Declaración de variables de entrada para las compuertas.

    reg A_tb;
    reg B_tb;
    reg C_tb;

    //Declaración de cables como salidas para las compuertas.
    wire S1_tb;
    wire C0_tb;


    //Instalacion del archivo principal.

    compuertas2 uut(
        .A(A_tb),
        .B(B_tb),
        .C(C_tb),
        .S1(S1_tb),
        .C0(C0_tb)
    );

    //Inicialización de estados por tiempo para las entradas.

    initial begin
        A_tb = 0; 
        B_tb = 0;
        C_tb = 0;
        #100    //100ps de paso de tiempo para cambio de estado.
        A_tb = 0; 
        B_tb = 0;
        C_tb = 1;
        #100    //100ps de paso de tiempo para cambio de estado.
        A_tb = 0; 
        B_tb = 1;
        C_tb = 0;
        #100    //100ps de paso de tiempo para cambio de estado.
        A_tb = 0; 
        B_tb = 1;
        C_tb = 1;
        #100    //100ps de paso de tiempo para cambio de estado.
        A_tb = 1; 
        B_tb = 0;
        C_tb = 0;
        #100    //100ps de paso de tiempo para cambio de estado.
        A_tb = 1; 
        B_tb = 0;
        C_tb = 1;
        #100    //100ps de paso de tiempo para cambio de estado.
        A_tb = 1; 
        B_tb = 1;
        C_tb = 0;
        #100    //100ps de paso de tiempo para cambio de estado.
        A_tb = 1; 
        B_tb = 1;
        C_tb = 1;
    end

    //Salida del archivo '.vcd' y sus parametros para la simulación.
    initial begin
        $dumpfile("compuertas2.vcd");
        $dumpvars(-1, uut);
        #800 $finish;
    end

endmodule
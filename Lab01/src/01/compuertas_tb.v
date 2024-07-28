// TESTBENCH

`include "Compuertas.v" // Inclusión del archivo a simular.
`timescale 1ps/1ps  //Declaración de escala de tiempo.

//Declaración del módulo del testbench
module tb_compuertas();

    //Declaración de las variables para las entradas en el testbench.
    reg A_tb;
    reg B_tb;
    reg C_tb;

    //Declaración de las variables para las salidas en el testbench.
    wire S1_tb;
    wire S2_tb;

    //Declaración de función para relacionar variables con las I/O del módulo 'Compuertas.v'
    Compuertas uut(
        .A(A_tb),
        .B(B_tb),
        .C(C_tb),
        .S1(S1_tb),
        .S2(S2_tb)
    );

    //Declaración de los estados para cada una de las entradas por tiempos
    initial begin
        A_tb = 0;
        B_tb = 0;
        C_tb = 0;

        #100  //100ps de paso de tiempo para cambio de estado. 

        A_tb = 0;
        B_tb = 1;
        C_tb = 1;

        #100  //100ps de paso de tiempo para cambio de estado.

        A_tb = 1;
        B_tb = 0;

        #100 //100ps de paso de tiempo para cambio de estado.

        A_tb = 1;
        B_tb = 1;

    end

    //Declaración de funciones y parámetros de salida: archivo .vcd para simulación. 
    initial begin

        $dumpfile("Compuertas.vcd");
        $dumpvars(-1, uut);
        #500 $finish;
    end

endmodule
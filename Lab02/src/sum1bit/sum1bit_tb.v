// TESTBENCH

`include "sum1bit.v" // Instanciación del archivo a simular.
`timescale 1ps/1ps  //Declaración escala de tiempo.

//Declaración variables de entrada y cables de salida para el sumador.

module sum1bit_tb ();

    reg a_tb;
    reg b_tb;
    reg ci_tb;

    wire s_tb;
    wire co_tb;

    sum1b uut(
        .a(a_tb),
        .b(b_tb),
        .ci(ci_tb),
        .s(s_tb),
        .co(co_tb)

    );

    // Inicialización de estados de entradas por tiempo.

    initial begin

        a_tb = 0;
        b_tb = 0;
        ci_tb = 0;   

        #100    //100ps de paso de tiempo para cambio de estado.

        a_tb = 0;
        b_tb = 1;
        ci_tb = 0;   

        #100    //100ps de paso de tiempo para cambio de estado.

        a_tb = 1;
        b_tb = 0;
        ci_tb = 0;   

        #100    //100ps de paso de tiempo para cambio de estado.

        a_tb = 1;
        b_tb = 1;
        ci_tb = 0;   

        #100    //100ps de paso de tiempo para cambio de estado.

        a_tb = 0;
        b_tb = 0;
        ci_tb = 1;   

        #100    //100ps de paso de tiempo para cambio de estado.

        a_tb = 0;
        b_tb = 1;
        ci_tb = 1;   

        #100    //100ps de paso de tiempo para cambio de estado.

        a_tb = 1;
        b_tb = 0;
        ci_tb = 1;   

        #100    //100ps de paso de tiempo para cambio de estado.

        a_tb = 1;
        b_tb = 1;
        ci_tb = 1;   


    end
        
    //Salida del archivo '.vcd' y sus parametros para la simulación.
    
    initial begin
        $dumpfile("sum1bit.vcd");
        $dumpvars(0, uut);
        #800 $finish;
    end

endmodule
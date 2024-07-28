// TESTBENCH

`include "sum4bit.v" // Instanciación del archivo a simular.
`timescale 1ps/1ps  // Declaración de escala de tiempo.

// Declaración de variables de entrada y cables de salida para el sumador.

module sum4b_tb();

    reg [3:0] A_tb;
    reg [3:0] B_tb;
    reg Ci_tb;

    wire [3:0] S_tb;
    wire Co_tb;

    sum4b uut(
        .A(A_tb),
        .B(B_tb),
        .Ci(Ci_tb),
        .S(S_tb),
        .Co(Co_tb)
    );

    // Inicialización de estados de entradas por tiempo.

    initial begin
        // Combinación 1
        Ci_tb = 0;
        A_tb = 4'b0000;
        B_tb = 4'b0000;
        #100; // Espera de 100ps

        // Combinación 2
        Ci_tb = 0;
        A_tb = 4'b0001;
        B_tb = 4'b0001;
        #100; // Espera de 100ps

        // Combinación 3
        Ci_tb = 0;
        A_tb = 4'b0010;
        B_tb = 4'b0010;
        #100; // Espera de 100ps

        // Combinación 4
        Ci_tb = 1;
        A_tb = 4'b0011;
        B_tb = 4'b0011;
        #100; // Espera de 100ps

        // Combinación 5
        Ci_tb = 1;
        A_tb = 4'b0100;
        B_tb = 4'b0100;
        #100; // Espera de 100ps

        // Combinación 6
        Ci_tb = 0;
        A_tb = 4'b0101;
        B_tb = 4'b0101;
        #100; // Espera de 100ps

        // Combinación 7
        Ci_tb = 0;
        A_tb = 4'b0110;
        B_tb = 4'b0110;
        #100; // Espera de 100ps

        // Combinación 8
        Ci_tb = 1;
        A_tb = 4'b0111;
        B_tb = 4'b0111;
        #100; // Espera de 100ps

        // Combinación 9
        Ci_tb = 1;
        A_tb = 4'b1000;
        B_tb = 4'b1000;
        #100; // Espera de 100ps

        // Combinación 10
        Ci_tb = 0;
        A_tb = 4'b1001;
        B_tb = 4'b1001;
        #100; // Espera de 100ps

        // Combinación 11
        Ci_tb = 0;
        A_tb = 4'b1010;
        B_tb = 4'b1010;
        #100; // Espera de 100ps

        // Combinación 12
        Ci_tb = 1;
        A_tb = 4'b1011;
        B_tb = 4'b1011;
        #100; // Espera de 100ps

        // Combinación 13
        Ci_tb = 1;
        A_tb = 4'b1100;
        B_tb = 4'b1100;
        #100; // Espera de 100ps

        // Combinación 14
        Ci_tb = 0;
        A_tb = 4'b1101;
        B_tb = 4'b1101;
        #100; // Espera de 100ps

        // Combinación 15
        Ci_tb = 0;
        A_tb = 4'b1110;
        B_tb = 4'b1110;
        #100; // Espera de 100ps

        // Combinación 16
        Ci_tb = 1;
        A_tb = 4'b1111;
        B_tb = 4'b1111;
        
    end
        
        /*
        Si necesitaramos mostrar todas las posibles combinaciones sería util usar el siguiente bloque de código en lugar del anterior:
            initial begin
                for (integer i = 0; i < 2; i = i + 1) begin
                    for (integer j = 0; j < 16; j = j + 1) begin
                        for (integer k = 0; k < 16; k = k + 1) begin
                            Ci_tb = i;
                            A_tb = j;
                            B_tb = k;
                            #100; // 100ps de paso de tiempo para cambio de estado.
                            count = count + 1;
                        end
                    end
                end
            end        
        */



    // Salida del archivo '.vcd' y sus parámetros para la simulación.
    
    initial begin
        $dumpfile("sum4b.vcd");
        $dumpvars(0, uut);
        #1600 $finish; // Tiempo total de simulación (16 * 100ps = 1600ps)
    end

endmodule
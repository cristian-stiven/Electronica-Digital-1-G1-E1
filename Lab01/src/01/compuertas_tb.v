`include "Electronica-Digital-1-G1-E1/Lab01/src/01/Compuertas.v"
`timescale 1ps/1ps

module tb_compuertas();

    reg A_tb;
    reg B_tb;
    reg C_tb;

    wire S1_tb;
    wire S2_tb;

    Compuertas uut(
        .A(A_tb),
        .B(B_tb),
        .C(C_tb),
        .S1(S1_tb),
        .S2(S2_tb)
    );

    initial begin
        A_tb = 0;
        B_tb = 0;
        C_tb = 0;

        #100;

        A_tb = 0;
        B_tb = 1;
        C_tb = 1;

        #100;

        A_tb = 1;
        B_tb = 0;

        #100;

        A_tb = 1;
        B_tb = 1;

    end


    initial begin

        $dumpfile("Compuertas.vcd");
        $dumpvars(-1, uut);
        #500 $finish;
    end

endmodule
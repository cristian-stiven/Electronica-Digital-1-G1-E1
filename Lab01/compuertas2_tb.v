`include "compuertas2.v"
`timescale 1ps/1ps


module compuertastwo_tb ();
reg A_tb;
reg B_tb;
reg C_tb;

wire V1_tb;
wire V2_tb;
wire V3_tb;
wire S1_tb;
wire S2_tb;


//Instalacion del archivo principal

compuertas2 uut(
    .A(A_tb),
    .B(B_tb),
    .C(C_tb),
    .S1(S1_tb),
    .S2(S2_tb),
    .V1(V1_tb),
    .V2(V2_tb),
    .V3(V3_tb),
    .V12(V12_tb),
    .V22(V22_tb),
    .V32(V32_tb)
);

initial begin
    A_tb = 0; 
    B_tb = 0;
    C_tb = 0;
    #100;
    A_tb = 0; 
    B_tb = 0;
    C_tb = 1;
    #100;
    A_tb = 0; 
    B_tb = 1;
    C_tb = 0;
    #100;
    A_tb = 0; 
    B_tb = 1;
    C_tb = 1;
    #100;
    A_tb = 1; 
    B_tb = 0;
    C_tb = 0;
    #100;
    A_tb = 1; 
    B_tb = 0;
    C_tb = 1;
    #100;
    A_tb = 1; 
    B_tb = 1;
    C_tb = 0;
    #100;
    A_tb = 1; 
    B_tb = 1;
    C_tb = 1;
    #100;
end

initial begin
    $dumpfile("compuertas2.vcd");
    $dumpvars(-1, uut);
    #800 $finish;
end

endmodule
# **Laboratorio 01**

Aquí se anexan los entregables correspondientes al laboratorio 01

1. Compuertas:
   * código *compuertas.v*:

```verilog

`include "Compuertas.v"
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

```


   * Código *Compuertas_tb.v*:


```verilog

`include "Compuertas.v"
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

```

   * Captura de pantalla de la simulación:

     ![Simulación del código mediante GTKWave](https://github.com/cristian-stiven/Electronica-Digital-1-G1-E1/blob/main/Lab01/imagenes/image_2024-03-10_231959632.png?raw=true))





1. Desarrollo circuito punto 2:
* código *compuertas.v*:

```verilog

module compuertas2(

    //Entradas de las diferentes compuertas y entradas del sistema
    input A,
    input B, 
    input C,
    input V1,
    input V2, 
    input V3,

    //Salidas de las compuertas y del sistema, S2 pertence a Co
    output S1,
    output S2,
    output V12,
    output V22,
    output V32
    );

    //Asiganmos los valores teniendo en cuenta que creamos una igualdad para dos variables
    //representan una salida y una entrada de una compuerta

    assign V12= A ^ B;
    assign V22= A & B ;
    assign S1= V1 ^ C;
    assign V32= V1 & C;
    assign S2= V2 | V3;
    assign V1= V12;
    assign V2= V22;
    assign V3= V32;

endmodule
```


   * Código *Compuertas2_tb.v*:


```verilog

`include "compuertas2.v"
`timescale 1ps/1ps


module compuertastwo_tb ();
reg A_tb;
reg B_tb;
reg C_tb;

// asignamos como un cable a las salidas de las diferentes compuertas 
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
```

   * Captura de pantalla de la simulación:

     ![Simulación compuertas mediante GTKWave](https://github.com/cristian-stiven/Electronica-Digital-1-G1-E1/blob/main/Lab01/imagenes/sumador4.png?raw=true)





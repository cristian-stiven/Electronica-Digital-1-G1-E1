`timescale 1ns / 1ps

// Incluir el módulo Leds
`include "Leds.v"

// Testbench para el módulo Leds
module Leds_tb;

    // Parámetros
    parameter CLK_PERIOD = 20; // Período del reloj en ns (50MHz)

    // Señales de prueba
    reg clk;                     // Señal de reloj
    reg reset;                   // Señal de reset
    reg [2:0] cmd;              // Comando para encender LEDs individuales
    wire [2:0] leds;            // Salida de los LEDs

    // Instanciar el módulo Leds
    Leds leds_inst (
        .clk(clk),
        .reset(reset),
        .cmd(cmd),
        .leds(leds)               // Asegúrate que este nombre coincida con el módulo
    );

    // Generar señal de reloj
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Cambiar el estado del reloj
    end

    // Proceso de prueba
    initial begin
        // Inicializar señales
        reset = 1;       // Activa el reset
        cmd = 3'b000;    // Inicializar comando
        #(CLK_PERIOD);   // Esperar un ciclo de reloj
        reset = 0;       // Desactivar el reset

        // Simulación del control de LEDs
        #(CLK_PERIOD * 5); // Esperar 5 ciclos de reloj

        // Activar comando para encender el LED 1
        cmd = 3'b001;      // Encender LED 1
        #(CLK_PERIOD * 30); // Esperar 30 ciclos de reloj

        // Activar comando para encender el LED 2
        cmd = 3'b010;      // Encender LED 2
        #(CLK_PERIOD * 30); // Esperar 30 ciclos de reloj

        // Activar comando para encender el LED 3
        cmd = 3'b100;      // Encender LED 3
        #(CLK_PERIOD * 30); // Esperar 30 ciclos de reloj

        // Dejar que el temporizador automático opere
        #(CLK_PERIOD * 60); // Esperar para observar el modo automático

        // Finalizar simulación
        $finish;
    end

    // Generar archivo .vcd para GTKWave
    initial begin
        $dumpfile("Leds_tb.vcd"); // Nombre del archivo .vcd
        $dumpvars(0, Leds_tb);     // Registrar todas las variables del testbench
    end
endmodule

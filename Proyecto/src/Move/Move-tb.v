`timescale 1ns / 1ps

// Incluir el módulo de movimiento
`include "Move.v"

// Testbench para el módulo Move
module Move_tb;

    // Señales de prueba
    reg clk;                    // Señal de reloj
    reg reset;                  // Señal de reset
    reg motion_detected;        // Señal de detección de movimiento
    wire buzzer;                // Salida para el buzzer

    // Instanciar el módulo Move
    Move move_inst (
        .clk(clk),
        .reset(reset),
        .motion_detected(motion_detected),
        .buzzer(buzzer)
    );

    // Generar señal de reloj
    initial begin
        clk = 0;
        forever #0.01 clk = ~clk; // Cambiar el estado del reloj cada 10ns (50MHz)
    end

    // Proceso de prueba
    initial begin
        // Inicializar señales
        reset = 1;                  // Activar el reset
        motion_detected = 0;        // No detectar movimiento inicialmente
        #10;                        // Esperar 10 ms
        reset = 0;                  // Desactivar el reset

        // Simulación de detección de movimiento
        #10 motion_detected = 1;    // Activar movimiento
        #100 motion_detected = 0;   // Desactivar movimiento

        // Esperar más para verificar el funcionamiento
        #100 motion_detected = 1;   // Activar movimiento nuevamente
        #50 motion_detected = 0;    // Desactivar movimiento nuevamente
        
        // Finalizar simulación
        #300 $finish;               // Esperar antes de finalizar
    end

    // Generar archivo .vcd para GTKWave
    initial begin
        $dumpfile("Move_tb.vcd");   // Nombre del archivo .vcd
        $dumpvars(0, Move_tb);      // Registrar todas las variables del testbench
    end
endmodule

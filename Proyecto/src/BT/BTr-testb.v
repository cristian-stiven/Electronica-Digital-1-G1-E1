`include "BTr.v"  // Incluir el módulo de recepción BTr
`timescale 1ns / 1ps

// Testbench para el módulo BTr
module BTr_tb;

    // Parámetros
    parameter CLK_PERIOD = 20; // Período del reloj en ns (50MHz)

    // Señales de prueba
    reg clk;                     // Señal de reloj
    reg reset;                   // Señal de reset
    reg rx;                      // Entrada de recepción
    wire [7:0] data_out;        // Datos recibidos
    wire ready;                 // Indica que los datos están listos

    // Instanciar el módulo BTr
    BTr btr_inst (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data_out(data_out),
        .ready(ready)
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
        rx = 1;          // Mantener rx en alto inicialmente
        #(CLK_PERIOD);   // Esperar un ciclo de reloj
        reset = 0;       // Desactivar el reset

        // Esperar hasta que el módulo esté listo
        #(CLK_PERIOD * 10); // Esperar 10 ciclos de reloj

        // Simulación de recepción de un byte
        // Enviando el byte 0b10101010 (0xAA) a través de rx
        rx = 0;          // Bit de inicio
        #(CLK_PERIOD * 16); // Esperar 16 ciclos de reloj
        rx = 0;          // Bit 0
        #(CLK_PERIOD);   // Esperar 1 ciclo de reloj
        rx = 1;          // Bit 1
        #(CLK_PERIOD);   // Esperar 1 ciclo de reloj
        rx = 0;          // Bit 2
        #(CLK_PERIOD);   // Esperar 1 ciclo de reloj
        rx = 1;          // Bit 3
        #(CLK_PERIOD);   // Esperar 1 ciclo de reloj
        rx = 0;          // Bit 4
        #(CLK_PERIOD);   // Esperar 1 ciclo de reloj
        rx = 1;          // Bit 5
        #(CLK_PERIOD);   // Esperar 1 ciclo de reloj
        rx = 0;          // Bit 6
        #(CLK_PERIOD);   // Esperar 1 ciclo de reloj
        rx = 1;          // Bit 7
        #(CLK_PERIOD);   // Esperar 1 ciclo de reloj
        rx = 1;          // Bit de parada

        // Esperar un poco para verificar la salida
        #(CLK_PERIOD * 20); // Esperar 20 ciclos de reloj

        // Verificar datos recibidos
        if (data_out == 8'hAA && ready) begin
            $display("Datos recibidos correctamente: %b", data_out);
        end else begin
            $display("Error en la recepción de datos.");
        end

        // Finalizar simulación
        $finish;
    end

    // Generar archivo .vcd para GTKWave
    initial begin
        $dumpfile("BTr_tb.vcd"); // Nombre del archivo .vcd
        $dumpvars(0, BTr_tb);     // Registrar todas las variables del testbench
    end
endmodule


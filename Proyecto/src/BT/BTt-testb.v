`timescale 1ns / 1ps

// Incluir el módulo de transmisión
`include "BTt.v"

// Testbench para el módulo BTt
module BTt_tb;

    // Parámetros
    parameter CLK_PERIOD = 20; // Período del reloj en ns (50MHz)

    // Señales de prueba
    reg clk;                     // Señal de reloj
    reg reset;                   // Señal de reset
    reg [7:0] data_in;          // Datos a enviar
    reg send;                   // Señal para iniciar el envío
    wire tx;                    // Salida de transmisión
    wire busy;                  // Indica que el módulo está ocupado

    // Instanciar el módulo BTt
    BTt btt_inst (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .send(send),
        .tx(tx),
        .busy(busy)
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
        send = 0;        // No enviar inicialmente
        data_in = 8'b0;  // Inicializar data_in
        #(CLK_PERIOD);   // Esperar un ciclo de reloj
        reset = 0;       // Desactivar el reset

        // Esperar hasta que el módulo esté listo
        #(CLK_PERIOD * 10); // Esperar 10 ciclos de reloj

        // Simulación de envío de un byte
        data_in = 8'b10101010; // Cargar datos a enviar
        send = 1;              // Activar señal de envío
        #(CLK_PERIOD);         // Esperar un ciclo de reloj
        send = 0;              // Desactivar señal de envío

        // Esperar hasta que la transmisión esté completa
        while (busy) begin
            #(CLK_PERIOD); // Esperar un ciclo de reloj
        end

        // Esperar un poco para verificar la salida
        #(CLK_PERIOD * 20); // Esperar 20 ciclos de reloj

        // Verificar la salida
        if (tx == 1) begin
            $display("Transmisión completa, tx en alto.");
        end else begin
            $display("Error en la transmisión, tx en bajo.");
        end

        // Finalizar simulación
        $finish;
    end

    // Generar archivo .vcd para GTKWave
    initial begin
        $dumpfile("BTt_tb.vcd"); // Nombre del archivo .vcd
        $dumpvars(0, BTt_tb);     // Registrar todas las variables del testbench
    end
endmodule

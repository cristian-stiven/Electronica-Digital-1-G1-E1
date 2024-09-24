`timescale 1ns / 1ps

// Módulo para detectar movimiento y activar un buzzer
module Move (
    input wire clk,              // Reloj del sistema
    input wire reset,            // Señal de reset asíncrono
    input wire motion_sensor,     // Señal del sensor de movimiento
    output reg buzzer            // Salida para el buzzer
);

    // Parámetros
    parameter CLK_FREQ = 50000000; // Frecuencia del reloj en Hz
    localparam DEBOUNCE_TIME = (20e-3 * CLK_FREQ); // Tiempo de debounce en ciclos (20 ms)

    reg [31:0] debounce_counter;   // Contador para el debounce
    reg motion_detected;            // Señal para indicar si se detectó movimiento

    // Proceso principal del módulo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            buzzer <= 0;            // Apagar el buzzer en reset
            debounce_counter <= 0;  // Reiniciar contador
            motion_detected <= 0;   // No hay movimiento detectado
        end else begin
            // Lógica para detectar movimiento
            if (motion_sensor) begin
                if (debounce_counter < DEBOUNCE_TIME - 1) begin
                    debounce_counter <= debounce_counter + 1; // Incrementar contador
                end else begin
                    motion_detected <= 1;   // Movimiento detectado
                end
            end else begin
                debounce_counter <= 0;     // Reiniciar contador si no hay movimiento
                motion_detected <= 0;      // No hay movimiento
            end
            
            // Control del buzzer
            if (motion_detected) begin
                buzzer <= 1;              // Activar buzzer si hay movimiento
            end else begin
                buzzer <= 0;              // Desactivar buzzer si no hay movimiento
            end
        end
    end
endmodule

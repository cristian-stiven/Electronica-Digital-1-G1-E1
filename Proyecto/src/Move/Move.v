`timescale 1ns / 1ps

// Módulo para el sensor de movimiento
module Move (
    input wire clk,               // Reloj del sistema
    input wire reset,             // Señal de reset asíncrono
    input wire motion_detected,   // Señal de detección de movimiento
    output reg buzzer             // Salida para el buzzer
);

    // Parámetros
    parameter DEBOUNCE_TIME = 2500; // 50 ms en ciclos de reloj (suponiendo 50MHz)
    
    reg [11:0] debounce_counter; // Contador para el debounce (12 bits son suficientes para contar hasta 4095)
    reg motion_state;            // Estado del movimiento detectado

    // Proceso principal del módulo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            buzzer <= 0;           // Apagar el buzzer en reset
            debounce_counter <= 0; // Reiniciar contador
            motion_state <= 0;     // Inicializar estado de movimiento
        end else begin
            // Verificar si hay detección de movimiento
            if (motion_detected) begin
                if (debounce_counter < DEBOUNCE_TIME) begin
                    debounce_counter <= debounce_counter + 1; // Incrementar contador
                end else begin
                    motion_state <= 1; // Confirmar movimiento detectado
                end
            end else begin
                debounce_counter <= 0; // Reiniciar contador si no hay movimiento
                motion_state <= 0;      // No hay movimiento detectado
            end

            // Activar el buzzer según el estado del movimiento
            buzzer <= motion_state;
        end
    end
endmodule

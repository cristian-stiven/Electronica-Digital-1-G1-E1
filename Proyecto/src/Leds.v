// Módulo para controlar LEDs
module Leds (
    input wire clk,              // Reloj del sistema
    input wire reset,            // Señal de reset asíncrono
    input wire [2:0] cmd,        // Comando para encender LEDs individuales
    output reg [2:0] leds        // Salida para los LEDs
);

    // Parámetros
    parameter CLK_FREQ = 50000000; // Frecuencia del reloj en Hz
    parameter LED_TOGGLE_TIME = 30; // Tiempo en segundos para cambiar el estado de los LEDs
    localparam COUNT_MAX = CLK_FREQ * LED_TOGGLE_TIME; // Contador para 30 segundos

    reg [31:0] counter;           // Contador para medir el tiempo
    reg toggle;                   // Señal para indicar el cambio de estado

    // Proceso principal del módulo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            leds <= 3'b000;         // Apagar todos los LEDs en reset
            counter <= 0;           // Reiniciar contador
            toggle <= 0;            // Inicializar señal de toggle
        end else begin
            // Contador para el tiempo de togglear LEDs
            if (counter < COUNT_MAX - 1) begin
                counter <= counter + 1; // Incrementar contador
            end else begin
                counter <= 0;           // Reiniciar contador
                toggle <= ~toggle;      // Invertir la señal de toggle
            end
            
            // Lógica para controlar el estado de los LEDs
            if (toggle) begin
                leds <= 3'b111;         // Encender todos los LEDs
            end else begin
                leds <= 3'b000;         // Apagar todos los LEDs
            end
            
            // Control de LEDs individuales
            if (cmd) begin
                leds <= cmd;            // Encender LEDs individuales según el comando
            end
        end
    end
endmodule

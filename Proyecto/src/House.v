`timescale 1ns / 1ps

// Módulo principal de la casa
module House (
    input wire clk,                // Reloj del sistema
    input wire reset,              // Señal de reset asíncrono
    input wire rx,                 // Entrada de recepción (UART)
    output wire tx,                // Salida de transmisión
    input wire motion_detected,    // Señal de detección de movimiento
    input wire TopeA,              // Tope superior
    input wire TopeB,              // Tope inferior

    output reg motor_up,           // Controla el motor hacia arriba
    output reg motor_down,         // Controla el motor hacia abajo
    output reg buzzer,             // Activa el buzzer
    output reg led1,               // Controla el LED 1
    output reg led2,               // Controla el LED 2
    output reg led3                // Controla el LED 3
);

    reg [7:0] data_out;            // Datos a enviar desde House.v
    wire ready;                    // Indica que los datos están listos
    wire [7:0] data_in;            // Datos recibidos desde el módulo BTr
    wire busy;                     // Indica que el módulo de transmisión está ocupado
    wire TopeA_S;                  // Señal de tope superior 
    wire TopeB_S;                  // Señal de tope inferior
    reg [1:0] motor_cmd;           // Comando para el motor
    reg [2:0] led_cmd;             // Comando para LEDs
    wire [2:0] leds;               // Salida para LEDs

    // Módulo de recepción Bluetooth
    BTr receiver (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data_out(data_in),        // Conexión a data_in 
        .ready(ready)
    );

    // Módulo de transmisión Bluetooth
    BTt transmitter (
        .clk(clk),
        .reset(reset),
        .data_in(data_out),        // Conexión a data_out
        .send(ready),              // Enviar cuando los datos estén listos
        .tx(tx),
        .busy(busy)
    );

    // Módulo de control de LEDs
    Leds led_controller (
        .clk(clk),
        .reset(reset),
        .cmd(led_cmd),             // Comando para los LEDs
        .leds(leds)                // Salida para los LEDs
    );

    // Módulo de control de motor
    Motor motor_controller (
        .clk(clk),
        .reset(reset),
        .cmd(motor_cmd),           // Comando recibido desde la lógica
        .TopeA(TopeA),             // Conexión directa a los topes
        .TopeB(TopeB),             // Conexión directa a los topes
        .TopeA_S(TopeA_S),         // Estado del tope superior
        .TopeB_S(TopeB_S)          // Estado del tope inferior
    );

    // Módulo de detección de movimiento
    Move motion_detector (
        .clk(clk),
        .reset(reset),
        .motion_detected(motion_detected) // Señal de detección de movimiento
    );

    // Lógica para determinar el comando del motor y LEDs basado en data_in
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            motor_cmd <= 2'b00; // Reiniciar comando del motor
            led_cmd <= 3'b000;   // Reiniciar comando de LEDs
            motor_up <= 1'b0;     // Reiniciar motor up
            motor_down <= 1'b0;   // Reiniciar motor down
            buzzer <= 1'b0;       // Reiniciar buzzer
            led1 <= 1'b0;         // Reiniciar LED 1
            led2 <= 1'b0;         // Reiniciar LED 2
            led3 <= 1'b0;         // Reiniciar LED 3
        end else begin
            // Determinar el comando para el motor
            motor_cmd <= data_in[1:0]; // Asignación directa de los bits menos significativos

            // Determinar el comando para los LEDs
            led_cmd <= data_in[7:5]; // Asignación directa de los bits más significativos

            // Actualizar las salidas del motor
            motor_up <= (motor_cmd == 2'b01);   // Si el comando es 01, activar motor hacia arriba
            motor_down <= (motor_cmd == 2'b10); // Si el comando es 10, activar motor hacia abajo

            // Activar el buzzer si se detecta movimiento
            buzzer <= motion_detected;

            // Actualizar los LEDs
            led1 <= leds[0];
            led2 <= leds[1];
            led3 <= leds[2];
        end
    end

    // Lógica para enviar los estados de los LEDs y los topes del motor
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 8'b00000000; // Reiniciar data_out
        end else begin
            // Actualizar data_out con los estados de los LEDs y los topes del motor
            data_out[7:5] <= leds;    // Estados de los LEDs en los bits más significativos
            data_out[4]   <= TopeA_S; // Estado del tope superior
            data_out[3]   <= TopeB_S; // Estado del tope inferior
            data_out[2:0] = 3'b000;   // Puedes usar estos bits para otros estados o información
        end
    end

endmodule

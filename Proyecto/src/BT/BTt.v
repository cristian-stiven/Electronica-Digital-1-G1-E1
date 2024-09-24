`timescale 1ns / 1ps

// Módulo para la transmisión de datos a través de Bluetooth
module BTt (
    input wire clk,              // Reloj del sistema
    input wire reset,            // Señal de reset asíncrono
    input wire [7:0] data_in,    // Datos a enviar
    input wire send,             // Señal para iniciar el envío
    output reg tx,               // Salida de transmisión
    output reg busy              // Indica que el módulo está ocupado
);

    parameter CLK_FREQ = 50000000; // Frecuencia del reloj del sistema en Hz
    parameter BAUD_RATE = 9600;    // Tasa de baudios UART

    // Calcular el contador de baudios con oversampling x16
    localparam BAUD_COUNT = (CLK_FREQ / (BAUD_RATE * 16)) - 1;

    reg [3:0] bit_index;          // Índice del bit actual a enviar
    reg [15:0] baud_counter;       // Contador para la generación del tiempo de baud
    reg [7:0] data_reg;            // Registro para almacenar los datos a enviar

    // Estado del envío
    localparam IDLE = 2'b00,       // Estado de inactividad
               SEND_START = 2'b01, // Enviando bit de inicio
               SEND_DATA = 2'b10,  // Enviando datos
               SEND_STOP = 2'b11;  // Enviando bit de parada
    reg [1:0] state;               // Estado actual del módulo

    // Proceso principal del módulo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tx <= 1;                // Tx se inicia en alto (idle)
            busy <= 0;              // Módulo no ocupado
            state <= IDLE;          // Regresar al estado inicial
            baud_counter <= 0;      // Reiniciar contador de baud
            bit_index <= 0;         // Reiniciar índice de bit
        end else begin
            case (state)
                IDLE: begin
                    if (send && !busy) begin
                        data_reg <= data_in;  // Cargar datos a enviar
                        busy <= 1;            // Indicar que el módulo está ocupado
                        baud_counter <= 0;    // Reiniciar contador de baud
                        state <= SEND_START;  // Cambiar al estado de envío de inicio
                        tx <= 0;              // Enviar bit de inicio (0)
                    end
                end

                SEND_START: begin
                    if (baud_counter < BAUD_COUNT) begin
                        baud_counter <= baud_counter + 1; // Contar hasta BAUD_COUNT
                    end else begin
                        baud_counter <= 0;        // Reiniciar contador
                        state <= SEND_DATA;      // Cambiar al estado de envío de datos
                        bit_index <= 0;          // Reiniciar índice de bit
                    end
                end

                SEND_DATA: begin
                    if (baud_counter < BAUD_COUNT) begin
                        baud_counter <= baud_counter + 1; // Contar hasta BAUD_COUNT
                    end else begin
                        baud_counter <= 0;                    // Reiniciar contador
                        tx <= data_reg[bit_index];           // Enviar el siguiente bit de datos
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;      // Siguiente bit
                        end else begin
                            state <= SEND_STOP;              // Cambiar al estado de envío de parada
                        end
                    end
                end

                SEND_STOP: begin
                    if (baud_counter < BAUD_COUNT) begin
                        baud_counter <= baud_counter + 1; // Contar hasta BAUD_COUNT
                    end else begin
                        tx <= 1;               // Enviar bit de parada (1)
                        busy <= 0;             // Módulo no ocupado
                        state <= IDLE;         // Regresar al estado inicial
                    end
                end

            endcase
        end
    end
endmodule

`timescale 1ns / 1ps

// Módulo para la recepción de datos a través de Bluetooth
module BTr (
    input wire clk,              // Reloj del sistema
    input wire reset,            // Señal de reset asíncrono
    input wire rx,               // Entrada de recepción (UART)
    output reg [7:0] data_out,   // Datos recibidos (8 bits)
    output reg ready             // Indica que los datos están listos
);

    // Parámetros de configuración
    parameter CLK_FREQ = 50000000; // Frecuencia del reloj del sistema en Hz
    parameter BAUD_RATE = 9600;    // Tasa de baudios para la comunicación UART

    // Calcular el contador de baudios con oversampling x16
    localparam BAUD_COUNT = (CLK_FREQ / (BAUD_RATE * 16)) - 1;

    // Registros internos
    reg [15:0] baud_counter;       // Contador para la generación del tiempo de baud
    reg [3:0] bit_index;           // Índice del bit actual recibido
    reg [7:0] data_reg;            // Registro para almacenar los datos recibidos
    reg [1:0] state;               // Estado actual del módulo

    // Definición de estados para la máquina de estados
    localparam IDLE = 2'b00,       // Estado de inactividad
               RECEIVE_START = 2'b01, // Esperando el bit de inicio
               RECEIVE_DATA = 2'b10,  // Recibiendo datos
               RECEIVE_STOP = 2'b11;  // Esperando el bit de parada

    // Proceso principal del módulo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 0;          // Reiniciar datos de salida
            ready <= 0;             // Indicar que los datos no están listos
            baud_counter <= 0;      // Reiniciar contador de baud
            bit_index <= 0;         // Reiniciar índice de bit
            state <= IDLE;          // Regresar al estado inicial
        end else begin
            case (state)
                IDLE: begin
                    if (rx == 0) begin  // Esperar a que rx baje a 0 (bit de inicio)
                        baud_counter <= 0; // Reiniciar contador de baud
                        state <= RECEIVE_START; // Cambiar al estado de espera de inicio
                    end
                end

                RECEIVE_START: begin
                    if (baud_counter < BAUD_COUNT) begin
                        baud_counter <= baud_counter + 1; // Contar hasta BAUD_COUNT
                    end else begin
                        baud_counter <= 0; // Reiniciar contador
                        state <= RECEIVE_DATA; // Cambiar al estado de recepción de datos
                        bit_index <= 0; // Reiniciar índice de bit
                    end
                end

                RECEIVE_DATA: begin
                    if (baud_counter < BAUD_COUNT) begin
                        baud_counter <= baud_counter + 1; // Contar hasta BAUD_COUNT
                    end else begin
                        baud_counter <= 0; // Reiniciar contador
                        data_reg[bit_index] <= rx; // Recibir el siguiente bit
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1; // Siguiente bit
                        end else begin
                            state <= RECEIVE_STOP; // Cambiar al estado de espera de parada
                        end
                    end
                end

                RECEIVE_STOP: begin
                    if (baud_counter < BAUD_COUNT) begin
                        baud_counter <= baud_counter + 1; // Contar hasta BAUD_COUNT
                    end else begin
                        ready <= 1;           // Indicar que los datos están listos
                        data_out <= data_reg; // Almacenar los datos recibidos
                        state <= IDLE;        // Regresar al estado inicial
                    end
                end
            endcase
        end
    end
endmodule

`timescale 1ns / 1ps

// Módulo para el control de motores
module Motor (
    input wire clk,                // Reloj del sistema
    input wire reset,              // Señal de reset asíncrono
    input wire [1:0] cmd,          // Comando recibido desde House.v (2 bits)
    input wire TopeA,              // Tope superior (pulsador)
    input wire TopeB,              // Tope inferior (pulsador)
    output reg motor_up,           // Control de motor hacia arriba
    output reg motor_down,         // Control de motor hacia abajo
    output reg TopeA_S,            // Señal de tope superior (activada cuando TopeA es presionado)
    output reg TopeB_S             // Señal de tope inferior (activada cuando TopeB es presionado)
);

    // Proceso principal del módulo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Resetear salidas
            motor_up <= 0;
            motor_down <= 0;
            TopeA_S <= 0;
            TopeB_S <= 0;
        end else begin
            // Actualizar las señales de tope según las entradas
            TopeA_S <= TopeA; // Activar señal de tope superior si TopeA es presionado
            TopeB_S <= TopeB; // Activar señal de tope inferior si TopeB es presionado

            // Comprobar comando
            case (cmd)
                2'b01: begin // Comando para subir
                    if (!TopeA) begin // Si no está en el tope superior
                        motor_up <= 1;  // Activar motor hacia arriba
                        motor_down <= 0; // Desactivar motor hacia abajo
                    end else begin
                        motor_up <= 0;   // Detener motor hacia arriba
                    end
                end
                2'b10: begin // Comando para bajar
                    if (!TopeB) begin // Si no está en el tope inferior
                        motor_down <= 1; // Activar motor hacia abajo
                        motor_up <= 0;   // Desactivar motor hacia arriba
                    end else begin
                        motor_down <= 0; // Detener motor hacia abajo
                    end
                end
                default: begin // Comando no válido
                    motor_up <= 0;     // Detener motor hacia arriba
                    motor_down <= 0;   // Detener motor hacia abajo
                end
            endcase
        end
    end
endmodule

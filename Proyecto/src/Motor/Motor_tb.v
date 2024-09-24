`timescale 1ns / 1ps

`include "Motor.v"  // Incluir el módulo de motores

module Motor_tb;

    // Declaración de señales de prueba
    reg clk;              // Reloj del sistema
    reg reset;            // Señal de reset asíncrono
    reg [1:0] cmd;        // Comando a enviar (2 bits para comandos 1 y 2)
    reg TopeA;            // Tope superior
    reg TopeB;            // Tope inferior
    wire motor_up;        // Salida de control de motor hacia arriba
    wire motor_down;      // Salida de control de motor hacia abajo
    wire TopeA_S;         // Señal de tope superior
    wire TopeB_S;         // Señal de tope inferior

    // Instanciar el módulo de motores
    Motor uut (
        .clk(clk),
        .reset(reset),
        .cmd(cmd),
        .TopeA(TopeA),
        .TopeB(TopeB),
        .motor_up(motor_up),
        .motor_down(motor_down),
        .TopeA_S(TopeA_S),
        .TopeB_S(TopeB_S)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Cambiar estado cada 10 ns (50 MHz)
    end

    // Inicializar señales y realizar la simulación
    initial begin
        // Inicialización
        reset = 1;       // Activar reset
        cmd = 2'b00;     // Comando inicial (ninguno)
        TopeA = 0;       // Tope superior no activado
        TopeB = 0;       // Tope inferior no activado

        // Esperar un tiempo
        #20;
        reset = 0;       // Desactivar reset

        // Prueba de subir motor
        #20;
        cmd = 2'b01;     // Comando para subir
        #40;             // Esperar tiempo de activación
        TopeA = 0;       // Asegurarse de que el tope no está activado

        // Prueba de bajar motor
        #20;
        cmd = 2'b10;     // Comando para bajar
        #40;             // Esperar tiempo de activación
        TopeB = 0;       // Asegurarse de que el tope no está activado

        // Desactivación de comandos
        #20;
        cmd = 2'b00;     // Comando no válido

        // Activar topes
        #20;
        TopeA = 1;       // Activar tope superior
        #20;
        TopeB = 1;       // Activar tope inferior

        // Prueba cruzada: comando 1 con TopeA activado
        #20;
        cmd = 2'b01;     // Comando para subir
        TopeA = 1;       // Activar tope superior
        #40;             // Esperar tiempo de activación

        // Prueba cruzada: comando 2 con TopeB activado
        #20;
        cmd = 2'b10;     // Comando para bajar
        TopeB = 1;       // Activar tope inferior
        #40;             // Esperar tiempo de activación

        // Finalizar la simulación
        #20;
        $finish;
    end

    // Generación del archivo VCD para visualizar en GTKWave
    initial begin
        $dumpfile("Motor_tb.vcd");
        $dumpvars(0, Motor_tb);
    end
endmodule

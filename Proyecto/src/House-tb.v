`timescale 1ns / 1ps


module tb_House;

    // Parámetros
    reg clk;
    reg reset;
    reg rx;
    reg motion_detected;
    reg TopeA;
    reg TopeB;
    
    wire tx;
    wire [7:0] data_out;
    wire [1:0] motor_cmd;
    wire [2:0] led_cmd;

    // Instanciar el módulo House
    House dut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .tx(tx),
        .motion_detected(motion_detected),
        .TopeA(TopeA),
        .TopeB(TopeB)
    );

    // Generar reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Cambiar cada 5 ns
    end

    // Inicializar señales
    initial begin
        reset = 1;  // Inicializar en reset
        #10;
        reset = 0;  // Liberar reset
        #10;

        // Testear diferentes combinaciones de data_in, TopeA y TopeB
        test_case(8'b00000000, 0, 0); // Detener motor, desactivar LEDs
        test_case(8'b00000001, 0, 0); // Giro adelante, desactivar LEDs
        test_case(8'b00000010, 0, 0); // Giro atrás, desactivar LEDs
        test_case(8'b00000100, 0, 0); // Detener motor, activar LED1
        test_case(8'b00000101, 0, 0); // Giro adelante, activar LED1
        test_case(8'b00000110, 0, 0); // Giro atrás, activar LED1
        test_case(8'b00001000, 0, 0); // Detener motor, activar LED2
        test_case(8'b00001100, 0, 0); // Detener motor, activar LED3

        // Probar con TopeA y TopeB activos
        test_case(8'b00000001, 1, 0); // Detener motor, desactivar LEDs (TopeA)
        test_case(8'b00000001, 0, 1); // Detener motor, desactivar LEDs (TopeB)
        test_case(8'b00000001, 1, 1); // Detener motor, desactivar LEDs (ambos topes)

        // Terminar simulación
        #100;
        $finish;
    end

    // Procedimiento para verificar casos de prueba
    task test_case(
        input [7:0] data_in,
        input TopeA_signal,
        input TopeB_signal
    );
        begin
            // Asignar valores a las señales
            dut.data_in = data_in;  // Asignar data_in
            TopeA = TopeA_signal;    // Asignar estado de TopeA
            TopeB = TopeB_signal;    // Asignar estado de TopeB

            // Esperar un ciclo de reloj
            #10;

            // Mostrar resultados
            $display("data_in: %b, TopeA: %b, TopeB: %b -> motor_cmd: %b, led_cmd: %b, data_out: %b",
                     data_in, TopeA_signal, TopeB_signal, dut.motor_cmd, dut.led_cmd, dut.data_out);
        end
    endtask

    // Dump de variables para el archivo .vcd
    initial begin
        $dumpfile("tb_House.vcd");
        $dumpvars(0, tb_House);
    end

endmodule

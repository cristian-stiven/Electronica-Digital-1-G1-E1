module cf_divider(clk, rst, fdiv, ms_f, cs_f, ds_f, sec_f); //modulo divisor de frecuencia

input clk; //entrada del reloj Pin23
input rst; //entrada del reset
output reg fdiv; //salida para cambio de 7Seg
output reg ms_f; //salida para milisegundos
output reg cs_f; //salida para centisegundos
output reg ds_f; //salida para decisegundos
output reg sec_f; //salida para segundos

/*
Sección creada para inicializar las variables para los contadores donde la primera
asigna el número de ciclos necesarios, el tamaño específico para almacenar esos ciclos
y por último la variable de conteo inicializada con el tamaño hallado.
*/

parameter trmsn_cont = 800000;  //Ciclos para cambio de 7seg
parameter tam_tc = $clog2(trmsn_cont);
reg [$clog2(trmsn_cont)-1:0] counter;

parameter ms_cont = 50000;      //Ciclos para conteo ms
parameter tam_ms = $clog2(ms_cont);
reg [$clog2(ms_cont)-1:0] ms_counter;

parameter cs_cont = 500000;     //Ciclos para conteo cs
parameter tam_cs = $clog2(cs_cont);
reg [$clog2(cs_cont)-1:0] cs_counter;

parameter ds_cont = 5000000;    //Ciclos para conteo ds
parameter tam_ds = $clog2(ds_cont);
reg [$clog2(ds_cont)-1:0] ds_counter;

parameter sc_cont = 50000000;   //Ciclos para conteo segundos
parameter tam_sc = $clog2(sc_cont);
reg [$clog2(sc_cont)-1:0] sc_counter;

//bloque para iniciar el conteo siempre que el reloj o el botón presenten un flanco de subida
always @(posedge clk or posedge rst) begin 

    if(rst) begin //Condición: al presionar RESET, todos los contadores y variables de estado se reinician.

        counter <= 'd0;
        ms_counter <= 'd0;
        cs_counter <= 'd0;
        ds_counter <= 'd0;
        sc_counter <= 'd0;

        fdiv <= 1'b0;  
        ms_f <= 1'b0;
        cs_f <= 1'b0;
        ds_f <= 1'b0;
        sec_f <= 1'b0;

    end else begin //Cuando no se presiona reset, se inicia la siguiente logica:

        if (counter == trmsn_cont) begin //Si este contador alcanza el límite establecido:
            counter <= 'd0; //Se reinicia 
            fdiv <= ~fdiv; //la salida correspondiente cambia de estado de 1 a 0 y viceversa.
        end else begin // De no cumplir la condición anterior se suma una unidad al contador.
            counter <= counter+1;
        end
            //La anterior lógica explicada sobre el divisor de frecuencia para el cambio de 7seg.

        if (ms_counter == ms_cont) begin //Logica aplicada para el div de ms.
            ms_counter <= 'd0;
            ms_f <= ~ms_f;
        end else begin
            ms_counter <= ms_counter+1;
        end

        if (cs_counter == cs_cont) begin    //Logica aplicada para el div de cs.
            cs_counter <= 'd0;
            cs_f <= ~cs_f;
        end else begin
            cs_counter <= cs_counter+1; 
        end

        if (ds_counter == ds_cont) begin     //Logica aplicada para el div de ds.
            ds_counter <= 'd0;
            ds_f <= ~ds_f;  
        end else begin
            ds_counter <= ds_counter+1;
        end

        if (sc_counter == sc_cont) begin    //Logica aplicada para el div de segundos.
            sc_counter <= 'd0;
            sec_f <= ~sec_f;
        end else begin
            sc_counter <= sc_counter+1;
        end
    end

end


endmodule

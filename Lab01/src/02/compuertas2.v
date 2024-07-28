module compuertas2(

    //Entradas de las diferentes compuertas y entradas del sistema
    input A,
    input B, 
    input C,

    //Salidas de las compuertas y del sistema, C0 pertence a Co
    output S1,
    output C0
    );

    //Asiganmos los valores teniendo en cuenta que creamos una igualdad para dos variables
    //representan una salida y una entrada de una compuerta

    assign S1 = (A^B)^C;
    assign C0 = ((A^B)&C)|(A&B);


endmodule
module compuertas2(
    input A,
    input B, 
    input C,
    input V1,
    input V2, 
    input V3,

    output S1,
    output S2,
    output V12,
    output V22,
    output V32
    );

    assign V12= A ^ B;
    assign V22= A & B ;
    assign S1= V1 ^ C;
    assign V32= V1 & C;
    assign S2= V2 | V3;
    assign V1= V12;
    assign V2= V22;
    assign V3= V32;

endmodule
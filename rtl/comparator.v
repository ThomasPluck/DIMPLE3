module preshift_comparator #(
    parameter WIDTH=32,
    parameter SPINS=32
) (
    input wire [SPINS-1:0][WIDTH-1:0] values,
    input wire [WIDTH-1:0] base,
    output wire [SPINS-1:0] comparison
);

    genvar i;
    generate
        for(i = 0; i < SPINS; i = i + 1) begin
            assign comparison[i] = values[i] > base;
        end
    endgenerate

endmodule

module postshift_comparator #(
    parameter WIDTH=32,
    parameter SPINS=32 
) (
    input wire [SPINS-1:0][WIDTH-1:0] unrotated,
    input wire [SPINS-1:0][WIDTH-1:0] rotated,
    output wire [SPINS-1:0] comparison
);

    genvar i;
    generate
        for(i = 0; i < SPINS; i = i + 1) begin
            assign comparison[i] = rotated[i] > unrotated[i];
        end
    endgenerate

endmodule
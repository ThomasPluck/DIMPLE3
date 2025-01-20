module spin_register #(
    parameter WIDTH = 32 // Default width is 32 bits
) (
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] increment
    input wire [WIDTH-1:0] coupling
    output reg [WIDTH-1:0] value
);

    always @ (posedge clk) begin
        if (rst)
            value <= 0;
        else
            value <= value + increment + coupling;
    end

endmodule

module spin_system #(
    parameter WIDTH = 32,  // Default width is 32 bits
    parameter SPINS = 32  // Default number of spins
) (
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] increment,
    input wire [SPINS][WIDTH-1:0] coupling,
    output wire [SPINS][WIDTH-1:0] value
);

    genvar s;

    generate
        for (s = 0; s < SPINS; s = s + 1) begin
            spin_register spin (
                clk,
                rst,
                increment,
                coupling[s],
                value[s]
            );
        end
    endgenerate

endmodule
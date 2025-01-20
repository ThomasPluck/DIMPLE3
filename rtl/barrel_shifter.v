module barrel_shifter #(
    parameter WIDTH=32, // per spin bit width to be rotated
    parameter SPINS=32  // number of spins in the system
) (
    input wire [SPINS][WIDTH-1:0] bus_in,
    input wire [$clog2(SPINS)-1:0] ctrl,
    output wire [SPINS][WIDTH-1:0] bus_out
);
    
    wire [SPINS][WIDTH-1:0] stage_wires[$clog2(SPINS):0];
    
    assign stage_wires[0] = bus_in;
    
    genvar i, j;
    generate
        for (i = 0; i < $clog2(SPINS); i++) begin : shift_stages
            localparam SHIFT_AMT = 1 << i;
            
            for (j = 0; j < SPINS; j++) begin : spin_connections
                assign stage_wires[i+1][j] = 
                    ctrl[i] ? stage_wires[i][(j + SPINS - SHIFT_AMT) % SPINS] : 
                             stage_wires[i][j];
            end
        end
    endgenerate
    
    assign bus_out = stage_wires[$clog2(SPINS)];

endmodule
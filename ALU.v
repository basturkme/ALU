module ALU #(
    parameter W = 8
)(
    // Inputs
    input [W-1:0] DATA_A,
    input [W-1:0] DATA_B,
    input [1:0] control,  // 2-bit control signal
    
    // Outputs
    output [W-1:0] OUT,
    output CO, OVF, N, Z
);

    // Internal wires for Arithmetic Unit
    wire [W-1:0] AU_OUT;
    wire AU_CO, AU_OVF, AU_N, AU_Z;
    
    // Internal wires for Logic Unit
    wire [W-1:0] LU_OUT;
    wire LU_N, LU_Z;

    // Instantiate Arithmetic Unit (for addition and subtraction)
    Arithmetic_Unit #(.W(W)) AU_inst (
        .DATA_A(DATA_A),
        .DATA_B(DATA_B),
        .control(control[0]),  // 0 for addition, 1 for subtraction
        .OUT(AU_OUT),
        .CO(AU_CO),
        .OVF(AU_OVF),
        .N(AU_N),
        .Z(AU_Z)
    );

    // Instantiate Logic Unit (for AND and OR operations)
    Logic_Unit #(.W(W)) LU_inst (
        .DATA_A(DATA_A),
        .DATA_B(DATA_B),
        .control(control[0]),  // 0 for AND, 1 for OR
        .OUT(LU_OUT),
        .N(LU_N),
        .Z(LU_Z)
    );

    // Operation selection multiplexer
    assign OUT = control[1] ? AU_OUT : LU_OUT;
    
    // Status flags
    assign CO = control[1] ? AU_CO : 1'b0;      // CO only active for arithmetic ops
    assign OVF = control[1] ? AU_OVF : 1'b0;    // OVF only active for arithmetic ops
    assign N = OUT[W-1];                        // Negative flag (MSB of result)
    assign Z = ~|OUT;                           // Zero flag (NOR of all bits)

endmodule
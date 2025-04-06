module Arithmetic_Unit#(parameter W=8)
        ( // This is a template. 
// You can modify the input-output declerations(width etc.) without changing the names.
    input [W-1:0] DATA_A,
    input [W-1:0] DATA_B,
    input control,
    output [W-1:0] OUT,
    output CO, OVF, N, Z
);

wire [W:0] sum; // W+1-bit sum to capture carry
wire [W:0] extended_A = {DATA_A[W-1], DATA_A}; // Sign-extend A
wire [W:0] extended_B = control ? {DATA_B[W-1], DATA_B} : ~{DATA_B[W-1], DATA_B} + 1; // B or -B

assign sum = extended_A + extended_B; // Addition/Subtraction
assign OUT = sum[W-1:0]; // Result (W bits)
assign CO = sum[W]; // Carry out (MSB of extended sum)
assign OVF = sum[W] ^ sum[W-1]; // Overflow detection
assign N = sum[W-1]; // Negative flag (sign bit)
assign Z = ~|OUT; // Zero flag (all bits zero)

endmodule
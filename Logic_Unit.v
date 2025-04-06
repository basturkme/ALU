module Logic_Unit #(parameter W = 8) (
    input [W-1:0] DATA_A,   // Rename A -> DATA_A
    input [W-1:0] DATA_B,   // Rename B -> DATA_B
    input control,
    output [W-1:0] OUT,
    output N,
    output Z
);

// Bitwise operations
assign OUT = control ? (DATA_A | DATA_B) : (DATA_A & DATA_B); // Use DATA_A/DATA_B

// Status flags
assign N = OUT[W-1];
assign Z = ~|OUT;

endmodule
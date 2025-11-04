module peres_gate (
    input  wire a, // A (preserved as P)
    input  wire b, // B
    input  wire c, // C (ancilla or input)
    output wire p, // P = A
    output wire q, // Q = A ^ B
    output wire r  // R = (A & B) ^ C
);
    assign p = a;
    assign q = a ^ b;
    assign r = (a & b) ^ c;
endmodule
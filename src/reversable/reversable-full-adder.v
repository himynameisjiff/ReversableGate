// reversible_full_adder.v
// A Peres-gate-based reversible full adder implementation.
// Inputs: a, b, cin
// Requires one ancilla input anc (should be initialized to 0).
// Outputs:
// - sum (the sum bit)
// - cout (the carry out)
// - g1, g2 are "garbage" outputs produced because reversible gates must be bijective.
// Notes:
// This implementation uses two Peres gates in sequence to compute sum and carry with limited ancilla.
// Gate sequence (conceptual):
// 1) Peres1 on (a, b, anc0=0) -> (p1=a, q1=a^b, g1=a&b)
//
// 2) Peres2 on (q1, cin, g1) -> (p2=q1, sum = q1^cin, cout = g1 ^ (q1 & cin))
// Final outputs: sum = a ^ b ^ cin, cout = majority(a,b,cin)
// Garbage: p1 (which is a) is preserved as p2's input; g1 is consumed/modified into cout but also appears as garbage depending on how ancilla are reused.
//
// This module exposes the intermediate garbage outputs so higher-level reversible synthesis can manage/uncompute them as needed.

module reversible_full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    input  wire anc_in,    // ancilla input, should be 0 for correct logical operation
    output wire sum,
    output wire cout,
    output wire g_a,       // preserved a (garbage/preserved line)
    output wire g_ab       // intermediate garbage (a & b) ^ anc_in after first Peres
);
    // First Peres: (a, b, anc_in) -> (a, a^b, (a & b) ^ anc_in)
    wire p1, q1, r1;
    peres_gate pgate1 (
        .a(a),
        .b(b),
        .c(anc_in),
        .p(p1),
        .q(q1),
        .r(r1)
    );

    // Second Peres: (q1, cin, r1) -> (q1, q1^cin, (q1 & cin) ^ r1)
    // q1^cin is the sum, (q1 & cin) ^ r1 is the carry-out
    wire p2, q2, r2;
    peres_gate pgate2 (
        .a(q1),
        .b(cin),
        .c(r1),
        .p(p2),
        .q(q2),
        .r(r2)
    );

    assign sum = q2;   // q1 ^ cin = a ^ b ^ cin
    assign cout = r2;  // (q1 & cin) ^ r1 -> majority(a,b,cin)
    // expose garbage/preserved lines so caller can uncompute if desired
    assign g_a  = p1;  // equals a (preserved input line)
    assign g_ab = r1;  // intermediate (a & b) ^ anc_in

endmodule
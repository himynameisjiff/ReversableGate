// reversible_ripple_adder_8bit.v
// 8-bit reversible ripple-carry adder synthesized using Peres-based reversible full adders.
// This design follows a straightforward ripple approach: each bit is implemented with a reversible full adder
// that consumes one ancilla initialised to 0. Because reversible logic must be bijective, each stage produces
// garbage outputs; to fully clean garbage you must apply uncomputation (not implemented here).
//
// Interface:
// - a[7:0], b[7:0] inputs
// - ancillas: anc[7:0] inputs, each should be 0 at start (one per full adder stage).
// - sum[7:0], cout (final carry out)
// - garbage lines are exposed for potential uncomputation/cleanup by higher-level synthesis.
//
// Notes on resource metrics (informal):
// - Peres gate cost: quantum cost often counted as 4 (depends on metric).
// - Each full adder here uses 2 Peres gates -> 2 * (Peres cost).
// - Ancilla: 1 per bit (you can trade ancilla for gate count by alternative constructions).
// - Garbage: preserve a inputs and intermediate bits per stage; proper reversible synthesis often adds uncompute stages to erase them.

module reversible_ripple_adder_8bit (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire       cin,
    input  wire [7:0] anc,    // ancillas (each should be initialised to 0)
    output wire [7:0] sum,
    output wire       cout,
    output wire [7:0] g_a,    // preserved a bits (garbage/preserved)
    output wire [7:0] g_ab    // per-bit intermediate garbage (a & b) ^ anc[i]
);
    // Internal carry chain (wires)
    wire [7:0] carry; // carry[i] is carry out from bit i
    // For bit 0, use input cin as the input carry; produce carry[0] as out from FA0
    // For bits i>0, cin in that FA is carry[i-1]

    // instantiate 8 reversible full adders
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : rfa_bits
            wire fa_sum, fa_cout, fa_ga, fa_gab;
            wire fa_cin;
            if (i == 0) begin
                assign fa_cin = cin;
            end else begin
                assign fa_cin = carry[i-1];
            end

            reversible_full_adder rfa (
                .a(a[i]),
                .b(b[i]),
                .cin(fa_cin),
                .anc_in(anc[i]),
                .sum(fa_sum),
                .cout(fa_cout),
                .g_a(fa_ga),
                .g_ab(fa_gab)
            );

            assign sum[i]   = fa_sum;
            assign carry[i] = fa_cout;
            assign g_a[i]   = fa_ga;
            assign g_ab[i]  = fa_gab;
        end
    endgenerate

    assign cout = carry[7];
endmodule
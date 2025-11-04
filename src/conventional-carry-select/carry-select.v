
module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    assign {cout, sum} = a + b + cin;
endmodule

// 4-bit ripple adder used for lower block (and for computing both cases in upper block)
module ripple_adder_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       cout
);
    wire [3:0] c;

    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin),     .sum(sum[0]), .cout(c[0]));
    full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c[0]),    .sum(sum[1]), .cout(c[1]));
    full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c[1]),    .sum(sum[2]), .cout(c[2]));
    full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c[2]),    .sum(sum[3]), .cout(c[3]));

    assign cout = c[3];
endmodule

module carry_select (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire       cin,
    output wire [7:0] sum,
    output wire       cout
);
    // Lower 4-bit block: actual ripple with incoming cin
    wire [3:0] sum_lo;
    wire       carry_lo;
    ripple_adder_4bit lo_block (
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .sum(sum_lo),
        .cout(carry_lo)
    );

    // Upper 4-bit block: compute for cin=0 and cin=1 in parallel
    wire [3:0] sum_hi_c0, sum_hi_c1;
    wire       cout_hi_c0, cout_hi_c1;

    ripple_adder_4bit hi_block_c0 (
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(1'b0),
        .sum(sum_hi_c0),
        .cout(cout_hi_c0)
    );

    ripple_adder_4bit hi_block_c1 (
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(1'b1),
        .sum(sum_hi_c1),
        .cout(cout_hi_c1)
    );

    // Select correct upper sum and carry based on carry_lo
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : sel_bits
            assign sum[4+i] = carry_lo ? sum_hi_c1[i] : sum_hi_c0[i];
        end
    endgenerate

    assign sum[3:0] = sum_lo;
    assign cout = carry_lo ? cout_hi_c1 : cout_hi_c0;
endmodule
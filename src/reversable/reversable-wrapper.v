module reversible_wrapper (
    input  wire        clk,
    input  wire        reset,    // synchronous active-high reset
    input  wire        enable,   // when high, sample new inputs into input registers
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    input  wire [7:0]  anc,      // ancillas (expected to be initialised to zero externally)
    input  wire        cin,
    output reg  [7:0]  sum,
    output reg         cout,
    output reg  [7:0]  g_a,      // registered garbage outputs
    output reg  [7:0]  g_ab      // registered garbage outputs
);
    // Registered inputs
    reg [7:0] a_r;
    reg [7:0] b_r;
    reg [7:0] anc_r;
    reg       cin_r;

    // Combinational instance outputs
    wire [7:0] sum_c;
    wire       cout_c;
    wire [7:0] g_a_c;
    wire [7:0] g_ab_c;

    // Instantiate combinational reversible adder driven by registered inputs
    reversible_ripple_adder_8bit u_rev (
        .a(a_r),
        .b(b_r),
        .cin(cin_r),
        .anc(anc_r),
        .sum(sum_c),
        .cout(cout_c),
        .g_a(g_a_c),
        .g_ab(g_ab_c)
    );

    // Input registers with enable and synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            a_r   <= 8'b0;
            b_r   <= 8'b0;
            anc_r <= 8'b0;
            cin_r <= 1'b0;
        end else if (enable) begin
            a_r   <= a;
            b_r   <= b;
            anc_r <= anc;
            cin_r <= cin;
        end
        // else hold previous registered inputs
    end

    // Output registers capture the combinational outputs (one-cycle latency)
    always @(posedge clk) begin
        if (reset) begin
            sum  <= 8'b0;
            cout <= 1'b0;
            g_a  <= 8'b0;
            g_ab <= 8'b0;
        end else begin
            sum  <= sum_c;
            cout <= cout_c;
            g_a  <= g_a_c;
            g_ab <= g_ab_c;
        end
    end
endmodule
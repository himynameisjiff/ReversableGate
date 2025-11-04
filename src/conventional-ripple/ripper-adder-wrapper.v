module ripple_adder_wrapper (
    input  wire        clk,
    input  wire        reset,   // synchronous active-high reset
    input  wire        enable,  // sample inputs when high
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    input  wire        cin,
    output reg  [7:0]  sum,
    output reg         cout
);
    // Registered inputs
    reg [7:0] a_r;
    reg [7:0] b_r;
    reg       cin_r;

    // Combinational adder instance (same ripple_adder)
    wire [7:0] sum_c;
    wire       cout_c;

    ripple_adder u_rip (
        .a(a_r),
        .b(b_r),
        .cin(cin_r),
        .sum(sum_c),
        .cout(cout_c)
    );

    // Input registers with enable and synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            a_r   <= 8'b0;
            b_r   <= 8'b0;
            cin_r <= 1'b0;
        end else if (enable) begin
            a_r   <= a;
            b_r   <= b;
            cin_r <= cin;
        end
        // else hold previous a_r, b_r, cin_r
    end

    // Output registers capturing combinational outputs (one-cycle latency)
    always @(posedge clk) begin
        if (reset) begin
            sum  <= 8'b0;
            cout <= 1'b0;
        end else begin
            sum  <= sum_c;
            cout <= cout_c;
        end
    end
endmodule
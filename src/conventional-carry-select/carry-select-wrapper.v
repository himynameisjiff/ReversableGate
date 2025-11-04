`timescale 1ns / 1ps

// Wrapper with registers around combinational carry_select to enable
// meaningful static timing analysis (register-to-register paths).
// - clk: used for registering inputs and outputs.
// - On reset (active high), output registers clear to 0.

module carry_select_wrapper (
    input  wire        clk,
    input  wire        reset,
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    input  wire        cin,
    output reg  [7:0]  sum,
    output reg         cout
);
    // Input registers
    reg [7:0] a_r;
    reg [7:0] b_r;
    reg       cin_r;

    // Combinational adder
    wire [7:0] sum_c;
    wire       cout_c;

    carry_select u_cs (
        .a(a_r),
        .b(b_r),
        .cin(cin_r),
        .sum(sum_c),
        .cout(cout_c)
    );

    // Register outputs (one cycle latency)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a_r   <= 8'b0;
            b_r   <= 8'b0;
            cin_r <= 1'b0;
            sum   <= 8'b0;
            cout  <= 1'b0;
        end else begin
            a_r   <= a;
            b_r   <= b;
            cin_r <= cin;
            sum   <= sum_c;
            cout  <= cout_c;
        end
    end
endmodule
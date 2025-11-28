`timescale 1ns/1ps
//------------------------------------------------------------------------------
// tb_common_gl.v - Unified gate-level testbench for reversible, ripple, 
// carry-select adders.
//
// Select ONE design via: -DDESIGN_REVERSIBLE | -DDESIGN_RIPPLE | -DDESIGN_CARRY_SELECT
// Optionally define VCD path: -DVCD_FILE="sim_out/<design>.vcd"
// Clock period default 25 ns (40 MHz) matching SDC.
//------------------------------------------------------------------------------

module tb_common_gl;
    localparam CLK_PERIOD_NS = 25; // 25 ns
    localparam NUM_CYCLES    = 1024;

    reg         clk;
    reg         reset;
    reg  [7:0]  a;
    reg  [7:0]  b;
    reg         cin;
`ifdef DESIGN_REVERSIBLE
    reg         enable;
    reg  [7:0]  anc;
    wire [7:0]  g_a;
    wire [7:0]  g_ab;
`endif
`ifdef DESIGN_RIPPLE
    reg         enable;
`endif
    wire [7:0]  sum;
    wire        cout;

    wire VPWR = 1'b1;
    wire VGND = 1'b0;

`ifdef DESIGN_REVERSIBLE
    reversible_wrapper dut (
        .clk(clk), .reset(reset), .enable(enable), .a(a), .b(b), .anc(anc), .cin(cin),
        .sum(sum), .cout(cout), .g_a(g_a), .g_ab(g_ab), .VPWR(VPWR), .VGND(VGND)
    );
`elsif DESIGN_RIPPLE
    ripple_adder_wrapper dut (
        .clk(clk), .reset(reset), .enable(enable), .a(a), .b(b), .cin(cin),
        .sum(sum), .cout(cout), .VPWR(VPWR), .VGND(VGND)
    );
`elsif DESIGN_CARRY_SELECT
    carry_select_wrapper dut (
        .clk(clk), .reset(reset), .a(a), .b(b), .cin(cin),
        .sum(sum), .cout(cout), .VPWR(VPWR), .VGND(VGND)
    );
`else
    initial begin
        $display("ERROR: Define one of -DDESIGN_REVERSIBLE | -DDESIGN_RIPPLE | -DDESIGN_CARRY_SELECT");
        $finish;
    end
`endif

    // Clock
    initial begin
        clk = 0;
        forever #(CLK_PERIOD_NS/2) clk = ~clk;
    end

    // VCD dump
    initial begin
`ifdef VCD_FILE
        $dumpfile(`VCD_FILE);
`else
        $dumpfile("sim_out/default.vcd");
`endif
        $dumpvars(0, tb_common_gl);
    end

    integer i;
    reg [15:0] lfsr;

    initial begin
        reset = 1; a = 0; b = 0; cin = 0; lfsr = 16'hACE1;
`ifdef DESIGN_REVERSIBLE
        enable = 0; anc = 0;
`endif
`ifdef DESIGN_RIPPLE
        enable = 0;
`endif
        repeat (4) @(posedge clk);
        reset = 0;
`ifdef DESIGN_REVERSIBLE
        enable = 1;
`endif
`ifdef DESIGN_RIPPLE
        enable = 1;
`endif
        for (i = 0; i < NUM_CYCLES; i = i + 1) begin
            @(posedge clk);
            lfsr = {lfsr[14:0], lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10]};
            a   = lfsr[7:0];
            b   = lfsr[15:8];
            cin = lfsr[0];
`ifdef DESIGN_REVERSIBLE
            anc = 8'h00;
`endif
        end
        repeat (10) @(posedge clk);
        $display("Simulation completed for %0d cycles.", NUM_CYCLES);
        $finish;
    end
endmodule

//------------------------------------------------------------------------------
// Common gate-level testbench for reversible_wrapper, ripple_adder_wrapper, 
// and carry_select_wrapper designs.
//
// Compile-time defines:
//   - DESIGN_REVERSIBLE: Instantiate reversible_wrapper
//   - DESIGN_RIPPLE: Instantiate ripple_adder_wrapper
//   - DESIGN_CARRY_SELECT: Instantiate carry_select_wrapper
//   - VCD_FILE: VCD output file path (e.g., "sim_out/reversible.vcd")
//
// Clock period: 25 ns (40 MHz) consistent with SDC constraints.
//------------------------------------------------------------------------------

`timescale 1ns / 1ps

module tb_common_gl;

    // Parameters
    localparam CLK_PERIOD = 25;         // 25 ns = 40 MHz
    localparam NUM_CYCLES = 1024;       // Number of test cycles

    // Common signals
    reg         clk;
    reg         reset;
    reg  [7:0]  a;
    reg  [7:0]  b;
    reg         cin;

    wire [7:0]  sum;
    wire        cout;

    // Reversible-specific signals
`ifdef DESIGN_REVERSIBLE
    reg         enable;
    reg  [7:0]  anc;
    wire [7:0]  g_a;
    wire [7:0]  g_ab;
`endif

    // Ripple-specific signals (has enable)
`ifdef DESIGN_RIPPLE
    reg         enable;
`endif

    // Power/ground (for powered netlist)
    wire VPWR = 1'b1;
    wire VGND = 1'b0;

    // Instantiate DUT based on design selection
`ifdef DESIGN_REVERSIBLE
    reversible_wrapper dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .a(a),
        .b(b),
        .anc(anc),
        .cin(cin),
        .sum(sum),
        .cout(cout),
        .g_a(g_a),
        .g_ab(g_ab),
        .VPWR(VPWR),
        .VGND(VGND)
    );
`elsif DESIGN_RIPPLE
    ripple_adder_wrapper dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout),
        .VPWR(VPWR),
        .VGND(VGND)
    );
`elsif DESIGN_CARRY_SELECT
    carry_select_wrapper dut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout),
        .VPWR(VPWR),
        .VGND(VGND)
    );
`else
    // Default error if no design specified
    initial begin
        $display("ERROR: No design specified. Use -DDESIGN_REVERSIBLE, -DDESIGN_RIPPLE, or -DDESIGN_CARRY_SELECT");
        $finish;
    end
`endif

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // VCD dumping
    initial begin
`ifdef VCD_FILE
        $dumpfile(`VCD_FILE);
        $dumpvars(0, tb_common_gl);
`else
        $dumpfile("sim_out/default.vcd");
        $dumpvars(0, tb_common_gl);
`endif
    end

    // Test sequence
    integer i;
    reg [15:0] lfsr;   // LFSR for pseudo-random test patterns

    initial begin
        // Initialize
        reset = 1;
        a = 8'b0;
        b = 8'b0;
        cin = 0;
`ifdef DESIGN_REVERSIBLE
        enable = 0;
        anc = 8'b0;
`endif
`ifdef DESIGN_RIPPLE
        enable = 0;
`endif
        lfsr = 16'hACE1;  // Seed for LFSR

        // Hold reset for a few cycles
        repeat (4) @(posedge clk);
        reset = 0;

`ifdef DESIGN_REVERSIBLE
        enable = 1;
`endif
`ifdef DESIGN_RIPPLE
        enable = 1;
`endif

        // Apply test vectors for NUM_CYCLES
        for (i = 0; i < NUM_CYCLES; i = i + 1) begin
            @(posedge clk);
            // LFSR-based pseudo-random pattern
            lfsr = {lfsr[14:0], lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10]};
            a = lfsr[7:0];
            b = lfsr[15:8];
            cin = lfsr[0];
`ifdef DESIGN_REVERSIBLE
            anc = 8'b0;  // Ancilla should be zero
`endif
        end

        // Additional cycles to capture outputs
        repeat (10) @(posedge clk);

        $display("Simulation completed successfully for %0d cycles", NUM_CYCLES);
        $finish;
    end

endmodule

// tb_common_gl.v
// Common gate-level testbench for power measurement of reversible and conventional adders.
//
// This testbench is designed to generate VCD files with switching activity for
// accurate power analysis using OpenROAD's read_vcd command.
//
// Usage:
//   1. Compile with one of the DUT selection defines:
//      +define+DUT_REVERSIBLE   - Test reversible_wrapper
//      +define+DUT_RIPPLE       - Test ripple_adder_wrapper
//      +define+DUT_CARRY_SELECT - Test carry_select_wrapper
//
//   2. Optionally control VCD dump depth:
//      +define+DUMP_DEPTH1 - Dump only DUT top-level pins (default)
//      +define+DUMP_DEPTH2 - Dump 2 levels of hierarchy
//      +define+DUMP_ALL    - Dump all internal nets (WARNING: large VCD files!)
//
// VCD Size Warning:
// -----------------
// Dumping all internal nets (+define+DUMP_ALL) can produce extremely large VCD
// files (100s of MB to GB), especially for longer simulations. Use with caution
// and ensure adequate disk space. Default behavior (DUMP_DEPTH1) captures only
// top-level DUT pins which is usually sufficient for power estimation.

`timescale 1ns / 1ps

module tb_common_gl;

    // Clock and control signals
    reg clk;
    reg reset;
    reg enable;

    // Common input signals
    reg [7:0] a;
    reg [7:0] b;
    reg       cin;

    // Output signals (directly wired to DUT outputs)
    wire [7:0] sum;
    wire       cout;

`ifdef DUT_REVERSIBLE
    // Additional signals for reversible wrapper
    reg  [7:0] anc;
    wire [7:0] g_a;
    wire [7:0] g_ab;

    reversible_wrapper u_dut (
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
        .g_ab(g_ab)
    );
`elsif DUT_RIPPLE
    ripple_adder_wrapper u_dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
`elsif DUT_CARRY_SELECT
    // Note: carry_select_wrapper doesn't have an 'enable' signal
    // Inputs are registered every clock cycle (not gated by enable)
    carry_select_wrapper u_dut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
`else
    // Default: Error if no DUT is selected
    initial begin
        $display("ERROR: No DUT selected. Use +define+DUT_REVERSIBLE, +define+DUT_RIPPLE, or +define+DUT_CARRY_SELECT");
        $finish;
    end
`endif

    // Clock generation: 25ns period (40 MHz) to match CLOCK_PERIOD in config.json
    localparam CLOCK_PERIOD = 25;
    initial clk = 0;
    always #(CLOCK_PERIOD/2) clk = ~clk;

    // VCD dumping with configurable depth
    // WARNING: Higher dump depths produce much larger VCD files!
    initial begin
        $dumpfile("sim_out/waveform.vcd");

`ifdef DUMP_ALL
        // Dump all signals at all hierarchy levels
        // WARNING: This produces very large VCD files!
        $display("INFO: Dumping ALL signals - expect large VCD file");
        $dumpvars(0, tb_common_gl);
`elsif DUMP_DEPTH2
        // Dump testbench and 2 levels inside DUT
        $display("INFO: Dumping 2 levels of DUT hierarchy");
        $dumpvars(0, tb_common_gl);
        $dumpvars(2, u_dut);
`else
        // Default: Dump testbench and top-level DUT pins only
        $display("INFO: Dumping testbench and DUT top-level pins only");
        $dumpvars(0, tb_common_gl);
        $dumpvars(1, u_dut);
`endif
    end

    // Test stimulus with varied switching patterns for realistic activity
    integer i;
    integer num_additions;
    reg [31:0] seed;

    initial begin
        // Initialize signals
        reset  = 1;
        enable = 0;
        a      = 8'h00;
        b      = 8'h00;
        cin    = 0;
`ifdef DUT_REVERSIBLE
        anc    = 8'h00; // Ancilla must be initialized to zero
`endif

        // Wait for a few clock cycles then release reset
        @(posedge clk);
        @(posedge clk);
        reset = 0;

        // Number of addition operations to perform
        num_additions = 256;
        seed = 32'hDEADBEEF;

        // Perform test additions with enable toggling
        for (i = 0; i < num_additions; i = i + 1) begin
            @(posedge clk);
            enable = 1;

            // Generate varied input patterns
            // Mix of sequential, random-ish, and corner cases
            case (i % 8)
                0: begin
                    // Sequential counting
                    a = i[7:0];
                    b = (num_additions - i - 1);
                end
                1: begin
                    // All zeros
                    a = 8'h00;
                    b = 8'h00;
                end
                2: begin
                    // All ones
                    a = 8'hFF;
                    b = 8'hFF;
                end
                3: begin
                    // Alternating bits
                    a = 8'hAA;
                    b = 8'h55;
                end
                4: begin
                    // Single bit walking
                    a = 8'h01 << (i % 8);
                    b = 8'h80 >> (i % 8);
                end
                5: begin
                    // Pseudo-random using LFSR-style update
                    seed = seed ^ (seed << 13);
                    seed = seed ^ (seed >> 17);
                    seed = seed ^ (seed << 5);
                    a = seed[7:0];
                    b = seed[15:8];
                end
                6: begin
                    // Carry propagation stress test
                    a = 8'hFF;
                    b = 8'h01;
                end
                7: begin
                    // Another carry test
                    a = 8'h7F;
                    b = 8'h01;
                end
            endcase

            // Toggle carry-in periodically
            cin = (i % 4 == 0) ? 1'b1 : 1'b0;

`ifdef DUT_REVERSIBLE
            // Ancilla bits must always be zero for correct operation
            anc = 8'h00;
`endif

            @(posedge clk);
            enable = 0; // Hold inputs for one cycle

            // Allow output registers to update
            @(posedge clk);
        end

        // Additional idle cycles to capture final settling
        repeat(10) @(posedge clk);

        $display("INFO: Simulation complete. %0d additions performed.", num_additions);
        $finish;
    end

    // Optional: Basic output checking (comment out for pure power measurement)
    // This helps verify the DUT is working correctly
`ifdef CHECK_OUTPUTS
    reg [8:0] expected_sum;
    always @(posedge clk) begin
        if (!reset && enable) begin
            expected_sum = a + b + cin;
            // Check after 2 clock cycles (1 for input reg, 1 for output reg)
            #(CLOCK_PERIOD * 2);
            if ({cout, sum} !== expected_sum) begin
                $display("ERROR at time %0t: a=%h, b=%h, cin=%b -> expected %h, got %h",
                         $time, a, b, cin, expected_sum, {cout, sum});
            end
        end
    end
`endif

endmodule

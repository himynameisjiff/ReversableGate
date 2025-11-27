`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// tb_common_gl.v
//
// Common gate-level testbench for all three adder designs.
// Exercises the DUT with various input patterns and generates a VCD file.
//
// Compile-time defines (pass one of these to select which design to test):
//   SIM_REVERSIBLE   - Simulate reversible_wrapper
//   SIM_RIPPLE       - Simulate ripple_adder_wrapper
//   SIM_CARRY_SELECT - Simulate carry_select_wrapper
//
// Additional defines:
//   VCD_FILE  - Path to VCD output file (default: "dump.vcd")
//
// Port differences:
//   - reversible_wrapper: clk, reset, enable, a, b, anc, cin, sum, cout, g_a, g_ab, VPWR, VGND
//   - ripple_adder_wrapper: clk, reset, enable, a, b, cin, sum, cout, VPWR, VGND
//   - carry_select_wrapper: clk, reset, a, b, cin, sum, cout, VPWR, VGND (no enable)
///////////////////////////////////////////////////////////////////////////////

module tb_common_gl;

    // ========================== Parameters ==================================
    parameter CLK_PERIOD = 10;  // 100 MHz clock
    parameter NUM_TESTS = 20;   // Number of random test vectors

    // ========================== Signals =====================================
    reg         clk;
    reg         reset;
    reg         enable;
    reg  [7:0]  a;
    reg  [7:0]  b;
    reg  [7:0]  anc;
    reg         cin;

    wire [7:0]  sum;
    wire        cout;
    wire [7:0]  g_a;
    wire [7:0]  g_ab;

    // Power supply nets for gate-level simulation
    wire        VPWR = 1'b1;
    wire        VGND = 1'b0;

    // ========================== DUT Instantiation ===========================
    // The correct module is selected by which netlist is compiled in.
    // We instantiate all possible modules conditionally.

`ifdef SIM_REVERSIBLE
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
`elsif SIM_RIPPLE
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
`elsif SIM_CARRY_SELECT
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
    // Error if no design is selected at compile time
    initial begin
        $display("ERROR: No design selected!");
        $display("Pass one of: -DSIM_REVERSIBLE, -DSIM_RIPPLE, or -DSIM_CARRY_SELECT");
        $finish;
    end
`endif

    // ========================== Clock Generation ============================
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // ========================== VCD Dump ====================================
    initial begin
        `ifdef VCD_FILE
            $dumpfile(`VCD_FILE);
        `else
            $dumpfile("dump.vcd");
        `endif
        $dumpvars(0, tb_common_gl);
    end

    // ========================== Test Sequence ===============================
    integer i;
    integer seed;

    initial begin
        // Display test info
        `ifdef SIM_REVERSIBLE
            $display("========================================");
            $display(" Gate-Level Simulation: reversible_wrapper");
            $display("========================================");
        `elsif SIM_RIPPLE
            $display("========================================");
            $display(" Gate-Level Simulation: ripple_adder_wrapper");
            $display("========================================");
        `elsif SIM_CARRY_SELECT
            $display("========================================");
            $display(" Gate-Level Simulation: carry_select_wrapper");
            $display("========================================");
        `else
            $display("========================================");
            $display(" Gate-Level Simulation");
            $display("========================================");
        `endif

        // Initialize
        seed = 12345;
        reset = 1;
        enable = 0;
        a = 8'h00;
        b = 8'h00;
        anc = 8'h00;
        cin = 0;

        // Hold reset for a few cycles
        repeat(5) @(posedge clk);
        reset = 0;
        @(posedge clk);

        // Enable inputs
        enable = 1;

        $display("Starting test vectors...");

        // Test 1: Zero + Zero
        a = 8'h00; b = 8'h00; cin = 0;
        @(posedge clk);
        repeat(2) @(posedge clk);  // Wait for pipeline
        $display("Test %2d: %h + %h + %b = %h, cout=%b", 1, a, b, cin, sum, cout);

        // Test 2: Max + Max
        a = 8'hFF; b = 8'hFF; cin = 1;
        @(posedge clk);
        repeat(2) @(posedge clk);
        $display("Test %2d: %h + %h + %b = %h, cout=%b", 2, a, b, cin, sum, cout);

        // Test 3: Alternating bits
        a = 8'hAA; b = 8'h55; cin = 0;
        @(posedge clk);
        repeat(2) @(posedge clk);
        $display("Test %2d: %h + %h + %b = %h, cout=%b", 3, a, b, cin, sum, cout);

        // Test 4-NUM_TESTS: Random vectors
        for (i = 4; i <= NUM_TESTS; i = i + 1) begin
            a = $random(seed);
            b = $random(seed);
            cin = $random(seed) & 1;
            @(posedge clk);
            repeat(2) @(posedge clk);
            $display("Test %2d: %h + %h + %b = %h, cout=%b", i, a, b, cin, sum, cout);
        end

        // Additional switching activity for power analysis
        $display("Running additional switching activity...");
        for (i = 0; i < 100; i = i + 1) begin
            a = $random(seed);
            b = $random(seed);
            cin = $random(seed) & 1;
            @(posedge clk);
        end

        // Disable and wait
        enable = 0;
        repeat(5) @(posedge clk);

        $display("========================================");
        $display(" Simulation Complete");
        $display("========================================");
        $finish;
    end

    // ========================== Timeout Watchdog ============================
    initial begin
        #100000;  // 100us timeout
        $display("ERROR: Simulation timeout!");
        $finish;
    end

endmodule

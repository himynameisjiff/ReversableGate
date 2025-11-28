`timescale 1ns / 1ps

// Common gate-level testbench for power analysis
// Uses SIM_* defines to select the design under test:
//   -DSIM_REVERSIBLE  : Test reversible_wrapper
//   -DSIM_RIPPLE      : Test ripple_adder_wrapper
//   -DSIM_CARRY_SELECT: Test carry_select_wrapper

module tb_common_gl;

    // Clock period in ns
    parameter CLK_PERIOD = 10;
    
    // Testbench signals
    reg         clk;
    reg         reset;
    reg         enable;
    reg  [7:0]  a;
    reg  [7:0]  b;
    reg         cin;
    
    // Common outputs
    wire [7:0]  sum;
    wire        cout;
    
`ifdef SIM_REVERSIBLE
    // Additional signals for reversible design
    reg  [7:0]  anc;
    wire [7:0]  g_a;
    wire [7:0]  g_ab;
    
    // Instantiate reversible_wrapper
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
        .g_ab(g_ab)
    );
    
    initial begin
        $display("Testbench: reversible_wrapper");
    end

`elsif SIM_RIPPLE
    // Instantiate ripple_adder_wrapper
    ripple_adder_wrapper dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    initial begin
        $display("Testbench: ripple_adder_wrapper");
    end

`elsif SIM_CARRY_SELECT
    // Instantiate carry_select_wrapper
    carry_select_wrapper dut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    initial begin
        $display("Testbench: carry_select_wrapper");
    end

`else
    // No design selected - error
    initial begin
        $display("ERROR: No design selected.");
        $display("       Use -DSIM_REVERSIBLE, -DSIM_RIPPLE, or -DSIM_CARRY_SELECT");
        $finish;
    end
`endif

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // VCD dump - use +vcd_file plusarg if provided
    initial begin
        string vcd_filename;
        if ($value$plusargs("vcd_file=%s", vcd_filename)) begin
            $dumpfile(vcd_filename);
        end else begin
`ifdef SIM_REVERSIBLE
            $dumpfile("reversible.vcd");
`elsif SIM_RIPPLE
            $dumpfile("ripple.vcd");
`elsif SIM_CARRY_SELECT
            $dumpfile("carry_select.vcd");
`else
            $dumpfile("simulation.vcd");
`endif
        end
        $dumpvars(0, tb_common_gl);
    end
    
    // Test stimulus
    initial begin
        // Initialize
        reset = 1;
        enable = 0;
        a = 8'h00;
        b = 8'h00;
        cin = 0;
`ifdef SIM_REVERSIBLE
        anc = 8'h00;
`endif
        
        // Release reset after a few cycles
        repeat (3) @(posedge clk);
        reset = 0;
        
        // Enable and start testing
        @(posedge clk);
        enable = 1;
        
        // Test case 1: Simple addition
        a = 8'h01;
        b = 8'h02;
        cin = 0;
        repeat (2) @(posedge clk);
        
        // Test case 2: Addition with carry-in
        a = 8'h0F;
        b = 8'h01;
        cin = 1;
        repeat (2) @(posedge clk);
        
        // Test case 3: Larger values
        a = 8'h55;
        b = 8'hAA;
        cin = 0;
        repeat (2) @(posedge clk);
        
        // Test case 4: Maximum values
        a = 8'hFF;
        b = 8'hFF;
        cin = 1;
        repeat (2) @(posedge clk);
        
        // Test case 5: Random patterns
        repeat (20) begin
            a = $random;
            b = $random;
            cin = $random & 1;
            repeat (2) @(posedge clk);
        end
        
        // Test case 6: All zeros
        a = 8'h00;
        b = 8'h00;
        cin = 0;
        repeat (2) @(posedge clk);
        
        // Test case 7: Alternating patterns
        a = 8'hAA;
        b = 8'h55;
        cin = 0;
        repeat (2) @(posedge clk);
        
        a = 8'h55;
        b = 8'hAA;
        cin = 1;
        repeat (2) @(posedge clk);
        
        // More random testing for power analysis
        repeat (50) begin
            a = $random;
            b = $random;
            cin = $random & 1;
            @(posedge clk);
        end
        
        // Finish simulation
        $display("Simulation complete.");
        $finish;
    end
    
    // Timeout watchdog
    initial begin
        #10000;
        $display("TIMEOUT: Simulation exceeded maximum time.");
        $finish;
    end

endmodule

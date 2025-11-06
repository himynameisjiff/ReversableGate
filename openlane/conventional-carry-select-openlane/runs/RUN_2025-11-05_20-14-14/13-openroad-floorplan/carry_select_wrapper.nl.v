module carry_select_wrapper (cin,
    clk,
    cout,
    reset,
    a,
    b,
    sum);
 input cin;
 input clk;
 output cout;
 input reset;
 input [7:0] a;
 input [7:0] b;
 output [7:0] sum;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire cin_r;
 wire cout_c;
 wire \sum_c[0] ;
 wire \sum_c[1] ;
 wire \sum_c[2] ;
 wire \sum_c[3] ;
 wire \sum_c[4] ;
 wire \sum_c[5] ;
 wire \sum_c[6] ;
 wire \sum_c[7] ;
 wire \u_cs.hi_block_c0.fa0.a ;
 wire \u_cs.hi_block_c0.fa0.b ;
 wire \u_cs.hi_block_c0.fa1.a ;
 wire \u_cs.hi_block_c0.fa1.b ;
 wire \u_cs.hi_block_c0.fa2.a ;
 wire \u_cs.hi_block_c0.fa2.b ;
 wire \u_cs.hi_block_c0.fa3.a ;
 wire \u_cs.hi_block_c0.fa3.b ;
 wire \u_cs.lo_block.fa0.a ;
 wire \u_cs.lo_block.fa0.b ;
 wire \u_cs.lo_block.fa1.a ;
 wire \u_cs.lo_block.fa1.b ;
 wire \u_cs.lo_block.fa2.a ;
 wire \u_cs.lo_block.fa2.b ;
 wire \u_cs.lo_block.fa3.a ;
 wire \u_cs.lo_block.fa3.b ;

 sky130_fd_sc_hd__inv_2 _068_ (.A(reset),
    .Y(_000_));
 sky130_fd_sc_hd__nand2_2 _069_ (.A(\u_cs.lo_block.fa0.a ),
    .B(cin_r),
    .Y(_028_));
 sky130_fd_sc_hd__or2_2 _070_ (.A(\u_cs.lo_block.fa0.a ),
    .B(cin_r),
    .X(_029_));
 sky130_fd_sc_hd__and3_2 _071_ (.A(\u_cs.lo_block.fa0.b ),
    .B(_028_),
    .C(_029_),
    .X(_030_));
 sky130_fd_sc_hd__a21boi_2 _072_ (.A1(\u_cs.lo_block.fa0.b ),
    .A2(_029_),
    .B1_N(_028_),
    .Y(_031_));
 sky130_fd_sc_hd__and2b_2 _073_ (.A_N(_031_),
    .B(\u_cs.lo_block.fa1.a ),
    .X(_032_));
 sky130_fd_sc_hd__xnor2_2 _074_ (.A(\u_cs.lo_block.fa1.a ),
    .B(_031_),
    .Y(_033_));
 sky130_fd_sc_hd__a21oi_2 _075_ (.A1(\u_cs.lo_block.fa1.b ),
    .A2(_033_),
    .B1(_032_),
    .Y(_034_));
 sky130_fd_sc_hd__and2b_2 _076_ (.A_N(_034_),
    .B(\u_cs.lo_block.fa2.a ),
    .X(_035_));
 sky130_fd_sc_hd__inv_2 _077_ (.A(_035_),
    .Y(_036_));
 sky130_fd_sc_hd__xnor2_2 _078_ (.A(\u_cs.lo_block.fa2.a ),
    .B(_034_),
    .Y(_037_));
 sky130_fd_sc_hd__nand2_2 _079_ (.A(\u_cs.lo_block.fa2.b ),
    .B(_037_),
    .Y(_038_));
 sky130_fd_sc_hd__a21boi_2 _080_ (.A1(_036_),
    .A2(_038_),
    .B1_N(\u_cs.lo_block.fa3.a ),
    .Y(_039_));
 sky130_fd_sc_hd__or3b_2 _081_ (.A(\u_cs.lo_block.fa3.a ),
    .B(_035_),
    .C_N(_038_),
    .X(_040_));
 sky130_fd_sc_hd__and2b_2 _082_ (.A_N(_039_),
    .B(_040_),
    .X(_041_));
 sky130_fd_sc_hd__a21oi_2 _083_ (.A1(\u_cs.lo_block.fa3.b ),
    .A2(_040_),
    .B1(_039_),
    .Y(_042_));
 sky130_fd_sc_hd__xnor2_2 _084_ (.A(\u_cs.hi_block_c0.fa3.a ),
    .B(\u_cs.hi_block_c0.fa3.b ),
    .Y(_043_));
 sky130_fd_sc_hd__nand2_2 _085_ (.A(\u_cs.hi_block_c0.fa2.a ),
    .B(\u_cs.hi_block_c0.fa2.b ),
    .Y(_044_));
 sky130_fd_sc_hd__or2_2 _086_ (.A(\u_cs.hi_block_c0.fa2.a ),
    .B(\u_cs.hi_block_c0.fa2.b ),
    .X(_045_));
 sky130_fd_sc_hd__nand2_2 _087_ (.A(_044_),
    .B(_045_),
    .Y(_046_));
 sky130_fd_sc_hd__nor2_2 _088_ (.A(\u_cs.hi_block_c0.fa1.a ),
    .B(\u_cs.hi_block_c0.fa1.b ),
    .Y(_047_));
 sky130_fd_sc_hd__nand2_2 _089_ (.A(\u_cs.hi_block_c0.fa1.a ),
    .B(\u_cs.hi_block_c0.fa1.b ),
    .Y(_048_));
 sky130_fd_sc_hd__nor2_2 _090_ (.A(\u_cs.hi_block_c0.fa0.a ),
    .B(\u_cs.hi_block_c0.fa0.b ),
    .Y(_049_));
 sky130_fd_sc_hd__o21a_2 _091_ (.A1(_047_),
    .A2(_049_),
    .B1(_048_),
    .X(_050_));
 sky130_fd_sc_hd__or2_2 _092_ (.A(_046_),
    .B(_050_),
    .X(_051_));
 sky130_fd_sc_hd__nand2_2 _093_ (.A(_044_),
    .B(_051_),
    .Y(_052_));
 sky130_fd_sc_hd__xnor2_2 _094_ (.A(_043_),
    .B(_052_),
    .Y(_053_));
 sky130_fd_sc_hd__nand2b_2 _095_ (.A_N(_047_),
    .B(_048_),
    .Y(_054_));
 sky130_fd_sc_hd__nand2_2 _096_ (.A(\u_cs.hi_block_c0.fa0.a ),
    .B(\u_cs.hi_block_c0.fa0.b ),
    .Y(_055_));
 sky130_fd_sc_hd__o21a_2 _097_ (.A1(_047_),
    .A2(_055_),
    .B1(_048_),
    .X(_056_));
 sky130_fd_sc_hd__nor2_2 _098_ (.A(_046_),
    .B(_056_),
    .Y(_057_));
 sky130_fd_sc_hd__inv_2 _099_ (.A(_057_),
    .Y(_058_));
 sky130_fd_sc_hd__and3_2 _100_ (.A(_043_),
    .B(_044_),
    .C(_058_),
    .X(_059_));
 sky130_fd_sc_hd__a21oi_2 _101_ (.A1(_044_),
    .A2(_058_),
    .B1(_043_),
    .Y(_060_));
 sky130_fd_sc_hd__nor2_2 _102_ (.A(_059_),
    .B(_060_),
    .Y(_061_));
 sky130_fd_sc_hd__mux2_1 _103_ (.A0(_053_),
    .A1(_061_),
    .S(_042_),
    .X(\sum_c[7] ));
 sky130_fd_sc_hd__nand2_2 _104_ (.A(_046_),
    .B(_056_),
    .Y(_062_));
 sky130_fd_sc_hd__a21oi_2 _105_ (.A1(_046_),
    .A2(_050_),
    .B1(_042_),
    .Y(_063_));
 sky130_fd_sc_hd__a32o_2 _106_ (.A1(_042_),
    .A2(_058_),
    .A3(_062_),
    .B1(_063_),
    .B2(_051_),
    .X(\sum_c[6] ));
 sky130_fd_sc_hd__and2b_2 _107_ (.A_N(_049_),
    .B(_055_),
    .X(_064_));
 sky130_fd_sc_hd__nand2b_2 _108_ (.A_N(_042_),
    .B(_064_),
    .Y(_065_));
 sky130_fd_sc_hd__xor2_2 _109_ (.A(_054_),
    .B(_055_),
    .X(_066_));
 sky130_fd_sc_hd__mux2_1 _110_ (.A0(_054_),
    .A1(_066_),
    .S(_065_),
    .X(\sum_c[5] ));
 sky130_fd_sc_hd__xnor2_2 _111_ (.A(_042_),
    .B(_064_),
    .Y(\sum_c[4] ));
 sky130_fd_sc_hd__nor3b_2 _112_ (.A(_042_),
    .B(_043_),
    .C_N(_052_),
    .Y(_067_));
 sky130_fd_sc_hd__a211o_2 _113_ (.A1(\u_cs.hi_block_c0.fa3.a ),
    .A2(\u_cs.hi_block_c0.fa3.b ),
    .B1(_060_),
    .C1(_067_),
    .X(cout_c));
 sky130_fd_sc_hd__a21oi_2 _114_ (.A1(_028_),
    .A2(_029_),
    .B1(\u_cs.lo_block.fa0.b ),
    .Y(_026_));
 sky130_fd_sc_hd__nor2_2 _115_ (.A(_030_),
    .B(_026_),
    .Y(\sum_c[0] ));
 sky130_fd_sc_hd__xor2_2 _116_ (.A(\u_cs.lo_block.fa1.b ),
    .B(_033_),
    .X(\sum_c[1] ));
 sky130_fd_sc_hd__or2_2 _117_ (.A(\u_cs.lo_block.fa2.b ),
    .B(_037_),
    .X(_027_));
 sky130_fd_sc_hd__and2_2 _118_ (.A(_038_),
    .B(_027_),
    .X(\sum_c[2] ));
 sky130_fd_sc_hd__xor2_2 _119_ (.A(\u_cs.lo_block.fa3.b ),
    .B(_041_),
    .X(\sum_c[3] ));
 sky130_fd_sc_hd__inv_2 _120_ (.A(reset),
    .Y(_001_));
 sky130_fd_sc_hd__inv_2 _121_ (.A(reset),
    .Y(_002_));
 sky130_fd_sc_hd__inv_2 _122_ (.A(reset),
    .Y(_003_));
 sky130_fd_sc_hd__inv_2 _123_ (.A(reset),
    .Y(_004_));
 sky130_fd_sc_hd__inv_2 _124_ (.A(reset),
    .Y(_005_));
 sky130_fd_sc_hd__inv_2 _125_ (.A(reset),
    .Y(_006_));
 sky130_fd_sc_hd__inv_2 _126_ (.A(reset),
    .Y(_007_));
 sky130_fd_sc_hd__inv_2 _127_ (.A(reset),
    .Y(_008_));
 sky130_fd_sc_hd__inv_2 _128_ (.A(reset),
    .Y(_009_));
 sky130_fd_sc_hd__inv_2 _129_ (.A(reset),
    .Y(_010_));
 sky130_fd_sc_hd__inv_2 _130_ (.A(reset),
    .Y(_011_));
 sky130_fd_sc_hd__inv_2 _131_ (.A(reset),
    .Y(_012_));
 sky130_fd_sc_hd__inv_2 _132_ (.A(reset),
    .Y(_013_));
 sky130_fd_sc_hd__inv_2 _133_ (.A(reset),
    .Y(_014_));
 sky130_fd_sc_hd__inv_2 _134_ (.A(reset),
    .Y(_015_));
 sky130_fd_sc_hd__inv_2 _135_ (.A(reset),
    .Y(_016_));
 sky130_fd_sc_hd__inv_2 _136_ (.A(reset),
    .Y(_017_));
 sky130_fd_sc_hd__inv_2 _137_ (.A(reset),
    .Y(_018_));
 sky130_fd_sc_hd__inv_2 _138_ (.A(reset),
    .Y(_019_));
 sky130_fd_sc_hd__inv_2 _139_ (.A(reset),
    .Y(_020_));
 sky130_fd_sc_hd__inv_2 _140_ (.A(reset),
    .Y(_021_));
 sky130_fd_sc_hd__inv_2 _141_ (.A(reset),
    .Y(_022_));
 sky130_fd_sc_hd__inv_2 _142_ (.A(reset),
    .Y(_023_));
 sky130_fd_sc_hd__inv_2 _143_ (.A(reset),
    .Y(_024_));
 sky130_fd_sc_hd__inv_2 _144_ (.A(reset),
    .Y(_025_));
 sky130_fd_sc_hd__dfrtp_2 _145_ (.CLK(clk),
    .D(\sum_c[0] ),
    .RESET_B(_000_),
    .Q(sum[0]));
 sky130_fd_sc_hd__dfrtp_2 _146_ (.CLK(clk),
    .D(\sum_c[1] ),
    .RESET_B(_001_),
    .Q(sum[1]));
 sky130_fd_sc_hd__dfrtp_2 _147_ (.CLK(clk),
    .D(\sum_c[2] ),
    .RESET_B(_002_),
    .Q(sum[2]));
 sky130_fd_sc_hd__dfrtp_2 _148_ (.CLK(clk),
    .D(\sum_c[3] ),
    .RESET_B(_003_),
    .Q(sum[3]));
 sky130_fd_sc_hd__dfrtp_2 _149_ (.CLK(clk),
    .D(\sum_c[4] ),
    .RESET_B(_004_),
    .Q(sum[4]));
 sky130_fd_sc_hd__dfrtp_2 _150_ (.CLK(clk),
    .D(\sum_c[5] ),
    .RESET_B(_005_),
    .Q(sum[5]));
 sky130_fd_sc_hd__dfrtp_2 _151_ (.CLK(clk),
    .D(\sum_c[6] ),
    .RESET_B(_006_),
    .Q(sum[6]));
 sky130_fd_sc_hd__dfrtp_2 _152_ (.CLK(clk),
    .D(\sum_c[7] ),
    .RESET_B(_007_),
    .Q(sum[7]));
 sky130_fd_sc_hd__dfrtp_2 _153_ (.CLK(clk),
    .D(cout_c),
    .RESET_B(_008_),
    .Q(cout));
 sky130_fd_sc_hd__dfrtp_2 _154_ (.CLK(clk),
    .D(a[0]),
    .RESET_B(_009_),
    .Q(\u_cs.lo_block.fa0.a ));
 sky130_fd_sc_hd__dfrtp_2 _155_ (.CLK(clk),
    .D(a[1]),
    .RESET_B(_010_),
    .Q(\u_cs.lo_block.fa1.a ));
 sky130_fd_sc_hd__dfrtp_2 _156_ (.CLK(clk),
    .D(a[2]),
    .RESET_B(_011_),
    .Q(\u_cs.lo_block.fa2.a ));
 sky130_fd_sc_hd__dfrtp_2 _157_ (.CLK(clk),
    .D(a[3]),
    .RESET_B(_012_),
    .Q(\u_cs.lo_block.fa3.a ));
 sky130_fd_sc_hd__dfrtp_2 _158_ (.CLK(clk),
    .D(a[4]),
    .RESET_B(_013_),
    .Q(\u_cs.hi_block_c0.fa0.a ));
 sky130_fd_sc_hd__dfrtp_2 _159_ (.CLK(clk),
    .D(a[5]),
    .RESET_B(_014_),
    .Q(\u_cs.hi_block_c0.fa1.a ));
 sky130_fd_sc_hd__dfrtp_2 _160_ (.CLK(clk),
    .D(a[6]),
    .RESET_B(_015_),
    .Q(\u_cs.hi_block_c0.fa2.a ));
 sky130_fd_sc_hd__dfrtp_2 _161_ (.CLK(clk),
    .D(a[7]),
    .RESET_B(_016_),
    .Q(\u_cs.hi_block_c0.fa3.a ));
 sky130_fd_sc_hd__dfrtp_2 _162_ (.CLK(clk),
    .D(b[0]),
    .RESET_B(_017_),
    .Q(\u_cs.lo_block.fa0.b ));
 sky130_fd_sc_hd__dfrtp_2 _163_ (.CLK(clk),
    .D(b[1]),
    .RESET_B(_018_),
    .Q(\u_cs.lo_block.fa1.b ));
 sky130_fd_sc_hd__dfrtp_2 _164_ (.CLK(clk),
    .D(b[2]),
    .RESET_B(_019_),
    .Q(\u_cs.lo_block.fa2.b ));
 sky130_fd_sc_hd__dfrtp_2 _165_ (.CLK(clk),
    .D(b[3]),
    .RESET_B(_020_),
    .Q(\u_cs.lo_block.fa3.b ));
 sky130_fd_sc_hd__dfrtp_2 _166_ (.CLK(clk),
    .D(b[4]),
    .RESET_B(_021_),
    .Q(\u_cs.hi_block_c0.fa0.b ));
 sky130_fd_sc_hd__dfrtp_2 _167_ (.CLK(clk),
    .D(b[5]),
    .RESET_B(_022_),
    .Q(\u_cs.hi_block_c0.fa1.b ));
 sky130_fd_sc_hd__dfrtp_2 _168_ (.CLK(clk),
    .D(b[6]),
    .RESET_B(_023_),
    .Q(\u_cs.hi_block_c0.fa2.b ));
 sky130_fd_sc_hd__dfrtp_2 _169_ (.CLK(clk),
    .D(b[7]),
    .RESET_B(_024_),
    .Q(\u_cs.hi_block_c0.fa3.b ));
 sky130_fd_sc_hd__dfrtp_2 _170_ (.CLK(clk),
    .D(cin),
    .RESET_B(_025_),
    .Q(cin_r));
endmodule

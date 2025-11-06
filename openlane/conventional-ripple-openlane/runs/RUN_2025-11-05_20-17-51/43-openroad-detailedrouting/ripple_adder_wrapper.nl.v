module ripple_adder_wrapper (cin,
    clk,
    cout,
    enable,
    reset,
    a,
    b,
    sum);
 input cin;
 input clk;
 output cout;
 input enable;
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
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire _077_;
 wire _078_;
 wire cin_r;
 wire \u_rip.fa0.a ;
 wire \u_rip.fa0.b ;
 wire \u_rip.gen_fa[1].fa.a ;
 wire \u_rip.gen_fa[1].fa.b ;
 wire \u_rip.gen_fa[2].fa.a ;
 wire \u_rip.gen_fa[2].fa.b ;
 wire \u_rip.gen_fa[3].fa.a ;
 wire \u_rip.gen_fa[3].fa.b ;
 wire \u_rip.gen_fa[4].fa.a ;
 wire \u_rip.gen_fa[4].fa.b ;
 wire \u_rip.gen_fa[5].fa.a ;
 wire \u_rip.gen_fa[5].fa.b ;
 wire \u_rip.gen_fa[6].fa.a ;
 wire \u_rip.gen_fa[6].fa.b ;
 wire \u_rip.gen_fa[7].fa.a ;
 wire \u_rip.gen_fa[7].fa.b ;
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
 wire net19;
 wire net20;
 wire net21;
 wire net22;
 wire net23;
 wire net24;
 wire net25;
 wire net26;
 wire net27;
 wire net28;
 wire net29;
 wire net30;
 wire net31;
 wire net32;
 wire net33;
 wire clknet_0_clk;
 wire clknet_1_0__leaf_clk;
 wire clknet_1_1__leaf_clk;
 wire net34;
 wire net35;
 wire net36;
 wire net37;
 wire net38;
 wire net39;
 wire net40;
 wire net41;
 wire net42;

 sky130_fd_sc_hd__or2_1 _079_ (.A(cin_r),
    .B(\u_rip.fa0.a ),
    .X(_048_));
 sky130_fd_sc_hd__nand2_1 _080_ (.A(cin_r),
    .B(\u_rip.fa0.a ),
    .Y(_049_));
 sky130_fd_sc_hd__a21oi_1 _081_ (.A1(_048_),
    .A2(_049_),
    .B1(net42),
    .Y(_050_));
 sky130_fd_sc_hd__and3_1 _082_ (.A(\u_rip.fa0.b ),
    .B(_048_),
    .C(_049_),
    .X(_051_));
 sky130_fd_sc_hd__nor3_1 _083_ (.A(net29),
    .B(_050_),
    .C(_051_),
    .Y(_000_));
 sky130_fd_sc_hd__a21boi_1 _084_ (.A1(\u_rip.fa0.b ),
    .A2(_048_),
    .B1_N(_049_),
    .Y(_052_));
 sky130_fd_sc_hd__nand2b_1 _085_ (.A_N(_052_),
    .B(\u_rip.gen_fa[1].fa.a ),
    .Y(_053_));
 sky130_fd_sc_hd__xnor2_1 _086_ (.A(\u_rip.gen_fa[1].fa.a ),
    .B(_052_),
    .Y(_054_));
 sky130_fd_sc_hd__or2_1 _087_ (.A(\u_rip.gen_fa[1].fa.b ),
    .B(_054_),
    .X(_055_));
 sky130_fd_sc_hd__nand2_1 _088_ (.A(\u_rip.gen_fa[1].fa.b ),
    .B(_054_),
    .Y(_056_));
 sky130_fd_sc_hd__and3b_1 _089_ (.A_N(net30),
    .B(_055_),
    .C(_056_),
    .X(_001_));
 sky130_fd_sc_hd__nand3b_1 _090_ (.A_N(\u_rip.gen_fa[2].fa.a ),
    .B(_053_),
    .C(_056_),
    .Y(_057_));
 sky130_fd_sc_hd__a21bo_1 _091_ (.A1(_053_),
    .A2(_056_),
    .B1_N(\u_rip.gen_fa[2].fa.a ),
    .X(_058_));
 sky130_fd_sc_hd__and2_1 _092_ (.A(_057_),
    .B(_058_),
    .X(_059_));
 sky130_fd_sc_hd__a21oi_1 _093_ (.A1(\u_rip.gen_fa[2].fa.b ),
    .A2(_059_),
    .B1(net30),
    .Y(_060_));
 sky130_fd_sc_hd__o21a_1 _094_ (.A1(net40),
    .A2(_059_),
    .B1(_060_),
    .X(_002_));
 sky130_fd_sc_hd__a21bo_1 _095_ (.A1(\u_rip.gen_fa[2].fa.b ),
    .A2(_057_),
    .B1_N(_058_),
    .X(_061_));
 sky130_fd_sc_hd__nand2_1 _096_ (.A(\u_rip.gen_fa[3].fa.a ),
    .B(_061_),
    .Y(_062_));
 sky130_fd_sc_hd__xor2_1 _097_ (.A(\u_rip.gen_fa[3].fa.a ),
    .B(_061_),
    .X(_063_));
 sky130_fd_sc_hd__or2_1 _098_ (.A(\u_rip.gen_fa[3].fa.b ),
    .B(_063_),
    .X(_064_));
 sky130_fd_sc_hd__nand2_1 _099_ (.A(\u_rip.gen_fa[3].fa.b ),
    .B(_063_),
    .Y(_065_));
 sky130_fd_sc_hd__and3b_1 _100_ (.A_N(net30),
    .B(_064_),
    .C(_065_),
    .X(_003_));
 sky130_fd_sc_hd__nand3b_1 _101_ (.A_N(\u_rip.gen_fa[4].fa.a ),
    .B(_062_),
    .C(_065_),
    .Y(_066_));
 sky130_fd_sc_hd__a21bo_1 _102_ (.A1(_062_),
    .A2(_065_),
    .B1_N(\u_rip.gen_fa[4].fa.a ),
    .X(_067_));
 sky130_fd_sc_hd__and2_1 _103_ (.A(_066_),
    .B(_067_),
    .X(_068_));
 sky130_fd_sc_hd__a21oi_1 _104_ (.A1(\u_rip.gen_fa[4].fa.b ),
    .A2(_068_),
    .B1(net30),
    .Y(_069_));
 sky130_fd_sc_hd__o21a_1 _105_ (.A1(net36),
    .A2(_068_),
    .B1(_069_),
    .X(_004_));
 sky130_fd_sc_hd__a21bo_1 _106_ (.A1(\u_rip.gen_fa[4].fa.b ),
    .A2(_066_),
    .B1_N(_067_),
    .X(_070_));
 sky130_fd_sc_hd__nand2_1 _107_ (.A(\u_rip.gen_fa[5].fa.a ),
    .B(_070_),
    .Y(_071_));
 sky130_fd_sc_hd__xor2_1 _108_ (.A(\u_rip.gen_fa[5].fa.a ),
    .B(_070_),
    .X(_072_));
 sky130_fd_sc_hd__or2_1 _109_ (.A(\u_rip.gen_fa[5].fa.b ),
    .B(_072_),
    .X(_073_));
 sky130_fd_sc_hd__nand2_1 _110_ (.A(\u_rip.gen_fa[5].fa.b ),
    .B(_072_),
    .Y(_074_));
 sky130_fd_sc_hd__and3b_1 _111_ (.A_N(net29),
    .B(_073_),
    .C(_074_),
    .X(_005_));
 sky130_fd_sc_hd__nand3b_1 _112_ (.A_N(\u_rip.gen_fa[6].fa.a ),
    .B(_071_),
    .C(_074_),
    .Y(_075_));
 sky130_fd_sc_hd__a21bo_1 _113_ (.A1(_071_),
    .A2(_074_),
    .B1_N(\u_rip.gen_fa[6].fa.a ),
    .X(_076_));
 sky130_fd_sc_hd__and2_1 _114_ (.A(_075_),
    .B(_076_),
    .X(_077_));
 sky130_fd_sc_hd__a21oi_1 _115_ (.A1(\u_rip.gen_fa[6].fa.b ),
    .A2(_077_),
    .B1(net29),
    .Y(_078_));
 sky130_fd_sc_hd__o21a_1 _116_ (.A1(net34),
    .A2(_077_),
    .B1(_078_),
    .X(_006_));
 sky130_fd_sc_hd__a21boi_1 _117_ (.A1(\u_rip.gen_fa[6].fa.b ),
    .A2(_075_),
    .B1_N(_076_),
    .Y(_026_));
 sky130_fd_sc_hd__nand2b_1 _118_ (.A_N(_026_),
    .B(\u_rip.gen_fa[7].fa.a ),
    .Y(_027_));
 sky130_fd_sc_hd__xnor2_1 _119_ (.A(\u_rip.gen_fa[7].fa.a ),
    .B(_026_),
    .Y(_028_));
 sky130_fd_sc_hd__or2_1 _120_ (.A(\u_rip.gen_fa[7].fa.b ),
    .B(_028_),
    .X(_029_));
 sky130_fd_sc_hd__nand2_1 _121_ (.A(net38),
    .B(_028_),
    .Y(_030_));
 sky130_fd_sc_hd__and3b_1 _122_ (.A_N(net30),
    .B(_029_),
    .C(_030_),
    .X(_007_));
 sky130_fd_sc_hd__mux2_1 _123_ (.A0(\u_rip.fa0.a ),
    .A1(net1),
    .S(net32),
    .X(_031_));
 sky130_fd_sc_hd__and2b_1 _124_ (.A_N(net29),
    .B(_031_),
    .X(_008_));
 sky130_fd_sc_hd__mux2_1 _125_ (.A0(\u_rip.gen_fa[1].fa.a ),
    .A1(net2),
    .S(net32),
    .X(_032_));
 sky130_fd_sc_hd__and2b_1 _126_ (.A_N(net29),
    .B(_032_),
    .X(_009_));
 sky130_fd_sc_hd__mux2_1 _127_ (.A0(\u_rip.gen_fa[2].fa.a ),
    .A1(net3),
    .S(net32),
    .X(_033_));
 sky130_fd_sc_hd__and2b_1 _128_ (.A_N(net30),
    .B(_033_),
    .X(_010_));
 sky130_fd_sc_hd__mux2_1 _129_ (.A0(\u_rip.gen_fa[3].fa.a ),
    .A1(net4),
    .S(net33),
    .X(_034_));
 sky130_fd_sc_hd__and2b_1 _130_ (.A_N(net30),
    .B(_034_),
    .X(_011_));
 sky130_fd_sc_hd__mux2_1 _131_ (.A0(\u_rip.gen_fa[4].fa.a ),
    .A1(net5),
    .S(net33),
    .X(_035_));
 sky130_fd_sc_hd__and2b_1 _132_ (.A_N(net31),
    .B(_035_),
    .X(_012_));
 sky130_fd_sc_hd__mux2_1 _133_ (.A0(\u_rip.gen_fa[5].fa.a ),
    .A1(net6),
    .S(net32),
    .X(_036_));
 sky130_fd_sc_hd__and2b_1 _134_ (.A_N(net29),
    .B(_036_),
    .X(_013_));
 sky130_fd_sc_hd__mux2_1 _135_ (.A0(\u_rip.gen_fa[6].fa.a ),
    .A1(net7),
    .S(net32),
    .X(_037_));
 sky130_fd_sc_hd__and2b_1 _136_ (.A_N(net29),
    .B(_037_),
    .X(_014_));
 sky130_fd_sc_hd__mux2_1 _137_ (.A0(\u_rip.gen_fa[7].fa.a ),
    .A1(net8),
    .S(net32),
    .X(_038_));
 sky130_fd_sc_hd__and2b_1 _138_ (.A_N(net31),
    .B(_038_),
    .X(_015_));
 sky130_fd_sc_hd__mux2_1 _139_ (.A0(\u_rip.fa0.b ),
    .A1(net9),
    .S(net32),
    .X(_039_));
 sky130_fd_sc_hd__and2b_1 _140_ (.A_N(net29),
    .B(_039_),
    .X(_016_));
 sky130_fd_sc_hd__mux2_1 _141_ (.A0(\u_rip.gen_fa[1].fa.b ),
    .A1(net10),
    .S(net33),
    .X(_040_));
 sky130_fd_sc_hd__and2b_1 _142_ (.A_N(net30),
    .B(_040_),
    .X(_017_));
 sky130_fd_sc_hd__mux2_1 _143_ (.A0(\u_rip.gen_fa[2].fa.b ),
    .A1(net11),
    .S(net33),
    .X(_041_));
 sky130_fd_sc_hd__and2b_1 _144_ (.A_N(net30),
    .B(_041_),
    .X(_018_));
 sky130_fd_sc_hd__mux2_1 _145_ (.A0(\u_rip.gen_fa[3].fa.b ),
    .A1(net12),
    .S(net33),
    .X(_042_));
 sky130_fd_sc_hd__and2b_1 _146_ (.A_N(net30),
    .B(_042_),
    .X(_019_));
 sky130_fd_sc_hd__mux2_1 _147_ (.A0(\u_rip.gen_fa[4].fa.b ),
    .A1(net13),
    .S(net33),
    .X(_043_));
 sky130_fd_sc_hd__and2b_1 _148_ (.A_N(net31),
    .B(_043_),
    .X(_020_));
 sky130_fd_sc_hd__mux2_1 _149_ (.A0(\u_rip.gen_fa[5].fa.b ),
    .A1(net14),
    .S(net32),
    .X(_044_));
 sky130_fd_sc_hd__and2b_1 _150_ (.A_N(net29),
    .B(_044_),
    .X(_021_));
 sky130_fd_sc_hd__mux2_1 _151_ (.A0(\u_rip.gen_fa[6].fa.b ),
    .A1(net15),
    .S(net32),
    .X(_045_));
 sky130_fd_sc_hd__and2b_1 _152_ (.A_N(net31),
    .B(_045_),
    .X(_022_));
 sky130_fd_sc_hd__mux2_1 _153_ (.A0(\u_rip.gen_fa[7].fa.b ),
    .A1(net16),
    .S(net33),
    .X(_046_));
 sky130_fd_sc_hd__and2b_1 _154_ (.A_N(net31),
    .B(_046_),
    .X(_023_));
 sky130_fd_sc_hd__mux2_1 _155_ (.A0(cin_r),
    .A1(net17),
    .S(net32),
    .X(_047_));
 sky130_fd_sc_hd__and2b_1 _156_ (.A_N(net29),
    .B(_047_),
    .X(_024_));
 sky130_fd_sc_hd__a21oi_1 _157_ (.A1(_027_),
    .A2(_030_),
    .B1(net31),
    .Y(_025_));
 sky130_fd_sc_hd__dfxtp_1 _158_ (.CLK(clknet_1_0__leaf_clk),
    .D(_000_),
    .Q(net21));
 sky130_fd_sc_hd__dfxtp_1 _159_ (.CLK(clknet_1_0__leaf_clk),
    .D(_001_),
    .Q(net22));
 sky130_fd_sc_hd__dfxtp_1 _160_ (.CLK(clknet_1_0__leaf_clk),
    .D(net41),
    .Q(net23));
 sky130_fd_sc_hd__dfxtp_1 _161_ (.CLK(clknet_1_0__leaf_clk),
    .D(_003_),
    .Q(net24));
 sky130_fd_sc_hd__dfxtp_1 _162_ (.CLK(clknet_1_1__leaf_clk),
    .D(net37),
    .Q(net25));
 sky130_fd_sc_hd__dfxtp_1 _163_ (.CLK(clknet_1_1__leaf_clk),
    .D(_005_),
    .Q(net26));
 sky130_fd_sc_hd__dfxtp_1 _164_ (.CLK(clknet_1_1__leaf_clk),
    .D(net35),
    .Q(net27));
 sky130_fd_sc_hd__dfxtp_1 _165_ (.CLK(clknet_1_1__leaf_clk),
    .D(_007_),
    .Q(net28));
 sky130_fd_sc_hd__dfxtp_1 _166_ (.CLK(clknet_1_0__leaf_clk),
    .D(_008_),
    .Q(\u_rip.fa0.a ));
 sky130_fd_sc_hd__dfxtp_1 _167_ (.CLK(clknet_1_0__leaf_clk),
    .D(_009_),
    .Q(\u_rip.gen_fa[1].fa.a ));
 sky130_fd_sc_hd__dfxtp_1 _168_ (.CLK(clknet_1_0__leaf_clk),
    .D(_010_),
    .Q(\u_rip.gen_fa[2].fa.a ));
 sky130_fd_sc_hd__dfxtp_1 _169_ (.CLK(clknet_1_0__leaf_clk),
    .D(_011_),
    .Q(\u_rip.gen_fa[3].fa.a ));
 sky130_fd_sc_hd__dfxtp_1 _170_ (.CLK(clknet_1_1__leaf_clk),
    .D(_012_),
    .Q(\u_rip.gen_fa[4].fa.a ));
 sky130_fd_sc_hd__dfxtp_1 _171_ (.CLK(clknet_1_1__leaf_clk),
    .D(_013_),
    .Q(\u_rip.gen_fa[5].fa.a ));
 sky130_fd_sc_hd__dfxtp_1 _172_ (.CLK(clknet_1_1__leaf_clk),
    .D(_014_),
    .Q(\u_rip.gen_fa[6].fa.a ));
 sky130_fd_sc_hd__dfxtp_1 _173_ (.CLK(clknet_1_1__leaf_clk),
    .D(_015_),
    .Q(\u_rip.gen_fa[7].fa.a ));
 sky130_fd_sc_hd__dfxtp_1 _174_ (.CLK(clknet_1_0__leaf_clk),
    .D(_016_),
    .Q(\u_rip.fa0.b ));
 sky130_fd_sc_hd__dfxtp_1 _175_ (.CLK(clknet_1_0__leaf_clk),
    .D(_017_),
    .Q(\u_rip.gen_fa[1].fa.b ));
 sky130_fd_sc_hd__dfxtp_1 _176_ (.CLK(clknet_1_0__leaf_clk),
    .D(_018_),
    .Q(\u_rip.gen_fa[2].fa.b ));
 sky130_fd_sc_hd__dfxtp_1 _177_ (.CLK(clknet_1_0__leaf_clk),
    .D(_019_),
    .Q(\u_rip.gen_fa[3].fa.b ));
 sky130_fd_sc_hd__dfxtp_1 _178_ (.CLK(clknet_1_1__leaf_clk),
    .D(_020_),
    .Q(\u_rip.gen_fa[4].fa.b ));
 sky130_fd_sc_hd__dfxtp_1 _179_ (.CLK(clknet_1_0__leaf_clk),
    .D(_021_),
    .Q(\u_rip.gen_fa[5].fa.b ));
 sky130_fd_sc_hd__dfxtp_1 _180_ (.CLK(clknet_1_1__leaf_clk),
    .D(_022_),
    .Q(\u_rip.gen_fa[6].fa.b ));
 sky130_fd_sc_hd__dfxtp_1 _181_ (.CLK(clknet_1_1__leaf_clk),
    .D(_023_),
    .Q(\u_rip.gen_fa[7].fa.b ));
 sky130_fd_sc_hd__dfxtp_1 _182_ (.CLK(clknet_1_0__leaf_clk),
    .D(_024_),
    .Q(cin_r));
 sky130_fd_sc_hd__dfxtp_1 _183_ (.CLK(clknet_1_1__leaf_clk),
    .D(net39),
    .Q(net20));
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Right_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Right_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Right_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_35 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_36 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_37 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_38 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_39 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_62 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_65 ();
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(a[0]),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(a[1]),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(a[2]),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(a[3]),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_1 input5 (.A(a[4]),
    .X(net5));
 sky130_fd_sc_hd__clkbuf_1 input6 (.A(a[5]),
    .X(net6));
 sky130_fd_sc_hd__clkbuf_1 input7 (.A(a[6]),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_1 input8 (.A(a[7]),
    .X(net8));
 sky130_fd_sc_hd__clkbuf_1 input9 (.A(b[0]),
    .X(net9));
 sky130_fd_sc_hd__clkbuf_1 input10 (.A(b[1]),
    .X(net10));
 sky130_fd_sc_hd__clkbuf_1 input11 (.A(b[2]),
    .X(net11));
 sky130_fd_sc_hd__clkbuf_1 input12 (.A(b[3]),
    .X(net12));
 sky130_fd_sc_hd__clkbuf_1 input13 (.A(b[4]),
    .X(net13));
 sky130_fd_sc_hd__clkbuf_1 input14 (.A(b[5]),
    .X(net14));
 sky130_fd_sc_hd__clkbuf_1 input15 (.A(b[6]),
    .X(net15));
 sky130_fd_sc_hd__clkbuf_1 input16 (.A(b[7]),
    .X(net16));
 sky130_fd_sc_hd__clkbuf_1 input17 (.A(cin),
    .X(net17));
 sky130_fd_sc_hd__buf_1 input18 (.A(enable),
    .X(net18));
 sky130_fd_sc_hd__clkbuf_1 input19 (.A(reset),
    .X(net19));
 sky130_fd_sc_hd__buf_2 output20 (.A(net20),
    .X(cout));
 sky130_fd_sc_hd__buf_2 output21 (.A(net21),
    .X(sum[0]));
 sky130_fd_sc_hd__buf_2 output22 (.A(net22),
    .X(sum[1]));
 sky130_fd_sc_hd__buf_2 output23 (.A(net23),
    .X(sum[2]));
 sky130_fd_sc_hd__buf_2 output24 (.A(net24),
    .X(sum[3]));
 sky130_fd_sc_hd__buf_2 output25 (.A(net25),
    .X(sum[4]));
 sky130_fd_sc_hd__buf_2 output26 (.A(net26),
    .X(sum[5]));
 sky130_fd_sc_hd__buf_2 output27 (.A(net27),
    .X(sum[6]));
 sky130_fd_sc_hd__buf_2 output28 (.A(net28),
    .X(sum[7]));
 sky130_fd_sc_hd__clkbuf_2 fanout29 (.A(net31),
    .X(net29));
 sky130_fd_sc_hd__clkbuf_2 fanout30 (.A(net31),
    .X(net30));
 sky130_fd_sc_hd__clkbuf_2 fanout31 (.A(net19),
    .X(net31));
 sky130_fd_sc_hd__clkbuf_4 fanout32 (.A(net18),
    .X(net32));
 sky130_fd_sc_hd__buf_2 fanout33 (.A(net18),
    .X(net33));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f_clk (.A(clknet_0_clk),
    .X(clknet_1_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f_clk (.A(clknet_0_clk),
    .X(clknet_1_1__leaf_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload0 (.A(clknet_1_1__leaf_clk));
 sky130_fd_sc_hd__dlygate4sd3_1 hold1 (.A(\u_rip.gen_fa[6].fa.b ),
    .X(net34));
 sky130_fd_sc_hd__dlygate4sd3_1 hold2 (.A(_006_),
    .X(net35));
 sky130_fd_sc_hd__dlygate4sd3_1 hold3 (.A(\u_rip.gen_fa[4].fa.b ),
    .X(net36));
 sky130_fd_sc_hd__dlygate4sd3_1 hold4 (.A(_004_),
    .X(net37));
 sky130_fd_sc_hd__dlygate4sd3_1 hold5 (.A(\u_rip.gen_fa[7].fa.b ),
    .X(net38));
 sky130_fd_sc_hd__dlygate4sd3_1 hold6 (.A(_025_),
    .X(net39));
 sky130_fd_sc_hd__dlygate4sd3_1 hold7 (.A(\u_rip.gen_fa[2].fa.b ),
    .X(net40));
 sky130_fd_sc_hd__dlygate4sd3_1 hold8 (.A(_002_),
    .X(net41));
 sky130_fd_sc_hd__dlygate4sd3_1 hold9 (.A(\u_rip.fa0.b ),
    .X(net42));
endmodule

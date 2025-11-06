module reversible_wrapper (cin,
    clk,
    cout,
    enable,
    reset,
    a,
    anc,
    b,
    g_a,
    g_ab,
    sum);
 input cin;
 input clk;
 output cout;
 input enable;
 input reset;
 input [7:0] a;
 input [7:0] anc;
 input [7:0] b;
 output [7:0] g_a;
 output [7:0] g_ab;
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
 wire _079_;
 wire _080_;
 wire _081_;
 wire _082_;
 wire _083_;
 wire _084_;
 wire _085_;
 wire _086_;
 wire _087_;
 wire _088_;
 wire _089_;
 wire _090_;
 wire _091_;
 wire _092_;
 wire _093_;
 wire _094_;
 wire _095_;
 wire _096_;
 wire _097_;
 wire _098_;
 wire _099_;
 wire _100_;
 wire _101_;
 wire _102_;
 wire _103_;
 wire _104_;
 wire _105_;
 wire _106_;
 wire _107_;
 wire _108_;
 wire _109_;
 wire _110_;
 wire _111_;
 wire _112_;
 wire _113_;
 wire _114_;
 wire _115_;
 wire _116_;
 wire _117_;
 wire _118_;
 wire _119_;
 wire _120_;
 wire _121_;
 wire _122_;
 wire _123_;
 wire _124_;
 wire _125_;
 wire _126_;
 wire _127_;
 wire _128_;
 wire _129_;
 wire _130_;
 wire _131_;
 wire _132_;
 wire _133_;
 wire _134_;
 wire _135_;
 wire _136_;
 wire _137_;
 wire _138_;
 wire _139_;
 wire _140_;
 wire _141_;
 wire _142_;
 wire cin_r;
 wire \u_rev.rfa_bits[0].fa_ga ;
 wire \u_rev.rfa_bits[0].rfa.anc_in ;
 wire \u_rev.rfa_bits[0].rfa.b ;
 wire \u_rev.rfa_bits[1].fa_ga ;
 wire \u_rev.rfa_bits[1].rfa.anc_in ;
 wire \u_rev.rfa_bits[1].rfa.b ;
 wire \u_rev.rfa_bits[2].fa_ga ;
 wire \u_rev.rfa_bits[2].rfa.anc_in ;
 wire \u_rev.rfa_bits[2].rfa.b ;
 wire \u_rev.rfa_bits[3].fa_ga ;
 wire \u_rev.rfa_bits[3].rfa.anc_in ;
 wire \u_rev.rfa_bits[3].rfa.b ;
 wire \u_rev.rfa_bits[4].fa_ga ;
 wire \u_rev.rfa_bits[4].rfa.anc_in ;
 wire \u_rev.rfa_bits[4].rfa.b ;
 wire \u_rev.rfa_bits[5].fa_ga ;
 wire \u_rev.rfa_bits[5].rfa.anc_in ;
 wire \u_rev.rfa_bits[5].rfa.b ;
 wire \u_rev.rfa_bits[6].fa_ga ;
 wire \u_rev.rfa_bits[6].rfa.anc_in ;
 wire \u_rev.rfa_bits[6].rfa.b ;
 wire \u_rev.rfa_bits[7].fa_ga ;
 wire \u_rev.rfa_bits[7].rfa.anc_in ;
 wire \u_rev.rfa_bits[7].rfa.b ;
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
 wire net34;
 wire net35;
 wire net36;
 wire net37;
 wire net38;
 wire net39;
 wire net40;
 wire net41;
 wire net42;
 wire net43;
 wire net44;
 wire net45;
 wire net46;
 wire net47;
 wire net48;
 wire net49;
 wire net50;
 wire net51;
 wire net52;
 wire net53;
 wire net54;
 wire net55;
 wire net56;
 wire net57;
 wire net58;
 wire net59;
 wire net60;
 wire net61;
 wire net62;
 wire clknet_0_clk;
 wire clknet_2_0__leaf_clk;
 wire clknet_2_1__leaf_clk;
 wire clknet_2_2__leaf_clk;
 wire clknet_2_3__leaf_clk;

 sky130_fd_sc_hd__inv_2 _143_ (.A(\u_rev.rfa_bits[5].rfa.anc_in ),
    .Y(_050_));
 sky130_fd_sc_hd__inv_2 _144_ (.A(\u_rev.rfa_bits[3].rfa.anc_in ),
    .Y(_051_));
 sky130_fd_sc_hd__inv_2 _145_ (.A(\u_rev.rfa_bits[1].rfa.anc_in ),
    .Y(_052_));
 sky130_fd_sc_hd__inv_2 _146_ (.A(net55),
    .Y(_053_));
 sky130_fd_sc_hd__nand2_1 _147_ (.A(\u_rev.rfa_bits[0].rfa.b ),
    .B(\u_rev.rfa_bits[0].fa_ga ),
    .Y(_054_));
 sky130_fd_sc_hd__or2_2 _148_ (.A(\u_rev.rfa_bits[0].rfa.b ),
    .B(\u_rev.rfa_bits[0].fa_ga ),
    .X(_055_));
 sky130_fd_sc_hd__a21o_1 _149_ (.A1(_054_),
    .A2(_055_),
    .B1(cin_r),
    .X(_056_));
 sky130_fd_sc_hd__nand3_1 _150_ (.A(cin_r),
    .B(_054_),
    .C(_055_),
    .Y(_057_));
 sky130_fd_sc_hd__and3_1 _151_ (.A(_053_),
    .B(_056_),
    .C(_057_),
    .X(_000_));
 sky130_fd_sc_hd__nor2_1 _152_ (.A(\u_rev.rfa_bits[1].rfa.b ),
    .B(\u_rev.rfa_bits[1].fa_ga ),
    .Y(_058_));
 sky130_fd_sc_hd__and2_1 _153_ (.A(\u_rev.rfa_bits[1].rfa.b ),
    .B(\u_rev.rfa_bits[1].fa_ga ),
    .X(_059_));
 sky130_fd_sc_hd__or2_1 _154_ (.A(_058_),
    .B(_059_),
    .X(_060_));
 sky130_fd_sc_hd__and4_1 _155_ (.A(cin_r),
    .B(\u_rev.rfa_bits[0].rfa.anc_in ),
    .C(_054_),
    .D(_055_),
    .X(_061_));
 sky130_fd_sc_hd__a21o_1 _156_ (.A1(\u_rev.rfa_bits[0].rfa.b ),
    .A2(\u_rev.rfa_bits[0].fa_ga ),
    .B1(\u_rev.rfa_bits[0].rfa.anc_in ),
    .X(_062_));
 sky130_fd_sc_hd__nand3_1 _157_ (.A(\u_rev.rfa_bits[0].rfa.anc_in ),
    .B(\u_rev.rfa_bits[0].rfa.b ),
    .C(\u_rev.rfa_bits[0].fa_ga ),
    .Y(_063_));
 sky130_fd_sc_hd__a32oi_4 _158_ (.A1(cin_r),
    .A2(_054_),
    .A3(_055_),
    .B1(_062_),
    .B2(_063_),
    .Y(_064_));
 sky130_fd_sc_hd__o21ai_1 _159_ (.A1(_061_),
    .A2(_064_),
    .B1(_060_),
    .Y(_065_));
 sky130_fd_sc_hd__o311a_1 _160_ (.A1(_060_),
    .A2(_061_),
    .A3(_064_),
    .B1(_065_),
    .C1(_053_),
    .X(_001_));
 sky130_fd_sc_hd__nor2_1 _161_ (.A(\u_rev.rfa_bits[2].rfa.b ),
    .B(\u_rev.rfa_bits[2].fa_ga ),
    .Y(_066_));
 sky130_fd_sc_hd__and2_1 _162_ (.A(\u_rev.rfa_bits[2].rfa.b ),
    .B(\u_rev.rfa_bits[2].fa_ga ),
    .X(_067_));
 sky130_fd_sc_hd__nor2_1 _163_ (.A(_066_),
    .B(_067_),
    .Y(_068_));
 sky130_fd_sc_hd__or4_2 _164_ (.A(_052_),
    .B(_060_),
    .C(_061_),
    .D(_064_),
    .X(_069_));
 sky130_fd_sc_hd__xnor2_1 _165_ (.A(\u_rev.rfa_bits[1].rfa.anc_in ),
    .B(_059_),
    .Y(_070_));
 sky130_fd_sc_hd__o31ai_2 _166_ (.A1(_060_),
    .A2(_061_),
    .A3(_064_),
    .B1(_070_),
    .Y(_071_));
 sky130_fd_sc_hd__a21oi_1 _167_ (.A1(_069_),
    .A2(_071_),
    .B1(_068_),
    .Y(_072_));
 sky130_fd_sc_hd__a311oi_1 _168_ (.A1(_068_),
    .A2(_069_),
    .A3(_071_),
    .B1(_072_),
    .C1(net55),
    .Y(_002_));
 sky130_fd_sc_hd__nand2_1 _169_ (.A(\u_rev.rfa_bits[3].rfa.b ),
    .B(\u_rev.rfa_bits[3].fa_ga ),
    .Y(_073_));
 sky130_fd_sc_hd__or2_1 _170_ (.A(\u_rev.rfa_bits[3].rfa.b ),
    .B(\u_rev.rfa_bits[3].fa_ga ),
    .X(_074_));
 sky130_fd_sc_hd__nand2_1 _171_ (.A(_073_),
    .B(_074_),
    .Y(_075_));
 sky130_fd_sc_hd__and4_1 _172_ (.A(\u_rev.rfa_bits[2].rfa.anc_in ),
    .B(_068_),
    .C(_069_),
    .D(_071_),
    .X(_076_));
 sky130_fd_sc_hd__xnor2_1 _173_ (.A(\u_rev.rfa_bits[2].rfa.anc_in ),
    .B(_067_),
    .Y(_077_));
 sky130_fd_sc_hd__inv_2 _174_ (.A(_077_),
    .Y(_078_));
 sky130_fd_sc_hd__a31oi_2 _175_ (.A1(_068_),
    .A2(_069_),
    .A3(_071_),
    .B1(_078_),
    .Y(_079_));
 sky130_fd_sc_hd__or2_1 _176_ (.A(_076_),
    .B(_079_),
    .X(_080_));
 sky130_fd_sc_hd__a21o_1 _177_ (.A1(_075_),
    .A2(_080_),
    .B1(net54),
    .X(_081_));
 sky130_fd_sc_hd__o21ba_1 _178_ (.A1(_075_),
    .A2(_080_),
    .B1_N(_081_),
    .X(_003_));
 sky130_fd_sc_hd__nand2_1 _179_ (.A(\u_rev.rfa_bits[4].rfa.b ),
    .B(\u_rev.rfa_bits[4].fa_ga ),
    .Y(_082_));
 sky130_fd_sc_hd__or2_1 _180_ (.A(\u_rev.rfa_bits[4].rfa.b ),
    .B(\u_rev.rfa_bits[4].fa_ga ),
    .X(_083_));
 sky130_fd_sc_hd__nand2_1 _181_ (.A(_082_),
    .B(_083_),
    .Y(_084_));
 sky130_fd_sc_hd__inv_2 _182_ (.A(_084_),
    .Y(_085_));
 sky130_fd_sc_hd__nor4_1 _183_ (.A(_051_),
    .B(_075_),
    .C(_076_),
    .D(_079_),
    .Y(_086_));
 sky130_fd_sc_hd__xnor2_1 _184_ (.A(_051_),
    .B(_073_),
    .Y(_087_));
 sky130_fd_sc_hd__o31a_1 _185_ (.A1(_075_),
    .A2(_076_),
    .A3(_079_),
    .B1(_087_),
    .X(_088_));
 sky130_fd_sc_hd__or2_1 _186_ (.A(net53),
    .B(_088_),
    .X(_089_));
 sky130_fd_sc_hd__a21oi_1 _187_ (.A1(_084_),
    .A2(_089_),
    .B1(net59),
    .Y(_090_));
 sky130_fd_sc_hd__o21a_1 _188_ (.A1(_084_),
    .A2(_089_),
    .B1(_090_),
    .X(_004_));
 sky130_fd_sc_hd__nand2_1 _189_ (.A(\u_rev.rfa_bits[5].rfa.b ),
    .B(\u_rev.rfa_bits[5].fa_ga ),
    .Y(_091_));
 sky130_fd_sc_hd__or2_1 _190_ (.A(\u_rev.rfa_bits[5].rfa.b ),
    .B(\u_rev.rfa_bits[5].fa_ga ),
    .X(_092_));
 sky130_fd_sc_hd__nand2_1 _191_ (.A(_091_),
    .B(_092_),
    .Y(_093_));
 sky130_fd_sc_hd__and4bb_1 _192_ (.A_N(net53),
    .B_N(_088_),
    .C(\u_rev.rfa_bits[4].rfa.anc_in ),
    .D(_085_),
    .X(_094_));
 sky130_fd_sc_hd__xor2_1 _193_ (.A(\u_rev.rfa_bits[4].rfa.anc_in ),
    .B(_082_),
    .X(_095_));
 sky130_fd_sc_hd__o31a_1 _194_ (.A1(_084_),
    .A2(net53),
    .A3(_088_),
    .B1(_095_),
    .X(_096_));
 sky130_fd_sc_hd__or2_1 _195_ (.A(_094_),
    .B(_096_),
    .X(_097_));
 sky130_fd_sc_hd__a21oi_1 _196_ (.A1(_093_),
    .A2(_097_),
    .B1(net57),
    .Y(_098_));
 sky130_fd_sc_hd__o21a_1 _197_ (.A1(_093_),
    .A2(_097_),
    .B1(_098_),
    .X(_005_));
 sky130_fd_sc_hd__nand2_1 _198_ (.A(\u_rev.rfa_bits[6].rfa.b ),
    .B(\u_rev.rfa_bits[6].fa_ga ),
    .Y(_099_));
 sky130_fd_sc_hd__or2_1 _199_ (.A(\u_rev.rfa_bits[6].rfa.b ),
    .B(\u_rev.rfa_bits[6].fa_ga ),
    .X(_100_));
 sky130_fd_sc_hd__nand2_1 _200_ (.A(_099_),
    .B(_100_),
    .Y(_101_));
 sky130_fd_sc_hd__inv_2 _201_ (.A(_101_),
    .Y(_102_));
 sky130_fd_sc_hd__or4_2 _202_ (.A(_050_),
    .B(_093_),
    .C(_094_),
    .D(_096_),
    .X(_103_));
 sky130_fd_sc_hd__xnor2_1 _203_ (.A(_050_),
    .B(_091_),
    .Y(_104_));
 sky130_fd_sc_hd__o31ai_2 _204_ (.A1(_093_),
    .A2(_094_),
    .A3(_096_),
    .B1(_104_),
    .Y(_105_));
 sky130_fd_sc_hd__a21oi_1 _205_ (.A1(_103_),
    .A2(_105_),
    .B1(_102_),
    .Y(_106_));
 sky130_fd_sc_hd__and3_1 _206_ (.A(_102_),
    .B(_103_),
    .C(_105_),
    .X(_107_));
 sky130_fd_sc_hd__nor3_1 _207_ (.A(net57),
    .B(_106_),
    .C(_107_),
    .Y(_006_));
 sky130_fd_sc_hd__nand2_1 _208_ (.A(\u_rev.rfa_bits[7].rfa.b ),
    .B(\u_rev.rfa_bits[7].fa_ga ),
    .Y(_108_));
 sky130_fd_sc_hd__or2_1 _209_ (.A(\u_rev.rfa_bits[7].rfa.b ),
    .B(\u_rev.rfa_bits[7].fa_ga ),
    .X(_109_));
 sky130_fd_sc_hd__and2_1 _210_ (.A(_108_),
    .B(_109_),
    .X(_110_));
 sky130_fd_sc_hd__nand4_1 _211_ (.A(\u_rev.rfa_bits[6].rfa.anc_in ),
    .B(_102_),
    .C(_103_),
    .D(_105_),
    .Y(_111_));
 sky130_fd_sc_hd__xnor2_1 _212_ (.A(\u_rev.rfa_bits[6].rfa.anc_in ),
    .B(_099_),
    .Y(_112_));
 sky130_fd_sc_hd__a31o_1 _213_ (.A1(_102_),
    .A2(_103_),
    .A3(_105_),
    .B1(_112_),
    .X(_113_));
 sky130_fd_sc_hd__a21oi_1 _214_ (.A1(_111_),
    .A2(_113_),
    .B1(_110_),
    .Y(_114_));
 sky130_fd_sc_hd__and3_1 _215_ (.A(_110_),
    .B(_111_),
    .C(_113_),
    .X(_115_));
 sky130_fd_sc_hd__nor3_1 _216_ (.A(net57),
    .B(_114_),
    .C(_115_),
    .Y(_007_));
 sky130_fd_sc_hd__xnor2_1 _217_ (.A(\u_rev.rfa_bits[7].rfa.anc_in ),
    .B(_108_),
    .Y(_116_));
 sky130_fd_sc_hd__nor2_1 _218_ (.A(net56),
    .B(_116_),
    .Y(_117_));
 sky130_fd_sc_hd__and2b_1 _219_ (.A_N(net56),
    .B(_116_),
    .X(_049_));
 sky130_fd_sc_hd__mux2_1 _220_ (.A0(_049_),
    .A1(_117_),
    .S(_115_),
    .X(_008_));
 sky130_fd_sc_hd__and2b_1 _221_ (.A_N(net55),
    .B(\u_rev.rfa_bits[0].fa_ga ),
    .X(_009_));
 sky130_fd_sc_hd__and2b_1 _222_ (.A_N(net56),
    .B(\u_rev.rfa_bits[1].fa_ga ),
    .X(_010_));
 sky130_fd_sc_hd__and2b_1 _223_ (.A_N(net56),
    .B(\u_rev.rfa_bits[2].fa_ga ),
    .X(_011_));
 sky130_fd_sc_hd__and2b_1 _224_ (.A_N(net54),
    .B(\u_rev.rfa_bits[3].fa_ga ),
    .X(_012_));
 sky130_fd_sc_hd__and2b_1 _225_ (.A_N(net54),
    .B(\u_rev.rfa_bits[4].fa_ga ),
    .X(_013_));
 sky130_fd_sc_hd__and2b_1 _226_ (.A_N(net57),
    .B(\u_rev.rfa_bits[5].fa_ga ),
    .X(_014_));
 sky130_fd_sc_hd__and2b_1 _227_ (.A_N(net57),
    .B(\u_rev.rfa_bits[6].fa_ga ),
    .X(_015_));
 sky130_fd_sc_hd__and2b_1 _228_ (.A_N(net56),
    .B(\u_rev.rfa_bits[7].fa_ga ),
    .X(_016_));
 sky130_fd_sc_hd__mux2_1 _229_ (.A0(\u_rev.rfa_bits[0].fa_ga ),
    .A1(net1),
    .S(net60),
    .X(_118_));
 sky130_fd_sc_hd__and2b_1 _230_ (.A_N(net55),
    .B(_118_),
    .X(_017_));
 sky130_fd_sc_hd__mux2_1 _231_ (.A0(\u_rev.rfa_bits[1].fa_ga ),
    .A1(net2),
    .S(net61),
    .X(_119_));
 sky130_fd_sc_hd__and2b_1 _232_ (.A_N(net56),
    .B(_119_),
    .X(_018_));
 sky130_fd_sc_hd__mux2_1 _233_ (.A0(\u_rev.rfa_bits[2].fa_ga ),
    .A1(net3),
    .S(net61),
    .X(_120_));
 sky130_fd_sc_hd__and2b_1 _234_ (.A_N(net56),
    .B(_120_),
    .X(_019_));
 sky130_fd_sc_hd__mux2_1 _235_ (.A0(\u_rev.rfa_bits[3].fa_ga ),
    .A1(net4),
    .S(net60),
    .X(_121_));
 sky130_fd_sc_hd__and2b_1 _236_ (.A_N(net54),
    .B(_121_),
    .X(_020_));
 sky130_fd_sc_hd__mux2_1 _237_ (.A0(\u_rev.rfa_bits[4].fa_ga ),
    .A1(net5),
    .S(net60),
    .X(_122_));
 sky130_fd_sc_hd__and2b_1 _238_ (.A_N(net54),
    .B(_122_),
    .X(_021_));
 sky130_fd_sc_hd__mux2_1 _239_ (.A0(\u_rev.rfa_bits[5].fa_ga ),
    .A1(net6),
    .S(net61),
    .X(_123_));
 sky130_fd_sc_hd__and2b_1 _240_ (.A_N(net57),
    .B(_123_),
    .X(_022_));
 sky130_fd_sc_hd__mux2_1 _241_ (.A0(\u_rev.rfa_bits[6].fa_ga ),
    .A1(net7),
    .S(net61),
    .X(_124_));
 sky130_fd_sc_hd__and2b_1 _242_ (.A_N(net57),
    .B(_124_),
    .X(_023_));
 sky130_fd_sc_hd__mux2_1 _243_ (.A0(\u_rev.rfa_bits[7].fa_ga ),
    .A1(net8),
    .S(net61),
    .X(_125_));
 sky130_fd_sc_hd__and2b_1 _244_ (.A_N(net58),
    .B(_125_),
    .X(_024_));
 sky130_fd_sc_hd__mux2_1 _245_ (.A0(\u_rev.rfa_bits[0].rfa.b ),
    .A1(net17),
    .S(net60),
    .X(_126_));
 sky130_fd_sc_hd__and2b_1 _246_ (.A_N(net55),
    .B(_126_),
    .X(_025_));
 sky130_fd_sc_hd__mux2_1 _247_ (.A0(\u_rev.rfa_bits[1].rfa.b ),
    .A1(net18),
    .S(net61),
    .X(_127_));
 sky130_fd_sc_hd__and2b_1 _248_ (.A_N(net56),
    .B(_127_),
    .X(_026_));
 sky130_fd_sc_hd__mux2_1 _249_ (.A0(\u_rev.rfa_bits[2].rfa.b ),
    .A1(net19),
    .S(net61),
    .X(_128_));
 sky130_fd_sc_hd__and2b_1 _250_ (.A_N(net56),
    .B(_128_),
    .X(_027_));
 sky130_fd_sc_hd__mux2_1 _251_ (.A0(\u_rev.rfa_bits[3].rfa.b ),
    .A1(net20),
    .S(net60),
    .X(_129_));
 sky130_fd_sc_hd__and2b_1 _252_ (.A_N(net54),
    .B(_129_),
    .X(_028_));
 sky130_fd_sc_hd__mux2_1 _253_ (.A0(\u_rev.rfa_bits[4].rfa.b ),
    .A1(net21),
    .S(net60),
    .X(_130_));
 sky130_fd_sc_hd__and2b_1 _254_ (.A_N(net54),
    .B(_130_),
    .X(_029_));
 sky130_fd_sc_hd__mux2_1 _255_ (.A0(\u_rev.rfa_bits[5].rfa.b ),
    .A1(net22),
    .S(net62),
    .X(_131_));
 sky130_fd_sc_hd__and2b_1 _256_ (.A_N(net57),
    .B(_131_),
    .X(_030_));
 sky130_fd_sc_hd__mux2_1 _257_ (.A0(\u_rev.rfa_bits[6].rfa.b ),
    .A1(net23),
    .S(net62),
    .X(_132_));
 sky130_fd_sc_hd__and2b_1 _258_ (.A_N(net58),
    .B(_132_),
    .X(_031_));
 sky130_fd_sc_hd__mux2_1 _259_ (.A0(\u_rev.rfa_bits[7].rfa.b ),
    .A1(net24),
    .S(net61),
    .X(_133_));
 sky130_fd_sc_hd__and2b_1 _260_ (.A_N(net58),
    .B(_133_),
    .X(_032_));
 sky130_fd_sc_hd__mux2_1 _261_ (.A0(\u_rev.rfa_bits[0].rfa.anc_in ),
    .A1(net9),
    .S(net60),
    .X(_134_));
 sky130_fd_sc_hd__and2b_1 _262_ (.A_N(net55),
    .B(_134_),
    .X(_033_));
 sky130_fd_sc_hd__mux2_1 _263_ (.A0(\u_rev.rfa_bits[1].rfa.anc_in ),
    .A1(net10),
    .S(net60),
    .X(_135_));
 sky130_fd_sc_hd__and2b_1 _264_ (.A_N(net55),
    .B(_135_),
    .X(_034_));
 sky130_fd_sc_hd__mux2_1 _265_ (.A0(\u_rev.rfa_bits[2].rfa.anc_in ),
    .A1(net11),
    .S(net61),
    .X(_136_));
 sky130_fd_sc_hd__and2b_1 _266_ (.A_N(net56),
    .B(_136_),
    .X(_035_));
 sky130_fd_sc_hd__mux2_1 _267_ (.A0(\u_rev.rfa_bits[3].rfa.anc_in ),
    .A1(net12),
    .S(net60),
    .X(_137_));
 sky130_fd_sc_hd__and2b_1 _268_ (.A_N(net54),
    .B(_137_),
    .X(_036_));
 sky130_fd_sc_hd__mux2_1 _269_ (.A0(\u_rev.rfa_bits[4].rfa.anc_in ),
    .A1(net13),
    .S(net62),
    .X(_138_));
 sky130_fd_sc_hd__and2b_1 _270_ (.A_N(net54),
    .B(_138_),
    .X(_037_));
 sky130_fd_sc_hd__mux2_1 _271_ (.A0(\u_rev.rfa_bits[5].rfa.anc_in ),
    .A1(net14),
    .S(net62),
    .X(_139_));
 sky130_fd_sc_hd__and2b_1 _272_ (.A_N(net57),
    .B(_139_),
    .X(_038_));
 sky130_fd_sc_hd__mux2_1 _273_ (.A0(\u_rev.rfa_bits[6].rfa.anc_in ),
    .A1(net15),
    .S(net62),
    .X(_140_));
 sky130_fd_sc_hd__and2b_1 _274_ (.A_N(net58),
    .B(_140_),
    .X(_039_));
 sky130_fd_sc_hd__mux2_1 _275_ (.A0(\u_rev.rfa_bits[7].rfa.anc_in ),
    .A1(net16),
    .S(net61),
    .X(_141_));
 sky130_fd_sc_hd__and2b_1 _276_ (.A_N(net58),
    .B(_141_),
    .X(_040_));
 sky130_fd_sc_hd__mux2_1 _277_ (.A0(cin_r),
    .A1(net25),
    .S(net60),
    .X(_142_));
 sky130_fd_sc_hd__and2b_1 _278_ (.A_N(net55),
    .B(_142_),
    .X(_041_));
 sky130_fd_sc_hd__and3b_1 _279_ (.A_N(net55),
    .B(_062_),
    .C(_063_),
    .X(_042_));
 sky130_fd_sc_hd__nor2_1 _280_ (.A(net55),
    .B(_070_),
    .Y(_043_));
 sky130_fd_sc_hd__nor2_1 _281_ (.A(net59),
    .B(_077_),
    .Y(_044_));
 sky130_fd_sc_hd__nor2_1 _282_ (.A(net54),
    .B(_087_),
    .Y(_045_));
 sky130_fd_sc_hd__nor2_1 _283_ (.A(net59),
    .B(_095_),
    .Y(_046_));
 sky130_fd_sc_hd__nor2_1 _284_ (.A(net57),
    .B(_104_),
    .Y(_047_));
 sky130_fd_sc_hd__and2b_1 _285_ (.A_N(net58),
    .B(_112_),
    .X(_048_));
 sky130_fd_sc_hd__dfxtp_1 _286_ (.CLK(clknet_2_0__leaf_clk),
    .D(_000_),
    .Q(net45));
 sky130_fd_sc_hd__dfxtp_1 _287_ (.CLK(clknet_2_0__leaf_clk),
    .D(_001_),
    .Q(net46));
 sky130_fd_sc_hd__dfxtp_1 _288_ (.CLK(clknet_2_0__leaf_clk),
    .D(_002_),
    .Q(net47));
 sky130_fd_sc_hd__dfxtp_1 _289_ (.CLK(clknet_2_1__leaf_clk),
    .D(_003_),
    .Q(net48));
 sky130_fd_sc_hd__dfxtp_1 _290_ (.CLK(clknet_2_1__leaf_clk),
    .D(_004_),
    .Q(net49));
 sky130_fd_sc_hd__dfxtp_1 _291_ (.CLK(clknet_2_1__leaf_clk),
    .D(_005_),
    .Q(net50));
 sky130_fd_sc_hd__dfxtp_1 _292_ (.CLK(clknet_2_3__leaf_clk),
    .D(_006_),
    .Q(net51));
 sky130_fd_sc_hd__dfxtp_1 _293_ (.CLK(clknet_2_2__leaf_clk),
    .D(_007_),
    .Q(net52));
 sky130_fd_sc_hd__dfxtp_1 _294_ (.CLK(clknet_2_2__leaf_clk),
    .D(_008_),
    .Q(net28));
 sky130_fd_sc_hd__dfxtp_1 _295_ (.CLK(clknet_2_0__leaf_clk),
    .D(_009_),
    .Q(net29));
 sky130_fd_sc_hd__dfxtp_1 _296_ (.CLK(clknet_2_2__leaf_clk),
    .D(_010_),
    .Q(net30));
 sky130_fd_sc_hd__dfxtp_1 _297_ (.CLK(clknet_2_2__leaf_clk),
    .D(_011_),
    .Q(net31));
 sky130_fd_sc_hd__dfxtp_1 _298_ (.CLK(clknet_2_1__leaf_clk),
    .D(_012_),
    .Q(net32));
 sky130_fd_sc_hd__dfxtp_1 _299_ (.CLK(clknet_2_1__leaf_clk),
    .D(_013_),
    .Q(net33));
 sky130_fd_sc_hd__dfxtp_1 _300_ (.CLK(clknet_2_3__leaf_clk),
    .D(_014_),
    .Q(net34));
 sky130_fd_sc_hd__dfxtp_1 _301_ (.CLK(clknet_2_3__leaf_clk),
    .D(_015_),
    .Q(net35));
 sky130_fd_sc_hd__dfxtp_1 _302_ (.CLK(clknet_2_2__leaf_clk),
    .D(_016_),
    .Q(net36));
 sky130_fd_sc_hd__dfxtp_1 _303_ (.CLK(clknet_2_0__leaf_clk),
    .D(_017_),
    .Q(\u_rev.rfa_bits[0].fa_ga ));
 sky130_fd_sc_hd__dfxtp_1 _304_ (.CLK(clknet_2_2__leaf_clk),
    .D(_018_),
    .Q(\u_rev.rfa_bits[1].fa_ga ));
 sky130_fd_sc_hd__dfxtp_1 _305_ (.CLK(clknet_2_2__leaf_clk),
    .D(_019_),
    .Q(\u_rev.rfa_bits[2].fa_ga ));
 sky130_fd_sc_hd__dfxtp_1 _306_ (.CLK(clknet_2_1__leaf_clk),
    .D(_020_),
    .Q(\u_rev.rfa_bits[3].fa_ga ));
 sky130_fd_sc_hd__dfxtp_1 _307_ (.CLK(clknet_2_1__leaf_clk),
    .D(_021_),
    .Q(\u_rev.rfa_bits[4].fa_ga ));
 sky130_fd_sc_hd__dfxtp_1 _308_ (.CLK(clknet_2_3__leaf_clk),
    .D(_022_),
    .Q(\u_rev.rfa_bits[5].fa_ga ));
 sky130_fd_sc_hd__dfxtp_1 _309_ (.CLK(clknet_2_3__leaf_clk),
    .D(_023_),
    .Q(\u_rev.rfa_bits[6].fa_ga ));
 sky130_fd_sc_hd__dfxtp_1 _310_ (.CLK(clknet_2_2__leaf_clk),
    .D(_024_),
    .Q(\u_rev.rfa_bits[7].fa_ga ));
 sky130_fd_sc_hd__dfxtp_1 _311_ (.CLK(clknet_2_0__leaf_clk),
    .D(_025_),
    .Q(\u_rev.rfa_bits[0].rfa.b ));
 sky130_fd_sc_hd__dfxtp_1 _312_ (.CLK(clknet_2_0__leaf_clk),
    .D(_026_),
    .Q(\u_rev.rfa_bits[1].rfa.b ));
 sky130_fd_sc_hd__dfxtp_1 _313_ (.CLK(clknet_2_2__leaf_clk),
    .D(_027_),
    .Q(\u_rev.rfa_bits[2].rfa.b ));
 sky130_fd_sc_hd__dfxtp_1 _314_ (.CLK(clknet_2_1__leaf_clk),
    .D(_028_),
    .Q(\u_rev.rfa_bits[3].rfa.b ));
 sky130_fd_sc_hd__dfxtp_1 _315_ (.CLK(clknet_2_1__leaf_clk),
    .D(_029_),
    .Q(\u_rev.rfa_bits[4].rfa.b ));
 sky130_fd_sc_hd__dfxtp_1 _316_ (.CLK(clknet_2_3__leaf_clk),
    .D(_030_),
    .Q(\u_rev.rfa_bits[5].rfa.b ));
 sky130_fd_sc_hd__dfxtp_1 _317_ (.CLK(clknet_2_3__leaf_clk),
    .D(_031_),
    .Q(\u_rev.rfa_bits[6].rfa.b ));
 sky130_fd_sc_hd__dfxtp_1 _318_ (.CLK(clknet_2_2__leaf_clk),
    .D(_032_),
    .Q(\u_rev.rfa_bits[7].rfa.b ));
 sky130_fd_sc_hd__dfxtp_1 _319_ (.CLK(clknet_2_0__leaf_clk),
    .D(_033_),
    .Q(\u_rev.rfa_bits[0].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_1 _320_ (.CLK(clknet_2_0__leaf_clk),
    .D(_034_),
    .Q(\u_rev.rfa_bits[1].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_1 _321_ (.CLK(clknet_2_0__leaf_clk),
    .D(_035_),
    .Q(\u_rev.rfa_bits[2].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_1 _322_ (.CLK(clknet_2_1__leaf_clk),
    .D(_036_),
    .Q(\u_rev.rfa_bits[3].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_1 _323_ (.CLK(clknet_2_1__leaf_clk),
    .D(_037_),
    .Q(\u_rev.rfa_bits[4].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_1 _324_ (.CLK(clknet_2_3__leaf_clk),
    .D(_038_),
    .Q(\u_rev.rfa_bits[5].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_1 _325_ (.CLK(clknet_2_3__leaf_clk),
    .D(_039_),
    .Q(\u_rev.rfa_bits[6].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_1 _326_ (.CLK(clknet_2_2__leaf_clk),
    .D(_040_),
    .Q(\u_rev.rfa_bits[7].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_1 _327_ (.CLK(clknet_2_0__leaf_clk),
    .D(_041_),
    .Q(cin_r));
 sky130_fd_sc_hd__dfxtp_1 _328_ (.CLK(clknet_2_0__leaf_clk),
    .D(_042_),
    .Q(net37));
 sky130_fd_sc_hd__dfxtp_1 _329_ (.CLK(clknet_2_0__leaf_clk),
    .D(_043_),
    .Q(net38));
 sky130_fd_sc_hd__dfxtp_1 _330_ (.CLK(clknet_2_1__leaf_clk),
    .D(_044_),
    .Q(net39));
 sky130_fd_sc_hd__dfxtp_1 _331_ (.CLK(clknet_2_1__leaf_clk),
    .D(_045_),
    .Q(net40));
 sky130_fd_sc_hd__dfxtp_1 _332_ (.CLK(clknet_2_1__leaf_clk),
    .D(_046_),
    .Q(net41));
 sky130_fd_sc_hd__dfxtp_1 _333_ (.CLK(clknet_2_3__leaf_clk),
    .D(_047_),
    .Q(net42));
 sky130_fd_sc_hd__dfxtp_1 _334_ (.CLK(clknet_2_3__leaf_clk),
    .D(_048_),
    .Q(net43));
 sky130_fd_sc_hd__dfxtp_1 _335_ (.CLK(clknet_2_2__leaf_clk),
    .D(_049_),
    .Q(net44));
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
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Right_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Right_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Right_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Right_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Right_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_23_Right_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_24_Right_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_35 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_36 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_37 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_38 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_39 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_40 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_41 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_42 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Left_43 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Left_44 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Left_45 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Left_46 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Left_47 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_23_Left_48 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_24_Left_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_62 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_65 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_67 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_69 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_71 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_97 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_98 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_99 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_101 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_102 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_103 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_104 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_105 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_106 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_107 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_108 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_109 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_110 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_111 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_112 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_113 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_114 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_115 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_116 ();
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
 sky130_fd_sc_hd__clkbuf_1 input9 (.A(anc[0]),
    .X(net9));
 sky130_fd_sc_hd__clkbuf_1 input10 (.A(anc[1]),
    .X(net10));
 sky130_fd_sc_hd__clkbuf_1 input11 (.A(anc[2]),
    .X(net11));
 sky130_fd_sc_hd__clkbuf_1 input12 (.A(anc[3]),
    .X(net12));
 sky130_fd_sc_hd__clkbuf_1 input13 (.A(anc[4]),
    .X(net13));
 sky130_fd_sc_hd__clkbuf_1 input14 (.A(anc[5]),
    .X(net14));
 sky130_fd_sc_hd__clkbuf_1 input15 (.A(anc[6]),
    .X(net15));
 sky130_fd_sc_hd__clkbuf_1 input16 (.A(anc[7]),
    .X(net16));
 sky130_fd_sc_hd__clkbuf_1 input17 (.A(b[0]),
    .X(net17));
 sky130_fd_sc_hd__clkbuf_1 input18 (.A(b[1]),
    .X(net18));
 sky130_fd_sc_hd__clkbuf_1 input19 (.A(b[2]),
    .X(net19));
 sky130_fd_sc_hd__clkbuf_1 input20 (.A(b[3]),
    .X(net20));
 sky130_fd_sc_hd__clkbuf_1 input21 (.A(b[4]),
    .X(net21));
 sky130_fd_sc_hd__clkbuf_1 input22 (.A(b[5]),
    .X(net22));
 sky130_fd_sc_hd__clkbuf_1 input23 (.A(b[6]),
    .X(net23));
 sky130_fd_sc_hd__clkbuf_1 input24 (.A(b[7]),
    .X(net24));
 sky130_fd_sc_hd__clkbuf_1 input25 (.A(cin),
    .X(net25));
 sky130_fd_sc_hd__clkbuf_1 input26 (.A(enable),
    .X(net26));
 sky130_fd_sc_hd__clkbuf_1 input27 (.A(reset),
    .X(net27));
 sky130_fd_sc_hd__buf_2 output28 (.A(net28),
    .X(cout));
 sky130_fd_sc_hd__buf_2 output29 (.A(net29),
    .X(g_a[0]));
 sky130_fd_sc_hd__buf_2 output30 (.A(net30),
    .X(g_a[1]));
 sky130_fd_sc_hd__buf_2 output31 (.A(net31),
    .X(g_a[2]));
 sky130_fd_sc_hd__buf_2 output32 (.A(net32),
    .X(g_a[3]));
 sky130_fd_sc_hd__buf_2 output33 (.A(net33),
    .X(g_a[4]));
 sky130_fd_sc_hd__buf_2 output34 (.A(net34),
    .X(g_a[5]));
 sky130_fd_sc_hd__buf_2 output35 (.A(net35),
    .X(g_a[6]));
 sky130_fd_sc_hd__buf_2 output36 (.A(net36),
    .X(g_a[7]));
 sky130_fd_sc_hd__buf_2 output37 (.A(net37),
    .X(g_ab[0]));
 sky130_fd_sc_hd__buf_2 output38 (.A(net38),
    .X(g_ab[1]));
 sky130_fd_sc_hd__buf_2 output39 (.A(net39),
    .X(g_ab[2]));
 sky130_fd_sc_hd__buf_2 output40 (.A(net40),
    .X(g_ab[3]));
 sky130_fd_sc_hd__buf_2 output41 (.A(net41),
    .X(g_ab[4]));
 sky130_fd_sc_hd__buf_2 output42 (.A(net42),
    .X(g_ab[5]));
 sky130_fd_sc_hd__buf_2 output43 (.A(net43),
    .X(g_ab[6]));
 sky130_fd_sc_hd__buf_2 output44 (.A(net44),
    .X(g_ab[7]));
 sky130_fd_sc_hd__buf_2 output45 (.A(net45),
    .X(sum[0]));
 sky130_fd_sc_hd__buf_2 output46 (.A(net46),
    .X(sum[1]));
 sky130_fd_sc_hd__buf_2 output47 (.A(net47),
    .X(sum[2]));
 sky130_fd_sc_hd__buf_2 output48 (.A(net48),
    .X(sum[3]));
 sky130_fd_sc_hd__buf_2 output49 (.A(net49),
    .X(sum[4]));
 sky130_fd_sc_hd__buf_2 output50 (.A(net50),
    .X(sum[5]));
 sky130_fd_sc_hd__buf_2 output51 (.A(net51),
    .X(sum[6]));
 sky130_fd_sc_hd__buf_2 output52 (.A(net52),
    .X(sum[7]));
 sky130_fd_sc_hd__clkbuf_1 wire53 (.A(_086_),
    .X(net53));
 sky130_fd_sc_hd__clkbuf_2 fanout54 (.A(net59),
    .X(net54));
 sky130_fd_sc_hd__buf_2 fanout55 (.A(net59),
    .X(net55));
 sky130_fd_sc_hd__clkbuf_2 fanout56 (.A(net58),
    .X(net56));
 sky130_fd_sc_hd__clkbuf_2 fanout57 (.A(net58),
    .X(net57));
 sky130_fd_sc_hd__clkbuf_2 fanout58 (.A(net59),
    .X(net58));
 sky130_fd_sc_hd__clkbuf_2 fanout59 (.A(net27),
    .X(net59));
 sky130_fd_sc_hd__clkbuf_4 fanout60 (.A(net62),
    .X(net60));
 sky130_fd_sc_hd__clkbuf_4 fanout61 (.A(net62),
    .X(net61));
 sky130_fd_sc_hd__buf_2 fanout62 (.A(net26),
    .X(net62));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_0__f_clk (.A(clknet_0_clk),
    .X(clknet_2_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_1__f_clk (.A(clknet_0_clk),
    .X(clknet_2_1__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_2__f_clk (.A(clknet_0_clk),
    .X(clknet_2_2__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_3__f_clk (.A(clknet_0_clk),
    .X(clknet_2_3__leaf_clk));
 sky130_fd_sc_hd__clkbuf_4 clkload0 (.A(clknet_2_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_8 clkload1 (.A(clknet_2_2__leaf_clk));
 sky130_fd_sc_hd__clkinv_2 clkload2 (.A(clknet_2_3__leaf_clk));
endmodule

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

 sky130_fd_sc_hd__inv_2 _143_ (.A(\u_rev.rfa_bits[5].rfa.anc_in ),
    .Y(_050_));
 sky130_fd_sc_hd__inv_2 _144_ (.A(\u_rev.rfa_bits[3].rfa.anc_in ),
    .Y(_051_));
 sky130_fd_sc_hd__inv_2 _145_ (.A(\u_rev.rfa_bits[1].rfa.anc_in ),
    .Y(_052_));
 sky130_fd_sc_hd__inv_2 _146_ (.A(reset),
    .Y(_053_));
 sky130_fd_sc_hd__nand2_2 _147_ (.A(\u_rev.rfa_bits[0].rfa.b ),
    .B(\u_rev.rfa_bits[0].fa_ga ),
    .Y(_054_));
 sky130_fd_sc_hd__or2_2 _148_ (.A(\u_rev.rfa_bits[0].rfa.b ),
    .B(\u_rev.rfa_bits[0].fa_ga ),
    .X(_055_));
 sky130_fd_sc_hd__a21o_2 _149_ (.A1(_054_),
    .A2(_055_),
    .B1(cin_r),
    .X(_056_));
 sky130_fd_sc_hd__nand3_2 _150_ (.A(cin_r),
    .B(_054_),
    .C(_055_),
    .Y(_057_));
 sky130_fd_sc_hd__and3_2 _151_ (.A(_053_),
    .B(_056_),
    .C(_057_),
    .X(_000_));
 sky130_fd_sc_hd__nor2_2 _152_ (.A(\u_rev.rfa_bits[1].rfa.b ),
    .B(\u_rev.rfa_bits[1].fa_ga ),
    .Y(_058_));
 sky130_fd_sc_hd__and2_2 _153_ (.A(\u_rev.rfa_bits[1].rfa.b ),
    .B(\u_rev.rfa_bits[1].fa_ga ),
    .X(_059_));
 sky130_fd_sc_hd__or2_2 _154_ (.A(_058_),
    .B(_059_),
    .X(_060_));
 sky130_fd_sc_hd__and4_2 _155_ (.A(cin_r),
    .B(\u_rev.rfa_bits[0].rfa.anc_in ),
    .C(_054_),
    .D(_055_),
    .X(_061_));
 sky130_fd_sc_hd__a21o_2 _156_ (.A1(\u_rev.rfa_bits[0].rfa.b ),
    .A2(\u_rev.rfa_bits[0].fa_ga ),
    .B1(\u_rev.rfa_bits[0].rfa.anc_in ),
    .X(_062_));
 sky130_fd_sc_hd__nand3_2 _157_ (.A(\u_rev.rfa_bits[0].rfa.anc_in ),
    .B(\u_rev.rfa_bits[0].rfa.b ),
    .C(\u_rev.rfa_bits[0].fa_ga ),
    .Y(_063_));
 sky130_fd_sc_hd__a32oi_2 _158_ (.A1(cin_r),
    .A2(_054_),
    .A3(_055_),
    .B1(_062_),
    .B2(_063_),
    .Y(_064_));
 sky130_fd_sc_hd__o21ai_2 _159_ (.A1(_061_),
    .A2(_064_),
    .B1(_060_),
    .Y(_065_));
 sky130_fd_sc_hd__o311a_2 _160_ (.A1(_060_),
    .A2(_061_),
    .A3(_064_),
    .B1(_065_),
    .C1(_053_),
    .X(_001_));
 sky130_fd_sc_hd__nor2_2 _161_ (.A(\u_rev.rfa_bits[2].rfa.b ),
    .B(\u_rev.rfa_bits[2].fa_ga ),
    .Y(_066_));
 sky130_fd_sc_hd__and2_2 _162_ (.A(\u_rev.rfa_bits[2].rfa.b ),
    .B(\u_rev.rfa_bits[2].fa_ga ),
    .X(_067_));
 sky130_fd_sc_hd__nor2_2 _163_ (.A(_066_),
    .B(_067_),
    .Y(_068_));
 sky130_fd_sc_hd__or4_2 _164_ (.A(_052_),
    .B(_060_),
    .C(_061_),
    .D(_064_),
    .X(_069_));
 sky130_fd_sc_hd__xnor2_2 _165_ (.A(\u_rev.rfa_bits[1].rfa.anc_in ),
    .B(_059_),
    .Y(_070_));
 sky130_fd_sc_hd__o31ai_2 _166_ (.A1(_060_),
    .A2(_061_),
    .A3(_064_),
    .B1(_070_),
    .Y(_071_));
 sky130_fd_sc_hd__a21oi_2 _167_ (.A1(_069_),
    .A2(_071_),
    .B1(_068_),
    .Y(_072_));
 sky130_fd_sc_hd__a311oi_2 _168_ (.A1(_068_),
    .A2(_069_),
    .A3(_071_),
    .B1(_072_),
    .C1(reset),
    .Y(_002_));
 sky130_fd_sc_hd__nand2_2 _169_ (.A(\u_rev.rfa_bits[3].rfa.b ),
    .B(\u_rev.rfa_bits[3].fa_ga ),
    .Y(_073_));
 sky130_fd_sc_hd__or2_2 _170_ (.A(\u_rev.rfa_bits[3].rfa.b ),
    .B(\u_rev.rfa_bits[3].fa_ga ),
    .X(_074_));
 sky130_fd_sc_hd__nand2_2 _171_ (.A(_073_),
    .B(_074_),
    .Y(_075_));
 sky130_fd_sc_hd__and4_2 _172_ (.A(\u_rev.rfa_bits[2].rfa.anc_in ),
    .B(_068_),
    .C(_069_),
    .D(_071_),
    .X(_076_));
 sky130_fd_sc_hd__xnor2_2 _173_ (.A(\u_rev.rfa_bits[2].rfa.anc_in ),
    .B(_067_),
    .Y(_077_));
 sky130_fd_sc_hd__inv_2 _174_ (.A(_077_),
    .Y(_078_));
 sky130_fd_sc_hd__a31oi_2 _175_ (.A1(_068_),
    .A2(_069_),
    .A3(_071_),
    .B1(_078_),
    .Y(_079_));
 sky130_fd_sc_hd__or2_2 _176_ (.A(_076_),
    .B(_079_),
    .X(_080_));
 sky130_fd_sc_hd__a21o_2 _177_ (.A1(_075_),
    .A2(_080_),
    .B1(reset),
    .X(_081_));
 sky130_fd_sc_hd__o21ba_2 _178_ (.A1(_075_),
    .A2(_080_),
    .B1_N(_081_),
    .X(_003_));
 sky130_fd_sc_hd__nand2_2 _179_ (.A(\u_rev.rfa_bits[4].rfa.b ),
    .B(\u_rev.rfa_bits[4].fa_ga ),
    .Y(_082_));
 sky130_fd_sc_hd__or2_2 _180_ (.A(\u_rev.rfa_bits[4].rfa.b ),
    .B(\u_rev.rfa_bits[4].fa_ga ),
    .X(_083_));
 sky130_fd_sc_hd__nand2_2 _181_ (.A(_082_),
    .B(_083_),
    .Y(_084_));
 sky130_fd_sc_hd__inv_2 _182_ (.A(_084_),
    .Y(_085_));
 sky130_fd_sc_hd__nor4_2 _183_ (.A(_051_),
    .B(_075_),
    .C(_076_),
    .D(_079_),
    .Y(_086_));
 sky130_fd_sc_hd__xnor2_2 _184_ (.A(_051_),
    .B(_073_),
    .Y(_087_));
 sky130_fd_sc_hd__o31a_2 _185_ (.A1(_075_),
    .A2(_076_),
    .A3(_079_),
    .B1(_087_),
    .X(_088_));
 sky130_fd_sc_hd__or2_2 _186_ (.A(_086_),
    .B(_088_),
    .X(_089_));
 sky130_fd_sc_hd__a21oi_2 _187_ (.A1(_084_),
    .A2(_089_),
    .B1(reset),
    .Y(_090_));
 sky130_fd_sc_hd__o21a_2 _188_ (.A1(_084_),
    .A2(_089_),
    .B1(_090_),
    .X(_004_));
 sky130_fd_sc_hd__nand2_2 _189_ (.A(\u_rev.rfa_bits[5].rfa.b ),
    .B(\u_rev.rfa_bits[5].fa_ga ),
    .Y(_091_));
 sky130_fd_sc_hd__or2_2 _190_ (.A(\u_rev.rfa_bits[5].rfa.b ),
    .B(\u_rev.rfa_bits[5].fa_ga ),
    .X(_092_));
 sky130_fd_sc_hd__nand2_2 _191_ (.A(_091_),
    .B(_092_),
    .Y(_093_));
 sky130_fd_sc_hd__and4bb_2 _192_ (.A_N(_086_),
    .B_N(_088_),
    .C(\u_rev.rfa_bits[4].rfa.anc_in ),
    .D(_085_),
    .X(_094_));
 sky130_fd_sc_hd__xor2_2 _193_ (.A(\u_rev.rfa_bits[4].rfa.anc_in ),
    .B(_082_),
    .X(_095_));
 sky130_fd_sc_hd__o31a_2 _194_ (.A1(_084_),
    .A2(_086_),
    .A3(_088_),
    .B1(_095_),
    .X(_096_));
 sky130_fd_sc_hd__or2_2 _195_ (.A(_094_),
    .B(_096_),
    .X(_097_));
 sky130_fd_sc_hd__a21oi_2 _196_ (.A1(_093_),
    .A2(_097_),
    .B1(reset),
    .Y(_098_));
 sky130_fd_sc_hd__o21a_2 _197_ (.A1(_093_),
    .A2(_097_),
    .B1(_098_),
    .X(_005_));
 sky130_fd_sc_hd__nand2_2 _198_ (.A(\u_rev.rfa_bits[6].rfa.b ),
    .B(\u_rev.rfa_bits[6].fa_ga ),
    .Y(_099_));
 sky130_fd_sc_hd__or2_2 _199_ (.A(\u_rev.rfa_bits[6].rfa.b ),
    .B(\u_rev.rfa_bits[6].fa_ga ),
    .X(_100_));
 sky130_fd_sc_hd__nand2_2 _200_ (.A(_099_),
    .B(_100_),
    .Y(_101_));
 sky130_fd_sc_hd__inv_2 _201_ (.A(_101_),
    .Y(_102_));
 sky130_fd_sc_hd__or4_2 _202_ (.A(_050_),
    .B(_093_),
    .C(_094_),
    .D(_096_),
    .X(_103_));
 sky130_fd_sc_hd__xnor2_2 _203_ (.A(_050_),
    .B(_091_),
    .Y(_104_));
 sky130_fd_sc_hd__o31ai_2 _204_ (.A1(_093_),
    .A2(_094_),
    .A3(_096_),
    .B1(_104_),
    .Y(_105_));
 sky130_fd_sc_hd__a21oi_2 _205_ (.A1(_103_),
    .A2(_105_),
    .B1(_102_),
    .Y(_106_));
 sky130_fd_sc_hd__and3_2 _206_ (.A(_102_),
    .B(_103_),
    .C(_105_),
    .X(_107_));
 sky130_fd_sc_hd__nor3_2 _207_ (.A(reset),
    .B(_106_),
    .C(_107_),
    .Y(_006_));
 sky130_fd_sc_hd__nand2_2 _208_ (.A(\u_rev.rfa_bits[7].rfa.b ),
    .B(\u_rev.rfa_bits[7].fa_ga ),
    .Y(_108_));
 sky130_fd_sc_hd__or2_2 _209_ (.A(\u_rev.rfa_bits[7].rfa.b ),
    .B(\u_rev.rfa_bits[7].fa_ga ),
    .X(_109_));
 sky130_fd_sc_hd__and2_2 _210_ (.A(_108_),
    .B(_109_),
    .X(_110_));
 sky130_fd_sc_hd__nand4_2 _211_ (.A(\u_rev.rfa_bits[6].rfa.anc_in ),
    .B(_102_),
    .C(_103_),
    .D(_105_),
    .Y(_111_));
 sky130_fd_sc_hd__xnor2_2 _212_ (.A(\u_rev.rfa_bits[6].rfa.anc_in ),
    .B(_099_),
    .Y(_112_));
 sky130_fd_sc_hd__a31o_2 _213_ (.A1(_102_),
    .A2(_103_),
    .A3(_105_),
    .B1(_112_),
    .X(_113_));
 sky130_fd_sc_hd__a21oi_2 _214_ (.A1(_111_),
    .A2(_113_),
    .B1(_110_),
    .Y(_114_));
 sky130_fd_sc_hd__and3_2 _215_ (.A(_110_),
    .B(_111_),
    .C(_113_),
    .X(_115_));
 sky130_fd_sc_hd__nor3_2 _216_ (.A(reset),
    .B(_114_),
    .C(_115_),
    .Y(_007_));
 sky130_fd_sc_hd__xnor2_2 _217_ (.A(\u_rev.rfa_bits[7].rfa.anc_in ),
    .B(_108_),
    .Y(_116_));
 sky130_fd_sc_hd__nor2_2 _218_ (.A(reset),
    .B(_116_),
    .Y(_117_));
 sky130_fd_sc_hd__and2b_2 _219_ (.A_N(reset),
    .B(_116_),
    .X(_049_));
 sky130_fd_sc_hd__mux2_1 _220_ (.A0(_049_),
    .A1(_117_),
    .S(_115_),
    .X(_008_));
 sky130_fd_sc_hd__and2b_2 _221_ (.A_N(reset),
    .B(\u_rev.rfa_bits[0].fa_ga ),
    .X(_009_));
 sky130_fd_sc_hd__and2b_2 _222_ (.A_N(reset),
    .B(\u_rev.rfa_bits[1].fa_ga ),
    .X(_010_));
 sky130_fd_sc_hd__and2b_2 _223_ (.A_N(reset),
    .B(\u_rev.rfa_bits[2].fa_ga ),
    .X(_011_));
 sky130_fd_sc_hd__and2b_2 _224_ (.A_N(reset),
    .B(\u_rev.rfa_bits[3].fa_ga ),
    .X(_012_));
 sky130_fd_sc_hd__and2b_2 _225_ (.A_N(reset),
    .B(\u_rev.rfa_bits[4].fa_ga ),
    .X(_013_));
 sky130_fd_sc_hd__and2b_2 _226_ (.A_N(reset),
    .B(\u_rev.rfa_bits[5].fa_ga ),
    .X(_014_));
 sky130_fd_sc_hd__and2b_2 _227_ (.A_N(reset),
    .B(\u_rev.rfa_bits[6].fa_ga ),
    .X(_015_));
 sky130_fd_sc_hd__and2b_2 _228_ (.A_N(reset),
    .B(\u_rev.rfa_bits[7].fa_ga ),
    .X(_016_));
 sky130_fd_sc_hd__mux2_1 _229_ (.A0(\u_rev.rfa_bits[0].fa_ga ),
    .A1(a[0]),
    .S(enable),
    .X(_118_));
 sky130_fd_sc_hd__and2b_2 _230_ (.A_N(reset),
    .B(_118_),
    .X(_017_));
 sky130_fd_sc_hd__mux2_1 _231_ (.A0(\u_rev.rfa_bits[1].fa_ga ),
    .A1(a[1]),
    .S(enable),
    .X(_119_));
 sky130_fd_sc_hd__and2b_2 _232_ (.A_N(reset),
    .B(_119_),
    .X(_018_));
 sky130_fd_sc_hd__mux2_1 _233_ (.A0(\u_rev.rfa_bits[2].fa_ga ),
    .A1(a[2]),
    .S(enable),
    .X(_120_));
 sky130_fd_sc_hd__and2b_2 _234_ (.A_N(reset),
    .B(_120_),
    .X(_019_));
 sky130_fd_sc_hd__mux2_1 _235_ (.A0(\u_rev.rfa_bits[3].fa_ga ),
    .A1(a[3]),
    .S(enable),
    .X(_121_));
 sky130_fd_sc_hd__and2b_2 _236_ (.A_N(reset),
    .B(_121_),
    .X(_020_));
 sky130_fd_sc_hd__mux2_1 _237_ (.A0(\u_rev.rfa_bits[4].fa_ga ),
    .A1(a[4]),
    .S(enable),
    .X(_122_));
 sky130_fd_sc_hd__and2b_2 _238_ (.A_N(reset),
    .B(_122_),
    .X(_021_));
 sky130_fd_sc_hd__mux2_1 _239_ (.A0(\u_rev.rfa_bits[5].fa_ga ),
    .A1(a[5]),
    .S(enable),
    .X(_123_));
 sky130_fd_sc_hd__and2b_2 _240_ (.A_N(reset),
    .B(_123_),
    .X(_022_));
 sky130_fd_sc_hd__mux2_1 _241_ (.A0(\u_rev.rfa_bits[6].fa_ga ),
    .A1(a[6]),
    .S(enable),
    .X(_124_));
 sky130_fd_sc_hd__and2b_2 _242_ (.A_N(reset),
    .B(_124_),
    .X(_023_));
 sky130_fd_sc_hd__mux2_1 _243_ (.A0(\u_rev.rfa_bits[7].fa_ga ),
    .A1(a[7]),
    .S(enable),
    .X(_125_));
 sky130_fd_sc_hd__and2b_2 _244_ (.A_N(reset),
    .B(_125_),
    .X(_024_));
 sky130_fd_sc_hd__mux2_1 _245_ (.A0(\u_rev.rfa_bits[0].rfa.b ),
    .A1(b[0]),
    .S(enable),
    .X(_126_));
 sky130_fd_sc_hd__and2b_2 _246_ (.A_N(reset),
    .B(_126_),
    .X(_025_));
 sky130_fd_sc_hd__mux2_1 _247_ (.A0(\u_rev.rfa_bits[1].rfa.b ),
    .A1(b[1]),
    .S(enable),
    .X(_127_));
 sky130_fd_sc_hd__and2b_2 _248_ (.A_N(reset),
    .B(_127_),
    .X(_026_));
 sky130_fd_sc_hd__mux2_1 _249_ (.A0(\u_rev.rfa_bits[2].rfa.b ),
    .A1(b[2]),
    .S(enable),
    .X(_128_));
 sky130_fd_sc_hd__and2b_2 _250_ (.A_N(reset),
    .B(_128_),
    .X(_027_));
 sky130_fd_sc_hd__mux2_1 _251_ (.A0(\u_rev.rfa_bits[3].rfa.b ),
    .A1(b[3]),
    .S(enable),
    .X(_129_));
 sky130_fd_sc_hd__and2b_2 _252_ (.A_N(reset),
    .B(_129_),
    .X(_028_));
 sky130_fd_sc_hd__mux2_1 _253_ (.A0(\u_rev.rfa_bits[4].rfa.b ),
    .A1(b[4]),
    .S(enable),
    .X(_130_));
 sky130_fd_sc_hd__and2b_2 _254_ (.A_N(reset),
    .B(_130_),
    .X(_029_));
 sky130_fd_sc_hd__mux2_1 _255_ (.A0(\u_rev.rfa_bits[5].rfa.b ),
    .A1(b[5]),
    .S(enable),
    .X(_131_));
 sky130_fd_sc_hd__and2b_2 _256_ (.A_N(reset),
    .B(_131_),
    .X(_030_));
 sky130_fd_sc_hd__mux2_1 _257_ (.A0(\u_rev.rfa_bits[6].rfa.b ),
    .A1(b[6]),
    .S(enable),
    .X(_132_));
 sky130_fd_sc_hd__and2b_2 _258_ (.A_N(reset),
    .B(_132_),
    .X(_031_));
 sky130_fd_sc_hd__mux2_1 _259_ (.A0(\u_rev.rfa_bits[7].rfa.b ),
    .A1(b[7]),
    .S(enable),
    .X(_133_));
 sky130_fd_sc_hd__and2b_2 _260_ (.A_N(reset),
    .B(_133_),
    .X(_032_));
 sky130_fd_sc_hd__mux2_1 _261_ (.A0(\u_rev.rfa_bits[0].rfa.anc_in ),
    .A1(anc[0]),
    .S(enable),
    .X(_134_));
 sky130_fd_sc_hd__and2b_2 _262_ (.A_N(reset),
    .B(_134_),
    .X(_033_));
 sky130_fd_sc_hd__mux2_1 _263_ (.A0(\u_rev.rfa_bits[1].rfa.anc_in ),
    .A1(anc[1]),
    .S(enable),
    .X(_135_));
 sky130_fd_sc_hd__and2b_2 _264_ (.A_N(reset),
    .B(_135_),
    .X(_034_));
 sky130_fd_sc_hd__mux2_1 _265_ (.A0(\u_rev.rfa_bits[2].rfa.anc_in ),
    .A1(anc[2]),
    .S(enable),
    .X(_136_));
 sky130_fd_sc_hd__and2b_2 _266_ (.A_N(reset),
    .B(_136_),
    .X(_035_));
 sky130_fd_sc_hd__mux2_1 _267_ (.A0(\u_rev.rfa_bits[3].rfa.anc_in ),
    .A1(anc[3]),
    .S(enable),
    .X(_137_));
 sky130_fd_sc_hd__and2b_2 _268_ (.A_N(reset),
    .B(_137_),
    .X(_036_));
 sky130_fd_sc_hd__mux2_1 _269_ (.A0(\u_rev.rfa_bits[4].rfa.anc_in ),
    .A1(anc[4]),
    .S(enable),
    .X(_138_));
 sky130_fd_sc_hd__and2b_2 _270_ (.A_N(reset),
    .B(_138_),
    .X(_037_));
 sky130_fd_sc_hd__mux2_1 _271_ (.A0(\u_rev.rfa_bits[5].rfa.anc_in ),
    .A1(anc[5]),
    .S(enable),
    .X(_139_));
 sky130_fd_sc_hd__and2b_2 _272_ (.A_N(reset),
    .B(_139_),
    .X(_038_));
 sky130_fd_sc_hd__mux2_1 _273_ (.A0(\u_rev.rfa_bits[6].rfa.anc_in ),
    .A1(anc[6]),
    .S(enable),
    .X(_140_));
 sky130_fd_sc_hd__and2b_2 _274_ (.A_N(reset),
    .B(_140_),
    .X(_039_));
 sky130_fd_sc_hd__mux2_1 _275_ (.A0(\u_rev.rfa_bits[7].rfa.anc_in ),
    .A1(anc[7]),
    .S(enable),
    .X(_141_));
 sky130_fd_sc_hd__and2b_2 _276_ (.A_N(reset),
    .B(_141_),
    .X(_040_));
 sky130_fd_sc_hd__mux2_1 _277_ (.A0(cin_r),
    .A1(cin),
    .S(enable),
    .X(_142_));
 sky130_fd_sc_hd__and2b_2 _278_ (.A_N(reset),
    .B(_142_),
    .X(_041_));
 sky130_fd_sc_hd__and3b_2 _279_ (.A_N(reset),
    .B(_062_),
    .C(_063_),
    .X(_042_));
 sky130_fd_sc_hd__nor2_2 _280_ (.A(reset),
    .B(_070_),
    .Y(_043_));
 sky130_fd_sc_hd__nor2_2 _281_ (.A(reset),
    .B(_077_),
    .Y(_044_));
 sky130_fd_sc_hd__nor2_2 _282_ (.A(reset),
    .B(_087_),
    .Y(_045_));
 sky130_fd_sc_hd__nor2_2 _283_ (.A(reset),
    .B(_095_),
    .Y(_046_));
 sky130_fd_sc_hd__nor2_2 _284_ (.A(reset),
    .B(_104_),
    .Y(_047_));
 sky130_fd_sc_hd__and2b_2 _285_ (.A_N(reset),
    .B(_112_),
    .X(_048_));
 sky130_fd_sc_hd__dfxtp_2 _286_ (.CLK(clk),
    .D(_000_),
    .Q(sum[0]));
 sky130_fd_sc_hd__dfxtp_2 _287_ (.CLK(clk),
    .D(_001_),
    .Q(sum[1]));
 sky130_fd_sc_hd__dfxtp_2 _288_ (.CLK(clk),
    .D(_002_),
    .Q(sum[2]));
 sky130_fd_sc_hd__dfxtp_2 _289_ (.CLK(clk),
    .D(_003_),
    .Q(sum[3]));
 sky130_fd_sc_hd__dfxtp_2 _290_ (.CLK(clk),
    .D(_004_),
    .Q(sum[4]));
 sky130_fd_sc_hd__dfxtp_2 _291_ (.CLK(clk),
    .D(_005_),
    .Q(sum[5]));
 sky130_fd_sc_hd__dfxtp_2 _292_ (.CLK(clk),
    .D(_006_),
    .Q(sum[6]));
 sky130_fd_sc_hd__dfxtp_2 _293_ (.CLK(clk),
    .D(_007_),
    .Q(sum[7]));
 sky130_fd_sc_hd__dfxtp_2 _294_ (.CLK(clk),
    .D(_008_),
    .Q(cout));
 sky130_fd_sc_hd__dfxtp_2 _295_ (.CLK(clk),
    .D(_009_),
    .Q(g_a[0]));
 sky130_fd_sc_hd__dfxtp_2 _296_ (.CLK(clk),
    .D(_010_),
    .Q(g_a[1]));
 sky130_fd_sc_hd__dfxtp_2 _297_ (.CLK(clk),
    .D(_011_),
    .Q(g_a[2]));
 sky130_fd_sc_hd__dfxtp_2 _298_ (.CLK(clk),
    .D(_012_),
    .Q(g_a[3]));
 sky130_fd_sc_hd__dfxtp_2 _299_ (.CLK(clk),
    .D(_013_),
    .Q(g_a[4]));
 sky130_fd_sc_hd__dfxtp_2 _300_ (.CLK(clk),
    .D(_014_),
    .Q(g_a[5]));
 sky130_fd_sc_hd__dfxtp_2 _301_ (.CLK(clk),
    .D(_015_),
    .Q(g_a[6]));
 sky130_fd_sc_hd__dfxtp_2 _302_ (.CLK(clk),
    .D(_016_),
    .Q(g_a[7]));
 sky130_fd_sc_hd__dfxtp_2 _303_ (.CLK(clk),
    .D(_017_),
    .Q(\u_rev.rfa_bits[0].fa_ga ));
 sky130_fd_sc_hd__dfxtp_2 _304_ (.CLK(clk),
    .D(_018_),
    .Q(\u_rev.rfa_bits[1].fa_ga ));
 sky130_fd_sc_hd__dfxtp_2 _305_ (.CLK(clk),
    .D(_019_),
    .Q(\u_rev.rfa_bits[2].fa_ga ));
 sky130_fd_sc_hd__dfxtp_2 _306_ (.CLK(clk),
    .D(_020_),
    .Q(\u_rev.rfa_bits[3].fa_ga ));
 sky130_fd_sc_hd__dfxtp_2 _307_ (.CLK(clk),
    .D(_021_),
    .Q(\u_rev.rfa_bits[4].fa_ga ));
 sky130_fd_sc_hd__dfxtp_2 _308_ (.CLK(clk),
    .D(_022_),
    .Q(\u_rev.rfa_bits[5].fa_ga ));
 sky130_fd_sc_hd__dfxtp_2 _309_ (.CLK(clk),
    .D(_023_),
    .Q(\u_rev.rfa_bits[6].fa_ga ));
 sky130_fd_sc_hd__dfxtp_2 _310_ (.CLK(clk),
    .D(_024_),
    .Q(\u_rev.rfa_bits[7].fa_ga ));
 sky130_fd_sc_hd__dfxtp_2 _311_ (.CLK(clk),
    .D(_025_),
    .Q(\u_rev.rfa_bits[0].rfa.b ));
 sky130_fd_sc_hd__dfxtp_2 _312_ (.CLK(clk),
    .D(_026_),
    .Q(\u_rev.rfa_bits[1].rfa.b ));
 sky130_fd_sc_hd__dfxtp_2 _313_ (.CLK(clk),
    .D(_027_),
    .Q(\u_rev.rfa_bits[2].rfa.b ));
 sky130_fd_sc_hd__dfxtp_2 _314_ (.CLK(clk),
    .D(_028_),
    .Q(\u_rev.rfa_bits[3].rfa.b ));
 sky130_fd_sc_hd__dfxtp_2 _315_ (.CLK(clk),
    .D(_029_),
    .Q(\u_rev.rfa_bits[4].rfa.b ));
 sky130_fd_sc_hd__dfxtp_2 _316_ (.CLK(clk),
    .D(_030_),
    .Q(\u_rev.rfa_bits[5].rfa.b ));
 sky130_fd_sc_hd__dfxtp_2 _317_ (.CLK(clk),
    .D(_031_),
    .Q(\u_rev.rfa_bits[6].rfa.b ));
 sky130_fd_sc_hd__dfxtp_2 _318_ (.CLK(clk),
    .D(_032_),
    .Q(\u_rev.rfa_bits[7].rfa.b ));
 sky130_fd_sc_hd__dfxtp_2 _319_ (.CLK(clk),
    .D(_033_),
    .Q(\u_rev.rfa_bits[0].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_2 _320_ (.CLK(clk),
    .D(_034_),
    .Q(\u_rev.rfa_bits[1].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_2 _321_ (.CLK(clk),
    .D(_035_),
    .Q(\u_rev.rfa_bits[2].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_2 _322_ (.CLK(clk),
    .D(_036_),
    .Q(\u_rev.rfa_bits[3].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_2 _323_ (.CLK(clk),
    .D(_037_),
    .Q(\u_rev.rfa_bits[4].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_2 _324_ (.CLK(clk),
    .D(_038_),
    .Q(\u_rev.rfa_bits[5].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_2 _325_ (.CLK(clk),
    .D(_039_),
    .Q(\u_rev.rfa_bits[6].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_2 _326_ (.CLK(clk),
    .D(_040_),
    .Q(\u_rev.rfa_bits[7].rfa.anc_in ));
 sky130_fd_sc_hd__dfxtp_2 _327_ (.CLK(clk),
    .D(_041_),
    .Q(cin_r));
 sky130_fd_sc_hd__dfxtp_2 _328_ (.CLK(clk),
    .D(_042_),
    .Q(g_ab[0]));
 sky130_fd_sc_hd__dfxtp_2 _329_ (.CLK(clk),
    .D(_043_),
    .Q(g_ab[1]));
 sky130_fd_sc_hd__dfxtp_2 _330_ (.CLK(clk),
    .D(_044_),
    .Q(g_ab[2]));
 sky130_fd_sc_hd__dfxtp_2 _331_ (.CLK(clk),
    .D(_045_),
    .Q(g_ab[3]));
 sky130_fd_sc_hd__dfxtp_2 _332_ (.CLK(clk),
    .D(_046_),
    .Q(g_ab[4]));
 sky130_fd_sc_hd__dfxtp_2 _333_ (.CLK(clk),
    .D(_047_),
    .Q(g_ab[5]));
 sky130_fd_sc_hd__dfxtp_2 _334_ (.CLK(clk),
    .D(_048_),
    .Q(g_ab[6]));
 sky130_fd_sc_hd__dfxtp_2 _335_ (.CLK(clk),
    .D(_049_),
    .Q(g_ab[7]));
endmodule

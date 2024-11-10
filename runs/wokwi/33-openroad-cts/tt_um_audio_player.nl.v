module tt_um_audio_player (clk,
    ena,
    rst_n,
    ui_in,
    uio_in,
    uio_oe,
    uio_out,
    uo_out);
 input clk;
 input ena;
 input rst_n;
 input [7:0] ui_in;
 input [7:0] uio_in;
 output [7:0] uio_oe;
 output [7:0] uio_out;
 output [7:0] uo_out;

 wire _0000_;
 wire _0001_;
 wire _0002_;
 wire _0003_;
 wire _0004_;
 wire _0005_;
 wire _0006_;
 wire _0007_;
 wire _0008_;
 wire _0009_;
 wire _0010_;
 wire _0011_;
 wire _0012_;
 wire _0013_;
 wire _0014_;
 wire _0015_;
 wire _0016_;
 wire _0017_;
 wire _0018_;
 wire _0019_;
 wire _0020_;
 wire _0021_;
 wire _0022_;
 wire _0023_;
 wire _0024_;
 wire _0025_;
 wire _0026_;
 wire _0027_;
 wire _0028_;
 wire _0029_;
 wire _0030_;
 wire _0031_;
 wire _0032_;
 wire _0033_;
 wire _0034_;
 wire _0035_;
 wire _0036_;
 wire _0037_;
 wire _0038_;
 wire _0039_;
 wire _0040_;
 wire _0041_;
 wire _0042_;
 wire _0043_;
 wire _0044_;
 wire _0045_;
 wire _0046_;
 wire _0047_;
 wire _0048_;
 wire _0049_;
 wire _0050_;
 wire _0051_;
 wire _0052_;
 wire _0053_;
 wire _0054_;
 wire _0055_;
 wire _0056_;
 wire _0057_;
 wire _0058_;
 wire _0059_;
 wire _0060_;
 wire _0061_;
 wire _0062_;
 wire _0063_;
 wire _0064_;
 wire _0065_;
 wire _0066_;
 wire _0067_;
 wire _0068_;
 wire _0069_;
 wire _0070_;
 wire _0071_;
 wire _0072_;
 wire _0073_;
 wire _0074_;
 wire _0075_;
 wire _0076_;
 wire _0077_;
 wire _0078_;
 wire _0079_;
 wire _0080_;
 wire _0081_;
 wire _0082_;
 wire _0083_;
 wire _0084_;
 wire _0085_;
 wire _0086_;
 wire _0087_;
 wire _0088_;
 wire _0089_;
 wire _0090_;
 wire _0091_;
 wire _0092_;
 wire _0093_;
 wire _0094_;
 wire _0095_;
 wire _0096_;
 wire _0097_;
 wire _0098_;
 wire _0099_;
 wire _0100_;
 wire _0101_;
 wire _0102_;
 wire _0103_;
 wire _0104_;
 wire _0105_;
 wire _0106_;
 wire _0107_;
 wire _0108_;
 wire _0109_;
 wire _0110_;
 wire _0111_;
 wire _0112_;
 wire _0113_;
 wire _0114_;
 wire _0115_;
 wire _0116_;
 wire _0117_;
 wire _0118_;
 wire _0119_;
 wire _0120_;
 wire _0121_;
 wire _0122_;
 wire _0123_;
 wire _0124_;
 wire _0125_;
 wire _0126_;
 wire _0127_;
 wire _0128_;
 wire _0129_;
 wire _0130_;
 wire _0131_;
 wire _0132_;
 wire _0133_;
 wire _0134_;
 wire _0135_;
 wire _0136_;
 wire _0137_;
 wire _0138_;
 wire _0139_;
 wire _0140_;
 wire _0141_;
 wire _0142_;
 wire _0143_;
 wire _0144_;
 wire _0145_;
 wire _0146_;
 wire _0147_;
 wire _0148_;
 wire _0149_;
 wire _0150_;
 wire _0151_;
 wire _0152_;
 wire _0153_;
 wire _0154_;
 wire _0155_;
 wire _0156_;
 wire _0157_;
 wire _0158_;
 wire _0159_;
 wire _0160_;
 wire _0161_;
 wire _0162_;
 wire _0163_;
 wire _0164_;
 wire _0165_;
 wire _0166_;
 wire _0167_;
 wire _0168_;
 wire _0169_;
 wire _0170_;
 wire _0171_;
 wire _0172_;
 wire _0173_;
 wire _0174_;
 wire _0175_;
 wire _0176_;
 wire _0177_;
 wire _0178_;
 wire _0179_;
 wire _0180_;
 wire _0181_;
 wire _0182_;
 wire _0183_;
 wire _0184_;
 wire _0185_;
 wire _0186_;
 wire _0187_;
 wire _0188_;
 wire _0189_;
 wire _0190_;
 wire _0191_;
 wire _0192_;
 wire _0193_;
 wire _0194_;
 wire _0195_;
 wire _0196_;
 wire _0197_;
 wire _0198_;
 wire _0199_;
 wire _0200_;
 wire _0201_;
 wire _0202_;
 wire _0203_;
 wire _0204_;
 wire _0205_;
 wire _0206_;
 wire _0207_;
 wire _0208_;
 wire _0209_;
 wire _0210_;
 wire _0211_;
 wire _0212_;
 wire _0213_;
 wire _0214_;
 wire _0215_;
 wire _0216_;
 wire _0217_;
 wire _0218_;
 wire _0219_;
 wire _0220_;
 wire _0221_;
 wire _0222_;
 wire _0223_;
 wire _0224_;
 wire _0225_;
 wire _0226_;
 wire _0227_;
 wire _0228_;
 wire _0229_;
 wire _0230_;
 wire _0231_;
 wire _0232_;
 wire _0233_;
 wire _0234_;
 wire _0235_;
 wire _0236_;
 wire _0237_;
 wire _0238_;
 wire _0239_;
 wire _0240_;
 wire _0241_;
 wire _0242_;
 wire _0243_;
 wire _0244_;
 wire _0245_;
 wire _0246_;
 wire _0247_;
 wire _0248_;
 wire _0249_;
 wire _0250_;
 wire _0251_;
 wire _0252_;
 wire _0253_;
 wire _0254_;
 wire _0255_;
 wire _0256_;
 wire _0257_;
 wire _0258_;
 wire _0259_;
 wire _0260_;
 wire _0261_;
 wire _0262_;
 wire _0263_;
 wire _0264_;
 wire _0265_;
 wire _0266_;
 wire _0267_;
 wire _0268_;
 wire _0269_;
 wire _0270_;
 wire _0271_;
 wire _0272_;
 wire _0273_;
 wire _0274_;
 wire _0275_;
 wire _0276_;
 wire _0277_;
 wire _0278_;
 wire _0279_;
 wire _0280_;
 wire _0281_;
 wire _0282_;
 wire _0283_;
 wire _0284_;
 wire _0285_;
 wire _0286_;
 wire _0287_;
 wire _0288_;
 wire _0289_;
 wire _0290_;
 wire _0291_;
 wire _0292_;
 wire _0293_;
 wire _0294_;
 wire _0295_;
 wire _0296_;
 wire _0297_;
 wire _0298_;
 wire _0299_;
 wire _0300_;
 wire _0301_;
 wire _0302_;
 wire _0303_;
 wire _0304_;
 wire _0305_;
 wire _0306_;
 wire _0307_;
 wire _0308_;
 wire _0309_;
 wire _0310_;
 wire _0311_;
 wire _0312_;
 wire _0313_;
 wire _0314_;
 wire _0315_;
 wire _0316_;
 wire _0317_;
 wire _0318_;
 wire _0319_;
 wire _0320_;
 wire _0321_;
 wire _0322_;
 wire _0323_;
 wire _0324_;
 wire _0325_;
 wire _0326_;
 wire _0327_;
 wire _0328_;
 wire _0329_;
 wire _0330_;
 wire _0331_;
 wire _0332_;
 wire _0333_;
 wire _0334_;
 wire _0335_;
 wire _0336_;
 wire _0337_;
 wire _0338_;
 wire _0339_;
 wire _0340_;
 wire _0341_;
 wire _0342_;
 wire _0343_;
 wire _0344_;
 wire _0345_;
 wire _0346_;
 wire _0347_;
 wire _0348_;
 wire _0349_;
 wire _0350_;
 wire _0351_;
 wire _0352_;
 wire _0353_;
 wire _0354_;
 wire _0355_;
 wire _0356_;
 wire _0357_;
 wire _0358_;
 wire _0359_;
 wire _0360_;
 wire _0361_;
 wire _0362_;
 wire _0363_;
 wire _0364_;
 wire _0365_;
 wire _0366_;
 wire _0367_;
 wire _0368_;
 wire _0369_;
 wire _0370_;
 wire _0371_;
 wire _0372_;
 wire _0373_;
 wire _0374_;
 wire _0375_;
 wire _0376_;
 wire _0377_;
 wire _0378_;
 wire _0379_;
 wire _0380_;
 wire _0381_;
 wire _0382_;
 wire _0383_;
 wire _0384_;
 wire _0385_;
 wire _0386_;
 wire _0387_;
 wire _0388_;
 wire _0389_;
 wire _0390_;
 wire _0391_;
 wire _0392_;
 wire _0393_;
 wire _0394_;
 wire _0395_;
 wire _0396_;
 wire _0397_;
 wire _0398_;
 wire _0399_;
 wire _0400_;
 wire _0401_;
 wire _0402_;
 wire _0403_;
 wire _0404_;
 wire _0405_;
 wire _0406_;
 wire _0407_;
 wire _0408_;
 wire _0409_;
 wire _0410_;
 wire _0411_;
 wire _0412_;
 wire _0413_;
 wire _0414_;
 wire _0415_;
 wire _0416_;
 wire _0417_;
 wire _0418_;
 wire _0419_;
 wire _0420_;
 wire _0421_;
 wire _0422_;
 wire _0423_;
 wire _0424_;
 wire _0425_;
 wire _0426_;
 wire _0427_;
 wire _0428_;
 wire _0429_;
 wire _0430_;
 wire _0431_;
 wire _0432_;
 wire _0433_;
 wire _0434_;
 wire _0435_;
 wire _0436_;
 wire _0437_;
 wire _0438_;
 wire _0439_;
 wire _0440_;
 wire _0441_;
 wire _0442_;
 wire _0443_;
 wire _0444_;
 wire _0445_;
 wire _0446_;
 wire _0447_;
 wire _0448_;
 wire _0449_;
 wire _0450_;
 wire _0451_;
 wire _0452_;
 wire _0453_;
 wire _0454_;
 wire _0455_;
 wire _0456_;
 wire _0457_;
 wire _0458_;
 wire _0459_;
 wire _0460_;
 wire _0461_;
 wire _0462_;
 wire _0463_;
 wire _0464_;
 wire _0465_;
 wire _0466_;
 wire _0467_;
 wire _0468_;
 wire _0469_;
 wire _0470_;
 wire _0471_;
 wire _0472_;
 wire _0473_;
 wire _0474_;
 wire _0475_;
 wire _0476_;
 wire _0477_;
 wire _0478_;
 wire _0479_;
 wire _0480_;
 wire _0481_;
 wire _0482_;
 wire _0483_;
 wire _0484_;
 wire _0485_;
 wire _0486_;
 wire _0487_;
 wire _0488_;
 wire _0489_;
 wire _0490_;
 wire _0491_;
 wire _0492_;
 wire _0493_;
 wire _0494_;
 wire _0495_;
 wire _0496_;
 wire _0497_;
 wire _0498_;
 wire _0499_;
 wire _0500_;
 wire _0501_;
 wire _0502_;
 wire _0503_;
 wire _0504_;
 wire _0505_;
 wire _0506_;
 wire _0507_;
 wire _0508_;
 wire _0509_;
 wire _0510_;
 wire _0511_;
 wire _0512_;
 wire _0513_;
 wire _0514_;
 wire _0515_;
 wire _0516_;
 wire _0517_;
 wire _0518_;
 wire _0519_;
 wire _0520_;
 wire _0521_;
 wire _0522_;
 wire _0523_;
 wire _0524_;
 wire _0525_;
 wire _0526_;
 wire _0527_;
 wire _0528_;
 wire _0529_;
 wire _0530_;
 wire _0531_;
 wire _0532_;
 wire _0533_;
 wire _0534_;
 wire _0535_;
 wire _0536_;
 wire _0537_;
 wire _0538_;
 wire _0539_;
 wire _0540_;
 wire _0541_;
 wire _0542_;
 wire _0543_;
 wire _0544_;
 wire _0545_;
 wire _0546_;
 wire _0547_;
 wire _0548_;
 wire _0549_;
 wire _0550_;
 wire _0551_;
 wire _0552_;
 wire _0553_;
 wire _0554_;
 wire _0555_;
 wire _0556_;
 wire _0557_;
 wire _0558_;
 wire _0559_;
 wire _0560_;
 wire _0561_;
 wire _0562_;
 wire _0563_;
 wire _0564_;
 wire _0565_;
 wire _0566_;
 wire _0567_;
 wire _0568_;
 wire _0569_;
 wire _0570_;
 wire _0571_;
 wire _0572_;
 wire _0573_;
 wire _0574_;
 wire _0575_;
 wire _0576_;
 wire _0577_;
 wire _0578_;
 wire _0579_;
 wire _0580_;
 wire _0581_;
 wire _0582_;
 wire _0583_;
 wire _0584_;
 wire _0585_;
 wire _0586_;
 wire _0587_;
 wire _0588_;
 wire _0589_;
 wire _0590_;
 wire _0591_;
 wire _0592_;
 wire _0593_;
 wire _0594_;
 wire _0595_;
 wire _0596_;
 wire _0597_;
 wire _0598_;
 wire _0599_;
 wire _0600_;
 wire _0601_;
 wire _0602_;
 wire _0603_;
 wire _0604_;
 wire _0605_;
 wire _0606_;
 wire _0607_;
 wire _0608_;
 wire _0609_;
 wire _0610_;
 wire _0611_;
 wire _0612_;
 wire _0613_;
 wire _0614_;
 wire _0615_;
 wire _0616_;
 wire _0617_;
 wire _0618_;
 wire _0619_;
 wire _0620_;
 wire _0621_;
 wire _0622_;
 wire _0623_;
 wire _0624_;
 wire _0625_;
 wire _0626_;
 wire _0627_;
 wire _0628_;
 wire _0629_;
 wire _0630_;
 wire _0631_;
 wire _0632_;
 wire _0633_;
 wire _0634_;
 wire _0635_;
 wire _0636_;
 wire _0637_;
 wire _0638_;
 wire _0639_;
 wire _0640_;
 wire _0641_;
 wire _0642_;
 wire _0643_;
 wire _0644_;
 wire _0645_;
 wire _0646_;
 wire _0647_;
 wire _0648_;
 wire _0649_;
 wire _0650_;
 wire _0651_;
 wire _0652_;
 wire _0653_;
 wire _0654_;
 wire _0655_;
 wire _0656_;
 wire _0657_;
 wire _0658_;
 wire _0659_;
 wire _0660_;
 wire _0661_;
 wire _0662_;
 wire _0663_;
 wire _0664_;
 wire _0665_;
 wire _0666_;
 wire _0667_;
 wire _0668_;
 wire _0669_;
 wire _0670_;
 wire _0671_;
 wire _0672_;
 wire _0673_;
 wire _0674_;
 wire _0675_;
 wire _0676_;
 wire _0677_;
 wire _0678_;
 wire _0679_;
 wire _0680_;
 wire _0681_;
 wire _0682_;
 wire _0683_;
 wire _0684_;
 wire _0685_;
 wire _0686_;
 wire _0687_;
 wire _0688_;
 wire _0689_;
 wire _0690_;
 wire _0691_;
 wire _0692_;
 wire _0693_;
 wire _0694_;
 wire _0695_;
 wire _0696_;
 wire _0697_;
 wire _0698_;
 wire _0699_;
 wire _0700_;
 wire _0701_;
 wire _0702_;
 wire _0703_;
 wire _0704_;
 wire _0705_;
 wire _0706_;
 wire _0707_;
 wire _0708_;
 wire _0709_;
 wire _0710_;
 wire _0711_;
 wire _0712_;
 wire _0713_;
 wire _0714_;
 wire _0715_;
 wire _0716_;
 wire _0717_;
 wire _0718_;
 wire _0719_;
 wire _0720_;
 wire _0721_;
 wire _0722_;
 wire _0723_;
 wire _0724_;
 wire _0725_;
 wire _0726_;
 wire _0727_;
 wire _0728_;
 wire _0729_;
 wire _0730_;
 wire _0731_;
 wire _0732_;
 wire _0733_;
 wire _0734_;
 wire _0735_;
 wire _0736_;
 wire _0737_;
 wire _0738_;
 wire _0739_;
 wire _0740_;
 wire _0741_;
 wire _0742_;
 wire _0743_;
 wire _0744_;
 wire _0745_;
 wire _0746_;
 wire _0747_;
 wire _0748_;
 wire _0749_;
 wire _0750_;
 wire _0751_;
 wire _0752_;
 wire _0753_;
 wire _0754_;
 wire _0755_;
 wire _0756_;
 wire _0757_;
 wire _0758_;
 wire _0759_;
 wire _0760_;
 wire _0761_;
 wire _0762_;
 wire _0763_;
 wire _0764_;
 wire _0765_;
 wire _0766_;
 wire _0767_;
 wire _0768_;
 wire _0769_;
 wire _0770_;
 wire _0771_;
 wire _0772_;
 wire _0773_;
 wire _0774_;
 wire _0775_;
 wire _0776_;
 wire _0777_;
 wire _0778_;
 wire _0779_;
 wire _0780_;
 wire _0781_;
 wire _0782_;
 wire _0783_;
 wire _0784_;
 wire _0785_;
 wire _0786_;
 wire \audio_player_inst.audio_out ;
 wire \audio_player_inst.current_addr[0] ;
 wire \audio_player_inst.current_addr[10] ;
 wire \audio_player_inst.current_addr[11] ;
 wire \audio_player_inst.current_addr[12] ;
 wire \audio_player_inst.current_addr[13] ;
 wire \audio_player_inst.current_addr[14] ;
 wire \audio_player_inst.current_addr[15] ;
 wire \audio_player_inst.current_addr[1] ;
 wire \audio_player_inst.current_addr[2] ;
 wire \audio_player_inst.current_addr[3] ;
 wire \audio_player_inst.current_addr[4] ;
 wire \audio_player_inst.current_addr[5] ;
 wire \audio_player_inst.current_addr[6] ;
 wire \audio_player_inst.current_addr[7] ;
 wire \audio_player_inst.current_addr[8] ;
 wire \audio_player_inst.current_addr[9] ;
 wire \audio_player_inst.pwm_counter[0] ;
 wire \audio_player_inst.pwm_counter[1] ;
 wire \audio_player_inst.pwm_counter[2] ;
 wire \audio_player_inst.pwm_counter[3] ;
 wire \audio_player_inst.sample_counter[0] ;
 wire \audio_player_inst.sample_counter[10] ;
 wire \audio_player_inst.sample_counter[11] ;
 wire \audio_player_inst.sample_counter[1] ;
 wire \audio_player_inst.sample_counter[2] ;
 wire \audio_player_inst.sample_counter[3] ;
 wire \audio_player_inst.sample_counter[4] ;
 wire \audio_player_inst.sample_counter[5] ;
 wire \audio_player_inst.sample_counter[6] ;
 wire \audio_player_inst.sample_counter[7] ;
 wire \audio_player_inst.sample_counter[8] ;
 wire \audio_player_inst.sample_counter[9] ;
 wire \audio_player_inst.sample_tick ;
 wire net122;
 wire net123;
 wire net124;
 wire net125;
 wire net126;
 wire net127;
 wire net128;
 wire net129;
 wire net130;
 wire net131;
 wire net132;
 wire net133;
 wire net134;
 wire net135;
 wire net136;
 wire net137;
 wire net138;
 wire net139;
 wire net140;
 wire net141;
 wire net142;
 wire net143;
 wire clknet_0_clk;
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
 wire net63;
 wire net64;
 wire net65;
 wire net66;
 wire net67;
 wire net68;
 wire net69;
 wire net70;
 wire net71;
 wire net72;
 wire net73;
 wire net74;
 wire net75;
 wire net76;
 wire net77;
 wire net78;
 wire net79;
 wire net80;
 wire net81;
 wire net82;
 wire net83;
 wire net84;
 wire net85;
 wire net86;
 wire net87;
 wire net88;
 wire net89;
 wire net90;
 wire net91;
 wire net92;
 wire net93;
 wire net94;
 wire net95;
 wire net96;
 wire net97;
 wire net98;
 wire net99;
 wire net100;
 wire net101;
 wire net102;
 wire net103;
 wire net104;
 wire net105;
 wire net106;
 wire net107;
 wire net108;
 wire net109;
 wire net110;
 wire net111;
 wire net112;
 wire net113;
 wire net114;
 wire net115;
 wire net116;
 wire net117;
 wire net118;
 wire net119;
 wire net120;
 wire net121;
 wire clknet_2_0__leaf_clk;
 wire clknet_2_1__leaf_clk;
 wire clknet_2_2__leaf_clk;
 wire clknet_2_3__leaf_clk;

 sky130_fd_sc_hd__inv_2 _0787_ (.A(net1),
    .Y(_0624_));
 sky130_fd_sc_hd__inv_2 _0788_ (.A(\audio_player_inst.current_addr[13] ),
    .Y(_0635_));
 sky130_fd_sc_hd__inv_2 _0789_ (.A(\audio_player_inst.current_addr[12] ),
    .Y(_0646_));
 sky130_fd_sc_hd__inv_2 _0790_ (.A(net37),
    .Y(_0657_));
 sky130_fd_sc_hd__inv_2 _0791_ (.A(net40),
    .Y(_0668_));
 sky130_fd_sc_hd__inv_2 _0792_ (.A(net36),
    .Y(_0679_));
 sky130_fd_sc_hd__inv_2 _0793_ (.A(\audio_player_inst.current_addr[11] ),
    .Y(_0690_));
 sky130_fd_sc_hd__inv_2 _0794_ (.A(net97),
    .Y(_0701_));
 sky130_fd_sc_hd__inv_2 _0795_ (.A(net87),
    .Y(_0712_));
 sky130_fd_sc_hd__inv_2 _0796_ (.A(net108),
    .Y(_0722_));
 sky130_fd_sc_hd__inv_2 _0797_ (.A(net74),
    .Y(_0729_));
 sky130_fd_sc_hd__inv_2 _0798_ (.A(net67),
    .Y(_0737_));
 sky130_fd_sc_hd__inv_2 _0799_ (.A(net50),
    .Y(_0742_));
 sky130_fd_sc_hd__inv_2 _0800_ (.A(net48),
    .Y(_0751_));
 sky130_fd_sc_hd__inv_2 _0801_ (.A(\audio_player_inst.pwm_counter[3] ),
    .Y(_0758_));
 sky130_fd_sc_hd__nor2_1 _0802_ (.A(net116),
    .B(\audio_player_inst.pwm_counter[0] ),
    .Y(_0001_));
 sky130_fd_sc_hd__a21oi_1 _0803_ (.A1(\audio_player_inst.pwm_counter[0] ),
    .A2(\audio_player_inst.pwm_counter[1] ),
    .B1(net116),
    .Y(_0772_));
 sky130_fd_sc_hd__o21a_1 _0804_ (.A1(\audio_player_inst.pwm_counter[0] ),
    .A2(\audio_player_inst.pwm_counter[1] ),
    .B1(_0772_),
    .X(_0002_));
 sky130_fd_sc_hd__a21o_1 _0805_ (.A1(\audio_player_inst.pwm_counter[0] ),
    .A2(\audio_player_inst.pwm_counter[1] ),
    .B1(\audio_player_inst.pwm_counter[2] ),
    .X(_0776_));
 sky130_fd_sc_hd__nand3_1 _0806_ (.A(\audio_player_inst.pwm_counter[0] ),
    .B(\audio_player_inst.pwm_counter[1] ),
    .C(\audio_player_inst.pwm_counter[2] ),
    .Y(_0777_));
 sky130_fd_sc_hd__and3_1 _0807_ (.A(net1),
    .B(_0776_),
    .C(_0777_),
    .X(_0003_));
 sky130_fd_sc_hd__and3_1 _0808_ (.A(\audio_player_inst.pwm_counter[1] ),
    .B(\audio_player_inst.pwm_counter[2] ),
    .C(\audio_player_inst.pwm_counter[3] ),
    .X(_0778_));
 sky130_fd_sc_hd__a21o_1 _0809_ (.A1(_0758_),
    .A2(_0777_),
    .B1(net116),
    .X(_0779_));
 sky130_fd_sc_hd__a21oi_1 _0810_ (.A1(\audio_player_inst.pwm_counter[0] ),
    .A2(_0778_),
    .B1(_0779_),
    .Y(_0004_));
 sky130_fd_sc_hd__and2_1 _0811_ (.A(net86),
    .B(net74),
    .X(_0780_));
 sky130_fd_sc_hd__nand2_2 _0812_ (.A(net83),
    .B(net70),
    .Y(_0781_));
 sky130_fd_sc_hd__and2_2 _0813_ (.A(net92),
    .B(net101),
    .X(_0782_));
 sky130_fd_sc_hd__nand2_2 _0814_ (.A(net92),
    .B(net81),
    .Y(_0783_));
 sky130_fd_sc_hd__and3_1 _0815_ (.A(net100),
    .B(net85),
    .C(net108),
    .X(_0784_));
 sky130_fd_sc_hd__nand3_1 _0816_ (.A(net94),
    .B(net83),
    .C(net103),
    .Y(_0785_));
 sky130_fd_sc_hd__nor2_1 _0817_ (.A(net31),
    .B(_0785_),
    .Y(_0786_));
 sky130_fd_sc_hd__a21oi_1 _0818_ (.A1(net22),
    .A2(_0782_),
    .B1(net59),
    .Y(_0034_));
 sky130_fd_sc_hd__a21o_1 _0819_ (.A1(net22),
    .A2(_0782_),
    .B1(net64),
    .X(_0035_));
 sky130_fd_sc_hd__nand2_1 _0820_ (.A(net86),
    .B(net67),
    .Y(_0036_));
 sky130_fd_sc_hd__nand3_2 _0821_ (.A(net87),
    .B(net75),
    .C(net67),
    .Y(_0037_));
 sky130_fd_sc_hd__and2b_1 _0822_ (.A_N(net65),
    .B(net55),
    .X(_0038_));
 sky130_fd_sc_hd__nand2b_2 _0823_ (.A_N(net58),
    .B(net50),
    .Y(_0039_));
 sky130_fd_sc_hd__a21oi_4 _0824_ (.A1(net92),
    .A2(net102),
    .B1(net80),
    .Y(_0040_));
 sky130_fd_sc_hd__a21o_2 _0825_ (.A1(net93),
    .A2(net102),
    .B1(net82),
    .X(_0041_));
 sky130_fd_sc_hd__or2_1 _0826_ (.A(net84),
    .B(net76),
    .X(_0042_));
 sky130_fd_sc_hd__a211o_2 _0827_ (.A1(net100),
    .A2(net108),
    .B1(net78),
    .C1(net85),
    .X(_0043_));
 sky130_fd_sc_hd__and2_1 _0828_ (.A(net65),
    .B(net55),
    .X(_0044_));
 sky130_fd_sc_hd__nand2_1 _0829_ (.A(net58),
    .B(net50),
    .Y(_0045_));
 sky130_fd_sc_hd__nor2_1 _0830_ (.A(_0712_),
    .B(net70),
    .Y(_0046_));
 sky130_fd_sc_hd__nand2b_1 _0831_ (.A_N(net77),
    .B(net89),
    .Y(_0047_));
 sky130_fd_sc_hd__a221o_1 _0832_ (.A1(_0038_),
    .A2(_0043_),
    .B1(net20),
    .B2(_0047_),
    .C1(net24),
    .X(_0048_));
 sky130_fd_sc_hd__a31oi_1 _0833_ (.A1(net27),
    .A2(_0035_),
    .A3(_0037_),
    .B1(_0048_),
    .Y(_0049_));
 sky130_fd_sc_hd__and2_2 _0834_ (.A(net69),
    .B(net61),
    .X(_0050_));
 sky130_fd_sc_hd__nand2_1 _0835_ (.A(net74),
    .B(net67),
    .Y(_0051_));
 sky130_fd_sc_hd__or2_2 _0836_ (.A(net96),
    .B(net104),
    .X(_0052_));
 sky130_fd_sc_hd__o21a_1 _0837_ (.A1(net97),
    .A2(net105),
    .B1(net84),
    .X(_0053_));
 sky130_fd_sc_hd__o21ai_4 _0838_ (.A1(net98),
    .A2(net106),
    .B1(net89),
    .Y(_0054_));
 sky130_fd_sc_hd__o211a_2 _0839_ (.A1(net93),
    .A2(net102),
    .B1(net73),
    .C1(net82),
    .X(_0055_));
 sky130_fd_sc_hd__o2111a_1 _0840_ (.A1(net98),
    .A2(net107),
    .B1(net77),
    .C1(net66),
    .D1(net90),
    .X(_0056_));
 sky130_fd_sc_hd__nor2_4 _0841_ (.A(net27),
    .B(net47),
    .Y(_0057_));
 sky130_fd_sc_hd__nand2_2 _0842_ (.A(net56),
    .B(net24),
    .Y(_0058_));
 sky130_fd_sc_hd__nor2_2 _0843_ (.A(\audio_player_inst.current_addr[9] ),
    .B(net41),
    .Y(_0059_));
 sky130_fd_sc_hd__a2111o_1 _0844_ (.A1(_0056_),
    .A2(_0057_),
    .B1(net38),
    .C1(net42),
    .D1(_0049_),
    .X(_0060_));
 sky130_fd_sc_hd__and2_2 _0845_ (.A(net93),
    .B(net109),
    .X(_0061_));
 sky130_fd_sc_hd__nand2_4 _0846_ (.A(net93),
    .B(net109),
    .Y(_0062_));
 sky130_fd_sc_hd__nand3_1 _0847_ (.A(net98),
    .B(net113),
    .C(net106),
    .Y(_0063_));
 sky130_fd_sc_hd__and2_1 _0848_ (.A(net112),
    .B(net104),
    .X(_0064_));
 sky130_fd_sc_hd__nand2_2 _0849_ (.A(net111),
    .B(net105),
    .Y(_0065_));
 sky130_fd_sc_hd__nor2_1 _0850_ (.A(_0701_),
    .B(_0781_),
    .Y(_0066_));
 sky130_fd_sc_hd__and4_4 _0851_ (.A(net98),
    .B(net89),
    .C(net113),
    .D(net107),
    .X(_0067_));
 sky130_fd_sc_hd__nand4_4 _0852_ (.A(net99),
    .B(net90),
    .C(net113),
    .D(net106),
    .Y(_0068_));
 sky130_fd_sc_hd__nor2_1 _0853_ (.A(net32),
    .B(_0068_),
    .Y(_0069_));
 sky130_fd_sc_hd__or2_1 _0854_ (.A(net86),
    .B(net111),
    .X(_0070_));
 sky130_fd_sc_hd__a31o_2 _0855_ (.A1(net98),
    .A2(net113),
    .A3(net106),
    .B1(net89),
    .X(_0071_));
 sky130_fd_sc_hd__a31oi_4 _0856_ (.A1(net92),
    .A2(net109),
    .A3(net101),
    .B1(net80),
    .Y(_0072_));
 sky130_fd_sc_hd__a311oi_4 _0857_ (.A1(net95),
    .A2(net112),
    .A3(net105),
    .B1(net75),
    .C1(net87),
    .Y(_0073_));
 sky130_fd_sc_hd__or2_2 _0858_ (.A(net30),
    .B(_0073_),
    .X(_0074_));
 sky130_fd_sc_hd__a211o_1 _0859_ (.A1(net77),
    .A2(_0067_),
    .B1(_0073_),
    .C1(net30),
    .X(_0075_));
 sky130_fd_sc_hd__nor2_4 _0860_ (.A(net95),
    .B(net87),
    .Y(_0076_));
 sky130_fd_sc_hd__or2_2 _0861_ (.A(net97),
    .B(net88),
    .X(_0077_));
 sky130_fd_sc_hd__nor2_1 _0862_ (.A(net31),
    .B(_0076_),
    .Y(_0078_));
 sky130_fd_sc_hd__o21ai_4 _0863_ (.A1(net98),
    .A2(net89),
    .B1(net77),
    .Y(_0079_));
 sky130_fd_sc_hd__nand2_1 _0864_ (.A(net30),
    .B(_0079_),
    .Y(_0080_));
 sky130_fd_sc_hd__nor2_2 _0865_ (.A(net78),
    .B(_0784_),
    .Y(_0081_));
 sky130_fd_sc_hd__a31o_4 _0866_ (.A1(net92),
    .A2(net80),
    .A3(net101),
    .B1(net69),
    .X(_0082_));
 sky130_fd_sc_hd__a21oi_1 _0867_ (.A1(net66),
    .A2(_0082_),
    .B1(net55),
    .Y(_0083_));
 sky130_fd_sc_hd__a311o_1 _0868_ (.A1(net55),
    .A2(_0075_),
    .A3(_0080_),
    .B1(_0083_),
    .C1(net47),
    .X(_0084_));
 sky130_fd_sc_hd__nor2_2 _0869_ (.A(net27),
    .B(net24),
    .Y(_0085_));
 sky130_fd_sc_hd__nand2_1 _0870_ (.A(net56),
    .B(net47),
    .Y(_0086_));
 sky130_fd_sc_hd__nor2_2 _0871_ (.A(net112),
    .B(net104),
    .Y(_0087_));
 sky130_fd_sc_hd__or2_2 _0872_ (.A(net113),
    .B(net106),
    .X(_0088_));
 sky130_fd_sc_hd__nor3_2 _0873_ (.A(net92),
    .B(net80),
    .C(net69),
    .Y(_0089_));
 sky130_fd_sc_hd__or2_2 _0874_ (.A(net100),
    .B(net114),
    .X(_0090_));
 sky130_fd_sc_hd__nor3_4 _0875_ (.A(net95),
    .B(net111),
    .C(net104),
    .Y(_0091_));
 sky130_fd_sc_hd__and2_1 _0876_ (.A(_0087_),
    .B(_0089_),
    .X(_0092_));
 sky130_fd_sc_hd__nand2_1 _0877_ (.A(_0087_),
    .B(net13),
    .Y(_0093_));
 sky130_fd_sc_hd__nor2_1 _0878_ (.A(net39),
    .B(_0668_),
    .Y(_0094_));
 sky130_fd_sc_hd__nand2_2 _0879_ (.A(net35),
    .B(net43),
    .Y(_0095_));
 sky130_fd_sc_hd__a31o_2 _0880_ (.A1(net98),
    .A2(net89),
    .A3(net77),
    .B1(net66),
    .X(_0096_));
 sky130_fd_sc_hd__and2b_2 _0881_ (.A_N(net53),
    .B(net45),
    .X(_0097_));
 sky130_fd_sc_hd__nand2b_1 _0882_ (.A_N(net53),
    .B(net46),
    .Y(_0098_));
 sky130_fd_sc_hd__nand2_2 _0883_ (.A(net15),
    .B(_0097_),
    .Y(_0099_));
 sky130_fd_sc_hd__o31ai_2 _0884_ (.A1(net96),
    .A2(net87),
    .A3(net76),
    .B1(net67),
    .Y(_0100_));
 sky130_fd_sc_hd__and3_1 _0885_ (.A(_0096_),
    .B(_0097_),
    .C(_0100_),
    .X(_0101_));
 sky130_fd_sc_hd__a31o_1 _0886_ (.A1(net45),
    .A2(net20),
    .A3(_0093_),
    .B1(_0101_),
    .X(_0102_));
 sky130_fd_sc_hd__or3b_1 _0887_ (.A(_0095_),
    .B(_0102_),
    .C_N(_0084_),
    .X(_0103_));
 sky130_fd_sc_hd__nor2_1 _0888_ (.A(net31),
    .B(_0072_),
    .Y(_0104_));
 sky130_fd_sc_hd__nand2_1 _0889_ (.A(net79),
    .B(_0071_),
    .Y(_0105_));
 sky130_fd_sc_hd__a32o_1 _0890_ (.A1(net62),
    .A2(_0783_),
    .A3(_0077_),
    .B1(_0093_),
    .B2(_0105_),
    .X(_0106_));
 sky130_fd_sc_hd__a21o_1 _0891_ (.A1(net73),
    .A2(_0071_),
    .B1(net28),
    .X(_0107_));
 sky130_fd_sc_hd__nor2_4 _0892_ (.A(net56),
    .B(net47),
    .Y(_0108_));
 sky130_fd_sc_hd__or2_1 _0893_ (.A(net49),
    .B(net44),
    .X(_0109_));
 sky130_fd_sc_hd__nor2_2 _0894_ (.A(net40),
    .B(net44),
    .Y(_0110_));
 sky130_fd_sc_hd__or2_4 _0895_ (.A(net40),
    .B(net44),
    .X(_0111_));
 sky130_fd_sc_hd__nor2_2 _0896_ (.A(net55),
    .B(_0111_),
    .Y(_0112_));
 sky130_fd_sc_hd__o211a_1 _0897_ (.A1(_0092_),
    .A2(_0107_),
    .B1(_0112_),
    .C1(_0106_),
    .X(_0113_));
 sky130_fd_sc_hd__a21o_1 _0898_ (.A1(_0060_),
    .A2(_0103_),
    .B1(_0113_),
    .X(_0114_));
 sky130_fd_sc_hd__nor4_2 _0899_ (.A(net99),
    .B(net90),
    .C(net113),
    .D(net106),
    .Y(_0115_));
 sky130_fd_sc_hd__or4_4 _0900_ (.A(net99),
    .B(net90),
    .C(net113),
    .D(net106),
    .X(_0116_));
 sky130_fd_sc_hd__a21o_1 _0901_ (.A1(net77),
    .A2(_0116_),
    .B1(net66),
    .X(_0117_));
 sky130_fd_sc_hd__nand2_1 _0902_ (.A(net52),
    .B(_0117_),
    .Y(_0118_));
 sky130_fd_sc_hd__and3_1 _0903_ (.A(_0074_),
    .B(_0085_),
    .C(_0117_),
    .X(_0119_));
 sky130_fd_sc_hd__a21o_2 _0904_ (.A1(net109),
    .A2(net101),
    .B1(net92),
    .X(_0120_));
 sky130_fd_sc_hd__a21oi_4 _0905_ (.A1(net111),
    .A2(net105),
    .B1(net97),
    .Y(_0121_));
 sky130_fd_sc_hd__a211oi_1 _0906_ (.A1(net109),
    .A2(net101),
    .B1(net92),
    .C1(net80),
    .Y(_0122_));
 sky130_fd_sc_hd__a211o_1 _0907_ (.A1(net110),
    .A2(net102),
    .B1(net93),
    .C1(net82),
    .X(_0123_));
 sky130_fd_sc_hd__nor2_1 _0908_ (.A(net31),
    .B(net10),
    .Y(_0124_));
 sky130_fd_sc_hd__nand2_1 _0909_ (.A(net73),
    .B(_0123_),
    .Y(_0125_));
 sky130_fd_sc_hd__o211a_2 _0910_ (.A1(net114),
    .A2(net108),
    .B1(net100),
    .C1(net84),
    .X(_0126_));
 sky130_fd_sc_hd__o211ai_4 _0911_ (.A1(net113),
    .A2(net106),
    .B1(net98),
    .C1(net90),
    .Y(_0127_));
 sky130_fd_sc_hd__o2111a_1 _0912_ (.A1(net111),
    .A2(net105),
    .B1(net74),
    .C1(net86),
    .D1(net97),
    .X(_0128_));
 sky130_fd_sc_hd__o2111ai_4 _0913_ (.A1(net109),
    .A2(net102),
    .B1(net69),
    .C1(net82),
    .D1(net93),
    .Y(_0129_));
 sky130_fd_sc_hd__nor2_1 _0914_ (.A(net28),
    .B(_0129_),
    .Y(_0130_));
 sky130_fd_sc_hd__nand2_1 _0915_ (.A(net64),
    .B(_0128_),
    .Y(_0131_));
 sky130_fd_sc_hd__nand2b_2 _0916_ (.A_N(net68),
    .B(net78),
    .Y(_0132_));
 sky130_fd_sc_hd__o211a_1 _0917_ (.A1(net64),
    .A2(_0124_),
    .B1(_0131_),
    .C1(_0097_),
    .X(_0133_));
 sky130_fd_sc_hd__nand2_1 _0918_ (.A(net68),
    .B(_0065_),
    .Y(_0134_));
 sky130_fd_sc_hd__a31o_1 _0919_ (.A1(_0073_),
    .A2(_0108_),
    .A3(_0134_),
    .B1(net42),
    .X(_0135_));
 sky130_fd_sc_hd__nor3_1 _0920_ (.A(_0119_),
    .B(_0133_),
    .C(_0135_),
    .Y(_0136_));
 sky130_fd_sc_hd__nor2_1 _0921_ (.A(net55),
    .B(_0056_),
    .Y(_0137_));
 sky130_fd_sc_hd__nor2_2 _0922_ (.A(_0781_),
    .B(_0121_),
    .Y(_0138_));
 sky130_fd_sc_hd__nand2_2 _0923_ (.A(net22),
    .B(_0120_),
    .Y(_0139_));
 sky130_fd_sc_hd__a221o_1 _0924_ (.A1(_0712_),
    .A2(net31),
    .B1(_0055_),
    .B2(_0090_),
    .C1(net62),
    .X(_0140_));
 sky130_fd_sc_hd__nor2_2 _0925_ (.A(net69),
    .B(net58),
    .Y(_0141_));
 sky130_fd_sc_hd__or2_4 _0926_ (.A(net72),
    .B(net60),
    .X(_0142_));
 sky130_fd_sc_hd__nor2_1 _0927_ (.A(net84),
    .B(net64),
    .Y(_0143_));
 sky130_fd_sc_hd__or3_2 _0928_ (.A(net84),
    .B(net76),
    .C(net64),
    .X(_0144_));
 sky130_fd_sc_hd__or3_4 _0929_ (.A(net95),
    .B(net87),
    .C(net104),
    .X(_0145_));
 sky130_fd_sc_hd__nor4_1 _0930_ (.A(net93),
    .B(net80),
    .C(net101),
    .D(net70),
    .Y(_0146_));
 sky130_fd_sc_hd__or4_4 _0931_ (.A(net95),
    .B(net87),
    .C(net104),
    .D(net75),
    .X(_0147_));
 sky130_fd_sc_hd__nor2_1 _0932_ (.A(net68),
    .B(_0147_),
    .Y(_0148_));
 sky130_fd_sc_hd__nand2_2 _0933_ (.A(_0784_),
    .B(_0050_),
    .Y(_0149_));
 sky130_fd_sc_hd__o22a_1 _0934_ (.A1(_0785_),
    .A2(net15),
    .B1(_0116_),
    .B2(_0142_),
    .X(_0150_));
 sky130_fd_sc_hd__a221o_1 _0935_ (.A1(_0137_),
    .A2(_0140_),
    .B1(_0150_),
    .B2(net52),
    .C1(net23),
    .X(_0151_));
 sky130_fd_sc_hd__a21oi_4 _0936_ (.A1(net80),
    .A2(_0120_),
    .B1(net70),
    .Y(_0152_));
 sky130_fd_sc_hd__a21o_1 _0937_ (.A1(net82),
    .A2(_0120_),
    .B1(net72),
    .X(_0153_));
 sky130_fd_sc_hd__a21oi_2 _0938_ (.A1(net81),
    .A2(_0120_),
    .B1(_0142_),
    .Y(_0154_));
 sky130_fd_sc_hd__nor2_1 _0939_ (.A(net15),
    .B(net11),
    .Y(_0155_));
 sky130_fd_sc_hd__nand2_2 _0940_ (.A(net16),
    .B(_0116_),
    .Y(_0156_));
 sky130_fd_sc_hd__o311a_1 _0941_ (.A1(_0058_),
    .A2(_0154_),
    .A3(_0155_),
    .B1(_0151_),
    .C1(net41),
    .X(_0157_));
 sky130_fd_sc_hd__o21ai_1 _0942_ (.A1(_0136_),
    .A2(_0157_),
    .B1(net38),
    .Y(_0158_));
 sky130_fd_sc_hd__a31o_1 _0943_ (.A1(net36),
    .A2(_0114_),
    .A3(_0158_),
    .B1(_0690_),
    .X(_0159_));
 sky130_fd_sc_hd__nand2_1 _0944_ (.A(net73),
    .B(net51),
    .Y(_0160_));
 sky130_fd_sc_hd__a41o_4 _0945_ (.A1(net92),
    .A2(net80),
    .A3(net109),
    .A4(net101),
    .B1(net69),
    .X(_0161_));
 sky130_fd_sc_hd__inv_2 _0946_ (.A(_0161_),
    .Y(_0162_));
 sky130_fd_sc_hd__nor2_1 _0947_ (.A(_0067_),
    .B(_0142_),
    .Y(_0163_));
 sky130_fd_sc_hd__mux4_1 _0948_ (.A0(net70),
    .A1(net9),
    .A2(_0161_),
    .A3(_0781_),
    .S0(net64),
    .S1(net26),
    .X(_0164_));
 sky130_fd_sc_hd__and2b_1 _0949_ (.A_N(net85),
    .B(net100),
    .X(_0165_));
 sky130_fd_sc_hd__nand2b_1 _0950_ (.A_N(net84),
    .B(net100),
    .Y(_0166_));
 sky130_fd_sc_hd__nor2_4 _0951_ (.A(net58),
    .B(net50),
    .Y(_0167_));
 sky130_fd_sc_hd__or2_2 _0952_ (.A(net59),
    .B(net51),
    .X(_0168_));
 sky130_fd_sc_hd__or3_2 _0953_ (.A(net74),
    .B(net67),
    .C(net53),
    .X(_0169_));
 sky130_fd_sc_hd__nor2_1 _0954_ (.A(net12),
    .B(_0142_),
    .Y(_0170_));
 sky130_fd_sc_hd__or4b_4 _0955_ (.A(net77),
    .B(net66),
    .C(net56),
    .D_N(net47),
    .X(_0171_));
 sky130_fd_sc_hd__a22o_1 _0956_ (.A1(net23),
    .A2(_0164_),
    .B1(_0165_),
    .B2(_0170_),
    .X(_0172_));
 sky130_fd_sc_hd__nand2_1 _0957_ (.A(net32),
    .B(_0127_),
    .Y(_0173_));
 sky130_fd_sc_hd__a21o_1 _0958_ (.A1(net32),
    .A2(_0127_),
    .B1(net29),
    .X(_0174_));
 sky130_fd_sc_hd__o211a_1 _0959_ (.A1(_0041_),
    .A2(_0142_),
    .B1(_0174_),
    .C1(_0085_),
    .X(_0175_));
 sky130_fd_sc_hd__o21a_1 _0960_ (.A1(_0172_),
    .A2(_0175_),
    .B1(net42),
    .X(_0176_));
 sky130_fd_sc_hd__a21o_1 _0961_ (.A1(_0034_),
    .A2(_0043_),
    .B1(_0099_),
    .X(_0177_));
 sky130_fd_sc_hd__or3_1 _0962_ (.A(net59),
    .B(_0041_),
    .C(net14),
    .X(_0178_));
 sky130_fd_sc_hd__or3_1 _0963_ (.A(net31),
    .B(_0091_),
    .C(_0178_),
    .X(_0179_));
 sky130_fd_sc_hd__a21oi_1 _0964_ (.A1(_0177_),
    .A2(_0179_),
    .B1(net40),
    .Y(_0180_));
 sky130_fd_sc_hd__and3_1 _0965_ (.A(net55),
    .B(_0096_),
    .C(_0110_),
    .X(_0181_));
 sky130_fd_sc_hd__a31o_1 _0966_ (.A1(_0035_),
    .A2(_0074_),
    .A3(_0110_),
    .B1(_0181_),
    .X(_0182_));
 sky130_fd_sc_hd__o31a_1 _0967_ (.A1(_0176_),
    .A2(_0180_),
    .A3(_0182_),
    .B1(net38),
    .X(_0183_));
 sky130_fd_sc_hd__nor2_1 _0968_ (.A(net75),
    .B(net21),
    .Y(_0184_));
 sky130_fd_sc_hd__or3b_4 _0969_ (.A(net69),
    .B(net58),
    .C_N(net50),
    .X(_0185_));
 sky130_fd_sc_hd__o311ai_4 _0970_ (.A1(net95),
    .A2(net112),
    .A3(net104),
    .B1(net74),
    .C1(net87),
    .Y(_0186_));
 sky130_fd_sc_hd__o21a_1 _0971_ (.A1(_0066_),
    .A2(_0100_),
    .B1(net26),
    .X(_0187_));
 sky130_fd_sc_hd__a311o_1 _0972_ (.A1(net19),
    .A2(_0173_),
    .A3(net8),
    .B1(_0187_),
    .C1(_0184_),
    .X(_0188_));
 sky130_fd_sc_hd__o32a_1 _0973_ (.A1(_0786_),
    .A2(net17),
    .A3(_0152_),
    .B1(_0078_),
    .B2(net21),
    .X(_0189_));
 sky130_fd_sc_hd__nor2_2 _0974_ (.A(net28),
    .B(net49),
    .Y(_0190_));
 sky130_fd_sc_hd__nand2b_4 _0975_ (.A_N(net50),
    .B(net58),
    .Y(_0191_));
 sky130_fd_sc_hd__o211ai_1 _0976_ (.A1(_0081_),
    .A2(_0191_),
    .B1(_0189_),
    .C1(net46),
    .Y(_0192_));
 sky130_fd_sc_hd__o211a_1 _0977_ (.A1(net46),
    .A2(_0188_),
    .B1(_0192_),
    .C1(_0094_),
    .X(_0193_));
 sky130_fd_sc_hd__a41o_1 _0978_ (.A1(net78),
    .A2(_0116_),
    .A3(_0127_),
    .A4(_0167_),
    .B1(net47),
    .X(_0194_));
 sky130_fd_sc_hd__nand2_1 _0979_ (.A(net16),
    .B(_0071_),
    .Y(_0195_));
 sky130_fd_sc_hd__nor2_1 _0980_ (.A(net58),
    .B(_0082_),
    .Y(_0196_));
 sky130_fd_sc_hd__a311o_1 _0981_ (.A1(net100),
    .A2(net85),
    .A3(net108),
    .B1(net78),
    .C1(net68),
    .X(_0197_));
 sky130_fd_sc_hd__nand2_2 _0982_ (.A(net55),
    .B(_0197_),
    .Y(_0198_));
 sky130_fd_sc_hd__a31o_1 _0983_ (.A1(net55),
    .A2(_0195_),
    .A3(_0197_),
    .B1(_0194_),
    .X(_0199_));
 sky130_fd_sc_hd__and2b_1 _0984_ (.A_N(net78),
    .B(net65),
    .X(_0200_));
 sky130_fd_sc_hd__nand2b_4 _0985_ (.A_N(net74),
    .B(net67),
    .Y(_0201_));
 sky130_fd_sc_hd__nor2_1 _0986_ (.A(_0116_),
    .B(_0201_),
    .Y(_0202_));
 sky130_fd_sc_hd__a21oi_2 _0987_ (.A1(net93),
    .A2(net82),
    .B1(net72),
    .Y(_0203_));
 sky130_fd_sc_hd__a21o_1 _0988_ (.A1(net95),
    .A2(net87),
    .B1(net75),
    .X(_0204_));
 sky130_fd_sc_hd__nor2_1 _0989_ (.A(net59),
    .B(_0203_),
    .Y(_0205_));
 sky130_fd_sc_hd__o32a_1 _0990_ (.A1(net12),
    .A2(_0202_),
    .A3(_0205_),
    .B1(_0154_),
    .B2(net14),
    .X(_0206_));
 sky130_fd_sc_hd__and3_1 _0991_ (.A(net78),
    .B(net65),
    .C(_0067_),
    .X(_0207_));
 sky130_fd_sc_hd__o211a_1 _0992_ (.A1(_0206_),
    .A2(_0207_),
    .B1(_0059_),
    .C1(_0199_),
    .X(_0208_));
 sky130_fd_sc_hd__o31a_1 _0993_ (.A1(_0183_),
    .A2(_0193_),
    .A3(_0208_),
    .B1(_0679_),
    .X(_0209_));
 sky130_fd_sc_hd__nand2_2 _0994_ (.A(_0668_),
    .B(net44),
    .Y(_0210_));
 sky130_fd_sc_hd__nor2_1 _0995_ (.A(net54),
    .B(_0143_),
    .Y(_0211_));
 sky130_fd_sc_hd__nand2_1 _0996_ (.A(net25),
    .B(_0144_),
    .Y(_0212_));
 sky130_fd_sc_hd__a31o_1 _0997_ (.A1(net62),
    .A2(_0093_),
    .A3(_0129_),
    .B1(_0212_),
    .X(_0213_));
 sky130_fd_sc_hd__o31a_1 _0998_ (.A1(net94),
    .A2(net110),
    .A3(net103),
    .B1(net83),
    .X(_0214_));
 sky130_fd_sc_hd__o31ai_2 _0999_ (.A1(net97),
    .A2(net111),
    .A3(net105),
    .B1(net86),
    .Y(_0215_));
 sky130_fd_sc_hd__nor2_1 _1000_ (.A(net73),
    .B(_0214_),
    .Y(_0216_));
 sky130_fd_sc_hd__nand2_2 _1001_ (.A(net32),
    .B(_0215_),
    .Y(_0217_));
 sky130_fd_sc_hd__o211ai_1 _1002_ (.A1(net62),
    .A2(_0216_),
    .B1(_0107_),
    .C1(net52),
    .Y(_0218_));
 sky130_fd_sc_hd__a21oi_1 _1003_ (.A1(_0213_),
    .A2(_0218_),
    .B1(_0210_),
    .Y(_0219_));
 sky130_fd_sc_hd__a21oi_2 _1004_ (.A1(net72),
    .A2(_0041_),
    .B1(net59),
    .Y(_0220_));
 sky130_fd_sc_hd__a21o_1 _1005_ (.A1(net72),
    .A2(_0041_),
    .B1(net60),
    .X(_0221_));
 sky130_fd_sc_hd__a211oi_1 _1006_ (.A1(net59),
    .A2(_0043_),
    .B1(_0220_),
    .C1(net51),
    .Y(_0222_));
 sky130_fd_sc_hd__o211a_1 _1007_ (.A1(net15),
    .A2(_0076_),
    .B1(_0117_),
    .C1(net52),
    .X(_0223_));
 sky130_fd_sc_hd__o21a_1 _1008_ (.A1(_0222_),
    .A2(_0223_),
    .B1(_0110_),
    .X(_0224_));
 sky130_fd_sc_hd__nor2_2 _1009_ (.A(_0668_),
    .B(net23),
    .Y(_0225_));
 sky130_fd_sc_hd__nand2_4 _1010_ (.A(net41),
    .B(net48),
    .Y(_0226_));
 sky130_fd_sc_hd__o311a_1 _1011_ (.A1(net61),
    .A2(_0104_),
    .A3(net9),
    .B1(_0156_),
    .C1(net57),
    .X(_0227_));
 sky130_fd_sc_hd__a21oi_2 _1012_ (.A1(net71),
    .A2(_0067_),
    .B1(net61),
    .Y(_0228_));
 sky130_fd_sc_hd__nor2_1 _1013_ (.A(net49),
    .B(_0228_),
    .Y(_0229_));
 sky130_fd_sc_hd__o21a_1 _1014_ (.A1(_0227_),
    .A2(_0229_),
    .B1(net6),
    .X(_0230_));
 sky130_fd_sc_hd__nor2_2 _1015_ (.A(_0668_),
    .B(net44),
    .Y(_0231_));
 sky130_fd_sc_hd__nand2_1 _1016_ (.A(net40),
    .B(net23),
    .Y(_0232_));
 sky130_fd_sc_hd__nor2_1 _1017_ (.A(net17),
    .B(_0161_),
    .Y(_0233_));
 sky130_fd_sc_hd__nand2_1 _1018_ (.A(_0040_),
    .B(_0185_),
    .Y(_0234_));
 sky130_fd_sc_hd__o211a_1 _1019_ (.A1(_0040_),
    .A2(_0233_),
    .B1(_0234_),
    .C1(net5),
    .X(_0235_));
 sky130_fd_sc_hd__or2_1 _1020_ (.A(_0783_),
    .B(_0132_),
    .X(_0236_));
 sky130_fd_sc_hd__nor2_1 _1021_ (.A(_0668_),
    .B(_0109_),
    .Y(_0237_));
 sky130_fd_sc_hd__a311o_1 _1022_ (.A1(_0201_),
    .A2(_0236_),
    .A3(_0237_),
    .B1(_0235_),
    .C1(net37),
    .X(_0238_));
 sky130_fd_sc_hd__or4_1 _1023_ (.A(_0219_),
    .B(_0224_),
    .C(_0230_),
    .D(_0238_),
    .X(_0239_));
 sky130_fd_sc_hd__o31ai_4 _1024_ (.A1(net94),
    .A2(net83),
    .A3(net103),
    .B1(net71),
    .Y(_0240_));
 sky130_fd_sc_hd__nand2_2 _1025_ (.A(net49),
    .B(_0240_),
    .Y(_0241_));
 sky130_fd_sc_hd__a2111oi_1 _1026_ (.A1(net109),
    .A2(net101),
    .B1(net69),
    .C1(net80),
    .D1(net92),
    .Y(_0242_));
 sky130_fd_sc_hd__nor2_1 _1027_ (.A(net28),
    .B(_0242_),
    .Y(_0243_));
 sky130_fd_sc_hd__or2_1 _1028_ (.A(net28),
    .B(_0242_),
    .X(_0244_));
 sky130_fd_sc_hd__nand2_2 _1029_ (.A(_0040_),
    .B(_0062_),
    .Y(_0245_));
 sky130_fd_sc_hd__o221ai_1 _1030_ (.A1(net63),
    .A2(net8),
    .B1(_0201_),
    .B2(_0067_),
    .C1(net25),
    .Y(_0246_));
 sky130_fd_sc_hd__o221a_1 _1031_ (.A1(_0241_),
    .A2(_0244_),
    .B1(_0245_),
    .B2(_0185_),
    .C1(_0246_),
    .X(_0247_));
 sky130_fd_sc_hd__o2bb2a_1 _1032_ (.A1_N(net21),
    .A2_N(_0241_),
    .B1(_0073_),
    .B2(_0035_),
    .X(_0248_));
 sky130_fd_sc_hd__a211o_1 _1033_ (.A1(_0147_),
    .A2(_0190_),
    .B1(_0226_),
    .C1(_0248_),
    .X(_0249_));
 sky130_fd_sc_hd__nand2_1 _1034_ (.A(net32),
    .B(_0054_),
    .Y(_0250_));
 sky130_fd_sc_hd__nor2_2 _1035_ (.A(net75),
    .B(_0053_),
    .Y(_0251_));
 sky130_fd_sc_hd__nor2_1 _1036_ (.A(net21),
    .B(_0251_),
    .Y(_0252_));
 sky130_fd_sc_hd__or3_1 _1037_ (.A(_0055_),
    .B(_0168_),
    .C(_0203_),
    .X(_0253_));
 sky130_fd_sc_hd__or4b_1 _1038_ (.A(_0111_),
    .B(_0233_),
    .C(_0252_),
    .D_N(_0253_),
    .X(_0254_));
 sky130_fd_sc_hd__nand2_1 _1039_ (.A(_0147_),
    .B(_0186_),
    .Y(_0255_));
 sky130_fd_sc_hd__nand2b_1 _1040_ (.A_N(net94),
    .B(net103),
    .Y(_0256_));
 sky130_fd_sc_hd__nand3b_4 _1041_ (.A_N(net95),
    .B(net111),
    .C(net104),
    .Y(_0257_));
 sky130_fd_sc_hd__a21bo_1 _1042_ (.A1(net111),
    .A2(net107),
    .B1_N(net96),
    .X(_0258_));
 sky130_fd_sc_hd__nand2_1 _1043_ (.A(_0257_),
    .B(_0258_),
    .Y(_0259_));
 sky130_fd_sc_hd__a21o_1 _1044_ (.A1(_0257_),
    .A2(_0258_),
    .B1(net29),
    .X(_0260_));
 sky130_fd_sc_hd__a31o_1 _1045_ (.A1(net67),
    .A2(_0147_),
    .A3(_0186_),
    .B1(net53),
    .X(_0261_));
 sky130_fd_sc_hd__a21oi_2 _1046_ (.A1(_0255_),
    .A2(_0260_),
    .B1(_0261_),
    .Y(_0262_));
 sky130_fd_sc_hd__nand2_1 _1047_ (.A(net54),
    .B(net16),
    .Y(_0263_));
 sky130_fd_sc_hd__inv_2 _1048_ (.A(_0263_),
    .Y(_0264_));
 sky130_fd_sc_hd__a21oi_4 _1049_ (.A1(_0040_),
    .A2(_0062_),
    .B1(net31),
    .Y(_0265_));
 sky130_fd_sc_hd__a21o_1 _1050_ (.A1(net19),
    .A2(_0265_),
    .B1(_0210_),
    .X(_0266_));
 sky130_fd_sc_hd__o2bb2a_1 _1051_ (.A1_N(net5),
    .A2_N(_0247_),
    .B1(_0262_),
    .B2(_0266_),
    .X(_0267_));
 sky130_fd_sc_hd__a31o_1 _1052_ (.A1(_0249_),
    .A2(_0254_),
    .A3(_0267_),
    .B1(net34),
    .X(_0268_));
 sky130_fd_sc_hd__o21a_1 _1053_ (.A1(_0043_),
    .A2(_0061_),
    .B1(net65),
    .X(_0269_));
 sky130_fd_sc_hd__inv_2 _1054_ (.A(_0269_),
    .Y(_0270_));
 sky130_fd_sc_hd__o211a_1 _1055_ (.A1(_0043_),
    .A2(_0061_),
    .B1(_0129_),
    .C1(net59),
    .X(_0271_));
 sky130_fd_sc_hd__nor2_2 _1056_ (.A(net28),
    .B(_0203_),
    .Y(_0272_));
 sky130_fd_sc_hd__nor2_1 _1057_ (.A(net56),
    .B(_0272_),
    .Y(_0273_));
 sky130_fd_sc_hd__o221a_1 _1058_ (.A1(_0198_),
    .A2(_0271_),
    .B1(_0272_),
    .B2(net51),
    .C1(net6),
    .X(_0274_));
 sky130_fd_sc_hd__a21oi_1 _1059_ (.A1(net72),
    .A2(_0041_),
    .B1(net21),
    .Y(_0275_));
 sky130_fd_sc_hd__a211o_1 _1060_ (.A1(net70),
    .A2(_0041_),
    .B1(net7),
    .C1(net21),
    .X(_0276_));
 sky130_fd_sc_hd__a221o_1 _1061_ (.A1(net58),
    .A2(_0082_),
    .B1(_0141_),
    .B2(_0072_),
    .C1(net50),
    .X(_0277_));
 sky130_fd_sc_hd__a21oi_1 _1062_ (.A1(_0276_),
    .A2(_0277_),
    .B1(net4),
    .Y(_0278_));
 sky130_fd_sc_hd__nand2_1 _1063_ (.A(net28),
    .B(_0129_),
    .Y(_0279_));
 sky130_fd_sc_hd__a211o_1 _1064_ (.A1(net32),
    .A2(_0054_),
    .B1(_0128_),
    .C1(net65),
    .X(_0280_));
 sky130_fd_sc_hd__nor2_1 _1065_ (.A(net42),
    .B(net12),
    .Y(_0281_));
 sky130_fd_sc_hd__or3b_2 _1066_ (.A(net40),
    .B(net52),
    .C_N(net44),
    .X(_0282_));
 sky130_fd_sc_hd__nor2_1 _1067_ (.A(net17),
    .B(_0089_),
    .Y(_0283_));
 sky130_fd_sc_hd__o21ai_1 _1068_ (.A1(net18),
    .A2(net13),
    .B1(_0169_),
    .Y(_0284_));
 sky130_fd_sc_hd__a32o_1 _1069_ (.A1(_0156_),
    .A2(_0280_),
    .A3(_0281_),
    .B1(_0284_),
    .B2(_0110_),
    .X(_0285_));
 sky130_fd_sc_hd__nor2_1 _1070_ (.A(net34),
    .B(_0285_),
    .Y(_0286_));
 sky130_fd_sc_hd__or4_1 _1071_ (.A(net34),
    .B(_0274_),
    .C(_0278_),
    .D(_0285_),
    .X(_0287_));
 sky130_fd_sc_hd__and2b_1 _1072_ (.A_N(net80),
    .B(net109),
    .X(_0288_));
 sky130_fd_sc_hd__nor2_1 _1073_ (.A(_0040_),
    .B(_0288_),
    .Y(_0289_));
 sky130_fd_sc_hd__or4_1 _1074_ (.A(net31),
    .B(_0040_),
    .C(_0091_),
    .D(_0288_),
    .X(_0290_));
 sky130_fd_sc_hd__nor2_1 _1075_ (.A(_0123_),
    .B(_0142_),
    .Y(_0291_));
 sky130_fd_sc_hd__nand2_1 _1076_ (.A(net10),
    .B(_0141_),
    .Y(_0292_));
 sky130_fd_sc_hd__a311o_1 _1077_ (.A1(net59),
    .A2(_0153_),
    .A3(_0290_),
    .B1(_0291_),
    .C1(net14),
    .X(_0293_));
 sky130_fd_sc_hd__or2_1 _1078_ (.A(_0071_),
    .B(_0185_),
    .X(_0294_));
 sky130_fd_sc_hd__o311a_1 _1079_ (.A1(net51),
    .A2(_0034_),
    .A3(_0092_),
    .B1(_0294_),
    .C1(net40),
    .X(_0295_));
 sky130_fd_sc_hd__o211ai_1 _1080_ (.A1(net6),
    .A2(_0295_),
    .B1(_0293_),
    .C1(net35),
    .Y(_0296_));
 sky130_fd_sc_hd__a21o_1 _1081_ (.A1(net72),
    .A2(_0067_),
    .B1(_0168_),
    .X(_0297_));
 sky130_fd_sc_hd__o21ai_1 _1082_ (.A1(_0043_),
    .A2(_0061_),
    .B1(net19),
    .Y(_0298_));
 sky130_fd_sc_hd__a21o_1 _1083_ (.A1(_0297_),
    .A2(_0298_),
    .B1(net48),
    .X(_0299_));
 sky130_fd_sc_hd__and2b_1 _1084_ (.A_N(net105),
    .B(net111),
    .X(_0300_));
 sky130_fd_sc_hd__nand2b_1 _1085_ (.A_N(net108),
    .B(net114),
    .Y(_0301_));
 sky130_fd_sc_hd__nand2_1 _1086_ (.A(_0701_),
    .B(_0300_),
    .Y(_0302_));
 sky130_fd_sc_hd__a31o_1 _1087_ (.A1(net81),
    .A2(net63),
    .A3(_0302_),
    .B1(_0099_),
    .X(_0303_));
 sky130_fd_sc_hd__a31oi_1 _1088_ (.A1(_0059_),
    .A2(_0299_),
    .A3(_0303_),
    .B1(net36),
    .Y(_0304_));
 sky130_fd_sc_hd__nand2_1 _1089_ (.A(_0296_),
    .B(_0304_),
    .Y(_0305_));
 sky130_fd_sc_hd__a31o_1 _1090_ (.A1(_0287_),
    .A2(_0296_),
    .A3(_0304_),
    .B1(\audio_player_inst.current_addr[11] ),
    .X(_0306_));
 sky130_fd_sc_hd__a31o_1 _1091_ (.A1(net36),
    .A2(_0239_),
    .A3(_0268_),
    .B1(_0306_),
    .X(_0307_));
 sky130_fd_sc_hd__o211a_1 _1092_ (.A1(_0159_),
    .A2(_0209_),
    .B1(_0307_),
    .C1(_0646_),
    .X(_0308_));
 sky130_fd_sc_hd__or3b_2 _1093_ (.A(net100),
    .B(net114),
    .C_N(net108),
    .X(_0309_));
 sky130_fd_sc_hd__and2_1 _1094_ (.A(net85),
    .B(_0309_),
    .X(_0310_));
 sky130_fd_sc_hd__o21ba_1 _1095_ (.A1(net112),
    .A2(net105),
    .B1_N(net86),
    .X(_0311_));
 sky130_fd_sc_hd__a2111o_1 _1096_ (.A1(_0065_),
    .A2(_0311_),
    .B1(_0076_),
    .C1(net76),
    .D1(_0191_),
    .X(_0312_));
 sky130_fd_sc_hd__o22a_1 _1097_ (.A1(_0169_),
    .A2(_0245_),
    .B1(_0310_),
    .B2(_0312_),
    .X(_0313_));
 sky130_fd_sc_hd__or2_1 _1098_ (.A(net45),
    .B(_0313_),
    .X(_0314_));
 sky130_fd_sc_hd__o31a_1 _1099_ (.A1(net29),
    .A2(_0058_),
    .A3(_0251_),
    .B1(net42),
    .X(_0315_));
 sky130_fd_sc_hd__or3b_2 _1100_ (.A(net112),
    .B(net104),
    .C_N(net96),
    .X(_0316_));
 sky130_fd_sc_hd__nand2_1 _1101_ (.A(_0257_),
    .B(_0316_),
    .Y(_0317_));
 sky130_fd_sc_hd__or3b_1 _1102_ (.A(net90),
    .B(_0051_),
    .C_N(_0317_),
    .X(_0318_));
 sky130_fd_sc_hd__a21o_1 _1103_ (.A1(_0117_),
    .A2(_0318_),
    .B1(net12),
    .X(_0319_));
 sky130_fd_sc_hd__o31a_1 _1104_ (.A1(net24),
    .A2(_0051_),
    .A3(_0076_),
    .B1(net14),
    .X(_0320_));
 sky130_fd_sc_hd__a31o_1 _1105_ (.A1(net53),
    .A2(_0096_),
    .A3(_0156_),
    .B1(_0320_),
    .X(_0321_));
 sky130_fd_sc_hd__or4_1 _1106_ (.A(net88),
    .B(net45),
    .C(_0121_),
    .D(_0185_),
    .X(_0322_));
 sky130_fd_sc_hd__a21oi_1 _1107_ (.A1(_0100_),
    .A2(_0108_),
    .B1(net43),
    .Y(_0323_));
 sky130_fd_sc_hd__o21a_1 _1108_ (.A1(_0078_),
    .A2(_0152_),
    .B1(_0279_),
    .X(_0324_));
 sky130_fd_sc_hd__o21a_1 _1109_ (.A1(net61),
    .A2(_0241_),
    .B1(_0191_),
    .X(_0325_));
 sky130_fd_sc_hd__nor2_1 _1110_ (.A(net54),
    .B(_0042_),
    .Y(_0326_));
 sky130_fd_sc_hd__nor2_1 _1111_ (.A(net61),
    .B(net22),
    .Y(_0327_));
 sky130_fd_sc_hd__or3_1 _1112_ (.A(_0058_),
    .B(_0243_),
    .C(_0327_),
    .X(_0328_));
 sky130_fd_sc_hd__o32a_1 _1113_ (.A1(net23),
    .A2(_0325_),
    .A3(_0326_),
    .B1(_0109_),
    .B2(_0324_),
    .X(_0329_));
 sky130_fd_sc_hd__and3_1 _1114_ (.A(net53),
    .B(_0036_),
    .C(net15),
    .X(_0330_));
 sky130_fd_sc_hd__a21o_1 _1115_ (.A1(_0786_),
    .A2(_0190_),
    .B1(_0330_),
    .X(_0331_));
 sky130_fd_sc_hd__or3_1 _1116_ (.A(net17),
    .B(_0125_),
    .C(_0210_),
    .X(_0332_));
 sky130_fd_sc_hd__nand2b_2 _1117_ (.A_N(net81),
    .B(net69),
    .Y(_0333_));
 sky130_fd_sc_hd__xnor2_4 _1118_ (.A(net93),
    .B(net101),
    .Y(_0334_));
 sky130_fd_sc_hd__or4_1 _1119_ (.A(_0061_),
    .B(_0282_),
    .C(_0333_),
    .D(_0334_),
    .X(_0335_));
 sky130_fd_sc_hd__o31a_1 _1120_ (.A1(net40),
    .A2(_0130_),
    .A3(_0220_),
    .B1(_0335_),
    .X(_0336_));
 sky130_fd_sc_hd__a31o_1 _1121_ (.A1(net14),
    .A2(_0131_),
    .A3(_0221_),
    .B1(_0336_),
    .X(_0337_));
 sky130_fd_sc_hd__nor2_1 _1122_ (.A(net89),
    .B(_0063_),
    .Y(_0338_));
 sky130_fd_sc_hd__o32a_1 _1123_ (.A1(net89),
    .A2(_0063_),
    .A3(_0185_),
    .B1(_0132_),
    .B2(net56),
    .X(_0339_));
 sky130_fd_sc_hd__nand2_1 _1124_ (.A(net86),
    .B(_0121_),
    .Y(_0340_));
 sky130_fd_sc_hd__a21o_1 _1125_ (.A1(net81),
    .A2(_0120_),
    .B1(_0072_),
    .X(_0341_));
 sky130_fd_sc_hd__a21oi_1 _1126_ (.A1(_0072_),
    .A2(_0141_),
    .B1(net25),
    .Y(_0342_));
 sky130_fd_sc_hd__a2111o_1 _1127_ (.A1(net94),
    .A2(_0301_),
    .B1(_0201_),
    .C1(_0121_),
    .D1(net83),
    .X(_0343_));
 sky130_fd_sc_hd__a221o_1 _1128_ (.A1(net25),
    .A2(_0228_),
    .B1(_0342_),
    .B2(_0343_),
    .C1(_0111_),
    .X(_0344_));
 sky130_fd_sc_hd__o31a_1 _1129_ (.A1(net4),
    .A2(_0339_),
    .A3(_0341_),
    .B1(_0344_),
    .X(_0345_));
 sky130_fd_sc_hd__a21oi_1 _1130_ (.A1(net59),
    .A2(_0125_),
    .B1(_0205_),
    .Y(_0346_));
 sky130_fd_sc_hd__nor2_1 _1131_ (.A(_0047_),
    .B(_0309_),
    .Y(_0347_));
 sky130_fd_sc_hd__a221o_1 _1132_ (.A1(net59),
    .A2(_0125_),
    .B1(_0347_),
    .B2(net51),
    .C1(_0205_),
    .X(_0348_));
 sky130_fd_sc_hd__o211ai_1 _1133_ (.A1(net25),
    .A2(_0346_),
    .B1(_0348_),
    .C1(net6),
    .Y(_0349_));
 sky130_fd_sc_hd__a211o_1 _1134_ (.A1(_0057_),
    .A2(_0279_),
    .B1(_0170_),
    .C1(net41),
    .X(_0350_));
 sky130_fd_sc_hd__and2_1 _1135_ (.A(net54),
    .B(_0144_),
    .X(_0351_));
 sky130_fd_sc_hd__a22o_1 _1136_ (.A1(_0196_),
    .A2(_0237_),
    .B1(_0351_),
    .B2(net5),
    .X(_0352_));
 sky130_fd_sc_hd__a31o_1 _1137_ (.A1(_0337_),
    .A2(_0345_),
    .A3(_0349_),
    .B1(net34),
    .X(_0353_));
 sky130_fd_sc_hd__a31o_1 _1138_ (.A1(_0321_),
    .A2(_0322_),
    .A3(_0323_),
    .B1(net39),
    .X(_0354_));
 sky130_fd_sc_hd__a31o_1 _1139_ (.A1(_0314_),
    .A2(_0315_),
    .A3(_0319_),
    .B1(_0354_),
    .X(_0355_));
 sky130_fd_sc_hd__a21o_1 _1140_ (.A1(_0328_),
    .A2(_0329_),
    .B1(_0095_),
    .X(_0356_));
 sky130_fd_sc_hd__a21boi_1 _1141_ (.A1(_0110_),
    .A2(_0331_),
    .B1_N(_0332_),
    .Y(_0357_));
 sky130_fd_sc_hd__o211ai_1 _1142_ (.A1(_0226_),
    .A2(_0351_),
    .B1(_0350_),
    .C1(net37),
    .Y(_0358_));
 sky130_fd_sc_hd__o221a_1 _1143_ (.A1(net37),
    .A2(_0357_),
    .B1(_0358_),
    .B2(_0352_),
    .C1(net36),
    .X(_0359_));
 sky130_fd_sc_hd__a32oi_1 _1144_ (.A1(_0679_),
    .A2(_0353_),
    .A3(_0355_),
    .B1(_0356_),
    .B2(_0359_),
    .Y(_0360_));
 sky130_fd_sc_hd__o21ai_1 _1145_ (.A1(net44),
    .A2(_0137_),
    .B1(_0099_),
    .Y(_0361_));
 sky130_fd_sc_hd__or2_1 _1146_ (.A(_0090_),
    .B(_0333_),
    .X(_0362_));
 sky130_fd_sc_hd__nand2_2 _1147_ (.A(net77),
    .B(_0115_),
    .Y(_0363_));
 sky130_fd_sc_hd__a31o_1 _1148_ (.A1(net83),
    .A2(net33),
    .A3(_0334_),
    .B1(net10),
    .X(_0364_));
 sky130_fd_sc_hd__a32o_1 _1149_ (.A1(net19),
    .A2(_0161_),
    .A3(_0363_),
    .B1(_0364_),
    .B2(_0167_),
    .X(_0365_));
 sky130_fd_sc_hd__a2bb2o_1 _1150_ (.A1_N(_0226_),
    .A2_N(_0365_),
    .B1(_0361_),
    .B2(_0668_),
    .X(_0366_));
 sky130_fd_sc_hd__nor2_2 _1151_ (.A(_0679_),
    .B(_0690_),
    .Y(_0367_));
 sky130_fd_sc_hd__a31o_1 _1152_ (.A1(_0145_),
    .A2(_0264_),
    .A3(_0309_),
    .B1(net35),
    .X(_0368_));
 sky130_fd_sc_hd__a31oi_1 _1153_ (.A1(_0366_),
    .A2(_0367_),
    .A3(_0368_),
    .B1(_0646_),
    .Y(_0369_));
 sky130_fd_sc_hd__o31a_1 _1154_ (.A1(net95),
    .A2(_0064_),
    .A3(_0087_),
    .B1(net87),
    .X(_0370_));
 sky130_fd_sc_hd__nor2_1 _1155_ (.A(net86),
    .B(_0300_),
    .Y(_0371_));
 sky130_fd_sc_hd__o2111a_1 _1156_ (.A1(_0370_),
    .A2(_0371_),
    .B1(net74),
    .C1(net53),
    .D1(_0145_),
    .X(_0372_));
 sky130_fd_sc_hd__a21o_1 _1157_ (.A1(net84),
    .A2(_0121_),
    .B1(_0169_),
    .X(_0373_));
 sky130_fd_sc_hd__o211ai_1 _1158_ (.A1(_0168_),
    .A2(_0362_),
    .B1(net46),
    .C1(net18),
    .Y(_0374_));
 sky130_fd_sc_hd__or3b_1 _1159_ (.A(_0372_),
    .B(_0374_),
    .C_N(_0373_),
    .X(_0375_));
 sky130_fd_sc_hd__a311o_1 _1160_ (.A1(net61),
    .A2(_0052_),
    .A3(_0289_),
    .B1(_0109_),
    .C1(net16),
    .X(_0376_));
 sky130_fd_sc_hd__a21o_1 _1161_ (.A1(net11),
    .A2(_0141_),
    .B1(net14),
    .X(_0377_));
 sky130_fd_sc_hd__nor2_1 _1162_ (.A(_0781_),
    .B(net18),
    .Y(_0378_));
 sky130_fd_sc_hd__a2111o_1 _1163_ (.A1(_0062_),
    .A2(_0326_),
    .B1(_0378_),
    .C1(_0167_),
    .D1(net46),
    .X(_0379_));
 sky130_fd_sc_hd__and3_1 _1164_ (.A(_0668_),
    .B(_0377_),
    .C(_0379_),
    .X(_0380_));
 sky130_fd_sc_hd__a31o_1 _1165_ (.A1(net42),
    .A2(_0375_),
    .A3(_0376_),
    .B1(_0380_),
    .X(_0381_));
 sky130_fd_sc_hd__nand2_1 _1166_ (.A(_0679_),
    .B(\audio_player_inst.current_addr[11] ),
    .Y(_0382_));
 sky130_fd_sc_hd__o21ai_1 _1167_ (.A1(net64),
    .A2(_0265_),
    .B1(_0057_),
    .Y(_0383_));
 sky130_fd_sc_hd__o32a_1 _1168_ (.A1(net64),
    .A2(_0109_),
    .A3(_0147_),
    .B1(_0145_),
    .B2(net12),
    .X(_0384_));
 sky130_fd_sc_hd__a31o_1 _1169_ (.A1(_0099_),
    .A2(_0383_),
    .A3(_0384_),
    .B1(net42),
    .X(_0385_));
 sky130_fd_sc_hd__a21oi_1 _1170_ (.A1(_0090_),
    .A2(_0301_),
    .B1(net84),
    .Y(_0386_));
 sky130_fd_sc_hd__o221a_1 _1171_ (.A1(net54),
    .A2(_0269_),
    .B1(_0386_),
    .B2(_0263_),
    .C1(net5),
    .X(_0387_));
 sky130_fd_sc_hd__a21oi_1 _1172_ (.A1(net6),
    .A2(_0351_),
    .B1(_0387_),
    .Y(_0388_));
 sky130_fd_sc_hd__a21oi_1 _1173_ (.A1(_0385_),
    .A2(_0388_),
    .B1(net39),
    .Y(_0389_));
 sky130_fd_sc_hd__a211o_1 _1174_ (.A1(net39),
    .A2(_0381_),
    .B1(_0382_),
    .C1(_0389_),
    .X(_0390_));
 sky130_fd_sc_hd__o211a_1 _1175_ (.A1(\audio_player_inst.current_addr[11] ),
    .A2(_0360_),
    .B1(_0369_),
    .C1(_0390_),
    .X(_0391_));
 sky130_fd_sc_hd__or3_1 _1176_ (.A(_0635_),
    .B(_0308_),
    .C(_0391_),
    .X(_0392_));
 sky130_fd_sc_hd__o221a_1 _1177_ (.A1(_0712_),
    .A2(_0782_),
    .B1(_0087_),
    .B2(_0166_),
    .C1(net73),
    .X(_0393_));
 sky130_fd_sc_hd__a2111o_1 _1178_ (.A1(net33),
    .A2(_0214_),
    .B1(_0393_),
    .C1(net62),
    .D1(net14),
    .X(_0394_));
 sky130_fd_sc_hd__o21ai_1 _1179_ (.A1(_0783_),
    .A2(net15),
    .B1(_0144_),
    .Y(_0395_));
 sky130_fd_sc_hd__nand2_1 _1180_ (.A(_0108_),
    .B(_0395_),
    .Y(_0396_));
 sky130_fd_sc_hd__or4_1 _1181_ (.A(net47),
    .B(_0185_),
    .C(_0259_),
    .D(_0310_),
    .X(_0397_));
 sky130_fd_sc_hd__a31o_1 _1182_ (.A1(_0394_),
    .A2(_0396_),
    .A3(_0397_),
    .B1(net41),
    .X(_0398_));
 sky130_fd_sc_hd__nand2_1 _1183_ (.A(_0080_),
    .B(_0281_),
    .Y(_0399_));
 sky130_fd_sc_hd__or3_1 _1184_ (.A(_0701_),
    .B(net86),
    .C(_0300_),
    .X(_0400_));
 sky130_fd_sc_hd__a21o_1 _1185_ (.A1(_0340_),
    .A2(_0400_),
    .B1(_0169_),
    .X(_0401_));
 sky130_fd_sc_hd__a21o_1 _1186_ (.A1(_0118_),
    .A2(_0401_),
    .B1(net4),
    .X(_0402_));
 sky130_fd_sc_hd__a31o_1 _1187_ (.A1(_0398_),
    .A2(_0399_),
    .A3(_0402_),
    .B1(net34),
    .X(_0403_));
 sky130_fd_sc_hd__o21a_1 _1188_ (.A1(_0043_),
    .A2(_0061_),
    .B1(_0079_),
    .X(_0404_));
 sky130_fd_sc_hd__o32a_1 _1189_ (.A1(net60),
    .A2(_0138_),
    .A3(_0404_),
    .B1(_0149_),
    .B2(net110),
    .X(_0405_));
 sky130_fd_sc_hd__or4b_1 _1190_ (.A(net34),
    .B(_0668_),
    .C(net23),
    .D_N(_0160_),
    .X(_0406_));
 sky130_fd_sc_hd__o21a_1 _1191_ (.A1(_0405_),
    .A2(_0406_),
    .B1(net36),
    .X(_0407_));
 sky130_fd_sc_hd__nor2_1 _1192_ (.A(_0088_),
    .B(_0142_),
    .Y(_0408_));
 sky130_fd_sc_hd__o31a_1 _1193_ (.A1(net49),
    .A2(_0154_),
    .A3(_0408_),
    .B1(net6),
    .X(_0409_));
 sky130_fd_sc_hd__o21ai_1 _1194_ (.A1(net61),
    .A2(_0241_),
    .B1(_0409_),
    .Y(_0410_));
 sky130_fd_sc_hd__nand2_2 _1195_ (.A(_0056_),
    .B(_0090_),
    .Y(_0411_));
 sky130_fd_sc_hd__a21o_1 _1196_ (.A1(net26),
    .A2(_0411_),
    .B1(_0111_),
    .X(_0412_));
 sky130_fd_sc_hd__or2_1 _1197_ (.A(_0066_),
    .B(_0216_),
    .X(_0413_));
 sky130_fd_sc_hd__a31o_1 _1198_ (.A1(net49),
    .A2(_0035_),
    .A3(_0413_),
    .B1(_0412_),
    .X(_0414_));
 sky130_fd_sc_hd__and4bb_1 _1199_ (.A_N(net108),
    .B_N(net76),
    .C(net100),
    .D(net84),
    .X(_0415_));
 sky130_fd_sc_hd__a31o_1 _1200_ (.A1(net110),
    .A2(net25),
    .A3(_0415_),
    .B1(_0167_),
    .X(_0416_));
 sky130_fd_sc_hd__o21a_1 _1201_ (.A1(net61),
    .A2(_0216_),
    .B1(_0416_),
    .X(_0417_));
 sky130_fd_sc_hd__or3_1 _1202_ (.A(net4),
    .B(_0342_),
    .C(_0417_),
    .X(_0418_));
 sky130_fd_sc_hd__a31o_1 _1203_ (.A1(_0410_),
    .A2(_0414_),
    .A3(_0418_),
    .B1(net37),
    .X(_0419_));
 sky130_fd_sc_hd__and3_1 _1204_ (.A(_0403_),
    .B(_0407_),
    .C(_0419_),
    .X(_0420_));
 sky130_fd_sc_hd__nand2_1 _1205_ (.A(_0089_),
    .B(_0167_),
    .Y(_0421_));
 sky130_fd_sc_hd__a21o_1 _1206_ (.A1(_0054_),
    .A2(_0155_),
    .B1(_0198_),
    .X(_0422_));
 sky130_fd_sc_hd__a21o_1 _1207_ (.A1(_0421_),
    .A2(_0422_),
    .B1(_0226_),
    .X(_0423_));
 sky130_fd_sc_hd__or4_1 _1208_ (.A(net73),
    .B(net30),
    .C(_0076_),
    .D(_0126_),
    .X(_0424_));
 sky130_fd_sc_hd__a41o_1 _1209_ (.A1(net27),
    .A2(_0149_),
    .A3(_0292_),
    .A4(_0424_),
    .B1(_0378_),
    .X(_0425_));
 sky130_fd_sc_hd__nand2_1 _1210_ (.A(net5),
    .B(_0425_),
    .Y(_0426_));
 sky130_fd_sc_hd__or3b_1 _1211_ (.A(_0737_),
    .B(_0282_),
    .C_N(_0043_),
    .X(_0427_));
 sky130_fd_sc_hd__and2_1 _1212_ (.A(net26),
    .B(_0195_),
    .X(_0428_));
 sky130_fd_sc_hd__o32a_1 _1213_ (.A1(_0111_),
    .A2(_0264_),
    .A3(_0428_),
    .B1(_0427_),
    .B2(net22),
    .X(_0429_));
 sky130_fd_sc_hd__a31o_1 _1214_ (.A1(_0423_),
    .A2(_0426_),
    .A3(_0429_),
    .B1(net38),
    .X(_0430_));
 sky130_fd_sc_hd__a21o_1 _1215_ (.A1(_0040_),
    .A2(_0062_),
    .B1(_0161_),
    .X(_0431_));
 sky130_fd_sc_hd__a211o_1 _1216_ (.A1(_0363_),
    .A2(_0431_),
    .B1(net44),
    .C1(net21),
    .X(_0432_));
 sky130_fd_sc_hd__a21oi_1 _1217_ (.A1(_0108_),
    .A2(_0163_),
    .B1(net40),
    .Y(_0433_));
 sky130_fd_sc_hd__o21ai_2 _1218_ (.A1(net62),
    .A2(_0055_),
    .B1(net27),
    .Y(_0434_));
 sky130_fd_sc_hd__o32a_1 _1219_ (.A1(net25),
    .A2(_0096_),
    .A3(_0152_),
    .B1(_0434_),
    .B2(_0130_),
    .X(_0435_));
 sky130_fd_sc_hd__o211a_1 _1220_ (.A1(net23),
    .A2(_0435_),
    .B1(_0433_),
    .C1(_0432_),
    .X(_0436_));
 sky130_fd_sc_hd__a41o_1 _1221_ (.A1(net75),
    .A2(net54),
    .A3(_0071_),
    .A4(_0215_),
    .B1(net19),
    .X(_0437_));
 sky130_fd_sc_hd__o2111ai_2 _1222_ (.A1(net75),
    .A2(_0370_),
    .B1(_0411_),
    .C1(_0437_),
    .D1(net45),
    .Y(_0438_));
 sky130_fd_sc_hd__o21a_1 _1223_ (.A1(net67),
    .A2(_0186_),
    .B1(_0173_),
    .X(_0439_));
 sky130_fd_sc_hd__o211a_1 _1224_ (.A1(net12),
    .A2(_0439_),
    .B1(_0438_),
    .C1(_0315_),
    .X(_0440_));
 sky130_fd_sc_hd__or3_1 _1225_ (.A(net35),
    .B(_0436_),
    .C(_0440_),
    .X(_0441_));
 sky130_fd_sc_hd__a31o_1 _1226_ (.A1(_0679_),
    .A2(_0430_),
    .A3(_0441_),
    .B1(\audio_player_inst.current_addr[11] ),
    .X(_0442_));
 sky130_fd_sc_hd__o211a_1 _1227_ (.A1(net96),
    .A2(net88),
    .B1(net112),
    .C1(net104),
    .X(_0443_));
 sky130_fd_sc_hd__o211a_1 _1228_ (.A1(_0091_),
    .A2(_0443_),
    .B1(net76),
    .C1(_0068_),
    .X(_0444_));
 sky130_fd_sc_hd__nand2_1 _1229_ (.A(_0065_),
    .B(_0126_),
    .Y(_0445_));
 sky130_fd_sc_hd__o211a_1 _1230_ (.A1(_0064_),
    .A2(_0127_),
    .B1(_0116_),
    .C1(net33),
    .X(_0446_));
 sky130_fd_sc_hd__a21oi_1 _1231_ (.A1(net29),
    .A2(_0204_),
    .B1(_0086_),
    .Y(_0447_));
 sky130_fd_sc_hd__o31a_1 _1232_ (.A1(net29),
    .A2(_0444_),
    .A3(_0446_),
    .B1(_0447_),
    .X(_0448_));
 sky130_fd_sc_hd__nand2_1 _1233_ (.A(_0127_),
    .B(_0141_),
    .Y(_0449_));
 sky130_fd_sc_hd__a22o_1 _1234_ (.A1(_0108_),
    .A2(_0220_),
    .B1(_0449_),
    .B2(_0097_),
    .X(_0450_));
 sky130_fd_sc_hd__o21a_1 _1235_ (.A1(_0448_),
    .A2(_0450_),
    .B1(net39),
    .X(_0451_));
 sky130_fd_sc_hd__and4b_1 _1236_ (.A_N(net114),
    .B(net106),
    .C(net77),
    .D(net89),
    .X(_0452_));
 sky130_fd_sc_hd__nor2_1 _1237_ (.A(_0096_),
    .B(_0452_),
    .Y(_0453_));
 sky130_fd_sc_hd__a311o_1 _1238_ (.A1(net66),
    .A2(_0139_),
    .A3(_0147_),
    .B1(_0453_),
    .C1(_0086_),
    .X(_0454_));
 sky130_fd_sc_hd__o211a_1 _1239_ (.A1(net48),
    .A2(_0273_),
    .B1(_0171_),
    .C1(net35),
    .X(_0455_));
 sky130_fd_sc_hd__a211oi_1 _1240_ (.A1(_0454_),
    .A2(_0455_),
    .B1(net43),
    .C1(_0451_),
    .Y(_0456_));
 sky130_fd_sc_hd__nand2b_1 _1241_ (.A_N(_0070_),
    .B(_0334_),
    .Y(_0457_));
 sky130_fd_sc_hd__o32a_1 _1242_ (.A1(net64),
    .A2(net22),
    .A3(net13),
    .B1(_0167_),
    .B2(_0326_),
    .X(_0458_));
 sky130_fd_sc_hd__nor2_1 _1243_ (.A(_0201_),
    .B(_0257_),
    .Y(_0459_));
 sky130_fd_sc_hd__a22o_1 _1244_ (.A1(net16),
    .A2(_0457_),
    .B1(_0459_),
    .B2(net84),
    .X(_0460_));
 sky130_fd_sc_hd__a211o_1 _1245_ (.A1(net54),
    .A2(_0460_),
    .B1(_0458_),
    .C1(net45),
    .X(_0461_));
 sky130_fd_sc_hd__a21o_1 _1246_ (.A1(net30),
    .A2(_0139_),
    .B1(net14),
    .X(_0462_));
 sky130_fd_sc_hd__and4_1 _1247_ (.A(net38),
    .B(net43),
    .C(_0461_),
    .D(_0462_),
    .X(_0463_));
 sky130_fd_sc_hd__a31o_1 _1248_ (.A1(_0041_),
    .A2(net16),
    .A3(_0108_),
    .B1(_0095_),
    .X(_0464_));
 sky130_fd_sc_hd__a2bb2o_1 _1249_ (.A1_N(_0228_),
    .A2_N(net14),
    .B1(_0057_),
    .B2(_0195_),
    .X(_0465_));
 sky130_fd_sc_hd__o21ai_1 _1250_ (.A1(_0464_),
    .A2(_0465_),
    .B1(_0367_),
    .Y(_0466_));
 sky130_fd_sc_hd__or3_1 _1251_ (.A(_0456_),
    .B(_0463_),
    .C(_0466_),
    .X(_0467_));
 sky130_fd_sc_hd__or3_1 _1252_ (.A(net64),
    .B(_0128_),
    .C(net9),
    .X(_0468_));
 sky130_fd_sc_hd__a311o_1 _1253_ (.A1(net94),
    .A2(net83),
    .A3(_0301_),
    .B1(_0072_),
    .C1(net70),
    .X(_0469_));
 sky130_fd_sc_hd__a211oi_1 _1254_ (.A1(net49),
    .A2(_0469_),
    .B1(_0279_),
    .C1(_0226_),
    .Y(_0470_));
 sky130_fd_sc_hd__a311oi_2 _1255_ (.A1(_0074_),
    .A2(_0237_),
    .A3(_0468_),
    .B1(_0470_),
    .C1(net39),
    .Y(_0471_));
 sky130_fd_sc_hd__nand2_1 _1256_ (.A(net58),
    .B(net8),
    .Y(_0472_));
 sky130_fd_sc_hd__a32o_1 _1257_ (.A1(net19),
    .A2(net8),
    .A3(_0250_),
    .B1(_0037_),
    .B2(net26),
    .X(_0473_));
 sky130_fd_sc_hd__or2_1 _1258_ (.A(net23),
    .B(_0473_),
    .X(_0474_));
 sky130_fd_sc_hd__or3_1 _1259_ (.A(net17),
    .B(_0146_),
    .C(net4),
    .X(_0475_));
 sky130_fd_sc_hd__or3_1 _1260_ (.A(_0783_),
    .B(_0088_),
    .C(_0142_),
    .X(_0476_));
 sky130_fd_sc_hd__o311a_1 _1261_ (.A1(net15),
    .A2(_0071_),
    .A3(_0091_),
    .B1(_0476_),
    .C1(net49),
    .X(_0477_));
 sky130_fd_sc_hd__a21o_1 _1262_ (.A1(_0072_),
    .A2(_0141_),
    .B1(_0111_),
    .X(_0478_));
 sky130_fd_sc_hd__o31a_1 _1263_ (.A1(_0130_),
    .A2(_0477_),
    .A3(_0478_),
    .B1(_0475_),
    .X(_0479_));
 sky130_fd_sc_hd__o211a_1 _1264_ (.A1(net41),
    .A2(_0474_),
    .B1(_0479_),
    .C1(_0471_),
    .X(_0480_));
 sky130_fd_sc_hd__or2_1 _1265_ (.A(_0781_),
    .B(_0256_),
    .X(_0481_));
 sky130_fd_sc_hd__a31o_1 _1266_ (.A1(net61),
    .A2(_0217_),
    .A3(_0481_),
    .B1(net26),
    .X(_0482_));
 sky130_fd_sc_hd__nand2_1 _1267_ (.A(_0190_),
    .B(_0250_),
    .Y(_0483_));
 sky130_fd_sc_hd__a21oi_1 _1268_ (.A1(_0482_),
    .A2(_0483_),
    .B1(_0210_),
    .Y(_0484_));
 sky130_fd_sc_hd__a31o_1 _1269_ (.A1(net33),
    .A2(net29),
    .A3(_0054_),
    .B1(net26),
    .X(_0485_));
 sky130_fd_sc_hd__o31a_1 _1270_ (.A1(_0169_),
    .A2(_0338_),
    .A3(_0370_),
    .B1(_0485_),
    .X(_0486_));
 sky130_fd_sc_hd__a31o_1 _1271_ (.A1(net83),
    .A2(_0090_),
    .A3(_0256_),
    .B1(_0142_),
    .X(_0487_));
 sky130_fd_sc_hd__a211o_1 _1272_ (.A1(net26),
    .A2(_0487_),
    .B1(_0330_),
    .C1(_0226_),
    .X(_0488_));
 sky130_fd_sc_hd__o22a_1 _1273_ (.A1(net54),
    .A2(_0143_),
    .B1(_0145_),
    .B2(_0185_),
    .X(_0489_));
 sky130_fd_sc_hd__o21a_1 _1274_ (.A1(_0111_),
    .A2(_0489_),
    .B1(net39),
    .X(_0490_));
 sky130_fd_sc_hd__o211ai_1 _1275_ (.A1(net4),
    .A2(_0486_),
    .B1(_0488_),
    .C1(_0490_),
    .Y(_0491_));
 sky130_fd_sc_hd__a211o_1 _1276_ (.A1(net71),
    .A2(_0112_),
    .B1(_0484_),
    .C1(_0491_),
    .X(_0492_));
 sky130_fd_sc_hd__or3b_1 _1277_ (.A(_0382_),
    .B(_0480_),
    .C_N(_0492_),
    .X(_0493_));
 sky130_fd_sc_hd__o211ai_1 _1278_ (.A1(_0420_),
    .A2(_0442_),
    .B1(_0467_),
    .C1(_0493_),
    .Y(_0494_));
 sky130_fd_sc_hd__o32a_1 _1279_ (.A1(net12),
    .A2(_0132_),
    .A3(_0145_),
    .B1(_0086_),
    .B2(_0056_),
    .X(_0495_));
 sky130_fd_sc_hd__a211o_1 _1280_ (.A1(_0257_),
    .A2(_0316_),
    .B1(net90),
    .C1(_0171_),
    .X(_0496_));
 sky130_fd_sc_hd__or4b_1 _1281_ (.A(_0037_),
    .B(_0087_),
    .C(net12),
    .D_N(_0258_),
    .X(_0497_));
 sky130_fd_sc_hd__and3_1 _1282_ (.A(_0495_),
    .B(_0496_),
    .C(_0497_),
    .X(_0498_));
 sky130_fd_sc_hd__nand3_1 _1283_ (.A(net114),
    .B(net65),
    .C(_0415_),
    .Y(_0499_));
 sky130_fd_sc_hd__o2111ai_2 _1284_ (.A1(_0142_),
    .A2(_0457_),
    .B1(_0499_),
    .C1(_0149_),
    .D1(_0057_),
    .Y(_0500_));
 sky130_fd_sc_hd__a21oi_1 _1285_ (.A1(_0498_),
    .A2(_0500_),
    .B1(net42),
    .Y(_0501_));
 sky130_fd_sc_hd__and3_1 _1286_ (.A(net32),
    .B(_0054_),
    .C(_0071_),
    .X(_0502_));
 sky130_fd_sc_hd__a21oi_1 _1287_ (.A1(net98),
    .A2(_0722_),
    .B1(net89),
    .Y(_0503_));
 sky130_fd_sc_hd__o211ai_1 _1288_ (.A1(_0701_),
    .A2(net74),
    .B1(net67),
    .C1(_0070_),
    .Y(_0504_));
 sky130_fd_sc_hd__o32a_1 _1289_ (.A1(net66),
    .A2(_0265_),
    .A3(_0502_),
    .B1(_0503_),
    .B2(_0504_),
    .X(_0505_));
 sky130_fd_sc_hd__and2b_1 _1290_ (.A_N(_0505_),
    .B(_0112_),
    .X(_0506_));
 sky130_fd_sc_hd__a32o_1 _1291_ (.A1(_0124_),
    .A2(_0211_),
    .A3(_0215_),
    .B1(_0292_),
    .B2(net54),
    .X(_0507_));
 sky130_fd_sc_hd__and2_1 _1292_ (.A(_0225_),
    .B(_0507_),
    .X(_0508_));
 sky130_fd_sc_hd__a21oi_1 _1293_ (.A1(net22),
    .A2(_0061_),
    .B1(_0452_),
    .Y(_0509_));
 sky130_fd_sc_hd__nor2_1 _1294_ (.A(_0039_),
    .B(_0363_),
    .Y(_0510_));
 sky130_fd_sc_hd__a32o_1 _1295_ (.A1(_0173_),
    .A2(_0190_),
    .A3(_0509_),
    .B1(_0184_),
    .B2(_0145_),
    .X(_0511_));
 sky130_fd_sc_hd__o21a_1 _1296_ (.A1(_0510_),
    .A2(_0511_),
    .B1(_0231_),
    .X(_0512_));
 sky130_fd_sc_hd__o41a_1 _1297_ (.A1(_0501_),
    .A2(_0506_),
    .A3(_0508_),
    .A4(_0512_),
    .B1(net38),
    .X(_0513_));
 sky130_fd_sc_hd__a21oi_1 _1298_ (.A1(net76),
    .A2(net10),
    .B1(_0415_),
    .Y(_0514_));
 sky130_fd_sc_hd__nor2_1 _1299_ (.A(_0782_),
    .B(_0121_),
    .Y(_0515_));
 sky130_fd_sc_hd__or4_1 _1300_ (.A(_0782_),
    .B(_0121_),
    .C(_0201_),
    .D(_0311_),
    .X(_0516_));
 sky130_fd_sc_hd__o211a_1 _1301_ (.A1(net65),
    .A2(_0514_),
    .B1(_0516_),
    .C1(net24),
    .X(_0517_));
 sky130_fd_sc_hd__o41a_1 _1302_ (.A1(_0095_),
    .A2(_0148_),
    .A3(_0428_),
    .A4(_0517_),
    .B1(\audio_player_inst.current_addr[10] ),
    .X(_0518_));
 sky130_fd_sc_hd__a211o_1 _1303_ (.A1(_0052_),
    .A2(_0062_),
    .B1(_0072_),
    .C1(net76),
    .X(_0519_));
 sky130_fd_sc_hd__o2111a_1 _1304_ (.A1(net33),
    .A2(_0258_),
    .B1(_0519_),
    .C1(net29),
    .D1(_0186_),
    .X(_0520_));
 sky130_fd_sc_hd__a31oi_1 _1305_ (.A1(_0070_),
    .A2(_0257_),
    .A3(_0258_),
    .B1(net74),
    .Y(_0521_));
 sky130_fd_sc_hd__a311o_1 _1306_ (.A1(net105),
    .A2(net75),
    .A3(_0076_),
    .B1(_0521_),
    .C1(net18),
    .X(_0522_));
 sky130_fd_sc_hd__o311a_1 _1307_ (.A1(net53),
    .A2(_0269_),
    .A3(_0520_),
    .B1(_0522_),
    .C1(net45),
    .X(_0523_));
 sky130_fd_sc_hd__a21o_1 _1308_ (.A1(_0712_),
    .A2(_0257_),
    .B1(net15),
    .X(_0524_));
 sky130_fd_sc_hd__and2b_1 _1309_ (.A_N(_0524_),
    .B(_0317_),
    .X(_0525_));
 sky130_fd_sc_hd__o22ai_1 _1310_ (.A1(net47),
    .A2(_0434_),
    .B1(_0525_),
    .B2(_0058_),
    .Y(_0526_));
 sky130_fd_sc_hd__o21a_1 _1311_ (.A1(_0523_),
    .A2(_0526_),
    .B1(_0059_),
    .X(_0527_));
 sky130_fd_sc_hd__or3b_1 _1312_ (.A(_0513_),
    .B(_0527_),
    .C_N(_0518_),
    .X(_0528_));
 sky130_fd_sc_hd__a21oi_1 _1313_ (.A1(_0240_),
    .A2(_0445_),
    .B1(_0128_),
    .Y(_0529_));
 sky130_fd_sc_hd__a21oi_1 _1314_ (.A1(_0257_),
    .A2(_0316_),
    .B1(_0036_),
    .Y(_0530_));
 sky130_fd_sc_hd__a211o_1 _1315_ (.A1(_0240_),
    .A2(_0445_),
    .B1(_0530_),
    .C1(_0128_),
    .X(_0531_));
 sky130_fd_sc_hd__o211a_1 _1316_ (.A1(net30),
    .A2(_0529_),
    .B1(_0531_),
    .C1(_0097_),
    .X(_0532_));
 sky130_fd_sc_hd__nor2_1 _1317_ (.A(net50),
    .B(_0243_),
    .Y(_0533_));
 sky130_fd_sc_hd__nor2_1 _1318_ (.A(net46),
    .B(_0533_),
    .Y(_0534_));
 sky130_fd_sc_hd__nor2_1 _1319_ (.A(_0712_),
    .B(_0052_),
    .Y(_0535_));
 sky130_fd_sc_hd__or4_1 _1320_ (.A(net29),
    .B(_0162_),
    .C(_0371_),
    .D(_0535_),
    .X(_0536_));
 sky130_fd_sc_hd__o211a_1 _1321_ (.A1(_0144_),
    .A2(_0515_),
    .B1(_0536_),
    .C1(net53),
    .X(_0537_));
 sky130_fd_sc_hd__o31a_1 _1322_ (.A1(_0532_),
    .A2(_0534_),
    .A3(_0537_),
    .B1(_0059_),
    .X(_0538_));
 sky130_fd_sc_hd__or3b_1 _1323_ (.A(net29),
    .B(net45),
    .C_N(_0316_),
    .X(_0539_));
 sky130_fd_sc_hd__a211oi_1 _1324_ (.A1(_0065_),
    .A2(_0311_),
    .B1(_0521_),
    .C1(_0539_),
    .Y(_0540_));
 sky130_fd_sc_hd__o21ai_1 _1325_ (.A1(net111),
    .A2(_0054_),
    .B1(_0077_),
    .Y(_0541_));
 sky130_fd_sc_hd__a21oi_1 _1326_ (.A1(_0184_),
    .A2(_0541_),
    .B1(net24),
    .Y(_0542_));
 sky130_fd_sc_hd__a2111o_1 _1327_ (.A1(net32),
    .A2(_0090_),
    .B1(_0091_),
    .C1(_0168_),
    .D1(_0245_),
    .X(_0543_));
 sky130_fd_sc_hd__o31a_1 _1328_ (.A1(net95),
    .A2(_0064_),
    .A3(_0087_),
    .B1(_0712_),
    .X(_0544_));
 sky130_fd_sc_hd__o31a_1 _1329_ (.A1(net15),
    .A2(_0535_),
    .A3(_0544_),
    .B1(net45),
    .X(_0545_));
 sky130_fd_sc_hd__o22a_1 _1330_ (.A1(_0540_),
    .A2(_0542_),
    .B1(_0545_),
    .B2(net53),
    .X(_0546_));
 sky130_fd_sc_hd__a31o_1 _1331_ (.A1(_0094_),
    .A2(_0543_),
    .A3(_0546_),
    .B1(\audio_player_inst.current_addr[10] ),
    .X(_0547_));
 sky130_fd_sc_hd__a21o_1 _1332_ (.A1(_0053_),
    .A2(_0301_),
    .B1(_0072_),
    .X(_0548_));
 sky130_fd_sc_hd__a21oi_1 _1333_ (.A1(_0082_),
    .A2(_0548_),
    .B1(_0191_),
    .Y(_0549_));
 sky130_fd_sc_hd__nor2_1 _1334_ (.A(_0263_),
    .B(_0445_),
    .Y(_0550_));
 sky130_fd_sc_hd__nor2_1 _1335_ (.A(net108),
    .B(_0166_),
    .Y(_0551_));
 sky130_fd_sc_hd__o211a_1 _1336_ (.A1(net76),
    .A2(_0551_),
    .B1(_0362_),
    .C1(_0167_),
    .X(_0552_));
 sky130_fd_sc_hd__o31a_1 _1337_ (.A1(_0549_),
    .A2(_0550_),
    .A3(_0552_),
    .B1(net5),
    .X(_0553_));
 sky130_fd_sc_hd__and3b_1 _1338_ (.A_N(_0309_),
    .B(net30),
    .C(_0712_),
    .X(_0554_));
 sky130_fd_sc_hd__or4_1 _1339_ (.A(_0712_),
    .B(net55),
    .C(_0197_),
    .D(_0257_),
    .X(_0555_));
 sky130_fd_sc_hd__o211a_1 _1340_ (.A1(_0198_),
    .A2(_0554_),
    .B1(_0555_),
    .C1(net6),
    .X(_0556_));
 sky130_fd_sc_hd__o21a_1 _1341_ (.A1(_0072_),
    .A2(_0217_),
    .B1(_0181_),
    .X(_0557_));
 sky130_fd_sc_hd__or3b_1 _1342_ (.A(net11),
    .B(_0338_),
    .C_N(_0272_),
    .X(_0558_));
 sky130_fd_sc_hd__or3_1 _1343_ (.A(_0165_),
    .B(_0201_),
    .C(_0334_),
    .X(_0559_));
 sky130_fd_sc_hd__a32o_1 _1344_ (.A1(_0112_),
    .A2(_0524_),
    .A3(_0559_),
    .B1(_0558_),
    .B2(_0281_),
    .X(_0560_));
 sky130_fd_sc_hd__or4_1 _1345_ (.A(_0553_),
    .B(_0556_),
    .C(_0557_),
    .D(_0560_),
    .X(_0561_));
 sky130_fd_sc_hd__a211o_1 _1346_ (.A1(net39),
    .A2(_0561_),
    .B1(_0547_),
    .C1(_0538_),
    .X(_0562_));
 sky130_fd_sc_hd__a21o_1 _1347_ (.A1(_0528_),
    .A2(_0562_),
    .B1(\audio_player_inst.current_addr[11] ),
    .X(_0563_));
 sky130_fd_sc_hd__o21a_1 _1348_ (.A1(_0152_),
    .A2(_0191_),
    .B1(_0294_),
    .X(_0564_));
 sky130_fd_sc_hd__a211o_1 _1349_ (.A1(_0139_),
    .A2(_0167_),
    .B1(net4),
    .C1(_0283_),
    .X(_0565_));
 sky130_fd_sc_hd__a21oi_1 _1350_ (.A1(_0076_),
    .A2(_0300_),
    .B1(_0204_),
    .Y(_0566_));
 sky130_fd_sc_hd__o32a_1 _1351_ (.A1(_0786_),
    .A2(_0168_),
    .A3(_0566_),
    .B1(_0327_),
    .B2(net25),
    .X(_0567_));
 sky130_fd_sc_hd__nand2_1 _1352_ (.A(_0110_),
    .B(_0567_),
    .Y(_0568_));
 sky130_fd_sc_hd__a41o_1 _1353_ (.A1(_0701_),
    .A2(net109),
    .A3(net101),
    .A4(net22),
    .B1(net21),
    .X(_0569_));
 sky130_fd_sc_hd__o21a_1 _1354_ (.A1(_0152_),
    .A2(_0191_),
    .B1(_0569_),
    .X(_0570_));
 sky130_fd_sc_hd__o22a_1 _1355_ (.A1(_0210_),
    .A2(_0564_),
    .B1(_0570_),
    .B2(_0226_),
    .X(_0571_));
 sky130_fd_sc_hd__and4_1 _1356_ (.A(net37),
    .B(_0565_),
    .C(_0568_),
    .D(_0571_),
    .X(_0572_));
 sky130_fd_sc_hd__nand2_1 _1357_ (.A(_0088_),
    .B(_0291_),
    .Y(_0573_));
 sky130_fd_sc_hd__o211a_1 _1358_ (.A1(_0087_),
    .A2(_0166_),
    .B1(net44),
    .C1(_0081_),
    .X(_0574_));
 sky130_fd_sc_hd__a221o_1 _1359_ (.A1(net44),
    .A2(net17),
    .B1(_0057_),
    .B2(_0573_),
    .C1(_0574_),
    .X(_0575_));
 sky130_fd_sc_hd__a21o_1 _1360_ (.A1(_0059_),
    .A2(_0575_),
    .B1(net36),
    .X(_0576_));
 sky130_fd_sc_hd__xnor2_1 _1361_ (.A(_0712_),
    .B(_0063_),
    .Y(_0577_));
 sky130_fd_sc_hd__or4_1 _1362_ (.A(net97),
    .B(net86),
    .C(_0201_),
    .D(_0300_),
    .X(_0578_));
 sky130_fd_sc_hd__o221a_1 _1363_ (.A1(net66),
    .A2(_0139_),
    .B1(_0577_),
    .B2(_0051_),
    .C1(_0085_),
    .X(_0579_));
 sky130_fd_sc_hd__nand2_1 _1364_ (.A(_0578_),
    .B(_0579_),
    .Y(_0580_));
 sky130_fd_sc_hd__a31o_1 _1365_ (.A1(_0065_),
    .A2(_0077_),
    .A3(_0088_),
    .B1(_0053_),
    .X(_0581_));
 sky130_fd_sc_hd__a31o_1 _1366_ (.A1(net26),
    .A2(_0050_),
    .A3(_0581_),
    .B1(net45),
    .X(_0582_));
 sky130_fd_sc_hd__a21o_1 _1367_ (.A1(net57),
    .A2(_0411_),
    .B1(_0582_),
    .X(_0583_));
 sky130_fd_sc_hd__o2111a_1 _1368_ (.A1(net12),
    .A2(_0148_),
    .B1(_0580_),
    .C1(_0583_),
    .D1(_0094_),
    .X(_0584_));
 sky130_fd_sc_hd__o31a_1 _1369_ (.A1(_0572_),
    .A2(_0576_),
    .A3(_0584_),
    .B1(\audio_player_inst.current_addr[11] ),
    .X(_0585_));
 sky130_fd_sc_hd__nand2_1 _1370_ (.A(_0781_),
    .B(_0082_),
    .Y(_0586_));
 sky130_fd_sc_hd__a32o_1 _1371_ (.A1(_0783_),
    .A2(_0038_),
    .A3(_0078_),
    .B1(_0533_),
    .B2(_0586_),
    .X(_0587_));
 sky130_fd_sc_hd__a22o_1 _1372_ (.A1(net16),
    .A2(_0071_),
    .B1(_0200_),
    .B2(_0054_),
    .X(_0588_));
 sky130_fd_sc_hd__a21oi_1 _1373_ (.A1(_0093_),
    .A2(_0588_),
    .B1(net12),
    .Y(_0589_));
 sky130_fd_sc_hd__a31o_1 _1374_ (.A1(_0108_),
    .A2(_0270_),
    .A3(_0279_),
    .B1(_0589_),
    .X(_0590_));
 sky130_fd_sc_hd__a22oi_2 _1375_ (.A1(_0110_),
    .A2(_0587_),
    .B1(_0590_),
    .B2(net41),
    .Y(_0591_));
 sky130_fd_sc_hd__o41a_1 _1376_ (.A1(net41),
    .A2(net14),
    .A3(_0265_),
    .A4(_0272_),
    .B1(\audio_player_inst.current_addr[9] ),
    .X(_0592_));
 sky130_fd_sc_hd__o32a_1 _1377_ (.A1(net18),
    .A2(_0081_),
    .A3(net4),
    .B1(_0282_),
    .B2(_0074_),
    .X(_0593_));
 sky130_fd_sc_hd__a211o_1 _1378_ (.A1(net82),
    .A2(_0120_),
    .B1(_0040_),
    .C1(net72),
    .X(_0594_));
 sky130_fd_sc_hd__a211o_1 _1379_ (.A1(_0221_),
    .A2(_0594_),
    .B1(net51),
    .C1(_0163_),
    .X(_0595_));
 sky130_fd_sc_hd__a31o_1 _1380_ (.A1(net40),
    .A2(net17),
    .A3(_0595_),
    .B1(net5),
    .X(_0596_));
 sky130_fd_sc_hd__o21a_1 _1381_ (.A1(_0072_),
    .A2(_0161_),
    .B1(_0129_),
    .X(_0597_));
 sky130_fd_sc_hd__a31o_1 _1382_ (.A1(net28),
    .A2(net23),
    .A3(_0597_),
    .B1(_0108_),
    .X(_0598_));
 sky130_fd_sc_hd__o21ai_1 _1383_ (.A1(_0138_),
    .A2(_0168_),
    .B1(_0598_),
    .Y(_0599_));
 sky130_fd_sc_hd__and3_1 _1384_ (.A(_0722_),
    .B(_0165_),
    .C(_0200_),
    .X(_0600_));
 sky130_fd_sc_hd__o211a_1 _1385_ (.A1(net78),
    .A2(_0126_),
    .B1(_0079_),
    .C1(net30),
    .X(_0601_));
 sky130_fd_sc_hd__o21ai_2 _1386_ (.A1(_0600_),
    .A2(_0601_),
    .B1(_0085_),
    .Y(_0602_));
 sky130_fd_sc_hd__o2111a_1 _1387_ (.A1(_0058_),
    .A2(_0163_),
    .B1(_0171_),
    .C1(_0602_),
    .D1(_0059_),
    .X(_0603_));
 sky130_fd_sc_hd__a311o_1 _1388_ (.A1(net34),
    .A2(_0596_),
    .A3(_0599_),
    .B1(_0603_),
    .C1(_0679_),
    .X(_0604_));
 sky130_fd_sc_hd__a31o_1 _1389_ (.A1(_0591_),
    .A2(_0592_),
    .A3(_0593_),
    .B1(_0604_),
    .X(_0605_));
 sky130_fd_sc_hd__a21oi_1 _1390_ (.A1(_0585_),
    .A2(_0605_),
    .B1(\audio_player_inst.current_addr[12] ),
    .Y(_0606_));
 sky130_fd_sc_hd__a221o_1 _1391_ (.A1(\audio_player_inst.current_addr[12] ),
    .A2(_0494_),
    .B1(_0563_),
    .B2(_0606_),
    .C1(\audio_player_inst.current_addr[13] ),
    .X(_0607_));
 sky130_fd_sc_hd__a21oi_1 _1392_ (.A1(_0392_),
    .A2(_0607_),
    .B1(_0778_),
    .Y(_0608_));
 sky130_fd_sc_hd__or3b_1 _1393_ (.A(_0126_),
    .B(_0172_),
    .C_N(_0265_),
    .X(_0609_));
 sky130_fd_sc_hd__or3_1 _1394_ (.A(net30),
    .B(_0081_),
    .C(_0104_),
    .X(_0610_));
 sky130_fd_sc_hd__a21o_1 _1395_ (.A1(_0182_),
    .A2(_0610_),
    .B1(net35),
    .X(_0611_));
 sky130_fd_sc_hd__a211o_1 _1396_ (.A1(_0176_),
    .A2(_0609_),
    .B1(_0611_),
    .C1(_0180_),
    .X(_0612_));
 sky130_fd_sc_hd__a21o_1 _1397_ (.A1(net72),
    .A2(_0041_),
    .B1(_0203_),
    .X(_0613_));
 sky130_fd_sc_hd__or3_1 _1398_ (.A(net65),
    .B(_0184_),
    .C(_0613_),
    .X(_0614_));
 sky130_fd_sc_hd__nor2_1 _1399_ (.A(_0198_),
    .B(_0588_),
    .Y(_0615_));
 sky130_fd_sc_hd__a21o_1 _1400_ (.A1(_0236_),
    .A2(_0615_),
    .B1(_0194_),
    .X(_0616_));
 sky130_fd_sc_hd__o211a_1 _1401_ (.A1(_0206_),
    .A2(_0207_),
    .B1(_0616_),
    .C1(_0668_),
    .X(_0617_));
 sky130_fd_sc_hd__o31ai_1 _1402_ (.A1(net28),
    .A2(_0066_),
    .A3(_0081_),
    .B1(_0189_),
    .Y(_0618_));
 sky130_fd_sc_hd__a32o_1 _1403_ (.A1(_0188_),
    .A2(_0231_),
    .A3(_0614_),
    .B1(_0618_),
    .B2(net6),
    .X(_0619_));
 sky130_fd_sc_hd__o311a_1 _1404_ (.A1(net38),
    .A2(_0617_),
    .A3(_0619_),
    .B1(_0679_),
    .C1(_0612_),
    .X(_0620_));
 sky130_fd_sc_hd__and3_1 _1405_ (.A(net32),
    .B(_0127_),
    .C(_0145_),
    .X(_0621_));
 sky130_fd_sc_hd__o21a_1 _1406_ (.A1(_0138_),
    .A2(_0621_),
    .B1(_0190_),
    .X(_0622_));
 sky130_fd_sc_hd__o21a_1 _1407_ (.A1(_0248_),
    .A2(_0622_),
    .B1(net6),
    .X(_0623_));
 sky130_fd_sc_hd__or3_1 _1408_ (.A(net17),
    .B(_0122_),
    .C(_0161_),
    .X(_0625_));
 sky130_fd_sc_hd__o311a_1 _1409_ (.A1(net21),
    .A2(_0124_),
    .A3(_0251_),
    .B1(_0253_),
    .C1(_0625_),
    .X(_0626_));
 sky130_fd_sc_hd__o21ai_1 _1410_ (.A1(_0111_),
    .A2(_0626_),
    .B1(net37),
    .Y(_0627_));
 sky130_fd_sc_hd__and3_1 _1411_ (.A(net19),
    .B(_0068_),
    .C(_0265_),
    .X(_0628_));
 sky130_fd_sc_hd__o21ba_1 _1412_ (.A1(_0262_),
    .A2(_0628_),
    .B1_N(_0210_),
    .X(_0629_));
 sky130_fd_sc_hd__o221a_1 _1413_ (.A1(_0241_),
    .A2(_0244_),
    .B1(_0245_),
    .B2(_0185_),
    .C1(_0196_),
    .X(_0630_));
 sky130_fd_sc_hd__nor3_1 _1414_ (.A(net4),
    .B(_0247_),
    .C(_0630_),
    .Y(_0631_));
 sky130_fd_sc_hd__or4_1 _1415_ (.A(_0623_),
    .B(_0627_),
    .C(_0629_),
    .D(_0631_),
    .X(_0632_));
 sky130_fd_sc_hd__a211o_1 _1416_ (.A1(net49),
    .A2(_0156_),
    .B1(_0104_),
    .C1(net28),
    .X(_0633_));
 sky130_fd_sc_hd__o221a_1 _1417_ (.A1(_0227_),
    .A2(_0229_),
    .B1(_0633_),
    .B2(_0216_),
    .C1(net6),
    .X(_0634_));
 sky130_fd_sc_hd__o2111a_1 _1418_ (.A1(net58),
    .A2(_0783_),
    .B1(net5),
    .C1(net25),
    .D1(net70),
    .X(_0636_));
 sky130_fd_sc_hd__or3_1 _1419_ (.A(net37),
    .B(_0235_),
    .C(_0636_),
    .X(_0637_));
 sky130_fd_sc_hd__and4_1 _1420_ (.A(net73),
    .B(_0038_),
    .C(_0054_),
    .D(_0116_),
    .X(_0638_));
 sky130_fd_sc_hd__a31o_1 _1421_ (.A1(net19),
    .A2(_0079_),
    .A3(_0217_),
    .B1(_0638_),
    .X(_0639_));
 sky130_fd_sc_hd__o21a_1 _1422_ (.A1(_0222_),
    .A2(_0639_),
    .B1(_0110_),
    .X(_0640_));
 sky130_fd_sc_hd__or4_1 _1423_ (.A(_0219_),
    .B(_0634_),
    .C(_0637_),
    .D(_0640_),
    .X(_0641_));
 sky130_fd_sc_hd__and3_1 _1424_ (.A(net36),
    .B(_0632_),
    .C(_0641_),
    .X(_0642_));
 sky130_fd_sc_hd__a21o_1 _1425_ (.A1(_0123_),
    .A2(_0196_),
    .B1(_0271_),
    .X(_0643_));
 sky130_fd_sc_hd__o2bb2a_1 _1426_ (.A1_N(net51),
    .A2_N(_0643_),
    .B1(_0613_),
    .B2(_0191_),
    .X(_0644_));
 sky130_fd_sc_hd__or4_1 _1427_ (.A(_0067_),
    .B(net10),
    .C(_0132_),
    .D(_0275_),
    .X(_0645_));
 sky130_fd_sc_hd__nand2_1 _1428_ (.A(_0278_),
    .B(_0645_),
    .Y(_0647_));
 sky130_fd_sc_hd__o211a_1 _1429_ (.A1(_0226_),
    .A2(_0644_),
    .B1(_0647_),
    .C1(_0286_),
    .X(_0648_));
 sky130_fd_sc_hd__o21ai_1 _1430_ (.A1(_0305_),
    .A2(_0648_),
    .B1(_0690_),
    .Y(_0649_));
 sky130_fd_sc_hd__o221a_1 _1431_ (.A1(_0159_),
    .A2(_0620_),
    .B1(_0642_),
    .B2(_0649_),
    .C1(_0646_),
    .X(_0650_));
 sky130_fd_sc_hd__o21a_1 _1432_ (.A1(_0391_),
    .A2(_0650_),
    .B1(\audio_player_inst.current_addr[13] ),
    .X(_0651_));
 sky130_fd_sc_hd__o211a_1 _1433_ (.A1(_0780_),
    .A2(_0502_),
    .B1(_0281_),
    .C1(net66),
    .X(_0652_));
 sky130_fd_sc_hd__and3_1 _1434_ (.A(_0112_),
    .B(net10),
    .C(_0200_),
    .X(_0653_));
 sky130_fd_sc_hd__o21ai_1 _1435_ (.A1(net32),
    .A2(_0067_),
    .B1(_0082_),
    .Y(_0654_));
 sky130_fd_sc_hd__nand2_1 _1436_ (.A(_0363_),
    .B(_0654_),
    .Y(_0655_));
 sky130_fd_sc_hd__a31o_1 _1437_ (.A1(net20),
    .A2(net5),
    .A3(_0655_),
    .B1(_0652_),
    .X(_0656_));
 sky130_fd_sc_hd__or4bb_1 _1438_ (.A(_0653_),
    .B(_0656_),
    .C_N(_0591_),
    .D_N(_0592_),
    .X(_0658_));
 sky130_fd_sc_hd__nand2_1 _1439_ (.A(net19),
    .B(_0431_),
    .Y(_0659_));
 sky130_fd_sc_hd__a21o_1 _1440_ (.A1(_0595_),
    .A2(_0659_),
    .B1(_0226_),
    .X(_0660_));
 sky130_fd_sc_hd__a2111o_1 _1441_ (.A1(net73),
    .A2(_0076_),
    .B1(_0067_),
    .C1(_0055_),
    .D1(net61),
    .X(_0661_));
 sky130_fd_sc_hd__nand2_1 _1442_ (.A(_0057_),
    .B(_0661_),
    .Y(_0662_));
 sky130_fd_sc_hd__mux2_1 _1443_ (.A0(_0138_),
    .A1(_0217_),
    .S(net60),
    .X(_0663_));
 sky130_fd_sc_hd__a31o_1 _1444_ (.A1(_0171_),
    .A2(_0602_),
    .A3(_0662_),
    .B1(\audio_player_inst.current_addr[8] ),
    .X(_0664_));
 sky130_fd_sc_hd__o211ai_1 _1445_ (.A1(net51),
    .A2(_0663_),
    .B1(_0598_),
    .C1(net41),
    .Y(_0665_));
 sky130_fd_sc_hd__a41oi_2 _1446_ (.A1(net34),
    .A2(_0660_),
    .A3(_0664_),
    .A4(_0665_),
    .B1(_0679_),
    .Y(_0666_));
 sky130_fd_sc_hd__a21bo_1 _1447_ (.A1(_0658_),
    .A2(_0666_),
    .B1_N(_0585_),
    .X(_0667_));
 sky130_fd_sc_hd__a21o_1 _1448_ (.A1(_0563_),
    .A2(_0667_),
    .B1(\audio_player_inst.current_addr[12] ),
    .X(_0669_));
 sky130_fd_sc_hd__a31o_1 _1449_ (.A1(net72),
    .A2(_0054_),
    .A3(_0116_),
    .B1(_0298_),
    .X(_0670_));
 sky130_fd_sc_hd__nand2_1 _1450_ (.A(_0082_),
    .B(_0275_),
    .Y(_0671_));
 sky130_fd_sc_hd__a31o_1 _1451_ (.A1(_0421_),
    .A2(_0670_),
    .A3(_0671_),
    .B1(_0226_),
    .X(_0672_));
 sky130_fd_sc_hd__or3_1 _1452_ (.A(net52),
    .B(net16),
    .C(_0154_),
    .X(_0673_));
 sky130_fd_sc_hd__o32a_1 _1453_ (.A1(net31),
    .A2(net51),
    .A3(_0341_),
    .B1(_0154_),
    .B2(net16),
    .X(_0674_));
 sky130_fd_sc_hd__or3b_1 _1454_ (.A(_0674_),
    .B(_0111_),
    .C_N(_0673_),
    .X(_0675_));
 sky130_fd_sc_hd__a311o_1 _1455_ (.A1(net31),
    .A2(_0054_),
    .A3(_0123_),
    .B1(net60),
    .C1(net22),
    .X(_0676_));
 sky130_fd_sc_hd__a41o_1 _1456_ (.A1(net26),
    .A2(_0149_),
    .A3(_0424_),
    .A4(_0676_),
    .B1(_0378_),
    .X(_0677_));
 sky130_fd_sc_hd__o2bb2a_1 _1457_ (.A1_N(net5),
    .A2_N(_0677_),
    .B1(_0427_),
    .B2(net22),
    .X(_0678_));
 sky130_fd_sc_hd__a31o_1 _1458_ (.A1(_0672_),
    .A2(_0675_),
    .A3(_0678_),
    .B1(net37),
    .X(_0680_));
 sky130_fd_sc_hd__o211a_1 _1459_ (.A1(_0115_),
    .A2(_0173_),
    .B1(_0186_),
    .C1(net29),
    .X(_0681_));
 sky130_fd_sc_hd__or3b_1 _1460_ (.A(_0681_),
    .B(_0098_),
    .C_N(_0174_),
    .X(_0682_));
 sky130_fd_sc_hd__a31o_1 _1461_ (.A1(net42),
    .A2(net79),
    .A3(_0077_),
    .B1(_0315_),
    .X(_0683_));
 sky130_fd_sc_hd__and3_1 _1462_ (.A(_0438_),
    .B(_0682_),
    .C(_0683_),
    .X(_0684_));
 sky130_fd_sc_hd__o21a_1 _1463_ (.A1(_0126_),
    .A2(_0240_),
    .B1(_0243_),
    .X(_0685_));
 sky130_fd_sc_hd__o32a_1 _1464_ (.A1(net27),
    .A2(_0096_),
    .A3(_0152_),
    .B1(_0434_),
    .B2(_0685_),
    .X(_0686_));
 sky130_fd_sc_hd__o211a_1 _1465_ (.A1(net23),
    .A2(_0686_),
    .B1(_0433_),
    .C1(_0432_),
    .X(_0687_));
 sky130_fd_sc_hd__o311a_1 _1466_ (.A1(net34),
    .A2(_0684_),
    .A3(_0687_),
    .B1(_0679_),
    .C1(_0680_),
    .X(_0688_));
 sky130_fd_sc_hd__o21ai_1 _1467_ (.A1(_0333_),
    .A2(_0334_),
    .B1(_0244_),
    .Y(_0689_));
 sky130_fd_sc_hd__o21ai_1 _1468_ (.A1(net25),
    .A2(_0689_),
    .B1(_0409_),
    .Y(_0691_));
 sky130_fd_sc_hd__a311oi_1 _1469_ (.A1(net71),
    .A2(_0785_),
    .A3(_0116_),
    .B1(net13),
    .C1(net21),
    .Y(_0692_));
 sky130_fd_sc_hd__a211o_1 _1470_ (.A1(net19),
    .A2(_0413_),
    .B1(_0692_),
    .C1(_0412_),
    .X(_0693_));
 sky130_fd_sc_hd__a31o_1 _1471_ (.A1(net71),
    .A2(_0785_),
    .A3(_0416_),
    .B1(_0418_),
    .X(_0694_));
 sky130_fd_sc_hd__a31o_1 _1472_ (.A1(_0691_),
    .A2(_0693_),
    .A3(_0694_),
    .B1(net37),
    .X(_0695_));
 sky130_fd_sc_hd__o32a_1 _1473_ (.A1(_0091_),
    .A2(_0160_),
    .A3(_0245_),
    .B1(_0092_),
    .B2(net17),
    .X(_0696_));
 sky130_fd_sc_hd__a21o_1 _1474_ (.A1(_0401_),
    .A2(_0696_),
    .B1(_0232_),
    .X(_0697_));
 sky130_fd_sc_hd__or4_1 _1475_ (.A(_0076_),
    .B(_0132_),
    .C(_0214_),
    .D(_0282_),
    .X(_0698_));
 sky130_fd_sc_hd__a41o_1 _1476_ (.A1(_0398_),
    .A2(_0427_),
    .A3(_0697_),
    .A4(_0698_),
    .B1(net34),
    .X(_0699_));
 sky130_fd_sc_hd__a311o_1 _1477_ (.A1(_0407_),
    .A2(_0695_),
    .A3(_0699_),
    .B1(_0688_),
    .C1(\audio_player_inst.current_addr[11] ),
    .X(_0700_));
 sky130_fd_sc_hd__o21ai_1 _1478_ (.A1(net69),
    .A2(_0341_),
    .B1(_0327_),
    .Y(_0702_));
 sky130_fd_sc_hd__a21oi_1 _1479_ (.A1(_0131_),
    .A2(_0702_),
    .B1(net50),
    .Y(_0703_));
 sky130_fd_sc_hd__o21ai_1 _1480_ (.A1(_0251_),
    .A2(_0472_),
    .B1(_0351_),
    .Y(_0704_));
 sky130_fd_sc_hd__o41a_1 _1481_ (.A1(_0712_),
    .A2(net49),
    .A3(_0782_),
    .A4(net15),
    .B1(_0704_),
    .X(_0705_));
 sky130_fd_sc_hd__o22ai_1 _1482_ (.A1(net70),
    .A2(_0052_),
    .B1(_0120_),
    .B2(_0333_),
    .Y(_0706_));
 sky130_fd_sc_hd__or4_1 _1483_ (.A(net17),
    .B(_0046_),
    .C(net4),
    .D(_0706_),
    .X(_0707_));
 sky130_fd_sc_hd__o32a_1 _1484_ (.A1(_0111_),
    .A2(_0477_),
    .A3(_0703_),
    .B1(_0705_),
    .B2(_0210_),
    .X(_0708_));
 sky130_fd_sc_hd__o221a_1 _1485_ (.A1(net8),
    .A2(_0191_),
    .B1(_0483_),
    .B2(_0078_),
    .C1(_0482_),
    .X(_0709_));
 sky130_fd_sc_hd__o21ba_1 _1486_ (.A1(_0210_),
    .A2(_0709_),
    .B1_N(_0491_),
    .X(_0710_));
 sky130_fd_sc_hd__a31o_1 _1487_ (.A1(_0471_),
    .A2(_0707_),
    .A3(_0708_),
    .B1(_0710_),
    .X(_0711_));
 sky130_fd_sc_hd__or2_1 _1488_ (.A(_0382_),
    .B(_0711_),
    .X(_0713_));
 sky130_fd_sc_hd__nand4_1 _1489_ (.A(\audio_player_inst.current_addr[12] ),
    .B(_0467_),
    .C(_0700_),
    .D(_0713_),
    .Y(_0714_));
 sky130_fd_sc_hd__a311oi_1 _1490_ (.A1(_0635_),
    .A2(_0669_),
    .A3(_0714_),
    .B1(\audio_player_inst.pwm_counter[0] ),
    .C1(_0651_),
    .Y(_0715_));
 sky130_fd_sc_hd__or3_1 _1491_ (.A(\audio_player_inst.pwm_counter[1] ),
    .B(\audio_player_inst.pwm_counter[2] ),
    .C(\audio_player_inst.pwm_counter[3] ),
    .X(_0716_));
 sky130_fd_sc_hd__a31o_1 _1492_ (.A1(_0392_),
    .A2(_0607_),
    .A3(_0716_),
    .B1(net116),
    .X(_0717_));
 sky130_fd_sc_hd__o21ba_1 _1493_ (.A1(_0608_),
    .A2(_0715_),
    .B1_N(_0717_),
    .X(_0000_));
 sky130_fd_sc_hd__or4_1 _1494_ (.A(\audio_player_inst.sample_counter[3] ),
    .B(\audio_player_inst.sample_counter[2] ),
    .C(\audio_player_inst.sample_counter[5] ),
    .D(\audio_player_inst.sample_counter[4] ),
    .X(_0718_));
 sky130_fd_sc_hd__o211a_1 _1495_ (.A1(\audio_player_inst.sample_counter[1] ),
    .A2(_0718_),
    .B1(\audio_player_inst.sample_counter[6] ),
    .C1(\audio_player_inst.sample_counter[7] ),
    .X(_0719_));
 sky130_fd_sc_hd__or3_1 _1496_ (.A(\audio_player_inst.sample_counter[11] ),
    .B(\audio_player_inst.sample_counter[10] ),
    .C(net115),
    .X(_0720_));
 sky130_fd_sc_hd__nor4_2 _1497_ (.A(\audio_player_inst.sample_counter[9] ),
    .B(\audio_player_inst.sample_counter[8] ),
    .C(_0719_),
    .D(_0720_),
    .Y(_0721_));
 sky130_fd_sc_hd__o21ba_1 _1498_ (.A1(\audio_player_inst.sample_tick ),
    .A2(net1),
    .B1_N(_0721_),
    .X(_0005_));
 sky130_fd_sc_hd__mux2_1 _1499_ (.A0(net3),
    .A1(net116),
    .S(\audio_player_inst.sample_counter[0] ),
    .X(_0006_));
 sky130_fd_sc_hd__or2_1 _1500_ (.A(\audio_player_inst.sample_counter[1] ),
    .B(\audio_player_inst.sample_counter[0] ),
    .X(_0723_));
 sky130_fd_sc_hd__nand2_1 _1501_ (.A(\audio_player_inst.sample_counter[1] ),
    .B(\audio_player_inst.sample_counter[0] ),
    .Y(_0724_));
 sky130_fd_sc_hd__a32o_1 _1502_ (.A1(net3),
    .A2(_0723_),
    .A3(_0724_),
    .B1(net115),
    .B2(\audio_player_inst.sample_counter[1] ),
    .X(_0007_));
 sky130_fd_sc_hd__a21o_1 _1503_ (.A1(\audio_player_inst.sample_counter[1] ),
    .A2(\audio_player_inst.sample_counter[0] ),
    .B1(\audio_player_inst.sample_counter[2] ),
    .X(_0725_));
 sky130_fd_sc_hd__nand3_1 _1504_ (.A(\audio_player_inst.sample_counter[1] ),
    .B(\audio_player_inst.sample_counter[0] ),
    .C(\audio_player_inst.sample_counter[2] ),
    .Y(_0726_));
 sky130_fd_sc_hd__a32o_1 _1505_ (.A1(net3),
    .A2(_0725_),
    .A3(_0726_),
    .B1(net115),
    .B2(\audio_player_inst.sample_counter[2] ),
    .X(_0008_));
 sky130_fd_sc_hd__a31o_1 _1506_ (.A1(\audio_player_inst.sample_counter[1] ),
    .A2(\audio_player_inst.sample_counter[0] ),
    .A3(\audio_player_inst.sample_counter[2] ),
    .B1(\audio_player_inst.sample_counter[3] ),
    .X(_0727_));
 sky130_fd_sc_hd__and4_1 _1507_ (.A(\audio_player_inst.sample_counter[1] ),
    .B(\audio_player_inst.sample_counter[0] ),
    .C(\audio_player_inst.sample_counter[3] ),
    .D(\audio_player_inst.sample_counter[2] ),
    .X(_0728_));
 sky130_fd_sc_hd__inv_2 _1508_ (.A(_0728_),
    .Y(_0730_));
 sky130_fd_sc_hd__a32o_1 _1509_ (.A1(net3),
    .A2(_0727_),
    .A3(_0730_),
    .B1(net115),
    .B2(\audio_player_inst.sample_counter[3] ),
    .X(_0009_));
 sky130_fd_sc_hd__or2_1 _1510_ (.A(\audio_player_inst.sample_counter[4] ),
    .B(_0728_),
    .X(_0731_));
 sky130_fd_sc_hd__nand2_1 _1511_ (.A(\audio_player_inst.sample_counter[4] ),
    .B(_0728_),
    .Y(_0732_));
 sky130_fd_sc_hd__a32o_1 _1512_ (.A1(net3),
    .A2(_0731_),
    .A3(_0732_),
    .B1(net115),
    .B2(\audio_player_inst.sample_counter[4] ),
    .X(_0010_));
 sky130_fd_sc_hd__and3_1 _1513_ (.A(\audio_player_inst.sample_counter[5] ),
    .B(\audio_player_inst.sample_counter[4] ),
    .C(_0728_),
    .X(_0733_));
 sky130_fd_sc_hd__inv_2 _1514_ (.A(_0733_),
    .Y(_0734_));
 sky130_fd_sc_hd__a21o_1 _1515_ (.A1(\audio_player_inst.sample_counter[4] ),
    .A2(_0728_),
    .B1(\audio_player_inst.sample_counter[5] ),
    .X(_0735_));
 sky130_fd_sc_hd__a32o_1 _1516_ (.A1(net3),
    .A2(_0734_),
    .A3(_0735_),
    .B1(net115),
    .B2(\audio_player_inst.sample_counter[5] ),
    .X(_0011_));
 sky130_fd_sc_hd__nand2_1 _1517_ (.A(\audio_player_inst.sample_counter[6] ),
    .B(_0733_),
    .Y(_0736_));
 sky130_fd_sc_hd__or2_1 _1518_ (.A(\audio_player_inst.sample_counter[6] ),
    .B(_0733_),
    .X(_0738_));
 sky130_fd_sc_hd__a32o_1 _1519_ (.A1(_0721_),
    .A2(_0736_),
    .A3(_0738_),
    .B1(net115),
    .B2(\audio_player_inst.sample_counter[6] ),
    .X(_0012_));
 sky130_fd_sc_hd__o21a_1 _1520_ (.A1(net116),
    .A2(_0721_),
    .B1(\audio_player_inst.sample_counter[7] ),
    .X(_0739_));
 sky130_fd_sc_hd__a31o_1 _1521_ (.A1(\audio_player_inst.sample_counter[6] ),
    .A2(_0721_),
    .A3(_0733_),
    .B1(_0739_),
    .X(_0013_));
 sky130_fd_sc_hd__and2_1 _1522_ (.A(\audio_player_inst.sample_counter[8] ),
    .B(net115),
    .X(_0014_));
 sky130_fd_sc_hd__and2_1 _1523_ (.A(\audio_player_inst.sample_counter[9] ),
    .B(net115),
    .X(_0015_));
 sky130_fd_sc_hd__and2_1 _1524_ (.A(\audio_player_inst.sample_counter[10] ),
    .B(net115),
    .X(_0016_));
 sky130_fd_sc_hd__and2_1 _1525_ (.A(\audio_player_inst.sample_counter[11] ),
    .B(net116),
    .X(_0017_));
 sky130_fd_sc_hd__and4_1 _1526_ (.A(\audio_player_inst.current_addr[12] ),
    .B(\audio_player_inst.current_addr[15] ),
    .C(net38),
    .D(net42),
    .X(_0740_));
 sky130_fd_sc_hd__and4bb_1 _1527_ (.A_N(\audio_player_inst.current_addr[14] ),
    .B_N(_0382_),
    .C(_0740_),
    .D(\audio_player_inst.current_addr[13] ),
    .X(_0741_));
 sky130_fd_sc_hd__and3_1 _1528_ (.A(\audio_player_inst.current_addr[13] ),
    .B(\audio_player_inst.current_addr[12] ),
    .C(_0367_),
    .X(_0743_));
 sky130_fd_sc_hd__or2_1 _1529_ (.A(\audio_player_inst.current_addr[14] ),
    .B(_0743_),
    .X(_0744_));
 sky130_fd_sc_hd__a22o_1 _1530_ (.A1(net47),
    .A2(_0741_),
    .B1(_0744_),
    .B2(\audio_player_inst.current_addr[15] ),
    .X(_0745_));
 sky130_fd_sc_hd__and2_2 _1531_ (.A(\audio_player_inst.sample_tick ),
    .B(net1),
    .X(_0746_));
 sky130_fd_sc_hd__nand2_2 _1532_ (.A(\audio_player_inst.sample_tick ),
    .B(net1),
    .Y(_0747_));
 sky130_fd_sc_hd__nor2_1 _1533_ (.A(_0745_),
    .B(_0747_),
    .Y(_0748_));
 sky130_fd_sc_hd__mux2_1 _1534_ (.A0(_0748_),
    .A1(_0747_),
    .S(net114),
    .X(_0018_));
 sky130_fd_sc_hd__a31o_2 _1535_ (.A1(_0057_),
    .A2(_0207_),
    .A3(_0741_),
    .B1(_0745_),
    .X(_0749_));
 sky130_fd_sc_hd__nor2_2 _1536_ (.A(_0747_),
    .B(_0749_),
    .Y(_0750_));
 sky130_fd_sc_hd__a32o_1 _1537_ (.A1(_0065_),
    .A2(_0088_),
    .A3(_0750_),
    .B1(_0747_),
    .B2(net106),
    .X(_0019_));
 sky130_fd_sc_hd__a22o_1 _1538_ (.A1(net98),
    .A2(_0747_),
    .B1(_0750_),
    .B2(_0259_),
    .X(_0020_));
 sky130_fd_sc_hd__nand2_1 _1539_ (.A(net90),
    .B(_0747_),
    .Y(_0752_));
 sky130_fd_sc_hd__o31ai_1 _1540_ (.A1(_0577_),
    .A2(_0747_),
    .A3(_0749_),
    .B1(_0752_),
    .Y(_0021_));
 sky130_fd_sc_hd__o21ai_1 _1541_ (.A1(_0069_),
    .A2(_0745_),
    .B1(_0746_),
    .Y(_0753_));
 sky130_fd_sc_hd__nor2_1 _1542_ (.A(_0068_),
    .B(_0747_),
    .Y(_0754_));
 sky130_fd_sc_hd__o21a_1 _1543_ (.A1(net77),
    .A2(_0754_),
    .B1(_0753_),
    .X(_0022_));
 sky130_fd_sc_hd__nor2_1 _1544_ (.A(_0132_),
    .B(_0749_),
    .Y(_0755_));
 sky130_fd_sc_hd__a22o_1 _1545_ (.A1(net66),
    .A2(_0753_),
    .B1(_0754_),
    .B2(_0755_),
    .X(_0023_));
 sky130_fd_sc_hd__a21o_1 _1546_ (.A1(net20),
    .A2(_0069_),
    .B1(_0745_),
    .X(_0756_));
 sky130_fd_sc_hd__nand2_1 _1547_ (.A(_0746_),
    .B(_0756_),
    .Y(_0757_));
 sky130_fd_sc_hd__and3_1 _1548_ (.A(net16),
    .B(_0067_),
    .C(_0746_),
    .X(_0759_));
 sky130_fd_sc_hd__o21a_1 _1549_ (.A1(net56),
    .A2(_0759_),
    .B1(_0757_),
    .X(_0024_));
 sky130_fd_sc_hd__a32o_1 _1550_ (.A1(_0057_),
    .A2(_0207_),
    .A3(_0750_),
    .B1(_0757_),
    .B2(net47),
    .X(_0025_));
 sky130_fd_sc_hd__and3_1 _1551_ (.A(net20),
    .B(_0069_),
    .C(_0225_),
    .X(_0760_));
 sky130_fd_sc_hd__o21ai_1 _1552_ (.A1(_0749_),
    .A2(_0760_),
    .B1(_0746_),
    .Y(_0761_));
 sky130_fd_sc_hd__a21o_1 _1553_ (.A1(_0085_),
    .A2(_0759_),
    .B1(net43),
    .X(_0762_));
 sky130_fd_sc_hd__and2_1 _1554_ (.A(_0761_),
    .B(_0762_),
    .X(_0026_));
 sky130_fd_sc_hd__and2_1 _1555_ (.A(net39),
    .B(_0761_),
    .X(_0763_));
 sky130_fd_sc_hd__a31o_1 _1556_ (.A1(net35),
    .A2(_0750_),
    .A3(_0760_),
    .B1(_0763_),
    .X(_0027_));
 sky130_fd_sc_hd__and2_1 _1557_ (.A(net38),
    .B(_0760_),
    .X(_0764_));
 sky130_fd_sc_hd__a21o_1 _1558_ (.A1(net36),
    .A2(_0764_),
    .B1(_0749_),
    .X(_0765_));
 sky130_fd_sc_hd__nand2_1 _1559_ (.A(_0746_),
    .B(_0765_),
    .Y(_0766_));
 sky130_fd_sc_hd__and3_1 _1560_ (.A(net38),
    .B(_0746_),
    .C(_0760_),
    .X(_0767_));
 sky130_fd_sc_hd__o21a_1 _1561_ (.A1(net36),
    .A2(_0767_),
    .B1(_0766_),
    .X(_0028_));
 sky130_fd_sc_hd__and3_1 _1562_ (.A(\audio_player_inst.current_addr[10] ),
    .B(_0750_),
    .C(_0764_),
    .X(_0768_));
 sky130_fd_sc_hd__mux2_1 _1563_ (.A0(_0766_),
    .A1(_0768_),
    .S(_0690_),
    .X(_0029_));
 sky130_fd_sc_hd__a21o_1 _1564_ (.A1(_0367_),
    .A2(_0767_),
    .B1(\audio_player_inst.current_addr[12] ),
    .X(_0769_));
 sky130_fd_sc_hd__and3_1 _1565_ (.A(\audio_player_inst.current_addr[12] ),
    .B(_0367_),
    .C(_0764_),
    .X(_0770_));
 sky130_fd_sc_hd__o21ai_1 _1566_ (.A1(_0749_),
    .A2(_0770_),
    .B1(_0746_),
    .Y(_0771_));
 sky130_fd_sc_hd__and2_1 _1567_ (.A(_0769_),
    .B(_0771_),
    .X(_0030_));
 sky130_fd_sc_hd__and2_1 _1568_ (.A(\audio_player_inst.current_addr[13] ),
    .B(_0771_),
    .X(_0773_));
 sky130_fd_sc_hd__a31o_1 _1569_ (.A1(_0635_),
    .A2(_0750_),
    .A3(_0770_),
    .B1(_0773_),
    .X(_0031_));
 sky130_fd_sc_hd__and3_1 _1570_ (.A(\audio_player_inst.current_addr[14] ),
    .B(_0743_),
    .C(_0764_),
    .X(_0774_));
 sky130_fd_sc_hd__o21ai_1 _1571_ (.A1(_0749_),
    .A2(_0774_),
    .B1(_0746_),
    .Y(_0775_));
 sky130_fd_sc_hd__o211a_1 _1572_ (.A1(\audio_player_inst.current_addr[14] ),
    .A2(_0767_),
    .B1(_0775_),
    .C1(_0744_),
    .X(_0032_));
 sky130_fd_sc_hd__a22o_1 _1573_ (.A1(_0750_),
    .A2(_0774_),
    .B1(_0775_),
    .B2(\audio_player_inst.current_addr[15] ),
    .X(_0033_));
 sky130_fd_sc_hd__dfrtp_1 _1574_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0005_),
    .RESET_B(net117),
    .Q(\audio_player_inst.sample_tick ));
 sky130_fd_sc_hd__dfrtp_4 _1575_ (.CLK(clknet_2_1__leaf_clk),
    .D(\audio_player_inst.audio_out ),
    .RESET_B(net120),
    .Q(uo_out[0]));
 sky130_fd_sc_hd__dfrtp_2 _1576_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0006_),
    .RESET_B(net118),
    .Q(\audio_player_inst.sample_counter[0] ));
 sky130_fd_sc_hd__dfrtp_2 _1577_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0007_),
    .RESET_B(net118),
    .Q(\audio_player_inst.sample_counter[1] ));
 sky130_fd_sc_hd__dfrtp_1 _1578_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0008_),
    .RESET_B(net118),
    .Q(\audio_player_inst.sample_counter[2] ));
 sky130_fd_sc_hd__dfrtp_1 _1579_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0009_),
    .RESET_B(net118),
    .Q(\audio_player_inst.sample_counter[3] ));
 sky130_fd_sc_hd__dfrtp_1 _1580_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0010_),
    .RESET_B(net118),
    .Q(\audio_player_inst.sample_counter[4] ));
 sky130_fd_sc_hd__dfrtp_1 _1581_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0011_),
    .RESET_B(net119),
    .Q(\audio_player_inst.sample_counter[5] ));
 sky130_fd_sc_hd__dfrtp_1 _1582_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0012_),
    .RESET_B(net118),
    .Q(\audio_player_inst.sample_counter[6] ));
 sky130_fd_sc_hd__dfrtp_1 _1583_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0013_),
    .RESET_B(net118),
    .Q(\audio_player_inst.sample_counter[7] ));
 sky130_fd_sc_hd__dfrtp_1 _1584_ (.CLK(clknet_2_1__leaf_clk),
    .D(_0014_),
    .RESET_B(net117),
    .Q(\audio_player_inst.sample_counter[8] ));
 sky130_fd_sc_hd__dfrtp_1 _1585_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0015_),
    .RESET_B(net117),
    .Q(\audio_player_inst.sample_counter[9] ));
 sky130_fd_sc_hd__dfrtp_1 _1586_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0016_),
    .RESET_B(net117),
    .Q(\audio_player_inst.sample_counter[10] ));
 sky130_fd_sc_hd__dfrtp_1 _1587_ (.CLK(clknet_2_1__leaf_clk),
    .D(_0017_),
    .RESET_B(net117),
    .Q(\audio_player_inst.sample_counter[11] ));
 sky130_fd_sc_hd__dfrtp_1 _1588_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0018_),
    .RESET_B(net118),
    .Q(\audio_player_inst.current_addr[0] ));
 sky130_fd_sc_hd__dfrtp_1 _1589_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0019_),
    .RESET_B(net118),
    .Q(\audio_player_inst.current_addr[1] ));
 sky130_fd_sc_hd__dfrtp_1 _1590_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0020_),
    .RESET_B(net118),
    .Q(\audio_player_inst.current_addr[2] ));
 sky130_fd_sc_hd__dfrtp_1 _1591_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0021_),
    .RESET_B(net119),
    .Q(\audio_player_inst.current_addr[3] ));
 sky130_fd_sc_hd__dfrtp_1 _1592_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0022_),
    .RESET_B(net119),
    .Q(\audio_player_inst.current_addr[4] ));
 sky130_fd_sc_hd__dfrtp_1 _1593_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0023_),
    .RESET_B(net119),
    .Q(\audio_player_inst.current_addr[5] ));
 sky130_fd_sc_hd__dfrtp_1 _1594_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0024_),
    .RESET_B(net117),
    .Q(\audio_player_inst.current_addr[6] ));
 sky130_fd_sc_hd__dfrtp_1 _1595_ (.CLK(clknet_2_2__leaf_clk),
    .D(_0025_),
    .RESET_B(net117),
    .Q(\audio_player_inst.current_addr[7] ));
 sky130_fd_sc_hd__dfrtp_2 _1596_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0026_),
    .RESET_B(net117),
    .Q(\audio_player_inst.current_addr[8] ));
 sky130_fd_sc_hd__dfrtp_4 _1597_ (.CLK(clknet_2_3__leaf_clk),
    .D(_0027_),
    .RESET_B(net119),
    .Q(\audio_player_inst.current_addr[9] ));
 sky130_fd_sc_hd__dfrtp_1 _1598_ (.CLK(clknet_2_1__leaf_clk),
    .D(_0028_),
    .RESET_B(net120),
    .Q(\audio_player_inst.current_addr[10] ));
 sky130_fd_sc_hd__dfrtp_4 _1599_ (.CLK(clknet_2_0__leaf_clk),
    .D(_0029_),
    .RESET_B(net120),
    .Q(\audio_player_inst.current_addr[11] ));
 sky130_fd_sc_hd__dfrtp_4 _1600_ (.CLK(clknet_2_1__leaf_clk),
    .D(_0030_),
    .RESET_B(net120),
    .Q(\audio_player_inst.current_addr[12] ));
 sky130_fd_sc_hd__dfrtp_2 _1601_ (.CLK(clknet_2_1__leaf_clk),
    .D(_0031_),
    .RESET_B(net120),
    .Q(\audio_player_inst.current_addr[13] ));
 sky130_fd_sc_hd__dfrtp_1 _1602_ (.CLK(clknet_2_1__leaf_clk),
    .D(_0032_),
    .RESET_B(net117),
    .Q(\audio_player_inst.current_addr[14] ));
 sky130_fd_sc_hd__dfrtp_1 _1603_ (.CLK(clknet_2_1__leaf_clk),
    .D(_0033_),
    .RESET_B(net117),
    .Q(\audio_player_inst.current_addr[15] ));
 sky130_fd_sc_hd__dfrtp_2 _1604_ (.CLK(clknet_2_0__leaf_clk),
    .D(_0001_),
    .RESET_B(net120),
    .Q(\audio_player_inst.pwm_counter[0] ));
 sky130_fd_sc_hd__dfrtp_1 _1605_ (.CLK(clknet_2_0__leaf_clk),
    .D(_0002_),
    .RESET_B(net120),
    .Q(\audio_player_inst.pwm_counter[1] ));
 sky130_fd_sc_hd__dfrtp_1 _1606_ (.CLK(clknet_2_0__leaf_clk),
    .D(_0003_),
    .RESET_B(net120),
    .Q(\audio_player_inst.pwm_counter[2] ));
 sky130_fd_sc_hd__dfrtp_1 _1607_ (.CLK(clknet_2_0__leaf_clk),
    .D(_0004_),
    .RESET_B(net120),
    .Q(\audio_player_inst.pwm_counter[3] ));
 sky130_fd_sc_hd__dfrtp_1 _1608_ (.CLK(clknet_2_0__leaf_clk),
    .D(_0000_),
    .RESET_B(net120),
    .Q(\audio_player_inst.audio_out ));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_122 (.LO(net122));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_123 (.LO(net123));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_124 (.LO(net124));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_125 (.LO(net125));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_126 (.LO(net126));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_127 (.LO(net127));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_128 (.LO(net128));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_129 (.LO(net129));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_130 (.LO(net130));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_131 (.LO(net131));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_132 (.LO(net132));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_133 (.LO(net133));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_134 (.LO(net134));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_135 (.LO(net135));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_136 (.LO(net136));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_137 (.LO(net137));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_138 (.LO(net138));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_139 (.LO(net139));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_140 (.LO(net140));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_141 (.LO(net141));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_142 (.LO(net142));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_143 (.LO(net143));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
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
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_25_Right_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_26_Right_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_27_Right_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_28_Right_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_29_Right_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_30_Right_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_31_Right_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_32_Right_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_33_Right_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_34_Right_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_35_Right_35 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_36_Right_36 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_37_Right_37 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_38_Right_38 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_39 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_40 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_41 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_42 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_43 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_44 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_45 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_46 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_47 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_48 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_49 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_50 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_51 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_52 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_53 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_54 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_55 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_56 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Left_57 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Left_58 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Left_59 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Left_60 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Left_61 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_23_Left_62 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_24_Left_63 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_25_Left_64 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_26_Left_65 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_27_Left_66 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_28_Left_67 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_29_Left_68 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_30_Left_69 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_31_Left_70 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_32_Left_71 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_33_Left_72 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_34_Left_73 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_35_Left_74 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_36_Left_75 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_37_Left_76 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_38_Left_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_97 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_98 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_99 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_101 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_102 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_103 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_104 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_105 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_106 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_107 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_108 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_109 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_110 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_111 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_112 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_113 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_114 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_115 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_116 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_117 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_118 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_119 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_120 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_121 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_122 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_123 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_124 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_125 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_126 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_127 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_128 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_129 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_130 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_131 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_132 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_133 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_134 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_135 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_136 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_137 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_138 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_139 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_140 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_141 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_142 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_143 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_144 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_145 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_146 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_147 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_148 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_149 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_150 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_151 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_152 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_153 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_154 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_155 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_156 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_157 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_158 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_159 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_160 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_161 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_162 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_163 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_164 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_165 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_166 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_167 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_168 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_169 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_170 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_171 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_172 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_173 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_174 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_175 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_176 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_177 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_178 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_179 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_180 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_181 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_182 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_183 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_184 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_185 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_186 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_187 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_188 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_189 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_190 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_191 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_192 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_193 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_194 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_195 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_196 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_197 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_198 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_199 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_200 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_201 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_202 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_203 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_204 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_205 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_206 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_207 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_208 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_209 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_210 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_211 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_212 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_213 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_214 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_215 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_216 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_217 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_218 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_219 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_220 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_221 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_222 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_223 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_224 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_225 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_226 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_227 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_228 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_229 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_230 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_231 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_232 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_233 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_234 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_235 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_236 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_237 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_238 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_239 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_240 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_241 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_242 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_243 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_244 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_245 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_246 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_247 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_248 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_249 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_250 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_251 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_252 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_253 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_254 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_255 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_256 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_257 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_258 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_259 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_260 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_261 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_262 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_263 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_264 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_265 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_266 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_267 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_268 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_269 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_270 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_271 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_272 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_273 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_274 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_275 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_276 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_277 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_278 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_279 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_280 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_281 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_282 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_283 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_284 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_285 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_286 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_37_287 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_37_288 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_37_289 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_37_290 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_37_291 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_292 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_293 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_294 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_295 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_296 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_297 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_298 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_299 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_300 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_301 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_302 ();
 sky130_fd_sc_hd__clkbuf_2 input1 (.A(ena),
    .X(net1));
 sky130_fd_sc_hd__buf_1 input2 (.A(rst_n),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_2 max_cap3 (.A(_0721_),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_4 fanout4 (.A(_0232_),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_4 fanout5 (.A(_0231_),
    .X(net5));
 sky130_fd_sc_hd__clkbuf_4 fanout6 (.A(_0225_),
    .X(net6));
 sky130_fd_sc_hd__clkbuf_1 max_cap7 (.A(_0242_),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_2 max_cap8 (.A(_0186_),
    .X(net8));
 sky130_fd_sc_hd__buf_1 max_cap9 (.A(_0146_),
    .X(net9));
 sky130_fd_sc_hd__buf_2 wire10 (.A(_0122_),
    .X(net10));
 sky130_fd_sc_hd__clkbuf_2 max_cap11 (.A(_0115_),
    .X(net11));
 sky130_fd_sc_hd__clkbuf_4 fanout12 (.A(_0098_),
    .X(net12));
 sky130_fd_sc_hd__clkbuf_2 max_cap13 (.A(_0089_),
    .X(net13));
 sky130_fd_sc_hd__clkbuf_4 fanout14 (.A(_0086_),
    .X(net14));
 sky130_fd_sc_hd__clkbuf_4 fanout15 (.A(_0051_),
    .X(net15));
 sky130_fd_sc_hd__clkbuf_4 fanout16 (.A(_0050_),
    .X(net16));
 sky130_fd_sc_hd__buf_2 fanout17 (.A(_0045_),
    .X(net17));
 sky130_fd_sc_hd__clkbuf_2 fanout18 (.A(_0045_),
    .X(net18));
 sky130_fd_sc_hd__clkbuf_4 fanout19 (.A(_0044_),
    .X(net19));
 sky130_fd_sc_hd__dlymetal6s2s_1 fanout20 (.A(_0044_),
    .X(net20));
 sky130_fd_sc_hd__clkbuf_4 fanout21 (.A(_0039_),
    .X(net21));
 sky130_fd_sc_hd__buf_4 fanout22 (.A(_0780_),
    .X(net22));
 sky130_fd_sc_hd__clkbuf_4 fanout23 (.A(_0751_),
    .X(net23));
 sky130_fd_sc_hd__buf_2 fanout24 (.A(_0751_),
    .X(net24));
 sky130_fd_sc_hd__clkbuf_4 fanout25 (.A(net27),
    .X(net25));
 sky130_fd_sc_hd__clkbuf_4 fanout26 (.A(net27),
    .X(net26));
 sky130_fd_sc_hd__clkbuf_4 fanout27 (.A(_0742_),
    .X(net27));
 sky130_fd_sc_hd__clkbuf_4 fanout28 (.A(_0737_),
    .X(net28));
 sky130_fd_sc_hd__buf_2 fanout29 (.A(net30),
    .X(net29));
 sky130_fd_sc_hd__clkbuf_4 fanout30 (.A(_0737_),
    .X(net30));
 sky130_fd_sc_hd__clkbuf_4 fanout31 (.A(net33),
    .X(net31));
 sky130_fd_sc_hd__clkbuf_4 fanout32 (.A(net33),
    .X(net32));
 sky130_fd_sc_hd__buf_2 fanout33 (.A(_0729_),
    .X(net33));
 sky130_fd_sc_hd__clkbuf_4 fanout34 (.A(net35),
    .X(net34));
 sky130_fd_sc_hd__buf_2 fanout35 (.A(_0657_),
    .X(net35));
 sky130_fd_sc_hd__clkbuf_4 fanout36 (.A(\audio_player_inst.current_addr[10] ),
    .X(net36));
 sky130_fd_sc_hd__clkbuf_4 fanout37 (.A(\audio_player_inst.current_addr[9] ),
    .X(net37));
 sky130_fd_sc_hd__buf_2 fanout38 (.A(net39),
    .X(net38));
 sky130_fd_sc_hd__clkbuf_4 fanout39 (.A(\audio_player_inst.current_addr[9] ),
    .X(net39));
 sky130_fd_sc_hd__clkbuf_4 fanout40 (.A(net41),
    .X(net40));
 sky130_fd_sc_hd__clkbuf_4 fanout41 (.A(\audio_player_inst.current_addr[8] ),
    .X(net41));
 sky130_fd_sc_hd__clkbuf_4 fanout42 (.A(\audio_player_inst.current_addr[8] ),
    .X(net42));
 sky130_fd_sc_hd__clkbuf_2 fanout43 (.A(\audio_player_inst.current_addr[8] ),
    .X(net43));
 sky130_fd_sc_hd__clkbuf_4 fanout44 (.A(net48),
    .X(net44));
 sky130_fd_sc_hd__buf_2 fanout45 (.A(net46),
    .X(net45));
 sky130_fd_sc_hd__buf_2 fanout46 (.A(net48),
    .X(net46));
 sky130_fd_sc_hd__clkbuf_4 fanout47 (.A(net48),
    .X(net47));
 sky130_fd_sc_hd__clkbuf_4 fanout48 (.A(\audio_player_inst.current_addr[7] ),
    .X(net48));
 sky130_fd_sc_hd__clkbuf_4 fanout49 (.A(net50),
    .X(net49));
 sky130_fd_sc_hd__clkbuf_4 fanout50 (.A(net57),
    .X(net50));
 sky130_fd_sc_hd__buf_2 fanout51 (.A(net57),
    .X(net51));
 sky130_fd_sc_hd__clkbuf_2 fanout52 (.A(net57),
    .X(net52));
 sky130_fd_sc_hd__buf_2 fanout53 (.A(net54),
    .X(net53));
 sky130_fd_sc_hd__buf_2 fanout54 (.A(net57),
    .X(net54));
 sky130_fd_sc_hd__clkbuf_4 fanout55 (.A(net57),
    .X(net55));
 sky130_fd_sc_hd__buf_2 fanout56 (.A(net57),
    .X(net56));
 sky130_fd_sc_hd__buf_2 fanout57 (.A(\audio_player_inst.current_addr[6] ),
    .X(net57));
 sky130_fd_sc_hd__clkbuf_4 fanout58 (.A(net63),
    .X(net58));
 sky130_fd_sc_hd__buf_2 fanout59 (.A(net60),
    .X(net59));
 sky130_fd_sc_hd__clkbuf_2 fanout60 (.A(net63),
    .X(net60));
 sky130_fd_sc_hd__clkbuf_4 fanout61 (.A(net63),
    .X(net61));
 sky130_fd_sc_hd__clkbuf_2 fanout62 (.A(net63),
    .X(net62));
 sky130_fd_sc_hd__buf_2 fanout63 (.A(\audio_player_inst.current_addr[5] ),
    .X(net63));
 sky130_fd_sc_hd__buf_2 fanout64 (.A(net65),
    .X(net64));
 sky130_fd_sc_hd__buf_2 fanout65 (.A(net68),
    .X(net65));
 sky130_fd_sc_hd__buf_2 fanout66 (.A(net68),
    .X(net66));
 sky130_fd_sc_hd__clkbuf_4 fanout67 (.A(net68),
    .X(net67));
 sky130_fd_sc_hd__clkbuf_2 fanout68 (.A(\audio_player_inst.current_addr[5] ),
    .X(net68));
 sky130_fd_sc_hd__buf_4 fanout69 (.A(net70),
    .X(net69));
 sky130_fd_sc_hd__clkbuf_4 fanout70 (.A(net79),
    .X(net70));
 sky130_fd_sc_hd__clkbuf_2 fanout71 (.A(net79),
    .X(net71));
 sky130_fd_sc_hd__clkbuf_4 fanout72 (.A(net73),
    .X(net72));
 sky130_fd_sc_hd__buf_2 fanout73 (.A(net79),
    .X(net73));
 sky130_fd_sc_hd__clkbuf_4 fanout74 (.A(net75),
    .X(net74));
 sky130_fd_sc_hd__clkbuf_4 fanout75 (.A(net76),
    .X(net75));
 sky130_fd_sc_hd__buf_2 fanout76 (.A(net79),
    .X(net76));
 sky130_fd_sc_hd__clkbuf_4 fanout77 (.A(net78),
    .X(net77));
 sky130_fd_sc_hd__buf_2 fanout78 (.A(net79),
    .X(net78));
 sky130_fd_sc_hd__buf_2 fanout79 (.A(\audio_player_inst.current_addr[4] ),
    .X(net79));
 sky130_fd_sc_hd__buf_4 fanout80 (.A(net82),
    .X(net80));
 sky130_fd_sc_hd__clkbuf_2 fanout81 (.A(net82),
    .X(net81));
 sky130_fd_sc_hd__clkbuf_4 fanout82 (.A(net83),
    .X(net82));
 sky130_fd_sc_hd__clkbuf_4 fanout83 (.A(\audio_player_inst.current_addr[3] ),
    .X(net83));
 sky130_fd_sc_hd__buf_2 fanout84 (.A(net91),
    .X(net84));
 sky130_fd_sc_hd__buf_1 fanout85 (.A(net91),
    .X(net85));
 sky130_fd_sc_hd__buf_2 fanout86 (.A(net88),
    .X(net86));
 sky130_fd_sc_hd__buf_4 fanout87 (.A(net88),
    .X(net87));
 sky130_fd_sc_hd__buf_1 fanout88 (.A(net91),
    .X(net88));
 sky130_fd_sc_hd__clkbuf_4 fanout89 (.A(net91),
    .X(net89));
 sky130_fd_sc_hd__clkbuf_4 fanout90 (.A(net91),
    .X(net90));
 sky130_fd_sc_hd__clkbuf_2 fanout91 (.A(\audio_player_inst.current_addr[3] ),
    .X(net91));
 sky130_fd_sc_hd__buf_4 fanout92 (.A(net93),
    .X(net92));
 sky130_fd_sc_hd__buf_4 fanout93 (.A(net94),
    .X(net93));
 sky130_fd_sc_hd__clkbuf_4 fanout94 (.A(\audio_player_inst.current_addr[2] ),
    .X(net94));
 sky130_fd_sc_hd__buf_4 fanout95 (.A(net97),
    .X(net95));
 sky130_fd_sc_hd__buf_1 fanout96 (.A(net97),
    .X(net96));
 sky130_fd_sc_hd__clkbuf_4 fanout97 (.A(net99),
    .X(net97));
 sky130_fd_sc_hd__buf_4 fanout98 (.A(net99),
    .X(net98));
 sky130_fd_sc_hd__buf_2 fanout99 (.A(net100),
    .X(net99));
 sky130_fd_sc_hd__buf_2 fanout100 (.A(\audio_player_inst.current_addr[2] ),
    .X(net100));
 sky130_fd_sc_hd__buf_4 fanout101 (.A(net102),
    .X(net101));
 sky130_fd_sc_hd__clkbuf_4 fanout102 (.A(net103),
    .X(net102));
 sky130_fd_sc_hd__buf_2 fanout103 (.A(\audio_player_inst.current_addr[1] ),
    .X(net103));
 sky130_fd_sc_hd__buf_4 fanout104 (.A(net105),
    .X(net104));
 sky130_fd_sc_hd__buf_4 fanout105 (.A(net107),
    .X(net105));
 sky130_fd_sc_hd__buf_4 fanout106 (.A(net107),
    .X(net106));
 sky130_fd_sc_hd__clkbuf_2 fanout107 (.A(net108),
    .X(net107));
 sky130_fd_sc_hd__buf_2 fanout108 (.A(\audio_player_inst.current_addr[1] ),
    .X(net108));
 sky130_fd_sc_hd__buf_4 fanout109 (.A(net110),
    .X(net109));
 sky130_fd_sc_hd__clkbuf_2 fanout110 (.A(\audio_player_inst.current_addr[0] ),
    .X(net110));
 sky130_fd_sc_hd__buf_4 fanout111 (.A(net113),
    .X(net111));
 sky130_fd_sc_hd__clkbuf_4 fanout112 (.A(net113),
    .X(net112));
 sky130_fd_sc_hd__buf_4 fanout113 (.A(net114),
    .X(net113));
 sky130_fd_sc_hd__buf_2 fanout114 (.A(\audio_player_inst.current_addr[0] ),
    .X(net114));
 sky130_fd_sc_hd__buf_2 fanout115 (.A(net116),
    .X(net115));
 sky130_fd_sc_hd__buf_2 fanout116 (.A(_0624_),
    .X(net116));
 sky130_fd_sc_hd__clkbuf_4 fanout117 (.A(net119),
    .X(net117));
 sky130_fd_sc_hd__clkbuf_4 fanout118 (.A(net119),
    .X(net118));
 sky130_fd_sc_hd__buf_2 fanout119 (.A(net2),
    .X(net119));
 sky130_fd_sc_hd__clkbuf_4 fanout120 (.A(net2),
    .X(net120));
 sky130_fd_sc_hd__conb_1 tt_um_audio_player_121 (.LO(net121));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_0__f_clk (.A(clknet_0_clk),
    .X(clknet_2_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_1__f_clk (.A(clknet_0_clk),
    .X(clknet_2_1__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_2__f_clk (.A(clknet_0_clk),
    .X(clknet_2_2__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_2_3__f_clk (.A(clknet_0_clk),
    .X(clknet_2_3__leaf_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload0 (.A(clknet_2_0__leaf_clk));
 sky130_fd_sc_hd__clkinv_2 clkload1 (.A(clknet_2_1__leaf_clk));
 sky130_fd_sc_hd__clkbuf_4 clkload2 (.A(clknet_2_2__leaf_clk));
 assign uio_oe[0] = net121;
 assign uio_oe[1] = net122;
 assign uio_oe[2] = net123;
 assign uio_oe[3] = net124;
 assign uio_oe[4] = net125;
 assign uio_oe[5] = net126;
 assign uio_oe[6] = net127;
 assign uio_oe[7] = net128;
 assign uio_out[0] = net129;
 assign uio_out[1] = net130;
 assign uio_out[2] = net131;
 assign uio_out[3] = net132;
 assign uio_out[4] = net133;
 assign uio_out[5] = net134;
 assign uio_out[6] = net135;
 assign uio_out[7] = net136;
 assign uo_out[1] = net137;
 assign uo_out[2] = net138;
 assign uo_out[3] = net139;
 assign uo_out[4] = net140;
 assign uo_out[5] = net141;
 assign uo_out[6] = net142;
 assign uo_out[7] = net143;
endmodule

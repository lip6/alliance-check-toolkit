/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module comet ( p_reset , m_clock , datai , datao , adrs , memory_read , memory_write , hlt , start , ext_int );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] datai;
  wire [15:0] datai;
  output [15:0] datao;
  wire [15:0] datao;
  output [15:0] adrs;
  wire [15:0] adrs;
  output memory_read;
  wire memory_read;
  output memory_write;
  wire memory_write;
  output hlt;
  wire hlt;
  input start;
  wire start;
  input ext_int;
  wire ext_int;
  reg [15:0] pr;
  reg [3:0] _opreg_r2;
  reg [3:0] _opreg_r1;
  reg [3:0] _opreg_sop;
  reg [3:0] _opreg_mop;
  reg [15:0] mar;
  reg [15:0] mdr;
  reg [3:0] regnum;
  reg qf;
  reg oof;
  reg sf;
  reg zf;
  reg ei0;
  reg ei1;
  reg ei2;
  wire [15:0] flag;
  wire [15:0] flagi;
  wire set_flag;
  reg ifetch;
  reg decode;
  reg oaddr;
  reg oload;
  reg exec;
  reg wb;
  reg wt;
  reg push;
  reg pop;
  reg call;
  reg ret;
  reg svc;
  reg reti;
  reg int_req;
  reg pushf;
  reg popf;
  wire [7:0] op;
  wire br;
  wire [15:0] _alu_a;
  wire [15:0] _alu_b;
  wire [3:0] _alu_f;
  wire [15:0] _alu_q;
  wire _alu_ov;
  wire _alu_exe;
  wire _alu_p_reset;
  wire _alu_m_clock;
  wire [15:0] _gr_regin;
  wire [15:0] _gr_regouta;
  wire [15:0] _gr_regoutb;
  wire [3:0] _gr_n_regin;
  wire [3:0] _gr_n_regouta;
  wire [3:0] _gr_n_regoutb;
  wire _gr_write;
  wire _gr_reada;
  wire _gr_readb;
  wire _gr_p_reset;
  wire _gr_m_clock;
  wire [15:0] _inc_a;
  wire [15:0] _inc_q;
  wire _inc_exe;
  wire _inc_p_reset;
  wire _inc_m_clock;
  wire _proc_ifetch_set;
  wire _proc_ifetch_reset;
  wire _net_0;
  wire _proc_decode_set;
  wire _proc_decode_reset;
  wire _net_1;
  wire _proc_oaddr_set;
  wire _proc_oaddr_reset;
  wire _net_2;
  wire _proc_oload_set;
  wire _proc_oload_reset;
  wire _net_3;
  wire _proc_exec_set;
  wire _proc_exec_reset;
  wire _net_4;
  wire _proc_wb_set;
  wire _proc_wb_reset;
  wire _net_5;
  wire _proc_wt_set;
  wire _proc_wt_reset;
  wire _net_6;
  wire _proc_popf_set;
  wire _proc_popf_reset;
  wire _net_7;
  wire _proc_pushf_set;
  wire _proc_pushf_reset;
  wire _net_8;
  wire _proc_int_req_set;
  wire _proc_int_req_reset;
  wire _net_9;
  wire _proc_reti_set;
  wire _proc_reti_reset;
  wire _net_10;
  wire _proc_svc_set;
  wire _proc_svc_reset;
  wire _net_11;
  wire _proc_ret_set;
  wire _proc_ret_reset;
  wire _net_12;
  wire _proc_call_set;
  wire _proc_call_reset;
  wire _net_13;
  wire _proc_pop_set;
  wire _proc_pop_reset;
  wire _net_14;
  wire _proc_push_set;
  wire _proc_push_reset;
  wire _net_15;
  wire [3:0] _net_16;
  wire _net_17;
  wire _net_18;
  wire _net_19;
  wire _net_20;
  wire _net_21;
  wire _net_22;
  wire _net_23;
  wire [15:0] _net_24;
  wire _net_25;
  wire _net_26;
  wire _net_27;
  wire _net_28;
  wire _net_29;
  wire _net_30;
  wire _net_31;
  wire _net_32;
  wire _net_33;
  wire _net_34;
  wire _net_35;
  wire _net_36;
  wire _net_37;
  wire _net_38;
  wire _net_39;
  wire _net_40;
  wire _net_41;
  wire _net_42;
  wire _net_43;
  wire _net_44;
  wire _net_45;
  wire _net_46;
  wire _net_47;
  wire _net_48;
  wire _net_49;
  wire _net_50;
  wire _net_51;
  wire _net_52;
  wire _net_53;
  wire _net_54;
  wire _net_55;
  wire _net_56;
  wire _net_57;
  wire _net_58;
  wire _net_59;
  wire _net_60;
  wire _net_61;
  wire _net_62;
  wire _net_63;
  wire _net_64;
  wire _net_65;
  wire _net_66;
  wire _net_67;
  wire _net_68;
  wire _net_69;
  wire _net_70;
  wire _net_71;
  wire _net_72;
  wire _net_73;
  wire _net_74;
  wire _net_75;
  wire _net_76;
  wire _net_77;
  wire _net_78;
  wire _net_79;
  wire _net_80;
  wire _net_81;
  wire _net_82;
  wire _net_83;
  wire _net_84;
  wire _net_85;
  wire _net_86;
  wire _net_87;
  wire _net_88;
  wire _net_89;
  wire _net_90;
  wire _net_91;
  wire _net_92;
  wire _net_93;
  wire _net_94;
  wire _net_95;
  wire _net_96;
  wire _net_97;
  wire _net_98;
  wire _net_99;
  wire _net_100;
  wire _net_101;
  wire _net_102;
  wire _net_103;
  wire _net_104;
  wire _net_105;
  wire _net_106;
  wire _net_107;
  wire _net_108;
  wire _net_109;
  wire _net_110;
  wire _net_111;
  wire _net_112;
  wire _net_113;
  wire _net_114;
  wire _net_115;
  wire _net_116;
  wire _net_117;
  wire _net_118;
  wire _net_119;
  wire _net_120;
  wire _net_121;
  wire _net_122;
  wire _net_123;
  wire [7:0] _net_124;
  wire _net_125;
  wire _net_126;
  wire _net_127;
  wire _net_128;
  wire _net_129;
  wire _net_130;
  wire _net_131;
  wire _net_132;
  wire _net_133;
  wire _net_134;
  wire _net_135;
  wire _net_136;
  wire _net_137;
  wire _net_138;
  wire _net_139;
  wire _net_140;
  wire _net_141;
  wire _net_142;
  wire _net_143;
  wire _net_144;
  wire _net_145;
  wire _net_146;
  wire _net_147;
  wire _net_148;
  wire _net_149;
  wire _net_150;
  wire _net_151;
  wire _net_152;
  wire _net_153;
  wire _net_154;
  wire _net_155;
  wire _net_156;
  wire _net_157;
  wire _net_158;
  wire _net_159;
  wire _net_160;
  wire _net_161;
  wire _net_162;
  wire _net_163;
  wire _net_164;
  wire _net_165;
  wire _net_166;
  wire _net_167;
  wire _net_168;
  wire _net_169;
  wire _net_170;
  wire _net_171;
  wire _net_172;
  wire _net_173;
  wire _net_174;
  wire _net_175;
  wire _net_176;
  wire _net_177;
  wire _net_178;
  wire _net_179;
  wire _net_180;
  wire _net_181;
  wire _net_182;
  wire _net_183;
  wire _net_184;
  wire _net_185;
  wire _net_186;
  wire _net_187;
  wire _net_188;
  wire _net_189;
  wire _net_190;
  wire _net_191;
  wire _net_192;
  wire _net_193;
  wire _net_194;
  wire _net_195;
  wire _net_196;
  wire _net_197;
  wire _net_198;
  wire _net_199;
  wire _net_200;
  wire _net_201;
  wire _net_202;
  wire _net_203;
  wire _net_204;
  wire _net_205;
  wire _net_206;
  wire _net_207;
  wire _net_208;
  wire _net_209;
  wire _net_210;
  wire _net_211;
  wire _net_212;
  wire _net_213;
  wire _net_214;
  wire _net_215;
  wire _net_216;
  wire _net_217;
  wire _net_218;
  wire _net_219;
  wire _net_220;
  wire _net_221;
  wire _net_222;
  wire _net_223;
  wire _net_224;
  wire _net_225;
  wire _net_226;
  wire _net_227;
  wire _net_228;
  wire _net_229;
  wire _net_230;
  wire _net_231;
  wire _net_232;
  wire _net_233;
  wire _net_234;
  wire _net_235;
  wire _net_236;
  wire _net_237;
  wire _net_238;
  wire _net_239;
  wire _net_240;
  wire _net_241;
  wire _net_242;
  wire _net_243;
  wire _net_244;
  wire _net_245;
  wire _net_246;
  wire _net_247;
  wire _net_248;
  wire _net_249;
  wire _net_250;
  wire _net_251;
  wire _net_252;
  wire _net_253;
  wire _net_254;
  wire _net_255;
  wire _net_256;
  wire _net_257;
  wire _net_258;
  wire _net_259;
  wire _net_260;
  wire _net_261;
  wire _net_262;
  wire _net_263;
  wire _net_264;
  wire _net_265;
  wire _net_266;
  wire _net_267;
  wire _net_268;
  wire _net_269;
  wire _net_270;
  wire _net_271;
  wire _net_272;
  wire _net_273;
  wire _net_274;
  wire _net_275;
  wire _net_276;
  wire _net_277;
  wire _net_278;
  wire _net_279;
  wire _net_280;
  wire _net_281;
  wire _net_282;
  wire _net_283;
  wire _net_284;
  wire _net_285;
  wire _net_286;
  wire _net_287;
  wire _net_288;
  wire _net_289;
  wire _net_290;
  wire _net_291;
  wire _net_292;
  wire _net_293;
  wire _net_294;
  wire _net_295;
  wire _net_296;
  wire _net_297;
  wire _net_298;
  wire _net_299;
  wire _net_300;
  wire _net_301;
  wire _net_302;
  wire _net_303;
  wire _net_304;
  wire _net_305;
  wire _net_306;
  reg _reg_307;
  reg _reg_308;
  reg _reg_309;
  wire _net_310;
  wire _net_311;
  wire _net_312;
  wire _net_313;
  wire _net_314;
  wire _net_315;
  wire _net_316;
  wire _net_317;
  wire _net_318;
  wire _net_319;
  wire _net_320;
  wire _net_321;
  wire _net_322;
  wire _net_323;
  reg _reg_324;
  reg _reg_325;
  reg _reg_326;
  wire _net_327;
  wire _net_328;
  wire _net_329;
  wire _net_330;
  wire _net_331;
  wire _net_332;
  wire _net_333;
  wire _net_334;
  wire _net_335;
  wire _net_336;
  wire _net_337;
  wire _net_338;
  reg _reg_339;
  reg _reg_340;
  reg _reg_341;
  wire _net_342;
  wire _net_343;
  wire _net_344;
  wire _net_345;
  wire _net_346;
  wire _net_347;
  wire _net_348;
  wire _net_349;
  wire _net_350;
  wire _net_351;
  wire _net_352;
  wire _net_353;
  wire _net_354;
  wire _net_355;
  reg _reg_356;
  reg _reg_357;
  reg _reg_358;
  wire _net_359;
  wire _net_360;
  wire _net_361;
  wire _net_362;
  wire _net_363;
  wire _net_364;
  wire _net_365;
  wire _net_366;
  wire _net_367;
  wire _net_368;
  wire _net_369;
  wire _net_370;
  wire _net_371;
  wire _net_372;
  wire _net_373;
  reg _reg_374;
  reg _reg_375;
  reg _reg_376;
  wire _net_377;
  wire _net_378;
  wire _net_379;
  wire _net_380;
  wire _net_381;
  wire _net_382;
  wire _net_383;
  wire _net_384;
  wire _net_385;
  wire _net_386;
  wire _net_387;
  wire _net_388;
  wire _net_389;
  wire _net_390;
  reg _reg_391;
  reg _reg_392;
  reg _reg_393;
  wire _net_394;
  wire _net_395;
  wire _net_396;
  wire _net_397;
  wire _net_398;
  wire _net_399;
  wire _net_400;
  wire _net_401;
  wire _net_402;
  wire _net_403;
  wire _net_404;
  wire _net_405;
  wire _net_406;
  wire _net_407;
  reg _reg_408;
  reg _reg_409;
  reg _reg_410;
  reg _reg_411;
  reg _reg_412;
  reg _reg_413;
  wire _net_414;
  wire _net_415;
  wire _net_416;
  wire _net_417;
  wire _net_418;
  wire _net_419;
  wire _net_420;
  wire _net_421;
  wire _net_422;
  wire _net_423;
  wire _net_424;
  wire _net_425;
  wire _net_426;
  wire _net_427;
  wire _net_428;
  wire _net_429;
  wire _net_430;
  wire _net_431;
  wire _net_432;
  wire _net_433;
  wire _net_434;
  wire _net_435;
  wire _net_436;
  wire _net_437;
  wire _net_438;
  wire _net_439;
  wire _net_440;
  wire _net_441;
  wire _net_442;
  wire _net_443;
  wire _net_444;
  wire _net_445;
  wire _net_446;
  wire _net_447;
  reg _reg_448;
  reg _reg_449;
  reg _reg_450;
  wire _net_451;
  wire _net_452;
  wire _net_453;
  wire _net_454;
  wire _net_455;
  wire _net_456;
  wire _net_457;
  wire _net_458;
  wire _net_459;
  wire _net_460;
  wire _net_461;
  wire _net_462;
  wire _net_463;
  wire _net_464;
  wire _net_465;
  wire _net_466;
  wire _net_467;
  wire _net_468;
  wire _net_469;
  wire _net_470;
  wire _net_471;
  wire _net_472;
  wire _net_473;
  wire _net_474;
  wire _net_475;
  wire _net_476;
  wire _net_477;
  reg _reg_478;
  reg _reg_479;
  reg _reg_480;
  reg _reg_481;
  reg _reg_482;
  wire _net_483;
  wire _net_484;
  wire _net_485;
  wire _net_486;
  wire _net_487;
  wire _net_488;
  wire _net_489;
  wire _net_490;
  wire _net_491;
  wire _net_492;
  wire _net_493;
  wire _net_494;
  wire _net_495;
  wire _net_496;
  wire _net_497;
  wire _net_498;
  wire _net_499;
  wire _net_500;
  wire _net_501;
  wire _net_502;
  wire _net_503;
  wire _net_504;
  wire _net_505;
  wire _net_506;
  wire _net_507;
  wire _net_508;
  wire _net_509;
  wire _net_510;
  wire _net_511;
inc16 inc (.m_clock(m_clock), .p_reset(p_reset), .exe(_inc_exe), .q(_inc_q), .a(_inc_a));
reg16 gr (.m_clock(m_clock), .p_reset(p_reset), .readb(_gr_readb), .reada(_gr_reada), .write(_gr_write), .n_regoutb(_gr_n_regoutb), .n_regouta(_gr_n_regouta), .n_regin(_gr_n_regin), .regoutb(_gr_regoutb), .regouta(_gr_regouta), .regin(_gr_regin));
alu16 alu (.m_clock(m_clock), .p_reset(p_reset), .exe(_alu_exe), .ov(_alu_ov), .q(_alu_q), .f(_alu_f), .b(_alu_b), .a(_alu_a));

   assign  flag = ({1'b1,qf,11'b00000000000,oof,sf,zf});
   assign  flagi = datai;
   assign  set_flag = (_net_454|_net_365);
   assign  op = _net_124;
   assign  br = ((((((_opreg_sop==4'b0100)|((_opreg_sop==4'b0001)&sf))|((_opreg_sop==4'b0010)&(~zf)))|((_opreg_sop==4'b0011)&zf))|(((_opreg_sop==4'b0101)&(~zf))&(~sf)))|((_opreg_sop==4'b0110)&oof));
   assign  _alu_a = (((_net_505|(_net_497|(_net_469|(_net_461|(_net_440|(_net_432|(_net_423|(_net_398|(_net_386|(_net_363|(_net_351|(_net_331|_net_319)))))))))))))?_gr_regouta:16'b0)|
    (((_net_295|(_net_285|(_net_275|(_net_265|(_net_255|(_net_245|(_net_235|(_net_225|(_net_215|(_net_205|(_net_195|(_net_185|_net_175)))))))))))))?mdr:16'b0)|
    ((_net_134)?pr:16'b0)|
    (((_net_85|_net_70))?mar:16'b0);
   assign  _alu_b = (((_net_422|(_net_294|(_net_284|(_net_274|(_net_264|(_net_254|(_net_244|(_net_234|(_net_224|(_net_214|(_net_204|(_net_194|(_net_184|_net_174))))))))))))))?mar:16'b0)|
    (((_net_505|(_net_497|(_net_469|(_net_461|(_net_440|(_net_432|(_net_398|(_net_386|(_net_363|(_net_351|(_net_331|(_net_319|_net_133)))))))))))))?16'b0000000000000001:16'b0)|
    (((_net_84|_net_69))?mdr:16'b0);
   assign  _alu_f = ((_net_296)?4'b0001:4'b0)|
    ((_net_256)?4'b0101:4'b0)|
    ((_net_246)?4'b0110:4'b0)|
    ((_net_236)?4'b0111:4'b0)|
    (((_net_286|_net_226))?4'b0010:4'b0)|
    ((_net_206)?4'b1000:4'b0)|
    ((_net_196)?4'b1001:4'b0)|
    ((_net_186)?4'b1010:4'b0)|
    ((_net_176)?4'b1011:4'b0)|
    (((_net_505|(_net_497|(_net_440|(_net_432|(_net_386|(_net_351|(_net_319|(_net_266|(_net_216|_net_135))))))))))?4'b0100:4'b0)|
    (((_net_469|(_net_461|(_net_424|(_net_398|(_net_363|(_net_331|(_net_276|(_net_86|_net_71)))))))))?4'b0011:4'b0);
   assign  _alu_exe = (_net_505|(_net_497|(_net_469|(_net_461|(_net_440|(_net_432|(_net_421|(_net_398|(_net_386|(_net_363|(_net_351|(_net_331|(_net_319|(_net_293|(_net_283|(_net_273|(_net_263|(_net_253|(_net_243|(_net_233|(_net_223|(_net_213|(_net_203|(_net_193|(_net_183|(_net_173|(_net_132|(_net_83|_net_68))))))))))))))))))))))))))));
   assign  _alu_p_reset = p_reset;
   assign  _alu_m_clock = m_clock;
   assign  _gr_regin = ((wb)?mdr:16'b0)|
    ((_net_334)?datai:16'b0)|
    (((_net_505|(_net_497|(_net_469|(_net_461|(_net_440|(_net_432|(_net_398|(_net_386|(_net_363|(_net_351|(_net_331|_net_319))))))))))))?_alu_q:16'b0)|
    ((_net_92)?mar:16'b0);
   assign  _gr_n_regin = ((wb)?regnum:4'b0)|
    (((_net_506|(_net_498|(_net_470|(_net_462|(_net_441|(_net_433|(_net_399|(_net_387|(_net_364|(_net_352|(_net_332|_net_320))))))))))))?4'b1111:4'b0)|
    (((_net_335|_net_93))?_opreg_r1:4'b0);
   assign  _gr_n_regouta = (((_net_486|_net_420))?4'b1110:4'b0)|
    (((_net_505|(_net_502|(_net_497|(_net_494|(_net_464|(_net_456|(_net_440|(_net_437|(_net_432|(_net_429|(_net_401|(_net_398|(_net_386|(_net_383|(_net_367|(_net_363|(_net_351|(_net_348|(_net_334|(_net_331|(_net_319|_net_316))))))))))))))))))))))?4'b1111:4'b0)|
    (((_net_122|(_net_101|_net_55)))?_opreg_r1:4'b0);
   assign  _gr_n_regoutb = (((_net_74|_net_64))?_opreg_r1:4'b0)|
    (((_net_304|(_net_52|_net_41)))?_opreg_r2:4'b0);
   assign  _gr_write = (_net_504|(_net_496|(wb|(_net_468|(_net_460|(_net_439|(_net_431|(_net_397|(_net_385|(_net_362|(_net_350|(_net_333|(_net_330|(_net_318|_net_91))))))))))))));
   assign  _gr_reada = (_net_505|(_net_501|(_net_497|(_net_493|(_net_485|(_net_463|(_net_455|(_net_440|(_net_436|(_net_432|(_net_428|(_net_419|(_net_400|(_net_398|(_net_386|(_net_382|(_net_366|(_net_363|(_net_351|(_net_347|(_net_334|(_net_331|(_net_319|(_net_315|(_net_121|(_net_100|_net_54))))))))))))))))))))))))));
   assign  _gr_readb = (_net_303|(_net_73|(_net_63|(_net_51|_net_40))));
   assign  _gr_p_reset = p_reset;
   assign  _gr_m_clock = m_clock;
   assign  _inc_a = pr;
   assign  _inc_exe = (_net_46|_net_30);
   assign  _inc_p_reset = p_reset;
   assign  _inc_m_clock = m_clock;
   assign  _proc_ifetch_set = (_net_484|(wt|(wb|(_net_451|(_net_414|(_net_394|(_net_377|(_net_359|(_net_342|(_net_327|(_net_310|(_net_167|(_net_164|(_net_131|(_net_105|(_net_95|(_net_35|start)))))))))))))))));
   assign  _proc_ifetch_reset = (_net_20|_net_18);
   assign  _net_0 = (_proc_ifetch_set|_proc_ifetch_reset);
   assign  _proc_decode_set = _net_21;
   assign  _proc_decode_reset = (_net_49|(_net_38|_net_34));
   assign  _net_1 = (_proc_decode_set|_proc_decode_reset);
   assign  _proc_oaddr_set = _net_39;
   assign  _proc_oaddr_reset = (_net_81|(_net_78|(_net_66|_net_60)));
   assign  _net_2 = (_proc_oaddr_set|_proc_oaddr_reset);
   assign  _proc_oload_set = (_net_82|_net_79);
   assign  _proc_oload_reset = (_net_116|(_net_109|(_net_104|_net_94)));
   assign  _net_3 = (_proc_oload_set|_proc_oload_reset);
   assign  _proc_exec_set = (_net_117|(_net_67|(_net_61|_net_50)));
   assign  _proc_exec_reset = (_net_300|(_net_290|(_net_280|(_net_270|(_net_260|(_net_250|(_net_240|(_net_230|(_net_220|(_net_210|(_net_200|(_net_190|(_net_180|(_net_170|(_net_166|(_net_163|(_net_159|(_net_156|(_net_153|(_net_150|(_net_147|(_net_144|(_net_141|(_net_138|_net_130))))))))))))))))))))))));
   assign  _net_4 = (_proc_exec_set|_proc_exec_reset);
   assign  _proc_wb_set = (_net_301|(_net_291|(_net_281|(_net_271|(_net_261|(_net_251|(_net_241|(_net_231|(_net_201|(_net_191|(_net_181|(_net_171|_net_110))))))))))));
   assign  _proc_wb_reset = wb;
   assign  _net_5 = (_proc_wb_set|_proc_wb_reset);
   assign  _proc_wt_set = (_net_221|_net_211);
   assign  _proc_wt_reset = wt;
   assign  _net_6 = (_proc_wt_set|_proc_wt_reset);
   assign  _proc_popf_set = _net_151;
   assign  _proc_popf_reset = _net_361;
   assign  _net_7 = (_proc_popf_set|_proc_popf_reset);
   assign  _proc_pushf_set = _net_154;
   assign  _proc_pushf_reset = _net_344;
   assign  _net_8 = (_proc_pushf_set|_proc_pushf_reset);
   assign  _proc_int_req_set = _net_19;
   assign  _proc_int_req_reset = _net_490;
   assign  _net_9 = (_proc_int_req_set|_proc_int_req_reset);
   assign  _proc_reti_set = _net_139;
   assign  _proc_reti_reset = _net_453;
   assign  _net_10 = (_proc_reti_set|_proc_reti_reset);
   assign  _proc_svc_set = _net_142;
   assign  _proc_svc_reset = _net_418;
   assign  _net_11 = (_proc_svc_set|_proc_svc_reset);
   assign  _proc_ret_set = _net_145;
   assign  _proc_ret_reset = _net_396;
   assign  _net_12 = (_proc_ret_set|_proc_ret_reset);
   assign  _proc_call_set = _net_148;
   assign  _proc_call_reset = _net_379;
   assign  _net_13 = (_proc_call_set|_proc_call_reset);
   assign  _proc_pop_set = _net_157;
   assign  _proc_pop_reset = _net_329;
   assign  _net_14 = (_proc_pop_set|_proc_pop_reset);
   assign  _proc_push_set = _net_160;
   assign  _proc_push_reset = _net_312;
   assign  _net_15 = (_proc_push_set|_proc_push_reset);
   assign  _net_16 = ({(flagi[14]),(flagi[2]),(flagi[1]),(flagi[0])});
   assign  _net_17 = (qf&ei2);
   assign  _net_18 = (ifetch&_net_17);
   assign  _net_19 = (ifetch&_net_17);
   assign  _net_20 = (ifetch&(~_net_17));
   assign  _net_21 = (ifetch&(~_net_17));
   assign  _net_22 = (ifetch&(~_net_17));
   assign  _net_23 = (ifetch&(~_net_17));
   assign  _net_24 = datai;
   assign  _net_25 = (ifetch&(~_net_17));
   assign  _net_26 = (ifetch&(~_net_17));
   assign  _net_27 = (ifetch&(~_net_17));
   assign  _net_28 = (ifetch&(~_net_17));
   assign  _net_29 = (ifetch&(~_net_17));
   assign  _net_30 = (ifetch&(~_net_17));
   assign  _net_31 = (ifetch&(~_net_17));
   assign  _net_32 = (ifetch&(~_net_17));
   assign  _net_33 = (_opreg_mop==4'b0000);
   assign  _net_34 = (decode&_net_33);
   assign  _net_35 = (decode&_net_33);
   assign  _net_36 = (decode&_net_33);
   assign  _net_37 = ((((((_opreg_mop==4'b1111)&(_opreg_sop==4'b0000))|(_opreg_mop==4'b0110))|(_opreg_mop==4'b0101))|(((((_opreg_mop==4'b0001)|(_opreg_mop==4'b0010))|(_opreg_mop==4'b0011))|(_opreg_mop==4'b0100))&((_opreg_sop[2])==1'b0)))|(((_opreg_mop==4'b0111)|(_opreg_mop==4'b1000))&(_opreg_sop==4'b0000)));
   assign  _net_38 = (decode&_net_37);
   assign  _net_39 = (decode&_net_37);
   assign  _net_40 = (decode&_net_37);
   assign  _net_41 = (decode&_net_37);
   assign  _net_42 = (decode&_net_37);
   assign  _net_43 = (decode&_net_37);
   assign  _net_44 = (decode&_net_37);
   assign  _net_45 = (decode&_net_37);
   assign  _net_46 = (decode&_net_37);
   assign  _net_47 = (decode&_net_37);
   assign  _net_48 = (decode&_net_37);
   assign  _net_49 = ((decode&(~_net_33))&(~_net_37));
   assign  _net_50 = ((decode&(~_net_33))&(~_net_37));
   assign  _net_51 = ((decode&(~_net_33))&(~_net_37));
   assign  _net_52 = ((decode&(~_net_33))&(~_net_37));
   assign  _net_53 = ((decode&(~_net_33))&(~_net_37));
   assign  _net_54 = ((decode&(~_net_33))&(~_net_37));
   assign  _net_55 = ((decode&(~_net_33))&(~_net_37));
   assign  _net_56 = ((decode&(~_net_33))&(~_net_37));
   assign  _net_57 = (((((_opreg_mop==4'b1111)|(_opreg_mop==4'b1000))|(_opreg_mop==4'b0111))|(_opreg_mop==4'b0110))|(_opreg_mop==4'b0101));
   assign  _net_58 = (_opreg_r2==4'b0000);
   assign  _net_59 = (oaddr&_net_57);
   assign  _net_60 = ((oaddr&_net_57)&_net_58);
   assign  _net_61 = ((oaddr&_net_57)&_net_58);
   assign  _net_62 = ((oaddr&_net_57)&_net_58);
   assign  _net_63 = ((oaddr&_net_57)&_net_58);
   assign  _net_64 = ((oaddr&_net_57)&_net_58);
   assign  _net_65 = ((oaddr&_net_57)&_net_58);
   assign  _net_66 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_67 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_68 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_69 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_70 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_71 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_72 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_73 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_74 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_75 = ((oaddr&_net_57)&(~_net_58));
   assign  _net_76 = (_opreg_r2==4'b0000);
   assign  _net_77 = (oaddr&(~_net_57));
   assign  _net_78 = ((oaddr&(~_net_57))&_net_76);
   assign  _net_79 = ((oaddr&(~_net_57))&_net_76);
   assign  _net_80 = ((oaddr&(~_net_57))&_net_76);
   assign  _net_81 = ((oaddr&(~_net_57))&(~_net_76));
   assign  _net_82 = ((oaddr&(~_net_57))&(~_net_76));
   assign  _net_83 = ((oaddr&(~_net_57))&(~_net_76));
   assign  _net_84 = ((oaddr&(~_net_57))&(~_net_76));
   assign  _net_85 = ((oaddr&(~_net_57))&(~_net_76));
   assign  _net_86 = ((oaddr&(~_net_57))&(~_net_76));
   assign  _net_87 = ((oaddr&(~_net_57))&(~_net_76));
   assign  _net_88 = (_opreg_mop==4'b0001);
   assign  _net_89 = (_opreg_sop==4'b0010);
   assign  _net_90 = (oload&_net_88);
   assign  _net_91 = ((oload&_net_88)&_net_89);
   assign  _net_92 = ((oload&_net_88)&_net_89);
   assign  _net_93 = ((oload&_net_88)&_net_89);
   assign  _net_94 = ((oload&_net_88)&_net_89);
   assign  _net_95 = ((oload&_net_88)&_net_89);
   assign  _net_96 = ((oload&_net_88)&_net_89);
   assign  _net_97 = (_opreg_sop==4'b0001);
   assign  _net_98 = (oload&_net_88);
   assign  _net_99 = ((oload&_net_88)&_net_97);
   assign  _net_100 = ((oload&_net_88)&_net_97);
   assign  _net_101 = ((oload&_net_88)&_net_97);
   assign  _net_102 = ((oload&_net_88)&_net_97);
   assign  _net_103 = ((oload&_net_88)&_net_97);
   assign  _net_104 = ((oload&_net_88)&_net_97);
   assign  _net_105 = ((oload&_net_88)&_net_97);
   assign  _net_106 = ((oload&_net_88)&_net_97);
   assign  _net_107 = (_opreg_sop==4'b0000);
   assign  _net_108 = (oload&_net_88);
   assign  _net_109 = ((oload&_net_88)&_net_107);
   assign  _net_110 = ((oload&_net_88)&_net_107);
   assign  _net_111 = ((oload&_net_88)&_net_107);
   assign  _net_112 = ((oload&_net_88)&_net_107);
   assign  _net_113 = ((oload&_net_88)&_net_107);
   assign  _net_114 = ((oload&_net_88)&_net_107);
   assign  _net_115 = ((oload&_net_88)&_net_107);
   assign  _net_116 = (oload&(~_net_88));
   assign  _net_117 = (oload&(~_net_88));
   assign  _net_118 = (oload&(~_net_88));
   assign  _net_119 = (oload&(~_net_88));
   assign  _net_120 = (oload&(~_net_88));
   assign  _net_121 = (oload&(~_net_88));
   assign  _net_122 = (oload&(~_net_88));
   assign  _net_123 = (oload&(~_net_88));
   assign  _net_124 = ((_net_127)?({_opreg_mop,_opreg_sop}):8'b0)|
    ((_net_126)?({_opreg_mop,(_opreg_sop&4'b0011)}):8'b0);
   assign  _net_125 = (_opreg_mop < 4'b0101);
   assign  _net_126 = (exec&_net_125);
   assign  _net_127 = (exec&(~_net_125));
   assign  _net_128 = (op==8'b11110010);
   assign  _net_129 = (exec&_net_128);
   assign  _net_130 = (exec&_net_128);
   assign  _net_131 = (exec&_net_128);
   assign  _net_132 = (exec&_net_128);
   assign  _net_133 = (exec&_net_128);
   assign  _net_134 = (exec&_net_128);
   assign  _net_135 = (exec&_net_128);
   assign  _net_136 = (exec&_net_128);
   assign  _net_137 = (op==8'b11110001);
   assign  _net_138 = (exec&_net_137);
   assign  _net_139 = (exec&_net_137);
   assign  _net_140 = (op==8'b11110000);
   assign  _net_141 = (exec&_net_140);
   assign  _net_142 = (exec&_net_140);
   assign  _net_143 = (op==8'b10000001);
   assign  _net_144 = (exec&_net_143);
   assign  _net_145 = (exec&_net_143);
   assign  _net_146 = (op==8'b10000000);
   assign  _net_147 = (exec&_net_146);
   assign  _net_148 = (exec&_net_146);
   assign  _net_149 = (op==8'b01110011);
   assign  _net_150 = (exec&_net_149);
   assign  _net_151 = (exec&_net_149);
   assign  _net_152 = (op==8'b01110010);
   assign  _net_153 = (exec&_net_152);
   assign  _net_154 = (exec&_net_152);
   assign  _net_155 = (op==8'b01110001);
   assign  _net_156 = (exec&_net_155);
   assign  _net_157 = (exec&_net_155);
   assign  _net_158 = (op==8'b01110000);
   assign  _net_159 = (exec&_net_158);
   assign  _net_160 = (exec&_net_158);
   assign  _net_161 = (_opreg_mop==4'b0110);
   assign  _net_162 = (exec&_net_161);
   assign  _net_163 = ((exec&_net_161)&br);
   assign  _net_164 = ((exec&_net_161)&br);
   assign  _net_165 = ((exec&_net_161)&br);
   assign  _net_166 = ((exec&_net_161)&(~br));
   assign  _net_167 = ((exec&_net_161)&(~br));
   assign  _net_168 = ((exec&_net_161)&(~br));
   assign  _net_169 = (op==8'b01010011);
   assign  _net_170 = (exec&_net_169);
   assign  _net_171 = (exec&_net_169);
   assign  _net_172 = (exec&_net_169);
   assign  _net_173 = (exec&_net_169);
   assign  _net_174 = (exec&_net_169);
   assign  _net_175 = (exec&_net_169);
   assign  _net_176 = (exec&_net_169);
   assign  _net_177 = (exec&_net_169);
   assign  _net_178 = (exec&_net_169);
   assign  _net_179 = (op==8'b01010010);
   assign  _net_180 = (exec&_net_179);
   assign  _net_181 = (exec&_net_179);
   assign  _net_182 = (exec&_net_179);
   assign  _net_183 = (exec&_net_179);
   assign  _net_184 = (exec&_net_179);
   assign  _net_185 = (exec&_net_179);
   assign  _net_186 = (exec&_net_179);
   assign  _net_187 = (exec&_net_179);
   assign  _net_188 = (exec&_net_179);
   assign  _net_189 = (op==8'b01010001);
   assign  _net_190 = (exec&_net_189);
   assign  _net_191 = (exec&_net_189);
   assign  _net_192 = (exec&_net_189);
   assign  _net_193 = (exec&_net_189);
   assign  _net_194 = (exec&_net_189);
   assign  _net_195 = (exec&_net_189);
   assign  _net_196 = (exec&_net_189);
   assign  _net_197 = (exec&_net_189);
   assign  _net_198 = (exec&_net_189);
   assign  _net_199 = (op==8'b01010000);
   assign  _net_200 = (exec&_net_199);
   assign  _net_201 = (exec&_net_199);
   assign  _net_202 = (exec&_net_199);
   assign  _net_203 = (exec&_net_199);
   assign  _net_204 = (exec&_net_199);
   assign  _net_205 = (exec&_net_199);
   assign  _net_206 = (exec&_net_199);
   assign  _net_207 = (exec&_net_199);
   assign  _net_208 = (exec&_net_199);
   assign  _net_209 = (op==8'b01000001);
   assign  _net_210 = (exec&_net_209);
   assign  _net_211 = (exec&_net_209);
   assign  _net_212 = (exec&_net_209);
   assign  _net_213 = (exec&_net_209);
   assign  _net_214 = (exec&_net_209);
   assign  _net_215 = (exec&_net_209);
   assign  _net_216 = (exec&_net_209);
   assign  _net_217 = (exec&_net_209);
   assign  _net_218 = (exec&_net_209);
   assign  _net_219 = (op==8'b01000000);
   assign  _net_220 = (exec&_net_219);
   assign  _net_221 = (exec&_net_219);
   assign  _net_222 = (exec&_net_219);
   assign  _net_223 = (exec&_net_219);
   assign  _net_224 = (exec&_net_219);
   assign  _net_225 = (exec&_net_219);
   assign  _net_226 = (exec&_net_219);
   assign  _net_227 = (exec&_net_219);
   assign  _net_228 = (exec&_net_219);
   assign  _net_229 = (op==8'b00110010);
   assign  _net_230 = (exec&_net_229);
   assign  _net_231 = (exec&_net_229);
   assign  _net_232 = (exec&_net_229);
   assign  _net_233 = (exec&_net_229);
   assign  _net_234 = (exec&_net_229);
   assign  _net_235 = (exec&_net_229);
   assign  _net_236 = (exec&_net_229);
   assign  _net_237 = (exec&_net_229);
   assign  _net_238 = (exec&_net_229);
   assign  _net_239 = (op==8'b00110001);
   assign  _net_240 = (exec&_net_239);
   assign  _net_241 = (exec&_net_239);
   assign  _net_242 = (exec&_net_239);
   assign  _net_243 = (exec&_net_239);
   assign  _net_244 = (exec&_net_239);
   assign  _net_245 = (exec&_net_239);
   assign  _net_246 = (exec&_net_239);
   assign  _net_247 = (exec&_net_239);
   assign  _net_248 = (exec&_net_239);
   assign  _net_249 = (op==8'b00110000);
   assign  _net_250 = (exec&_net_249);
   assign  _net_251 = (exec&_net_249);
   assign  _net_252 = (exec&_net_249);
   assign  _net_253 = (exec&_net_249);
   assign  _net_254 = (exec&_net_249);
   assign  _net_255 = (exec&_net_249);
   assign  _net_256 = (exec&_net_249);
   assign  _net_257 = (exec&_net_249);
   assign  _net_258 = (exec&_net_249);
   assign  _net_259 = (op==8'b00100011);
   assign  _net_260 = (exec&_net_259);
   assign  _net_261 = (exec&_net_259);
   assign  _net_262 = (exec&_net_259);
   assign  _net_263 = (exec&_net_259);
   assign  _net_264 = (exec&_net_259);
   assign  _net_265 = (exec&_net_259);
   assign  _net_266 = (exec&_net_259);
   assign  _net_267 = (exec&_net_259);
   assign  _net_268 = (exec&_net_259);
   assign  _net_269 = (op==8'b00100010);
   assign  _net_270 = (exec&_net_269);
   assign  _net_271 = (exec&_net_269);
   assign  _net_272 = (exec&_net_269);
   assign  _net_273 = (exec&_net_269);
   assign  _net_274 = (exec&_net_269);
   assign  _net_275 = (exec&_net_269);
   assign  _net_276 = (exec&_net_269);
   assign  _net_277 = (exec&_net_269);
   assign  _net_278 = (exec&_net_269);
   assign  _net_279 = (op==8'b00100001);
   assign  _net_280 = (exec&_net_279);
   assign  _net_281 = (exec&_net_279);
   assign  _net_282 = (exec&_net_279);
   assign  _net_283 = (exec&_net_279);
   assign  _net_284 = (exec&_net_279);
   assign  _net_285 = (exec&_net_279);
   assign  _net_286 = (exec&_net_279);
   assign  _net_287 = (exec&_net_279);
   assign  _net_288 = (exec&_net_279);
   assign  _net_289 = (op==8'b00100000);
   assign  _net_290 = (exec&_net_289);
   assign  _net_291 = (exec&_net_289);
   assign  _net_292 = (exec&_net_289);
   assign  _net_293 = (exec&_net_289);
   assign  _net_294 = (exec&_net_289);
   assign  _net_295 = (exec&_net_289);
   assign  _net_296 = (exec&_net_289);
   assign  _net_297 = (exec&_net_289);
   assign  _net_298 = (exec&_net_289);
   assign  _net_299 = (op==8'b00010000);
   assign  _net_300 = (exec&_net_299);
   assign  _net_301 = (exec&_net_299);
   assign  _net_302 = (exec&_net_299);
   assign  _net_303 = (exec&_net_299);
   assign  _net_304 = (exec&_net_299);
   assign  _net_305 = (exec&_net_299);
   assign  _net_306 = (exec&_net_299);
   assign  _net_310 = (_reg_307&push);
   assign  _net_311 = (_reg_307&push);
   assign  _net_312 = (_reg_307&push);
   assign  _net_313 = (_reg_308&push);
   assign  _net_314 = (_reg_308&push);
   assign  _net_315 = (_reg_308&push);
   assign  _net_316 = (_reg_308&push);
   assign  _net_317 = (_reg_308&push);
   assign  _net_318 = (push&_reg_309);
   assign  _net_319 = (push&_reg_309);
   assign  _net_320 = (push&_reg_309);
   assign  _net_321 = ((_proc_push_set|_proc_push_reset)|_reg_309);
   assign  _net_322 = (_proc_push_reset|(_reg_309|(_reg_308|_reg_309)));
   assign  _net_323 = (_proc_push_reset|(_reg_307|_reg_308));
   assign  _net_327 = (_reg_324&pop);
   assign  _net_328 = (_reg_324&pop);
   assign  _net_329 = (_reg_324&pop);
   assign  _net_330 = (_reg_325&pop);
   assign  _net_331 = (_reg_325&pop);
   assign  _net_332 = (_reg_325&pop);
   assign  _net_333 = (pop&_reg_326);
   assign  _net_334 = (pop&_reg_326);
   assign  _net_335 = (pop&_reg_326);
   assign  _net_336 = ((_proc_pop_set|_proc_pop_reset)|_reg_326);
   assign  _net_337 = (_proc_pop_reset|(_reg_326|(_reg_325|_reg_326)));
   assign  _net_338 = (_proc_pop_reset|(_reg_324|_reg_325));
   assign  _net_342 = (_reg_339&pushf);
   assign  _net_343 = (_reg_339&pushf);
   assign  _net_344 = (_reg_339&pushf);
   assign  _net_345 = (_reg_340&pushf);
   assign  _net_346 = (_reg_340&pushf);
   assign  _net_347 = (_reg_340&pushf);
   assign  _net_348 = (_reg_340&pushf);
   assign  _net_349 = (_reg_340&pushf);
   assign  _net_350 = (pushf&_reg_341);
   assign  _net_351 = (pushf&_reg_341);
   assign  _net_352 = (pushf&_reg_341);
   assign  _net_353 = ((_proc_pushf_set|_proc_pushf_reset)|_reg_341);
   assign  _net_354 = (_proc_pushf_reset|(_reg_341|(_reg_340|_reg_341)));
   assign  _net_355 = (_proc_pushf_reset|(_reg_339|_reg_340));
   assign  _net_359 = (_reg_356&popf);
   assign  _net_360 = (_reg_356&popf);
   assign  _net_361 = (_reg_356&popf);
   assign  _net_362 = (_reg_357&popf);
   assign  _net_363 = (_reg_357&popf);
   assign  _net_364 = (_reg_357&popf);
   assign  _net_365 = (popf&_reg_358);
   assign  _net_366 = (popf&_reg_358);
   assign  _net_367 = (popf&_reg_358);
   assign  _net_368 = (popf&_reg_358);
   assign  _net_369 = (popf&_reg_358);
   assign  _net_370 = (popf&_reg_358);
   assign  _net_371 = ((_proc_popf_set|_proc_popf_reset)|_reg_358);
   assign  _net_372 = (_proc_popf_reset|(_reg_358|(_reg_357|_reg_358)));
   assign  _net_373 = (_proc_popf_reset|(_reg_356|_reg_357));
   assign  _net_377 = (_reg_374&call);
   assign  _net_378 = (_reg_374&call);
   assign  _net_379 = (_reg_374&call);
   assign  _net_380 = (_reg_375&call);
   assign  _net_381 = (_reg_375&call);
   assign  _net_382 = (_reg_375&call);
   assign  _net_383 = (_reg_375&call);
   assign  _net_384 = (_reg_375&call);
   assign  _net_385 = (call&_reg_376);
   assign  _net_386 = (call&_reg_376);
   assign  _net_387 = (call&_reg_376);
   assign  _net_388 = ((_proc_call_set|_proc_call_reset)|_reg_376);
   assign  _net_389 = (_proc_call_reset|(_reg_376|(_reg_375|_reg_376)));
   assign  _net_390 = (_proc_call_reset|(_reg_374|_reg_375));
   assign  _net_394 = (_reg_391&ret);
   assign  _net_395 = (_reg_391&ret);
   assign  _net_396 = (_reg_391&ret);
   assign  _net_397 = (_reg_392&ret);
   assign  _net_398 = (_reg_392&ret);
   assign  _net_399 = (_reg_392&ret);
   assign  _net_400 = (ret&_reg_393);
   assign  _net_401 = (ret&_reg_393);
   assign  _net_402 = (ret&_reg_393);
   assign  _net_403 = (ret&_reg_393);
   assign  _net_404 = (ret&_reg_393);
   assign  _net_405 = ((_proc_ret_set|_proc_ret_reset)|_reg_393);
   assign  _net_406 = (_proc_ret_reset|(_reg_393|(_reg_392|_reg_393)));
   assign  _net_407 = (_proc_ret_reset|(_reg_391|_reg_392));
   assign  _net_414 = (_reg_408&svc);
   assign  _net_415 = (_reg_408&svc);
   assign  _net_416 = (_reg_408&svc);
   assign  _net_417 = (_reg_408&svc);
   assign  _net_418 = (_reg_408&svc);
   assign  _net_419 = (_reg_409&svc);
   assign  _net_420 = (_reg_409&svc);
   assign  _net_421 = (_reg_409&svc);
   assign  _net_422 = (_reg_409&svc);
   assign  _net_423 = (_reg_409&svc);
   assign  _net_424 = (_reg_409&svc);
   assign  _net_425 = (_reg_409&svc);
   assign  _net_426 = (_reg_410&svc);
   assign  _net_427 = (_reg_410&svc);
   assign  _net_428 = (_reg_410&svc);
   assign  _net_429 = (_reg_410&svc);
   assign  _net_430 = (_reg_410&svc);
   assign  _net_431 = (_reg_411&svc);
   assign  _net_432 = (_reg_411&svc);
   assign  _net_433 = (_reg_411&svc);
   assign  _net_434 = (_reg_412&svc);
   assign  _net_435 = (_reg_412&svc);
   assign  _net_436 = (_reg_412&svc);
   assign  _net_437 = (_reg_412&svc);
   assign  _net_438 = (_reg_412&svc);
   assign  _net_439 = (svc&_reg_413);
   assign  _net_440 = (svc&_reg_413);
   assign  _net_441 = (svc&_reg_413);
   assign  _net_442 = ((_proc_svc_set|_proc_svc_reset)|_reg_413);
   assign  _net_443 = (_proc_svc_reset|(_reg_413|(_reg_412|_reg_413)));
   assign  _net_444 = (_proc_svc_reset|(_reg_411|_reg_412));
   assign  _net_445 = (_proc_svc_reset|(_reg_410|_reg_411));
   assign  _net_446 = (_proc_svc_reset|(_reg_409|_reg_410));
   assign  _net_447 = (_proc_svc_reset|(_reg_408|_reg_409));
   assign  _net_451 = (_reg_448&reti);
   assign  _net_452 = (_reg_448&reti);
   assign  _net_453 = (_reg_448&reti);
   assign  _net_454 = (_reg_449&reti);
   assign  _net_455 = (_reg_449&reti);
   assign  _net_456 = (_reg_449&reti);
   assign  _net_457 = (_reg_449&reti);
   assign  _net_458 = (_reg_449&reti);
   assign  _net_459 = (_reg_449&reti);
   assign  _net_460 = (_reg_449&reti);
   assign  _net_461 = (_reg_449&reti);
   assign  _net_462 = (_reg_449&reti);
   assign  _net_463 = (reti&_reg_450);
   assign  _net_464 = (reti&_reg_450);
   assign  _net_465 = (reti&_reg_450);
   assign  _net_466 = (reti&_reg_450);
   assign  _net_467 = (reti&_reg_450);
   assign  _net_468 = (reti&_reg_450);
   assign  _net_469 = (reti&_reg_450);
   assign  _net_470 = (reti&_reg_450);
   assign  _net_471 = ((_proc_reti_set|_proc_reti_reset)|_reg_450);
   assign  _net_472 = (_proc_reti_reset|(_reg_450|(_reg_449|_reg_450)));
   assign  _net_473 = (_proc_reti_reset|(_reg_448|_reg_449));
   assign  _net_474 = ((_net_477)?(oof^(mdr[15])):1'b0)|
    ((_net_476)?of:1'b0);
   assign  _net_475 = ((_opreg_sop[0]));
   assign  _net_476 = (wt&_net_475);
   assign  _net_477 = (wt&(~_net_475));
   assign  _net_483 = (_reg_478&int_req);
   assign  _net_484 = (_reg_478&int_req);
   assign  _net_485 = (_reg_478&int_req);
   assign  _net_486 = (_reg_478&int_req);
   assign  _net_487 = (_reg_478&int_req);
   assign  _net_488 = (_reg_478&int_req);
   assign  _net_489 = (_reg_478&int_req);
   assign  _net_490 = (_reg_478&int_req);
   assign  _net_491 = (_reg_479&int_req);
   assign  _net_492 = (_reg_479&int_req);
   assign  _net_493 = (_reg_479&int_req);
   assign  _net_494 = (_reg_479&int_req);
   assign  _net_495 = (_reg_479&int_req);
   assign  _net_496 = (_reg_480&int_req);
   assign  _net_497 = (_reg_480&int_req);
   assign  _net_498 = (_reg_480&int_req);
   assign  _net_499 = (_reg_481&int_req);
   assign  _net_500 = (_reg_481&int_req);
   assign  _net_501 = (_reg_481&int_req);
   assign  _net_502 = (_reg_481&int_req);
   assign  _net_503 = (_reg_481&int_req);
   assign  _net_504 = (int_req&_reg_482);
   assign  _net_505 = (int_req&_reg_482);
   assign  _net_506 = (int_req&_reg_482);
   assign  _net_507 = ((_proc_int_req_set|_proc_int_req_reset)|_reg_482);
   assign  _net_508 = (_proc_int_req_reset|(_reg_482|(_reg_481|_reg_482)));
   assign  _net_509 = (_proc_int_req_reset|(_reg_480|_reg_481));
   assign  _net_510 = (_proc_int_req_reset|(_reg_479|_reg_480));
   assign  _net_511 = (_proc_int_req_reset|(_reg_478|_reg_479));
   assign  datao = ((_net_500)?(flag&16'b0111111111111111):16'b0)|
    (((_net_492|(_net_427|_net_381)))?pr:16'b0)|
    (((_net_435|_net_346))?flag:16'b0)|
    ((_net_314)?mar:16'b0)|
    ((_net_102)?_gr_regouta:16'b0);
   assign  adrs = ((_net_416)?mdr:16'b0)|
    (((_net_503|(_net_495|(_net_488|(_net_466|(_net_458|(_net_438|(_net_430|(_net_403|(_net_384|(_net_369|(_net_349|(_net_334|_net_317)))))))))))))?_gr_regouta:16'b0)|
    (((_net_119|(_net_113|_net_103)))?mar:16'b0)|
    (((_net_44|_net_23))?pr:16'b0);
   assign  memory_read = (_net_487|(_net_465|(_net_457|(_net_415|(_net_402|(_net_368|(_net_334|(_net_118|(_net_112|(_net_43|_net_22))))))))));
   assign  memory_write = (_net_499|(_net_491|(_net_434|(_net_426|(_net_380|(_net_345|(_net_313|_net_99)))))));
   assign  hlt = _net_129;
always @(posedge m_clock)
  begin
if (((_net_489|(_net_467|(_net_417|_net_404))))|((_net_378|_net_165))|(_net_136)|((wt|(wb|(_net_452|(_net_395|(_net_360|(_net_343|(_net_328|(_net_311|(_net_168|(_net_106|(_net_96|_net_36))))))))))))|((_net_48|_net_32))|(start)) 
      pr <= (((_net_489|(_net_467|(_net_417|_net_404)))) ?datai:16'b0)|
    (((_net_378|_net_165)) ?mar:16'b0)|
    ((_net_136) ?_alu_q:16'b0)|
    (((wt|(wb|(_net_452|(_net_395|(_net_360|(_net_343|(_net_328|(_net_311|(_net_168|(_net_106|(_net_96|_net_36)))))))))))) ?pr:16'b0)|
    (((_net_48|_net_32)) ?_inc_q:16'b0)|
    ((start) ?16'b0000000000000000:16'b0);

end
always @(posedge m_clock)
  begin
if ((_net_29)) 
      _opreg_r2 <= (_net_24[3:0]);
end
always @(posedge m_clock)
  begin
if ((_net_28)) 
      _opreg_r1 <= (_net_24[7:4]);
end
always @(posedge m_clock)
  begin
if ((_net_27)) 
      _opreg_sop <= (_net_24[11:8]);
end
always @(posedge m_clock)
  begin
if ((_net_26)) 
      _opreg_mop <= (_net_24[15:12]);
end
always @(posedge m_clock)
  begin
if ((_net_120)|((_net_87|_net_72))|((_net_80|_net_62))|((_net_53|_net_42))) 
      mar <= ((_net_120) ?datai:16'b0)|
    (((_net_87|_net_72)) ?_alu_q:16'b0)|
    (((_net_80|_net_62)) ?mdr:16'b0)|
    (((_net_53|_net_42)) ?_gr_regoutb:16'b0);

end
always @(posedge m_clock)
  begin
if (((_net_425|(_net_297|(_net_287|(_net_277|(_net_267|(_net_257|(_net_247|(_net_237|(_net_227|(_net_217|(_net_207|(_net_197|(_net_187|_net_177))))))))))))))|((_net_305|(_net_75|_net_65)))|((_net_123|_net_56))|((_net_114|_net_45))) 
      mdr <= (((_net_425|(_net_297|(_net_287|(_net_277|(_net_267|(_net_257|(_net_247|(_net_237|(_net_227|(_net_217|(_net_207|(_net_197|(_net_187|_net_177)))))))))))))) ?_alu_q:16'b0)|
    (((_net_305|(_net_75|_net_65))) ?_gr_regoutb:16'b0)|
    (((_net_123|_net_56)) ?_gr_regouta:16'b0)|
    (((_net_114|_net_45)) ?datai:16'b0);

end
always @(posedge m_clock)
  begin
if (((_net_306|(_net_298|(_net_288|(_net_278|(_net_268|(_net_258|(_net_248|(_net_238|(_net_228|(_net_218|(_net_208|(_net_198|(_net_188|(_net_178|_net_115)))))))))))))))) 
      regnum <= _opreg_r1;
end
always @(posedge m_clock)
  begin
if (p_reset)
     qf <= 1'b0;
else if ((_net_483)|(set_flag)) 
      qf <= ((_net_483) ?1'b0:1'b0)|
    ((set_flag) ?(_net_16[3:3]):1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     oof <= 1'b0;
else if (((_net_292|(_net_282|(_net_272|(_net_262|(_net_222|(_net_212|(_net_202|(_net_192|(_net_182|_net_172))))))))))|((wt|(_net_302|(_net_252|(_net_242|(_net_232|_net_111))))))|(set_flag)) 
      oof <= (((_net_292|(_net_282|(_net_272|(_net_262|(_net_222|(_net_212|(_net_202|(_net_192|(_net_182|_net_172)))))))))) ?_alu_ov:1'b0)|
    (((wt|(_net_302|(_net_252|(_net_242|(_net_232|_net_111)))))) ?1'b0:1'b0)|
    ((set_flag) ?(_net_16[2:2]):1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     sf <= 1'b0;
else if ((wt)|(wb)|(set_flag)) 
      sf <= ((wt) ?_net_474:1'b0)|
    ((wb) ?(mdr[15]):1'b0)|
    ((set_flag) ?(_net_16[1:1]):1'b0);

end
always @(posedge m_clock)
  begin
if (p_reset)
     zf <= 1'b0;
else if (((wt|wb))|(set_flag)) 
      zf <= (((wt|wb)) ?(mdr==16'b0000000000000000):1'b0)|
    ((set_flag) ?(_net_16[0:0]):1'b0);

end
always @(posedge m_clock)
  begin
  ei0 <= ext_int;
end
always @(posedge m_clock)
  begin
  ei1 <= ei0;
end
always @(posedge m_clock)
  begin
  ei2 <= ei1;
end
always @(posedge m_clock)
  begin
if (p_reset)
     ifetch <= 1'b0;
else if ((_net_0)) 
      ifetch <= _proc_ifetch_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     decode <= 1'b0;
else if ((_net_1)) 
      decode <= _proc_decode_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     oaddr <= 1'b0;
else if ((_net_2)) 
      oaddr <= _proc_oaddr_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     oload <= 1'b0;
else if ((_net_3)) 
      oload <= _proc_oload_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     exec <= 1'b0;
else if ((_net_4)) 
      exec <= _proc_exec_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     wb <= 1'b0;
else if ((_net_5)) 
      wb <= _proc_wb_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     wt <= 1'b0;
else if ((_net_6)) 
      wt <= _proc_wt_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     push <= 1'b0;
else if ((_net_15)) 
      push <= _proc_push_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     pop <= 1'b0;
else if ((_net_14)) 
      pop <= _proc_pop_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     call <= 1'b0;
else if ((_net_13)) 
      call <= _proc_call_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     ret <= 1'b0;
else if ((_net_12)) 
      ret <= _proc_ret_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     svc <= 1'b0;
else if ((_net_11)) 
      svc <= _proc_svc_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     reti <= 1'b0;
else if ((_net_10)) 
      reti <= _proc_reti_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     int_req <= 1'b0;
else if ((_net_9)) 
      int_req <= _proc_int_req_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     pushf <= 1'b0;
else if ((_net_8)) 
      pushf <= _proc_pushf_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     popf <= 1'b0;
else if ((_net_7)) 
      popf <= _proc_popf_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_307 <= 1'b0;
else if ((_net_323)) 
      _reg_307 <= (_reg_308&(~_proc_push_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_308 <= 1'b0;
else if ((_net_322)) 
      _reg_308 <= (_reg_309&(~_proc_push_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_309 <= 1'b0;
else if ((_net_321)) 
      _reg_309 <= _proc_push_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_324 <= 1'b0;
else if ((_net_338)) 
      _reg_324 <= (_reg_325&(~_proc_pop_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_325 <= 1'b0;
else if ((_net_337)) 
      _reg_325 <= (_reg_326&(~_proc_pop_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_326 <= 1'b0;
else if ((_net_336)) 
      _reg_326 <= _proc_pop_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_339 <= 1'b0;
else if ((_net_355)) 
      _reg_339 <= (_reg_340&(~_proc_pushf_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_340 <= 1'b0;
else if ((_net_354)) 
      _reg_340 <= (_reg_341&(~_proc_pushf_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_341 <= 1'b0;
else if ((_net_353)) 
      _reg_341 <= _proc_pushf_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_356 <= 1'b0;
else if ((_net_373)) 
      _reg_356 <= (_reg_357&(~_proc_popf_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_357 <= 1'b0;
else if ((_net_372)) 
      _reg_357 <= (_reg_358&(~_proc_popf_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_358 <= 1'b0;
else if ((_net_371)) 
      _reg_358 <= _proc_popf_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_374 <= 1'b0;
else if ((_net_390)) 
      _reg_374 <= (_reg_375&(~_proc_call_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_375 <= 1'b0;
else if ((_net_389)) 
      _reg_375 <= (_reg_376&(~_proc_call_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_376 <= 1'b0;
else if ((_net_388)) 
      _reg_376 <= _proc_call_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_391 <= 1'b0;
else if ((_net_407)) 
      _reg_391 <= (_reg_392&(~_proc_ret_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_392 <= 1'b0;
else if ((_net_406)) 
      _reg_392 <= (_reg_393&(~_proc_ret_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_393 <= 1'b0;
else if ((_net_405)) 
      _reg_393 <= _proc_ret_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_408 <= 1'b0;
else if ((_net_447)) 
      _reg_408 <= (_reg_409&(~_proc_svc_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_409 <= 1'b0;
else if ((_net_446)) 
      _reg_409 <= (_reg_410&(~_proc_svc_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_410 <= 1'b0;
else if ((_net_445)) 
      _reg_410 <= (_reg_411&(~_proc_svc_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_411 <= 1'b0;
else if ((_net_444)) 
      _reg_411 <= (_reg_412&(~_proc_svc_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_412 <= 1'b0;
else if ((_net_443)) 
      _reg_412 <= (_reg_413&(~_proc_svc_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_413 <= 1'b0;
else if ((_net_442)) 
      _reg_413 <= _proc_svc_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_448 <= 1'b0;
else if ((_net_473)) 
      _reg_448 <= (_reg_449&(~_proc_reti_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_449 <= 1'b0;
else if ((_net_472)) 
      _reg_449 <= (_reg_450&(~_proc_reti_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_450 <= 1'b0;
else if ((_net_471)) 
      _reg_450 <= _proc_reti_set;
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_478 <= 1'b0;
else if ((_net_511)) 
      _reg_478 <= (_reg_479&(~_proc_int_req_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_479 <= 1'b0;
else if ((_net_510)) 
      _reg_479 <= (_reg_480&(~_proc_int_req_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_480 <= 1'b0;
else if ((_net_509)) 
      _reg_480 <= (_reg_481&(~_proc_int_req_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_481 <= 1'b0;
else if ((_net_508)) 
      _reg_481 <= (_reg_482&(~_proc_int_req_reset));
end
always @(posedge m_clock)
  begin
if (p_reset)
     _reg_482 <= 1'b0;
else if ((_net_507)) 
      _reg_482 <= _proc_int_req_set;
end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module shift16 ( p_reset , m_clock , in , sa , f , q , ov , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] in;
  wire [15:0] in;
  input [15:0] sa;
  wire [15:0] sa;
  input [3:0] f;
  wire [3:0] f;
  output [15:0] q;
  wire [15:0] q;
  output ov;
  wire ov;
  input exe;
  wire exe;
  wire [16:0] sta;
  wire [16:0] stb;
  wire [16:0] stc;
  wire [16:0] std;
  wire [16:0] ste;
  wire right;
  wire arith;
  wire _net_512;
  wire _net_513;
  wire _net_514;
  wire _net_515;
  wire _net_516;
  wire _net_517;
  wire _net_518;
  wire _net_519;
  wire _net_520;
  wire _net_521;
  wire _net_522;
  wire _net_523;
  wire _net_524;
  wire _net_525;
  wire _net_526;
  wire [16:0] _net_527;
  wire _net_528;
  wire _net_529;
  wire _net_530;
  wire [16:0] _net_531;
  wire _net_532;
  wire _net_533;
  wire _net_534;
  wire _net_535;
  wire _net_536;
  wire _net_537;
  wire [16:0] _net_538;
  wire [8:0] _net_539;
  wire _net_540;
  wire _net_541;
  wire _net_542;
  wire [16:0] _net_543;
  wire _net_544;
  wire _net_545;
  wire _net_546;
  wire _net_547;
  wire _net_548;
  wire _net_549;
  wire [16:0] _net_550;
  wire [12:0] _net_551;
  wire _net_552;
  wire _net_553;
  wire _net_554;
  wire [16:0] _net_555;
  wire _net_556;
  wire _net_557;
  wire _net_558;
  wire _net_559;
  wire _net_560;
  wire _net_561;
  wire [16:0] _net_562;
  wire [14:0] _net_563;
  wire _net_564;
  wire _net_565;
  wire _net_566;
  wire [16:0] _net_567;
  wire _net_568;
  wire _net_569;
  wire _net_570;
  wire _net_571;
  wire [15:0] _net_572;
  wire _net_573;
  wire [15:0] _net_574;
  wire _net_575;
  wire _net_576;
  wire [16:0] _net_577;
  wire _net_578;
  wire [15:0] _net_579;
  wire _net_580;
  wire _net_581;
  wire [16:0] _net_582;
  wire _net_583;
  wire [15:0] _net_584;
  wire _net_585;
  wire _net_586;

   assign  sta = ((_net_586)?_net_582:17'b0)|
    ((_net_581)?_net_577:17'b0)|
    ((_net_575)?({1'b0,_net_574}):17'b0)|
    ((_net_573)?(({1'b0,_net_572})<<1):17'b0);
   assign  stb = ((_net_570)?_net_567:17'b0)|
    ((_net_566)?_net_562:17'b0)|
    ((_net_560)?sta:17'b0);
   assign  stc = ((_net_558)?_net_555:17'b0)|
    ((_net_554)?_net_550:17'b0)|
    ((_net_548)?stb:17'b0);
   assign  std = ((_net_546)?_net_543:17'b0)|
    ((_net_542)?_net_538:17'b0)|
    ((_net_536)?stc:17'b0);
   assign  ste = ((_net_534)?_net_531:17'b0)|
    ((_net_530)?_net_527:17'b0)|
    ((_net_525)?std:17'b0);
   assign  right = ((f==4'b1001)|(f==4'b1011));
   assign  arith = ((f==4'b1001)|(f==4'b1000));
   assign  _net_512 = (f==4'b1011);
   assign  _net_513 = (exe&_net_512);
   assign  _net_514 = (exe&_net_512);
   assign  _net_515 = (f==4'b1001);
   assign  _net_516 = (exe&_net_515);
   assign  _net_517 = (exe&_net_515);
   assign  _net_518 = (f==4'b1010);
   assign  _net_519 = (exe&_net_518);
   assign  _net_520 = (exe&_net_518);
   assign  _net_521 = (f==4'b1000);
   assign  _net_522 = (exe&_net_521);
   assign  _net_523 = (exe&_net_521);
   assign  _net_524 = (~(sa[4]));
   assign  _net_525 = (exe&_net_524);
   assign  _net_526 = (sa[4]);
   assign  _net_527 = ((_net_529)?(std>>16):17'b0)|
    ((_net_528)?({({(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16]),(std[16])}),(std[16])}):17'b0);
   assign  _net_528 = (((exe&_net_526)&right)&arith);
   assign  _net_529 = (((exe&_net_526)&right)&(~arith));
   assign  _net_530 = ((exe&_net_526)&right);
   assign  _net_531 = ((_net_533)?(std<<16):17'b0)|
    ((_net_532)?({1'b0,(std[15]),({({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),1'b0})}):17'b0);
   assign  _net_532 = (((exe&_net_526)&(~right))&arith);
   assign  _net_533 = (((exe&_net_526)&(~right))&(~arith));
   assign  _net_534 = ((exe&_net_526)&(~right));
   assign  _net_535 = (~(sa[3]));
   assign  _net_536 = (exe&_net_535);
   assign  _net_537 = (sa[3]);
   assign  _net_538 = ((_net_541)?(stc>>8):17'b0)|
    ((_net_540)?({({(_net_539[8]),(_net_539[8]),(_net_539[8]),(_net_539[8]),(_net_539[8]),(_net_539[8]),(_net_539[8]),(_net_539[8])}),(stc[16:8])}):17'b0);
   assign  _net_539 = (stc[16:8]);
   assign  _net_540 = (((exe&_net_537)&right)&arith);
   assign  _net_541 = (((exe&_net_537)&right)&(~arith));
   assign  _net_542 = ((exe&_net_537)&right);
   assign  _net_543 = ((_net_545)?(stc<<8):17'b0)|
    ((_net_544)?({(stc[7]),(stc[15]),(stc[6:0]),8'b00000000}):17'b0);
   assign  _net_544 = (((exe&_net_537)&(~right))&arith);
   assign  _net_545 = (((exe&_net_537)&(~right))&(~arith));
   assign  _net_546 = ((exe&_net_537)&(~right));
   assign  _net_547 = (~(sa[2]));
   assign  _net_548 = (exe&_net_547);
   assign  _net_549 = (sa[2]);
   assign  _net_550 = ((_net_553)?(stb>>4):17'b0)|
    ((_net_552)?({({(_net_551[12]),(_net_551[12]),(_net_551[12]),(_net_551[12])}),(stb[16:4])}):17'b0);
   assign  _net_551 = (stb[16:4]);
   assign  _net_552 = (((exe&_net_549)&right)&arith);
   assign  _net_553 = (((exe&_net_549)&right)&(~arith));
   assign  _net_554 = ((exe&_net_549)&right);
   assign  _net_555 = ((_net_557)?(stb<<4):17'b0)|
    ((_net_556)?({(stb[11]),(stb[15]),(stb[10:0]),4'b0000}):17'b0);
   assign  _net_556 = (((exe&_net_549)&(~right))&arith);
   assign  _net_557 = (((exe&_net_549)&(~right))&(~arith));
   assign  _net_558 = ((exe&_net_549)&(~right));
   assign  _net_559 = (~(sa[1]));
   assign  _net_560 = (exe&_net_559);
   assign  _net_561 = (sa[1]);
   assign  _net_562 = ((_net_565)?(sta>>2):17'b0)|
    ((_net_564)?({({(_net_563[14]),(_net_563[14])}),(sta[16:2])}):17'b0);
   assign  _net_563 = (sta[16:2]);
   assign  _net_564 = (((exe&_net_561)&right)&arith);
   assign  _net_565 = (((exe&_net_561)&right)&(~arith));
   assign  _net_566 = ((exe&_net_561)&right);
   assign  _net_567 = ((_net_569)?(sta<<2):17'b0)|
    ((_net_568)?({(sta[13]),(sta[15]),(sta[12:0]),2'b00}):17'b0);
   assign  _net_568 = (((exe&_net_561)&(~right))&arith);
   assign  _net_569 = (((exe&_net_561)&(~right))&(~arith));
   assign  _net_570 = ((exe&_net_561)&(~right));
   assign  _net_571 = (~(sa[0]));
   assign  _net_572 = in;
   assign  _net_573 = ((exe&_net_571)&right);
   assign  _net_574 = in;
   assign  _net_575 = ((exe&_net_571)&(~right));
   assign  _net_576 = (sa[0]);
   assign  _net_577 = ((_net_580)?({1'b0,_net_579}):17'b0)|
    ((_net_578)?({({(in[15])}),in}):17'b0);
   assign  _net_578 = (((exe&_net_576)&right)&arith);
   assign  _net_579 = in;
   assign  _net_580 = (((exe&_net_576)&right)&(~arith));
   assign  _net_581 = ((exe&_net_576)&right);
   assign  _net_582 = ((_net_585)?(({1'b0,_net_584})<<1):17'b0)|
    ((_net_583)?({(in[14]),(in[15]),(in[13:0]),1'b0}):17'b0);
   assign  _net_583 = (((exe&_net_576)&(~right))&arith);
   assign  _net_584 = in;
   assign  _net_585 = (((exe&_net_576)&(~right))&(~arith));
   assign  _net_586 = ((exe&_net_576)&(~right));
   assign  q = (((_net_523|_net_520))?(ste[15:0]):16'b0)|
    (((_net_517|_net_514))?(ste[16:1]):16'b0);
   assign  ov = (((_net_522|_net_519))?(ste[16]):1'b0)|
    (((_net_516|_net_513))?(ste[0]):1'b0);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module alu16 ( p_reset , m_clock , a , b , f , q , ov , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] a;
  wire [15:0] a;
  input [15:0] b;
  wire [15:0] b;
  input [3:0] f;
  wire [3:0] f;
  output [15:0] q;
  wire [15:0] q;
  output ov;
  wire ov;
  input exe;
  wire exe;
  wire _cla_cin;
  wire [15:0] _cla_in1;
  wire [15:0] _cla_in2;
  wire [15:0] _cla_q;
  wire _cla_ov;
  wire _cla_co;
  wire _cla_exe;
  wire _cla_p_reset;
  wire _cla_m_clock;
  wire [15:0] _bsft_in;
  wire [15:0] _bsft_sa;
  wire [3:0] _bsft_f;
  wire [15:0] _bsft_q;
  wire _bsft_ov;
  wire _bsft_exe;
  wire _bsft_p_reset;
  wire _bsft_m_clock;
  wire _net_587;
  wire _net_588;
  wire _net_589;
  wire _net_590;
  wire _net_591;
  wire _net_592;
  wire _net_593;
  wire _net_594;
  wire _net_595;
  wire _net_596;
  wire _net_597;
  wire _net_598;
  wire _net_599;
  wire _net_600;
  wire _net_601;
  wire _net_602;
  wire _net_603;
  wire _net_604;
  wire _net_605;
  wire _net_606;
  wire _net_607;
  wire _net_608;
  wire _net_609;
  wire _net_610;
  wire _net_611;
  wire _net_612;
  wire _net_613;
  wire _net_614;
  wire _net_615;
  wire _net_616;
  wire _net_617;
  wire _net_618;
  wire _net_619;
  wire _net_620;
  wire _net_621;
  wire _net_622;
  wire _net_623;
  wire _net_624;
  wire _net_625;
  wire _net_626;
  wire _net_627;
  wire _net_628;
  wire _net_629;
  wire _net_630;
  wire _net_631;
  wire _net_632;
  wire _net_633;
  wire _net_634;
  wire _net_635;
  wire _net_636;
  wire _net_637;
  wire _net_638;
  wire _net_639;
  wire _net_640;
  wire _net_641;
  wire _net_642;
  wire _net_643;
  wire _net_644;
  wire _net_645;
  wire _net_646;
  wire _net_647;
  wire _net_648;
shift16 bsft (.m_clock(m_clock), .p_reset(p_reset), .exe(_bsft_exe), .ov(_bsft_ov), .q(_bsft_q), .f(_bsft_f), .sa(_bsft_sa), .in(_bsft_in));
cla16 cla (.m_clock(m_clock), .p_reset(p_reset), .exe(_cla_exe), .ov(_cla_ov), .co(_cla_co), .q(_cla_q), .in2(_cla_in2), .in1(_cla_in1), .cin(_cla_cin));

   assign  _cla_cin = (((_net_647|_net_640))?1'b0:1'b0)|
    (((_net_633|_net_626))?1'b1:1'b0);
   assign  _cla_in1 = a;
   assign  _cla_in2 = (((_net_645|_net_638))?b:16'b0)|
    (((_net_631|_net_624))?(~b):16'b0);
   assign  _cla_exe = (_net_644|(_net_637|(_net_630|_net_623)));
   assign  _cla_p_reset = p_reset;
   assign  _cla_m_clock = m_clock;
   assign  _bsft_in = a;
   assign  _bsft_sa = b;
   assign  _bsft_f = ((_net_613)?4'b1000:4'b0)|
    ((_net_606)?4'b1001:4'b0)|
    ((_net_599)?4'b1010:4'b0)|
    ((_net_592)?4'b1011:4'b0);
   assign  _bsft_exe = (_net_610|(_net_603|(_net_596|_net_589)));
   assign  _bsft_p_reset = p_reset;
   assign  _bsft_m_clock = m_clock;
   assign  _net_587 = (f==4'b1011);
   assign  _net_588 = (exe&_net_587);
   assign  _net_589 = (exe&_net_587);
   assign  _net_590 = (exe&_net_587);
   assign  _net_591 = (exe&_net_587);
   assign  _net_592 = (exe&_net_587);
   assign  _net_593 = (exe&_net_587);
   assign  _net_594 = (f==4'b1010);
   assign  _net_595 = (exe&_net_594);
   assign  _net_596 = (exe&_net_594);
   assign  _net_597 = (exe&_net_594);
   assign  _net_598 = (exe&_net_594);
   assign  _net_599 = (exe&_net_594);
   assign  _net_600 = (exe&_net_594);
   assign  _net_601 = (f==4'b1001);
   assign  _net_602 = (exe&_net_601);
   assign  _net_603 = (exe&_net_601);
   assign  _net_604 = (exe&_net_601);
   assign  _net_605 = (exe&_net_601);
   assign  _net_606 = (exe&_net_601);
   assign  _net_607 = (exe&_net_601);
   assign  _net_608 = (f==4'b1000);
   assign  _net_609 = (exe&_net_608);
   assign  _net_610 = (exe&_net_608);
   assign  _net_611 = (exe&_net_608);
   assign  _net_612 = (exe&_net_608);
   assign  _net_613 = (exe&_net_608);
   assign  _net_614 = (exe&_net_608);
   assign  _net_615 = (f==4'b0111);
   assign  _net_616 = (exe&_net_615);
   assign  _net_617 = (f==4'b0110);
   assign  _net_618 = (exe&_net_617);
   assign  _net_619 = (f==4'b0101);
   assign  _net_620 = (exe&_net_619);
   assign  _net_621 = (f==4'b0100);
   assign  _net_622 = (exe&_net_621);
   assign  _net_623 = (exe&_net_621);
   assign  _net_624 = (exe&_net_621);
   assign  _net_625 = (exe&_net_621);
   assign  _net_626 = (exe&_net_621);
   assign  _net_627 = (exe&_net_621);
   assign  _net_628 = (f==4'b0010);
   assign  _net_629 = (exe&_net_628);
   assign  _net_630 = (exe&_net_628);
   assign  _net_631 = (exe&_net_628);
   assign  _net_632 = (exe&_net_628);
   assign  _net_633 = (exe&_net_628);
   assign  _net_634 = (exe&_net_628);
   assign  _net_635 = (f==4'b0011);
   assign  _net_636 = (exe&_net_635);
   assign  _net_637 = (exe&_net_635);
   assign  _net_638 = (exe&_net_635);
   assign  _net_639 = (exe&_net_635);
   assign  _net_640 = (exe&_net_635);
   assign  _net_641 = (exe&_net_635);
   assign  _net_642 = (f==4'b0001);
   assign  _net_643 = (exe&_net_642);
   assign  _net_644 = (exe&_net_642);
   assign  _net_645 = (exe&_net_642);
   assign  _net_646 = (exe&_net_642);
   assign  _net_647 = (exe&_net_642);
   assign  _net_648 = (exe&_net_642);
   assign  q = (((_net_648|(_net_641|(_net_634|_net_627))))?_cla_q:16'b0)|
    ((_net_620)?(a&b):16'b0)|
    ((_net_618)?(a|b):16'b0)|
    ((_net_616)?(a^b):16'b0)|
    (((_net_614|(_net_607|(_net_600|_net_593))))?_bsft_q:16'b0);
   assign  ov = ((_net_636)?_cla_co:1'b0)|
    (((_net_643|_net_629))?_cla_ov:1'b0)|
    ((_net_622)?(~_cla_co):1'b0)|
    (((_net_609|(_net_602|(_net_595|_net_588))))?_bsft_ov:1'b0);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module cla16 ( p_reset , m_clock , cin , in1 , in2 , q , ov , co , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input cin;
  wire cin;
  input [15:0] in1;
  wire [15:0] in1;
  input [15:0] in2;
  wire [15:0] in2;
  output [15:0] q;
  wire [15:0] q;
  output ov;
  wire ov;
  output co;
  wire co;
  input exe;
  wire exe;
  wire [14:0] t1;
  wire [14:0] t2;
  wire t1m;
  wire t2m;
  wire [15:0] tp;
  wire [1:0] to;
  wire [15:0] _net_649;
  wire [15:0] _net_650;
  wire [14:0] _net_651;
  wire [14:0] _net_652;
  wire _net_653;
  wire [14:0] _net_654;
  wire _net_655;
  wire _net_656;
  wire _net_657;

   assign  t1 = (_net_649[14:0]);
   assign  t2 = (_net_650[14:0]);
   assign  t1m = (_net_649[15:15]);
   assign  t2m = (_net_650[15:15]);
   assign  tp = ((({1'b0,_net_651})+({1'b0,_net_652}))+({1'b0,_net_654}));
   assign  to = ((({1'b0,_net_655})+({1'b0,_net_656}))+({1'b0,_net_657}));
   assign  _net_649 = in1;
   assign  _net_650 = in2;
   assign  _net_651 = t1;
   assign  _net_652 = t2;
   assign  _net_653 = cin;
   assign  _net_654 = ({14'b00000000000000,_net_653});
   assign  _net_655 = (tp[15]);
   assign  _net_656 = t1m;
   assign  _net_657 = t2m;
   assign  q = ({(to[0]),(tp[14:0])});
   assign  ov = ((to[1])^(tp[15]));
   assign  co = (to[1]);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module reg16 ( p_reset , m_clock , regin , regouta , regoutb , n_regin , n_regouta , n_regoutb , write , reada , readb );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] regin;
  wire [15:0] regin;
  output [15:0] regouta;
  wire [15:0] regouta;
  output [15:0] regoutb;
  wire [15:0] regoutb;
  input [3:0] n_regin;
  wire [3:0] n_regin;
  input [3:0] n_regouta;
  wire [3:0] n_regouta;
  input [3:0] n_regoutb;
  wire [3:0] n_regoutb;
  input write;
  wire write;
  input reada;
  wire reada;
  input readb;
  wire readb;
  reg [15:0] gr [0:15];

   assign  regouta = ((reada)?(gr[n_regouta]):16'b0);
   assign  regoutb = ((readb)?(gr[n_regoutb]):16'b0);
always @(posedge m_clock)
  begin
   if (write )
     gr[n_regin] <= regin;
end
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/
/*
 DO NOT USE ANY PART OF THIS FILE FOR COMMERCIAL PRODUCTS. 
*/

module inc16 ( p_reset , m_clock , a , q , exe );
  input p_reset, m_clock;
  wire p_reset, m_clock;
  input [15:0] a;
  wire [15:0] a;
  output [15:0] q;
  wire [15:0] q;
  input exe;
  wire exe;

   assign  q = (a+16'b0000000000000001);
endmodule
/*
 Produced by NSL Core(version=20151214), IP ARCH, Inc. Tue Mar 29 22:50:00 2016
 Licensed to :EVALUATION USER
*/

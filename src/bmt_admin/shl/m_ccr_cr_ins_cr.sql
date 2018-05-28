CREATE TABLE m_ccr_cr_ins_cr
(
  plyno character varying(16) NOT NULL, -- 증권번호
  cr_yymm character(6), -- 계약년월
  cnrdt date, -- 계약일자
  ins_itm_smccd character(10), -- 보험종목소분류코드
  ins_imcd character(10), -- 보험종목코드
  gdcd character(10), -- 상품코드
  gd_ty_flgcd character(10), -- 상품형태구분코드
  nw_rnw_flgcd character(10), -- 신규갱신구분코드
  ins_st date, -- 보험시기
  ins_st_yymm character(6), -- 보험시기년월
  ins_clstr date, -- 보험종기
  ins_clstr_yymm character(6), -- 보험종기년월
  ins_days numeric(5), -- 보험일수
  ap_prm numeric(17,2), -- 적용보험료
  trt_ap_cvr_prmsm numeric(17,2), -- 특약적용담보보험료합계
  dty_pym_mtdcd character(10), -- 의무납입방법코드
  optn_pym_mtdcd character(10), -- 임의납입방법코드
  holo_sign_yn character(1), -- 자필서명여부
  cr_chncd character(10), -- 계약채널코드
  same_ply_flgcd character(10), -- 동일증권구분코드
  fnl_cr_stcd character(10), -- 최종계약상태코드
  nrdps_ctmno character(9), -- 피보험자고객번호
  nrdps_lclcd character(10), -- 피보험자대분류코드
  nrdps_mdccd character(10), -- 피보험자중분류코드
  nrdps_smccd character(10), -- 피보험자소분류코드
  nrdps_age numeric(3), -- 피보험자연령
  nrdps_sexcd character(10), -- 피보험자성별코드
  nrdps_jbcd character(10), -- 피보험자직업코드
  nrdps_cr_oper_tycd character(10), -- 피보험자차량운행형태코드
  nrdps_adr_sd character varying(30), -- 피보험자주소시도
  nrdps_adr_sgng character varying(30), -- 피보험자주소시군구
  nrdps_adr_twmd character varying(30), -- 피보험자주소읍면동
  dh_stfno character(7), -- 취급직원번호
  dh_usr_no character(7), -- 취급사용인번호
  ce_stfno character(7), -- 모집직원번호
  ce_usrno character(7), -- 모집사용인번호
  cer_stf_flgcd character(10), -- 모집자직원구분코드
  cprtb_admno character(10), -- 협력점관리번호
  nsc_yn character(1), -- 계열사여부
  fscr_yn character(1), -- 선계약유무
  fscr_mntct numeric(4), -- 선계약개월수
  fscr_days numeric(9), -- 선계약일수
  clmct numeric(7), -- 사고건수
  crt_ctmno character(9), -- 계약자고객번호
  crt_age numeric(3), -- 계약자연령
  crt_sexcd character(10), -- 계약자성별코드
  crt_adr_sd character varying(30), -- 계약자주소시도
  crt_adr_sgng character varying(30), -- 계약자주소시군구
  crt_adr_twmd character varying(30), -- 계약자주소읍면동
  crt_jbcd character(10), -- 계약자직업코드
  prort_shtm_flgcd character(10), -- 일할단기구분코드
  rglt_vltcd character(10), -- 법규위반코드
  is_crrcd character(10), -- 가입경력코드
  spc_xccd character(10), -- 특별할증코드
  gn_co_obj_flgcd character(10), -- 일반공동물건구분코드
  bfcr_iscmp character(2), -- 전계약가입회사
  bfcr_ikdcd character(2), -- 전계약보종코드
  bfcr_year character(2), -- 전계약연도
  bfcr_no character(10), -- 전계약번호
  bfcr_ins_st date, -- 전계약보험시기
  bfcr_ins_clstr date, -- 전계약보험종기
  bfcr_aprt numeric(12,6), -- 전계약적용율
  udrtk_gu_arecd character(10), -- 인수지침지역코드
  pl_udrtk_grdcd character(10), -- 설계인수등급코드
  cr_udrtk_grdcd character(10), -- 계약인수등급코드
  sng_cr_flgcd character(10), -- 단독계약구분코드
  stsus_catcd character(10), -- 통계용차종코드
  cr_yytp character(4), -- 차량연식
  cramt numeric(15), -- 차량가액
  cr_vlamt_sm numeric(17,2), -- 차량가액합계
  airb_ct numeric(3), -- 에어백갯수
  dspl numeric(4), -- 배기량
  cnmcd character varying(11), -- 차명코드
  crncd character varying(20), -- 차량번호코드
  carno_hngl character varying(50), -- 차량번호한글
  chsno_or_tmpno character varying(30), -- 차대번호/임시번호
  ap_cr_tycd character(10), -- 적용차형태코드
  dma_foma_flgcd character(10), -- 국산외산구분코드
  cr_usecd character(10), -- 차량용도코드
  cr_prd_cmpcd character(10), -- 차량제작회사코드
  rpbl_stdrt numeric(12,6), -- 책임표준율
  optn_stdrt numeric(12,6), -- 임의표준율
  rpbl_spc_xcrt numeric(12,6), -- 책임특별할증율
  optn_spc_xcrt numeric(12,6), -- 임의특별할증율
  rglt_vltrt numeric(12,6), -- 법규위반율
  age_lmit_trtcd character(10), -- 연령한정특약코드
  drv_lmit_trtcd character(10), -- 운전자한정특약코드
  cmps_tr_trtcd character(10), -- 유상운송특약코드
  spcrt_rkgd_yn character(1), -- 특별요율위험물여부
  spcrt_spcl_eqp_yn character(1), -- 특별요율특수장치여부
  spcrt_crty_opus_yn character(1), -- 특별요율차형태운행용도여부
  spc_rt_airb_yn character(1), -- 특별요율에어백여부
  spcrt_abs_bag_yn character(1), -- 특별요율ABS장착여부
  spcrt_mch_eqp_yn character(1), -- 특별요율기계장치여부
  spcrt_co_us_yn character(1), -- 특별요율공동사용여부
  spcrt_rbpeq_rt_yn character(1), -- 특별요율도난방지장치요율여부
  spcrt_auto_yn character(1), -- 특별요율AUTO여부
  owcr_is_yn character(1), -- 자차가입여부
  owcr_isamt numeric(17,2), -- 자차가입금액
  ppr_plyno character varying(16), -- 상위증권번호
  cnn_ltrm_plyno character varying(16), -- 관련장기증권번호
  wcvis_yn character(1), -- 전담보가입여부
  onoff_nw_rnw_flgcd character(10), -- ONOFF신규갱신구분코드
  co_obj_as_yn character(1), -- 공동물건배정여부
  rgsct numeric(5), -- 정원수
  dvpns_plyno character varying(16), -- 개발원증권번호
  cr_grdcd character(10), -- 차량등급코드
  dc_xc_grdcd character(10), -- 할인할증등급코드
  onw_cr_flgcd character(10), -- 신구계약구분코드
  y3_clm_ct numeric(3), -- 3년사고횟수
  y1_clm_ct numeric(3), -- 1년사고횟수
  y1_clm_yn character(1), -- 1년사고유무
  plcd character(10) ,-- 플랜코드
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno);
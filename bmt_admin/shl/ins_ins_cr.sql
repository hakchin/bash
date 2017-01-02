CREATE TABLE ins_ins_cr
(
  plyno character varying(16) NOT NULL, -- 증권번호
  ap_nddt date NOT NULL, -- 적용종료일자
  ap_strdt date NOT NULL, -- 적용시작일자
  ndsno character(4) NOT NULL, -- 배서번호
  vald_nds_yn character(1) NOT NULL, -- 유효배서여부
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- 배서승인시작일시
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- 배서승인종료일시
  fnl_cr_stcd character(10), -- 최종계약상태코드
  fnl_cr_dt_stcd character(10), -- 최종계약세부상태코드
  fnl_cr_st_chdt date, -- 최종계약상태변경일자
  cnrdt date, -- 계약일자
  plno character varying(16), -- 설계번호
  cgaf_ch_seqno numeric(5), -- 발행후변경순번
  fnl_pym_seq numeric(5), -- 최종납입회차
  fnl_pym_yymm character(6), -- 최종납입년월
  ply_lvl_flgcd character(10) NOT NULL, -- 증권레벨구분코드
  gdcd character(10) NOT NULL, -- 상품코드
  ikd_grpcd character(10) NOT NULL, -- 보종군코드
  ins_imcd character(10), -- 보험종목코드
  nw_rnw_flgcd character(10), -- 신규갱신구분코드
  apldt date, -- 청약일자
  trm_sct_flgcd character(10), -- 기간구간구분코드
  ins_st date NOT NULL, -- 보험시기
  ins_st_hms character(4), -- 보험시기시각
  ins_clstr date NOT NULL, -- 보험종기
  ins_clstr_hms character(4), -- 보험종기시각
  ins_days numeric(5), -- 보험일수
  condt_t_ap_prm numeric(15) NOT NULL, -- 공동인수총적용보험료
  pym_mtdcd character(10), -- 납입방법코드
  ce_rowcd character(10), -- 모집경위코드
  ply_rc_mtdcd character(10), -- 증권수령방법코드
  holo_sign_yn character(1), -- 자필서명여부
  gr_cr_yn character(1), -- 단체계약여부
  cr_chncd character(10), -- 계약채널코드
  cprtb_admno character(10), -- 협력점관리번호
  cmpg_bj_yn character(1), -- 캠페인대상여부
  nrdct numeric(9), -- 피보험자수
  udrtk_tycd character(10), -- 인수형태코드
  crycd character(10), -- 계약형태코드
  otcm_mg_cmpcd character(10), -- 타사간사회사코드
  otcm_plyno character varying(25), -- 타사증권번호
  otcm_ply_ssdt date, -- 타사증권발행일자
  agmt_aqr_rt_flgcd character(10), -- 협정구득요율구분코드
  nsc_yn character(1), -- 계열사여부
  bk_admno character varying(20), -- 은행관리번호
  bk_brcd character(10), -- 은행지점코드
  bk_extn_qfp character(10), -- 은행유자격자
  bk_ipps character(10), -- 은행입력자
  hscs_hs_flgcd character(10), -- 가계비가계구분코드
  ps_cst_yn character(1), -- 보유품의여부
  rt_aqr_rqno character varying(20), -- 요율구득신청번호
  onw_cr_flgcd character(10), -- 신구계약구분코드
  rv_ccldt date, -- 수납취소일자
  fmlct numeric(5), -- 가족수
  bzcs_qtrt_ap_yn character(1), -- 사업비지분율적용여부
  prort_shtm_flgcd character(10), -- 일할단기구분코드
  same_ply_flgcd character(10), -- 동일증권구분코드
  dc_xc_ap_flgcd character(10), -- 할인할증적용구분코드
  pypof_symb character(10), -- 납입국기호
  rglt_vltct numeric(7), -- 법규위반건수
  rglt_vlt_poct numeric(3), -- 법규위반점수
  rglt_vltcd character(10), -- 법규위반코드
  is_crrcd character(10), -- 가입경력코드
  spc_xccd character(10), -- 특별할증코드
  dty_pym_mtdcd character(10), -- 의무납입방법코드
  pst_rpbl_is_yn character(1), -- 과거책임가입여부
  gn_co_obj_flgcd character(10), -- 일반공동물건구분코드
  co_obj_asno character varying(14), -- 공동물건배정번호
  bfcr_iscmp character(2), -- 전계약가입회사
  bfcr_ikdcd character(2), -- 전계약보종코드
  bfcr_year character(2), -- 전계약연도
  bfcr_no character(10), -- 전계약번호
  bfcr_ins_st date, -- 전계약보험시기
  bfcr_ins_clstr date, -- 전계약보험종기
  bfcr_aprt numeric(12,6) NOT NULL, -- 전계약적용율
  dvpns_plyno character varying(16), -- 개발원증권번호
  dvpns_jbcd character(10), -- 개발원직업코드
  udrtk_gu_arecd character(10), -- 인수지침지역코드
  udrtk_grdcd character(10), -- 인수등급코드
  sng_cr_flgcd character(10), -- 단독계약구분코드
  ins_itm_smccd character(10), -- 보험종목소분류코드
  fsti_rp_prm numeric(15) NOT NULL, -- 초회영수보험료
  dc_xc_grdcd character(10), -- 할인할증등급코드
  a_sct_ct numeric(3), -- a구간대수
  b_sct_ct numeric(3), -- b구간대수
  bfcr_dc_xc_grdcd character(10), -- 전계약할인할증등급코드
  dc_xc_same_grdyn character(1), -- 할인할증동일등급여부
  rpbl_ins_plyno character varying(16), -- 책임보험증권번호
  repy_nt_rcpdt date, -- 수불통지접수일자
  repy_nt_rcp_seqno numeric(5), -- 수불통지접수순번
  xacd character(10), -- 정산형태코드
  xc_cyccd character(10), -- 정산주기코드
  cr_tpcd character(10), -- 계약유형코드
  hlt_ins_is_yn character(1), -- 건강보험가입여부
  unf_rt_ap_yn character(1), -- 단일요율적용여부
  avg_age_flgcd character(10), -- 평균연령구분코드
  dpsrt numeric(12,6) NOT NULL, -- 예치율
  dpst_prm_cc_flgcd character(10), -- 예치보험료산출구분코드
  xc_prdy character(2), -- 정산예정일
  is_tpcd character(10), -- 가입유형코드
  ssng_arecd character(10), -- 여행지역코드
  ssst character varying(100), -- 여행지
  ssng_ojccd character(10), -- 여행목적코드
  trf_ridcd character(10), -- 교통승용구코드
  ssng_cmpnm character varying(100), -- 여행회사명
  nrdps_adm_mtdcd character(10), -- 피보험자관리방법코드
  stdsb_rk_grdcd character(10), -- 학과위험등급코드
  stdsb_flgcd character(10), -- 학과구분코드
  rl_stdsb character varying(100), -- 실제학과
  prctc_pln character varying(100), -- 실습현장
  prctc_nm character varying(100), -- 실습명
  prctc_mntct numeric(3), -- 실습개월수
  dmgrt_md_cfcap_bzmno character(10), -- 손해율조정계수적용사업자번호
  dmgrt_md_cfc_crpno character varying(13), -- 손해율조정계수법인번호
  dmgrt_md_cfcap_yn character(1), -- 손해율조정계수적용여부
  fcntr_dmgrt numeric(12,6) NOT NULL, -- 원청자손해율
  dmgrt_md_cfc numeric(12,6) NOT NULL, -- 손해율조정계수
  fcntr_sclcd character(10), -- 원청자범위코드
  cc_prm numeric(15) NOT NULL, -- 산출보험료
  nkor_rs_yn character(1), -- 북한주민여부
  ins_rt_flgcd character(10), -- 보험요율구분코드
  ap_cvr_flgcd character(10), -- 적용담보구분코드
  chaf_annu_apprm numeric(17,2) NOT NULL, -- 변경후년간적용보험료
  rt_aqr_unt_flgcd character(10), -- 요율구득단위구분코드
  rt_aqr_stncd character(10), -- 요율구득기준코드
  bsns_chrps_stfno character(7), -- 업무담당직원번호
  intn_rltno character varying(30), -- 대외연계번호
  cstcp_flgcd character(10), -- 건설사구분코드
  chr_admr_stfno character(7), -- 담당관리자직원번호
  nvgtn_arecd character(10), -- 항해구역코드
  et_nvgtn_arenm character varying(200), -- 기타항해구역명
  condt_qtrt_frcap_yn character(1), -- 공동인수지분율강제적용여부
  ss_plyct numeric(3), -- 발행증권수
  trspr_cmpnm character varying(100), -- 운송인회사명
  dstcd character(10), -- 거리코드
  spcl_tr_dst numeric(7,2), -- 특수운송거리
  tr_days numeric(5), -- 운송일수
  snddt date, -- 발송일자
  arvdt date, -- 도착일자
  lowt_prm_ap_yn character(1), -- 최저보험료적용여부
  slfdt date, -- 출항일자
  outus_mncd character(10), -- 출력용화폐코드
  ivamt_prt_yn character(1), -- 보험가액인쇄여부
  bl_yn character(1), -- bl여부
  vp_clm character(10), -- vp컬럼
  dc_mtdcd character(10), -- 공제방법코드
  dvdld_ct numeric(5), -- 분적횟수
  xpipt_op_flgcd character(10), -- 수출입op구분코드
  carg_dt_flgcd character(10), -- 적하세부구분코드
  trt_yymm character(6), -- 특약년월
  fltno character(8), -- 선단번호
  flt_dc_yn character(1), -- 선단할인여부
  shtm_xc_yn character(1), -- 단기할증여부
  annu_shtm_flgcd character(10), -- 연간단기구분코드
  op_crano character(8), -- op계약번호
  op_cr_ch_seq numeric(3), -- op계약변경회차
  op_cr_napc_yn character(1), -- op계약미적용여부
  nv_ctmno character(9), -- 조사고객번호
  nv_cprt_entp_seqno numeric(3), -- 조사협력업체순번
  xc_ctmno character(9), -- 정산고객번호
  xc_cprt_entp_seqno numeric(3), -- 정산협력업체순번
  marne_onds_no character(9), -- 해상구배서번호
  nvgtn_sct_dstcd character(10), -- 항해구간거리코드
  inlwt_slng_yn character(1), -- 내수면운항여부
  cmpx_tr_yn character(1), -- 복합운송여부
  prvsn_dcn_flgcd character(10), -- 잠정확정구분코드
  cr_objnm character varying(100), -- 계약물건명
  pym_trm_flgcd character(10), -- 납입기간구분코드
  pym_trm numeric(3), -- 납입기간
  pym_trmcd character(10), -- 납입기간코드
  rl_pym_trm numeric(3), -- 실납입기간
  nd_flgcd character(10), -- 만기구분코드
  nd numeric(3), -- 만기
  ndcd character(10), -- 만기코드
  rl_nd_trm numeric(3), -- 실만기기간
  nd_rtamt_py_tpcd character(10), -- 만기환급금지급유형코드
  inr_ins_cr_strdt date, -- 통합보험계약시작일자
  inr_ins_cr_nddt date, -- 통합보험계약종료일자
  pym_cyccd character(10), -- 납입주기코드
  type_flgcd character(10), -- 종구분코드
  dfr_trm numeric(3), -- 거치기간
  mw_py_mtdcd character(10), -- 중도지급방법코드
  rvi_nt numeric(15) NOT NULL, -- 부활이자
  rvi_nt_crdt date, -- 부활이자발생일자
  an_py_stdt date, -- 연금지급시기일자
  an_py_age numeric(3), -- 연금지급연령
  an_py_trm numeric(3), -- 연금지급기간
  annu_an_py_ct numeric(5), -- 연간연금지급횟수
  an_pytcd character(10), -- 연금지급형코드
  an_py_girt numeric(12,6) NOT NULL, -- 연금지급체증율
  tx_pf_flgcd character(10), -- 세금우대구분코드
  iht_yn character(1), -- 상속여부
  tx_pfamt numeric(15) NOT NULL, -- 세금우대금액
  tx_pf_rgt_flgcd character(10), -- 세금우대등록구분코드
  tx_pf_cncd character(10), -- 세금우대해지코드
  tx_pf_cnldt date, -- 세금우대해지일자
  tx_pf_gd_csfcd character(10), -- 세금우대상품분류코드
  cr_cvr_is_yn character(1), -- 차량담보가입여부
  cv_yn character(1), -- 전환여부
  gr_cr_flgcd character(10), -- 단체계약구분코드
  gr_dscrt numeric(12,6) NOT NULL, -- 단체할인율
  pym_xmp_stdt date, -- 납입면제시기일자
  avg_rt_ap_yn character(1), -- 평균요율적용여부
  man_avg_ap_age numeric(3), -- 남자평균적용연령
  fml_avg_ap_age numeric(3), -- 여자평균적용연령
  man_avg_injr_rnkcd character(10), -- 남자평균상해급수코드
  fml_avg_injr_rnkcd character(10), -- 여자평균상해급수코드
  man_avg_drve_tycd character(10), -- 남자평균운전형태코드
  fml_avg_drve_tycd character(10), -- 여자평균운전형태코드
  plcd character(10), -- 플랜코드
  ibnf_py_tpcd character(10), -- 보험금지급유형코드
  drve_tycd character(10), -- 운전형태코드
  drve_cr_usecd character(10), -- 운전차량용도코드
  embr_minsr_yn character(1), -- 태아주피여부
  sb_pym_rq_yn character(1), -- 대체납입신청여부
  befo_plyno character varying(16), -- 이전증권번호
  bdl_pym_yn character(1), -- 일괄납입여부
  gr_ctmno character(9), -- 단체고객번호
  ppr_plyno character varying(16), -- 상위증권번호
  fnl_dh_stfno character(7) NOT NULL, -- 최종취급직원번호
  gdxpn_ss_bj_yn character(1), -- 상품설명서발행대상여부
  inp_usr_id character(7) NOT NULL, -- 입력사용자id
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  self_cr_yn character(1), -- 자기계약여부
  rdch_cr_yn character(1), -- 승환계약여부
  cr_info_cvap_yn character(1), -- 계약정보민원여부
  gdxpn_trnm_yn character(1), -- 상품설명서전달여부
  nwcr_scan_bj_yn character(1), -- 신계약스캔대상여부
  nwcr_scan_cplt_yn character(1), -- 신계약스캔완료여부
  nwcr_scan_cplt_dthms timestamp(0) without time zone, -- 신계약스캔완료일시
  dc_st_flgcd character(10), -- 할인기준구분코드
  gu_fire_gdcd character(10), -- 구화재상품코드
  gu_fire_gdnm character varying(100), -- 구화재상품명
  gu_plyno character varying(16), -- 구증권번호
  rltn_plyno character varying(16), -- 연계증권번호
  xwpy_rtntm_ntpy_yn character(1), -- 과오납환급시이자지급여부
  y3_clm_ct numeric(3), -- 3년사고횟수
  apl_tycd character(10), -- 청약형태코드
  sep_cr_flgcd character(10), -- 분리계약구분코드
  vlt_spc_xccd character(10), -- 위반특별할증코드
  y1_clm_ct numeric(3), -- 1년사고횟수
  y1_clm_yn character(1), -- 1년사고유무
  ibnf_sb_pym_yn character(1), -- 보험금대체납입여부
  ibnf_sb_pym_st date, -- 보험금대체납입시기
  rnw_nddt date, -- 갱신종료일자
  sign_mtdcd character(10), -- 서명방법코드
  nd_sep_rtn_tycd character(10), -- 만기분할환급형태코드
  nd_sep_py_mtdcd character(10), -- 만기분할지급방법코드
  dc_plyno character varying(20), -- 공제증권번호
  load_dthms timestamp(0) without time zone


)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)
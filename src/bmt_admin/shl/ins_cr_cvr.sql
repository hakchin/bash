CREATE TABLE ins_cr_cvr
(
  plyno character varying(16) NOT NULL, -- 증권번호
  cvrcd character(8) NOT NULL, -- 담보코드
  cvr_seqno numeric(5) NOT NULL, -- 담보순번
  ap_nddt date NOT NULL, -- 적용종료일자
  ap_strdt date NOT NULL, -- 적용시작일자
  ndsno character(4) NOT NULL, -- 배서번호
  vald_nds_yn character(1) NOT NULL, -- 유효배서여부
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- 배서승인시작일시
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- 배서승인종료일시
  ikd_grpcd character(10) NOT NULL, -- 보종군코드
  cvr_bj_flgcd character(10), -- 담보대상구분코드
  relpc_oj_seqno numeric(10), -- 관계자목적물순번
  cvr_ba_trt_flgcd character(10) NOT NULL, -- 담보기본특약구분코드
  cvr_stcd character(10) NOT NULL, -- 담보상태코드
  cvr_st_chdt date, -- 담보상태변경일자
  isamt numeric(15) NOT NULL, -- 가입금액
  nds_isamt numeric(15) NOT NULL, -- 배서가입금액
  ba_prm numeric(15) NOT NULL, -- 기본보험료
  nds_ba_prm numeric(17,2) NOT NULL, -- 배서기본보험료
  ap_prm numeric(15) NOT NULL, -- 적용보험료
  nds_ap_prm numeric(15) NOT NULL, -- 배서적용보험료
  scd_ins_trm_apprm numeric(15) NOT NULL, -- 제2보험기간적용보험료
  ins_st date, -- 보험시기
  ins_st_hms character(4), -- 보험시기시각
  ins_clstr date, -- 보험종기
  ins_clstr_hms character(4), -- 보험종기시각
  self_chamt_mncd character(10), -- 자기부담금화폐코드
  self_chamt numeric(15) NOT NULL, -- 자기부담금액
  agmt_aqr_rt_flgcd character(10), -- 협정구득요율구분코드
  nrdps_lvlcd character(10), -- 피보험자레벨코드
  rk_tpcd character(8), -- 위험유형코드
  chbf_ap_prm numeric(15) NOT NULL, -- 변경전적용보험료
  chaf_ap_prm numeric(15) NOT NULL, -- 변경후적용보험료
  pym_cyccd character(10), -- 납입주기코드
  pym_trmcd character(10), -- 납입기간코드
  cvr_st_st_yymm character(6), -- 담보시기기준년월
  pym_xmp_yn character(1), -- 납입면제여부
  pym_xmp_str_yymm character(6), -- 납입면제시작년월
  rfamt_clc_ins_st date, -- 준비금액산정보험시기
  rfamt_clc_ins_clstr date, -- 준비금액산정보험종기
  auto_rnw_av_yn character(1), -- 자동갱신가능여부
  auto_rnw_cvr_cnldt date, -- 자동갱신담보해지일자
  cvr_fnl_pym_yymm character(6), -- 담보최종납입년월
  cvr_fnl_pym_seq numeric(5), -- 담보최종납입회차
  nd_flgcd character(10), -- 만기구분코드
  nd numeric(3), -- 만기
  ndcd character(10), -- 만기코드
  rl_nd_trm numeric(3), -- 실만기기간
  pym_trm_flgcd character(10), -- 납입기간구분코드
  pym_trm numeric(3), -- 납입기간
  rl_pym_trm numeric(3), -- 실납입기간
  nrdps_ap_age numeric(3), -- 피보험자적용연령
  bfrnw_cvrsn numeric(5), -- 갱신전담보순번
  bfrnw_cvrcd character(10), -- 갱신전담보코드
  trt_preg_rnd_wkct numeric(2), -- 특약임신경과주수
  db_cvr_flgcd character(10), -- 중복담보구분코드
  cvr_is_tpcd character(10), -- 담보가입유형코드
  sb_cscd character(10), -- 대체비용코드
  isamt_cd character(10), -- 가입금액코드
  xp_dmamt numeric(17,5) NOT NULL, -- 예상손해액
  md_dmamt numeric(17,5) NOT NULL, -- 조정손해액
  trt_ap_cvr_prmsm numeric(17,2) NOT NULL, -- 특약적용담보보험료합계
  sys_mpv_dt date, -- 제도개선일자
  trt_ap_cvrcd character(10), -- 특약적용담보코드
  mstr_car_plyno character varying(25), -- 마스터카증권번호
  clmp1_is_amtcd character(10), -- 1사고당가입금액코드
  emeg_mvo_ce_stfno character(7), -- 긴급출동모집직원번호
  emeg_mvo_cnrdt date, -- 긴급출동계약일자
  de_sel_obs_flgcd character(10), -- 사망후유장해구분코드
  itm_cvr_rk_rnk character(10), -- 품목담보위험급수
  imu_trmcd character(10), -- 면책기간코드
  agr_rt numeric(12,6) NOT NULL, -- 약정비율
  absc_trm_flgcd character(10), -- 부재기간구분코드
  agr_rest_trmcd character(10), -- 약정복구기간코드
  isamt_spc character varying(300), -- 가입금액내역
  esrct numeric(2), -- 호위인수
  bd_dlbr_rpbl_btpcd character(10), -- 신체손해배상책임업종코드
  woncr_cv_self_chamt numeric(15) NOT NULL, -- 원화환산자기부담금액
  dc_rt numeric(12,6) NOT NULL, -- 공제비율
  act_or_actct numeric(4), -- 구좌/계좌수
  frc_rt_ap_yn character(1), -- 강제요율적용여부
  ad_self_chamt numeric(17,2) NOT NULL, -- 추가자기부담금액
  prgcs_prt_yn character(1), -- 문구비인쇄여부
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  cvr_spqu_flgcd character(10), -- 담보특성구분코드
  nds_prdt date, -- 배서예정일자
  afgst_prm_ccbj_yn character(1), -- 보장시기이후보험료산출대상여부
  sep_cr_cn_yn character(1), -- 분리계약해약여부
  flpy_cvrfs_sb_yn character(1), -- 일시납담보초회대체여부
  rnw_nddt date, -- 갱신종료일자
  rnw_cvr_nclm_dcamt numeric(15), -- 갱신담보무사고할인금액
  sustd_xc_rk_ndx numeric(5), -- 표준하체할증위험지수
  stdbd_prm numeric(15), -- 표준체보험료
  sustd_prm numeric(15), -- 표준하체보험료
  dcamt numeric(15), -- 할인금액
  sustd_rwcvr_nclm_dcamt numeric(15), -- 표준하체갱신담보무사고할인금액
  stdbd_rwcvr_nclm_dcamt numeric(15), -- 표준체갱신담보무사고할인금액
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)

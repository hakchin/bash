CREATE TABLE cls_cr_rnd_prm_mmcls
(
  cls_yymm character(6) NOT NULL, -- 마감년월
  plyno character varying(16) NOT NULL, -- 증권번호
  cvrcd character(8) NOT NULL, -- 담보코드
  cvr_seqno numeric(5) NOT NULL, -- 담보순번
  trtcd character(10) NOT NULL, -- 특약코드
  rnd_prm_seqno numeric(10) NOT NULL, -- 경과보험료순번
  ce_stfno character(7), -- 모집직원번호
  incm_prm numeric(15), -- 수입보험료
  rn_prm numeric(15), -- 원수보험료
  cn_prm numeric(17,2), -- 해지보험료
  ptrm_nelp_prm numeric(15), -- 전기미경과보험료
  lltm_nelp_prm numeric(15), -- 후기미경과보험료
  rnd_prm numeric(15), -- 경과보험료
  psst_incm_prm numeric(17,2), -- 보유기준수입보험료
  psst_rn_prm numeric(17,2), -- 보유기준원수보험료
  psst_cn_prm numeric(17,2), -- 보유기준해지보험료
  psst_ptrm_nrnpr numeric(17,2), -- 보유기준전기미경과보험료
  psst_lltm_nrnpr numeric(17,2), -- 보유기준후기미경과보험료
  psst_rnd_prm numeric(17,2), -- 보유기준경과보험료
  rk_incm_prm numeric(15), -- 위험수입보험료
  rk_rn_prm numeric(15), -- 위험원수보험료
  rk_cn_prm numeric(15), -- 위험해지보험료
  rk_ptrm_nelp_prm numeric(15), -- 위험전기미경과보험료
  rk_lltm_nelp_prm numeric(15), -- 위험후기미경과보험료
  rk_rnd_prm numeric(17,2), -- 위험경과보험료
  psst_rk_incm_prm numeric(17,2), -- 보유기준위험수입보험료
  psst_rk_rn numeric(17,2), -- 보유기준위험원수보험료
  psst_rk_cn_prm numeric(17,2), -- 보유기준위험해지보험료
  psst_rk_ptrm_nrnpr numeric(17,2), -- 보유기준위험전기미경과보험료
  psst_rk_lltm_nrnpr numeric(17,2), -- 보유기준위험후기미경과보험료
  psst_rk_rnd_prm numeric(17,2), -- 보유기준위험경과보험료
  iramt_ct numeric(5), -- 부보대수
  onw_cr_flgcd character(10), -- 신구계약구분코드
  ce_bf_cmpcd character(10), -- 모집전회사코드
  cvr_spqu_flgcd character(10), -- 담보특성구분코드
  gn_co_obj_flgcd character(10), -- 일반공동물건구분코드
  ins_itm_smccd character(10), -- 보험종목소분류코드
  ins_imcd character(10), -- 보험종목코드
  gn_co_appr_flgcd character(10), -- 일반공동인정구분코드
  milg_cvrcd character(10), -- 마일리지담보코드
  milg_is_amtcd character(10), -- 마일리지가입금액코드
  milg_nelp_days numeric(5), -- 마일리지미경과일수
  milg_lltm_nelp_prm numeric(15), -- 마일리지후기미경과보험료
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (cls_yymm, plyno, cvrcd, cvr_seqno, trtcd, rnd_prm_seqno)

CREATE TABLE m_lwt_dm_rd_rptg_list
(
  vl_yymm character(6) NOT NULL, -- 평가년월
  rcp_yymm character(6) NOT NULL, -- 접수년월
  rcp_nv_seqno character(5) NOT NULL, -- 접수조사순번
  ins_imcd character(10) NOT NULL, -- 보험종목코드
  dm_rd_rptg_seqno numeric(3) NOT NULL, -- 손해감소보고서순번
  cvgcd character(10) NOT NULL, -- 담보군코드
  adm_chrps_stfno character(7) NOT NULL, -- 관리담당자직원번호
  adm_chrps_tm_orgcd character(7), -- 관리담당자팀기관코드
  adm_chrps_orgcd character(7), -- 관리담당자기관코드
  rptdt date, -- 보고일자
  prvdt date, -- 결재일자
  imu_tpcd character(10), -- 면책유형코드
  plyno character varying(16), -- 증권번호
  clmdt date, -- 사고일자
  rcpdt date, -- 접수일자
  cnrdt date, -- 계약일자
  clm_carno character varying(20), -- 사고차량번호
  nrdnm character varying(100), -- 피보험자명
  clm_cvrnm character varying(100), -- 사고담보명
  siu_admno_yr character(4), -- SIU관리번호년도
  siu_admno_seqno character(6), -- SIU관리번호순번
  siu_dl_rstcd character(10), -- SIU처리결과코드
  ce_stfno character(7), -- 모집직원번호
  ce_bzp_orgcd character(7), -- 모집영업소기관코드
  ce_br_orgcd character(7), -- 모집지점기관코드
  gn_co_obj_flgcd character(10), -- 일반공동물건구분코드
  cvap_rcgnt_yn character(1), -- 민원인식여부
  detc_orgnm character varying(100), -- 수사기관명
  cnbd numeric(5,2), -- 기여도
  moff_vl_vwbl_poct numeric(3), -- 본점평가착안점수
  dfwk_poct numeric(3), -- 난이도점수
  fdg_poct numeric(3), -- 노력도점수
  ins_crme_ct numeric(9), -- 보험범죄건수
  dm_rd_ct numeric(9), -- 손해감소건수
  ins_crme_sjtdn_ct numeric(5), -- 보험범죄적발건수
  ibnf_rdamt numeric(15), -- 보험금감소금액
  xp_dmamt numeric(15), -- 예상손해금액
  dm_rd_poct numeric(4,1), -- 손해감소점수
  ap_prm numeric(17,2), -- 적용보험료
  ins_crme_scr numeric(4,1), -- 보험범죄가점
  ins_crme_dmk numeric(4,1), -- 보험범죄감점
  ins_crme_t_poct numeric(4,1), -- 보험범죄총점수
  no1_relnm character varying(100), -- 1번관계자명
  no1_relpc_rsno character varying(40), -- 1번관계자주민번호
  no1_nrdps_relnm character varying(50), -- 1번피보험자관계명
  no1_relpc_jbnm character varying(100), -- 1번관계자직업명
  no2_relnm character varying(100), -- 2번관계자명
  no2_relpc_rsno character varying(40), -- 2번관계자주민번호
  no2_nrdps_relnm character varying(50), -- 2번피보험자관계명
  no2_relpc_jbnm character varying(100), -- 2번관계자직업명
  no3_relnm character varying(100), -- 3번관계자명
  no3_relpc_rsno character varying(40), -- 3번관계자주민번호
  no3_nrdps_relnm character varying(50), -- 3번피보험자관계명
  no3_relpc_jbnm character varying(100), -- 3번관계자직업명
  n04_relnm character varying(100), -- 4번관계자명
  n04_relpc_rsno character varying(40), -- 4번관계자주민번호
  n04_nrdps_relnm character varying(50), -- 4번피보험자관계명
  n04_relpc_jbnm character varying(100), -- 4번관계자직업명
  n05_relnm character varying(100), -- 5번관계자명
  n05_relpc_rsno character varying(40), -- 5번관계자주민번호
  n05_nrdps_relnm character varying(50), -- 5번피보험자관계명
  n05_relpc_jbnm character varying(100), -- 5번관계자직업명
  fr_xiamt numeric(15), -- 최초추산보험금액
  remn_xiamt numeric(15), -- 잔여추산보험금액
  ds_ibamt numeric(15), -- 결정보험금액
  rcamt numeric(15), -- 환수금액
  nvr_stfno character(7), -- 조사자직원번호
  udwr_stfno character(7), -- 심사자직원번호
  nvr_cnbd numeric(5,2), -- 조사자기여도
  udwr_cnbd numeric(5,2), -- 심사자기여도
  itg1_imu_yn character(1), -- 1보전면책여부
  itg2_imu_yn character(1), -- 2보전면책여부
  siu_nv_tpcd character(10), -- SIU조사유형코드
  appr_dm_rd_ct numeric(10,2), -- 인정손해감소건수
  appr_ibnf_rdamt numeric(17,2), -- 인정보험금감소금액
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (vl_yymm, rcp_yymm, rcp_nv_seqno, ins_imcd, dm_rd_rptg_seqno, cvgcd, adm_chrps_stfno)
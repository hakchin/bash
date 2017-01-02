CREATE TABLE sam_org
(
  orgcd character(7) NOT NULL, -- 기관코드
  orgnm character varying(100) NOT NULL, -- 기관명
  org_ennm character varying(100), -- 기관영문명
  org_shtnm character varying(100) NOT NULL, -- 기관단축명
  pstno character(6), -- 우편번호
  sd character varying(30), -- 시도
  sgng character varying(30), -- 시군구
  twmd character varying(30), -- 읍면동
  ri_or_lrdlp character varying(50), -- 리/대량배달처
  dtadr character varying(100), -- 상세주소
  org_flgcd character(10) NOT NULL, -- 기관구분코드
  org_tpcd character(10) NOT NULL, -- 기관유형코드
  org_spcd character(10) NOT NULL, -- 기관특성코드
  org_stcd character(10) NOT NULL, -- 기관상태코드
  org_stb_rscd character(10) NOT NULL, -- 기관개설사유코드
  org_stbdt date NOT NULL, -- 기관개설일자
  org_clo_rscd character(10), -- 기관폐쇄사유코드
  org_clodt date NOT NULL, -- 기관폐쇄일자
  bkcd character(10), -- 은행코드
  actno character varying(20), -- 계좌번호
  orghd_stfno character(7), -- 기관장직원번호
  orghd_apodt date, -- 기관장발령일자
  ppr_orgcd character(7), -- 상위기관코드
  rcapm_org_yn character(1) NOT NULL, -- 출납기관여부
  rcapm_orgcd character(7), -- 출납기관코드
  act_org_yn character(1) NOT NULL, -- 회계기관여부
  act_orgcd character(7), -- 회계기관코드
  rv_org_yn character(1) NOT NULL, -- 수납기관여부
  rv_orgcd character(7), -- 수납기관코드
  jrd_uofcd character(10), -- 관할관청코드
  crp_eqdtx_pymbj_yn character(1), -- 법인균등할주민세납부대상여부
  insbz_lictx_pymbj_yn character(1), -- 보험업면허세납부대상여부
  pdwkp_txpym_bj_yn character(1), -- 재산할사업소세납부대상여부
  ofwk_stf_apo_yn character(1), -- 내근직원발령여부
  bz_strdt date, -- 영업시작일자
  tm_kndcd character(10), -- 팀종류코드
  vl_gp_flgcd character(10), -- 평가그룹구분코드
  mncs_gp_flgcd character(10), -- 운영비그룹구분코드
  are_flgcd character(10), -- 지역구분코드
  org_rl_flgcd character(10) NOT NULL, -- 기관실제구분코드
  trn_tm_flgcd character(10), -- 육성팀구분코드
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  fr_rgt_cmpcd character(10), -- 최초등록회사코드
  fire_orgcd character(7), -- 화재기관코드
  vl_adm_stfno character(7), -- 평가관리직원번호
  vl_adm_stf_apodt date, -- 평가관리직원발령일자
  vl_ppr_orgcd character(7), -- 평가상위기관코드
  ref_it character varying(100), -- 참고항목
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (orgcd);
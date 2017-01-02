CREATE TABLE ins_incm_prm
(
  plyno character varying(16) NOT NULL, -- 증권번호
  incm_prm_cr_seqno numeric(5) NOT NULL, -- 수입보험료발생순번
  pym_seq numeric(5) NOT NULL, -- 납입회차
  ndsno character(4), -- 배서번호
  fnl_pym_yymm character(6), -- 최종납입년월
  pyp_t_seq numeric(5), -- 분납총회차
  rp_prm numeric(15) NOT NULL, -- 영수보험료
  ap_prm numeric(15) NOT NULL, -- 적용보험료
  dp_cascd character(10) NOT NULL, -- 입금원인코드
  dp_dt_cascd character(10) NOT NULL, -- 입금세부원인코드
  rv_sbno character varying(20), -- 수납대기번호
  ccldt date, -- 취소일자
  ccl_flgcd character(10), -- 취소구분코드
  ppdt date, -- 계상일자
  pym_cyccd character(10), -- 납입주기코드
  dh_stfno character(7) NOT NULL, -- 취급직원번호
  usrno character(7), -- 사용인번호
  rp_admno character varying(20), -- 영수관리번호
  mncd character(10), -- 화폐코드
  fc_ap_prm numeric(17,2) NOT NULL, -- 외화적용보험료
  usd_cv_ap_prm numeric(17,2) NOT NULL, -- 미화환산적용보험료
  xcrt_flgcd character(10), -- 환율구분코드
  fc_ap_xcrt numeric(12,6) NOT NULL, -- 외화적용환율
  usd_ap_xcrt numeric(12,6) NOT NULL, -- 미화적용환율
  fc_condt_t_prm numeric(17,2) NOT NULL, -- 외화공동인수총보험료
  condt_t_prm numeric(15) NOT NULL, -- 공동인수총보험료
  udrtk_tycd character(10), -- 인수형태코드
  otcm_mg_cmpcd character(10), -- 타사간사회사코드
  cnn_incm_prmcr_seqno numeric(5), -- 관련수입보험료발생순번
  hscs_hs_flgcd character(10), -- 가계비가계구분코드
  pyp_ad_cs numeric(17,2) NOT NULL, -- 분납추가비용
  ba_cvr_prm numeric(15) NOT NULL, -- 기본담보보험료
  trt_prm numeric(15) NOT NULL, -- 특약보험료
  cu_prm numeric(15) NOT NULL, -- 적립보험료
  flpy_cvr_trt_prm numeric(15) NOT NULL, -- 일시납담보특약보험료
  dcbf_cu_prm numeric(15) NOT NULL, -- 할인전적립보험료
  cu_nprm numeric(15) NOT NULL, -- 적립순보험료
  ppy_yn character(1), -- 선납여부
  ppy_dc_yn character(1), -- 선납할인여부
  nwfsq_flgcd character(10), -- 신초차구분코드
  auto_tf_dc_yn character(1), -- 자동이체할인여부
  rvi_nt numeric(15) NOT NULL, -- 부활이자
  du_ar_flgcd character(10), -- 응당연체구분코드
  prm_diss_yn character(1), -- 보험료분해여부
  cvr_prm_disbj_yn character(1), -- 담보보험료분해대상여부
  dcbf_prm numeric(15) NOT NULL, -- 할인전보험료
  sb_flgcd character(10), -- 대체구분코드
  onds_dp_tpcd character(10), -- 구배서입금유형코드
  bkcd character(10), -- 은행코드
  bk_brcd character(10), -- 은행지점코드
  bk_extn_qfp character(10), -- 은행유자격자
  bk_ipps character(10), -- 은행입력자
  bnc_admr character(7), -- 방카관리자
  pym_dudt date, -- 납입응당일자
  dbl_paym_yn character(1), -- 이중불입여부
  ac_tf_yn character(1), -- 경리이체여부
  uc_prm_yn character(1), -- 미수보험료여부
  co_crt_rv_flgcd character(10), -- 공동계약자수납구분코드
  ikd_grpcd character(10) NOT NULL, -- 보종군코드
  ccl_wdr_rtn_nt numeric(15) NOT NULL, -- 취소철회환급이자
  payao_yn character(1), -- 즉시불여부
  amt_ndscd character(10), -- 금액배서코드
  crt_relpc_seqno numeric(10), -- 계약자관계자순번
  tincm_prm_cr_seqno numeric(5), -- 집계수입보험료발생순번
  co_crt_yn character(1), -- 공동계약자여부
  pyno_whpy_bjno character(10), -- 지급번호/제지급대상번호
  cu_st_rpdt date, -- 적립기준영수일자
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  self_cr_yn character(1), -- 자기계약여부
  rdch_cr_yn character(1), -- 승환계약여부
  rv_dldt date , -- 수납처리일자
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)
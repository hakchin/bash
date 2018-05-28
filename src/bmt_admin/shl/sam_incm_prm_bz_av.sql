CREATE TABLE sam_incm_prm_bz_av
(
  plyno character varying(16) NOT NULL, -- 증권번호
  incm_prm_cr_seqno numeric(5) NOT NULL, -- 수입보험료발생순번
  cv_prm_sm numeric(15) NOT NULL, -- 환산보험료합계
  vl_prm numeric(15) NOT NULL, -- 평가보험료
  ce_awamt numeric(15) NOT NULL, -- 모집수당금액
  ikd_grpcd character(10) NOT NULL, -- 보종군코드
  ce_aw_pyrt numeric(5,2) NOT NULL, -- 모집수당지급율
  aw_spc_dl_yn character(1) NOT NULL, -- 수당내역처리여부
  aw_spc_dldt date NOT NULL, -- 수당내역처리일자
  aw_py_prdt date NOT NULL, -- 수당지급예정일자
  prpn_aw_smamt numeric(15) NOT NULL, -- 비례수당합계금액
  ppdt date NOT NULL, -- 계상일자
  gnte_cv_prm numeric(15) NOT NULL, -- 보장성환산보험료
  cumt_cv_prm numeric(15) NOT NULL, -- 적립성환산보험료
  ltrm_mpy_cv_prm numeric(15) NOT NULL, -- 장기월납환산보험료
  mn_awamt numeric(15) NOT NULL, -- 유지수당금액
  cm_awamt numeric(15) NOT NULL, -- 수금수당금액
  nw_ou_awamt numeric(15) NOT NULL, -- 신규성과수당금액
  mn_ou_awamt numeric(15) NOT NULL, -- 유지성과수당금액
  cu_cvrt numeric(5,2) NOT NULL, -- 적립환산율
  gn_cvrt numeric(5,2) NOT NULL, -- 보장환산율
  mn_aw_pyrt numeric(5,2) NOT NULL, -- 유지수당지급율
  cm_aw_pyrt numeric(5,2) NOT NULL, -- 수금수당지급율
  rpbl_cv_prm numeric(15) NOT NULL, -- 책임환산보험료
  optn_cv_prm numeric(15) NOT NULL, -- 임의환산보험료
  rpbl_xc_prm_1 numeric(15) NOT NULL, -- 책임정산보험료1
  rpbl_xc_prm_2 numeric(15) NOT NULL, -- 책임정산보험료2
  optn_xc_prm numeric(15) NOT NULL, -- 임의정산보험료
  rpbl_ins_pyrt_1 numeric(5,2) NOT NULL, -- 책임보험지급율1
  rpbl_ins_pyrt_2 numeric(5,2) NOT NULL, -- 책임보험지급율2
  optn_ins_pyrt numeric(5,2) NOT NULL, -- 임의보험지급율
  rpbl_ins_awamt_1 numeric(15) NOT NULL, -- 책임보험수당금액1
  rpbl_ins_awamt_2 numeric(15) NOT NULL, -- 책임보험수당금액2
  optn_ins_awamt numeric(15) NOT NULL, -- 임의보험수당금액
  inp_usr_id character(7) NOT NULL, -- 입력사용자id
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  cm_mdf_prm numeric(15), -- 수금수정보험료
  cm_cvrt numeric(5,2), -- 수금환산율
  re_prm numeric(15), -- 출재보험료
  re_cm numeric(17,2), -- 출재수수료
  re_cmrt numeric(12,6), -- 출재수수료율
  o1_nwcr_mdf_prm numeric(15), -- 1차신계약수정보험료
  o1_mn_aw_pyrt numeric(5,2), -- 1차유지수당지급율
  o1_mn_awamt numeric(15), -- 1차유지수당금액
  o2_nwcr_mdf_prm numeric(15), -- 2차신계약수정보험료
  o2_mn_aw_pyrt numeric(5,2), -- 2차유지수당지급율
  o2_mn_awamt numeric(15), -- 2차유지수당금액
  cradm_mn_aw_pyrt numeric(5,2), -- 계약관리유지수당지급율
  cradm_mn_awamt numeric(15), -- 계약관리유지수당금액
  sv_cradm_awamt numeric(15), -- 저축계약관리수당금액
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno, incm_prm_cr_seqno)
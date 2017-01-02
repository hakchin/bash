CREATE TABLE ins_prm_pym_pr
(
  plyno character varying(16) NOT NULL, -- 증권번호
  pym_seq numeric(5) NOT NULL, -- 납입회차
  crt_relpc_seqno numeric(10) NOT NULL, -- 계약자관계자순번
  mncd character(10) NOT NULL, -- 화폐코드
  ap_nddt date NOT NULL, -- 적용종료일자
  ap_strdt date NOT NULL, -- 적용시작일자
  ndsno character(4) NOT NULL, -- 배서번호
  vald_nds_yn character(1) NOT NULL, -- 유효배서여부
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- 배서승인시작일시
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- 배서승인종료일시
  ikd_grpcd character(10) NOT NULL, -- 보종군코드
  ba_cvr_prm numeric(15) NOT NULL, -- 기본담보보험료
  trt_prm numeric(15) NOT NULL, -- 특약보험료
  cu_prm numeric(15) NOT NULL, -- 적립보험료
  flpy_cvr_trt_prm numeric(15) NOT NULL, -- 일시납담보특약보험료
  dcbf_cu_prm numeric(15) NOT NULL, -- 할인전적립보험료
  dcbf_flpy_cvrtr_prm numeric(15) NOT NULL, -- 할인전일시납담보특약보험료
  t1_prm numeric(15) NOT NULL, -- 1회보험료
  cumny_sb_prm numeric(15) NOT NULL, -- 적립금대체보험료
  ap_prm numeric(17,2) NOT NULL, -- 적용보험료
  dcbf_prm numeric(15) NOT NULL, -- 할인전보험료
  woncr_cv_ap_prm numeric(15) NOT NULL, -- 원화환산적용보험료
  condt_t_prm numeric(17,2) NOT NULL, -- 공동인수총보험료
  woncv_condt_t_prm numeric(15) NOT NULL, -- 원화환산공동인수총보험료
  thcpq_ap_prm numeric(17,2) NOT NULL, -- 당사분적용보험료
  thcpq_woncv_ap_prm numeric(15) NOT NULL, -- 당사분원화환산적용보험료
  nds_ap_prm numeric(17,2) NOT NULL, -- 배서적용보험료
  woncv_nds_ap_prm numeric(15) NOT NULL, -- 원화환산배서적용보험료
  pym_prdt date, -- 납입예정일자
  dcndt date, -- 확정일자
  hg_pym_perd date, -- 최고납입기한
  pyp_rt numeric(12,6) NOT NULL, -- 분납비율
  incm_prm_cr_seqno numeric(5), -- 수입보험료발생순번
  prm_flgcd character(10), -- 보험료구분코드
  nds_prm_yn character(1), -- 배서보험료여부
  xwpy_amt numeric(15) NOT NULL, -- 과오납금액
  pym_pr_stcd character(10), -- 납입예정상태코드
  pym_cyccd character(10), -- 납입주기코드
  cu_nprm numeric(15) NOT NULL, -- 적립순보험료
  xcrt numeric(12,6) NOT NULL, -- 환율
  dmpdt date, -- 최고일자
  npy_cnldt date, -- 미납해지일자
  wrdmp_snddt date, -- 최고문발송일자
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  prm_dcamt numeric(15) NOT NULL, -- 보험료할인금액
  load_dthms timestamp(0) without time zone


)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno, pym_seq)
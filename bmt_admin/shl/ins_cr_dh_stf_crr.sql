CREATE TABLE ins_cr_dh_stf_crr
(
  plyno character varying(16) NOT NULL, -- 증권번호
  dh_stf_tpcd character(10) NOT NULL, -- 취급직원유형코드
  dh_stfno character(7) NOT NULL, -- 취급직원번호
  ap_nddt date NOT NULL, -- 적용종료일자
  ap_strdt date NOT NULL, -- 적용시작일자
  ndsno character(4) NOT NULL, -- 배서번호
  vald_nds_yn character(1) NOT NULL, -- 유효배서여부
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- 배서승인시작일시
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- 배서승인종료일시
  ikd_grpcd character(10), -- 보종군코드
  tabf_dh_stfno character(7), -- 이관전취급직원번호
  usrno character(7), -- 사용인번호
  prs_dh_stf_yn character(1), -- 대표취급직원여부
  qtrt numeric(12,6) NOT NULL, -- 지분율
  ta_crno character varying(12), -- 이관발생번호
  pym_seq numeric(5), -- 납입회차
  bzcs_qtrt numeric(12,6) NOT NULL, -- 사업비지분율
  cnrdt date, -- 계약일자
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL ,-- 수정일시
  load_dthms timestamp(0) without time zone
)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)
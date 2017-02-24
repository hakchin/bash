CREATE TABLE adm_dw_wrk_rst
(
  dw_wrknm character varying(100) NOT NULL, -- dw_wrknm
  strdt date NOT NULL, -- strdt
  str_hms character(8) NOT NULL, -- str_hms
  nddt date, -- nddt
  nd_hms character(8), -- nd_hms
  dw_wrk_rstcd character(10), -- dw_wrk_rstcd
  slc_ct numeric(15), -- slc_ct
  nsrt_ct numeric(15), -- nsrt_ct
  upd_ct numeric(15), -- upd_ct
  dlte_ct numeric(15), -- dlte_ct
  type_err_ct numeric(15), -- type_err_ct
  unque_err_ct numeric(15), -- unque_err_ct
  dup_err_ct numeric(15), -- dup_err_ct
  jbpmt character varying(100), -- jbpmt
  dw_trgt_nm character varying(100), -- dw_trgt_nm
  fnl_us_utlty_nm character varying(100), -- fnl_us_utlty_nm
  CONSTRAINT adm_dw_wrk_rst_nd_hms_check CHECK (
CASE
    WHEN nd_hms IS NULL THEN '00:00:00'::bpchar
    ELSE nd_hms
END::time(0) without time zone >= '00:00:00'::time without time zone::time(0) without time zone),
  CONSTRAINT adm_dw_wrk_rst_str_hms_check CHECK (str_hms::time(0) without time zone >= '00:00:00'::time without time zone::time(0) without time zone)
)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (dw_wrknm, strdt, str_hms);
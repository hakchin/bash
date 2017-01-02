CREATE TABLE m_sam_vl_wkdgr_adm
(
  vl_yr character(4) NOT NULL, -- �򰡳⵵
  vl_wkdgr numeric(2) NOT NULL, -- ��������
  wkdgr_strdt date NOT NULL, -- ��������������
  wkdgr_nddt date NOT NULL, -- ��������������
  load_dthms timestamp(0) without time zone
)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (vl_yr, vl_wkdgr);

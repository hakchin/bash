CREATE TABLE m_org_org_ordr
(
  orgcd character(7) NOT NULL, -- ����ڵ�
  crnt_org_ordr numeric(5), -- ����������
  ap_dt date, -- ��������
  org_ordr numeric(5), -- �������
  orgnm character varying(100), -- �����
  org_shtnm character varying(100), -- ��������
  orgcd_orgnm character varying(100), -- ����ڵ�����
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (orgcd);
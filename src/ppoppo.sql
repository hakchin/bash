--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: iss; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA iss;


ALTER SCHEMA iss OWNER TO postgres;

--
-- Name: sn; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sn;


ALTER SCHEMA sn OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = iss, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: r; Type: TABLE; Schema: iss; Owner: postgres; Tablespace: 
--

CREATE TABLE r (
    a character varying(2),
    b character varying(2),
    c character varying(2)
);


ALTER TABLE iss.r OWNER TO postgres;

--
-- Name: s; Type: TABLE; Schema: iss; Owner: postgres; Tablespace: 
--

CREATE TABLE s (
    b character varying(2),
    c character varying(2),
    d character varying(2)
);


ALTER TABLE iss.s OWNER TO postgres;

--
-- Name: t; Type: TABLE; Schema: iss; Owner: postgres; Tablespace: 
--

CREATE TABLE t (
    a character varying(2),
    b character varying(2),
    c character varying(2),
    amt numeric
);


ALTER TABLE iss.t OWNER TO postgres;

--
-- Data for Name: r; Type: TABLE DATA; Schema: iss; Owner: postgres
--

COPY r (a, b, c) FROM stdin;
a1	b1	c1
a2	b1	c1
a3	b1	c2
a4	b2	c3
a3	b2	c4
a4	b2	c4
\.


--
-- Data for Name: s; Type: TABLE DATA; Schema: iss; Owner: postgres
--

COPY s (b, c, d) FROM stdin;
b1	c1	d1
b1	c1	d2
b2	c3	d3
b2	c4	d4
\.


--
-- Data for Name: t; Type: TABLE DATA; Schema: iss; Owner: postgres
--

COPY t (a, b, c, amt) FROM stdin;
A1	B1	C1	100
A1	B2	C2	200
A1	B3	C3	150
A2	B1	C1	120
A2	B3	C2	50
A2	B4	C3	40
\.


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


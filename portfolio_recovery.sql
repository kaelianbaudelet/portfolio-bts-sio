--
-- PostgreSQL database cluster dump
--

\restrict 0Xz9XZe9pRqUHdd13Drvlj6OEq450zwPeZsRV4OnSDD1tjSlLk8yj0gr5j8uIHr

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE portfolio;
ALTER ROLE portfolio WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:PCAU7wNJiNn1rxYgH0c5DQ==$ouMC0nO/HYDlQuB9vMzLvo7bRYim4Gn6P0TQsl2m8wg=:XbrUZ5ApqHUlEbd5JKxEfCkZFEB7E21KYbWqPVpsUdc=';

--
-- User Configurations
--








\unrestrict 0Xz9XZe9pRqUHdd13Drvlj6OEq450zwPeZsRV4OnSDD1tjSlLk8yj0gr5j8uIHr

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict MdFMRFvAhCNE6BF5IRJOrdgOdut8NNOzgj95ASKQhk6DgwzJhdj8we8UjOv00XZ

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict MdFMRFvAhCNE6BF5IRJOrdgOdut8NNOzgj95ASKQhk6DgwzJhdj8we8UjOv00XZ

--
-- Database "portfolio" dump
--

--
-- PostgreSQL database dump
--

\restrict 93jMMSixSPqndryCkyaY7rRttcwbasSW5jMI58WNogeX5zxbmAkL12rhbw8x0zh

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: portfolio; Type: DATABASE; Schema: -; Owner: portfolio
--

CREATE DATABASE portfolio WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE portfolio OWNER TO portfolio;

\unrestrict 93jMMSixSPqndryCkyaY7rRttcwbasSW5jMI58WNogeX5zxbmAkL12rhbw8x0zh
\connect portfolio
\restrict 93jMMSixSPqndryCkyaY7rRttcwbasSW5jMI58WNogeX5zxbmAkL12rhbw8x0zh

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: certification; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.certification (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(50) NOT NULL,
    issuer character varying(255) NOT NULL,
    issuer_slug character varying(100) NOT NULL,
    description text,
    subtitle character varying(255) DEFAULT NULL::character varying,
    obtained_at date NOT NULL,
    expires_at date,
    pdf_file character varying(255) DEFAULT NULL::character varying,
    verification_url character varying(255) DEFAULT NULL::character varying,
    credential_id character varying(100) DEFAULT NULL::character varying,
    is_visible boolean NOT NULL,
    display_order integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.certification OWNER TO portfolio;

--
-- Name: COLUMN certification.created_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.certification.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN certification.updated_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.certification.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: certification_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.certification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.certification_id_seq OWNER TO portfolio;

--
-- Name: certification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.certification_id_seq OWNED BY public.certification.id;


--
-- Name: contact_message; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.contact_message (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    message text NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    is_read boolean NOT NULL
);


ALTER TABLE public.contact_message OWNER TO portfolio;

--
-- Name: COLUMN contact_message.created_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.contact_message.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: contact_message_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.contact_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_message_id_seq OWNER TO portfolio;

--
-- Name: contact_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.contact_message_id_seq OWNED BY public.contact_message.id;


--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO portfolio;

--
-- Name: education; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.education (
    id integer NOT NULL,
    degree character varying(255) NOT NULL,
    institution character varying(255) NOT NULL,
    start_date character varying(100) NOT NULL,
    end_date character varying(100) NOT NULL,
    description text,
    display_order integer NOT NULL,
    is_visible boolean NOT NULL
);


ALTER TABLE public.education OWNER TO portfolio;

--
-- Name: education_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.education_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.education_id_seq OWNER TO portfolio;

--
-- Name: education_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.education_id_seq OWNED BY public.education.id;


--
-- Name: experience; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.experience (
    id integer NOT NULL,
    "position" character varying(255) NOT NULL,
    company character varying(255) NOT NULL,
    start_date character varying(100) NOT NULL,
    end_date character varying(100) NOT NULL,
    description text,
    responsibilities json,
    display_order integer NOT NULL,
    is_visible boolean NOT NULL
);


ALTER TABLE public.experience OWNER TO portfolio;

--
-- Name: experience_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.experience_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experience_id_seq OWNER TO portfolio;

--
-- Name: experience_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.experience_id_seq OWNED BY public.experience.id;


--
-- Name: internship; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.internship (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    company character varying(255) NOT NULL,
    company_logo character varying(255) DEFAULT NULL::character varying,
    start_date date NOT NULL,
    end_date date,
    short_description text,
    full_description text,
    tasks text,
    year integer NOT NULL,
    display_order integer NOT NULL,
    is_visible boolean NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.internship OWNER TO portfolio;

--
-- Name: COLUMN internship.start_date; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.internship.start_date IS '(DC2Type:date_immutable)';


--
-- Name: COLUMN internship.end_date; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.internship.end_date IS '(DC2Type:date_immutable)';


--
-- Name: COLUMN internship.created_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.internship.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN internship.updated_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.internship.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: internship_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.internship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.internship_id_seq OWNER TO portfolio;

--
-- Name: internship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.internship_id_seq OWNED BY public.internship.id;


--
-- Name: internship_project; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.internship_project (
    internship_id integer NOT NULL,
    project_id integer NOT NULL
);


ALTER TABLE public.internship_project OWNER TO portfolio;

--
-- Name: project; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.project (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    short_description text NOT NULL,
    full_description text,
    image character varying(255) DEFAULT NULL::character varying,
    github_url character varying(255) DEFAULT NULL::character varying,
    live_url character varying(255) DEFAULT NULL::character varying,
    display_order integer NOT NULL,
    is_visible boolean NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    type character varying(100) DEFAULT NULL::character varying,
    category character varying(100) DEFAULT NULL::character varying,
    start_date date,
    end_date date
);


ALTER TABLE public.project OWNER TO portfolio;

--
-- Name: COLUMN project.created_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.project.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN project.updated_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.project.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN project.start_date; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.project.start_date IS '(DC2Type:date_immutable)';


--
-- Name: COLUMN project.end_date; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.project.end_date IS '(DC2Type:date_immutable)';


--
-- Name: project_file; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.project_file (
    id integer NOT NULL,
    project_id integer NOT NULL,
    filename character varying(255) NOT NULL,
    original_name character varying(255) NOT NULL,
    mime_type character varying(100) NOT NULL,
    file_size integer NOT NULL,
    file_type character varying(50) NOT NULL,
    uploaded_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.project_file OWNER TO portfolio;

--
-- Name: COLUMN project_file.uploaded_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.project_file.uploaded_at IS '(DC2Type:datetime_immutable)';


--
-- Name: project_file_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.project_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_file_id_seq OWNER TO portfolio;

--
-- Name: project_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.project_file_id_seq OWNED BY public.project_file.id;


--
-- Name: project_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_id_seq OWNER TO portfolio;

--
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.project_id_seq OWNED BY public.project.id;


--
-- Name: project_image; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.project_image (
    id integer NOT NULL,
    project_id integer NOT NULL,
    filename character varying(255) NOT NULL,
    display_order integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.project_image OWNER TO portfolio;

--
-- Name: COLUMN project_image.created_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.project_image.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: project_image_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.project_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_image_id_seq OWNER TO portfolio;

--
-- Name: project_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.project_image_id_seq OWNED BY public.project_image.id;


--
-- Name: project_skill; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.project_skill (
    project_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.project_skill OWNER TO portfolio;

--
-- Name: project_technology; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.project_technology (
    project_id integer NOT NULL,
    technology_id integer NOT NULL
);


ALTER TABLE public.project_technology OWNER TO portfolio;

--
-- Name: skill; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.skill (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(100) NOT NULL,
    icon character varying(255) DEFAULT NULL::character varying,
    display_order integer NOT NULL,
    is_visible boolean NOT NULL,
    description text
);


ALTER TABLE public.skill OWNER TO portfolio;

--
-- Name: skill_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skill_id_seq OWNER TO portfolio;

--
-- Name: skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.skill_id_seq OWNED BY public.skill.id;


--
-- Name: tech_watch_article; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.tech_watch_article (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    author character varying(255) NOT NULL,
    published_at date NOT NULL,
    article_url character varying(500) NOT NULL,
    image character varying(255) DEFAULT NULL::character varying,
    is_visible boolean NOT NULL,
    display_order integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.tech_watch_article OWNER TO portfolio;

--
-- Name: COLUMN tech_watch_article.published_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.tech_watch_article.published_at IS '(DC2Type:date_immutable)';


--
-- Name: COLUMN tech_watch_article.created_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.tech_watch_article.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN tech_watch_article.updated_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.tech_watch_article.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: tech_watch_article_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.tech_watch_article_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tech_watch_article_id_seq OWNER TO portfolio;

--
-- Name: tech_watch_article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.tech_watch_article_id_seq OWNED BY public.tech_watch_article.id;


--
-- Name: technology; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.technology (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    icon character varying(255) DEFAULT NULL::character varying,
    display_order integer NOT NULL
);


ALTER TABLE public.technology OWNER TO portfolio;

--
-- Name: technology_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.technology_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technology_id_seq OWNER TO portfolio;

--
-- Name: technology_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.technology_id_seq OWNED BY public.technology.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(180) NOT NULL
);


ALTER TABLE public."user" OWNER TO portfolio;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO portfolio;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: portfolio
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: certification id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.certification ALTER COLUMN id SET DEFAULT nextval('public.certification_id_seq'::regclass);


--
-- Name: contact_message id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.contact_message ALTER COLUMN id SET DEFAULT nextval('public.contact_message_id_seq'::regclass);


--
-- Name: education id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.education ALTER COLUMN id SET DEFAULT nextval('public.education_id_seq'::regclass);


--
-- Name: experience id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.experience ALTER COLUMN id SET DEFAULT nextval('public.experience_id_seq'::regclass);


--
-- Name: internship id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.internship ALTER COLUMN id SET DEFAULT nextval('public.internship_id_seq'::regclass);


--
-- Name: project id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project ALTER COLUMN id SET DEFAULT nextval('public.project_id_seq'::regclass);


--
-- Name: project_file id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_file ALTER COLUMN id SET DEFAULT nextval('public.project_file_id_seq'::regclass);


--
-- Name: project_image id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_image ALTER COLUMN id SET DEFAULT nextval('public.project_image_id_seq'::regclass);


--
-- Name: skill id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.skill ALTER COLUMN id SET DEFAULT nextval('public.skill_id_seq'::regclass);


--
-- Name: tech_watch_article id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.tech_watch_article ALTER COLUMN id SET DEFAULT nextval('public.tech_watch_article_id_seq'::regclass);


--
-- Name: technology id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.technology ALTER COLUMN id SET DEFAULT nextval('public.technology_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: certification; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.certification (id, name, type, issuer, issuer_slug, description, subtitle, obtained_at, expires_at, pdf_file, verification_url, credential_id, is_visible, display_order, created_at, updated_at) FROM stdin;
10	MOOC EBIOS – Introduction à la méthode EBIOS Risk Manager	attestation	ANSSI et EBIOS	anssi	Attestation EBIOS	\N	2025-11-17	\N	EBIOS-2025-Kaelian-Baudelet-6921d6153280d.pdf	\N	\N	t	1	2025-11-22 15:26:18	2025-11-22 15:33:42
11	MOOC ANSSI – SecNumAcadémie – ANSSI	attestation	ANSSI	anssi	Attestation SecNumAcadémie	\N	2025-11-04	\N	ATTESTATION-DE-SUIVI-04-11-2025-SECNumAcademie-6921c5a71a0bf.pdf	\N	\N	t	2	2025-11-22 15:32:51	2025-11-22 15:33:52
27	Les compétences humaines à l'ère de l'IA	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-Les-competences-humaines-a-lere-de-lIA-6921e89d44f72.pdf	\N	\N	t	18	2025-11-22 20:24:36	2025-11-22 20:26:56
28	Les fondements de la programmation	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-Les-fondements-de-la-programmation-6921e4d3508f4.pdf	\N	\N	t	19	2025-11-22 20:25:59	2025-11-22 20:27:02
13	Certification PIX	certification	Pix	pix	Attestation PIX	Obtention avec 688 PIX	2024-02-20	\N	CERTIFICATION-20-02-2024-PIX-6921c5bd0c79e.pdf	https://app.pix.fr/verification-certificat	P-9C49XVDK	t	4	2025-11-22 15:43:20	2025-11-22 15:45:47
14	MOOC CNIL – MODULE 1 : LE RGPD ET SES NOTIONS CLÉS	attestation	CNIL	cnil	Attestation CNIL	\N	2025-03-17	\N	ATTESTATION-DE-SUIVI-MOD1-17-03-2025-AtelierRGPD-6921c5800d40b.pdf	\N	\N	t	5	2025-11-22 15:48:31	2025-11-22 15:49:11
17	MOOC CNIL – MODULE 4 : LE DPO ET LES OUTILS DE LA CONFORMITÉ	attestation	CNIL	cnil	Attestation CNIL	\N	2025-04-01	\N	ATTESTATION-DE-SUIVI-MOD4-01-04-2025-AtelierRGPD-6921c590248d7.pdf	\N	\N	t	8	2025-11-22 15:53:11	2025-11-22 15:53:11
19	MOOC CNIL – MODULE 6 : TRAVAIL ET DONNÉES PERSONNELLES	attestation	CNIL	cnil	Attestation CNIL	\N	2025-11-04	\N	ATTESTATION-DE-SUIVI-MOD6-04-11-2025-AtelierRGPD-6921c59f369f3.pdf	\N	\N	t	10	2025-11-22 15:55:13	2025-11-22 15:55:13
18	MOOC CNIL – MODULE 5 : LES COLLECTIVITÉS TERRITORIALES	attestation	CNIL	cnil	Attestation CNIL	\N	2025-11-04	\N	ATTESTATION-DE-SUIVI-MOD5-04-11-2025-AtelierRGPD-6921c59894e2b.pdf	\N	\N	t	9	2025-11-22 15:54:22	2025-11-22 15:56:00
16	MOOC CNIL – MODULE 3 : LES RESPONSABILITÉS DES ACTEURS	attestation	CNIL	cnil	Attestation CNIL	\N	2025-04-01	\N	ATTESTATION-DE-SUIVI-MOD3-01-04-2025-AtelierRGPD-6921c58aae02c.pdf	\N	\N	t	7	2025-11-22 15:52:18	2025-11-22 15:56:06
15	MOOC CNIL – MODULE 2 : LES PRINCIPES DE LA PROTECTION DES DONNÉES	attestation	CNIL	cnil	Attestation CNIL	\N	2025-04-01	\N	ATTESTATION-DE-SUIVI-MOD2-01-04-2025-AtelierRGPD-6921c584e0ead.pdf	\N	\N	t	6	2025-11-22 15:50:17	2025-11-22 15:56:11
12	INCLUSION, ON EN PARLE ?	attestation	Compétences et développement	cetd	Attestation Compétences et développement	\N	2025-09-11	\N	INCLUSION-ON-EN-PARLE-11-09-2025-C-and-D-6921c5adbba33.pdf	\N	\N	t	3	2025-11-22 15:40:09	2025-11-22 15:57:41
22	15 minutes pour savoir prendre des décisions	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-15-minutes-pour-savoir-prendre-des-decisions-6921e885752ee.pdf	\N	\N	t	13	2025-11-22 20:09:55	2025-11-22 20:11:33
21	10 conseils pour construire un CV percutant	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-10-conseils-pour-construire-un-CV-percutant-6921e8a1dfcef.pdf	\N	\N	t	12	2025-11-22 20:02:05	2025-11-22 20:11:43
25	Exploiter la puissance de l’intelligence sociale à l’ère de l’IA	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-Exploiter-la-puissance-de-lintelligence-sociale-a-lere-de-lIA-6921e87e209b3.pdf	\N	\N	t	16	2025-11-22 20:19:21	2025-11-22 20:20:12
24	Développer votre pensée critique avec l'IA générative	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-Developper-votre-pensee-critique-avec-lIA-generative-1-6921e88b31112.pdf	\N	\N	t	15	2025-11-22 20:16:15	2025-11-22 20:20:25
23	Développer ses compétences en communication à l’ère de l’IA	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-Developper-ses-competences-en-communication-a-lere-de-lIA-6921e87790cd9.pdf	\N	\N	t	14	2025-11-22 20:13:15	2025-11-22 20:20:34
26	Intégrer l’IA générative dans son processus créatif	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-Integrer-lIA-generative-dans-son-processus-creatif-6921e890f3473.pdf	\N	\N	t	17	2025-11-22 20:22:23	2025-11-22 20:23:03
33	L'essentiel de Redis	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-Lessentiel-de-Redis-6921e4ef0aee2.pdf	\N	\N	t	24	2025-11-22 20:42:30	2025-11-22 20:42:56
30	Les fondements de la transformation durable	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-20	\N	CertificatDaccomplissement-Les-fondements-de-la-transformation-durable-6921e8b2245b7.pdf	\N	\N	t	21	2025-11-22 20:33:18	2025-11-22 20:33:41
29	Les fondements de la programmation : Les algorithmes	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-04	\N	CertificatDaccomplissement-Les-fondements-de-la-programmation-Les-algorithmes-6921e4bdefdb9.pdf	\N	\N	t	20	2025-11-22 20:28:49	2025-11-22 20:34:08
31	L'essentiel de Docker	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-20	\N	CertificatDaccomplissement-Lessentiel-de-Docker-6921e8b77496a.pdf	\N	\N	t	22	2025-11-22 20:38:31	2025-11-22 20:38:50
32	L'essentiel de PostgreSQL	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-06	\N	CertificatDaccomplissement-Lessentiel-de-PostgreSQL-6921e8ab8a4f5.pdf	\N	\N	t	23	2025-11-22 20:40:42	2025-11-22 20:41:00
36	Miser sur les compétences humaines à l'ère de l'IA	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-21	\N	CertificatDaccomplissement-Miser-sur-les-competences-humaines-a-lere-de-lIA-6921e4f369648.pdf	\N	\N	t	27	2025-11-22 20:49:50	2025-11-22 20:54:30
35	L'essentiel de SQL Server 2022	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-05	\N	CertificatDaccomplissement-Lessentiel-de-SQL-Server-2022-6921e8a6cf328.pdf	\N	\N	t	26	2025-11-22 20:46:51	2025-11-22 20:47:36
37	Se préparer au métier de développeur/ développeuse par Microsoft et LinkedIn	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-04	\N	CertificatDaccomplissement-Se-preparer-au-metier-de-developpeur-developpeuse-par-Microsoft-et-LinkedIn-6921e4d96724a.pdf	\N	\N	t	28	2025-11-22 20:51:57	2025-11-22 20:52:19
34	Sensibilisation à la cybersécurité : Sécurité dans le cloud	attestation	LinkedIn	linkedin	Attestation LinkedIn	\N	2025-11-03	\N	CertificatDaccomplissement-Sensibilisation-a-la-cybersecurite-Securite-dans-le-cloud-6921e49f44f03.pdf	\N	\N	t	25	2025-11-22 20:44:39	2025-11-22 20:54:16
\.


--
-- Data for Name: contact_message; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.contact_message (id, name, email, subject, message, created_at, is_read) FROM stdin;
8	Kaelian BAUDELET	aconique@gmail.com	ghgtyygyt	ggyytytytytytyt	2025-11-19 12:22:46	t
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20251027115948	2025-10-27 11:59:52	1
DoctrineMigrations\\Version20251102173710	2025-11-02 17:37:10	21
DoctrineMigrations\\Version20251102173808	2025-11-02 17:38:08	0
DoctrineMigrations\\Version20251102200323	2025-11-02 20:03:26	8
DoctrineMigrations\\Version20251105232716	2025-11-05 23:27:20	16
DoctrineMigrations\\Version20251106140827	2025-11-06 14:08:36	22
DoctrineMigrations\\Version20251106142254	2025-11-06 14:22:59	10
DoctrineMigrations\\Version20251106173206	2025-11-06 17:32:11	14
DoctrineMigrations\\Version20251106234630	2025-11-06 23:46:35	5
DoctrineMigrations\\Version20251107224725	2025-11-07 22:47:57	27
DoctrineMigrations\\Version20251107231421	2025-11-07 23:16:27	21
DoctrineMigrations\\Version20251107234826	2025-11-08 15:48:59	1
DoctrineMigrations\\Version20251108154726	2025-11-08 15:48:59	7
DoctrineMigrations\\Version20251122180637	2025-11-22 18:06:41	12
\.


--
-- Data for Name: education; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.education (id, degree, institution, start_date, end_date, description, display_order, is_visible) FROM stdin;
\.


--
-- Data for Name: experience; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.experience (id, "position", company, start_date, end_date, description, responsibilities, display_order, is_visible) FROM stdin;
\.


--
-- Data for Name: internship; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.internship (id, title, company, company_logo, start_date, end_date, short_description, full_description, tasks, year, display_order, is_visible, created_at, updated_at) FROM stdin;
4	kihodev	KIHO	logo-kiho-6922524bb8261.png	2024-04-19	2024-08-05	Dans le cadre de ma formation en BTS SIO (option SLAM), j’ai réalisé un stage de neuf semaines chez KIHODEV, filiale du groupe KIHO, du 22 avril au 20 juin 2025. Ce stage m’a permis de découvrir concrètement le métier de développeur web et concepteur logiciel.	Dans le cadre de ma formation en BTS Services Informatiques aux Organisations avec spécialité Solutions Logicielles et Applications Métier (SLAM). J’ai effectué un stage au sein de l’infrastructure KIHODEV (filiale du groupe KIHO) durant neuf semaines du mardi 22 avril 2025 au vendredi 20 juin 2025. Au cours de ce stage, j’ai pu m’initier concrètement au métier de développeur web et concepteur logiciel.\r\n\r\nMon stage a consisté en la participation au développement de Kworks, un logiciel interne de KIHODEV destiné à être commercialisé. J’ai contribué à plusieurs étapes clés de sa conception et de sa mise en œuvre.\r\n\r\nCette expérience a été l’opportunité pour moi de percevoir comment une entreprise spécialisée dans le développement de solutions numériques sur mesure se développe, et de mieux comprendre les processus liés à la conception, la réalisation et l’évolution d’un logiciel interne évolutif, notamment en ce qui concerne sa structuration et sa commercialisation.	["Participation au d\\u00e9veloppement d'un serveur API backend Spring Boot","Contribution \\u00e0 l\\u2019impl\\u00e9mentation d'un serveur web frontend Angular","Participation au d\\u00e9veloppement d\\u2019une application mobile avec Flutter"]	2024	0	t	2025-11-17 13:13:50	2025-11-23 13:13:51
\.


--
-- Data for Name: internship_project; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.internship_project (internship_id, project_id) FROM stdin;
4	20
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.project (id, title, short_description, full_description, image, github_url, live_url, display_order, is_visible, created_at, updated_at, type, category, start_date, end_date) FROM stdin;
10	Projet TPRE101 — Développement d'une solution web de livrables	Projet TPRE101		filesphere-69223dfd31ccb.png			0	t	2025-11-18 13:00:19	2025-11-23 12:18:07	app-web	formation	\N	\N
11	Projet TPRW204 — Installation d'une Infrastructure système & réseau pour un environnement web	Projet TPRW204		projet-archi-res-69223cc1b7a21.png			0	t	2025-11-18 13:00:45	2025-11-23 12:19:57			\N	\N
12	Projet TPRW207 — Concevoir et exploiter une base de données dans un environnement web	Projet TPRW207		neptune-692243ddcbcc0.png			0	t	2025-11-18 13:01:26	2025-11-23 12:22:26	app-web		\N	\N
13	Projet TPRW210 — Conception et déploiement d’une stratégie de communication digitale à partir d’un cahier des charges client	Projet TPRW210		bassin-arcachon-692241bbbefbd.png			0	t	2025-11-18 13:02:06	2025-11-23 12:23:52	autre		\N	\N
14	Projet TPRW213 — Dossier de Synthèse de Veille Technologique en Anglais	Projet TPRW213		veille-techno-anglais-6922472a20c5c.png			0	t	2025-11-18 13:02:35	2025-11-23 12:24:33	autre	formation	\N	\N
15	Projet Workshop SN2 — Q. La nouvelle génération	Projet Workshop SN2		projet-workshop-sn2-692249f892eaa.png			0	t	2025-11-18 13:03:10	2025-11-23 12:45:36	autre	formation	\N	\N
16	Projet AP1 — Mise en place d’un système de sauvegarde automatisée et sécurisée d’une base de données	Projet AP1		cyb-ap1-69224538bef4e.png			0	t	2025-11-18 13:04:49	2025-11-23 12:46:13	infrastructure	formation	\N	\N
17	Projet AP2 — Introduction à la sécurité informatique et aux attaques de mots de passe	Projet AP2		cyb-ap2-69224bab45de3.png			0	t	2025-11-18 13:05:16	2025-11-23 12:48:56			\N	\N
19	Portfolio BTS SIO — Création d'un support numérique pour l'epreuve E4 du BTS SIO	Portfolio BTS SIO		page-principal-portfolio-bts-sio-691c7e4c67197.png			0	t	2025-11-18 13:06:16	2025-11-23 12:50:10	autre	formation	\N	\N
20	Projet Kworks [Stage SN1] — Plateforme de gestion des activités opérationnelles pour les entreprises de services	En arrivant a KIHODEV j’ai travaillé sur Kworks, une solution interne au sein du groupe KIHO, qui est appelée à devenir un produit commercialisable pour l’année 2026. Cette plateforme SaaS a été conçue pour répondre aux besoins opérationnels complexes des sociétés de services, en centralisant au même endroit plusieurs fonctionnalités essentielles. L’objectif principal de Kworks est de simplifier la gestion des interventions techniques, en offrant une interface claire pour la planification des interventions, le suivi en temps réel des incidents, la gestion des ressources humaines, ainsi que la facturation. Plutôt que d’avoir plusieurs outils distincts, Kworks propose une solution intégrée qui permet aux entreprises partenaires d’optimiser leur organisation et de gagner en efficacité. Cette centralisation facilite non seulement la communication interne, mais aussi la relation avec les clients finaux, grâce à un système de gestion de tickets qui rend le suivi des incidents et des demandes beaucoup plus transparent.	# C'est quoi Kworks ?\r\n\r\nEn arrivant a KIHODEV j’ai travaillé sur Kworks, une solution interne au sein du groupe KIHO, qui est appelée à devenir un produit commercialisable pour l’année 2026. Cette plateforme SaaS a été conçue pour répondre aux besoins opérationnels complexes des sociétés de services, en centralisant au même endroit plusieurs fonctionnalités essentielles. L’objectif principal de Kworks est de simplifier la gestion des interventions techniques, en offrant une interface claire pour la planification des interventions, le suivi en temps réel des incidents, la gestion des ressources humaines, ainsi que la facturation. Plutôt que d’avoir plusieurs outils distincts, Kworks propose une solution intégrée qui permet aux entreprises partenaires d’optimiser leur organisation et de gagner en efficacité. Cette centralisation facilite non seulement la communication interne, mais aussi la relation avec les clients finaux, grâce à un système de gestion de tickets qui rend le suivi des incidents et des demandes beaucoup plus transparent.\r\n\r\n# Missions \r\n\r\n- Participation au développement d'un serveur API backend Spring Boot\r\n- Contribution à l’implémentation d'un serveur web frontend Angular\r\n- Participation au développement d’une application mobile avec Flutter	stage-sn1-69224db7680bb.png			0	t	2025-11-20 14:30:36	2025-11-25 00:24:48	autre	professionnel	\N	\N
9	Projet Workshop SN1 — Machine de Rube Goldberg	Projet Workshop SN1		worshop-sn1-69223a0a61330.png			0	f	2025-11-18 12:59:15	2025-12-05 12:58:26	autre	formation	2024-09-09	2024-09-13
18	DepotScolaire — Plateforme de gestion de dépôt/rendu de devoirs pour professeurs et élèves.	Projet de l’Epreuve E6 du BTS SIO					0	t	2025-11-18 13:05:47	2025-12-06 21:12:24	app-web	formation	2025-10-08	2025-12-12
\.


--
-- Data for Name: project_file; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.project_file (id, project_id, filename, original_name, mime_type, file_size, file_type, uploaded_at) FROM stdin;
31	10	projet-TPRE101-dossier-6922254fc3af0.pdf	projet-TPRE101-dossier-6922254fc3af0.pdf	application/pdf	3817659	document	2025-11-22 21:04:21
32	10	projet-TPRE101-feuille-de-route-6922258e81884.pdf	projet-TPRE101-feuille-de-route-6922258e81884.pdf	application/pdf	441975	document	2025-11-22 21:05:31
33	10	projet-TPRE101-support-692225ab5a24e.pdf	projet-TPRE101-support-692225ab5a24e.pdf	application/pdf	2283448	document	2025-11-22 21:05:50
36	20	Rapport-de-STAGE-Kaelian-BAUDELET-SN1-2024-2025-692226fca2bd3.pdf	Rapport-de-STAGE-Kaelian-BAUDELET-SN1-2024-2025-692226fca2bd3.pdf	application/pdf	19002159	document	2025-11-22 21:11:28
37	14	Projet-TPRW213-2025-Veille-Technologique-69222992b7478.pdf	Projet-TPRW213-2025-Veille-Technologique-69222992b7478.pdf	application/pdf	6878149	document	2025-11-22 21:22:29
38	11	ARCHITECTURE-RESEAUX-DIAPO-SN1-2024-TPRW204-69222ac282e36.pdf	ARCHITECTURE-RESEAUX-DIAPO-SN1-2024-TPRW204-69222ac282e36.pdf	application/pdf	4116822	document	2025-11-22 21:27:38
39	11	PROJET-ARCHI-RES-SN1-2024-TPRW204-69222b0da6fba.pdf	PROJET-ARCHI-RES-SN1-2024-TPRW204-69222b0da6fba.pdf	application/pdf	3745355	document	2025-11-22 21:28:49
40	9	EPSI-SN1-Projet-Workshop-Machine-de-Rube-Goldberg-Dossier-69222bffeaeca.pdf	EPSI-SN1-Projet-Workshop-Machine-de-Rube-Goldberg-Dossier-69222bffeaeca.pdf	application/pdf	545585	document	2025-11-22 21:32:52
41	9	EPSI-SN1-Projet-Workshop-Machine-de-Rube-Goldberg-Support-69222c0a41cfd.pdf	EPSI-SN1-Projet-Workshop-Machine-de-Rube-Goldberg-Support-69222c0a41cfd.pdf	application/pdf	2002239	document	2025-11-22 21:33:00
42	12	Projet-22Concevoir-et-exploiter-une-base-de-donnees-dans-un-environnement-web-22-EPSI-SN1-2024-2025-TPRW207-69222c9eace3a.pdf	Projet-22Concevoir-et-exploiter-une-base-de-donnees-dans-un-environnement-web-22-EPSI-SN1-2024-2025-TPRW207-69222c9eace3a.pdf	application/pdf	9945238	document	2025-11-22 21:35:29
43	12	Projet-TPRW207-Concevoir-et-exploiter-une-base-de-donnees-dans-un-environnement-web-69222ceb6cd52.pdf	Projet-TPRW207-Concevoir-et-exploiter-une-base-de-donnees-dans-un-environnement-web-69222ceb6cd52.pdf	application/pdf	6643096	document	2025-11-22 21:36:51
44	13	Projet-TPRW210-Communication-Digitale-Cas-Arcachon-69222d4476978.pdf	Projet-TPRW210-Communication-Digitale-Cas-Arcachon-69222d4476978.pdf	application/pdf	3062347	document	2025-11-22 21:38:16
45	15	EPSI-SN2-Projet-Workshop-Q-La-nouvelle-Generation-Support-69222dd821f2b.pdf	EPSI-SN2-Projet-Workshop-Q-La-nouvelle-Generation-Support-69222dd821f2b.pdf	application/pdf	5143929	document	2025-11-22 21:40:44
46	15	EPSI-SN2-Projet-Workshop-Q-La-nouvelle-Generation-Dossier-69222dd81f836.pdf	EPSI-SN2-Projet-Workshop-Q-La-nouvelle-Generation-Dossier-69222dd81f836.pdf	application/pdf	1277113	document	2025-11-22 21:40:44
47	20	Support-Presentation-STAGE-SN1-KIHODEV-Kaelian-BAUDELET-69222e9508bd1.pdf	Support-Presentation-STAGE-SN1-KIHODEV-Kaelian-BAUDELET-69222e9508bd1.pdf	application/pdf	14225881	document	2025-11-22 21:43:51
48	14	Support-TPRW213-2025-Veille-Technologique-69222f79be94a.pdf	Support-TPRW213-2025-Veille-Technologique-69222f79be94a.pdf	application/pdf	6636730	document	2025-11-22 21:47:41
49	17	Projet-AP2-Cybersecurite-Introduction-a-la-securite-informatique-et-aux-attaques-de-mots-de-passe-Dossier-6922333feeab2.pdf	Projet-AP2-Cybersecurite-Introduction-a-la-securite-informatique-et-aux-attaques-de-mots-de-passe-Dossier-6922333feeab2.pdf	application/pdf	2734413	document	2025-11-22 22:03:53
50	17	Projet-AP2-Cybersecurite-Introduction-a-la-securite-informatique-et-aux-attaques-de-mots-de-passe-Support-6922334676e3d.pdf	Projet-AP2-Cybersecurite-Introduction-a-la-securite-informatique-et-aux-attaques-de-mots-de-passe-Support-6922334676e3d.pdf	application/pdf	11023429	document	2025-11-22 22:03:53
51	16	Documentation-DBBackupCLI-692233b1ce66d.pdf	Documentation-DBBackupCLI-692233b1ce66d.pdf	application/pdf	97882	document	2025-11-22 22:05:42
52	16	Projet-AP1-Cybersecurite-Support-692233b1d0b4c.pdf	Projet-AP1-Cybersecurite-Support-692233b1d0b4c.pdf	application/pdf	3057825	document	2025-11-22 22:05:42
53	16	Projet-AP1-Cybersecurite-Dossier-692233b1d3ee5.pdf	Projet-AP1-Cybersecurite-Dossier-692233b1d3ee5.pdf	application/pdf	3615853	document	2025-11-22 22:05:42
54	13	TPRW210-COMMUNICATION-DIGITALE-Support-6922451d6ed31.pdf	TPRW210-COMMUNICATION-DIGITALE-Support-6922451d6ed31.pdf	application/pdf	6754466	document	2025-11-22 23:19:59
\.


--
-- Data for Name: project_image; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.project_image (id, project_id, filename, display_order, created_at) FROM stdin;
12	19	page-competences-portfolio-bts-sio-691c7e4940940.png	1	2025-11-18 14:10:41
14	19	page-a-propos-portfolio-bts-sio-691c7e45127b6.png	3	2025-11-18 14:10:41
15	19	page-stage-portfolio-bts-sio-691c7e4f5d949.png	4	2025-11-18 14:10:41
\.


--
-- Data for Name: project_skill; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.project_skill (project_id, skill_id) FROM stdin;
19	4
10	4
10	7
11	7
11	4
11	8
19	7
12	4
12	7
13	6
13	7
14	9
14	7
9	7
15	7
16	7
16	4
18	7
17	7
17	8
17	4
19	8
19	9
20	4
20	9
20	7
\.


--
-- Data for Name: project_technology; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.project_technology (project_id, technology_id) FROM stdin;
20	10
19	6
19	18
17	18
17	6
17	5
16	20
15	3
15	19
15	4
15	15
12	16
12	5
9	21
18	18
18	5
18	6
10	18
10	5
10	8
19	8
12	18
19	5
15	16
18	8
17	17
20	17
20	11
20	12
20	15
20	13
20	14
\.


--
-- Data for Name: skill; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.skill (id, name, code, icon, display_order, is_visible, description) FROM stdin;
4	Gérer le patrimoine informatique	Gérer le patrimoine informatique		0	t	
8	Mettre à disposition des utilisateurs un service informatique	Mettre à disposition des utilisateurs un service informatique		0	t	
9	Organiser son développement professionnel	Organiser son développement professionnel		0	t	
5	Répondre aux incidents et aux demandes d’assistance et d’évolution	Répondre aux incidents et aux demandes d’assistance et d’évolution		0	t	
7	Travailler en mode projet	Travailler en mode projet		0	t	
6	Développer la présence en ligne de l’organisation	Développer la présence en ligne de l’organisation		0	t	
\.


--
-- Data for Name: tech_watch_article; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.tech_watch_article (id, title, description, author, published_at, article_url, image, is_visible, display_order, created_at, updated_at) FROM stdin;
2	The Future of Server-Side Rendering: Trends for 2025	Server-Side Rendering (SSR) has been a crucial technique in web development, enabling faster load times, improved SEO, and enhanced user experiences. As we move into 2025, SSR continues to evolve, driven by new technologies, developer priorities, and user expectations.	KnubiSoft	2025-02-25	https://knubisoft.medium.com/the-future-of-server-side-rendering-trends-for-2025-78cde2c09084	1-Emd8O757iqev-EHEkvrq-g-692263d30d064.webp	t	0	2025-11-23 01:32:10	2025-11-23 01:32:34
3	Jopi : un clone de NextJS qui s'annonce plus performant - Programmez!	Jopi v3 est un clone de NextJS pour pouvoir afficher les pages React. Son auteur annonce un framework jusqu'à 7,5 plus performant que NextJS et même x3 pour la générer de 1000 pages. Jopi n'est pas qu'un simple clone. Il utilise un user roles pour limiter les accès et un core code modulaire. 	Programmez!	2025-12-09	https://www.programmez.com/actualites/jopi-un-clone-de-nextjs-qui-sannonce-plus-performant-38675		t	0	2025-12-09 14:10:31	2025-12-09 14:10:31
4	The New Frontend Era with Next.js and React	The frontend ecosystem is evolving quickly, and recent updates in Next.js, React, and modern UI architecture are leading this transformation. Here are the key shifts shaping the new era:	Muhammad Umair Arshad	2025-12-08	https://dev.to/umairarshad-dev/-58ag		t	0	2025-12-10 01:43:29	2025-12-10 01:43:29
6	Next.js 15 : Les nouveautés qui changent tout pour vos projets web	Next.js 15 marque une étape majeure dans l'évolution du framework React le plus populaire. Avec des améliorations significatives en termes de performance, de développement et d'expérience utilisateur, cette version redéfinit les standards du développement web moderne	Équipe OZC Web	2025-05-20	https://ozc-web.fr/blog/nextjs-14-nouveautes/?utm_source=chatgpt.com		t	0	2025-12-10 01:57:23	2025-12-10 01:57:23
5	Une vulnérabilité dans React et Next.js à corriger en urgence	Une faille critique dans la bibliothèque React a été corrigée et les développeurs sont invités à l'actualiser rapidement ainsi que le framework Next.js. Une urgence similaire à la vulnérabilité Log4j prévient un expert.	LeMondeInformatique	2025-12-08	https://www.lemondeinformatique.fr/actualites/lire-des-cyber-espions-chinois-ciblent-avec-persistance-vcenter-de-vmware-98729.html		t	0	2025-12-10 01:45:09	2025-12-10 01:57:56
\.


--
-- Data for Name: technology; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.technology (id, name, slug, icon, display_order) FROM stdin;
4	React	react	react.svg	0
5	PHP	php	php.svg	0
6	Symfony	symfony	symfony.svg	0
7	HTML	html	html.svg	0
9	JS	js	js.svg	0
10	Angular	angular	angular.svg	0
11	Springboot	springboot	springboot.svg	0
12	Java	java	java.svg	0
13	Flutter	flutter	flutter.svg	0
14	Dart	dart	dart.svg	0
15	NodeJS	nodejs	nodejs.svg	0
3	NextJS	nextjs	nextjs.svg	0
8	CSS	css	css.svg	0
16	Tailwind	tailwind	tailwind.svg	0
17	Bootstrap	bootstrap	bootstrap.svg	0
18	Twig	twig	twig.svg	0
19	Python	python	python.svg	0
20	Bash	bash	bash.svg	0
21	Arduino	arduino	arduino.svg	0
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public."user" (id, email, roles, password, username) FROM stdin;
1	aconique@gmail.com	["ROLE_ADMIN"]	$2y$13$VIhOWRTIbOKCgCslD1B3tOBFR6DCqFn1VAuWOdW72dj8HG9fybKdC	afi
\.


--
-- Name: certification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.certification_id_seq', 37, true);


--
-- Name: contact_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.contact_message_id_seq', 8, true);


--
-- Name: education_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.education_id_seq', 1, false);


--
-- Name: experience_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.experience_id_seq', 1, false);


--
-- Name: internship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.internship_id_seq', 4, true);


--
-- Name: project_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.project_file_id_seq', 54, true);


--
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.project_id_seq', 20, true);


--
-- Name: project_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.project_image_id_seq', 18, true);


--
-- Name: skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.skill_id_seq', 9, true);


--
-- Name: tech_watch_article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.tech_watch_article_id_seq', 6, true);


--
-- Name: technology_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.technology_id_seq', 21, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- Name: certification certification_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.certification
    ADD CONSTRAINT certification_pkey PRIMARY KEY (id);


--
-- Name: contact_message contact_message_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.contact_message
    ADD CONSTRAINT contact_message_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: education education_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.education
    ADD CONSTRAINT education_pkey PRIMARY KEY (id);


--
-- Name: experience experience_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.experience
    ADD CONSTRAINT experience_pkey PRIMARY KEY (id);


--
-- Name: internship internship_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.internship
    ADD CONSTRAINT internship_pkey PRIMARY KEY (id);


--
-- Name: internship_project internship_project_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.internship_project
    ADD CONSTRAINT internship_project_pkey PRIMARY KEY (internship_id, project_id);


--
-- Name: project_file project_file_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_file
    ADD CONSTRAINT project_file_pkey PRIMARY KEY (id);


--
-- Name: project_image project_image_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_image
    ADD CONSTRAINT project_image_pkey PRIMARY KEY (id);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: project_skill project_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_skill
    ADD CONSTRAINT project_skill_pkey PRIMARY KEY (project_id, skill_id);


--
-- Name: project_technology project_technology_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_technology
    ADD CONSTRAINT project_technology_pkey PRIMARY KEY (project_id, technology_id);


--
-- Name: skill skill_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (id);


--
-- Name: tech_watch_article tech_watch_article_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.tech_watch_article
    ADD CONSTRAINT tech_watch_article_pkey PRIMARY KEY (id);


--
-- Name: technology technology_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.technology
    ADD CONSTRAINT technology_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_4d68ede9166d1f9c; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_4d68ede9166d1f9c ON public.project_skill USING btree (project_id);


--
-- Name: idx_4d68ede95585c142; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_4d68ede95585c142 ON public.project_skill USING btree (skill_id);


--
-- Name: idx_95a33374166d1f9c; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_95a33374166d1f9c ON public.internship_project USING btree (project_id);


--
-- Name: idx_95a333747a4a70be; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_95a333747a4a70be ON public.internship_project USING btree (internship_id);


--
-- Name: idx_b50efe08166d1f9c; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_b50efe08166d1f9c ON public.project_file USING btree (project_id);


--
-- Name: idx_d6680dc1166d1f9c; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_d6680dc1166d1f9c ON public.project_image USING btree (project_id);


--
-- Name: idx_ecc5297f166d1f9c; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_ecc5297f166d1f9c ON public.project_technology USING btree (project_id);


--
-- Name: idx_ecc5297f4235d463; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_ecc5297f4235d463 ON public.project_technology USING btree (technology_id);


--
-- Name: uniq_8d93d649f85e0677; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE UNIQUE INDEX uniq_8d93d649f85e0677 ON public."user" USING btree (username);


--
-- Name: uniq_f463524d989d9b62; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE UNIQUE INDEX uniq_f463524d989d9b62 ON public.technology USING btree (slug);


--
-- Name: uniq_identifier_email; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE UNIQUE INDEX uniq_identifier_email ON public."user" USING btree (email);


--
-- Name: project_skill fk_4d68ede9166d1f9c; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_skill
    ADD CONSTRAINT fk_4d68ede9166d1f9c FOREIGN KEY (project_id) REFERENCES public.project(id) ON DELETE CASCADE;


--
-- Name: project_skill fk_4d68ede95585c142; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_skill
    ADD CONSTRAINT fk_4d68ede95585c142 FOREIGN KEY (skill_id) REFERENCES public.skill(id) ON DELETE CASCADE;


--
-- Name: internship_project fk_95a33374166d1f9c; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.internship_project
    ADD CONSTRAINT fk_95a33374166d1f9c FOREIGN KEY (project_id) REFERENCES public.project(id) ON DELETE CASCADE;


--
-- Name: internship_project fk_95a333747a4a70be; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.internship_project
    ADD CONSTRAINT fk_95a333747a4a70be FOREIGN KEY (internship_id) REFERENCES public.internship(id) ON DELETE CASCADE;


--
-- Name: project_file fk_b50efe08166d1f9c; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_file
    ADD CONSTRAINT fk_b50efe08166d1f9c FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: project_image fk_d6680dc1166d1f9c; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_image
    ADD CONSTRAINT fk_d6680dc1166d1f9c FOREIGN KEY (project_id) REFERENCES public.project(id) ON DELETE CASCADE;


--
-- Name: project_technology fk_ecc5297f166d1f9c; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_technology
    ADD CONSTRAINT fk_ecc5297f166d1f9c FOREIGN KEY (project_id) REFERENCES public.project(id) ON DELETE CASCADE;


--
-- Name: project_technology fk_ecc5297f4235d463; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.project_technology
    ADD CONSTRAINT fk_ecc5297f4235d463 FOREIGN KEY (technology_id) REFERENCES public.technology(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 93jMMSixSPqndryCkyaY7rRttcwbasSW5jMI58WNogeX5zxbmAkL12rhbw8x0zh

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict cujzkf4rCX17iojYRq9E1skmR3UIfpJO3LfIbtERTmY1KRaFmF1b7hSD2xFljjp

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict cujzkf4rCX17iojYRq9E1skmR3UIfpJO3LfIbtERTmY1KRaFmF1b7hSD2xFljjp

--
-- PostgreSQL database cluster dump complete
--


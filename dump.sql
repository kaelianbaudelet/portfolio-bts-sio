--
-- PostgreSQL database dump
--

\restrict t1FigHBc2d8Jj8GLz0yqjQh6SQ4BDp0DwFyUh9j9wyJyEsgljY7fGXJwc2I6arG

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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

ALTER TABLE IF EXISTS ONLY public.preuve DROP CONSTRAINT IF EXISTS fk_preuve_skill;
ALTER TABLE IF EXISTS ONLY public.preuve DROP CONSTRAINT IF EXISTS fk_preuve_project;
ALTER TABLE IF EXISTS ONLY public.project_technology DROP CONSTRAINT IF EXISTS fk_ecc5297f4235d463;
ALTER TABLE IF EXISTS ONLY public.project_technology DROP CONSTRAINT IF EXISTS fk_ecc5297f166d1f9c;
ALTER TABLE IF EXISTS ONLY public.project_image DROP CONSTRAINT IF EXISTS fk_d6680dc1166d1f9c;
ALTER TABLE IF EXISTS ONLY public.project_file DROP CONSTRAINT IF EXISTS fk_b50efe08166d1f9c;
ALTER TABLE IF EXISTS ONLY public.internship_project DROP CONSTRAINT IF EXISTS fk_95a333747a4a70be;
ALTER TABLE IF EXISTS ONLY public.internship_project DROP CONSTRAINT IF EXISTS fk_95a33374166d1f9c;
ALTER TABLE IF EXISTS ONLY public.project_skill DROP CONSTRAINT IF EXISTS fk_4d68ede95585c142;
ALTER TABLE IF EXISTS ONLY public.project_skill DROP CONSTRAINT IF EXISTS fk_4d68ede9166d1f9c;
DROP INDEX IF EXISTS public.uniq_identifier_email;
DROP INDEX IF EXISTS public.uniq_f463524d989d9b62;
DROP INDEX IF EXISTS public.uniq_8d93d649f85e0677;
DROP INDEX IF EXISTS public.idx_preuve_skill;
DROP INDEX IF EXISTS public.idx_preuve_project;
DROP INDEX IF EXISTS public.idx_ecc5297f4235d463;
DROP INDEX IF EXISTS public.idx_ecc5297f166d1f9c;
DROP INDEX IF EXISTS public.idx_d6680dc1166d1f9c;
DROP INDEX IF EXISTS public.idx_b50efe08166d1f9c;
DROP INDEX IF EXISTS public.idx_95a333747a4a70be;
DROP INDEX IF EXISTS public.idx_95a33374166d1f9c;
DROP INDEX IF EXISTS public.idx_4d68ede95585c142;
DROP INDEX IF EXISTS public.idx_4d68ede9166d1f9c;
ALTER TABLE IF EXISTS ONLY public."user" DROP CONSTRAINT IF EXISTS user_pkey;
ALTER TABLE IF EXISTS ONLY public.technology DROP CONSTRAINT IF EXISTS technology_pkey;
ALTER TABLE IF EXISTS ONLY public.tech_watch_article DROP CONSTRAINT IF EXISTS tech_watch_article_pkey;
ALTER TABLE IF EXISTS ONLY public.skill DROP CONSTRAINT IF EXISTS skill_pkey;
ALTER TABLE IF EXISTS ONLY public.project_technology DROP CONSTRAINT IF EXISTS project_technology_pkey;
ALTER TABLE IF EXISTS ONLY public.project_skill DROP CONSTRAINT IF EXISTS project_skill_pkey;
ALTER TABLE IF EXISTS ONLY public.project DROP CONSTRAINT IF EXISTS project_pkey;
ALTER TABLE IF EXISTS ONLY public.project_image DROP CONSTRAINT IF EXISTS project_image_pkey;
ALTER TABLE IF EXISTS ONLY public.project_file DROP CONSTRAINT IF EXISTS project_file_pkey;
ALTER TABLE IF EXISTS ONLY public.preuve DROP CONSTRAINT IF EXISTS preuve_pkey;
ALTER TABLE IF EXISTS ONLY public.internship_project DROP CONSTRAINT IF EXISTS internship_project_pkey;
ALTER TABLE IF EXISTS ONLY public.internship DROP CONSTRAINT IF EXISTS internship_pkey;
ALTER TABLE IF EXISTS ONLY public.experience DROP CONSTRAINT IF EXISTS experience_pkey;
ALTER TABLE IF EXISTS ONLY public.education DROP CONSTRAINT IF EXISTS education_pkey;
ALTER TABLE IF EXISTS ONLY public.doctrine_migration_versions DROP CONSTRAINT IF EXISTS doctrine_migration_versions_pkey;
ALTER TABLE IF EXISTS ONLY public.contact_message DROP CONSTRAINT IF EXISTS contact_message_pkey;
ALTER TABLE IF EXISTS ONLY public.certification DROP CONSTRAINT IF EXISTS certification_pkey;
ALTER TABLE IF EXISTS public."user" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.technology ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tech_watch_article ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.skill ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.project_image ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.project_file ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.project ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.internship ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.experience ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.education ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.contact_message ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.certification ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.user_id_seq;
DROP TABLE IF EXISTS public."user";
DROP SEQUENCE IF EXISTS public.technology_id_seq;
DROP TABLE IF EXISTS public.technology;
DROP SEQUENCE IF EXISTS public.tech_watch_article_id_seq;
DROP TABLE IF EXISTS public.tech_watch_article;
DROP SEQUENCE IF EXISTS public.skill_id_seq;
DROP TABLE IF EXISTS public.skill;
DROP TABLE IF EXISTS public.project_technology;
DROP TABLE IF EXISTS public.project_skill;
DROP SEQUENCE IF EXISTS public.project_image_id_seq;
DROP TABLE IF EXISTS public.project_image;
DROP SEQUENCE IF EXISTS public.project_id_seq;
DROP SEQUENCE IF EXISTS public.project_file_id_seq;
DROP TABLE IF EXISTS public.project_file;
DROP TABLE IF EXISTS public.project;
DROP TABLE IF EXISTS public.preuve;
DROP SEQUENCE IF EXISTS public.preuve_id_seq;
DROP TABLE IF EXISTS public.internship_project;
DROP SEQUENCE IF EXISTS public.internship_id_seq;
DROP TABLE IF EXISTS public.internship;
DROP SEQUENCE IF EXISTS public.experience_id_seq;
DROP TABLE IF EXISTS public.experience;
DROP SEQUENCE IF EXISTS public.education_id_seq;
DROP TABLE IF EXISTS public.education;
DROP TABLE IF EXISTS public.doctrine_migration_versions;
DROP SEQUENCE IF EXISTS public.contact_message_id_seq;
DROP TABLE IF EXISTS public.contact_message;
DROP SEQUENCE IF EXISTS public.certification_id_seq;
DROP TABLE IF EXISTS public.certification;
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
-- Name: preuve_id_seq; Type: SEQUENCE; Schema: public; Owner: portfolio
--

CREATE SEQUENCE public.preuve_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.preuve_id_seq OWNER TO portfolio;

--
-- Name: preuve; Type: TABLE; Schema: public; Owner: portfolio
--

CREATE TABLE public.preuve (
    id integer DEFAULT nextval('public.preuve_id_seq'::regclass) NOT NULL,
    project_id integer NOT NULL,
    skill_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    filename character varying(255) NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.preuve OWNER TO portfolio;

--
-- Name: COLUMN preuve.created_at; Type: COMMENT; Schema: public; Owner: portfolio
--

COMMENT ON COLUMN public.preuve.created_at IS '(DC2Type:datetime_immutable)';


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
DoctrineMigrations\\Version20260403010000	2026-04-03 01:11:31	21
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
5	Stagiaire Développeur Full Stack	Grégory Boudringhin EI	greg-69cf1d4b421bb.jpg	2026-01-05	2026-02-13	Dans le cadre de ma formation en BTS SIO (option SLAM), j'ai réalisé mon stage de deuxième année de six semaines chez Grégory Boudringhin EI, du 5 janvier au 13 février 2026. Ce stage m'a permis d'approfondir concrètement le métier de développeur fullstack.\r\nJ'ai participé pendant quatre semaines au développement de Wavely, une plateforme SaaS de type App Builder TV permettant de créer, éditer et publier facilement des applications télévisées destinées aux radios. Cette expérience m'a permis de renforcer mes compétences techniques et d'élargir ma maîtrise des pratiques du développement fullstack.	De janvier à février 2026, j'ai effectué un second stage en tant que développeur Fullstack. Dans le cadre de cette mission, j'ai créé la plateforme SaaS Wavely, un éditeur d'applications dédié à l'OTT sur TV qui intègre la conception visuelle ainsi que la publication automatisée vers les stores.\r\n\r\nMon travail s'est principalement articulé autour du développement complet de cet éditeur et de l'automatisation des flux de déploiement spécifiques aux plateformes de streaming. Ce projet m'a permis de concevoir une solution globale de A à Z, tout en assurant une expérience utilisateur optimale sur les interfaces TV connectées.\r\nAfin de mener à bien ce projet, j'ai pu développer et approfondir mes compétences techniques sur une stack spécialisée, utilisant notamment NestJS pour le backend, ainsi que TypeScript et React pour l'interface d'édition. Par ailleurs, j'ai également travaillé sur la partie diffusion avec React Native, Expo et le langage Roku BrightScript pour assurer la compatibilité TV.	["Contribution au d\\u00e9veloppement d'une application mobile skeleton (r\\u00e9ceptable) avec Expo React Native","Contribution \\u00e0 l'impl\\u00e9mentation d'un frontend web avec React et ViteJS","Participation au d\\u00e9veloppement d'un serveur API backend avec NestJS"]	2026	0	t	2026-04-03 01:52:42	2026-04-03 03:17:17
4	Stagiaire Développeur Full Stack	KihoDev	logo-kiho-6922524bb8261.png	2025-04-19	2025-08-05	Dans le cadre de ma formation en BTS SIO (option SLAM), j’ai réalisé un stage de neuf semaines chez KIHODEV, filiale du groupe KIHO, du 22 avril au 20 juin 2025. Ce stage m’a permis de découvrir concrètement le métier de développeur web et concepteur logiciel.	Dans le cadre de ma formation en BTS Services Informatiques aux Organisations avec spécialité Solutions Logicielles et Applications Métier (SLAM). J’ai effectué un stage au sein de l’infrastructure KIHODEV (filiale du groupe KIHO) durant neuf semaines du mardi 22 avril 2025 au vendredi 20 juin 2025. Au cours de ce stage, j’ai pu m’initier concrètement au métier de développeur web et concepteur logiciel.\r\n\r\nMon stage a consisté en la participation au développement de Kworks, un logiciel interne de KIHODEV destiné à être commercialisé. J’ai contribué à plusieurs étapes clés de sa conception et de sa mise en œuvre.\r\n\r\nCette expérience a été l’opportunité pour moi de percevoir comment une entreprise spécialisée dans le développement de solutions numériques sur mesure se développe, et de mieux comprendre les processus liés à la conception, la réalisation et l’évolution d’un logiciel interne évolutif, notamment en ce qui concerne sa structuration et sa commercialisation.	["Participation au d\\u00e9veloppement d'un serveur API backend Spring Boot","Contribution \\u00e0 l\\u2019impl\\u00e9mentation d'un serveur web frontend Angular","Participation au d\\u00e9veloppement d\\u2019une application mobile avec Flutter"]	2025	0	t	2025-11-17 13:13:50	2026-04-03 02:14:36
\.


--
-- Data for Name: internship_project; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.internship_project (internship_id, project_id) FROM stdin;
4	20
5	21
\.


--
-- Data for Name: preuve; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.preuve (id, project_id, skill_id, title, description, filename, display_order, created_at) FROM stdin;
1	20	7	Travailler en mode projet	Tout au long de mon stage, j'ai activement collaboré en mode projet avec Mélanie Boudry et James Morelle, mes collègues de travail. Cette collaboration s'est principalement appuyée sur Microsoft Teams, qui a été notre outil de communication central pour les échanges quotidiens, le suivi de l'avancement des tâches et la coordination entre les membres de l'équipe.	Presentation-Portfolio-de-competences-69cf3216510d6.png	0	2026-04-03 03:21:55
2	20	4	Gérer le patrimoine informatique	Avec Mélanie, nous avons pensé tout au long du projet la solution Kworks de l'API jusqu'à l'application mobile, en ayant toujours à l'esprit les accès et les habilitations, en vérifiant systématiquement les droits par rôle et les conditions des utilisateurs dès la phase d'ajout de nouvelles fonctionnalités dans le code.	Presentation-Portfolio-de-competences-1-69cf34437de6e.png	0	2026-04-03 03:32:08
3	20	8	Mettre à disposition des utilisateurs un service informatique	Pendant tout le projet, j'ai veillé à effectuer des tests d'acceptation auprès de James et Mélanie, et à reverifier chaque vendredi avec Mélanie l'ensemble des fonctionnalités implémentées lors d'une phase de test et de vérification dédiée. Ces sessions hebdomadaires étaient également l'occasion de réaliser soigneusement les merges de code sur GitHub, afin de garantir l'intégrité et la stabilité de la base de code commune.	Capture-d-ecran-2026-04-03-a-01-19-36-69cf35b327185.png	0	2026-04-03 03:36:23
4	20	6	Développer la présence en ligne de l’organisation	Durant mon stage, j'ai pu réaliser une vidéo de présentation complète à destination de James, mettant en avant la fonctionnalité d'examens développée. Cette vidéo lui a permis de démontrer l'avancement du projet auprès d'un prestataire client pour lequel il travaillait, contribuant ainsi directement à la communication externe et à la valorisation du travail accompli.	Presentation-Portfolio-de-competences-2-69cf36a8b0fea.png	0	2026-04-03 03:40:29
5	20	9	Organiser son développement professionnel	Durant mon stage, j'ai été amené à mener plusieurs veilles technologiques. La première portait sur le choix technique du design system de l'application, pour laquelle j'ai réalisé un comparatif détaillé des solutions Tailwind CSS, Bootstrap et Angular Material, en analysant leurs avantages et inconvénients respectifs. La seconde veille concernait l'implémentation d'un outil technicien dans l'application Wavely permettant de scanner des équipements réseau, pour laquelle j'ai effectué des recherches approfondies afin d'identifier les solutions techniques les plus adaptées.	Presentation-Portfolio-de-competences-3-69cf374ce8e71.png	0	2026-04-03 03:43:11
8	21	6	Développer la présence en ligne de l’organisation	Au cours de mon stage, j'ai eu l'occasion de concevoir et de développer une page d'accueil commerciale pour Wavely, destinée à présenter la plateforme et à valoriser son offre auprès des visiteurs.	Presentation-Portfolio-de-competences-5-69cf38b5415ff.png	0	2026-04-03 03:50:00
10	21	4	Gérer le patrimoine informatique	Afin d'assurer au mieux la continuité du projet après mon départ, j'ai rédigé plusieurs documentations couvrant chacune des parties du projet, notamment la base de données, l'application TV ainsi que l'éditeur d'application, en décrivant de manière claire et détaillée l'ensemble des informations nécessaires à la compréhension et à la prise en main de chaque composant.	Presentation-Portfolio-de-competences-6-69cf396caf621.png	0	2026-04-03 03:53:19
11	21	9	Organiser son développement professionnel	Au cours de mon stage, j'ai eu l'occasion de mener de nombreuses veilles technologiques sur plusieurs frameworks simultanément, pour lesquelles j'ai consacré de nombreuses heures à parcourir les documentations officielles de chaque framework ainsi qu'à visionner des tutoriels sur YouTube, afin de monter en compétences de manière autonome et efficace.	Presentation-Portfolio-de-competences-7-69cf3a0e61281.png	0	2026-04-03 03:54:56
12	21	8	Mettre à disposition des utilisateurs un service informatique	Au cours de mon stage, j'ai eu l'occasion d'échanger avec Grégory lors de mon dernier jour afin de lui expliquer le fonctionnement de l'infrastructure. J'ai ainsi pu lui présenter, via Discord, les étapes nécessaires au déploiement de la solution ainsi que les différents éléments de configuration indispensables à sa mise en production.	Presentation-Portfolio-de-competences-4-69cf384bb89bd.png	0	2026-04-03 03:56:42
13	21	7	Travailler en mode projet	Tout au long de mon stage, j'ai eu l'occasion d'échanger et de communiquer avec Grégory via Discord, qui a été notre principal outil de communication pour le suivi du travail et les échanges quotidiens.	Presentation-Portfolio-de-competences-8-69cf3aad8309c.png	0	2026-04-03 03:58:21
14	16	7	Travailler en mode projet	Tout au long de mon projet, j'ai organisé mon travail en planifiant mes tâches via un diagramme de Gantt, ce qui m'a permis de structurer mon avancement par sprints.	diagramme-de-gantt-ap1-69ede945e5196.png	0	2026-04-26 10:30:39
15	16	7	Travailler en mode projet	Tout au long de mon projet, j'ai utilisé l'outil Jira pour planifier et organiser mes tâches, ce qui m'a permis de suivre précisément l'évolution de chaque sprint.	preuve-tableau-des-taches-ap1-69ede983a754b.png	0	2026-04-26 10:31:36
16	22	4	Gérer le patrimoine informatique	Dans le cadre de mon projet Forum, j'ai implémenté un système d'authentification. Chaque utilisateur doit être connecté pour pouvoir répondre à un commentaire. Pour permettre cela, une page de connexion et une page d'inscription ont été mises en place dans l'application. Toute la logique d'authentification a été réalisée côté API Platform.	preuve-authentification-projet-forum-69ee1b896ed35.png	0	2026-04-26 14:11:28
17	22	9	Organiser son développement professionnel	En complément des enseignements théoriques dispensés par M. Le Gales, mon professeur de SLAM et Flutter, j’ai adopté une démarche proactive de veille technologique pour préparer l’épreuve E6. Afin d'anticiper les exigences techniques de l'examen. En consultant les documentations officielles, j’ai approfondi ma maîtrise de l'écosystème Symfony, API Platform et Flutter. J'ai pu consolider mes acquis techniques et structurer mes méthodes de travail afin d'être pleinement opérationnel et autonome le jour de l'examen.	preuve-veille-projet-forum-69ee21ea92dfb.png	0	2026-04-26 14:32:14
18	22	7	Travailler en mode projet	Pour piloter la réalisation du Projet Forum, j'ai utilisé l'outil Jira afin de structurer mon flux de travail sur ce projet de situation 2 pour l'épreuve E6 du BTS SIO. Cette organisation en mode agile m'a permis de découper chaque fonctionnalité en tickets précis et de suivre en temps réel l'avancement de mes sprints durant tout le mois d'avril.	preuve-plannification-jira-projet-forum-69ee336db8392.png	0	2026-04-26 15:50:18
34	12	9	Organiser son développement professionnel	Pour le projet hôtel Neptune, j'ai organisé mon développement professionnel en me documentant de manière approfondie sur les documentations officielles de PHP et Twig. Cette recherche personnelle, menée en complément des cours de M. Le Galès, a été indispensable pour maîtriser les spécificités techniques nécessaires à la réussite de ce projet.	preuve-organiser-developpement-profesionnel-projet-hotel-neptune-69ef185f8fb36.png	0	2026-04-27 08:12:08
19	19	7	Travailler en mode projet	Tout au long de mes deux années à l'EPSI, j'ai planifié l'évolution de mon portfolio pour l'épreuve E5 via un tableau de bord Jira. De la veille technologique à la rédaction finale, j'ai découpé chaque section en tâches spécifiques. Cette organisation m'a permis de structurer mon avancement de manière logique, garantissant que chaque étapes de la réalisation de ce portfolio, du développement technique du portfolio E5, en passant par la rédactions des éléments (projets, compétences, certifications, veille) jusqu’à sa mise en service effective pour le jour de l'épreuve.	preuve-projet-portfolio-organisation-en-mode-projet-69ee3cb704366.png	0	2026-04-26 16:34:27
20	18	7	Travailler en mode projet	Tout au long de la réalisation du projet Dépôt Scolaire, j'ai utilisé l'outil Jira pour planifier et organiser mes tâches, ce qui m'a permis de suivre précisément l'évolution de chaque sprint, de la gestion des classes jusqu'à la mise en place du système de rendu de devoirs.	preuve-projet-depotscolaire-travaille-en-mode-projet-69ee4993d349b.png	0	2026-04-26 17:21:44
21	11	8	Mettre à disposition des utilisateurs un service informatique	Dans le cadre de ma formation, j'ai réalisé l'installation physique et la configuration d'une infrastructure réseau locale sécurisée avec mon groupe. L'objectif était de simuler un environnement d'entreprise fonctionnel, incluant la gestion des accès, l'adressage dynamique et l'interconnexion de postes clients et serveurs.	preuve-projet-archi-reseaux-infra-69ee4bebe9dd1.jpg	0	2026-04-26 17:32:16
22	19	4	Gérer le patrimoine informatique	Dans le cadre de l'épreuve E5, j'ai développé mon propre portfolio en mettant en place un système d'authentification sécurisé permettant de gérer les accès à la plateforme. Cette réalisation inclut un panneau d'administration complet qui me permet d'administrer le site de A à Z : gestion des projets, mise à jour de ma veille technologique et modification des informations personnelles.	preuve-patrimoine-info-portfolio-69ef08e9d9e48.png	0	2026-04-27 06:59:35
23	19	9	Organiser son développement professionnel	Pour mon portfolio de l'épreuve E5, j'ai réalisé une veille sur Symfony 7 en exploitant les documentations officielles de Symfony et Twig. Cette démarche d'auto-formation m'a permis d'actualiser mes compétences et de maîtriser les dernières évolutions du framework.	preuve-veille-techo-site-portoflio-69ef0b36a17de.png	0	2026-04-27 07:07:38
24	19	8	Mettre à disposition des utilisateurs un service informatique	Pour l'épreuve E5, j'ai déployé mon portfolio sur un serveur privé (VPS) sous Linux en configurant Nginx pour rendre le site accessible via portfolio.kaelian.dev. Cette mise en production a mobilisé mes compétences en administration système pour assurer la mise à disposition réelle du service.	preuve-mettre-a-dispo-infra-projet-portfolio-69ef0bf1e9004.png	0	2026-04-27 07:12:48
25	18	9	Organiser son développement professionnel	En complément des enseignements théoriques dispensés par M. Le Gales, mon professeur de SLAM et Symfony, j’ai adopté une démarche proactive de veille technologique pour préparer l’épreuve E6. Afin d'anticiper les exigences techniques de l'examen. En consultant la documentations officiel de Symfony. J'ai pu consolider mes acquis techniques et  structurer mes méthodes de travail afin d'être pleinement opérationnel et autonome le jour de l'examen.	preuve-veille-techo-site-portoflio-69ef0b36a17de.png	0	2026-04-27 07:16:42
26	18	4	Gérer le patrimoine informatique	Pour mon projet "Dépôt Scolaire", j'ai développé un système d'authentification sécurisé permettant de gérer les accès au patrimoine applicatif. Les utilisateurs peuvent s'inscrire et se connecter selon deux rôles distincts, élève ou professeur, garantissant ainsi la protection des données et la gestion des droits sur la plateforme.	preuve-depot-scolaire-gerer-patrimoine-info-69ef0edb97617.png	0	2026-04-27 07:23:10
27	17	7	Travailler en mode projet	Pour le projet collectif AP2, j'ai utilisé Jira pour planifier et organiser les tâches au sein de mon groupe. Cette méthode de travail en mode projet nous a permis de structurer nos sprints et de suivre précisément l'avancement de chaque membre du groupe jusqu'à la livraison finale.	preuve-travailler-en-mode-projet-projet-ap2-69ef0fc4a35b7.png	0	2026-04-27 07:27:34
28	17	8	Mettre à disposition des utilisateurs un service informatique	Pour le projet AP2, j'ai assuré la mise à disposition du service en déployant le site sur mon serveur privé (VPS) le jour de la présentation. Cette mise en production réelle a permis de démontrer le travail effectué en rendant l'application accessible pour le professeur.	preuve-mettre-a-disposition-infra-utilisateur-projet-ap2-69ef117ed9c30.png	0	2026-04-27 07:34:29
29	17	4	Gérer le patrimoine informatique	Lors du projet AP2, j'ai contribué à la sécurisation du patrimoine applicatif en mettant en place l'authentification Symfony. J'ai configuré la base de données avec des rôles distincts (Admin/User) et développé la logique de contrôle dans le Controller pour restreindre l'accès aux ressources selon le profil de l'utilisateur.	preuve-gerer-patrimoine-informatique-projet-ap2-69ef11fd73a9b.png	0	2026-04-27 07:36:31
30	16	9	Organiser son développement professionnel	Pour réaliser mon utilitaire CLI, j'ai mené une veille technologique afin de concevoir des scripts Bash structurés et propres. En me documentant sur des sites comme Debian-facile, j'ai pu assimiler les bonnes pratiques de programmation shell et organiser mon développement professionnel de manière autonome.	preuve-organiser-developpement-pro-projet-ap1-69ef146c50be8.png	0	2026-04-27 07:46:57
31	16	4	Gérer le patrimoine informatique	Pour ce projet, j'ai développé un utilitaire CLI permettant de réaliser des sauvegardes complètes de bases de données MySQL. Cet outil garantit la sécurité du patrimoine informatique en automatisant l'extraction des données, assurant ainsi une restauration rapide et fiable en cas d'incident.	preuve-gerer-patrimoine-informatique-projet-ap1-69ef15f159d77.png	0	2026-04-27 07:53:31
32	12	7	Travailler en mode projet	Pour ce projet, j'ai utilisé un tableau de planification sous Excel pour organiser la répartition des tâches au sein de l'équipe. Cette méthode nous a permis de définir précisément les missions de chacun et de fixer les dates de début et de fin pour chaque sprint, garantissant ainsi un suivi rigoureux de l'avancement du projet.	preuve-travailler-en-mode-projet-projet-hotel-neptune-69ef185f8d136.png	0	2026-04-27 08:05:13
33	12	4	Gérer le patrimoine informatique	Pour le projet de l'hôtel Neptune, j'ai contribué à la sécurisation du patrimoine applicatif en mettant en place un système d'authentification. J'ai configuré la protection des routes pour restreindre l'accès aux seules utilisateurs authentifiés, garantissant ainsi que chaque ressource du site est protégée selon le rôle de l'utilisateur.	preuve-gerer-patrimoine-informatique-projet-hotel-neptune-69ef185f92329.png	0	2026-04-27 08:07:37
35	15	9	Organiser son développement professionnel	Pour ce projet Nix, j'ai mené une veille technologique sur Next.js et React afin de concevoir un tableau de bord capable d'afficher les retranscriptions audio. Cette démarche d'auto-formation m'a permis de maîtriser ces frameworks modernes pour structurer l'interface de gestion des données du "gadget espion".	preuve-organiser-developpement-profesionnel-projet-nix-69ef1b90716c6.png	0	2026-04-27 08:21:56
36	10	7	Travailler en mode projet	Pour le projet FileSphere, j'ai utilisé Discord comme plateforme de collaboration centrale pour échanger en temps réel avec mon groupe. Cet outil nous a permis de planifier notre organisation et de maintenir une communication constante tout au long du développement afin de coordonner efficacement nos actions.	preuve-travailler-en-mode-projet-projet-filesphere-69ef1e720a220.png	0	2026-04-27 08:29:43
37	10	9	Organiser son développement professionnel	Pour le projet Filesphere, j'ai organisé mon développement professionnel en menant une veille technologique sur PHP et Twig. La consultation régulière des documentations officielles m'a permis d'approfondir mes connaissances techniques et d'appliquer les standards de développement nécessaires à la réalisation de ce projet de groupe.	preuve-organiser-developpement-profesionnel-projet-hotel-neptune-69ef185f8fb36.png	0	2026-04-27 08:31:34
38	10	4	Gérer le patrimoine informatique	Pour ce projet, j'ai mis en place un système d'authentification gérant différents rôles (élève, professeur, administrateur) afin de sécuriser l'accès à la plateforme de livrables. En développant cette logique de contrôle au sein des contrôleurs, j'ai pu restreindre l'accès aux fonctionnalités selon le profil de l'utilisateur, garantissant ainsi l'intégrité et la confidentialité du patrimoine applicatif.	preuve-gerer-patrimoine-informatique-projet-filesphere-69ef1e7207e3a.png	0	2026-04-27 08:33:56
39	13	7	Travailler en mode projet	Pour ce projet de communication sur la redynamisation du bassin d'Arcachon, j'ai collaboré avec mon groupe en utilisant un tableau de tâches sous Excel. Cet outil nous a permis de planifier chaque action et de suivre précisément l'échéancier du projet afin de garantir le respect des délais fixés.	preuve-travailler-mode-projet-projet-arcachon-69ef203db132c.png	0	2026-04-27 08:38:34
40	13	6	Développer la présence en ligne de l’organisation	Pour ce projet de communication sur la redynamisation du bassin d'Arcachon, j'ai participé à l'élaboration d'une stratégie globale visant à moderniser l'offre de transport. En proposant un plan d'action structuré, j'ai contribué à valoriser les transports du bassin d'Arcachon.	preuve-developper-presence-organisation-projet-arcachon-69ef218003852.png	0	2026-04-27 08:44:26
41	11	7	Travailler en mode projet	Pour ce projet, j'ai utilisé une planification structurée pour définir et répartir les missions au sein du groupe. Cela nous a permis de fixer les objectifs de chaque membre du groupe et de suivre précisément l'avancement des tâches, garantissant une coordination efficace de l'équipe tout au long du projet	preuve-travailler-mode-projet-genhealth-69ef283de7f3e.png	0	2026-04-27 09:12:06
42	11	4	Gérer le patrimoine informatique	Pour le projet GenHealth, j'ai contribué à la gestion et à la sécurisation du patrimoine informatique en participant à la mise en place d'une infrastructure réseau complète. J'ai notamment travaillé sur le déploiement d'un serveur DHCP pour l'attribution dynamique des adresses IP ainsi que sur la configuration d'un Active Directory pour centraliser la gestion des utilisateurs et des accès aux différents serveurs de l'entreprise. Cette intervention a permis de garantir un contrôle rigoureux des ressources et une organisation structurée des services au sein du réseau.	preuve-gerer-patrimoine-informatique-projet-genhealth-69ef2c522c7d5.png	0	2026-04-27 09:29:00
44	10	5	Répondre aux incidents et aux demandes d’assistance et d’évolution	Pour le projet FileSphere, j'ai assuré la maintenance corrective en utilisant GLPI pour centraliser les retours. J'ai traité les tickets d'incidents remontés par mon équipe, notamment en phase finale, afin de corriger les bugs et d'ajuster les fonctionnalités. Cette gestion proactive a permis de garantir la fiabilité avant sa mise en production.	preuve-repondre-incidents-projet-filesphere-69ef71d3a523e.png	0	2026-04-27 14:32:22
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.project (id, title, short_description, full_description, image, github_url, live_url, display_order, is_visible, created_at, updated_at, type, category, start_date, end_date) FROM stdin;
9	Projet Workshop SN1 — Machine de Rube Goldberg	Projet Workshop SN1		worshop-sn1-69223a0a61330.png			0	f	2025-11-18 12:59:15	2025-12-05 12:58:26	autre	formation	2024-09-09	2024-09-13
22	Projet Forum — Plateforme d'échanges et d'entraide mobile pour la communication entre professeurs et élèves.	Projet n°2 de l’épreuve E6 du BTS SIO	Le projet Forum Scolaire est une application mobile multiplateforme développée avec Flutter, conçue pour faciliter les échanges entre étudiants et enseignants. Cette solution permet aux utilisateurs de naviguer à travers différents forums et sous-forums thématiques pour engager des discussions. Chaque membre peut poster des nouveaux messages ou répondre aux interventions des autres utilisateurs, créant ainsi une dynamique d'entraide et de partage de connaissances au sein de l'établissement.\r\n\r\nL'architecture technique repose sur un backend Symfony utilisé comme API, qui centralise la gestion de la base de données et la logique métier. L'application mobile communique avec ce serveur pour assurer la persistance des messages et la fluidité des échanges. Ce projet m'a permis de maîtriser le développement d'une interface mobile moderne tout en concevant une API robuste capable de traiter les interactions en temps réel entre les utilisateurs.	forum-scolaire-69edf74c61316.png	https://github.com/kaelianbaudelet/projet-epreuve-E6-bts-sio-2		0	t	2026-04-26 11:30:26	2026-04-27 08:54:37	app-mobile	formation	2026-03-02	2026-05-01
12	Projet Hotel Neptune — Concevoir et exploiter une base de données dans un environnement web	Projet TPRW207	Le projet Hôtel Neptune est une réalisation transversale centrée sur la conception et l'exploitation d'une base de données dans un environnement web. L'objectif principal était d'informatiser le système de réservation de cet établissement afin d'offrir une interface de gestion moderne et efficace, permettant aux clients de réserver des chambres en ligne et au gérant de piloter son activité.\r\n\r\nTechniquement, j'ai travaillé sur la modélisation complète de la base de données MySQL, en structurant les relations entre les clients, les chambres, les réservations et les factures. Le développement du site a été réalisé en PHP, en utilisant les fondamentaux du HTML5 et du CSS3 pour l'interface. J'ai notamment mis en place des fonctionnalités dynamiques permettant de vérifier la disponibilité des chambres et de générer automatiquement des factures à la fin du séjour.\r\n\r\nCe projet m'a permis de consolider mes compétences en développement web "full-stack" en assurant la liaison entre le front-end et le back-end. En plus de l'aspect technique, cette réalisation m'a confronté aux problématiques de l'expérience utilisateur et de l'administration de données réelles, garantissant ainsi une solution logicielle cohérente et adaptée aux besoins spécifiques d'un établissement hôtelier.	neptune-692243ddcbcc0.png			0	t	2025-11-18 13:01:26	2026-04-27 09:19:40	app-web		\N	\N
18	Projet DepotScolaire — Plateforme de gestion de dépôt/rendu de devoirs pour professeurs et élèves.	Projet n°1 de l’épreuve E6 du BTS SIO	Le projet DépôtScolaire constitue la première situation de mon épreuve E6 du BTS SIO. Il s'agit d'une plateforme de gestion pédagogique développée avec le framework Symfony, conçue pour simplifier les échanges entre enseignants et étudiants en permettant aux professeurs de créer des espaces de dépôt et aux élèves de soumettre leurs livrables directement en ligne.\r\n\r\nL'architecture de l'application repose sur le moteur de template Twig et une logique backend robuste permettant de gérer le stockage des fichiers et le suivi des rendus. J'ai mis en place un système d'authentification sécurisé qui structure les accès, offrant une interface dédiée à chaque profil pour garantir une organisation fluide des documents et une visibilité claire sur les échéances à respecter.\r\n\r\nCe projet m'a permis d'approfondir ma maîtrise de l'écosystème PHP en répondant à une problématique concrète de dématérialisation. En développant cette plateforme, j'ai pu travailler sur des fonctionnalités essentielles comme l'upload sécurisé de fichiers, la gestion de base de données relationnelle et l'optimisation de l'expérience utilisateur pour un usage quotidien en milieu scolaire.	Backup-old-diapo-portfolio-69cf2cc8c8cdd.png			0	t	2025-11-18 13:05:47	2026-04-27 08:57:36	app-web	formation	2025-10-08	2025-12-12
17	Projet AP2 (Sécurisation d’un site web) — Introduction à la sécurité informatique et aux attaques de mots de passe	Projet AP2	Le projet AP2, réalisé en groupe, portait sur la sécurisation d'un site web développé avec le framework Symfony. L'objectif principal était de nous introduire aux enjeux de la sécurité informatique en milieu professionnel en implémentant des mécanismes de protection concrets contre les vulnérabilités courantes.\r\n\r\nDans le cadre de cette situation, j'ai travaillé sur la mise en place d'une sécurité renforcée lors de l'authentification. Nous avons notamment développé une protection contre les attaques de type brute-force pour limiter les tentatives de connexion malveillantes, ainsi qu'un système de validation de mots de passe interdisant l'utilisation de combinaisons déjà utilisées ou trop simplistes.\r\n\r\nCe projet a été déterminant pour le développement de mes compétences techniques sur Symfony en vue de l'épreuve pratique. Il m'a permis de comprendre comment intégrer la sécurité native du framework tout en développant des fonctionnalités personnalisées pour garantir l'intégrité des données et la protection des comptes utilisateurs.	cyb-ap2-69224bab45de3.png			0	t	2025-11-18 13:05:16	2026-04-27 08:58:43			\N	\N
13	Projet Bassin d'Arcachon — Conception et déploiement d’une stratégie de communication digitale à partir d’un cahier des charges client	Projet TPRW210		bassin-arcachon-692241bbbefbd.png			0	t	2025-11-18 13:02:06	2026-04-27 08:52:03	autre		\N	\N
20	Projet Kworks [Stage SN1] — Plateforme de gestion des activités opérationnelles pour les entreprises de services	Projet réalisé au cours de mon stage de première année.	Le projet Kworks, réalisé au cours de mon stage de première année chez KIHODEV, est une solution SaaS de gestion opérationnelle conçue pour les sociétés de services. Cette plateforme intégrée vise à centraliser des processus complexes tels que la planification d'interventions techniques, le suivi d'incidents via un système de ticketing, la gestion des ressources humaines et la facturation, afin d'optimiser l'efficacité globale des entreprises partenaires.\r\n\r\nDans le cadre de ce projet d'envergure destiné à une commercialisation en 2026, j'ai évolué dans un environnement technique de pointe en intervenant sur l'ensemble de la stack logicielle. J'ai notamment participé au développement du backend via un serveur API Spring Boot, contribué à l'implémentation de l'interface web sous Angular, et pris part à la création de l'application mobile avec Flutter.\r\n\r\nCette expérience en immersion au sein du groupe KIHO m'a permis de confronter mes compétences aux exigences d'un produit professionnel complexe. En travaillant sur ces trois supports (Web, Mobile, API), j'ai pu appréhender les enjeux de la centralisation des données et de la communication fluide entre les différents composants d'une architecture logicielle moderne.	stage-sn1-69224db7680bb.png			0	t	2025-11-20 14:30:36	2026-04-27 08:56:25	autre	professionnel	\N	\N
19	Portfolio BTS SIO — Création d'un support numérique pour l'epreuve E5 du BTS SIO	Portfolio BTS SIO	Tout au long de mes deux années de formation à l'EPSI, j'ai conçu et développé mon propre portfolio numérique pour servir de support principal à l'épreuve E5. Ce projet a été pensé dès le début de mon cursus comme une plateforme dynamique capable de centraliser et de mettre en valeur l'intégralité de mon parcours professionnel et académique. En développant moi-même cet outil, j'ai pu créer un environnement sur mesure qui me permet de vous présenter aujourd'hui, de manière fluide et structurée, les différentes étapes de ma professionnalisation lors de cet oral.\r\n\r\nLa structure de ce portfolio a été rigoureusement alignée sur les exigences du référentiel du BTS SIO. J'ai ainsi développé des modules spécifiques pour exposer mes compétences acquises, mes expériences en stage, ainsi que l'ensemble de mes certifications obtenues. Chaque projet réalisé en formation, comme le "Projet Forum" ou le "Dépôt Scolaire", bénéficie d'une page dédiée détaillant les technologies utilisées et les problématiques résolues. Cette organisation exhaustive garantit que tous les éléments attendus par le jury, incluant également la veille technologique, sont accessibles et documentés avec précision.\r\n\r\nPour assurer la qualité technique et éditoriale de ce support, j'ai appliqué une méthodologie de travail professionnelle sur le long terme. Tout au long de mes deux années à l'EPSI, j'ai planifié l'évolution de mon portfolio via un tableau de bord Jira. De la veille technologique à la rédaction finale, j'ai découpé chaque section en tâches spécifiques, ce qui m'a permis de structurer mon avancement de manière logique. Cette démarche rigoureuse a facilité la gestion du développement technique, l'intégration des contenus et la mise en production finale du site pour l'examen.	portfolio-kaelian-epreuve-e5-69ee34dd876cd.png			0	t	2025-11-18 13:06:16	2026-04-27 08:56:31	autre	formation	\N	\N
14	Projet de veille technologique en Anglais — Dossier de Synthèse de Veille Technologique en Anglais	Projet de veille techno en Anglais	Le projet de Veille Technologique en Anglais a consisté en la réalisation d'un dossier de synthèse et d'une présentation orale portant sur les évolutions des pompes à insuline. Ce travail m'a permis d'explorer l'intersection entre la santé connectée et la cybersécurité, en analysant comment ces dispositifs médicaux intègrent désormais des technologies de pointe pour améliorer le quotidien des patients.\r\n\r\nDans le cadre de cette veille, j'ai dû compiler et synthétiser des ressources techniques exclusivement en anglais, me permettant d'approfondir mon vocabulaire spécialisé et ma compréhension des enjeux technologiques internationaux. L'étude s'est concentrée sur l'automatisation des doses, la connectivité smartphone et la protection des données biométriques face aux risques de piratage.\r\n\r\nCette expérience a été essentielle pour valider ma capacité à mener une recherche documentaire structurée dans une langue étrangère. En présentant mes conclusions lors d'un exposé, j'ai pu démontrer ma maîtrise du sujet technique ainsi que ma faculté à communiquer des concepts complexes de manière claire et professionnelle en anglais.	veille-techno-anglais-6922472a20c5c.png			0	t	2025-11-18 13:02:35	2026-04-27 09:01:41	autre	formation	\N	\N
16	Projet AP1 (Projet Script de sauvegarde de base de donnée) — Mise en place d’un système de sauvegarde automatisée et sécurisée d’une base de données	Projet AP1	Le projet AP1 consiste en la création d'un utilitaire en ligne de commande (CLI) développé en Bash, dédié à la sécurisation des données. Cet outil permet d'automatiser la sauvegarde complète d'une base de données MySQL et d'en assurer l'extraction vers un serveur distant, garantissant ainsi la pérennité du patrimoine applicatif.\r\n\r\nCe projet m'a permis d'approfondir mes connaissances en scripting shell et en administration système Linux. J'ai dû concevoir une solution fiable capable de gérer les processus d'exportation de données tout en structurant le code de manière propre et réutilisable, répondant ainsi aux exigences professionnelles de continuité d'activité.	cyb-ap1-69224538bef4e.png			0	t	2025-11-18 13:04:49	2026-04-30 12:18:55	infrastructure	formation	\N	\N
15	Projet Workshop SN2 Nix — Q. La nouvelle génération	Projet Workshop SN2	Le projet Workshop SN2 — Q. La nouvelle génération a consisté en la conception d'un gadget espion innovant alliant hardware, software et intelligence artificielle. L'objectif était de créer un dispositif capable de capturer des conversations audio de manière autonome et de les transmettre à une infrastructure distante pour analyse.\r\n\r\nTechniquement, le projet repose sur un script de collecte en Python qui gère la capture sonore et l'envoi des données vers un serveur web développé sous Next.js. Pour apporter une dimension intelligente à la solution, nous avons intégré le modèle Whisper, permettant de retranscrire automatiquement les fichiers audio capturés en texte clair directement sur la plateforme de réception.\r\n\r\nCette expérience en mode workshop m'a permis d'explorer l'interopérabilité entre différents langages et frameworks au sein d'une architecture complexe. En combinant l'IoT, le développement web moderne et l'intelligence artificielle, j'ai pu valider des compétences en traitement de données en temps réel et en intégration de services d'IA.	projet-workshop-sn2-692249f892eaa.png			0	t	2025-11-18 13:03:10	2026-04-27 09:19:48	autre	formation	\N	\N
11	Projet GenHealth — Installation d'une Infrastructure système & réseau pour un environnement web	Projet TPRW204	Le projet GenHealth, réalisé en première année de BTS SIO, a consisté à concevoir et mettre en œuvre l'intégralité d'une infrastructure système et réseau pour une entreprise fictive spécialisée dans les thérapies médicales. L'objectif principal était de répondre aux besoins d'extension de la société en créant un environnement informatique complet, sécurisé et supervisé.\r\n\r\nDans le cadre de cette réalisation, j'ai participé à la mise en place d'une architecture segmentée en cinq zones distinctes (Laboratoire, Employés, Invités, Serveurs et DMZ) pour garantir un cloisonnement strict des flux via des VLANs et des listes de contrôle d'accès (ACL). Sur le plan des services réseaux, nous avons déployé un serveur DNS pour la résolution de noms interne et un serveur DHCP centralisé pour l'attribution dynamique des adresses IP sur l'ensemble des sous-réseaux.\r\n\r\nL'infrastructure intègre également une gestion centralisée des utilisateurs via Active Directory, ainsi qu'un serveur de base de données MariaDB et un hébergement web interne sous Apache. Pour assurer la continuité de service, nous avons mis en place un système de supervision avec PRTG Network Monitor, permettant un suivi en temps réel de l'état des équipements et des serveurs. Ce projet m'a permis de manipuler des équipements physiques réels (Switch Cisco, routeur Ubiquiti) tout en validant des compétences en administration système sous Windows Server.	projet-archi-res-69223cc1b7a21.png			0	t	2025-11-18 13:00:45	2026-04-27 09:29:01			\N	\N
10	Projet FileSphere — Développement d'une solution web de livrables	Projet TPRE101	Le projet FileSphere consiste en la conception et la réalisation d'une plateforme web de gestion de livrables, développée pour répondre à un besoin de centralisation des dépôts de fichiers. Cette solution permet aux utilisateurs de soumettre leurs travaux au sein de dossiers structurés, tout en offrant aux administrateurs des outils complets de gestion pour superviser les rendus et les échéances.\r\n\r\nSur le plan technique, j'ai travaillé sur le développement des fonctionnalités CRUD (Create, Read, Update, Delete) dédiées à l'administration. J'ai notamment mis en place le système de création de dossiers par section, la gestion des dates limites de rendu et une interface responsive adaptée à tous les types d'écrans. Le projet intègre également une dimension sécuritaire importante, avec des messages de confirmation pour la suppression de données et un système d'authentification pour protéger l'accès aux ressources.\r\n\r\nCette réalisation, menée en équipe, m'a permis de consolider mes compétences en développement full-stack et en gestion de projet collaborative. En assurant la cohérence entre le design de l'interface, la structure de la base de données et la logique métier, j'ai pu contribuer à la livraison d'une plateforme intuitive capable de gérer efficacement l'arborescence des fichiers et le suivi des soumissions en temps réel.	filesphere-69223dfd31ccb.png	https://github.com/kaelianbaudelet/filesphere	https://filesphere.kaelian.dev	0	t	2025-11-18 13:00:19	2026-04-27 14:43:54	app-web	formation	\N	\N
21	Projet Wavely [Stage SN2] — Plateforme de création et de déploiement automatisé d’applications TV pour les radios.	 Projet réalisé au cours de mon stage de deuxième année. 	Le projet Wavely, réalisé lors de mon stage de seconde année, est une plateforme SaaS innovante de type "App Builder" dédiée au secteur de l'audiovisuel. Véritable "Wix de la TV", cette solution permet aux radios de créer et de déployer de manière automatisée leurs propres applications OTT sur les plateformes de télévision connectée.\r\n\r\nMa mission a consisté à intervenir sur le développement de cet outil complexe, qui simplifie la transition numérique des radios vers le support TV. J'ai ainsi participé à la conception de fonctionnalités permettant aux clients de personnaliser leur interface et de gérer la diffusion de leurs flux en direct et de leurs contenus en replay, sans nécessiter de compétences avancées en programmation.\r\n\r\nCe projet m'a permis de travailler sur des problématiques de déploiement automatisé et de gestion multi-plateforme dans un environnement professionnel exigeant. En contribuant à cette plateforme SaaS, j'ai développé une expertise technique sur les technologies OTT tout en répondant aux besoins spécifiques de flexibilité et de scalabilité propres aux éditeurs de services radio.	compo-rpt-de-stage-69cf2c12af0be.png			0	t	2026-04-03 02:40:24	2026-04-27 14:42:40	app-web	professionnel	2026-01-05	2026-02-13
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
19	19	Screenshot-2026-04-26-at-18-36-49-Kaelian-Projets-69ee3f32da475.png	1	2026-04-26 16:37:25
20	19	Screenshot-2026-04-26-at-18-36-41-Kaelian-Veille-Technologique-69ee3f32d8085.png	2	2026-04-26 16:37:25
21	19	Screenshot-2026-04-26-at-18-36-53-Kaelian-Accueil-69ee3f32ce602.png	3	2026-04-26 16:37:25
22	19	Screenshot-2026-04-26-at-18-36-34-Kaelian-Mes-Stages-et-Alternances-69ee3f32cc423.png	4	2026-04-26 16:37:25
23	19	Screenshot-2026-04-26-at-18-36-29-Kaelian-Competences-BTS-SIO-69ee3f32d5b47.png	5	2026-04-26 16:37:25
24	19	Screenshot-2026-04-26-at-18-36-21-Kaelian-Certifications-69ee3f32dce82.png	6	2026-04-26 16:37:26
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
21	4
21	6
21	7
21	9
20	8
20	6
21	8
22	7
22	9
22	4
18	9
18	4
16	9
12	9
15	9
10	9
10	5
\.


--
-- Data for Name: project_technology; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public.project_technology (project_id, technology_id) FROM stdin;
19	6
19	18
17	18
17	6
17	5
15	3
15	19
15	4
15	15
12	16
12	5
9	21
10	18
10	5
10	8
19	8
12	18
19	5
15	16
17	17
22	6
22	23
22	5
21	22
21	25
21	24
16	20
18	5
18	6
18	8
18	18
20	10
20	12
20	11
20	24
20	14
20	13
11	26
11	27
11	28
22	13
22	14
22	4
22	30
22	29
21	16
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
48	React 19.2 : Les 2 nouveautés à ne pas manquer	Analyse purement technique sur l'arrivée du composant Activity pour le pré-rendu en arrière-plan et du hook useEffectEvent.	Coding Tech	2025-10-15	https://www.coding-tech.fr/blog/react-19-2-les-nouveautes-a-ne-pas-manquer	\N	t	0	2026-04-03 03:10:42	2026-04-03 03:10:42
49	Nouveautés d'Angular 21	Bilan exhaustif détaillant l'impact du mode "Zoneless" et l'introduction des Signal Forms pour une réactivité accrue.	Angular.fr	2025-11-20	https://angular.fr/news/angular21	\N	t	1	2026-04-03 03:10:42	2026-04-03 03:10:42
50	Vulnérabilité dans React Server Components	Bulletin de sécurité CERT-FR décryptant une faille critique de type exécution de code à distance (RCE) touchant les RSC.	CERT-FR	2026-01-10	https://www.cert.ssi.gouv.fr/alerte/CERTFR-2025-ALE-014/	\N	t	2	2026-04-03 03:10:42	2026-04-03 03:10:42
51	L'avenir de React.js : Tendances et évolutions pour 2026	Étude analysant l'impact du compilateur React (Forget) et de Next.js sur les performances et l'expérience développeur.	Polara Studio	2026-01-05	https://www.polarastudio.fr/blog/lavenir-de-react-js-tendances-et-evolutions-pour-2026	\N	t	3	2026-04-03 03:10:42	2026-04-03 03:10:42
52	L'avenir de React : Tendances et évolutions en 2026	Analyse de la roadmap officielle, du support TypeScript natif et de la stratégie de Meta pour l'écosystème React.	Dyma	2026-01-20	https://dyma.fr/blog/quel-futur-pour-react/	\N	t	4	2026-04-03 03:10:42	2026-04-03 03:10:42
53	Les meilleurs boilerplates Svelte pour votre SaaS en 2025	Tour d'horizon de l'écosystème Svelte 5 et de sa compilation sans Virtual DOM pour des architectures web ultra-légères.	SaaS Boilerplate	2025-09-30	https://saasboilerplate.fr/frameworks/svelte	\N	t	5	2026-04-03 03:10:42	2026-04-03 03:10:42
54	Framework JavaScript 2025 : guide d'évolution	Rétrospective sur les paradigmes (SolidJS, Svelte) qui s'affranchissent du Virtual DOM pour plus de performance.	Business to Web	2025-10-05	https://www.business-to-web.fr/framework-javascript/	\N	t	6	2026-04-03 03:10:42	2026-04-03 03:10:42
55	Exploitation d'une vulnérabilité critique dans les RSC	Décryptage technique de la faille CVE-2025-55182 touchant React et Next.js, avec recommandations de remédiation.	Palo Alto Networks	2025-12-12	https://unit42.paloaltonetworks.com/fr/cve-2025-55182-react-and-cve-2025-66478-next/	\N	t	7	2026-04-03 03:10:42	2026-04-03 03:10:42
56	Migration d'un éditeur graphique de React vers Svelte 5	Retour d'expérience sur le passage incrémental d'une application complexe vers la réactivité par "runes".	OSS Directory	2025-12-20	https://www.ossdirectory.com/fr/success-stories/details/react-to-svelte	\N	t	8	2026-04-03 03:10:42	2026-04-03 03:10:42
57	React vs Vue vs Angular 2026 : Guide complet	Bilan sur les performances, la taille des bundles et l'impact du SSR sur le choix technologique en 2026.	Bluewave	2025-12-28	https://bluewave.fr/blog/react-vs-vue-vs-angular-comparatif-complet-des-frameworks-javascript-pour-2026	\N	t	9	2026-04-03 03:10:42	2026-04-03 03:10:42
58	Les 10 Meilleurs Frameworks JavaScript en 2026	Analyse prospective soulignant la montée en puissance de SvelteKit et Qwik face aux géants traditionnels.	Industrie du Futur	2026-03-15	https://industrie-du-futur.tv/developpement-informatique/10-meilleurs-frameworks-javascript-a-utiliser-en-2022/	\N	t	10	2026-04-03 03:10:42	2026-04-03 03:10:42
59	Écrire son propre injecteur de dépendances en TypeScript	Comprendre le fonctionnement interne de l'injection de dépendances en recréant un moteur simple et typé.	Nathanaël Cherrier	2026-02-19	https://mindsers.blog/fr/post/ecrire-injecteur-dependance-javascript/	\N	t	11	2026-04-03 03:10:42	2026-04-03 03:10:42
60	Pourquoi apprendre React Native en 2025 ?	Les avantages du cross-platform avec React Native face aux solutions hybrides et natives traditionnelles.	Nathanaël Cherrier	2025-04-23	https://mindsers.blog/fr/post/pourquoi-apprendre-react-native-en-2025/	\N	t	12	2026-04-03 03:10:42	2026-04-03 03:10:42
61	Les meilleures pratiques pour un SaaS performant	Architecture, scalabilité et performance : faire les bons choix techniques dès le début du projet.	Nathanaël Cherrier	2025-05-08	https://mindsers.blog/fr/post/les-meilleures-pratiques-pour-un-saas-performant/	\N	t	13	2026-04-03 03:10:42	2026-04-03 03:10:42
62	Développeur Freelance : ma toolbox 2025	Les outils indispensables pour gagner en productivité et en sérénité en tant que freelance tech.	Nathanaël Cherrier	2025-05-21	https://mindsers.blog/fr/post/developpeur-freelance-toolbox-2025-pour-etre-plus-rapide-serein/	\N	t	14	2026-04-03 03:10:42	2026-04-03 03:10:42
63	Quelle évolution de carrière pour un développeur ?	Explorer les trajectoires possibles après quelques années d'expérience : Senior, Lead, Staff ou Manager.	Nathanaël Cherrier	2025-05-14	https://mindsers.blog/fr/post/quelle-evolution-de-carriere-pour-un-developpeur/	\N	t	15	2026-04-03 03:10:42	2026-04-03 03:10:42
64	Comprendre les rôles dans la tech : du Développeur au CTO	Décryptage des responsabilités et des attentes pour chaque niveau de séniorité dans une équipe technique.	Nathanaël Cherrier	2025-04-30	https://mindsers.blog/fr/post/comprendre-roles-tech-developpeur-au-cto/	\N	t	16	2026-04-03 03:10:42	2026-04-03 03:10:42
66	Récapitulatif technique 2025	Un bilan des évolutions majeures du web en 2025 : frameworks, outils et nouvelles APIs navigateurs.	Grafikart	2025-12-20	https://grafikart.fr/blog/recap-2025	\N	t	18	2026-04-03 03:10:42	2026-04-03 03:10:42
67	Pourquoi je n'aime pas Next.js	Une critique constructive sur la complexité croissante et les choix architecturaux de Next.js.	Grafikart	2025-06-15	https://grafikart.fr/blog/nextjs-dislike	\N	t	19	2026-04-03 03:10:42	2026-04-03 03:10:42
68	Je ne déteste plus TailwindCSS	Retour sur un changement d'avis concernant les frameworks CSS utility-first après usage intensif.	Grafikart	2025-03-10	https://grafikart.fr/blog/je-deteste-plus-tailwindcss	\N	t	20	2026-04-03 03:10:42	2026-04-03 03:10:42
69	Windsurf, le meilleur éditeur IA ?	Test approfondi du nouvel éditeur de code intégrant l'IA nativement pour booster la productivité.	Grafikart	2025-11-05	https://grafikart.fr/blog/windsurf-editor-ia	\N	t	21	2026-04-03 03:10:42	2026-04-03 03:10:42
70	L'impact de l'IA sur le métier de Freelance	Comment l'IA transforme la manière de travailler, de deviser et de livrer des projets en freelance.	Grafikart	2026-02-15	https://grafikart.fr/blog/impact-llm-freelance-ia	\N	t	22	2026-04-03 03:10:42	2026-04-03 03:10:42
75	Concevoir une barre de recherche accessible avec React	Méthodes et bonnes pratiques pour une recherche conforme au RGAA en utilisant React et MUI.	Eleven Labs	2025-11-15	https://blog.eleven-labs.com/fr/concevoir-barre-recherche-accessible-react-html/	\N	t	27	2026-04-03 03:10:42	2026-04-03 03:10:42
76	La nouvelle Anchor positioning API en CSS	Comment lier dynamiquement des éléments en pur CSS sans passer par JavaScript.	Eleven Labs	2025-08-20	https://blog.eleven-labs.com/fr/css-anchor-positioning-api/	\N	t	28	2026-04-03 03:10:42	2026-04-03 03:10:42
77	Construire un Design System robuste avec React	Les fondations essentielles pour concevoir une interface cohérente et évolutive avec React.	Eleven Labs	2025-07-12	https://blog.eleven-labs.com/fr/design-system-react/	\N	t	29	2026-04-03 03:10:42	2026-04-03 03:10:42
78	Micro frontend : solution pour la maintenabilité	Comprendre et mettre en place des architectures micro-frontends pour de grandes applications web.	Eleven Labs	2025-03-05	https://blog.eleven-labs.com/fr/micro-frontend/	\N	t	30	2026-04-03 03:10:42	2026-04-03 03:10:42
79	Atomic Design : pour des interfaces modulaires	Appliquer l'approche Atomic Design pour créer des composants réutilisables et cohérents.	Eleven Labs	2025-02-10	https://blog.eleven-labs.com/fr/atomic-design/	\N	t	31	2026-04-03 03:10:42	2026-04-03 03:10:42
80	Maîtriser les types avancés en TypeScript	Exploration des types conditionnels et des types utilitaires pour des codebases plus robustes.	Julien Pradet	2024-03-11	https://www.julienpradet.fr/tutoriels/typescript-types-avances/	\N	t	32	2026-04-03 03:10:42	2026-04-03 03:10:42
81	3 Règles d'or en TypeScript	Les bonnes pratiques indispensables pour éviter de polluer son code avec des types "any".	Julien Pradet	2024-03-04	https://www.julienpradet.fr/tutoriels/typescript-bonnes-pratiques/	\N	t	33	2026-04-03 03:10:42	2026-04-03 03:10:42
82	Comment utiliser l'API View Transitions ?	Animer les transitions entre les pages avec cette nouvelle API navigateur ultra-puissante.	Julien Pradet	2024-02-06	https://www.julienpradet.fr/tutoriels/view-transitions/	\N	t	34	2026-04-03 03:10:42	2026-04-03 03:10:42
83	Manipulation robuste des URL avec URLSearchParams	Pourquoi et comment utiliser l'objet natif URL pour une gestion propre des paramètres query.	Christophe Porteneuve	2023-04-10	https://delicious-insights.com/fr/articles-et-tutos/url-search-params/	\N	t	35	2026-04-03 03:10:42	2026-04-03 03:10:42
84	JS protip : Array.from() ou Array#fill() ?	Comparaison et cas d'usage pour l'initialisation de tableaux en JavaScript moderne.	Christophe Porteneuve	2023-03-22	https://delicious-insights.com/fr/articles-et-tutos/js-protip-array-from-fill/	\N	t	36	2026-04-03 03:10:42	2026-04-03 03:10:42
85	Faire une pause avec setTimeout() en mode await	Encapsuler les timers classiques dans des promesses pour un code plus lisible et séquentiel.	Christophe Porteneuve	2023-02-08	https://delicious-insights.com/fr/articles-et-tutos/js-protip-timers-promises/	\N	t	37	2026-04-03 03:10:42	2026-04-03 03:10:42
86	Apprendre React : Le guide complet pour débuter	Un parcours pédagogique pour comprendre les bases de React et construire sa première application.	Alex Soyes	2024-05-15	https://alexsoyes.com/apprendre-react/	\N	t	38	2026-04-03 03:10:42	2026-04-03 03:10:42
87	Pourquoi j'utilise TypeScript dans tous mes projets	Retour d'expérience sur le gain de productivité et la réduction de bugs grâce au typage statique.	Nathanaël Cherrier	2024-11-20	https://mindsers.blog/fr/post/pourquoi-j-utilise-typescript/	\N	t	39	2026-04-03 03:10:42	2026-04-03 03:10:42
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
22	NestJS	nestjs	nestjs.svg	0
23	API Platform	api-platform	api-platform.svg	0
24	Typescript	ts	ts.svg	0
25	ViteJS	vitejs	vitejs.svg	0
26	Windows Server	windows-server	windows-server.svg	0
27	Cisco Packet Tracer	cisco-packet-tracer	cisco-packet-tracer.svg	0
28	Switch Cisco	cisco	cisco.svg	0
29	Expo	expo	expo.svg	0
30	React Native	react-native	react.svg	0
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: portfolio
--

COPY public."user" (id, email, roles, password, username) FROM stdin;
1	aconique@gmail.com	["ROLE_ADMIN"]	$2y$13$VIhOWRTIbOKCgCslD1B3tOBFR6DCqFn1VAuWOdW72dj8HG9fybKdC	afi
2	admin@kaelian.dev	["ROLE_ADMIN"]	$2y$13$CwJsBb7uxKGlbreaBFM2jOUQfUAKuRGKu1Sk0/2i5ttJNrItSUFQi	admin
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

SELECT pg_catalog.setval('public.internship_id_seq', 5, true);


--
-- Name: preuve_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.preuve_id_seq', 44, true);


--
-- Name: project_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.project_file_id_seq', 54, true);


--
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.project_id_seq', 22, true);


--
-- Name: project_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.project_image_id_seq', 24, true);


--
-- Name: skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.skill_id_seq', 9, true);


--
-- Name: tech_watch_article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.tech_watch_article_id_seq', 87, true);


--
-- Name: technology_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.technology_id_seq', 30, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: portfolio
--

SELECT pg_catalog.setval('public.user_id_seq', 3, true);


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
-- Name: preuve preuve_pkey; Type: CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.preuve
    ADD CONSTRAINT preuve_pkey PRIMARY KEY (id);


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
-- Name: idx_preuve_project; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_preuve_project ON public.preuve USING btree (project_id);


--
-- Name: idx_preuve_skill; Type: INDEX; Schema: public; Owner: portfolio
--

CREATE INDEX idx_preuve_skill ON public.preuve USING btree (skill_id);


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
-- Name: preuve fk_preuve_project; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.preuve
    ADD CONSTRAINT fk_preuve_project FOREIGN KEY (project_id) REFERENCES public.project(id) ON DELETE CASCADE;


--
-- Name: preuve fk_preuve_skill; Type: FK CONSTRAINT; Schema: public; Owner: portfolio
--

ALTER TABLE ONLY public.preuve
    ADD CONSTRAINT fk_preuve_skill FOREIGN KEY (skill_id) REFERENCES public.skill(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict t1FigHBc2d8Jj8GLz0yqjQh6SQ4BDp0DwFyUh9j9wyJyEsgljY7fGXJwc2I6arG


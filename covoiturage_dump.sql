--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 13.8 (Debian 13.8-0+deb11u1)

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

--
-- Name: etape; Type: TABLE; Schema: public; Owner: terry.you2
--

CREATE TABLE public.etape (
    ide integer NOT NULL,
    heure_p timestamp without time zone,
    heure_a timestamp without time zone,
    lieu integer,
    email character varying(25),
    traj integer
);


ALTER TABLE public.etape OWNER TO "terry.you2";

--
-- Name: etape_ide_seq; Type: SEQUENCE; Schema: public; Owner: terry.you2
--

CREATE SEQUENCE public.etape_ide_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.etape_ide_seq OWNER TO "terry.you2";

--
-- Name: etape_ide_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terry.you2
--

ALTER SEQUENCE public.etape_ide_seq OWNED BY public.etape.ide;


--
-- Name: indique; Type: TABLE; Schema: public; Owner: terry.you2
--

CREATE TABLE public.indique (
    comment character varying(100),
    email character varying(25) NOT NULL,
    ide integer NOT NULL,
    lieu integer NOT NULL
);


ALTER TABLE public.indique OWNER TO "terry.you2";

--
-- Name: localisation; Type: TABLE; Schema: public; Owner: terry.you2
--

CREATE TABLE public.localisation (
    idl integer NOT NULL,
    nom character varying(50) NOT NULL,
    adresse character varying(50) NOT NULL,
    description character varying(100)
);


ALTER TABLE public.localisation OWNER TO "terry.you2";

--
-- Name: localisation_idl_seq; Type: SEQUENCE; Schema: public; Owner: terry.you2
--

CREATE SEQUENCE public.localisation_idl_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.localisation_idl_seq OWNER TO "terry.you2";

--
-- Name: localisation_idl_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terry.you2
--

ALTER SEQUENCE public.localisation_idl_seq OWNED BY public.localisation.idl;


--
-- Name: parraine; Type: TABLE; Schema: public; Owner: terry.you2
--

CREATE TABLE public.parraine (
    userpar character varying(25) NOT NULL,
    userenf character varying(25) NOT NULL
);


ALTER TABLE public.parraine OWNER TO "terry.you2";

--
-- Name: sponsor; Type: TABLE; Schema: public; Owner: terry.you2
--

CREATE TABLE public.sponsor (
    idspon integer NOT NULL,
    nature character varying(50) NOT NULL
);


ALTER TABLE public.sponsor OWNER TO "terry.you2";

--
-- Name: sponsor_idspon_seq; Type: SEQUENCE; Schema: public; Owner: terry.you2
--

CREATE SEQUENCE public.sponsor_idspon_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sponsor_idspon_seq OWNER TO "terry.you2";

--
-- Name: sponsor_idspon_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terry.you2
--

ALTER SEQUENCE public.sponsor_idspon_seq OWNED BY public.sponsor.idspon;


--
-- Name: sponsorise; Type: TABLE; Schema: public; Owner: terry.you2
--

CREATE TABLE public.sponsorise (
    idspon integer NOT NULL,
    immat character(8) NOT NULL,
    dureemini timestamp without time zone NOT NULL,
    dureecont date NOT NULL,
    remuneration integer,
    totdistance integer
);


ALTER TABLE public.sponsorise OWNER TO "terry.you2";

--
-- Name: trajet; Type: TABLE; Schema: public; Owner: terry.you2
--

CREATE TABLE public.trajet (
    idt integer NOT NULL,
    date_t date NOT NULL,
    cout integer,
    distance integer,
    immat character(8),
    lieu integer,
    email character varying(25)
);


ALTER TABLE public.trajet OWNER TO "terry.you2";

--
-- Name: trajet_idt_seq; Type: SEQUENCE; Schema: public; Owner: terry.you2
--

CREATE SEQUENCE public.trajet_idt_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trajet_idt_seq OWNER TO "terry.you2";

--
-- Name: trajet_idt_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: terry.you2
--

ALTER SEQUENCE public.trajet_idt_seq OWNED BY public.trajet.idt;


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: terry.you2
--

CREATE TABLE public.utilisateur (
    email character varying(25) NOT NULL,
    nom character varying(25),
    prenom character varying(25),
    adresse character varying(50),
    date_nai date,
    mdp character varying(50) NOT NULL,
    permis boolean DEFAULT false
);


ALTER TABLE public.utilisateur OWNER TO "terry.you2";

--
-- Name: vehicule; Type: TABLE; Schema: public; Owner: terry.you2
--

CREATE TABLE public.vehicule (
    immat character(8) NOT NULL,
    modele character varying(25) NOT NULL,
    places integer NOT NULL,
    couleur character varying(15) NOT NULL,
    carburant character varying(10) NOT NULL,
    classe character(1) NOT NULL,
    email character varying(25)
);


ALTER TABLE public.vehicule OWNER TO "terry.you2";

--
-- Name: etape ide; Type: DEFAULT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.etape ALTER COLUMN ide SET DEFAULT nextval('public.etape_ide_seq'::regclass);


--
-- Name: localisation idl; Type: DEFAULT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.localisation ALTER COLUMN idl SET DEFAULT nextval('public.localisation_idl_seq'::regclass);


--
-- Name: sponsor idspon; Type: DEFAULT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.sponsor ALTER COLUMN idspon SET DEFAULT nextval('public.sponsor_idspon_seq'::regclass);


--
-- Name: trajet idt; Type: DEFAULT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.trajet ALTER COLUMN idt SET DEFAULT nextval('public.trajet_idt_seq'::regclass);


--
-- Data for Name: etape; Type: TABLE DATA; Schema: public; Owner: terry.you2
--

COPY public.etape (ide, heure_p, heure_a, lieu, email, traj) FROM stdin;
4	2022-04-27 11:08:33	2022-04-23 10:17:21	7	shepard@mail.com	1
5	2022-05-13 06:45:04	2022-10-14 21:30:17	7	boone@mail.com	2
6	2022-09-15 20:21:29	2022-08-25 02:06:08	4	boone@mail.com	2
7	2022-06-02 21:04:14	2022-06-05 12:49:11	4	shepard@mail.com	2
8	2022-01-13 16:33:46	2022-02-05 13:25:25	6	shepard@mail.com	2
9	2022-01-05 19:20:50	2022-06-02 19:29:16	4	carlson@mail.com	3
10	2022-02-27 23:16:40	2022-08-03 20:49:45	5	carlson@mail.com	3
11	2022-09-04 11:02:52	2022-07-09 12:06:16	10	neal@mail.com	4
12	2022-04-29 22:11:46	2022-10-07 03:07:28	6	neal@mail.com	4
13	2022-07-20 14:19:50	2022-01-15 01:34:19	5	neal@mail.com	4
14	2022-05-15 14:32:45	2022-06-14 10:15:58	2	neal@mail.com	4
15	2022-09-13 12:52:52	2022-10-13 09:12:17	1	neal@mail.com	4
17	2022-10-29 15:52:07	2022-11-02 15:02:10	2	shepard@mail.com	5
18	2022-10-12 15:47:13	2022-09-10 11:04:24	8	shepard@mail.com	5
19	2022-02-16 07:29:19	2022-09-17 14:58:24	2	shepard@mail.com	5
20	2022-07-16 14:33:46	2022-04-15 06:52:53	7	roth@mail.com	6
21	2022-09-16 16:42:23	2022-02-27 06:44:48	1	roth@mail.com	6
22	2022-03-28 05:29:08	2022-09-01 17:25:28	6	roth@mail.com	6
23	2022-02-15 06:37:42	2022-06-01 11:48:41	1	roth@mail.com	6
24	2022-05-15 07:48:34	2022-12-17 08:21:16	10	roth@mail.com	6
25	2022-02-16 06:57:07	2022-06-26 04:51:43	6	neal@mail.com	7
26	2022-12-17 12:28:09	2022-08-25 04:58:44	2	neal@mail.com	7
27	2022-04-19 23:07:09	2022-10-17 06:31:55	9	neal@mail.com	7
28	2022-09-16 22:56:18	2022-11-11 06:11:01	10	neal@mail.com	7
29	2022-06-01 11:51:34	2022-02-01 14:25:31	9	neal@mail.com	7
30	2022-02-16 22:43:41	2022-09-23 16:28:38	6	branch@mail.com	8
31	2022-05-08 23:11:20	2022-01-23 01:29:46	4	branch@mail.com	8
32	2022-09-24 05:48:18	2022-03-15 12:27:25	10	branch@mail.com	9
33	2022-10-29 10:21:33	2022-02-27 08:40:22	3	branch@mail.com	9
34	2022-06-13 23:49:47	2022-07-16 14:40:01	3	branch@mail.com	9
35	2022-03-07 06:38:52	2022-03-03 16:36:56	6	branch@mail.com	9
36	2022-12-29 09:50:44	2022-04-04 23:15:43	4	branch@mail.com	9
\.


--
-- Data for Name: indique; Type: TABLE DATA; Schema: public; Owner: terry.you2
--

COPY public.indique (comment, email, ide, lieu) FROM stdin;
rue est en travaux	branch@mail.com	32	1
rue est en travaux	branch@mail.com	33	1
rue est en travaux	branch@mail.com	34	1
rue est en travaux	branch@mail.com	35	1
\.


--
-- Data for Name: localisation; Type: TABLE DATA; Schema: public; Owner: terry.you2
--

COPY public.localisation (idl, nom, adresse, description) FROM stdin;
1	localisation deJuliet Harrell	30 rue Christine	à droite la maison, rue sens unique
2	localisation deNevaeh Sexton	52 rue Christine	à gauche le jardin, rue sens unique
3	localisation deLilian Huber	95 rue Aristide Briand	à droite le jardin, rue en travaux
4	localisation deKristen Hood	12 rue Bruges	avant la station, rue en travaux
5	localisation deShamar Bishop	53 rue Coteau des Vignes	à droite le jardin, rue est bon
6	localisation deJerome Whitaker	16 rue Cornélis	avant la jonction, rue en travaux
7	localisation dePranav Mays	9 rue Alexandre	derrière le pub, rue sens unique
8	localisation deAdelyn Mcdowell	81 rue Commandant Raynal	à droite la jonction, rue en travaux
9	localisation deShawn Boone	70 rue Charles Cathala	derrière la station, rue est bon
10	localisation deAthena Barry	39 rue André Malraux	avant le pub, rue en travaux
\.


--
-- Data for Name: parraine; Type: TABLE DATA; Schema: public; Owner: terry.you2
--

COPY public.parraine (userpar, userenf) FROM stdin;
carlson@mail.com	roth@mail.com
shepard@mail.com	snyder@mail.com
branch@mail.com	shepard@mail.com
branch@mail.com	fowler@mail.com
branch@mail.com	neal@mail.com
shepard@mail.com	larson@mail.com
carlson@mail.com	boone@mail.com
larson@mail.com	morgan@mail.com
neal@mail.com	branch@mail.com
larson@mail.com	carlson@mail.com
\.


--
-- Data for Name: sponsor; Type: TABLE DATA; Schema: public; Owner: terry.you2
--

COPY public.sponsor (idspon, nature) FROM stdin;
1	AirBnb - Chez vous, ailleurs.
2	AirBnb - Chez vous, ailleurs.
3	AirBnb - Chez vous, ailleurs.
4	Afflelou - Dommage qu’il ne soit qu’opticien
5	A nous Paris Magazine - Un autre style de ville.
6	Afflelou - Dommage qu’il ne soit qu’opticien
7	A nous Paris Magazine - Un autre style de ville.
8	AccordHotel - Feel welcome.
9	A nous Paris Magazine - Un autre style de ville.
10	Afflelou - Dommage qu’il ne soit qu’opticien
\.


--
-- Data for Name: sponsorise; Type: TABLE DATA; Schema: public; Owner: terry.you2
--

COPY public.sponsorise (idspon, immat, dureemini, dureecont, remuneration, totdistance) FROM stdin;
1	KK1WPIO0	2022-01-22 10:55:01	2022-05-07	501	10
2	KNAZW4D7	2022-01-10 10:55:01	2022-01-12	781	628
3	0F365C3Z	2022-03-29 10:55:01	2022-08-05	861	446
4	G70X9Q0G	2022-04-01 10:55:01	2022-05-22	916	298
5	RQKHCKOH	2022-04-30 10:55:01	2022-07-22	780	199
6	TADJCL0X	2022-05-23 10:55:01	2022-11-26	280	186
7	YICBO0KE	2022-07-28 10:55:01	2022-09-05	541	33
8	1ZJ5ULCE	2022-08-29 10:55:01	2022-09-14	440	596
9	TPF6GNNK	2022-08-30 10:55:01	2022-09-01	359	113
10	J1FSSAZL	2022-09-22 10:55:01	2022-10-19	293	407
\.


--
-- Data for Name: trajet; Type: TABLE DATA; Schema: public; Owner: terry.you2
--

COPY public.trajet (idt, date_t, cout, distance, immat, lieu, email) FROM stdin;
1	2022-04-27	902	72	KK1WPIO0	1	snyder@mail.com
2	2022-05-21	92	57	G70X9Q0G	2	shepard@mail.com
3	2022-08-26	866	23	0F365C3Z	3	carlson@mail.com
4	2022-10-19	83	77	YICBO0KE	4	branch@mail.com
5	2022-11-12	762	52	TADJCL0X	5	snyder@mail.com
6	2022-11-14	512	96	J1FSSAZL	6	shepard@mail.com
7	2022-12-14	381	13	RQKHCKOH	7	snyder@mail.com
8	2022-12-20	674	68	1ZJ5ULCE	8	roth@mail.com
9	2022-12-29	926	75	KNAZW4D7	9	larson@mail.com
10	2022-12-30	670	13	TPF6GNNK	10	carlson@mail.com
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: terry.you2
--

COPY public.utilisateur (email, nom, prenom, adresse, date_nai, mdp, permis) FROM stdin;
boone@mail.com	Boone	Shawn	48 rue André Malraux	1971-11-11	W7ZGP27VMO	f
fowler@mail.com	Fowler	Evelin	25 rue Bel-Air	1989-11-04	8U3YS4VWVB	f
neal@mail.com	Neal	Madison	90 rue Blondeau	1994-07-28	Y1WVOE4BWN	f
morgan@mail.com	Morgan	Donavan	15 rue Cornélis	1970-09-10	LQRD8SLH5L	f
snyder@mail.com	Snyder	Ella	17 rue Boureau-Guérinière	1999-01-09	ANU50T5K60	t
carlson@mail.com	Carlson	Bryant	89 rue Antoine de Saint-Exupéry	1973-05-06	7VKCRFPBIB	t
roth@mail.com	Roth	Sloane	20 rue Christine	1991-06-07	1MNX4M2BRI	t
larson@mail.com	Larson	Autumn	91 rue Boureau-Guérinière	1983-02-08	TMKNW66HQ1	t
shepard@mail.com	Shepard	Bridger	84 rue Bruges	1978-01-05	KTEFEBADEV	t
branch@mail.com	Branch	Felicity	11 rue Charlotte	1981-10-23	O0BHVZDTHH	t
\.


--
-- Data for Name: vehicule; Type: TABLE DATA; Schema: public; Owner: terry.you2
--

COPY public.vehicule (immat, modele, places, couleur, carburant, classe, email) FROM stdin;
KK1WPIO0	Volkswagen	6	bleu	essence	B	snyder@mail.com
0F365C3Z	Ford	7	violet	biodiesel	D	carlson@mail.com
1ZJ5ULCE	Audi	5	vert	biodiesel	C	roth@mail.com
TPF6GNNK	Rolls-Royce	4	rouge	gazole	E	carlson@mail.com
KNAZW4D7	Nissan	5	orange	biodiesel	B	larson@mail.com
J1FSSAZL	Tesla	4	rouge	essence	D	shepard@mail.com
RQKHCKOH	Ford	5	vert	gazole	C	snyder@mail.com
G70X9Q0G	Rolls-Royce	6	vert	gazole	B	shepard@mail.com
TADJCL0X	Volkswagen	8	rose	essence	C	snyder@mail.com
YICBO0KE	Mercedes	6	rose	essence	B	branch@mail.com
\.


--
-- Name: etape_ide_seq; Type: SEQUENCE SET; Schema: public; Owner: terry.you2
--

SELECT pg_catalog.setval('public.etape_ide_seq', 1, false);


--
-- Name: localisation_idl_seq; Type: SEQUENCE SET; Schema: public; Owner: terry.you2
--

SELECT pg_catalog.setval('public.localisation_idl_seq', 1, false);


--
-- Name: sponsor_idspon_seq; Type: SEQUENCE SET; Schema: public; Owner: terry.you2
--

SELECT pg_catalog.setval('public.sponsor_idspon_seq', 1, false);


--
-- Name: trajet_idt_seq; Type: SEQUENCE SET; Schema: public; Owner: terry.you2
--

SELECT pg_catalog.setval('public.trajet_idt_seq', 1, false);


--
-- Name: etape etape_pkey; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.etape
    ADD CONSTRAINT etape_pkey PRIMARY KEY (ide);


--
-- Name: indique indique_pkey; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.indique
    ADD CONSTRAINT indique_pkey PRIMARY KEY (email, ide, lieu);


--
-- Name: localisation localisation_pkey; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.localisation
    ADD CONSTRAINT localisation_pkey PRIMARY KEY (idl);


--
-- Name: parraine parraine_pkey; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.parraine
    ADD CONSTRAINT parraine_pkey PRIMARY KEY (userpar, userenf);


--
-- Name: parraine parraine_userenf_key; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.parraine
    ADD CONSTRAINT parraine_userenf_key UNIQUE (userenf);


--
-- Name: sponsor sponsor_pkey; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.sponsor
    ADD CONSTRAINT sponsor_pkey PRIMARY KEY (idspon);


--
-- Name: sponsorise sponsorise_pkey; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.sponsorise
    ADD CONSTRAINT sponsorise_pkey PRIMARY KEY (idspon, immat);


--
-- Name: trajet trajet_pkey; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.trajet
    ADD CONSTRAINT trajet_pkey PRIMARY KEY (idt);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (email);


--
-- Name: vehicule vehicule_pkey; Type: CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT vehicule_pkey PRIMARY KEY (immat);


--
-- Name: etape etape_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.etape
    ADD CONSTRAINT etape_email_fkey FOREIGN KEY (email) REFERENCES public.utilisateur(email);


--
-- Name: etape etape_lieu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.etape
    ADD CONSTRAINT etape_lieu_fkey FOREIGN KEY (lieu) REFERENCES public.localisation(idl);


--
-- Name: etape etape_traj_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.etape
    ADD CONSTRAINT etape_traj_fkey FOREIGN KEY (traj) REFERENCES public.trajet(idt);


--
-- Name: indique indique_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.indique
    ADD CONSTRAINT indique_email_fkey FOREIGN KEY (email) REFERENCES public.utilisateur(email);


--
-- Name: indique indique_ide_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.indique
    ADD CONSTRAINT indique_ide_fkey FOREIGN KEY (ide) REFERENCES public.etape(ide);


--
-- Name: indique indique_lieu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.indique
    ADD CONSTRAINT indique_lieu_fkey FOREIGN KEY (lieu) REFERENCES public.localisation(idl);


--
-- Name: parraine parraine_userenf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.parraine
    ADD CONSTRAINT parraine_userenf_fkey FOREIGN KEY (userenf) REFERENCES public.utilisateur(email);


--
-- Name: parraine parraine_userpar_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.parraine
    ADD CONSTRAINT parraine_userpar_fkey FOREIGN KEY (userpar) REFERENCES public.utilisateur(email);


--
-- Name: sponsorise sponsorise_idspon_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.sponsorise
    ADD CONSTRAINT sponsorise_idspon_fkey FOREIGN KEY (idspon) REFERENCES public.sponsor(idspon);


--
-- Name: sponsorise sponsorise_immat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.sponsorise
    ADD CONSTRAINT sponsorise_immat_fkey FOREIGN KEY (immat) REFERENCES public.vehicule(immat);


--
-- Name: trajet trajet_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.trajet
    ADD CONSTRAINT trajet_email_fkey FOREIGN KEY (email) REFERENCES public.utilisateur(email);


--
-- Name: trajet trajet_immat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.trajet
    ADD CONSTRAINT trajet_immat_fkey FOREIGN KEY (immat) REFERENCES public.vehicule(immat);


--
-- Name: trajet trajet_lieu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.trajet
    ADD CONSTRAINT trajet_lieu_fkey FOREIGN KEY (lieu) REFERENCES public.localisation(idl);


--
-- Name: vehicule vehicule_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: terry.you2
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT vehicule_email_fkey FOREIGN KEY (email) REFERENCES public.utilisateur(email);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


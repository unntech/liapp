--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-07-05 14:03:07 CST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 222 (class 1259 OID 16625)
-- Name: admin; Type: TABLE; Schema: public; Owner: t1
--

CREATE TABLE public.admin (
    id integer NOT NULL,
    username character varying(32) DEFAULT ''::character varying NOT NULL,
    nickname character varying(32) DEFAULT ''::character varying NOT NULL,
    psw character varying(64) DEFAULT ''::character varying NOT NULL,
    login_num integer DEFAULT 0 NOT NULL,
    status smallint DEFAULT '1'::smallint NOT NULL,
    authenticator character varying(32) DEFAULT ''::character varying NOT NULL,
    auth_ids character varying(200) DEFAULT ''::character varying NOT NULL,
    admin smallint DEFAULT '0'::smallint NOT NULL,
    params json,
    auth_priv character varying(200) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.admin OWNER TO t1;

--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE admin; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON TABLE public.admin IS '管理登入表';


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.username; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.username IS '用户名';


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.nickname; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.nickname IS '昵称';


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.psw; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.psw IS '密码';


--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.login_num; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.login_num IS '登入次数';


--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.status; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.status IS '0正常1禁用2锁定，-1删除';


--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.authenticator; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.authenticator IS '谷歌二次验证';


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.auth_ids; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.auth_ids IS '角色权限ID';


--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.admin; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.admin IS '标识：0标准用户，1超级管理员，2自定义';


--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.params; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.params IS '个人配置参数';


--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN admin.auth_priv; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin.auth_priv IS '私有权限ID';


--
-- TOC entry 224 (class 1259 OID 16641)
-- Name: admin_auth; Type: TABLE; Schema: public; Owner: t1
--

CREATE TABLE public.admin_auth (
    id integer NOT NULL,
    title character varying(32) NOT NULL,
    remark character varying(100) DEFAULT ''::character varying NOT NULL,
    status smallint DEFAULT '0'::smallint NOT NULL,
    rules character varying(1000) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.admin_auth OWNER TO t1;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE admin_auth; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON TABLE public.admin_auth IS '角色权限表';


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN admin_auth.title; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_auth.title IS '权限名称';


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN admin_auth.remark; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_auth.remark IS '备注说明';


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN admin_auth.status; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_auth.status IS '0禁用1启用-1删除';


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN admin_auth.rules; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_auth.rules IS '节点ID';


--
-- TOC entry 223 (class 1259 OID 16640)
-- Name: admin_auth_id_seq; Type: SEQUENCE; Schema: public; Owner: t1
--

CREATE SEQUENCE public.admin_auth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_auth_id_seq OWNER TO t1;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 223
-- Name: admin_auth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: t1
--

ALTER SEQUENCE public.admin_auth_id_seq OWNED BY public.admin_auth.id;


--
-- TOC entry 221 (class 1259 OID 16624)
-- Name: admin_id_seq; Type: SEQUENCE; Schema: public; Owner: t1
--

CREATE SEQUENCE public.admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_id_seq OWNER TO t1;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 221
-- Name: admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: t1
--

ALTER SEQUENCE public.admin_id_seq OWNED BY public.admin.id;


--
-- TOC entry 226 (class 1259 OID 16651)
-- Name: admin_log; Type: TABLE; Schema: public; Owner: t1
--

CREATE TABLE public.admin_log (
    id integer NOT NULL,
    admin_id integer DEFAULT 0 NOT NULL,
    nickname character varying(32) DEFAULT ''::character varying NOT NULL,
    url character varying(1500) DEFAULT ''::character varying NOT NULL,
    title character varying(100) DEFAULT ''::character varying NOT NULL,
    content json,
    ip character varying(40) DEFAULT ''::character varying NOT NULL,
    addtime bigint DEFAULT '0'::bigint NOT NULL
);


ALTER TABLE public.admin_log OWNER TO t1;

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE admin_log; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON TABLE public.admin_log IS '管理员日志表';


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN admin_log.admin_id; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_log.admin_id IS '管理员ID';


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN admin_log.nickname; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_log.nickname IS '管理员名称';


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN admin_log.url; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_log.url IS '操作页面';


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN admin_log.title; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_log.title IS '标题';


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN admin_log.content; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_log.content IS '内容';


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN admin_log.ip; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_log.ip IS 'IP';


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN admin_log.addtime; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_log.addtime IS '操作时间';


--
-- TOC entry 225 (class 1259 OID 16650)
-- Name: admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: t1
--

CREATE SEQUENCE public.admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_log_id_seq OWNER TO t1;

--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 225
-- Name: admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: t1
--

ALTER SEQUENCE public.admin_log_id_seq OWNED BY public.admin_log.id;


--
-- TOC entry 228 (class 1259 OID 16664)
-- Name: admin_node; Type: TABLE; Schema: public; Owner: t1
--

CREATE TABLE public.admin_node (
    id integer NOT NULL,
    pid integer DEFAULT 0 NOT NULL,
    node character varying(100) DEFAULT ''::character varying NOT NULL,
    title character varying(32) DEFAULT ''::character varying NOT NULL,
    status smallint DEFAULT '0'::smallint NOT NULL,
    is_menu smallint DEFAULT '0'::smallint NOT NULL,
    params json,
    condit character varying(200) DEFAULT ''::character varying NOT NULL,
    icon character varying(100) DEFAULT ''::character varying NOT NULL,
    sort integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.admin_node OWNER TO t1;

--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE admin_node; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON TABLE public.admin_node IS '节点表';


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN admin_node.pid; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_node.pid IS '父级ID';


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN admin_node.node; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_node.node IS '节点代码';


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN admin_node.title; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_node.title IS '节点标题';


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN admin_node.status; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_node.status IS '0禁用1正常-1删除';


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN admin_node.is_menu; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_node.is_menu IS '1为菜单0为权限节点';


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN admin_node.params; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_node.params IS '参数';


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN admin_node.condit; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_node.condit IS '规则表达式';


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN admin_node.sort; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.admin_node.sort IS '排序';


--
-- TOC entry 227 (class 1259 OID 16663)
-- Name: admin_node_id_seq; Type: SEQUENCE; Schema: public; Owner: t1
--

CREATE SEQUENCE public.admin_node_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_node_id_seq OWNER TO t1;

--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 227
-- Name: admin_node_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: t1
--

ALTER SEQUENCE public.admin_node_id_seq OWNED BY public.admin_node.id;


--
-- TOC entry 230 (class 1259 OID 16679)
-- Name: alog; Type: TABLE; Schema: public; Owner: t1
--

CREATE TABLE public.alog (
    id integer NOT NULL,
    type character varying(32) DEFAULT ''::character varying NOT NULL,
    log1 text,
    log2 text,
    log3 text
);


ALTER TABLE public.alog OWNER TO t1;

--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE alog; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON TABLE public.alog IS 'log';


--
-- TOC entry 229 (class 1259 OID 16678)
-- Name: alog_id_seq; Type: SEQUENCE; Schema: public; Owner: t1
--

CREATE SEQUENCE public.alog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alog_id_seq OWNER TO t1;

--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 229
-- Name: alog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: t1
--

ALTER SEQUENCE public.alog_id_seq OWNED BY public.alog.id;


--
-- TOC entry 232 (class 1259 OID 16687)
-- Name: api_request_log; Type: TABLE; Schema: public; Owner: t1
--

CREATE TABLE public.api_request_log (
    id integer NOT NULL,
    url character varying(250) DEFAULT ''::character varying NOT NULL,
    params character varying(1500) NOT NULL,
    postdata text NOT NULL,
    ip character varying(40) DEFAULT ''::character varying NOT NULL,
    addtime bigint DEFAULT '0'::bigint NOT NULL
);


ALTER TABLE public.api_request_log OWNER TO t1;

--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE api_request_log; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON TABLE public.api_request_log IS 'API接口请求日志';


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN api_request_log.url; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.api_request_log.url IS '请求方法';


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN api_request_log.params; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.api_request_log.params IS 'GET参数';


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN api_request_log.postdata; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.api_request_log.postdata IS '请求BODY';


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN api_request_log.ip; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.api_request_log.ip IS 'IP';


--
-- TOC entry 231 (class 1259 OID 16686)
-- Name: api_request_log_id_seq; Type: SEQUENCE; Schema: public; Owner: t1
--

CREATE SEQUENCE public.api_request_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.api_request_log_id_seq OWNER TO t1;

--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 231
-- Name: api_request_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: t1
--

ALTER SEQUENCE public.api_request_log_id_seq OWNED BY public.api_request_log.id;


--
-- TOC entry 234 (class 1259 OID 16697)
-- Name: app_secret; Type: TABLE; Schema: public; Owner: t1
--

CREATE TABLE public.app_secret (
    id integer NOT NULL,
    appid character varying(32) DEFAULT ''::character varying NOT NULL,
    appsecret character varying(100) DEFAULT ''::character varying NOT NULL,
    title character varying(16) DEFAULT ''::character varying NOT NULL,
    status smallint DEFAULT '0'::smallint NOT NULL,
    expires bigint DEFAULT '0'::bigint NOT NULL
);


ALTER TABLE public.app_secret OWNER TO t1;

--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE app_secret; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON TABLE public.app_secret IS '项目对接密钥';


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN app_secret.title; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.app_secret.title IS '名称';


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN app_secret.status; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON COLUMN public.app_secret.status IS '0禁用，1生效，2期限';


--
-- TOC entry 233 (class 1259 OID 16696)
-- Name: app_secret_id_seq; Type: SEQUENCE; Schema: public; Owner: t1
--

CREATE SEQUENCE public.app_secret_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.app_secret_id_seq OWNER TO t1;

--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 233
-- Name: app_secret_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: t1
--

ALTER SEQUENCE public.app_secret_id_seq OWNED BY public.app_secret.id;


--
-- TOC entry 236 (class 1259 OID 16707)
-- Name: icons; Type: TABLE; Schema: public; Owner: t1
--

CREATE TABLE public.icons (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.icons OWNER TO t1;

--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE icons; Type: COMMENT; Schema: public; Owner: t1
--

COMMENT ON TABLE public.icons IS 'Bootstrap Icons List';


--
-- TOC entry 235 (class 1259 OID 16706)
-- Name: icons_id_seq; Type: SEQUENCE; Schema: public; Owner: t1
--

CREATE SEQUENCE public.icons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.icons_id_seq OWNER TO t1;

--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 235
-- Name: icons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: t1
--

ALTER SEQUENCE public.icons_id_seq OWNED BY public.icons.id;


--
-- TOC entry 238 (class 1259 OID 16712)
-- Name: t1; Type: TABLE; Schema: public; Owner: t1
--

CREATE TABLE public.t1 (
    id integer NOT NULL,
    i integer DEFAULT 0 NOT NULL,
    str character varying(64) DEFAULT ''::character varying NOT NULL,
    n numeric(13,2) DEFAULT 0.00 NOT NULL
);


ALTER TABLE public.t1 OWNER TO t1;

--
-- TOC entry 237 (class 1259 OID 16711)
-- Name: t1_id_seq; Type: SEQUENCE; Schema: public; Owner: t1
--

CREATE SEQUENCE public.t1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t1_id_seq OWNER TO t1;

--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 237
-- Name: t1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: t1
--

ALTER SEQUENCE public.t1_id_seq OWNED BY public.t1.id;


--
-- TOC entry 3280 (class 2604 OID 16628)
-- Name: admin id; Type: DEFAULT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.admin ALTER COLUMN id SET DEFAULT nextval('public.admin_id_seq'::regclass);


--
-- TOC entry 3290 (class 2604 OID 16644)
-- Name: admin_auth id; Type: DEFAULT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.admin_auth ALTER COLUMN id SET DEFAULT nextval('public.admin_auth_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 16654)
-- Name: admin_log id; Type: DEFAULT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.admin_log ALTER COLUMN id SET DEFAULT nextval('public.admin_log_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16667)
-- Name: admin_node id; Type: DEFAULT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.admin_node ALTER COLUMN id SET DEFAULT nextval('public.admin_node_id_seq'::regclass);


--
-- TOC entry 3310 (class 2604 OID 16682)
-- Name: alog id; Type: DEFAULT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.alog ALTER COLUMN id SET DEFAULT nextval('public.alog_id_seq'::regclass);


--
-- TOC entry 3312 (class 2604 OID 16690)
-- Name: api_request_log id; Type: DEFAULT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.api_request_log ALTER COLUMN id SET DEFAULT nextval('public.api_request_log_id_seq'::regclass);


--
-- TOC entry 3316 (class 2604 OID 16700)
-- Name: app_secret id; Type: DEFAULT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.app_secret ALTER COLUMN id SET DEFAULT nextval('public.app_secret_id_seq'::regclass);


--
-- TOC entry 3322 (class 2604 OID 16710)
-- Name: icons id; Type: DEFAULT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.icons ALTER COLUMN id SET DEFAULT nextval('public.icons_id_seq'::regclass);


--
-- TOC entry 3323 (class 2604 OID 16715)
-- Name: t1 id; Type: DEFAULT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.t1 ALTER COLUMN id SET DEFAULT nextval('public.t1_id_seq'::regclass);


--
-- TOC entry 3498 (class 0 OID 16625)
-- Dependencies: 222
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: t1
--

COPY public.admin (id, username, nickname, psw, login_num, status, authenticator, auth_ids, admin, params, auth_priv) FROM stdin;
3	ABC	DDDD	da39a3ee5e6b4b0d3255bfef95601890afd80709	0	-1			0	\N	
1	ADMIN	Admin	8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92	126	0			1	{"navigation": "sider"}	
2	USER	User	7c4a8d09ca3762af61e59520943dc26494f8941b	24	0		2	0	{"navigation": "sider"}	1
\.


--
-- TOC entry 3500 (class 0 OID 16641)
-- Dependencies: 224
-- Data for Name: admin_auth; Type: TABLE DATA; Schema: public; Owner: t1
--

COPY public.admin_auth (id, title, remark, status, rules) FROM stdin;
2	示例	示例角色组	1	1,5,7
1	测试	测试角色组	1	1,2,3,17,4,5
\.


--
-- TOC entry 3502 (class 0 OID 16651)
-- Dependencies: 226
-- Data for Name: admin_log; Type: TABLE DATA; Schema: public; Owner: t1
--

COPY public.admin_log (id, admin_id, nickname, url, title, content, ip, addtime) FROM stdin;
\.


--
-- TOC entry 3504 (class 0 OID 16664)
-- Dependencies: 228
-- Data for Name: admin_node; Type: TABLE DATA; Schema: public; Owner: t1
--

COPY public.admin_node (id, pid, node, title, status, is_menu, params, condit, icon, sort) FROM stdin;
2	0		系统管理	1	1	\N		bi bi-gear	0
3	2	admin/menu	菜单管理	1	1	\N		bi bi-menu-button-wide	0
4	2	admin/setting	基本配置	1	1	\N		bi bi-view-list	0
5	0		权限管理	1	1	\N		bi bi-layout-wtf	0
6	5	admin/admin	管理员管理	1	1	\N		bi bi-person-gear	0
7	5	admin/adminlog	管理员日志	1	1	\N		bi bi-text-left	0
8	5	admin/node	权限节点管理	1	1	\N		bi bi-nut	0
9	5	admin/auth	角色组管理	1	1	\N		bi bi-person-lines-fill	0
10	6	admin/admin#add	添加	1	0	\N			0
11	6	admin/admin#edit	编辑	1	0	\N			0
12	9	admin/auth#add	添加	1	0	\N			0
13	9	admin/auth#edit	编辑	1	0	\N			0
14	9	admin/auth#del	删除	1	0	\N			0
15	9	admin/auth_alloc	分配权限	1	0	\N			0
16	8	admin/node	编辑	1	0	\N			0
17	3	admin/menu	编辑	1	0	\N			0
18	6	admin/admin#authentic	解绑动态码	1	0	\N			0
19	8	admin/node	添加	1	0	\N			0
20	0	admin/test	测试D	-1	0	\N			0
21	1	admin/main#report	数据报表	1	0	\N			0
22	7	admin/adminlog#export	导出	1	0	\N			0
23	0	@admin/sample/index	控制器示例	1	1	\N		bi bi-p-square-fill	0
1	0	admin/main	控制台	1	1	\N		bi bi-speedometer2	0
\.


--
-- TOC entry 3506 (class 0 OID 16679)
-- Dependencies: 230
-- Data for Name: alog; Type: TABLE DATA; Schema: public; Owner: t1
--

COPY public.alog (id, type, log1, log2, log3) FROM stdin;
\.


--
-- TOC entry 3508 (class 0 OID 16687)
-- Dependencies: 232
-- Data for Name: api_request_log; Type: TABLE DATA; Schema: public; Owner: t1
--

COPY public.api_request_log (id, url, params, postdata, ip, addtime) FROM stdin;
\.


--
-- TOC entry 3510 (class 0 OID 16697)
-- Dependencies: 234
-- Data for Name: app_secret; Type: TABLE DATA; Schema: public; Owner: t1
--

COPY public.app_secret (id, appid, appsecret, title, status, expires) FROM stdin;
1	app313276672646586985	481b9e180527e3ce790e85b43369ce64	测试项目	1	0
\.


--
-- TOC entry 3512 (class 0 OID 16707)
-- Dependencies: 236
-- Data for Name: icons; Type: TABLE DATA; Schema: public; Owner: t1
--

COPY public.icons (id, name) FROM stdin;
2	bi bi-0-circle
1	bi bi-0-circle-fill
4	bi bi-0-square
3	bi bi-0-square-fill
6	bi bi-1-circle
5	bi bi-1-circle-fill
8	bi bi-1-square
7	bi bi-1-square-fill
9	bi bi-123
11	bi bi-2-circle
10	bi bi-2-circle-fill
13	bi bi-2-square
12	bi bi-2-square-fill
15	bi bi-3-circle
14	bi bi-3-circle-fill
17	bi bi-3-square
16	bi bi-3-square-fill
19	bi bi-4-circle
18	bi bi-4-circle-fill
21	bi bi-4-square
20	bi bi-4-square-fill
23	bi bi-5-circle
22	bi bi-5-circle-fill
25	bi bi-5-square
24	bi bi-5-square-fill
27	bi bi-6-circle
26	bi bi-6-circle-fill
29	bi bi-6-square
28	bi bi-6-square-fill
31	bi bi-7-circle
30	bi bi-7-circle-fill
33	bi bi-7-square
32	bi bi-7-square-fill
35	bi bi-8-circle
34	bi bi-8-circle-fill
37	bi bi-8-square
36	bi bi-8-square-fill
39	bi bi-9-circle
38	bi bi-9-circle-fill
41	bi bi-9-square
40	bi bi-9-square-fill
42	bi bi-activity
46	bi bi-airplane
44	bi bi-airplane-engines
43	bi bi-airplane-engines-fill
45	bi bi-airplane-fill
48	bi bi-alarm
47	bi bi-alarm-fill
49	bi bi-alexa
50	bi bi-align-bottom
51	bi bi-align-center
52	bi bi-align-end
53	bi bi-align-middle
54	bi bi-align-start
55	bi bi-align-top
56	bi bi-alipay
57	bi bi-alt
58	bi bi-amd
59	bi bi-android
60	bi bi-android2
62	bi bi-app
61	bi bi-app-indicator
63	bi bi-apple
65	bi bi-archive
64	bi bi-archive-fill
66	bi bi-arrow-90deg-down
67	bi bi-arrow-90deg-left
68	bi bi-arrow-90deg-right
69	bi bi-arrow-90deg-up
70	bi bi-arrow-bar-down
71	bi bi-arrow-bar-left
72	bi bi-arrow-bar-right
73	bi bi-arrow-bar-up
74	bi bi-arrow-clockwise
75	bi bi-arrow-counterclockwise
92	bi bi-arrow-down
77	bi bi-arrow-down-circle
76	bi bi-arrow-down-circle-fill
82	bi bi-arrow-down-left
79	bi bi-arrow-down-left-circle
78	bi bi-arrow-down-left-circle-fill
81	bi bi-arrow-down-left-square
80	bi bi-arrow-down-left-square-fill
87	bi bi-arrow-down-right
84	bi bi-arrow-down-right-circle
83	bi bi-arrow-down-right-circle-fill
86	bi bi-arrow-down-right-square
85	bi bi-arrow-down-right-square-fill
88	bi bi-arrow-down-short
90	bi bi-arrow-down-square
89	bi bi-arrow-down-square-fill
91	bi bi-arrow-down-up
99	bi bi-arrow-left
94	bi bi-arrow-left-circle
93	bi bi-arrow-left-circle-fill
95	bi bi-arrow-left-right
96	bi bi-arrow-left-short
98	bi bi-arrow-left-square
97	bi bi-arrow-left-square-fill
100	bi bi-arrow-repeat
101	bi bi-arrow-return-left
102	bi bi-arrow-return-right
108	bi bi-arrow-right
104	bi bi-arrow-right-circle
103	bi bi-arrow-right-circle-fill
105	bi bi-arrow-right-short
107	bi bi-arrow-right-square
106	bi bi-arrow-right-square-fill
110	bi bi-arrow-through-heart
109	bi bi-arrow-through-heart-fill
126	bi bi-arrow-up
112	bi bi-arrow-up-circle
111	bi bi-arrow-up-circle-fill
117	bi bi-arrow-up-left
114	bi bi-arrow-up-left-circle
113	bi bi-arrow-up-left-circle-fill
116	bi bi-arrow-up-left-square
115	bi bi-arrow-up-left-square-fill
122	bi bi-arrow-up-right
119	bi bi-arrow-up-right-circle
118	bi bi-arrow-up-right-circle-fill
121	bi bi-arrow-up-right-square
120	bi bi-arrow-up-right-square-fill
123	bi bi-arrow-up-short
125	bi bi-arrow-up-square
124	bi bi-arrow-up-square-fill
127	bi bi-arrows-angle-contract
128	bi bi-arrows-angle-expand
129	bi bi-arrows-collapse
130	bi bi-arrows-expand
131	bi bi-arrows-fullscreen
132	bi bi-arrows-move
134	bi bi-aspect-ratio
133	bi bi-aspect-ratio-fill
135	bi bi-asterisk
136	bi bi-at
138	bi bi-award
137	bi bi-award-fill
139	bi bi-back
143	bi bi-backspace
140	bi bi-backspace-fill
142	bi bi-backspace-reverse
141	bi bi-backspace-reverse-fill
145	bi bi-badge-3d
144	bi bi-badge-3d-fill
147	bi bi-badge-4k
146	bi bi-badge-4k-fill
149	bi bi-badge-8k
148	bi bi-badge-8k-fill
151	bi bi-badge-ad
150	bi bi-badge-ad-fill
153	bi bi-badge-ar
152	bi bi-badge-ar-fill
155	bi bi-badge-cc
154	bi bi-badge-cc-fill
157	bi bi-badge-hd
156	bi bi-badge-hd-fill
159	bi bi-badge-sd
158	bi bi-badge-sd-fill
161	bi bi-badge-tm
160	bi bi-badge-tm-fill
163	bi bi-badge-vo
162	bi bi-badge-vo-fill
165	bi bi-badge-vr
164	bi bi-badge-vr-fill
167	bi bi-badge-wc
166	bi bi-badge-wc-fill
179	bi bi-bag
169	bi bi-bag-check
168	bi bi-bag-check-fill
171	bi bi-bag-dash
170	bi bi-bag-dash-fill
172	bi bi-bag-fill
174	bi bi-bag-heart
173	bi bi-bag-heart-fill
176	bi bi-bag-plus
175	bi bi-bag-plus-fill
178	bi bi-bag-x
177	bi bi-bag-x-fill
183	bi bi-balloon
180	bi bi-balloon-fill
182	bi bi-balloon-heart
181	bi bi-balloon-heart-fill
185	bi bi-bandaid
184	bi bi-bandaid-fill
186	bi bi-bank
187	bi bi-bank2
192	bi bi-bar-chart
188	bi bi-bar-chart-fill
190	bi bi-bar-chart-line
189	bi bi-bar-chart-line-fill
191	bi bi-bar-chart-steps
194	bi bi-basket
193	bi bi-basket-fill
196	bi bi-basket2
195	bi bi-basket2-fill
198	bi bi-basket3
197	bi bi-basket3-fill
202	bi bi-battery
199	bi bi-battery-charging
200	bi bi-battery-full
201	bi bi-battery-half
203	bi bi-behance
207	bi bi-bell
204	bi bi-bell-fill
206	bi bi-bell-slash
205	bi bi-bell-slash-fill
208	bi bi-bezier
209	bi bi-bezier2
210	bi bi-bicycle
212	bi bi-binoculars
211	bi bi-binoculars-fill
213	bi bi-blockquote-left
214	bi bi-blockquote-right
215	bi bi-bluetooth
216	bi bi-body-text
219	bi bi-book
217	bi bi-book-fill
218	bi bi-book-half
233	bi bi-bookmark
221	bi bi-bookmark-check
220	bi bi-bookmark-check-fill
223	bi bi-bookmark-dash
222	bi bi-bookmark-dash-fill
224	bi bi-bookmark-fill
226	bi bi-bookmark-heart
225	bi bi-bookmark-heart-fill
228	bi bi-bookmark-plus
227	bi bi-bookmark-plus-fill
230	bi bi-bookmark-star
229	bi bi-bookmark-star-fill
232	bi bi-bookmark-x
231	bi bi-bookmark-x-fill
235	bi bi-bookmarks
234	bi bi-bookmarks-fill
236	bi bi-bookshelf
238	bi bi-boombox
237	bi bi-boombox-fill
242	bi bi-bootstrap
239	bi bi-bootstrap-fill
240	bi bi-bootstrap-icons
241	bi bi-bootstrap-reboot
254	bi bi-border
243	bi bi-border-all
244	bi bi-border-bottom
245	bi bi-border-center
246	bi bi-border-inner
247	bi bi-border-left
248	bi bi-border-middle
249	bi bi-border-outer
250	bi bi-border-right
251	bi bi-border-style
252	bi bi-border-top
253	bi bi-border-width
256	bi bi-bounding-box
255	bi bi-bounding-box-circles
276	bi bi-box
259	bi bi-box-arrow-down
257	bi bi-box-arrow-down-left
258	bi bi-box-arrow-down-right
262	bi bi-box-arrow-in-down
260	bi bi-box-arrow-in-down-left
261	bi bi-box-arrow-in-down-right
263	bi bi-box-arrow-in-left
264	bi bi-box-arrow-in-right
267	bi bi-box-arrow-in-up
265	bi bi-box-arrow-in-up-left
266	bi bi-box-arrow-in-up-right
268	bi bi-box-arrow-left
269	bi bi-box-arrow-right
272	bi bi-box-arrow-up
270	bi bi-box-arrow-up-left
271	bi bi-box-arrow-up-right
273	bi bi-box-fill
275	bi bi-box-seam
274	bi bi-box-seam-fill
280	bi bi-box2
277	bi bi-box2-fill
279	bi bi-box2-heart
278	bi bi-box2-heart-fill
281	bi bi-boxes
283	bi bi-braces
282	bi bi-braces-asterisk
284	bi bi-bricks
286	bi bi-briefcase
285	bi bi-briefcase-fill
288	bi bi-brightness-alt-high
287	bi bi-brightness-alt-high-fill
290	bi bi-brightness-alt-low
289	bi bi-brightness-alt-low-fill
292	bi bi-brightness-high
291	bi bi-brightness-high-fill
294	bi bi-brightness-low
293	bi bi-brightness-low-fill
296	bi bi-broadcast
295	bi bi-broadcast-pin
297	bi bi-browser-chrome
298	bi bi-browser-edge
299	bi bi-browser-firefox
300	bi bi-browser-safari
302	bi bi-brush
301	bi bi-brush-fill
304	bi bi-bucket
303	bi bi-bucket-fill
306	bi bi-bug
305	bi bi-bug-fill
328	bi bi-building
307	bi bi-building-add
308	bi bi-building-check
309	bi bi-building-dash
310	bi bi-building-down
311	bi bi-building-exclamation
322	bi bi-building-fill
312	bi bi-building-fill-add
313	bi bi-building-fill-check
314	bi bi-building-fill-dash
315	bi bi-building-fill-down
316	bi bi-building-fill-exclamation
317	bi bi-building-fill-gear
318	bi bi-building-fill-lock
319	bi bi-building-fill-slash
320	bi bi-building-fill-up
321	bi bi-building-fill-x
323	bi bi-building-gear
324	bi bi-building-lock
325	bi bi-building-slash
326	bi bi-building-up
327	bi bi-building-x
330	bi bi-buildings
329	bi bi-buildings-fill
331	bi bi-bullseye
333	bi bi-bus-front
332	bi bi-bus-front-fill
335	bi bi-c-circle
334	bi bi-c-circle-fill
337	bi bi-c-square
336	bi bi-c-square-fill
339	bi bi-calculator
338	bi bi-calculator-fill
363	bi bi-calendar
341	bi bi-calendar-check
340	bi bi-calendar-check-fill
343	bi bi-calendar-date
342	bi bi-calendar-date-fill
345	bi bi-calendar-day
344	bi bi-calendar-day-fill
347	bi bi-calendar-event
346	bi bi-calendar-event-fill
348	bi bi-calendar-fill
350	bi bi-calendar-heart
349	bi bi-calendar-heart-fill
352	bi bi-calendar-minus
351	bi bi-calendar-minus-fill
354	bi bi-calendar-month
353	bi bi-calendar-month-fill
356	bi bi-calendar-plus
355	bi bi-calendar-plus-fill
358	bi bi-calendar-range
357	bi bi-calendar-range-fill
360	bi bi-calendar-week
359	bi bi-calendar-week-fill
362	bi bi-calendar-x
361	bi bi-calendar-x-fill
387	bi bi-calendar2
365	bi bi-calendar2-check
364	bi bi-calendar2-check-fill
367	bi bi-calendar2-date
366	bi bi-calendar2-date-fill
369	bi bi-calendar2-day
368	bi bi-calendar2-day-fill
371	bi bi-calendar2-event
370	bi bi-calendar2-event-fill
372	bi bi-calendar2-fill
374	bi bi-calendar2-heart
373	bi bi-calendar2-heart-fill
376	bi bi-calendar2-minus
375	bi bi-calendar2-minus-fill
378	bi bi-calendar2-month
377	bi bi-calendar2-month-fill
380	bi bi-calendar2-plus
379	bi bi-calendar2-plus-fill
382	bi bi-calendar2-range
381	bi bi-calendar2-range-fill
384	bi bi-calendar2-week
383	bi bi-calendar2-week-fill
386	bi bi-calendar2-x
385	bi bi-calendar2-x-fill
395	bi bi-calendar3
389	bi bi-calendar3-event
388	bi bi-calendar3-event-fill
390	bi bi-calendar3-fill
392	bi bi-calendar3-range
391	bi bi-calendar3-range-fill
394	bi bi-calendar3-week
393	bi bi-calendar3-week-fill
399	bi bi-calendar4
396	bi bi-calendar4-event
397	bi bi-calendar4-range
398	bi bi-calendar4-week
407	bi bi-camera
400	bi bi-camera-fill
402	bi bi-camera-reels
401	bi bi-camera-reels-fill
406	bi bi-camera-video
403	bi bi-camera-video-fill
405	bi bi-camera-video-off
404	bi bi-camera-video-off-fill
408	bi bi-camera2
410	bi bi-capslock
409	bi bi-capslock-fill
412	bi bi-capsule
411	bi bi-capsule-pill
414	bi bi-car-front
413	bi bi-car-front-fill
415	bi bi-card-checklist
416	bi bi-card-heading
417	bi bi-card-image
418	bi bi-card-list
419	bi bi-card-text
423	bi bi-caret-down
420	bi bi-caret-down-fill
422	bi bi-caret-down-square
421	bi bi-caret-down-square-fill
427	bi bi-caret-left
424	bi bi-caret-left-fill
426	bi bi-caret-left-square
425	bi bi-caret-left-square-fill
431	bi bi-caret-right
428	bi bi-caret-right-fill
430	bi bi-caret-right-square
429	bi bi-caret-right-square-fill
435	bi bi-caret-up
432	bi bi-caret-up-fill
434	bi bi-caret-up-square
433	bi bi-caret-up-square-fill
445	bi bi-cart
437	bi bi-cart-check
436	bi bi-cart-check-fill
439	bi bi-cart-dash
438	bi bi-cart-dash-fill
440	bi bi-cart-fill
442	bi bi-cart-plus
441	bi bi-cart-plus-fill
444	bi bi-cart-x
443	bi bi-cart-x-fill
446	bi bi-cart2
447	bi bi-cart3
448	bi bi-cart4
451	bi bi-cash
449	bi bi-cash-coin
450	bi bi-cash-stack
453	bi bi-cassette
452	bi bi-cassette-fill
454	bi bi-cast
456	bi bi-cc-circle
455	bi bi-cc-circle-fill
458	bi bi-cc-square
457	bi bi-cc-square-fill
498	bi bi-chat
460	bi bi-chat-dots
459	bi bi-chat-dots-fill
461	bi bi-chat-fill
463	bi bi-chat-heart
462	bi bi-chat-heart-fill
473	bi bi-chat-left
465	bi bi-chat-left-dots
464	bi bi-chat-left-dots-fill
466	bi bi-chat-left-fill
468	bi bi-chat-left-heart
467	bi bi-chat-left-heart-fill
470	bi bi-chat-left-quote
469	bi bi-chat-left-quote-fill
472	bi bi-chat-left-text
471	bi bi-chat-left-text-fill
475	bi bi-chat-quote
474	bi bi-chat-quote-fill
485	bi bi-chat-right
477	bi bi-chat-right-dots
476	bi bi-chat-right-dots-fill
478	bi bi-chat-right-fill
480	bi bi-chat-right-heart
479	bi bi-chat-right-heart-fill
482	bi bi-chat-right-quote
481	bi bi-chat-right-quote-fill
484	bi bi-chat-right-text
483	bi bi-chat-right-text-fill
495	bi bi-chat-square
487	bi bi-chat-square-dots
486	bi bi-chat-square-dots-fill
488	bi bi-chat-square-fill
490	bi bi-chat-square-heart
489	bi bi-chat-square-heart-fill
492	bi bi-chat-square-quote
491	bi bi-chat-square-quote-fill
494	bi bi-chat-square-text
493	bi bi-chat-square-text-fill
497	bi bi-chat-text
496	bi bi-chat-text-fill
505	bi bi-check
499	bi bi-check-all
501	bi bi-check-circle
500	bi bi-check-circle-fill
502	bi bi-check-lg
504	bi bi-check-square
503	bi bi-check-square-fill
509	bi bi-check2
506	bi bi-check2-all
507	bi bi-check2-circle
508	bi bi-check2-square
510	bi bi-chevron-bar-contract
511	bi bi-chevron-bar-down
512	bi bi-chevron-bar-expand
513	bi bi-chevron-bar-left
514	bi bi-chevron-bar-right
515	bi bi-chevron-bar-up
516	bi bi-chevron-compact-down
517	bi bi-chevron-compact-left
518	bi bi-chevron-compact-right
519	bi bi-chevron-compact-up
520	bi bi-chevron-contract
521	bi bi-chevron-double-down
522	bi bi-chevron-double-left
523	bi bi-chevron-double-right
524	bi bi-chevron-double-up
525	bi bi-chevron-down
526	bi bi-chevron-expand
527	bi bi-chevron-left
528	bi bi-chevron-right
529	bi bi-chevron-up
533	bi bi-circle
530	bi bi-circle-fill
531	bi bi-circle-half
532	bi bi-circle-square
548	bi bi-clipboard
535	bi bi-clipboard-check
534	bi bi-clipboard-check-fill
537	bi bi-clipboard-data
536	bi bi-clipboard-data-fill
538	bi bi-clipboard-fill
540	bi bi-clipboard-heart
539	bi bi-clipboard-heart-fill
542	bi bi-clipboard-minus
541	bi bi-clipboard-minus-fill
544	bi bi-clipboard-plus
543	bi bi-clipboard-plus-fill
545	bi bi-clipboard-pulse
547	bi bi-clipboard-x
546	bi bi-clipboard-x-fill
564	bi bi-clipboard2
550	bi bi-clipboard2-check
549	bi bi-clipboard2-check-fill
552	bi bi-clipboard2-data
551	bi bi-clipboard2-data-fill
553	bi bi-clipboard2-fill
555	bi bi-clipboard2-heart
554	bi bi-clipboard2-heart-fill
557	bi bi-clipboard2-minus
556	bi bi-clipboard2-minus-fill
559	bi bi-clipboard2-plus
558	bi bi-clipboard2-plus-fill
561	bi bi-clipboard2-pulse
560	bi bi-clipboard2-pulse-fill
563	bi bi-clipboard2-x
562	bi bi-clipboard2-x-fill
567	bi bi-clock
565	bi bi-clock-fill
566	bi bi-clock-history
613	bi bi-cloud
569	bi bi-cloud-arrow-down
568	bi bi-cloud-arrow-down-fill
571	bi bi-cloud-arrow-up
570	bi bi-cloud-arrow-up-fill
573	bi bi-cloud-check
572	bi bi-cloud-check-fill
575	bi bi-cloud-download
574	bi bi-cloud-download-fill
577	bi bi-cloud-drizzle
576	bi bi-cloud-drizzle-fill
578	bi bi-cloud-fill
580	bi bi-cloud-fog
579	bi bi-cloud-fog-fill
582	bi bi-cloud-fog2
581	bi bi-cloud-fog2-fill
584	bi bi-cloud-hail
583	bi bi-cloud-hail-fill
586	bi bi-cloud-haze
585	bi bi-cloud-haze-fill
588	bi bi-cloud-haze2
587	bi bi-cloud-haze2-fill
592	bi bi-cloud-lightning
589	bi bi-cloud-lightning-fill
591	bi bi-cloud-lightning-rain
590	bi bi-cloud-lightning-rain-fill
594	bi bi-cloud-minus
593	bi bi-cloud-minus-fill
596	bi bi-cloud-moon
595	bi bi-cloud-moon-fill
598	bi bi-cloud-plus
597	bi bi-cloud-plus-fill
602	bi bi-cloud-rain
599	bi bi-cloud-rain-fill
601	bi bi-cloud-rain-heavy
600	bi bi-cloud-rain-heavy-fill
604	bi bi-cloud-slash
603	bi bi-cloud-slash-fill
606	bi bi-cloud-sleet
605	bi bi-cloud-sleet-fill
608	bi bi-cloud-snow
607	bi bi-cloud-snow-fill
610	bi bi-cloud-sun
609	bi bi-cloud-sun-fill
612	bi bi-cloud-upload
611	bi bi-cloud-upload-fill
615	bi bi-clouds
614	bi bi-clouds-fill
617	bi bi-cloudy
616	bi bi-cloudy-fill
620	bi bi-code
618	bi bi-code-slash
619	bi bi-code-square
621	bi bi-coin
625	bi bi-collection
622	bi bi-collection-fill
624	bi bi-collection-play
623	bi bi-collection-play-fill
627	bi bi-columns
626	bi bi-columns-gap
628	bi bi-command
630	bi bi-compass
629	bi bi-compass-fill
632	bi bi-cone
631	bi bi-cone-striped
633	bi bi-controller
635	bi bi-cpu
634	bi bi-cpu-fill
641	bi bi-credit-card
637	bi bi-credit-card-2-back
636	bi bi-credit-card-2-back-fill
639	bi bi-credit-card-2-front
638	bi bi-credit-card-2-front-fill
640	bi bi-credit-card-fill
642	bi bi-crop
647	bi bi-cup
643	bi bi-cup-fill
645	bi bi-cup-hot
644	bi bi-cup-hot-fill
646	bi bi-cup-straw
648	bi bi-currency-bitcoin
649	bi bi-currency-dollar
650	bi bi-currency-euro
651	bi bi-currency-exchange
652	bi bi-currency-pound
653	bi bi-currency-rupee
654	bi bi-currency-yen
657	bi bi-cursor
655	bi bi-cursor-fill
656	bi bi-cursor-text
665	bi bi-dash
660	bi bi-dash-circle
658	bi bi-dash-circle-dotted
659	bi bi-dash-circle-fill
661	bi bi-dash-lg
664	bi bi-dash-square
662	bi bi-dash-square-dotted
663	bi bi-dash-square-fill
687	bi bi-database
666	bi bi-database-add
667	bi bi-database-check
668	bi bi-database-dash
669	bi bi-database-down
670	bi bi-database-exclamation
681	bi bi-database-fill
671	bi bi-database-fill-add
672	bi bi-database-fill-check
673	bi bi-database-fill-dash
674	bi bi-database-fill-down
675	bi bi-database-fill-exclamation
676	bi bi-database-fill-gear
677	bi bi-database-fill-lock
678	bi bi-database-fill-slash
679	bi bi-database-fill-up
680	bi bi-database-fill-x
682	bi bi-database-gear
683	bi bi-database-lock
684	bi bi-database-slash
685	bi bi-database-up
686	bi bi-database-x
689	bi bi-device-hdd
688	bi bi-device-hdd-fill
691	bi bi-device-ssd
690	bi bi-device-ssd-fill
693	bi bi-diagram-2
692	bi bi-diagram-2-fill
695	bi bi-diagram-3
694	bi bi-diagram-3-fill
698	bi bi-diamond
696	bi bi-diamond-fill
697	bi bi-diamond-half
700	bi bi-dice-1
699	bi bi-dice-1-fill
702	bi bi-dice-2
701	bi bi-dice-2-fill
704	bi bi-dice-3
703	bi bi-dice-3-fill
706	bi bi-dice-4
705	bi bi-dice-4-fill
708	bi bi-dice-5
707	bi bi-dice-5-fill
710	bi bi-dice-6
709	bi bi-dice-6-fill
712	bi bi-disc
711	bi bi-disc-fill
713	bi bi-discord
715	bi bi-display
714	bi bi-display-fill
717	bi bi-displayport
716	bi bi-displayport-fill
718	bi bi-distribute-horizontal
719	bi bi-distribute-vertical
721	bi bi-door-closed
720	bi bi-door-closed-fill
723	bi bi-door-open
722	bi bi-door-open-fill
724	bi bi-dot
725	bi bi-download
727	bi bi-dpad
726	bi bi-dpad-fill
728	bi bi-dribbble
729	bi bi-dropbox
732	bi bi-droplet
730	bi bi-droplet-fill
731	bi bi-droplet-half
734	bi bi-ear
733	bi bi-ear-fill
735	bi bi-earbuds
737	bi bi-easel
736	bi bi-easel-fill
739	bi bi-easel2
738	bi bi-easel2-fill
741	bi bi-easel3
740	bi bi-easel3-fill
744	bi bi-egg
742	bi bi-egg-fill
743	bi bi-egg-fried
746	bi bi-eject
745	bi bi-eject-fill
748	bi bi-emoji-angry
747	bi bi-emoji-angry-fill
750	bi bi-emoji-dizzy
749	bi bi-emoji-dizzy-fill
752	bi bi-emoji-expressionless
751	bi bi-emoji-expressionless-fill
754	bi bi-emoji-frown
753	bi bi-emoji-frown-fill
756	bi bi-emoji-heart-eyes
755	bi bi-emoji-heart-eyes-fill
758	bi bi-emoji-kiss
757	bi bi-emoji-kiss-fill
760	bi bi-emoji-laughing
759	bi bi-emoji-laughing-fill
762	bi bi-emoji-neutral
761	bi bi-emoji-neutral-fill
766	bi bi-emoji-smile
763	bi bi-emoji-smile-fill
765	bi bi-emoji-smile-upside-down
764	bi bi-emoji-smile-upside-down-fill
768	bi bi-emoji-sunglasses
767	bi bi-emoji-sunglasses-fill
770	bi bi-emoji-wink
769	bi bi-emoji-wink-fill
796	bi bi-envelope
772	bi bi-envelope-at
771	bi bi-envelope-at-fill
774	bi bi-envelope-check
773	bi bi-envelope-check-fill
776	bi bi-envelope-dash
775	bi bi-envelope-dash-fill
778	bi bi-envelope-exclamation
777	bi bi-envelope-exclamation-fill
779	bi bi-envelope-fill
781	bi bi-envelope-heart
780	bi bi-envelope-heart-fill
785	bi bi-envelope-open
782	bi bi-envelope-open-fill
784	bi bi-envelope-open-heart
783	bi bi-envelope-open-heart-fill
789	bi bi-envelope-paper
786	bi bi-envelope-paper-fill
788	bi bi-envelope-paper-heart
787	bi bi-envelope-paper-heart-fill
791	bi bi-envelope-plus
790	bi bi-envelope-plus-fill
793	bi bi-envelope-slash
792	bi bi-envelope-slash-fill
795	bi bi-envelope-x
794	bi bi-envelope-x-fill
798	bi bi-eraser
797	bi bi-eraser-fill
799	bi bi-escape
800	bi bi-ethernet
802	bi bi-ev-front
801	bi bi-ev-front-fill
804	bi bi-ev-station
803	bi bi-ev-station-fill
816	bi bi-exclamation
806	bi bi-exclamation-circle
805	bi bi-exclamation-circle-fill
808	bi bi-exclamation-diamond
807	bi bi-exclamation-diamond-fill
809	bi bi-exclamation-lg
811	bi bi-exclamation-octagon
810	bi bi-exclamation-octagon-fill
813	bi bi-exclamation-square
812	bi bi-exclamation-square-fill
815	bi bi-exclamation-triangle
814	bi bi-exclamation-triangle-fill
817	bi bi-exclude
819	bi bi-explicit
818	bi bi-explicit-fill
823	bi bi-eye
820	bi bi-eye-fill
822	bi bi-eye-slash
821	bi bi-eye-slash-fill
824	bi bi-eyedropper
825	bi bi-eyeglasses
826	bi bi-facebook
827	bi bi-fan
833	bi bi-fast-forward
829	bi bi-fast-forward-btn
828	bi bi-fast-forward-btn-fill
831	bi bi-fast-forward-circle
830	bi bi-fast-forward-circle-fill
832	bi bi-fast-forward-fill
961	bi bi-file
835	bi bi-file-arrow-down
834	bi bi-file-arrow-down-fill
837	bi bi-file-arrow-up
836	bi bi-file-arrow-up-fill
839	bi bi-file-bar-graph
838	bi bi-file-bar-graph-fill
841	bi bi-file-binary
840	bi bi-file-binary-fill
843	bi bi-file-break
842	bi bi-file-break-fill
845	bi bi-file-check
844	bi bi-file-check-fill
847	bi bi-file-code
846	bi bi-file-code-fill
849	bi bi-file-diff
848	bi bi-file-diff-fill
913	bi bi-file-earmark
851	bi bi-file-earmark-arrow-down
850	bi bi-file-earmark-arrow-down-fill
853	bi bi-file-earmark-arrow-up
852	bi bi-file-earmark-arrow-up-fill
855	bi bi-file-earmark-bar-graph
854	bi bi-file-earmark-bar-graph-fill
857	bi bi-file-earmark-binary
856	bi bi-file-earmark-binary-fill
859	bi bi-file-earmark-break
858	bi bi-file-earmark-break-fill
861	bi bi-file-earmark-check
860	bi bi-file-earmark-check-fill
863	bi bi-file-earmark-code
862	bi bi-file-earmark-code-fill
865	bi bi-file-earmark-diff
864	bi bi-file-earmark-diff-fill
867	bi bi-file-earmark-easel
866	bi bi-file-earmark-easel-fill
869	bi bi-file-earmark-excel
868	bi bi-file-earmark-excel-fill
870	bi bi-file-earmark-fill
872	bi bi-file-earmark-font
871	bi bi-file-earmark-font-fill
874	bi bi-file-earmark-image
873	bi bi-file-earmark-image-fill
876	bi bi-file-earmark-lock
875	bi bi-file-earmark-lock-fill
878	bi bi-file-earmark-lock2
877	bi bi-file-earmark-lock2-fill
880	bi bi-file-earmark-medical
879	bi bi-file-earmark-medical-fill
882	bi bi-file-earmark-minus
881	bi bi-file-earmark-minus-fill
884	bi bi-file-earmark-music
883	bi bi-file-earmark-music-fill
886	bi bi-file-earmark-pdf
885	bi bi-file-earmark-pdf-fill
888	bi bi-file-earmark-person
887	bi bi-file-earmark-person-fill
890	bi bi-file-earmark-play
889	bi bi-file-earmark-play-fill
892	bi bi-file-earmark-plus
891	bi bi-file-earmark-plus-fill
894	bi bi-file-earmark-post
893	bi bi-file-earmark-post-fill
896	bi bi-file-earmark-ppt
895	bi bi-file-earmark-ppt-fill
898	bi bi-file-earmark-richtext
897	bi bi-file-earmark-richtext-fill
900	bi bi-file-earmark-ruled
899	bi bi-file-earmark-ruled-fill
902	bi bi-file-earmark-slides
901	bi bi-file-earmark-slides-fill
904	bi bi-file-earmark-spreadsheet
903	bi bi-file-earmark-spreadsheet-fill
906	bi bi-file-earmark-text
905	bi bi-file-earmark-text-fill
908	bi bi-file-earmark-word
907	bi bi-file-earmark-word-fill
910	bi bi-file-earmark-x
909	bi bi-file-earmark-x-fill
912	bi bi-file-earmark-zip
911	bi bi-file-earmark-zip-fill
915	bi bi-file-easel
914	bi bi-file-easel-fill
917	bi bi-file-excel
916	bi bi-file-excel-fill
918	bi bi-file-fill
920	bi bi-file-font
919	bi bi-file-font-fill
922	bi bi-file-image
921	bi bi-file-image-fill
924	bi bi-file-lock
923	bi bi-file-lock-fill
926	bi bi-file-lock2
925	bi bi-file-lock2-fill
928	bi bi-file-medical
927	bi bi-file-medical-fill
930	bi bi-file-minus
929	bi bi-file-minus-fill
932	bi bi-file-music
931	bi bi-file-music-fill
934	bi bi-file-pdf
933	bi bi-file-pdf-fill
936	bi bi-file-person
935	bi bi-file-person-fill
938	bi bi-file-play
937	bi bi-file-play-fill
940	bi bi-file-plus
939	bi bi-file-plus-fill
942	bi bi-file-post
941	bi bi-file-post-fill
944	bi bi-file-ppt
943	bi bi-file-ppt-fill
946	bi bi-file-richtext
945	bi bi-file-richtext-fill
948	bi bi-file-ruled
947	bi bi-file-ruled-fill
950	bi bi-file-slides
949	bi bi-file-slides-fill
952	bi bi-file-spreadsheet
951	bi bi-file-spreadsheet-fill
954	bi bi-file-text
953	bi bi-file-text-fill
956	bi bi-file-word
955	bi bi-file-word-fill
958	bi bi-file-x
957	bi bi-file-x-fill
960	bi bi-file-zip
959	bi bi-file-zip-fill
963	bi bi-files
962	bi bi-files-alt
964	bi bi-filetype-aac
965	bi bi-filetype-ai
966	bi bi-filetype-bmp
967	bi bi-filetype-cs
968	bi bi-filetype-css
969	bi bi-filetype-csv
970	bi bi-filetype-doc
971	bi bi-filetype-docx
972	bi bi-filetype-exe
973	bi bi-filetype-gif
974	bi bi-filetype-heic
975	bi bi-filetype-html
976	bi bi-filetype-java
977	bi bi-filetype-jpg
978	bi bi-filetype-js
979	bi bi-filetype-json
980	bi bi-filetype-jsx
981	bi bi-filetype-key
982	bi bi-filetype-m4p
983	bi bi-filetype-md
984	bi bi-filetype-mdx
985	bi bi-filetype-mov
986	bi bi-filetype-mp3
987	bi bi-filetype-mp4
988	bi bi-filetype-otf
989	bi bi-filetype-pdf
990	bi bi-filetype-php
991	bi bi-filetype-png
992	bi bi-filetype-ppt
993	bi bi-filetype-pptx
994	bi bi-filetype-psd
995	bi bi-filetype-py
996	bi bi-filetype-raw
997	bi bi-filetype-rb
998	bi bi-filetype-sass
999	bi bi-filetype-scss
1000	bi bi-filetype-sh
1001	bi bi-filetype-sql
1002	bi bi-filetype-svg
1003	bi bi-filetype-tiff
1004	bi bi-filetype-tsx
1005	bi bi-filetype-ttf
1006	bi bi-filetype-txt
1007	bi bi-filetype-wav
1008	bi bi-filetype-woff
1009	bi bi-filetype-xls
1010	bi bi-filetype-xlsx
1011	bi bi-filetype-xml
1012	bi bi-filetype-yml
1013	bi bi-film
1020	bi bi-filter
1015	bi bi-filter-circle
1014	bi bi-filter-circle-fill
1016	bi bi-filter-left
1017	bi bi-filter-right
1019	bi bi-filter-square
1018	bi bi-filter-square-fill
1021	bi bi-fingerprint
1022	bi bi-fire
1024	bi bi-flag
1023	bi bi-flag-fill
1025	bi bi-flower1
1026	bi bi-flower2
1027	bi bi-flower3
1035	bi bi-folder
1028	bi bi-folder-check
1029	bi bi-folder-fill
1030	bi bi-folder-minus
1031	bi bi-folder-plus
1033	bi bi-folder-symlink
1032	bi bi-folder-symlink-fill
1034	bi bi-folder-x
1037	bi bi-folder2
1036	bi bi-folder2-open
1038	bi bi-fonts
1040	bi bi-forward
1039	bi bi-forward-fill
1041	bi bi-front
1045	bi bi-fuel-pump
1043	bi bi-fuel-pump-diesel
1042	bi bi-fuel-pump-diesel-fill
1044	bi bi-fuel-pump-fill
1047	bi bi-fullscreen
1046	bi bi-fullscreen-exit
1049	bi bi-funnel
1048	bi bi-funnel-fill
1053	bi bi-gear
1050	bi bi-gear-fill
1052	bi bi-gear-wide
1051	bi bi-gear-wide-connected
1054	bi bi-gem
1055	bi bi-gender-ambiguous
1056	bi bi-gender-female
1057	bi bi-gender-male
1058	bi bi-gender-trans
1062	bi bi-geo
1060	bi bi-geo-alt
1059	bi bi-geo-alt-fill
1061	bi bi-geo-fill
1064	bi bi-gift
1063	bi bi-gift-fill
1065	bi bi-git
1066	bi bi-github
1071	bi bi-globe
1067	bi bi-globe-americas
1068	bi bi-globe-asia-australia
1069	bi bi-globe-central-south-asia
1070	bi bi-globe-europe-africa
1072	bi bi-globe2
1074	bi bi-google
1073	bi bi-google-play
1075	bi bi-gpu-card
1077	bi bi-graph-down
1076	bi bi-graph-down-arrow
1079	bi bi-graph-up
1078	bi bi-graph-up-arrow
1089	bi bi-grid
1081	bi bi-grid-1x2
1080	bi bi-grid-1x2-fill
1084	bi bi-grid-3x2
1083	bi bi-grid-3x2-gap
1082	bi bi-grid-3x2-gap-fill
1087	bi bi-grid-3x3
1086	bi bi-grid-3x3-gap
1085	bi bi-grid-3x3-gap-fill
1088	bi bi-grid-fill
1090	bi bi-grip-horizontal
1091	bi bi-grip-vertical
1093	bi bi-h-circle
1092	bi bi-h-circle-fill
1095	bi bi-h-square
1094	bi bi-h-square-fill
1096	bi bi-hammer
1100	bi bi-hand-index
1097	bi bi-hand-index-fill
1099	bi bi-hand-index-thumb
1098	bi bi-hand-index-thumb-fill
1102	bi bi-hand-thumbs-down
1101	bi bi-hand-thumbs-down-fill
1104	bi bi-hand-thumbs-up
1103	bi bi-hand-thumbs-up-fill
1106	bi bi-handbag
1105	bi bi-handbag-fill
1107	bi bi-hash
1115	bi bi-hdd
1108	bi bi-hdd-fill
1110	bi bi-hdd-network
1109	bi bi-hdd-network-fill
1112	bi bi-hdd-rack
1111	bi bi-hdd-rack-fill
1114	bi bi-hdd-stack
1113	bi bi-hdd-stack-fill
1117	bi bi-hdmi
1116	bi bi-hdmi-fill
1118	bi bi-headphones
1120	bi bi-headset
1119	bi bi-headset-vr
1126	bi bi-heart
1121	bi bi-heart-arrow
1122	bi bi-heart-fill
1123	bi bi-heart-half
1125	bi bi-heart-pulse
1124	bi bi-heart-pulse-fill
1128	bi bi-heartbreak
1127	bi bi-heartbreak-fill
1129	bi bi-hearts
1132	bi bi-heptagon
1130	bi bi-heptagon-fill
1131	bi bi-heptagon-half
1135	bi bi-hexagon
1133	bi bi-hexagon-fill
1134	bi bi-hexagon-half
1137	bi bi-hospital
1136	bi bi-hospital-fill
1141	bi bi-hourglass
1138	bi bi-hourglass-bottom
1139	bi bi-hourglass-split
1140	bi bi-hourglass-top
1167	bi bi-house
1143	bi bi-house-add
1142	bi bi-house-add-fill
1145	bi bi-house-check
1144	bi bi-house-check-fill
1147	bi bi-house-dash
1146	bi bi-house-dash-fill
1149	bi bi-house-door
1148	bi bi-house-door-fill
1151	bi bi-house-down
1150	bi bi-house-down-fill
1153	bi bi-house-exclamation
1152	bi bi-house-exclamation-fill
1154	bi bi-house-fill
1156	bi bi-house-gear
1155	bi bi-house-gear-fill
1158	bi bi-house-heart
1157	bi bi-house-heart-fill
1160	bi bi-house-lock
1159	bi bi-house-lock-fill
1162	bi bi-house-slash
1161	bi bi-house-slash-fill
1164	bi bi-house-up
1163	bi bi-house-up-fill
1166	bi bi-house-x
1165	bi bi-house-x-fill
1169	bi bi-houses
1168	bi bi-houses-fill
1170	bi bi-hr
1171	bi bi-hurricane
1172	bi bi-hypnotize
1175	bi bi-image
1173	bi bi-image-alt
1174	bi bi-image-fill
1176	bi bi-images
1178	bi bi-inbox
1177	bi bi-inbox-fill
1180	bi bi-inboxes
1179	bi bi-inboxes-fill
1181	bi bi-incognito
1182	bi bi-indent
1183	bi bi-infinity
1189	bi bi-info
1185	bi bi-info-circle
1184	bi bi-info-circle-fill
1186	bi bi-info-lg
1188	bi bi-info-square
1187	bi bi-info-square-fill
1191	bi bi-input-cursor
1190	bi bi-input-cursor-text
1192	bi bi-instagram
1193	bi bi-intersect
1207	bi bi-journal
1194	bi bi-journal-album
1195	bi bi-journal-arrow-down
1196	bi bi-journal-arrow-up
1198	bi bi-journal-bookmark
1197	bi bi-journal-bookmark-fill
1199	bi bi-journal-check
1200	bi bi-journal-code
1201	bi bi-journal-medical
1202	bi bi-journal-minus
1203	bi bi-journal-plus
1204	bi bi-journal-richtext
1205	bi bi-journal-text
1206	bi bi-journal-x
1208	bi bi-journals
1209	bi bi-joystick
1212	bi bi-justify
1210	bi bi-justify-left
1211	bi bi-justify-right
1214	bi bi-kanban
1213	bi bi-kanban-fill
1216	bi bi-key
1215	bi bi-key-fill
1218	bi bi-keyboard
1217	bi bi-keyboard-fill
1219	bi bi-ladder
1221	bi bi-lamp
1220	bi bi-lamp-fill
1223	bi bi-laptop
1222	bi bi-laptop-fill
1224	bi bi-layer-backward
1225	bi bi-layer-forward
1228	bi bi-layers
1226	bi bi-layers-fill
1227	bi bi-layers-half
1232	bi bi-layout-sidebar
1230	bi bi-layout-sidebar-inset
1229	bi bi-layout-sidebar-inset-reverse
1231	bi bi-layout-sidebar-reverse
1233	bi bi-layout-split
1235	bi bi-layout-text-sidebar
1234	bi bi-layout-text-sidebar-reverse
1237	bi bi-layout-text-window
1236	bi bi-layout-text-window-reverse
1238	bi bi-layout-three-columns
1239	bi bi-layout-wtf
1240	bi bi-life-preserver
1244	bi bi-lightbulb
1241	bi bi-lightbulb-fill
1243	bi bi-lightbulb-off
1242	bi bi-lightbulb-off-fill
1248	bi bi-lightning
1246	bi bi-lightning-charge
1245	bi bi-lightning-charge-fill
1247	bi bi-lightning-fill
1249	bi bi-line
1251	bi bi-link
1250	bi bi-link-45deg
1252	bi bi-linkedin
1261	bi bi-list
1253	bi bi-list-check
1255	bi bi-list-columns
1254	bi bi-list-columns-reverse
1256	bi bi-list-nested
1257	bi bi-list-ol
1258	bi bi-list-stars
1259	bi bi-list-task
1260	bi bi-list-ul
1263	bi bi-lock
1262	bi bi-lock-fill
1265	bi bi-lungs
1264	bi bi-lungs-fill
1266	bi bi-magic
1268	bi bi-magnet
1267	bi bi-magnet-fill
1269	bi bi-mailbox
1270	bi bi-mailbox2
1272	bi bi-map
1271	bi bi-map-fill
1274	bi bi-markdown
1273	bi bi-markdown-fill
1275	bi bi-mask
1276	bi bi-mastodon
1277	bi bi-medium
1279	bi bi-megaphone
1278	bi bi-megaphone-fill
1280	bi bi-memory
1282	bi bi-menu-app
1281	bi bi-menu-app-fill
1286	bi bi-menu-button
1283	bi bi-menu-button-fill
1285	bi bi-menu-button-wide
1284	bi bi-menu-button-wide-fill
1287	bi bi-menu-down
1288	bi bi-menu-up
1289	bi bi-messenger
1290	bi bi-meta
1294	bi bi-mic
1291	bi bi-mic-fill
1293	bi bi-mic-mute
1292	bi bi-mic-mute-fill
1296	bi bi-microsoft
1295	bi bi-microsoft-teams
1298	bi bi-minecart
1297	bi bi-minecart-loaded
1300	bi bi-modem
1299	bi bi-modem-fill
1301	bi bi-moisture
1305	bi bi-moon
1302	bi bi-moon-fill
1304	bi bi-moon-stars
1303	bi bi-moon-stars-fill
1307	bi bi-mortarboard
1306	bi bi-mortarboard-fill
1309	bi bi-motherboard
1308	bi bi-motherboard-fill
1311	bi bi-mouse
1310	bi bi-mouse-fill
1313	bi bi-mouse2
1312	bi bi-mouse2-fill
1315	bi bi-mouse3
1314	bi bi-mouse3-fill
1318	bi bi-music-note
1316	bi bi-music-note-beamed
1317	bi bi-music-note-list
1320	bi bi-music-player
1319	bi bi-music-player-fill
1321	bi bi-newspaper
1322	bi bi-nintendo-switch
1324	bi bi-node-minus
1323	bi bi-node-minus-fill
1326	bi bi-node-plus
1325	bi bi-node-plus-fill
1328	bi bi-nut
1327	bi bi-nut-fill
1329	bi bi-nvidia
1332	bi bi-octagon
1330	bi bi-octagon-fill
1331	bi bi-octagon-half
1334	bi bi-optical-audio
1333	bi bi-optical-audio-fill
1335	bi bi-option
1336	bi bi-outlet
1338	bi bi-p-circle
1337	bi bi-p-circle-fill
1340	bi bi-p-square
1339	bi bi-p-square-fill
1341	bi bi-paint-bucket
1343	bi bi-palette
1342	bi bi-palette-fill
1344	bi bi-palette2
1345	bi bi-paperclip
1346	bi bi-paragraph
1348	bi bi-pass
1347	bi bi-pass-fill
1350	bi bi-patch-check
1349	bi bi-patch-check-fill
1352	bi bi-patch-exclamation
1351	bi bi-patch-exclamation-fill
1354	bi bi-patch-minus
1353	bi bi-patch-minus-fill
1356	bi bi-patch-plus
1355	bi bi-patch-plus-fill
1358	bi bi-patch-question
1357	bi bi-patch-question-fill
1364	bi bi-pause
1360	bi bi-pause-btn
1359	bi bi-pause-btn-fill
1362	bi bi-pause-circle
1361	bi bi-pause-circle-fill
1363	bi bi-pause-fill
1365	bi bi-paypal
1369	bi bi-pc
1367	bi bi-pc-display
1366	bi bi-pc-display-horizontal
1368	bi bi-pc-horizontal
1370	bi bi-pci-card
1372	bi bi-peace
1371	bi bi-peace-fill
1374	bi bi-pen
1373	bi bi-pen-fill
1377	bi bi-pencil
1375	bi bi-pencil-fill
1376	bi bi-pencil-square
1380	bi bi-pentagon
1378	bi bi-pentagon-fill
1379	bi bi-pentagon-half
1382	bi bi-people
1381	bi bi-people-fill
1383	bi bi-percent
1425	bi bi-person
1384	bi bi-person-add
1386	bi bi-person-badge
1385	bi bi-person-badge-fill
1387	bi bi-person-bounding-box
1389	bi bi-person-check
1388	bi bi-person-check-fill
1390	bi bi-person-circle
1392	bi bi-person-dash
1391	bi bi-person-dash-fill
1393	bi bi-person-down
1394	bi bi-person-exclamation
1405	bi bi-person-fill
1395	bi bi-person-fill-add
1396	bi bi-person-fill-check
1397	bi bi-person-fill-dash
1398	bi bi-person-fill-down
1399	bi bi-person-fill-exclamation
1400	bi bi-person-fill-gear
1401	bi bi-person-fill-lock
1402	bi bi-person-fill-slash
1403	bi bi-person-fill-up
1404	bi bi-person-fill-x
1406	bi bi-person-gear
1407	bi bi-person-heart
1408	bi bi-person-hearts
1409	bi bi-person-lines-fill
1410	bi bi-person-lock
1412	bi bi-person-plus
1411	bi bi-person-plus-fill
1413	bi bi-person-rolodex
1414	bi bi-person-slash
1415	bi bi-person-square
1416	bi bi-person-up
1418	bi bi-person-vcard
1417	bi bi-person-vcard-fill
1419	bi bi-person-video
1420	bi bi-person-video2
1421	bi bi-person-video3
1422	bi bi-person-workspace
1424	bi bi-person-x
1423	bi bi-person-x-fill
1432	bi bi-phone
1426	bi bi-phone-fill
1427	bi bi-phone-flip
1429	bi bi-phone-landscape
1428	bi bi-phone-landscape-fill
1431	bi bi-phone-vibrate
1430	bi bi-phone-vibrate-fill
1434	bi bi-pie-chart
1433	bi bi-pie-chart-fill
1436	bi bi-piggy-bank
1435	bi bi-piggy-bank-fill
1442	bi bi-pin
1438	bi bi-pin-angle
1437	bi bi-pin-angle-fill
1439	bi bi-pin-fill
1441	bi bi-pin-map
1440	bi bi-pin-map-fill
1443	bi bi-pinterest
1445	bi bi-pip
1444	bi bi-pip-fill
1451	bi bi-play
1447	bi bi-play-btn
1446	bi bi-play-btn-fill
1449	bi bi-play-circle
1448	bi bi-play-circle-fill
1450	bi bi-play-fill
1452	bi bi-playstation
1454	bi bi-plug
1453	bi bi-plug-fill
1455	bi bi-plugin
1464	bi bi-plus
1458	bi bi-plus-circle
1456	bi bi-plus-circle-dotted
1457	bi bi-plus-circle-fill
1459	bi bi-plus-lg
1460	bi bi-plus-slash-minus
1463	bi bi-plus-square
1461	bi bi-plus-square-dotted
1462	bi bi-plus-square-fill
1468	bi bi-postage
1465	bi bi-postage-fill
1467	bi bi-postage-heart
1466	bi bi-postage-heart-fill
1472	bi bi-postcard
1469	bi bi-postcard-fill
1471	bi bi-postcard-heart
1470	bi bi-postcard-heart-fill
1473	bi bi-power
1474	bi bi-prescription
1475	bi bi-prescription2
1477	bi bi-printer
1476	bi bi-printer-fill
1479	bi bi-projector
1478	bi bi-projector-fill
1481	bi bi-puzzle
1480	bi bi-puzzle-fill
1483	bi bi-qr-code
1482	bi bi-qr-code-scan
1493	bi bi-question
1485	bi bi-question-circle
1484	bi bi-question-circle-fill
1487	bi bi-question-diamond
1486	bi bi-question-diamond-fill
1488	bi bi-question-lg
1490	bi bi-question-octagon
1489	bi bi-question-octagon-fill
1492	bi bi-question-square
1491	bi bi-question-square-fill
1494	bi bi-quora
1495	bi bi-quote
1497	bi bi-r-circle
1496	bi bi-r-circle-fill
1499	bi bi-r-square
1498	bi bi-r-square-fill
1500	bi bi-radioactive
1501	bi bi-rainbow
1503	bi bi-receipt
1502	bi bi-receipt-cutoff
1504	bi bi-reception-0
1505	bi bi-reception-1
1506	bi bi-reception-2
1507	bi bi-reception-3
1508	bi bi-reception-4
1514	bi bi-record
1510	bi bi-record-btn
1509	bi bi-record-btn-fill
1512	bi bi-record-circle
1511	bi bi-record-circle-fill
1513	bi bi-record-fill
1516	bi bi-record2
1515	bi bi-record2-fill
1517	bi bi-recycle
1518	bi bi-reddit
1519	bi bi-regex
1521	bi bi-repeat
1520	bi bi-repeat-1
1525	bi bi-reply
1523	bi bi-reply-all
1522	bi bi-reply-all-fill
1524	bi bi-reply-fill
1531	bi bi-rewind
1527	bi bi-rewind-btn
1526	bi bi-rewind-btn-fill
1529	bi bi-rewind-circle
1528	bi bi-rewind-circle-fill
1530	bi bi-rewind-fill
1532	bi bi-robot
1536	bi bi-rocket
1533	bi bi-rocket-fill
1535	bi bi-rocket-takeoff
1534	bi bi-rocket-takeoff-fill
1538	bi bi-router
1537	bi bi-router-fill
1540	bi bi-rss
1539	bi bi-rss-fill
1541	bi bi-rulers
1543	bi bi-safe
1542	bi bi-safe-fill
1545	bi bi-safe2
1544	bi bi-safe2-fill
1547	bi bi-save
1546	bi bi-save-fill
1549	bi bi-save2
1548	bi bi-save2-fill
1550	bi bi-scissors
1551	bi bi-scooter
1552	bi bi-screwdriver
1554	bi bi-sd-card
1553	bi bi-sd-card-fill
1557	bi bi-search
1556	bi bi-search-heart
1555	bi bi-search-heart-fill
1558	bi bi-segmented-nav
1572	bi bi-send
1560	bi bi-send-check
1559	bi bi-send-check-fill
1562	bi bi-send-dash
1561	bi bi-send-dash-fill
1564	bi bi-send-exclamation
1563	bi bi-send-exclamation-fill
1565	bi bi-send-fill
1567	bi bi-send-plus
1566	bi bi-send-plus-fill
1569	bi bi-send-slash
1568	bi bi-send-slash-fill
1571	bi bi-send-x
1570	bi bi-send-x-fill
1573	bi bi-server
1575	bi bi-share
1574	bi bi-share-fill
1592	bi bi-shield
1576	bi bi-shield-check
1577	bi bi-shield-exclamation
1583	bi bi-shield-fill
1578	bi bi-shield-fill-check
1579	bi bi-shield-fill-exclamation
1580	bi bi-shield-fill-minus
1581	bi bi-shield-fill-plus
1582	bi bi-shield-fill-x
1585	bi bi-shield-lock
1584	bi bi-shield-lock-fill
1586	bi bi-shield-minus
1587	bi bi-shield-plus
1588	bi bi-shield-shaded
1590	bi bi-shield-slash
1589	bi bi-shield-slash-fill
1591	bi bi-shield-x
1594	bi bi-shift
1593	bi bi-shift-fill
1596	bi bi-shop
1595	bi bi-shop-window
1597	bi bi-shuffle
1599	bi bi-sign-dead-end
1598	bi bi-sign-dead-end-fill
1601	bi bi-sign-do-not-enter
1600	bi bi-sign-do-not-enter-fill
1609	bi bi-sign-intersection
1602	bi bi-sign-intersection-fill
1604	bi bi-sign-intersection-side
1603	bi bi-sign-intersection-side-fill
1606	bi bi-sign-intersection-t
1605	bi bi-sign-intersection-t-fill
1608	bi bi-sign-intersection-y
1607	bi bi-sign-intersection-y-fill
1611	bi bi-sign-merge-left
1610	bi bi-sign-merge-left-fill
1613	bi bi-sign-merge-right
1612	bi bi-sign-merge-right-fill
1615	bi bi-sign-no-left-turn
1614	bi bi-sign-no-left-turn-fill
1617	bi bi-sign-no-parking
1616	bi bi-sign-no-parking-fill
1619	bi bi-sign-no-right-turn
1618	bi bi-sign-no-right-turn-fill
1621	bi bi-sign-railroad
1620	bi bi-sign-railroad-fill
1625	bi bi-sign-stop
1622	bi bi-sign-stop-fill
1624	bi bi-sign-stop-lights
1623	bi bi-sign-stop-lights-fill
1627	bi bi-sign-turn-left
1626	bi bi-sign-turn-left-fill
1629	bi bi-sign-turn-right
1628	bi bi-sign-turn-right-fill
1631	bi bi-sign-turn-slight-left
1630	bi bi-sign-turn-slight-left-fill
1633	bi bi-sign-turn-slight-right
1632	bi bi-sign-turn-slight-right-fill
1635	bi bi-sign-yield
1634	bi bi-sign-yield-fill
1636	bi bi-signal
1642	bi bi-signpost
1638	bi bi-signpost-2
1637	bi bi-signpost-2-fill
1639	bi bi-signpost-fill
1641	bi bi-signpost-split
1640	bi bi-signpost-split-fill
1644	bi bi-sim
1643	bi bi-sim-fill
1645	bi bi-sina-weibo
1651	bi bi-skip-backward
1647	bi bi-skip-backward-btn
1646	bi bi-skip-backward-btn-fill
1649	bi bi-skip-backward-circle
1648	bi bi-skip-backward-circle-fill
1650	bi bi-skip-backward-fill
1657	bi bi-skip-end
1653	bi bi-skip-end-btn
1652	bi bi-skip-end-btn-fill
1655	bi bi-skip-end-circle
1654	bi bi-skip-end-circle-fill
1656	bi bi-skip-end-fill
1663	bi bi-skip-forward
1659	bi bi-skip-forward-btn
1658	bi bi-skip-forward-btn-fill
1661	bi bi-skip-forward-circle
1660	bi bi-skip-forward-circle-fill
1662	bi bi-skip-forward-fill
1669	bi bi-skip-start
1665	bi bi-skip-start-btn
1664	bi bi-skip-start-btn-fill
1667	bi bi-skip-start-circle
1666	bi bi-skip-start-circle-fill
1668	bi bi-skip-start-fill
1670	bi bi-skype
1671	bi bi-slack
1677	bi bi-slash
1673	bi bi-slash-circle
1672	bi bi-slash-circle-fill
1674	bi bi-slash-lg
1676	bi bi-slash-square
1675	bi bi-slash-square-fill
1678	bi bi-sliders
1680	bi bi-sliders2
1679	bi bi-sliders2-vertical
1681	bi bi-smartwatch
1682	bi bi-snapchat
1683	bi bi-snow
1684	bi bi-snow2
1685	bi bi-snow3
1687	bi bi-sort-alpha-down
1686	bi bi-sort-alpha-down-alt
1689	bi bi-sort-alpha-up
1688	bi bi-sort-alpha-up-alt
1691	bi bi-sort-down
1690	bi bi-sort-down-alt
1693	bi bi-sort-numeric-down
1692	bi bi-sort-numeric-down-alt
1695	bi bi-sort-numeric-up
1694	bi bi-sort-numeric-up-alt
1697	bi bi-sort-up
1696	bi bi-sort-up-alt
1698	bi bi-soundwave
1700	bi bi-speaker
1699	bi bi-speaker-fill
1701	bi bi-speedometer
1702	bi bi-speedometer2
1703	bi bi-spellcheck
1704	bi bi-spotify
1707	bi bi-square
1705	bi bi-square-fill
1706	bi bi-square-half
1709	bi bi-stack
1708	bi bi-stack-overflow
1712	bi bi-star
1710	bi bi-star-fill
1711	bi bi-star-half
1713	bi bi-stars
1714	bi bi-steam
1716	bi bi-stickies
1715	bi bi-stickies-fill
1718	bi bi-sticky
1717	bi bi-sticky-fill
1724	bi bi-stop
1720	bi bi-stop-btn
1719	bi bi-stop-btn-fill
1722	bi bi-stop-circle
1721	bi bi-stop-circle-fill
1723	bi bi-stop-fill
1726	bi bi-stoplights
1725	bi bi-stoplights-fill
1728	bi bi-stopwatch
1727	bi bi-stopwatch-fill
1729	bi bi-strava
1730	bi bi-stripe
1731	bi bi-subscript
1732	bi bi-subtract
1734	bi bi-suit-club
1733	bi bi-suit-club-fill
1736	bi bi-suit-diamond
1735	bi bi-suit-diamond-fill
1738	bi bi-suit-heart
1737	bi bi-suit-heart-fill
1740	bi bi-suit-spade
1739	bi bi-suit-spade-fill
1742	bi bi-sun
1741	bi bi-sun-fill
1743	bi bi-sunglasses
1745	bi bi-sunrise
1744	bi bi-sunrise-fill
1747	bi bi-sunset
1746	bi bi-sunset-fill
1748	bi bi-superscript
1749	bi bi-symmetry-horizontal
1750	bi bi-symmetry-vertical
1751	bi bi-table
1755	bi bi-tablet
1752	bi bi-tablet-fill
1754	bi bi-tablet-landscape
1753	bi bi-tablet-landscape-fill
1757	bi bi-tag
1756	bi bi-tag-fill
1759	bi bi-tags
1758	bi bi-tags-fill
1761	bi bi-taxi-front
1760	bi bi-taxi-front-fill
1762	bi bi-telegram
1776	bi bi-telephone
1763	bi bi-telephone-fill
1765	bi bi-telephone-forward
1764	bi bi-telephone-forward-fill
1767	bi bi-telephone-inbound
1766	bi bi-telephone-inbound-fill
1769	bi bi-telephone-minus
1768	bi bi-telephone-minus-fill
1771	bi bi-telephone-outbound
1770	bi bi-telephone-outbound-fill
1773	bi bi-telephone-plus
1772	bi bi-telephone-plus-fill
1775	bi bi-telephone-x
1774	bi bi-telephone-x-fill
1777	bi bi-tencent-qq
1783	bi bi-terminal
1778	bi bi-terminal-dash
1779	bi bi-terminal-fill
1780	bi bi-terminal-plus
1781	bi bi-terminal-split
1782	bi bi-terminal-x
1784	bi bi-text-center
1785	bi bi-text-indent-left
1786	bi bi-text-indent-right
1787	bi bi-text-left
1788	bi bi-text-paragraph
1789	bi bi-text-right
1790	bi bi-text-wrap
1793	bi bi-textarea
1791	bi bi-textarea-resize
1792	bi bi-textarea-t
1799	bi bi-thermometer
1794	bi bi-thermometer-half
1795	bi bi-thermometer-high
1796	bi bi-thermometer-low
1797	bi bi-thermometer-snow
1798	bi bi-thermometer-sun
1801	bi bi-three-dots
1800	bi bi-three-dots-vertical
1803	bi bi-thunderbolt
1802	bi bi-thunderbolt-fill
1809	bi bi-ticket
1805	bi bi-ticket-detailed
1804	bi bi-ticket-detailed-fill
1806	bi bi-ticket-fill
1808	bi bi-ticket-perforated
1807	bi bi-ticket-perforated-fill
1810	bi bi-tiktok
1811	bi bi-toggle-off
1812	bi bi-toggle-on
1813	bi bi-toggle2-off
1814	bi bi-toggle2-on
1815	bi bi-toggles
1816	bi bi-toggles2
1817	bi bi-tools
1818	bi bi-tornado
1820	bi bi-train-freight-front
1819	bi bi-train-freight-front-fill
1822	bi bi-train-front
1821	bi bi-train-front-fill
1824	bi bi-train-lightrail-front
1823	bi bi-train-lightrail-front-fill
1825	bi bi-translate
1827	bi bi-trash
1826	bi bi-trash-fill
1829	bi bi-trash2
1828	bi bi-trash2-fill
1831	bi bi-trash3
1830	bi bi-trash3-fill
1833	bi bi-tree
1832	bi bi-tree-fill
1834	bi bi-trello
1837	bi bi-triangle
1835	bi bi-triangle-fill
1836	bi bi-triangle-half
1839	bi bi-trophy
1838	bi bi-trophy-fill
1840	bi bi-tropical-storm
1844	bi bi-truck
1841	bi bi-truck-flatbed
1843	bi bi-truck-front
1842	bi bi-truck-front-fill
1845	bi bi-tsunami
1847	bi bi-tv
1846	bi bi-tv-fill
1848	bi bi-twitch
1849	bi bi-twitter
1857	bi bi-type
1850	bi bi-type-bold
1851	bi bi-type-h1
1852	bi bi-type-h2
1853	bi bi-type-h3
1854	bi bi-type-italic
1855	bi bi-type-strikethrough
1856	bi bi-type-underline
1858	bi bi-ubuntu
1860	bi bi-ui-checks
1859	bi bi-ui-checks-grid
1862	bi bi-ui-radios
1861	bi bi-ui-radios-grid
1864	bi bi-umbrella
1863	bi bi-umbrella-fill
1865	bi bi-unindent
1866	bi bi-union
1867	bi bi-unity
1869	bi bi-universal-access
1868	bi bi-universal-access-circle
1871	bi bi-unlock
1870	bi bi-unlock-fill
1873	bi bi-upc
1872	bi bi-upc-scan
1874	bi bi-upload
1887	bi bi-usb
1876	bi bi-usb-c
1875	bi bi-usb-c-fill
1878	bi bi-usb-drive
1877	bi bi-usb-drive-fill
1879	bi bi-usb-fill
1881	bi bi-usb-micro
1880	bi bi-usb-micro-fill
1883	bi bi-usb-mini
1882	bi bi-usb-mini-fill
1885	bi bi-usb-plug
1884	bi bi-usb-plug-fill
1886	bi bi-usb-symbol
1888	bi bi-valentine
1889	bi bi-valentine2
1890	bi bi-vector-pen
1891	bi bi-view-list
1892	bi bi-view-stacked
1893	bi bi-vimeo
1895	bi bi-vinyl
1894	bi bi-vinyl-fill
1896	bi bi-virus
1897	bi bi-virus2
1898	bi bi-voicemail
1900	bi bi-volume-down
1899	bi bi-volume-down-fill
1902	bi bi-volume-mute
1901	bi bi-volume-mute-fill
1904	bi bi-volume-off
1903	bi bi-volume-off-fill
1906	bi bi-volume-up
1905	bi bi-volume-up-fill
1907	bi bi-vr
1909	bi bi-wallet
1908	bi bi-wallet-fill
1910	bi bi-wallet2
1911	bi bi-watch
1912	bi bi-water
1914	bi bi-webcam
1913	bi bi-webcam-fill
1915	bi bi-wechat
1916	bi bi-whatsapp
1920	bi bi-wifi
1917	bi bi-wifi-1
1918	bi bi-wifi-2
1919	bi bi-wifi-off
1921	bi bi-wikipedia
1922	bi bi-wind
1932	bi bi-window
1923	bi bi-window-dash
1924	bi bi-window-desktop
1925	bi bi-window-dock
1926	bi bi-window-fullscreen
1927	bi bi-window-plus
1928	bi bi-window-sidebar
1929	bi bi-window-split
1930	bi bi-window-stack
1931	bi bi-window-x
1933	bi bi-windows
1934	bi bi-wordpress
1938	bi bi-wrench
1937	bi bi-wrench-adjustable
1936	bi bi-wrench-adjustable-circle
1935	bi bi-wrench-adjustable-circle-fill
1948	bi bi-x
1940	bi bi-x-circle
1939	bi bi-x-circle-fill
1942	bi bi-x-diamond
1941	bi bi-x-diamond-fill
1943	bi bi-x-lg
1945	bi bi-x-octagon
1944	bi bi-x-octagon-fill
1947	bi bi-x-square
1946	bi bi-x-square-fill
1949	bi bi-xbox
1950	bi bi-yelp
1951	bi bi-yin-yang
1952	bi bi-youtube
1953	bi bi-zoom-in
1954	bi bi-zoom-out
\.


--
-- TOC entry 3514 (class 0 OID 16712)
-- Dependencies: 238
-- Data for Name: t1; Type: TABLE DATA; Schema: public; Owner: t1
--

COPY public.t1 (id, i, str, n) FROM stdin;
1	54		0.00
\.


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 223
-- Name: admin_auth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: t1
--

SELECT pg_catalog.setval('public.admin_auth_id_seq', 2, true);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 221
-- Name: admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: t1
--

SELECT pg_catalog.setval('public.admin_id_seq', 3, true);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 225
-- Name: admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: t1
--

SELECT pg_catalog.setval('public.admin_log_id_seq', 26, true);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 227
-- Name: admin_node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: t1
--

SELECT pg_catalog.setval('public.admin_node_id_seq', 23, true);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 229
-- Name: alog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: t1
--

SELECT pg_catalog.setval('public.alog_id_seq', 1, true);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 231
-- Name: api_request_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: t1
--

SELECT pg_catalog.setval('public.api_request_log_id_seq', 2, true);


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 233
-- Name: app_secret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: t1
--

SELECT pg_catalog.setval('public.app_secret_id_seq', 1, true);


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 235
-- Name: icons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: t1
--

SELECT pg_catalog.setval('public.icons_id_seq', 1954, true);


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 237
-- Name: t1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: t1
--

SELECT pg_catalog.setval('public.t1_id_seq', 1, true);


--
-- TOC entry 3328 (class 2606 OID 16743)
-- Name: admin idx_16625_primary; Type: CONSTRAINT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT idx_16625_primary PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 16744)
-- Name: admin_auth idx_16641_primary; Type: CONSTRAINT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.admin_auth
    ADD CONSTRAINT idx_16641_primary PRIMARY KEY (id);


--
-- TOC entry 3335 (class 2606 OID 16742)
-- Name: admin_log idx_16651_primary; Type: CONSTRAINT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.admin_log
    ADD CONSTRAINT idx_16651_primary PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 16740)
-- Name: admin_node idx_16664_primary; Type: CONSTRAINT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.admin_node
    ADD CONSTRAINT idx_16664_primary PRIMARY KEY (id);


--
-- TOC entry 3341 (class 2606 OID 16747)
-- Name: alog idx_16679_primary; Type: CONSTRAINT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.alog
    ADD CONSTRAINT idx_16679_primary PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 16745)
-- Name: api_request_log idx_16687_primary; Type: CONSTRAINT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.api_request_log
    ADD CONSTRAINT idx_16687_primary PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 16748)
-- Name: app_secret idx_16697_primary; Type: CONSTRAINT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.app_secret
    ADD CONSTRAINT idx_16697_primary PRIMARY KEY (id);


--
-- TOC entry 3349 (class 2606 OID 16741)
-- Name: icons idx_16707_primary; Type: CONSTRAINT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.icons
    ADD CONSTRAINT idx_16707_primary PRIMARY KEY (id);


--
-- TOC entry 3351 (class 2606 OID 16746)
-- Name: t1 idx_16712_primary; Type: CONSTRAINT; Schema: public; Owner: t1
--

ALTER TABLE ONLY public.t1
    ADD CONSTRAINT idx_16712_primary PRIMARY KEY (id);


--
-- TOC entry 3329 (class 1259 OID 16730)
-- Name: idx_16625_username; Type: INDEX; Schema: public; Owner: t1
--

CREATE UNIQUE INDEX idx_16625_username ON public.admin USING btree (username);


--
-- TOC entry 3332 (class 1259 OID 16722)
-- Name: idx_16651_addtime; Type: INDEX; Schema: public; Owner: t1
--

CREATE INDEX idx_16651_addtime ON public.admin_log USING btree (addtime);


--
-- TOC entry 3333 (class 1259 OID 16727)
-- Name: idx_16651_admin_id; Type: INDEX; Schema: public; Owner: t1
--

CREATE INDEX idx_16651_admin_id ON public.admin_log USING btree (admin_id);


--
-- TOC entry 3336 (class 1259 OID 16721)
-- Name: idx_16664_is_menu; Type: INDEX; Schema: public; Owner: t1
--

CREATE INDEX idx_16664_is_menu ON public.admin_node USING btree (is_menu);


--
-- TOC entry 3339 (class 1259 OID 16720)
-- Name: idx_16664_status; Type: INDEX; Schema: public; Owner: t1
--

CREATE INDEX idx_16664_status ON public.admin_node USING btree (status);


--
-- TOC entry 3344 (class 1259 OID 16731)
-- Name: idx_16697_appid; Type: INDEX; Schema: public; Owner: t1
--

CREATE UNIQUE INDEX idx_16697_appid ON public.app_secret USING btree (appid);


--
-- TOC entry 3347 (class 1259 OID 16724)
-- Name: idx_16707_name; Type: INDEX; Schema: public; Owner: t1
--

CREATE UNIQUE INDEX idx_16707_name ON public.icons USING btree (name);


-- Completed on 2025-07-05 14:03:07 CST

--
-- PostgreSQL database dump complete
--


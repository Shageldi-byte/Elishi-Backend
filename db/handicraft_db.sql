PGDMP         (                z         
   handicraft    13.2    14.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    49274 
   handicraft    DATABASE     n   CREATE DATABASE handicraft WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE handicraft;
                postgres    false            �            1255    49442 '   add_category(text, text, text, integer)    FUNCTION     �  CREATE FUNCTION public.add_category(name_tm text, name_ru text, name_en text, category_status integer) RETURNS TABLE(category_name_tm text, category_name_ru text, category_name_en text, status integer, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
declare
	category_id integer;
begin 
	insert into category(id,category_name_tm,category_name_ru,status,created_at,updated_at) values(null,name_tm,
								  name_ru,
								  name_en,
								  category_status,
								  NOW()::timestamp,
								  NOW()::timestamp)
								  returning id into category_id;
	return query select * from category where id=category_id;
end; $$;
 f   DROP FUNCTION public.add_category(name_tm text, name_ru text, name_en text, category_status integer);
       public          postgres    false                       1255    49451 0   add_category(text, text, text, integer, boolean)    FUNCTION     �  CREATE FUNCTION public.add_category(name_tm text, name_ru text, name_en text, category_status integer, category_ismain boolean) RETURNS TABLE(category_name_tm text, category_name_ru text, category_name_en text, status integer, ismain boolean, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
declare
	category_id integer;
begin 
	insert into category(id,category_name_tm,category_name_ru,status,created_at,updated_at,is_main) values(null,name_tm,
								  name_ru,
								  name_en,
								  category_status,
								  NOW()::timestamp,
								  NOW()::timestamp,
								  category_isMain)
								  returning id into category_id;
	return query select * from category where id=category_id;
end; $$;
    DROP FUNCTION public.add_category(name_tm text, name_ru text, name_en text, category_status integer, category_ismain boolean);
       public          postgres    false                       1255    49487    getProducts()    FUNCTION     �  CREATE FUNCTION public."getProducts"() RETURNS void
    LANGUAGE sql
    AS $_$
CREATE FUNCTION getProductsFun() RETURNS setof refcursor AS
$$
DECLARE products refcursor;
DECLARE images refcursor;
BEGIN
    OPEN products FOR
        SELECT p.*
        FROM product p;
    RETURN NEXT products;
    OPEN images FOR
        SELECT c.*
        FROM product_images c;
    RETURN NEXT images;
END;
$$ LANGUAGE plpgsql;
$_$;
 &   DROP FUNCTION public."getProducts"();
       public          postgres    false            �            1259    49343    product    TABLE     �  CREATE TABLE public.product (
    id bigint NOT NULL,
    product_name text,
    price double precision,
    status integer,
    description text,
    sub_category_id integer NOT NULL,
    user_id integer NOT NULL,
    is_popular boolean NOT NULL,
    size text,
    phone_number text,
    updated_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    view_count integer,
    cancel_reason text
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1255    49489    getproducts()    FUNCTION     �   CREATE FUNCTION public.getproducts() RETURNS SETOF public.product
    LANGUAGE plpgsql
    AS $$
BEGIN

RETURN QUERY
SELECT * FROM product;

RETURN QUERY
SELECT * FROM product_images;   -- has to return same rowtype as first_table!

END
$$;
 $   DROP FUNCTION public.getproducts();
       public          postgres    false    213            �            1255    49490    getproductsfun()    FUNCTION     ]  CREATE FUNCTION public.getproductsfun() RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
DECLARE products refcursor;
DECLARE images refcursor;
BEGIN
    OPEN products FOR
        SELECT p.*
        FROM product p;
    RETURN NEXT products;
    OPEN images FOR
        SELECT c.*
        FROM product_images c;
    RETURN NEXT images;
END;
$$;
 '   DROP FUNCTION public.getproductsfun();
       public          postgres    false                       1255    82281 5   insert_admin_user(text, text, text, integer, integer) 	   PROCEDURE     O  CREATE PROCEDURE public.insert_admin_user(_username text, _password text, _token text, _status integer, _user_type_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO admin_user(username,password,token,status,created_at,updated_at,user_type_id) VALUES (_username,_password,_token,_status,now(),now(),_user_type_id);
END;
$$;
 ~   DROP PROCEDURE public.insert_admin_user(_username text, _password text, _token text, _status integer, _user_type_id integer);
       public          postgres    false            �            1255    49488    test()    FUNCTION     �   CREATE FUNCTION public.test() RETURNS SETOF public.product
    LANGUAGE plpgsql
    AS $$
BEGIN

RETURN QUERY
SELECT * FROM product;

RETURN QUERY
SELECT * FROM product_images;   -- has to return same rowtype as first_table!

END
$$;
    DROP FUNCTION public.test();
       public          postgres    false    213            �            1259    49504    today_product    TABLE     �   CREATE TABLE public.today_product (
    id bigint NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 !   DROP TABLE public.today_product;
       public         heap    postgres    false            �            1259    49502    TodayProduct_id_seq    SEQUENCE     ~   CREATE SEQUENCE public."TodayProduct_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."TodayProduct_id_seq";
       public          postgres    false    235            �           0    0    TodayProduct_id_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public."TodayProduct_id_seq" OWNED BY public.today_product.id;
          public          postgres    false    234            �            1259    49454 
   admin_user    TABLE     6  CREATE TABLE public.admin_user (
    id bigint NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    token text NOT NULL,
    status integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_type_id integer NOT NULL
);
    DROP TABLE public.admin_user;
       public         heap    postgres    false            �            1259    49452    admin_user_id_seq    SEQUENCE     z   CREATE SEQUENCE public.admin_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.admin_user_id_seq;
       public          postgres    false    231            �           0    0    admin_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.admin_user_id_seq OWNED BY public.admin_user.id;
          public          postgres    false    230            �            1259    82261    ads    TABLE     �   CREATE TABLE public.ads (
    id bigint NOT NULL,
    ads_image text,
    site_url text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    status text,
    constant_id text
);
    DROP TABLE public.ads;
       public         heap    postgres    false            �            1259    82259 
   ads_id_seq    SEQUENCE     s   CREATE SEQUENCE public.ads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.ads_id_seq;
       public          postgres    false    239            �           0    0 
   ads_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE public.ads_id_seq OWNED BY public.ads.id;
          public          postgres    false    238            �            1259    49365    banner    TABLE       CREATE TABLE public.banner (
    id bigint NOT NULL,
    banner_image_tm text,
    banner_image_ru text,
    banner_image_en text,
    "order" integer,
    status integer,
    "siteURL" text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.banner;
       public         heap    postgres    false            �            1259    49363    banner_id_seq    SEQUENCE     v   CREATE SEQUENCE public.banner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.banner_id_seq;
       public          postgres    false    217            �           0    0    banner_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.banner_id_seq OWNED BY public.banner.id;
          public          postgres    false    216            �            1259    82284 
   blocked_ip    TABLE     �   CREATE TABLE public.blocked_ip (
    id bigint NOT NULL,
    ip_addr text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status integer
);
    DROP TABLE public.blocked_ip;
       public         heap    postgres    false            �            1259    82282    blocked_ip_id_seq    SEQUENCE     z   CREATE SEQUENCE public.blocked_ip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.blocked_ip_id_seq;
       public          postgres    false    241            �           0    0    blocked_ip_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.blocked_ip_id_seq OWNED BY public.blocked_ip.id;
          public          postgres    false    240            �            1259    49321    category    TABLE     Z  CREATE TABLE public.category (
    id bigint NOT NULL,
    category_name_tm text NOT NULL,
    category_name_ru text NOT NULL,
    category_name_en text NOT NULL,
    status integer NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_main boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    image text
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    49319    category_id_seq    SEQUENCE     x   CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    209            �           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    208            �            1259    49407    congratulations    TABLE     1  CREATE TABLE public.congratulations (
    id bigint NOT NULL,
    text text NOT NULL,
    status integer NOT NULL,
    user_id integer NOT NULL,
    holiday_id integer NOT NULL,
    title text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);
 #   DROP TABLE public.congratulations;
       public         heap    postgres    false            �            1259    49405    congratulations_id_seq    SEQUENCE        CREATE SEQUENCE public.congratulations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.congratulations_id_seq;
       public          postgres    false    225            �           0    0    congratulations_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.congratulations_id_seq OWNED BY public.congratulations.id;
          public          postgres    false    224            �            1259    49385    constant_page    TABLE     �  CREATE TABLE public.constant_page (
    id bigint NOT NULL,
    "titleTM" text NOT NULL,
    "titleRU" text NOT NULL,
    "titleEN" text NOT NULL,
    content_light_tm text NOT NULL,
    content_light_ru text NOT NULL,
    content_light_en text NOT NULL,
    content_dark_tm text NOT NULL,
    content_dark_ru text NOT NULL,
    content_dark_en text NOT NULL,
    page_type text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);
 !   DROP TABLE public.constant_page;
       public         heap    postgres    false            �            1259    49383    constant_page_id_seq    SEQUENCE     }   CREATE SEQUENCE public.constant_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.constant_page_id_seq;
       public          postgres    false    221            �           0    0    constant_page_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.constant_page_id_seq OWNED BY public.constant_page.id;
          public          postgres    false    220            �            1259    49310    district    TABLE     �   CREATE TABLE public.district (
    id bigint NOT NULL,
    district_name_tm text NOT NULL,
    district_name_ru text NOT NULL,
    district_name_en text NOT NULL,
    region_id integer NOT NULL
);
    DROP TABLE public.district;
       public         heap    postgres    false            �            1259    49308    district_id_seq    SEQUENCE     x   CREATE SEQUENCE public.district_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.district_id_seq;
       public          postgres    false    207            �           0    0    district_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.district_id_seq OWNED BY public.district.id;
          public          postgres    false    206            �            1259    49418    event    TABLE     r  CREATE TABLE public.event (
    id bigint NOT NULL,
    title_tm text NOT NULL,
    title_ru text NOT NULL,
    title_en text NOT NULL,
    event_image text,
    url text,
    status integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    event_type text,
    go_id integer,
    is_main integer
);
    DROP TABLE public.event;
       public         heap    postgres    false            �            1259    49416    event_id_seq    SEQUENCE     u   CREATE SEQUENCE public.event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.event_id_seq;
       public          postgres    false    227            �           0    0    event_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.event_id_seq OWNED BY public.event.id;
          public          postgres    false    226            �            1259    74089    event_products    TABLE     �   CREATE TABLE public.event_products (
    product_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    event_id integer NOT NULL,
    id bigint NOT NULL
);
 "   DROP TABLE public.event_products;
       public         heap    postgres    false            �            1259    74095    event_products_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.event_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.event_products_id_seq;
       public          postgres    false    236            �           0    0    event_products_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.event_products_id_seq OWNED BY public.event_products.id;
          public          postgres    false    237            �            1259    49377    favorite    TABLE     �   CREATE TABLE public.favorite (
    id bigint NOT NULL,
    product_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);
    DROP TABLE public.favorite;
       public         heap    postgres    false            �            1259    49375    favorite_id_seq    SEQUENCE     x   CREATE SEQUENCE public.favorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.favorite_id_seq;
       public          postgres    false    219            �           0    0    favorite_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.favorite_id_seq OWNED BY public.favorite.id;
          public          postgres    false    218            �            1259    49396    holiday    TABLE     �   CREATE TABLE public.holiday (
    id bigint NOT NULL,
    holiday_name_tm text NOT NULL,
    holiday_name_ru text NOT NULL,
    holiday_name_en text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.holiday;
       public         heap    postgres    false            �            1259    49394    holiday_id_seq    SEQUENCE     w   CREATE SEQUENCE public.holiday_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.holiday_id_seq;
       public          postgres    false    223            �           0    0    holiday_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.holiday_id_seq OWNED BY public.holiday.id;
          public          postgres    false    222            �            1259    49277    mobile_users    TABLE     �  CREATE TABLE public.mobile_users (
    id bigint NOT NULL,
    fullname text,
    address text,
    phone_number text,
    profile_image text,
    user_type_id integer,
    region_id integer,
    email text NOT NULL,
    notification_token text,
    gender integer NOT NULL,
    status integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    token text
);
     DROP TABLE public.mobile_users;
       public         heap    postgres    false            �            1259    49429    phone_verification    TABLE     �   CREATE TABLE public.phone_verification (
    id bigint NOT NULL,
    phone_number text NOT NULL,
    code text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 &   DROP TABLE public.phone_verification;
       public         heap    postgres    false            �            1259    49427    phone_verification_id_seq    SEQUENCE     �   CREATE SEQUENCE public.phone_verification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.phone_verification_id_seq;
       public          postgres    false    229            �           0    0    phone_verification_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.phone_verification_id_seq OWNED BY public.phone_verification.id;
          public          postgres    false    228            �            1259    49341    product_id_seq    SEQUENCE     w   CREATE SEQUENCE public.product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          postgres    false    213            �           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          postgres    false    212            �            1259    49354    product_images    TABLE       CREATE TABLE public.product_images (
    id bigint NOT NULL,
    small_image text,
    large_image text,
    product_id integer NOT NULL,
    is_first boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);
 "   DROP TABLE public.product_images;
       public         heap    postgres    false            �            1259    49352    product_images_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.product_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.product_images_id_seq;
       public          postgres    false    215            �           0    0    product_images_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.product_images_id_seq OWNED BY public.product_images.id;
          public          postgres    false    214            �            1259    49299    region    TABLE     �   CREATE TABLE public.region (
    id bigint NOT NULL,
    region_name_tm text NOT NULL,
    region_name_ru text NOT NULL,
    region_name_en text NOT NULL
);
    DROP TABLE public.region;
       public         heap    postgres    false            �            1259    49297    region_id_seq    SEQUENCE     v   CREATE SEQUENCE public.region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.region_id_seq;
       public          postgres    false    205            �           0    0    region_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.region_id_seq OWNED BY public.region.id;
          public          postgres    false    204            �            1259    49332    sub_category    TABLE     h  CREATE TABLE public.sub_category (
    id bigint NOT NULL,
    sub_category_name_tm text NOT NULL,
    sub_category_name_ru text NOT NULL,
    sub_category_name_en text NOT NULL,
    category_id integer NOT NULL,
    status integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    image text
);
     DROP TABLE public.sub_category;
       public         heap    postgres    false            �            1259    49330    sub_categoy_id_seq    SEQUENCE     {   CREATE SEQUENCE public.sub_categoy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.sub_categoy_id_seq;
       public          postgres    false    211            �           0    0    sub_categoy_id_seq    SEQUENCE OWNED BY     J   ALTER SEQUENCE public.sub_categoy_id_seq OWNED BY public.sub_category.id;
          public          postgres    false    210            �            1259    49275    user_id_seq    SEQUENCE     t   CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public          postgres    false    201            �           0    0    user_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.user_id_seq OWNED BY public.mobile_users.id;
          public          postgres    false    200            �            1259    49288 	   user_type    TABLE     r   CREATE TABLE public.user_type (
    id bigint NOT NULL,
    user_type text,
    product_limit integer NOT NULL
);
    DROP TABLE public.user_type;
       public         heap    postgres    false            �            1259    49286    user_type_id_seq    SEQUENCE     y   CREATE SEQUENCE public.user_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.user_type_id_seq;
       public          postgres    false    203            �           0    0    user_type_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.user_type_id_seq OWNED BY public.user_type.id;
          public          postgres    false    202            �            1259    49493    vars    TABLE     T   CREATE TABLE public.vars (
    id bigint NOT NULL,
    type text,
    value text
);
    DROP TABLE public.vars;
       public         heap    postgres    false            �            1259    49491    vars_id_seq    SEQUENCE     t   CREATE SEQUENCE public.vars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.vars_id_seq;
       public          postgres    false    233            �           0    0    vars_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.vars_id_seq OWNED BY public.vars.id;
          public          postgres    false    232            �           2604    49457    admin_user id    DEFAULT     n   ALTER TABLE ONLY public.admin_user ALTER COLUMN id SET DEFAULT nextval('public.admin_user_id_seq'::regclass);
 <   ALTER TABLE public.admin_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    230    231            �           2604    82264    ads id    DEFAULT     `   ALTER TABLE ONLY public.ads ALTER COLUMN id SET DEFAULT nextval('public.ads_id_seq'::regclass);
 5   ALTER TABLE public.ads ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    239    238    239            �           2604    49368 	   banner id    DEFAULT     f   ALTER TABLE ONLY public.banner ALTER COLUMN id SET DEFAULT nextval('public.banner_id_seq'::regclass);
 8   ALTER TABLE public.banner ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    82287    blocked_ip id    DEFAULT     n   ALTER TABLE ONLY public.blocked_ip ALTER COLUMN id SET DEFAULT nextval('public.blocked_ip_id_seq'::regclass);
 <   ALTER TABLE public.blocked_ip ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    241    240    241            �           2604    49324    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209            �           2604    49410    congratulations id    DEFAULT     x   ALTER TABLE ONLY public.congratulations ALTER COLUMN id SET DEFAULT nextval('public.congratulations_id_seq'::regclass);
 A   ALTER TABLE public.congratulations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    49388    constant_page id    DEFAULT     t   ALTER TABLE ONLY public.constant_page ALTER COLUMN id SET DEFAULT nextval('public.constant_page_id_seq'::regclass);
 ?   ALTER TABLE public.constant_page ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            �           2604    49313    district id    DEFAULT     j   ALTER TABLE ONLY public.district ALTER COLUMN id SET DEFAULT nextval('public.district_id_seq'::regclass);
 :   ALTER TABLE public.district ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    206    207            �           2604    49421    event id    DEFAULT     d   ALTER TABLE ONLY public.event ALTER COLUMN id SET DEFAULT nextval('public.event_id_seq'::regclass);
 7   ALTER TABLE public.event ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            �           2604    74097    event_products id    DEFAULT     v   ALTER TABLE ONLY public.event_products ALTER COLUMN id SET DEFAULT nextval('public.event_products_id_seq'::regclass);
 @   ALTER TABLE public.event_products ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    236            �           2604    49380    favorite id    DEFAULT     j   ALTER TABLE ONLY public.favorite ALTER COLUMN id SET DEFAULT nextval('public.favorite_id_seq'::regclass);
 :   ALTER TABLE public.favorite ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    49399 
   holiday id    DEFAULT     h   ALTER TABLE ONLY public.holiday ALTER COLUMN id SET DEFAULT nextval('public.holiday_id_seq'::regclass);
 9   ALTER TABLE public.holiday ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            �           2604    49280    mobile_users id    DEFAULT     j   ALTER TABLE ONLY public.mobile_users ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);
 >   ALTER TABLE public.mobile_users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    200    201    201            �           2604    49432    phone_verification id    DEFAULT     ~   ALTER TABLE ONLY public.phone_verification ALTER COLUMN id SET DEFAULT nextval('public.phone_verification_id_seq'::regclass);
 D   ALTER TABLE public.phone_verification ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    49346 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212    213            �           2604    49357    product_images id    DEFAULT     v   ALTER TABLE ONLY public.product_images ALTER COLUMN id SET DEFAULT nextval('public.product_images_id_seq'::regclass);
 @   ALTER TABLE public.product_images ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    49302 	   region id    DEFAULT     f   ALTER TABLE ONLY public.region ALTER COLUMN id SET DEFAULT nextval('public.region_id_seq'::regclass);
 8   ALTER TABLE public.region ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    204    205    205            �           2604    49335    sub_category id    DEFAULT     q   ALTER TABLE ONLY public.sub_category ALTER COLUMN id SET DEFAULT nextval('public.sub_categoy_id_seq'::regclass);
 >   ALTER TABLE public.sub_category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            �           2604    49507    today_product id    DEFAULT     u   ALTER TABLE ONLY public.today_product ALTER COLUMN id SET DEFAULT nextval('public."TodayProduct_id_seq"'::regclass);
 ?   ALTER TABLE public.today_product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    235    235            �           2604    49291    user_type id    DEFAULT     l   ALTER TABLE ONLY public.user_type ALTER COLUMN id SET DEFAULT nextval('public.user_type_id_seq'::regclass);
 ;   ALTER TABLE public.user_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            �           2604    49496    vars id    DEFAULT     b   ALTER TABLE ONLY public.vars ALTER COLUMN id SET DEFAULT nextval('public.vars_id_seq'::regclass);
 6   ALTER TABLE public.vars ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    233    233            �          0    49454 
   admin_user 
   TABLE DATA           q   COPY public.admin_user (id, username, password, token, status, created_at, updated_at, user_type_id) FROM stdin;
    public          postgres    false    231   ��       �          0    82261    ads 
   TABLE DATA           c   COPY public.ads (id, ads_image, site_url, created_at, updated_at, status, constant_id) FROM stdin;
    public          postgres    false    239   .�       �          0    49365    banner 
   TABLE DATA           �   COPY public.banner (id, banner_image_tm, banner_image_ru, banner_image_en, "order", status, "siteURL", created_at, updated_at) FROM stdin;
    public          postgres    false    217   �       �          0    82284 
   blocked_ip 
   TABLE DATA           Q   COPY public.blocked_ip (id, ip_addr, created_at, updated_at, status) FROM stdin;
    public          postgres    false    241   �       {          0    49321    category 
   TABLE DATA           �   COPY public.category (id, category_name_tm, category_name_ru, category_name_en, status, updated_at, is_main, created_at, image) FROM stdin;
    public          postgres    false    209   ,�       �          0    49407    congratulations 
   TABLE DATA           o   COPY public.congratulations (id, text, status, user_id, holiday_id, title, created_at, updated_at) FROM stdin;
    public          postgres    false    225   ��       �          0    49385    constant_page 
   TABLE DATA           �   COPY public.constant_page (id, "titleTM", "titleRU", "titleEN", content_light_tm, content_light_ru, content_light_en, content_dark_tm, content_dark_ru, content_dark_en, page_type, created_at, updated_at) FROM stdin;
    public          postgres    false    221   ��       y          0    49310    district 
   TABLE DATA           g   COPY public.district (id, district_name_tm, district_name_ru, district_name_en, region_id) FROM stdin;
    public          postgres    false    207   4�       �          0    49418    event 
   TABLE DATA           �   COPY public.event (id, title_tm, title_ru, title_en, event_image, url, status, created_at, updated_at, event_type, go_id, is_main) FROM stdin;
    public          postgres    false    227   s�       �          0    74089    event_products 
   TABLE DATA           Z   COPY public.event_products (product_id, created_at, updated_at, event_id, id) FROM stdin;
    public          postgres    false    236   ��       �          0    49377    favorite 
   TABLE DATA           S   COPY public.favorite (id, product_id, user_id, created_at, updated_at) FROM stdin;
    public          postgres    false    219   _�       �          0    49396    holiday 
   TABLE DATA           p   COPY public.holiday (id, holiday_name_tm, holiday_name_ru, holiday_name_en, created_at, updated_at) FROM stdin;
    public          postgres    false    223   ��       s          0    49277    mobile_users 
   TABLE DATA           �   COPY public.mobile_users (id, fullname, address, phone_number, profile_image, user_type_id, region_id, email, notification_token, gender, status, created_at, updated_at, token) FROM stdin;
    public          postgres    false    201   2�       �          0    49429    phone_verification 
   TABLE DATA           \   COPY public.phone_verification (id, phone_number, code, created_at, updated_at) FROM stdin;
    public          postgres    false    229   ��                 0    49343    product 
   TABLE DATA           �   COPY public.product (id, product_name, price, status, description, sub_category_id, user_id, is_popular, size, phone_number, updated_at, created_at, view_count, cancel_reason) FROM stdin;
    public          postgres    false    213   G�       �          0    49354    product_images 
   TABLE DATA           t   COPY public.product_images (id, small_image, large_image, product_id, is_first, created_at, updated_at) FROM stdin;
    public          postgres    false    215   �       w          0    49299    region 
   TABLE DATA           T   COPY public.region (id, region_name_tm, region_name_ru, region_name_en) FROM stdin;
    public          postgres    false    205   �      }          0    49332    sub_category 
   TABLE DATA           �   COPY public.sub_category (id, sub_category_name_tm, sub_category_name_ru, sub_category_name_en, category_id, status, created_at, updated_at, image) FROM stdin;
    public          postgres    false    211   ?      �          0    49504    today_product 
   TABLE DATA           O   COPY public.today_product (id, product_id, created_at, updated_at) FROM stdin;
    public          postgres    false    235   �      u          0    49288 	   user_type 
   TABLE DATA           A   COPY public.user_type (id, user_type, product_limit) FROM stdin;
    public          postgres    false    203         �          0    49493    vars 
   TABLE DATA           /   COPY public.vars (id, type, value) FROM stdin;
    public          postgres    false    233   U      �           0    0    TodayProduct_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."TodayProduct_id_seq"', 1, false);
          public          postgres    false    234            �           0    0    admin_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.admin_user_id_seq', 330, true);
          public          postgres    false    230            �           0    0 
   ads_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.ads_id_seq', 28, true);
          public          postgres    false    238            �           0    0    banner_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.banner_id_seq', 34, true);
          public          postgres    false    216            �           0    0    blocked_ip_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.blocked_ip_id_seq', 1, false);
          public          postgres    false    240            �           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 33, true);
          public          postgres    false    208            �           0    0    congratulations_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.congratulations_id_seq', 11, true);
          public          postgres    false    224            �           0    0    constant_page_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.constant_page_id_seq', 7, true);
          public          postgres    false    220            �           0    0    district_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.district_id_seq', 7, true);
          public          postgres    false    206            �           0    0    event_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.event_id_seq', 13, true);
          public          postgres    false    226            �           0    0    event_products_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.event_products_id_seq', 19, true);
          public          postgres    false    237            �           0    0    favorite_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.favorite_id_seq', 15, true);
          public          postgres    false    218            �           0    0    holiday_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.holiday_id_seq', 46, true);
          public          postgres    false    222            �           0    0    phone_verification_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.phone_verification_id_seq', 18, true);
          public          postgres    false    228            �           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 26, true);
          public          postgres    false    212            �           0    0    product_images_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.product_images_id_seq', 104, true);
          public          postgres    false    214            �           0    0    region_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.region_id_seq', 11, true);
          public          postgres    false    204            �           0    0    sub_categoy_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.sub_categoy_id_seq', 108, true);
          public          postgres    false    210            �           0    0    user_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.user_id_seq', 150, true);
          public          postgres    false    200            �           0    0    user_type_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.user_type_id_seq', 9, true);
          public          postgres    false    202            �           0    0    vars_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.vars_id_seq', 5, true);
          public          postgres    false    232            �           2606    49509    today_product TodayProduct_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.today_product
    ADD CONSTRAINT "TodayProduct_pkey" PRIMARY KEY (id);
 K   ALTER TABLE ONLY public.today_product DROP CONSTRAINT "TodayProduct_pkey";
       public            postgres    false    235            �           2606    49462    admin_user admin_user_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.admin_user
    ADD CONSTRAINT admin_user_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.admin_user DROP CONSTRAINT admin_user_pkey;
       public            postgres    false    231            �           2606    82269    ads ads_pkey 
   CONSTRAINT     J   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_pkey;
       public            postgres    false    239            �           2606    49373    banner banner_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.banner
    ADD CONSTRAINT banner_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.banner DROP CONSTRAINT banner_pkey;
       public            postgres    false    217            �           2606    82292    blocked_ip blocked_ip_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.blocked_ip
    ADD CONSTRAINT blocked_ip_pkey PRIMARY KEY (id, created_at, updated_at);
 D   ALTER TABLE ONLY public.blocked_ip DROP CONSTRAINT blocked_ip_pkey;
       public            postgres    false    241    241    241            �           2606    49329    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    209            �           2606    49415 $   congratulations congratulations_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.congratulations
    ADD CONSTRAINT congratulations_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.congratulations DROP CONSTRAINT congratulations_pkey;
       public            postgres    false    225            �           2606    49393     constant_page constant_page_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.constant_page
    ADD CONSTRAINT constant_page_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.constant_page DROP CONSTRAINT constant_page_pkey;
       public            postgres    false    221            �           2606    49318    district district_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.district
    ADD CONSTRAINT district_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.district DROP CONSTRAINT district_pkey;
       public            postgres    false    207            �           2606    49426    event event_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.event DROP CONSTRAINT event_pkey;
       public            postgres    false    227            �           2606    74102 "   event_products event_products_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.event_products
    ADD CONSTRAINT event_products_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.event_products DROP CONSTRAINT event_products_pkey;
       public            postgres    false    236            �           2606    49382    favorite favorite_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT favorite_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.favorite DROP CONSTRAINT favorite_pkey;
       public            postgres    false    219            �           2606    49404    holiday holiday_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.holiday
    ADD CONSTRAINT holiday_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.holiday DROP CONSTRAINT holiday_pkey;
       public            postgres    false    223            �           2606    49437 *   phone_verification phone_verification_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.phone_verification
    ADD CONSTRAINT phone_verification_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.phone_verification DROP CONSTRAINT phone_verification_pkey;
       public            postgres    false    229            �           2606    49362 "   product_images product_images_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.product_images DROP CONSTRAINT product_images_pkey;
       public            postgres    false    215            �           2606    49351    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    213            �           2606    49307    region region_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.region DROP CONSTRAINT region_pkey;
       public            postgres    false    205            �           2606    49340    sub_category sub_categoy_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.sub_category
    ADD CONSTRAINT sub_categoy_pkey PRIMARY KEY (id);
 G   ALTER TABLE ONLY public.sub_category DROP CONSTRAINT sub_categoy_pkey;
       public            postgres    false    211            �           2606    49296    user_type user_type_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.user_type
    ADD CONSTRAINT user_type_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.user_type DROP CONSTRAINT user_type_pkey;
       public            postgres    false    203            �           2606    49501    vars vars_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.vars
    ADD CONSTRAINT vars_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.vars DROP CONSTRAINT vars_pkey;
       public            postgres    false    233            �   �  x���ێ$�E�����T�/�fa=ր���%l�i.6����޻;��1�2�/�æ:kEĉ��j��_���=�)���I|�BJOC~��;�=+�Y�[���KKRR�%�#���$��LGI�<�ma���dIUI*!�|@�Ӕ�ZCv�6CH�J�1�3���%���*�R��6g����~������}�����Ű�2Kq������
�z�C9B�2σ�s���/�oP�Ġ$���s�� �|�iKmNO���t>����?� �|��z���<BH:�1oa�\�$CH:�(�!��'�I�r��vMO%CH���H��!Iл`T�Нir!$	~�-�ئ��!L%��ek!��'�I��e��ew�¼t��a6����$-��$���a���Y`I�h�[)17�3�$a�`��5g�B�0Z0K�\3!I-�+�2=�c�kk��KCH�
V�ٚ�0-�$a��-��!q��%c�o���=�!I+}�����s��$>�8�h�g2�$���K�x$��[���=+!I�{B�T��dI��Kl��M��$>�:�={ߜ!$	��m��������2l�Qw���ʥ���B��kI'a�ouxͮ!$	�G��y��$lx�V�h��L;B���I\S�6��$lx�Zdo�bI��=F�CH�<h����_gI��茖��$8������R.U0<o�Ğ��!$	������B�`x�d�]�!I0�lh���9BH/���!I0�#�kII��e��r��$^��{����$^�֔6����Q>��v��gyW�v�����q1fK�u2�$a�t��t��$���Et�^����т�8⼒�$��c����B�0Z��bjͳ���т�R�;�B�0ZP^k�vv!I-h��jy�ͅ�$���>��iG�2$�s.��K/�$��\Z��I��5���㆐$9�JA�u��$9�j�y!Ir��ҽ�~!$I��敏tO�#�3:-?hGH��y^��v�$�p\�Z}/wT.S2�[��1�$��P�&CH�z�p��$����eI���~h�M�!$	���E�O��!I0�9dw�cI���|�ѽSڅ�$8�m|���dI���u^�L���䨇3���B��,ǐp����A��c��6b�%Y>c��i�B��4�h#��1J�|�6�1J����Eb�`��T4��,b��:�Sś\1Jp}�d{z�x/Ip}n�w��^1Jp��f��2�(�v�cW��G� �u��� a�`:�g-�aG�L�[Ʀ�]C1J0�=��!FI��^��[0�(��<r���%����=�z$��)y^j�ג�$�K���b��y�ɿ�o�Q�魌vŪ1Jr����6��$�[�ûϱ�$���~�`�Q��=���/�%��e�^6;b����بW��ǟ۞�j�vFt�:��Hު���]g}��Sa!F����}AbԹ��%��y!F�����i�1�����1�CŅu�:�k
�[�bԹ���XT��j!F����܇7/�'F$���]�Q��ؼ�i��%�>K��M��%���9�kgb�`;�G���^�K$��f��=]���Q��;/b��z�*�]���B�\�\R�ׂ.�(���%%�'��&�u�c��uV1Jp���zT�\G}�ÝC1Jr=A����$�����1/�(�v|����/�(��rw�C��l�^Ƿ�$�G��Fa����ß��;��Yr�2��Q��blx��!F	�'l�sw�uC�\G}�;�_�Q��	�bw�f�A��(�c���!F	��Y��	� 1J0=my���,�(���������B�\G}	�ʧ��\G}��;.^�Q��o����!FI�7L�G�A��-��=���$�[��ʟ�#FI��Ƶ��1Jr��R�	��$��@��[�#FI��Y���]�Q���ڤ��)O�A��Rp{=C��<��d� 1J�<o!T��n#<Gy��]g1J�<o����b��y�؎{O,�(��!6݇�b��9�s��1J���}����3��c�O���	04��Q�騟��� 1J2}$>�p�%�^xf���b��:���B�\/|�b��za�S�!b��:�g�[�1Jp�`���b�`;�[uo�-�7?�Q�����Q����qw�%�^�ZЉ{�b�d{-ӽg��$�kE��+�#FI���?���$�[��ʵ��$۱�Ϡ.�(����	�IfG��lo3����v�d{Þ�=�2�(����tb�Q��u#�Sb�`;��zo�,�(����0���B�l�����&���Q����{�b�`{��_�Y��%�^7��MȆ%�^��ݧE��7�u����,�(�u��vE�1Jr�`�� 2�(���;?I�c�ݝ�!FI�W�"FI�׊��1J2���ܖ��$�+�w/w!FI����g��{���تw����$����1b����=5���$����1�(���j����$�'vCע����5�����Q߃����Y?����B�loX3y����a�v��͢+Q�Q����ٿ]m�Q����=�1�(����j���%؎��;�b�`;�{�H$�^K�n�g�Q��w5�(�u��=0�(���>̝��v��fs��1Jr}���C��\�hQ�3>C�\�[�蠼o���;�Y��.C�\�aɿk�Q��|c)`�>B�lG=�.nKd�Q����e��jG�lG}ons�H����|�	;���Q��|A�^�L�A��(/�=�z$�<�-cm:B��<�}��$�GM�ʀ������(C�,����b�`9�;߰>B�,[�o&y��D���\{�~-�(�s�7_�G� �s�������ǖCq��G� ��>��Qb�`:_�J����$�1��?���$�[��1J2���;�1J2��޽w����H��8��r�B��LG��ܖ��$���[�G� ��9+v�G�Q��su�y��%���^�{����Q?�t�?C�\G���Jb��:��%�T0�(�u����/,	����;�1Jp��/��e���'��|��1J������e��$�s���z��L�qｃ�%�ް�rM1J2���Y��$�G�~om�Q��<�qw��`禗�A���
1��t�c�z{n#:����]ߍ0��r�g4)ރ1��r֣��n�,Ĩs�Y�=K�#F���z̶ޝɅun�}}��>�bԹ�/hN�Ey!F�������B��:��҆�*/�(��2B��[�Q��؝{Ϗa��:v�m���Q��U��b��z�mb��z�=]��;b��z��}$c!FI��:ݳ��%�>�t:�o(J������@$�>y�41J2�/��C�(���ݿW�	j�Q�����[�b��:�)��!F	��޽Cf�A��J��r1J0=��q-�1J0=�p��������q+���B�����}}��-��|���7_�������7��z?��������wo���?����sCQ|�>}{���滻�7��p��%?���Ϟ����|���wz��_�~��>���o�Bȋ��-���/�9l���'_�}����۟?z����7�������p���?�?�|��x{�K���n�LOS~'%�t�����~��E����r���uo�      �   �   x���In�0E�����*�>DN�rhD[���	��w%�D"YԢ���>�loc����s���kڔ��S0�S����y�GŖi �Z�5p��;K�Z�Pbfݜ�=��{ls\k_揶fNP R���PA� ���J���6��iJ��ڠ�S�H����b5�C���h�1����,Z�|ݺڎ�=������C��rⷂ���{)�>��
���4��Fu;      �   �   x���Kn�0��5�"�=�6g�9)MQ�C�z��d�E�j�O����q��۫[����'wI}�d��ޛ����P*&dC1F"�cۓyy���p��/��/�#����P_|��8�έ�j�~��-��^����ܥ���]��&���@@4 ��K-Z{� �K�Y��G�R	$h�b��p��de���G�<%���'�=%�'�<�X��Ơ���7[��/�٥�      �      x������ � �      {   z  x���MK�P��w~E�@�9��fז��.\�e7q�3�D棃])n
]��R���
n�Q�Mp�z2"�M	�x��ޗ+�Q��ٰ��,���'L�p.ث�30d8�A� "�)Ȕ��
R��b(b��T(�'NI�-�my{m�W���`��}���u��Ǩ�uA�ml�4(�a��붸a��jU��iދ��NIp��nꃈ��/��&\�	{]�zZզUK�&�"qNj%Xg�V�D:��D˵����HTV��r�������pI�&�'����0eo�����w�u���|Y�L�'J�f�(��,h���F#}���`o}QT'Q�W���f�I/��kct&Q8'�W���Gl���v}o8�:e?�����>�B��T�В�{�+���D�R�AY��I)�sgر����Μ�'�>�s�^�p� !F�RiSiDn5_N]���:p���:�y��rP���e�լ����tޝ�>���fӝw��J,:o��\,E�S.T@�~�@�u�B������gV��D_)��0��>jZ]f��m?��|�5G�Hp4��"DB��S� ���(��ZTE�������<�_�u�8|�F9��W��D����*�T�	��#֠��K��9B[yW��I���5�E      �   �  x�mV�n�F<���ݵ%'�Ib�A']f�Y��ᐞ���קz^�6$�3������t�}qz&^}�i\���s 5��ѰX���Ct�F^�l'҆CO���^�@.����L:�M���h���߁�7����Y�tGW5�a�x2�Bj����W6�ӟѯڎ�&(,�ʏ�>E;�dT�+�|y���j��7�i��x�Ш[�(��*:���갬��hըH�5��%:ua��!ߔT#rH�t�qb),%A���e$����>�O�T8_�[���gK@�W��b�1(O{��5�&����}����YjD���3�:���eo:�z VC4_�9r��A�>XJ�[�k� Hb@wn�H�tru �
��x=K ���%���\�.>j�	
A/-nO�.R�m11���Ҭ��W!Bz���%�EW��7�49uc!���D���%�6z�M���8	�ϐg ��k����
ʓ�DW(��~𢭆�W�����EE�{��P`�7A.�
�,J"�h��%�4r���?^ �mL�EƯR)�mb�N&���$%j��E��Zy�M�6Ȑ��B�)�����N<wY���:���&O�(%�5*��;��k��c��.t(�U�2�E mx�ZY۝5�kI���d��EW�-�&�j�6 �q �#jl�i6��Yy�^�)ݛkp6/!�&"�qX�U,e�RSF/I�w�&��$�w�z_XgJ�JPF�W�Ӥ�,+m��ᓇ1u����\yW1��-,�x��ZP��ޞ}��N�\_��K���Kf��V�k����~��[�����I
�)�qP(�^��-\Fj�֑о˴ǐ%�V\6��Z}U�n~v^e1��Yhz9�n�;�[֤�8����<}��F��mѯHJ�s2�bN�#MD�yWP�(�a����,�k�6bt�5�`,:l��}X:9ڦ��"$�Q&l���"��E� �5ϲe�s�(��c��������:�N(�;3׸�k��WF�����k�e��h���� =K]��\n�
�ɟA@����wh�� S>),�r,�BD���^-��R�SY��&(�@�m����R:�o%}��2�me7�Ω�g�n@%q����u1���[��e��|ڂ��?����û��_�?M߾���|<��߾9����x<>�;���?��?�p������|��?�?���Sww�?9��      �      x��\Oo�?ǟb�C�%+��(�ڤ(��OIxY���z���]�]�l+��Z�
7-�ԉ�V�OY�)����˯�O����,��]��HY�'F��rw������o��w�Pu�@s���5���t9���i�i���v��[ᇗWn��Wu�ЗU��-3�(�{���_]�~���f��mZ�{�ׂ���Y����h�m�^`�yc���Rro��VN����'���s�����^�v�m�&�yU��G�C��Sw+0LY�u�ގ�~��4��_��p%&�vXr�^��	ϲ�	����W	��ν+L�`Vx�iGۚUѬ0濢����l�&�����`v%,�4�Օ�2�R�p�N�*����k�0��������4T�)|��*�BDa��үm@u�g!#<���3�6\�
%7�|?�l��,�k���.���a����6���c����*j�6L�tM��g7?cV�RwA���k��g:�$���k�l=I���Ԥ�m�bnG34V��v��>ڮ�lL�
�֏�Mp+�n�Z=���I��]w�"=�ӎ��h60��
��rf�V��L��:��b(4�h��*h�3�;f%G���j���O�#��@��Z�C�ɖ�Y%w��B[߱Y�jϐ���3e�@�5[�uBL��ZE�u��z���z�9�z��h�g����P�7c} }��|0_[k)|���4�^D�����X�m��r��k;�rd�Ap�@5/<�bڜ7�c�ƪv�5�lP�+� @�>�[�ê<.m�q��@��!�'0��U�p|�\�z���Y�ȳc�6�dPyhAܘ���B��t�0A�.PtF��1r�0�j��罶g9�kb�B֪�u�hCq5F�g� T��{��=� �y����`����`�9�aƉ G�
�>$�L��"��p���U�������+�&���m($c���� �P�i��n�;��p�S�=�4�Q�҇�qW��nW���mb
�{�[d���C�0YY��p����ro��B#'�[O��t��dK�(������9[�/�O��㝉H��Urs�4�t��̚��)!�&�� ���A���2 �v8;x�$OB�9�5wMX��\*ڪL�������`A�M&x�M��<tu
N�����H+p��閜��#�_�S���~��cӫ�)i�c0���c����S6���l��c]p4����h#\���	���i�`�� �<����S�ЏW�
��*(G.b������
����Z��,@���c��5�����no�hS S9`X���dU��ɤY̩�E�$MkP���2���pa���q�r�#��r���Ɓ�O���q�L�@*��h�^�O��RB ���yKn�p&̓j��5�pi�Pk���圂O�C�hH�w�����1�T]�S��"K.ء��n6������"d�?9���nTd�x{;~��g��x���!ο(��2��G0��,��x�V]��Xy���V�|�����1����;��@&�Y3��9���_]�p�g,1
Ղg -~��TDSO����� �����w��):�a�/�N1p.���@������G��D:�i���A�~o�-$��J��1��&q��8Fj"�=+��8h|y
�2t�1/H���V���F����Du�N�+��5��k�jD��ͨu���A�Jn���=x����[p>����ɗt�o�W��k �)��"�믳�����GQ�E��w�|����&���]`��[M�������p����q��fA0M�=4�����l��'�=����@�]�x�nȩN���!�7�����7p�]r�:���=��_`���g���QZ��� ,O`���sr�<р'���RP`���&H��b��1��.Ki9�RZ����ǨLs}��;p���o�$p����Q���
0�p x���M�v��6���?.0N�¢�pkG��T��	L��9��=4�Cſt��S�9O���2$�!����������M��x��N	�Pj=&�m��Rr�L��3Eߣ�	��˗�6T�m
2��Lz;@3�Q[�QQ�T����M�⢗h�	��JD�ьzZr+���z�
�9�n�f).���=e���m�H@(�u��hs�E���7,U2?Ν�j�}q	�Ϲ���2�K)U��N���Q�ϝ5�A�Y��8:f�[��nd��ތc%��7��ia���I?M�K3Sq��?9Y��or��`e�L�'Q�5L� SS�:*Ķ�o�BD�<�`d+x{�;oW �}�®�qH9���A� M�1n2��a��!�#���E���鐣A���b�-I�@���THXz��9�vH]-��Q�/ĀE�Nq��ՊA
L�0e�ٚe��:�&����ݢ��I�٢�J�0�G���Uq���M�)�9+�IJ
rơ�0�r��B~T�4e
'�z48!��E��H�e�q�HMf� \��G�skċd|/u_
��*�Ko��	�siȑ2l�FL�$y'�أ9
�'q�eu"I_:��(E�����Ы��&�J�#��q"�Lt?�.�z�k����4�8*=���� �s5��i���L�p"���1N�M"���K�n+�)<9i7�\����d�LFP`��_Q~і#/^��<�%�ұ+��d��1N���K��.�*pC"4�6%�9��z�g���� t<k��/C��uרy�z2��X{�Q^������p���a��% ����(�&GYl����9�0>�	��0�p��&K���ݡ��B�ұJTa� ��bL�o"�CKi�ƛ9�W����I�2i��( �U$�y�ϛ01G�6��ee�WA��(#dE���K]��C^�P�$��D�"� �~��cD��.{�Ke:p���v����PL��Bg2��%��W�(ƥ���`�߸e��a�jve��I.�A�%���]�bqԌ�`S]+�0�DZ^+����|�)Z�2u���	 ��.��d����,�`�"`t�܉�ֱegP�P%g�O���Iޣo��%*���b�^,(��p��g�	�	ƿY����/��߈�r\��<e�x�,ɺ�X�	�=�X�$��EK��\-f�Y\��`+qo���T�MV)��j���Ђ�m��}���r]��ah��.�A�0���.�����M�����2�^j͊�aC�]fq�7wiY��trU$/|ᗧ!<i-��]i��-�!�G�&��/��S��:OᏇ	�`>�ϳw��¤N
A���2]�NI�{R)�\�_�������~�G�IM������1r������/�y�K��>btVy%V�6�b�Zd=�8)�I�+�F\�wh}3QWaC`�WB��L��x�Y���3�����RB0�"��/�G<�~�X����}s����C��_��� ��֋�.'���5<��ɉ�_tX��.j�R<�n�l���
L�ue2| ������_��g�i�Yaf��eH�J��?��s�T�j|P���A5>�����T�j|P���A5>�����T�j|P���2U�j|P���A5>�����T�j|P����-h|H�|����W��f�G�fS��N&���X���`��hݱmP�;;����XpN�Wh��qYz�M�B�;�cvs�_�{���Q�SXKI���=z�q�o��ݔf�{�nj�3;r7�0��i^����t4����idVG�NG�����\*����H��Mrqv�e@�ڋvf{Ѳ�?��hë�h���h�Ԏ�aϙՎ�ɿ]{�2paw�I��e���ز�V�cS��N�C��N��,C�e�|/[&��lc
J�g{c��&7[���״�-w���i�	UjW���v�X����}m�n_[Κ�y�ٖ]���mjo�y�ۖ�C���tQ��e��Fv��$�s��-4�v�[��Vj��ۼ�-�<�;��ɽ�{�~M[�T� �   �P��wB�N��	�;�z'T��P��wB�N��	�;�z'T��P�����P��wB�N��	�;�z'T��P��wB�N�މ��;�����`yqn��������������kׯ/��ۅ%�����{�����{�W�Kח�-,·�J�K�.����      y   /   x�3���/��D!�L����Ң�Լ�d�BQ)
75�ӈ+F��� o�-      �     x�}�AN�0EדS�I=��89 ;vl@lL�B�4���n)��@�hرwnTg�VUd�{4O���H�Z٥�E.U�jkV�>�'��6^�݆�W_��g���?�y�E�ݕ�t�եQ�f�u�N�E�CLr�%�!���4���= ���T���9�r��HR:��F[@��p�+U��^,Jmpo��m�Ϋ���o�6�_�B5����X�2K]�a
�a�y�FT"����uӶ:�` �����:c/�8�2􇏡c��t�ȩ���G�2A�1td|A�ә�      �   �   x��һ�0�Z7����D��,���H؀ ����C��]���Q�Ȑ^�C3f����-j��M#/<~���0r�I�YD��6(׵C�#s}@ۺ���o:���������N0^p���A�<�_o��NG���,b+���ϸ_����:��ǵ��x�S|����      �   |   x�}̱�0D�Z��} �wE��d�9�4�G��Ǜ�h�JV�sS=-�x���-�BxUn詚m7�c,��
����?�$��)�U�Y���Jp��J9���HIk�a�r��l"�ٴ?�      �   7   x�31�I�JU�����0202�50�54P0��22�22�3�4�06�#����� $��      s   �  x������F���)澲�nh�}
���6�`	�q���9r�3�q/{�r�G
�!��!RTU����/�> cAg�_������C��T>`,)P�T�P�	��c[�*��ǖg�G� �HS�)2����Y]Y@?�b��YE�9�c�fiu�8���X�r����;�C6�_u��97��jom��WϠ'�1�r�r�6��1Eg%/Knn�����6�p{�v�8\�%"(�������KvL^�mt�S�6��M�L���A�p#��M��U��Sj}��&����TDSQ~ ��93�ɪ?��gW���L���on�[�d�R�Z��@�M	'��Qȩ|�³����IQ���N����"B;�l�2,f�G�m���~6�z��)���1�m�a;��!˜Zk�7�4�ŊUB���Qҷ�/�����	@�����������F�&ɲ&p|]ȯet��ڭV��S<�/�wFK܆�����s�:foعZ0�\�@�Vѭ��na&x�<ϕc�����u���~������p@��i^�}ve���):�["�%��i����۾D�\\����"Xl��F < 4Gc�##�B�OF���F���Έ�v��wĳ�jL�.\������雱�+�Ӛ7��v��.�f7�u6�L��� >      �   f  x�}�In�0ϚW���}{K���Hq��s5z6���*qQA�<��F���$k�&���t2���CQ}�[�ƈ@� ���3�4;y#7�V� �y:�
3_U[t��o�ܓ��K^'Q+6Ӑ"4� ��ɮ�&��d�ֱ̺A��G�=U#5�Hv� �ى����'q��� �{����g��r���=�Y�.��I�mz�5����l����������BK�� ��?C�$��X1�j����+�O�k�o})�b5# ���R^�:����ߕs��l�1������^��x��t,�UOM9(�0��$�2E��R�����G�;�-Q�К���E�*�	| ����/         �  x��Zێ�}}EK�/<K����C��~�'�(7��� ��qIj�5V�Jr�8�$�0pg9������B�$U��{zȕ�H	|�8����S�NO����Xy�0����bZ�)'�xR���"-��,4E^��n^҃Y�k6�((��cz�Ȋi�,���?�GG4��剡��D�bz����38����?c}n]��4<_�KYy��?��<���j���ɶ3z�f煬`���]_�l`Jo��[���S����.h�Y�N5�!�Aw��A�I�V�;�A��ڽ(���E���~�eZ�!��n���������fgǍV;��m�{���Jſ�2j�����AG�Î�J'�C+�����6�����:���y(�K�n��Ӎ[ߺĲ���Y7?��Q��K{U������ ���C��#�<�I|_v;���K�(�+'�"Ě�ʄߐ�i1��L`�k9��a���@�<�P3��be�{x��t�3�^ަ��u��yq
�\h���45n�d��c*Zњ��/�#wD��#Cfݧ-a/�KZ���x�sp���\��/85�a̟�#�$)�_��f��b=˗2��svQ�!o��ܻ��j�f����x���#�'Ŝ�o���s���x�x�<�{�(jDQ�״yp��+�Է���@��ְ7�[��+E!Y	��N�����UB��-�'К?n6��
ct�"|ξ�:o�}Ӊ:��x�7�^H�-8b㧦���*nGd9d�����,�u����Q�ؙ� ��P��n3H�aĊ�K/�P�����sZL�bƦ�U�U�Qb0t+"�!��k�J">3�)[�9a*�Fs����S��M�l��Ա�(o��k��4�a AJgܙ� ]�j�/�����r�'؋LS�׀������K��`�Q&ؠIqn�轐*����/�&�~���8{�H��^ xl$	���7�<$�r�Py��� ���#t����,����KT\WU2�`���<e'p�szL���^�@Dݱ���3IF��#��MJ�Ǖ�����{S��������K6mݙ�{��}�W��]#>��[#�SY���u��� p6Ń��8��q�/�΋z���	�c!M�Gc	��v[7���\b�cg)a«��I!<Z"���:�m�{6���������!U""���)��w�+<��a���#̟*���QIYT�����Qx،�cG�>Ib�6A^x�UaA�۸�˳
�S��q7�YEe$ƪk5�M{���i;�F�;�[-�h��hm4�9�5�m�ݧ9�]����<��b���v��{�s�6��R�W �e�)�&��Ǌe��{�kI�����QLI������\G�,���/�O��_U�ֺx��B�w���Dg���ϩ���ӊg���ـ5�{\�Q��Z07��p/8���)��yt�啼\+��Y��.�>	��z��{=����F����*�Z� ���|�9&��k�[������w��e�}U[�����4��.�e�$���2��#��6�\� �P��`5�S�jW�����~gg�N�Q�2���Q�a�k��ΠgۨV?( �V� ��;v�k|Z�$�~�.�0N�{��5�6�C
m���9vp���7ǳt��|_�0/�y��!�"?��~JI��v�Y(\-wQZ�����×-�HX������Z�v��PJ�/k��0R�J����c �T2�H0�fs�2IQ2��\��Z�6���	*�����W�����K	ڪ�%8�WG�r�g�vɵX�s�ZG�ׂ��(��Y����6P�YWr�o���ѹC�>Ė�>��ɺ�L$����S�7(��x��8C ��{<��Y�3v<����=66���-�H���篥#	QͨL��ό�ǦX�J�j!��Rz�S��s���^�qc8���Db?-���"�0��%�Z��B!��S����4s�@�m誧�����3����H�B�����P�m�Q��y�|��-�C&���|j�#�A�!�敼+p�6��<��P	�T�a��u$�S�4��p�P&�?��S��@�,$�Z�PA:��C��i#�����3a-�\���#��)�	M�	u�4Uj�pz���Ԡ`���.��+�o�	�26��1�ф�
5�jo��m��-��Zxѐ8�Y 	�W�����?�`�]�X�WyG�,�ʻ{{�0���K�k���3���f�Ӌ}�4`�g)A�_c�d��;,�N�})��z*B._�4Rۨɐ/��.o�TQ�����SѰWK�E�<w�*T�L���ᥡ3�Z�ѺJ{�=�U�Yd�*����� ���X��l<�8ڧ^��w�7l��Nw^�	�mC]�#�r���������ݟ��Ւ��ߥ�X��-T���}|�Z��o�᏷>�z�-V=�: +�8T�e����|:eu�<q���1�)��y�w�|^��Ud�|+� ����
~��|�C
ՐS��v���V=Z��'��wĶ�'�Ԯ����Ӫ$:60�DOE��(^cnu,f	�
]{ߏ��x�&>��n3j��	Lӝ�m5O$�X0R��f����yЩV�\���H�v /�uU�4����E��z}2��T4���X�鞨�tB,�UiϪ�Lq7l(^�	pG�k�Sr� i�j����\W��	��J�-�(��էʤ�KT���ܥHG)��H[��e��l#h��DE0h�c%��d�i+62A.,�VX� ��6��I��3�NS���\������ݷ^��'K8����)���(� �g
�0��¥�|.
�1{��`(���a����`�U{j��ι�����QW���Ә|I�7�?����{��,3x�дZ]U<%aЗ�0���jUUP�z��Y�M�\��lAϭ`��X�e�T%�y4�|e�(�v�Z�~t�e�Rz��g���L�!�47AυA�e�~=+�Vds�o����{��X(�`�z� '�����D�Ȭ���h��I�&L�"��?&����0$6T��Q�R��4%�<C�7a���@��1��Hl�'�g�R+��s4
iic�PԞV�&nJ'C�А/�Q�H��#̫�aH���9�s���ځ(`G�?���b�Y�P��|b̑]N|��>F4o۲))���x,nt��n�뱩VP��_IP��V���;�����)����g�+tZ�tYpJ
�X�a�0T/E�T��G��c���g��آ��ظ�ȗ"�^E+ɠ����'�"d�j+W4��e�,�'���P�O��x��k7�q�����v�xH�Ïi�e�PF4����/��rft"��2��K �ρ?Z�.������ᙠh����fq�K��x�I�5I��eꅜ	����^�Q8ч!eiO2�GR{�-��E���O�`��Iw�%��>�<�:�>r�2��i�+=�MCw�f�mn)�����UG.X'��{����_H��L������k�;|���^
�΄�=G���	Z=�x�c�+ x�8�j�w^Q-��n��!\?����������UN����ǞІZ0ܩ�-M�}�2��TT�^;�^��߹�a�*�2+���Q�~k��8-|����-Da?mzɷn��L�WR�/�ji�$��K��G�0,I5��3K
�Ъ:Ti:�G58:R��r��-�؞�J��/q�P��k*��Ћ�����������@U�)N�|;%Q�+ ��O$C���$�kڅ�|)��^H��m�'!]R@���ʝh�V��*��(l�h��Du�tاA6�w!d�q�t&b�|r)�I�^���(��CS]t��B�og�(K��7T��������)�3,~���XƢ��8\ȑG'd�{�`�c"V���)�v�{�����9N^E�ʱZ1���#N0r��z�p�+-�W��d����n�׊+4�ٸr�� �?�K      �   m  x����n�E�=_����E���� �;�%1,����/9GꙌ��Ѓ4� �U�������ߞ�����ק�?||~������������������_�����_�o
ig�a!\��ޥ79���PO�}��"�������E[3��u
E���w\�K��'�Km��Yſ����~z�o��/?}{�RY-�[�4��Tk��DLV(�W���}D=I���Z�� k%��ɹ�9��^\�SoA;�B
w�.�z�%�����W��VKx���� "Oy/�����"�b���"�xH&���\��An*�EZ�O�g2�*^����i�v����S����t/���=9U#�X|V�1��D��z���DAEj��]|#�VhxW��8E$��`��ک����$
.��1@z�q�Y	r���Oa�h"|e��HE0��D�.;:I��جզ�-�;���i%�fE:Z�{Ca��xS$Tl�h�k]�ʶ���3��]{���73�"	��UOM������fG_�6S���bNE��7�J�[|��H� s���7s*.�������3� �ߪ�It�A� �J��FS��.Ӌ~��As��;���qaGG���D���3�z��pK�%)j`/a���&o��(rVD|i}#y����򊖿zz��Ĝ
L���J���9�hk��:L�J�z�$z�A̩L����ْ�7f{ȃ)���wQ/����y�vegq�Lr��GK*^��vt���9��u4�0%�Ô�sq3���D^���}��ADw��M������лy@�wh�
	VRgx�,��g����$X�+d/��4a!F*��bG��rM�L}�l��J���ǈb&�<U|���Ma୤���j\�Y�BL�p-�t�i�kZ�ފ�r���?|X�ZqE{��)
�Z[;
(c�T�mC�Tޱ�0&%������2�aJŋFk��m#6Ԃ@�n�ݱ7E�)���}@�%�M�۩kc[|=׭�Jй�T�����2bd�BiXx;���il�0t-�m��1���@*�����SZ ��a�Ts]f?Q��a"�(ST�,��b�;:��Hp?��ps;���i� Uu�w����PR b�m�S�igW�*݂�zz�������h-��o
�pV���X�^O�cD�1#��r��e�c"��Db�� ��������.h����D]�hL5>Dt�A��N��flsշ����N#GA��[N��v��(R'�|��ӓg��e�O�C��r�ū7쨮+�f�#ʜA�T;[���OU�0T��F��eĔ
����=D\�t��m���2bJ�����,�$���w��F�~���A�NpӵC�v�i�#��G����q/@X�\{���#�)�T�>Β�v��|�Z1�+��z�'��T����`�䛳9L-}���X?�(�aN�����f��a (��Ր�D	�0Ri�JThx�,J3�x�Ϋ��df?Q�b&BQ�/SwIz�u`��VkG��O*��ZF��uǋ�5�tc]j�V��N�Q9��O�<�`�V���}�)��B�2*.��Uɷ�B;_HϡX�W�^==E�F�T�e�ogw�K�1�"����� Q�F̩�8��R�$���0Z�p�v� ��AĔ
�PFk��4F3Q`c�YW^w�n�����4����Q���	�wԪ�8��
��GCm���]��n"�w,�M��fC�����rH~S��P(Sҩ��]Do{5��K�3
ѕ2��)�2^b�>���&�%�Q�/a��9t%�LփD/1r��E�z��M�(3�^�> )q
1�b���_�xK�t����U��~ %�!�\`��:�#3���Am��{�~9�N� `�\�      w   �   x�3�t<:?=1)����[/l����p:g�ŹL9}�*9/̹��b��n0�˘�'5)�����[��C��8]���O/��0���¾�/6_�/� �s�q:f$��ٶ��24�tJ��N��0$za������� m4OM      }      x���]sevǯ�O�w�y�_��/`vo\�	�*nZR[�5�꙱"_�fwI
*�e�݄�q�P�4�0����}�W�'��t��VϣM�p�ёƿ��y���5�.͏GYT}�xPTϫ����Z�M&�P�"a:a2�~��@��q%��;�_ZU����ש�\rG���Z1\k�[����[��Z��M��q��֝a�'�h��g�.������6_S>�<��eT��:\��:X|]��9A.62�Z:��p阛��)RϜ0�\�	��O,��+�\�e�w�Q^�e_WO�c��F7����x#'�@��0�����)�N��8�I_��H��8=�i]��px_4h�Qu���4�R[�;�5�����.࿮���Lz)�9F͘0�A�ͬX�ߎ�?"��A��~����s,�*�ձ��2N+��4�z�p�����e���=�Nj£ڑ�\<��oO���������#Y�L�2Z��R�R%���	ɌN��;��d�*��m��G�,>�S`0�E��4�Ŧ��C�*���
$��!�V02�HA��L7d�(~�8��&�/!�_:E��aI���Ul;`| X��)��ث֞�`f���[�R\4�&�:��A�����7����O���_��� dꍴ6Dױ����;�'�[&�󦡳���v�]�eU�o~����ʃ�q�d�H�UB?�,�&d��E �F��K�[ @Gm%+�������ſ��7>�ˁv�qܘ���U�W�=*D�Q(��#�4��u���g�Y��9r���auT�o��2#�ѡנ�
@�X{"J�T!x"��sߤ�a�ۣ�y���U�,>���N�Vf����t��|�S����i�n���}9%S�;p*�$
|�ɣKӗ���[ἓ����i����k_L-�:]\ZӴn)���b~�SoDi_|
�_���E������POڧ�Ĝua�ڳs+���&��se�g���)���m*�hې<?QLF�K��4(H�8�v�}92���8*����*�6+���� q��D8���0z;+��hs$�� �*@ر�%�~�%\d�GQ�	�jf�x�8�FQ��r��$����~�a>�T@��^� _�ڛ�p(��[+���1"�5?��-���d���Mkү�����rX��π���C�Btk/ϧ����4�;P����LJQ��7w���
�fRC/Mtm~��ɶ����:t<^�������)��E��g�}�+c��Gqs�tiћw���	��Fb�_�5n�����xw8
SZ�2
��� f�ڗS)�Xe�SƶA��������v�����~�;7��W���֡��/�f�J჉m��� �"�7g%���ڗ�7uH��� ���3�P���$K��V�Uʮ�/%��Wb��Đ�)F�EW��F�����HJ����~{�F$Ę����l�9w�=	�Ѹ���Wf1X�c"G�͟l�O6��O��� |^���+�d7��1D)!ƨ(2/�k_J��"Q��O�d�ы/w�E��E�9��b���ay.#
�H���z�ڗQL�&�H3ܻ6$���C_������C-%����&�scRa����*P޻־�Z�m��Ɲ[�I��'>����GZ�Sq^��"��m ��־|VhA9c��R�F�)]��(?����Ɠ�����ш�t�N�x�q]k_0�"\	��k��M��n\}s���Z�@Z�W��Uk�%
���D��%�����������6"4��6oQ`�+[�u|}���¯�Qrw�ڳ+4ac<��P�<��Q�($��=�hzm�V�� 	�ԓ,	p�5�Œ�H�=s޶GG�jaC�<���x�������Tל`V�,#�����'�5�$�d;'��=��N?h��c�Z{��Jf���!�c��Yd�xs~4j�U���q�d���t��������z�Y�ӭ���cZ��7$�Jt�Z��;��F(T�2mt@���g�1N<�Fm�����GVP>y�
��X��zɜ�	"�jW���l��%�w��!AՏ5o6���$+��4�k��G�ړ�&Ib!��U���G.��;Y9=�bZl!�@��\ߊ]��B��Tx�k_`4]Lo	8�Q�5ay�UM|'�+�b���ߘmg�$~?+��t؄�������x�[��:������z̧<���l��=�(xW��wԶ͚����k��>��j�����j��F�9(�����D`���9�"$/�J�w�ݞ}?��������z�R�c\���W}�_�{�?�Y`�ᨚr��m�[�_�Z�b;o�|�R�$k��e���ϴ!2��~���}
B�^�_Y�����B��\!�1�aP�R���э�fV���]��� �Zm֗S�c��3̛e=��(1P>��2t����A7�x�8�8��hJ�U��l��S��'$����4����$��ʝs
/)<$!�V/�V�}��u����2ݒ���)��uv������x���]�y��45�5gkn���s��3�3~Ѷ�5�;�.���x��>V�I�Ѻs}����nB$%�-s�������r�;Z����!]hX8��!֎�/+g�M<�R?kX]tk��NW_�73��7¨���t�!=�� ]�ڗ�ZG�EJ��z�G�!��O�����z�ѕb6m�N����L����*`���;��2���e�w���zvP�����Y9ɃlP�>�R���܀)'�/���@�F�����ƵB���渜�Gy-�k]rTKփڒÔ�8��ܮҾ�B�k�ˉ�K9���B[�����b�K���_Q7�?t�k��b�N�c��^tm�ڏN��b��dfxȬU�NFoŰ��=���SR��������봹V���7��t����� EY*1{@�X����fig��6N���n��o��ky�]�<��k~�,���b{7��|�����i���!1�v&ܠ�/��y�xZ����t��q����Eːc���K�c��6'�oJ�������4�J*�p<Pɺ־'�\s��ǳ`��0ѥ��2z���G�ߡ�>�����_���+:�R��^-b�֞l��9A�rR��8�գl�O��Q<�f�t/�s-?�9/��x���t����fŇ��cl��V�E�����	��¹����N˸O����w������AY��z��sk�JM3���M䒶@��X�\�'�T��ߵ��K�悙B�8�������+�Hlj����e��V��J��M\��Qx�ʖRO��������e����j�&�ì�E����s��������[�lHC$)� b]��aܭT�Uk_DT*(�Dh���Ĥ��F�1�z����p}:+��).R���k��g8����^���OF�Pn��̏��e��/Ѱ��a�V?V?�-�滆���G��Ǫ4�G�־ĘߥQ	��Z�I�!�L5�f���K-
�N{�*ߘ����6O��V� g�ړ��hb�&x�R��[W^G�f��l����9��'��qQ���U6_�;O7uF��蠵�3I�T)��9�5�Oޠ�Ϗ��Z`��g(��F�FÝ,L(E��qh�Jص�%���(�����z�F7f�߷of[�>�zA�~���D H�E+ݘ���xc��At��]L���U���':&i�K��+}�^�{��TΏ
4���Czw�YiG�G$�6�����q�����Z�j�ViCjh3,{߼�w�_��9a������R�Ŝ�̎�/&�zcXb���g���B��ل^���YS�2x�gE1�[�3��')��6+N��F
ƙ����,	����YKǣ_��y9?�K�_f�����������2��i�j��~#\	]Xa�cty�z����!��:��U��!d�����/w'~�S�0�s�v�{�־��ɩ�[%�X��˓��Y�pM�ގ�B��X��Z�1�%�B�*ޮa9>�Yo�7gE]ú��]�wF���N�>�����(xz[����e��]k��X�N�΋��f|{��c�JY���9��V�-�����u�J�X��e�������
��˴ �   ��7@���Qz��!�Q��k_J���2A1��1`��t�/�O��q��1���������o�Kap��h#/��1[�Ku�ų�"��[��Q��^�eމ�.���I�j��=�8�� ݍA���?R�!����h�����������/�      �      x������ � �      u   9   x�3�,-N-�4�2�,�,��5�2�LL���1M9ӊRS�������%@u@�=... {�      �   C   x�3�L�K)��L	K-*����4�3�2���/�
��f���pr!ɀ���GVn����� ~� v     
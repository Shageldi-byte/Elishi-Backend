PGDMP     9                    z         
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
    constant_id integer,
    site_url text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    status text
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
          public          postgres    false    240            �            1259    49321    category    TABLE     J  CREATE TABLE public.category (
    id bigint NOT NULL,
    category_name_tm text NOT NULL,
    category_name_ru text NOT NULL,
    category_name_en text NOT NULL,
    status integer NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_main boolean NOT NULL,
    created_at timestamp without time zone NOT NULL
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
          public          postgres    false    206            �            1259    49418    event    TABLE     s  CREATE TABLE public.event (
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
    "isMain" integer
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
          public          postgres    false    212            �            1259    49354    product_images    TABLE     !  CREATE TABLE public.product_images (
    id bigint NOT NULL,
    small_image text NOT NULL,
    large_image text NOT NULL,
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
   TABLE DATA           c   COPY public.ads (id, ads_image, constant_id, site_url, created_at, updated_at, status) FROM stdin;
    public          postgres    false    239   +�       �          0    49365    banner 
   TABLE DATA           �   COPY public.banner (id, banner_image_tm, banner_image_ru, banner_image_en, "order", status, "siteURL", created_at, updated_at) FROM stdin;
    public          postgres    false    217   ��       �          0    82284 
   blocked_ip 
   TABLE DATA           Q   COPY public.blocked_ip (id, ip_addr, created_at, updated_at, status) FROM stdin;
    public          postgres    false    241   ��       {          0    49321    category 
   TABLE DATA           �   COPY public.category (id, category_name_tm, category_name_ru, category_name_en, status, updated_at, is_main, created_at) FROM stdin;
    public          postgres    false    209   ��       �          0    49407    congratulations 
   TABLE DATA           o   COPY public.congratulations (id, text, status, user_id, holiday_id, title, created_at, updated_at) FROM stdin;
    public          postgres    false    225   ��       �          0    49385    constant_page 
   TABLE DATA           �   COPY public.constant_page (id, "titleTM", "titleRU", "titleEN", content_light_tm, content_light_ru, content_light_en, content_dark_tm, content_dark_ru, content_dark_en, page_type, created_at, updated_at) FROM stdin;
    public          postgres    false    221   ��       y          0    49310    district 
   TABLE DATA           g   COPY public.district (id, district_name_tm, district_name_ru, district_name_en, region_id) FROM stdin;
    public          postgres    false    207   ��       �          0    49418    event 
   TABLE DATA           �   COPY public.event (id, title_tm, title_ru, title_en, event_image, url, status, created_at, updated_at, event_type, go_id, "isMain") FROM stdin;
    public          postgres    false    227   $�       �          0    74089    event_products 
   TABLE DATA           Z   COPY public.event_products (product_id, created_at, updated_at, event_id, id) FROM stdin;
    public          postgres    false    236   ��       �          0    49377    favorite 
   TABLE DATA           S   COPY public.favorite (id, product_id, user_id, created_at, updated_at) FROM stdin;
    public          postgres    false    219   ��       �          0    49396    holiday 
   TABLE DATA           p   COPY public.holiday (id, holiday_name_tm, holiday_name_ru, holiday_name_en, created_at, updated_at) FROM stdin;
    public          postgres    false    223   �       s          0    49277    mobile_users 
   TABLE DATA           �   COPY public.mobile_users (id, fullname, address, phone_number, profile_image, user_type_id, region_id, email, notification_token, gender, status, created_at, updated_at, token) FROM stdin;
    public          postgres    false    201   e�       �          0    49429    phone_verification 
   TABLE DATA           \   COPY public.phone_verification (id, phone_number, code, created_at, updated_at) FROM stdin;
    public          postgres    false    229   %�                 0    49343    product 
   TABLE DATA           �   COPY public.product (id, product_name, price, status, description, sub_category_id, user_id, is_popular, size, phone_number, updated_at, created_at, view_count, cancel_reason) FROM stdin;
    public          postgres    false    213   @�       �          0    49354    product_images 
   TABLE DATA           t   COPY public.product_images (id, small_image, large_image, product_id, is_first, created_at, updated_at) FROM stdin;
    public          postgres    false    215   ��       w          0    49299    region 
   TABLE DATA           T   COPY public.region (id, region_name_tm, region_name_ru, region_name_en) FROM stdin;
    public          postgres    false    205   "�       }          0    49332    sub_category 
   TABLE DATA           �   COPY public.sub_category (id, sub_category_name_tm, sub_category_name_ru, sub_category_name_en, category_id, status, created_at, updated_at, image) FROM stdin;
    public          postgres    false    211   ��       �          0    49504    today_product 
   TABLE DATA           O   COPY public.today_product (id, product_id, created_at, updated_at) FROM stdin;
    public          postgres    false    235   �       u          0    49288 	   user_type 
   TABLE DATA           A   COPY public.user_type (id, user_type, product_limit) FROM stdin;
    public          postgres    false    203   %�       �          0    49493    vars 
   TABLE DATA           /   COPY public.vars (id, type, value) FROM stdin;
    public          postgres    false    233   d�       �           0    0    TodayProduct_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."TodayProduct_id_seq"', 1, false);
          public          postgres    false    234            �           0    0    admin_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.admin_user_id_seq', 330, true);
          public          postgres    false    230            �           0    0 
   ads_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.ads_id_seq', 14, true);
          public          postgres    false    238            �           0    0    banner_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.banner_id_seq', 28, true);
          public          postgres    false    216            �           0    0    blocked_ip_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.blocked_ip_id_seq', 10, true);
          public          postgres    false    240            �           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 29, true);
          public          postgres    false    208            �           0    0    congratulations_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.congratulations_id_seq', 11, true);
          public          postgres    false    224            �           0    0    constant_page_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.constant_page_id_seq', 6, true);
          public          postgres    false    220            �           0    0    district_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.district_id_seq', 7, true);
          public          postgres    false    206            �           0    0    event_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.event_id_seq', 21, true);
          public          postgres    false    226            �           0    0    event_products_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.event_products_id_seq', 37, true);
          public          postgres    false    237            �           0    0    favorite_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.favorite_id_seq', 5, true);
          public          postgres    false    218            �           0    0    holiday_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.holiday_id_seq', 46, true);
          public          postgres    false    222            �           0    0    phone_verification_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.phone_verification_id_seq', 25, true);
          public          postgres    false    228            �           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 47, true);
          public          postgres    false    212            �           0    0    product_images_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.product_images_id_seq', 344, true);
          public          postgres    false    214            �           0    0    region_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.region_id_seq', 11, true);
          public          postgres    false    204            �           0    0    sub_categoy_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.sub_categoy_id_seq', 30, true);
          public          postgres    false    210            �           0    0    user_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.user_id_seq', 144, true);
          public          postgres    false    200            �           0    0    user_type_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.user_type_id_seq', 8, true);
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
       public            postgres    false    233            �   �  x���ێ$�E���� �˼!�G#<�Ȓ5�{��d�z�ݝ}S���uXS��#�Ddf���Ww�wObʥ>y�����!���[�=-�i�[���KK��ƒ��)+�1c���T�Mm���}&C0U�TB�����O�!��!��b#��}s�`���ޏP��D ��ils�<>���	�jZJ��Y�\�/Q[(��[[�\ί�G�1�#T.�\��k��~��%�4j
�52��Ӗڜ^���|@y�!z�#��|��z���<B0����0j���L���9��|ӎ`:7�k����d&!�y)c8!��x���3M.������biS��ﲵ�F�M;�IHx�fn�s�0/��u�g(�8��𙄱R7��Z��I-u+%��}w�`FV�Xs���!��тY:��&�L�hi\ax���#���ٟ.�$����5�aZ&a��-��!q��%c�o��ܽ��I+}�����s�`>�8�h�g2������e���#�{l���Ri&!�!N�x&C0	��Xbct�d&!�s�߳���IH��F��]�$̗a�h����-T.�<�(o!��ͼ�`6<	��kv�$lx����!�I���ъ��v���I\S�6�`6<y�	-��Q1���ay��K�!��-Z��m����I�򠼷�ѲLB�Ѵ�����@ʥ
	�[/�go�i&!�h�����`^8�e7M�`^6�~��!�����~s�`���5��IHx�z�"����-�޼�n!���W�5�Mo�4��p��8�]�B蟅����+�M;��^0u\�ْw��$���s��L�h�[DG�5��$������I-(�6��K/�0Z��bj�K�!��т�R�;��I-(�5x;��`Fn�Z�ns!��тr�'�3��\���K����$e<�V�!�I�x���!����R�m!������C^C0Io�t��_&)�m�y�#�x����N��&)�=�k�ӎ`��+Q����˔���y�$$|l�M�!���n�g8D0		��tD�2���q?��&�LB���"���iG0		Gy����I�86�et�v!���s��;;�I����@�W>��9�r�#3���BTI)ǐp����")�c��6b���R>c��i�BTI1�h#��Q%�|�6�Q%����E�JH��T4��,�J�:�Sś\Q%d}�d{z�x/I����߂;��J�:�c�ne�*!��Ǯ�ˏ�"!�(�;@4B��t��Z��Q%$}n�Bw5D��t���{�����{�n�UR����J<wD��t4��A�#�N)祶|�􀨒r^����UR�KO�}|CTIIoe�+��UR�[��m�Q%e��:��Q%e���
�����Ckn�b�*)�X��a�#�����zE��x?�<�9l�Vo�`��󬳼���Qu�u��X�(,D�y�Q��Ѕ�:�:�s��`^��󬳾b9DT�g��~L�Pq!�γ���B�V全:��}=g�Z���>��M��)�]�׃.D��vl^����BTIi��U�&�BT	i�[䵳Q%�����q��%	Y�X3s���Y�*!�ǆѝQ%d=nˮw~!���G.)�kA�J�zĒ�ܓʅ�L��u�c��uVQ%d�����?����>��Ρ������ Lg\�*)�}����JJ;���m��JJ���S�!���\��[�*)�#��l#�P$e}��OƆ�ԝ��Yr�2��*)�blx��!���'l�sw�uCT	YG}�;�_�*!�	�bw�f�"!�(�c���!����Y��	� Q%$=my���,D����������BT	YG}	�ʧ�����:�w\�UB�Q�Zq�=CTIYo���ER�[��{2e!����Tӕ?oGTIYo%�k��J�z+���!�������OՎ����f�6w!����k�^ߧ<�)�GJ���Q%�|�Γ�D���P�绍P$��1&w�1D���a~���n�*!�yc;�=Q�UB�3��t�Z�*!��y�CD��s��IC#	)�h|gp�!>U/$�O��8DT	IG�l��*)�#�#D����3��=w�UB�Y?��P�J�z��(h�UB���UB�Q?c���n�*!�#vV�d�UB�Qߪ{�l!��!����+����Ҏz\wa�*!�e����vCTIi�e��L�JJ{�h4���*)���O>,D����r�r�vD��v��3�Q%���q��UR�ی�y�!��$��a��~�JJ�L�?:1D��������Q%����7A�JH{�b�{s!���W��Mn�m�*!��o����Q%�����,�BT	i��Y�&dCT	i�[���"F�֛�u����,D��u��v%
;�J�z�>ֽd�*)�5w6~$II��3�;SCTII�< 9DTII�m�!�JJzm3�-�!���W|�^�BTIIo!��&/��2��c����gCTIY�sw�l�*)�#���	fGTIY�C�.�UR�g�y��jGTIi��]S= ����-�krG�!������^�!����~��ۅ��ްf�����B�Q�7���UB�Q߳��UB�Y?�{c�*!�m����Q%��-wn7D��v�O��P$e����~�UR�6�j�*)���{,`�*)�}�;/���R�g��=�7D���ksOQ%e}�Eq��Q%d�o!���ACT	Y�f�_�Q%d���%��!���󍥀��Q%��غ�-�!�������_�Q%������#��/Y��O���}GT	Y�B��gz 	IGyi���#�H�ymk��J�����F(�R>j�W̎�R>Фt�C�JH����t�H�UB�Q�����JH��3ɻV��� B�Q�͵���BT	9G}�C�H(r���`�JH��r(n��H(r>��Gw;*CT	I�KP�Z<wD��tL �=-D����Gq�CTIIgc�eCTII�w����5R�g��{�x!�����In�a�*)�s�-�#�HJ����#D�����:��<�BT	YG}/��kj�*!�q�ߟ!����~��n%Q%d�o
�xQ0D��u����/,	YG=�qw0�J�:�_�{�x!���O�����JH;_�#x˖!��������^�(�{Q%%�a3���JJz/%���!�������UR�yZ�����Γ^ oVX������s��<�,���n���<�I�4X�����w�g!�Γ�z��\�Qu�t�c���L.D�y���k���U�IG}As�-�Qu�t�g����/�II/m���BTII/#4�����ݹ������c'܆�Q%e����P�BTIY�a�M�BTIYﱧ+}GTIY�q��d,D���Q�{��UR�G��A�B�E)�+���=���O;+�BTII�K��Q%d=n��x5D��u��������z��˺!����޽Cf�"!�J��rQ%$=��qM�����V��Z�B��O!�q+���B������7_�}yKד�~y��������g7/����������/޽i7o~���w��E���/7��7�ݽ�y����/X��}���/?���g/�?|����?������'�}�%$�������	�_�󇟆������՛�?y������Wq��_~�����W�|����^����n�;�W��S~+%�tO����~��E����r����n�      �   z   x�=�K� @�1��@߯dM*�&h����zu��N�E1}=��<��-��~]�V=�D�	��G�1!'���Q�/�궭"�1:���9�_��"u�$�$���뱕�T�!Xk?��!�      �   �   x���Kn�@��u�\`&~{�� !(i���4�o¢*������ɛi>��v��������؟�����?3�X8kT��ʕMI�L��#y���*Y�EP����x#!R0�UR�MC@��3����6A���a�w*�"�$�=�*f�uy�B��3;�B��+ȦXm��J��X�
�~'4�1-'Ҷ��~ 1F��      �   i   x��̱1C��4E8��,K�,���q$0���3�n^�~�?��ls��:�v��kB�L9K��hjmй�(�Ǖ}�XQ�8���ϭ#4�'�D�����:l      {   �  x�}�1k�0�g�S�D�O�}�ֆ��ұ�{�]L|N�t�pK�C;��)�4�5$�.q�]�Fy>���&�����=�$�l��S6��N3W�Ӝ}���8�%�������_��_7�>��_�;������2O�m^Mب(ٮMvH@@ l�!�A`�2r	�d�HA�탩��r������?���J���O��GP����#<�4�L�I�%8�Wp����NGդ뭍P<�JÀTψBr��ze�gw���y���_�v2)���b��B�aE�ml�:O��;[�~�K�������Ѐ�
�;Z)����I��Z�1Ng���3"�YQ��5\�"����H!"��ugi�v�^Q�7ž�r�������kf�7�w���"|*H#b#�� 9���F�\�B! /��vj��=O��@�`�#���ne��a��~���w~�      �   �  x�mV�n�F<���ݵ%'�Ib�A']f�Y��ᐞ���קz^�6$�3������t�}qz&^}�i\���s 5��ѰX���Ct�F^�l'҆CO���^�@.����L:�M���h���߁�7����Y�tGW5�a�x2�Bj����W6�ӟѯڎ�&(,�ʏ�>E;�dT�+�|y���j��7�i��x�Ш[�(��*:���갬��hըH�5��%:ua��!ߔT#rH�t�qb),%A���e$����>�O�T8_�[���gK@�W��b�1(O{��5�&����}����YjD���3�:���eo:�z VC4_�9r��A�>XJ�[�k� Hb@wn�H�tru �
��x=K ���%���\�.>j�	
A/-nO�.R�m11���Ҭ��W!Bz���%�EW��7�49uc!���D���%�6z�M���8	�ϐg ��k����
ʓ�DW(��~𢭆�W�����EE�{��P`�7A.�
�,J"�h��%�4r���?^ �mL�EƯR)�mb�N&���$%j��E��Zy�M�6Ȑ��B�)�����N<wY���:���&O�(%�5*��;��k��c��.t(�U�2�E mx�ZY۝5�kI���d��EW�-�&�j�6 �q �#jl�i6��Yy�^�)ݛkp6/!�&"�qX�U,e�RSF/I�w�&��$�w�z_XgJ�JPF�W�Ӥ�,+m��ᓇ1u����\yW1��-,�x��ZP��ޞ}��N�\_��K���Kf��V�k����~��[�����I
�)�qP(�^��-\Fj�֑о˴ǐ%�V\6��Z}U�n~v^e1��Yhz9�n�;�[֤�8����<}��F��mѯHJ�s2�bN�#MD�yWP�(�a����,�k�6bt�5�`,:l��}X:9ڦ��"$�Q&l���"��E� �5ϲe�s�(��c��������:�N(�;3׸�k��WF�����k�e��h���� =K]��\n�
�ɟA@����wh�� S>),�r,�BD���^-��R�SY��&(�@�m����R:�o%}��2�me7�Ω�g�n@%q����u1���[��e��|ڂ��?����û��_�?M߾���|<��߾9����x<>�;���?��?�p������|��?�?���Sww�?9��      �     x��k��D�gNQ2Z���a�1O��!�E�˟vܱ{�;�d���"��p��FT��8�"!��vuWu=[�e�x1�,a��_�᷇_��w�����Eg�"2v��E��=��� k%�`�
��C�т�}����܊�a��b���]0�
��_�r)3[䵡X�F�2�]'\P��{ه�a��Js��֖��zBfx�m��+�o
�8�+fC���V�lEb�&���Y�7<�ZU�\��J^�$���0/wG�L'2����3-wn��4f��>4����I�Ƙ�2�ie�j�=;�G,���E��+.1�8f��T��L��!|2���YR�6�m&,��EZ&d��N�M�g��:�}j��}�]	����rδ+�ͪ�D�2g�����+l�[������r���6��B�J��$f*G��&� ��\��N7ox��?M������F��T� k:)��gg���?���f�Y����``V�s	L&�`�Ac�������IS��$��3�G|�F��F�j��2rC잉�Ǻ1c���>�N7ʂE}	�h�;�r4�+��{U�*UPibjl90ͫ���;Q�hT�Jo9�+�eb�'�0
��V��n�l&�0�O�M������4�l�،F��%1��Py�u�WW�[��h�������^4�v�u�k��
�~+�Q�`���m'�@����9��]�z�r{�}�$�Z�꒹�u��܌�qٕa�pV�V�&��R�jVc�-���|
_�^�M|��S�*�	Ǧ17�b�K^�(ͦ��$�GFޡ+���eα#�G�f���/t�Ŷ�Ѩ,�zm!Oߏ�}��;��V�=Ay�x������h�B㔩�T�]��gҝ��'���O����T~��A/����ՅO G G G G G G G G G G G G G G G G G G G G G G G G G G w4B G G G G G G G G G G ���C G G G G G G G G G ��@���{c<��A0� Ǔp<���`z��?;[���`>�O��%.^,� �1�      y   J   x�3���/��D!�L����Ң�Լ�d�BQ)
75�ӈˌ�1/;�(�24�2��,.I�K*��� ���qqq ��)j      �   �   x�}���0 ��W����J)�L\]*T46� %���Uc�.�K�$\x��!�4�>�w8������іi���ү>.��|�ZՊ+n�a*P�J%Y������$Q!y/s�m�-kaX��⼸�����^>߶��sB�bc��Qs����
�!4�a��.��r�\D�eo�A�      �   �   x�����0�s\ģݑj��:�Ȃ���F��[l! Z�W�A�J2���M����d܂�	܂�n�=��F�v�!�U���9���}��{ v�ت(5]l����l����V���r�=��[��&t�<R�}�f�E�?��v��Qj���ߚ�k�}G��BwTE��U�_���9gx�9�m�K{���v���      �   Y   x�}�A� D�u{
�2�R���ϡ.Qb2��y�]2�3#�`�47���z��@��B���"��!u���Їsx/�;0#��gQ��&�      �   7   x�31�I�JU�����0202�50�54P0��22�22�3�4�06�#����� $��      s   �  x���[o�@���Wx�h��a�Z@�AQ[��� �gV��/6��m�l7��7�̛��>�a��<n��γ� <P�%L0�X$@AH���7ei3B�: wiCڃ��`�*X���l��<n�>w�ɞnڜ,����$�gݤ����s��\fI�0㓅���ʎ���`����י����|�r������Q�a��e���={�R���Tyd�)ZK�f�\Q7,W��Q",1/��]^�����js�������U�y�����(2�@A�����	���A ��5���x<��Y"�Jc�؄/�u��ӝ�"[_�ԩJ�v�C��ө�4kZ��,ַʾ4��t�̔�1�T�94�I���f'����LFY���"��p;O܊�f/������r�����li�/�N�:#Ke�M��) ����	��M���a�aJ��w�Ͷ����2��պ����m�}�k�����6�]����"��N&4��(����(-Ek���Gj$�A}���8���U ��|tw�hP Jo��h�������s�c��� ��,ܧt�Ϝm��|���+�lgй�$�2�E�ccr��mժ��7�;YA��C�Y���@�m�B�C5�AD�Æ�no<��]���Qjl^:���J0�@Z����9�a���V��JW,      �     x�}�;n1�k�)�&�M�� m)��@
��O�K�
|�p-� �2�-���g8.�D��
��÷��������t�y:�y<�/OϏ�����~����^^�1��������|$��+R�"Qd���p�E'�z5MY"|v���$8ɭŦd�3�Az::���Ik{$�#�|N����|��$"��9��p����b�:�p�l�@�G�"8fd�[I9)�X (����f�{��	HvN������I���q�@��;
�=�����������;�(mZ�82[{ZmS����4�Vt�R���6B5��mƷ�ri��>$*��PR˴@@:Ze����fk��B۰.;d�J\���'F2+�UP�I/VSVs����<��y��6��"L��Y�Mz����0�k�C@1wPF�{������n��e��s�l��|��i�bC���-�����欨��->�G�Ӎ�:8g��,	[�pΪG��i��m!)�+�	+�O,ia��@�6�=���TRp�?��� �knm@         <  x���=n�0��>��"�D���t�	�P�l��i{�>����!8$x�?����R)�ӂ�e!N��S��1�! ��;�ẉ�̜՚ɲ��f�M�K�"u&i��zz�� J��Z�x8��q\�Oh8���W8�%+!�p�ڜ� c������X������y�)� ��� �ɡ����rZ�ĳ��:�I��Ը4���n�l����e������.lnun审�ӂ���6ϊ��43P1)F�-�E|0��Ε�C���������/P>k�^���>P�p_+�x�z>^�^�n���ILG� �˛���n�0�ϤB      �   �  x����N9���S�~ep���gY)b�!�����L�.��@�}�FӨT��>u�=���Ͽ��>_�|��~����������\=�}su{�������7߾~:|S���4�Ԩ�R"�ˇ��u����/��<�R���M[Bi���W�R�T�X�Z���2�T�?����g�=���ݗ��O��4e���5�+���,�D)+��N"$J.���buR��F�)�,$C��ŘY]�w �C��Z�,$D")�=[�8�U+ILl)m��"�"�dG����E�欳�l��T,��5� Ei�2"�f!� ��B�"�,;��&�*�Ӫ�F{:�Ԋ��1U߳�$��:)���T׬��J�ł��c���Nk�%3厾�"�T�r�G�-jد)ȣdMF���E�P-��Xc7_�?�E����_�z����C�m>P�ߦ��r�TkH�Z�
t�(F�Z	��n>� Y�0M�9@��a�$�{�����D��T��1��6�Ò	�ZcS��5L��C�9h�_3�⭵��{�w�h�����|���S�0��}�`im���z����}���0��w@�Q�%���T�����Po�漮z�����C�m��K&�0-Id�;:҉B-Q��㶚��!yQ��<�M�1��b�QO��F�b�M�^�{/�f����L�@Q���?�I@���1�l��!S����P�@����~a��Gߥg�������9@o���b=nX^@5�n�Vuݔ�D�#�>׺�Hț�1��z�/`��^`��Z�%�|%�ڹ9�%*�ꉢ/�	�۝H��Ê��W�dh�[�P�J��5����=��X1���j���HVe���5�,�����k�}�b����6�%����g���D��)8	uj����gu�54��U�q����!T��''��uD�S§y��
;�$��@��"�\��K����9Y�C-�=�ږ7 @:Q�MHo�����6�����8_��gń̫���bq��J��d�>��y}�%�a��б�2k�.,Us�����چ$#�׺[C��\0;�Э������������si0��>8:�H�Q'
LN4i���\B�$"�4t��L#b�2�J#���t�{�`�� �1�i�iH�G�5�,L8C��%�0��1m�5'���ĸ32��a��^1��Vg!mr��$�
K˞!{�� �^�3�g!���f�J�}ÿ�XCi�m�n��N5\���~�w��S�5\��e�H���mZ��"z�X�^;U�-H:�p{.X��_S��u#%�_�r3=i���\(H�.$-hڨ�*5ܞKC���eؕ���For�E4�o{.�FX_�a�;.�n�����H#��!�,��2va��ʠ����A������_Gv�      w   �   x�3�t<:?=1)����[/l����p:g�ŹL9}�*9/̹��b��n0�˘�'5)�����[��C��8]���O/��0���¾�/6_�/� �s�q:f$��ٶ��24�tJ��N��0$za���24�)-�άLE��3�b���� eX�      }   "  x���;N�@@�z�
�h�yo��i�X�c�`2"����_A���d4�Qh���bB���;��ʳ�?�}�;��(�g�
D.$�"��� �4��	�O���*{�I���t>�e1��q}�;���`�A��r+,��e��a���ݳ�F,>�W񵽎�ش7�_w��g ��HY��'SA���>'�1v'ik'rNK"��l}w�t�~|��sGl��6�o�������>���3�C]��ol0�0Y$g~�r�r�2��i��Jj+�ں��$I6i!�t      �      x������ � �      u   /   x�3�,-N-�4�2�,�,��5�2�LL���1M9ӊRS��1z\\\ ��	�      �   ?   x�3�L�K)��L	K-*����4�3�2���/F0FS�ZX�Y����W�i�e��U&F��� i w     
CREATE DATABASE miniproj;
USE DATABASE miniproj;

CREATE TABLE t_accounts
(
    user_id BIGSERIAL NOT NULL PRIMARY KEY,
    username character varying(50),
    email character varying(50),
    password character varying(50),    
    CONSTRAINT unique_email UNIQUE (email),
    CONSTRAINT unique_username UNIQUE (username),
    
)


CREATE TABLE t_userdata
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id bigint,
    first_name character varying(50),
    last_name character varying(50),
    avatar character varying(200),
    description text,
    contact character varying(50),
    CONSTRAINT "account_user_FK" FOREIGN KEY (user_id)
        REFERENCES public.t_accounts (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
    
)


CREATE TABLE t_category
(
    category_id BIGSERIAL NOT NULL PRIMARY KEY,
    category_name character varying(50)
    
)

CREATE TABLE t_user_category
(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    category_id bigint NOT NULL,
    user_id bigint NOT NULL,
    CONSTRAINT "user_category_FK" FOREIGN KEY (user_id)
        REFERENCES t_accounts (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "category_FK" FOREIGN KEY (category_id)
        REFERENCES t_category (category_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
    




CREATE SEQUENCE t_account_role_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

    
CREATE TABLE t_account_role
(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('t_location_id_seq'::regclass),
    role_id smallint NOT NULL DEFAULT 1,
    user_id bigint NOT NULL,
    CONSTRAINT "account_role_FK" FOREIGN KEY (user_id)
        REFERENCES public.t_accounts (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "role_description_FK" FOREIGN KEY (role_id)
        REFERENCES public.t_roles (role_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
    
)


    
CREATE TABLE t_roles
(
    role_id smallint NOT NULL PRIMARY KEY,
    description character varying(200)
    
)



CREATE SEQUENCE public.t_location_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE public.t_location
(
    id bigint NOT NULL DEFAULT nextval('t_location_id_seq'::regclass),
    geolocation character varying(100),
    user_id bigint NOT NULL,
    location_name character varying(100),
    selected boolean NOT NULL DEFAULT false,
    CONSTRAINT t_location_pkey PRIMARY KEY (id),
    CONSTRAINT user_locations FOREIGN KEY (user_id)
        REFERENCES public.t_accounts (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

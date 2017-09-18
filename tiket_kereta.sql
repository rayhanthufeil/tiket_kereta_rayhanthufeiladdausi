

CREATE SEQUENCE customer_customer_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."customer" (
    "customer_id" bigint DEFAULT nextval('customer_customer_id_seq') NOT NULL,
    "customer_name" character varying(50) NOT NULL,
    "identity_number" character varying(20) NOT NULL,
    "customer_address" character varying(50) NOT NULL,
    "customer_email" character varying(20) NOT NULL,
    "customer_phone_number" character varying(12) NOT NULL,
    CONSTRAINT "customer_pkey" PRIMARY KEY ("customer_id")
) WITH (oids = false);

INSERT INTO "customer" ("customer_id", "customer_name", "identity_number", "customer_address", "customer_email", "customer_phone_number") VALUES
(1121,	'didin',	'342342423',	'permata gelap',	'djadjoaijds',	'809890809');

CREATE SEQUENCE user_customer_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."user" (
    "user_id" character varying(10) NOT NULL,
    "password" character varying(10) NOT NULL,
    "customer_id" bigint DEFAULT nextval('user_customer_id_seq') NOT NULL,
    CONSTRAINT "user_pkey" PRIMARY KEY ("user_id"),
    CONSTRAINT "customer" FOREIGN KEY (customer_id) REFERENCES customer(customer_id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "user" ("user_id", "password", "customer_id") VALUES
('adil',	'12345',	1121);

CREATE SEQUENCE city_city_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."city" (
    "city_id" bigint DEFAULT nextval('city_city_id_seq') NOT NULL,
    "city_name" character varying(20) NOT NULL,
    "is_valid" character varying(10),
    CONSTRAINT "city_pkey" PRIMARY KEY ("city_id")
) WITH (oids = false);


CREATE SEQUENCE ticket_master_schedule_detail_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE SEQUENCE ticket_customer_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."ticket" (
    "master_schedule_detail_id" bigint DEFAULT nextval('ticket_master_schedule_detail_id_seq') NOT NULL,
    "customer_id" bigint DEFAULT nextval('ticket_customer_id_seq') NOT NULL,
    CONSTRAINT "ticket_pkey" PRIMARY KEY ("master_schedule_detail_id"),
    CONSTRAINT "customer" FOREIGN KEY (customer_id) REFERENCES customer(customer_id) NOT DEFERRABLE
) WITH (oids = false);


CREATE SEQUENCE route_id_route_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."route" (
    "route_id" bigint DEFAULT nextval('route_id_route_id_seq') NOT NULL,
    "route_name" character varying(20) NOT NULL,
    "is_valid" character varying(20),
    CONSTRAINT "route_id_pkey" PRIMARY KEY ("route_id")
) WITH (oids = false);


CREATE SEQUENCE master_schedule_schedule_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE SEQUENCE master_schedule_route_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE SEQUENCE master_schedule_city_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."master_schedule" (
    "schedule_id" bigint DEFAULT nextval('master_schedule_schedule_id_seq') NOT NULL,
    "route_id" bigint DEFAULT nextval('master_schedule_route_id_seq') NOT NULL,
    "city_id" bigint DEFAULT nextval('master_schedule_city_id_seq') NOT NULL,
    CONSTRAINT "master_schedule_pkey" PRIMARY KEY ("schedule_id"),
    CONSTRAINT "city" FOREIGN KEY (city_id) REFERENCES city(city_id) NOT DEFERRABLE,
    CONSTRAINT "route" FOREIGN KEY (route_id) REFERENCES route(route_id) NOT DEFERRABLE
) WITH (oids = false);


CREATE TABLE "public"."rails" (
    "rails_id" character varying(10) NOT NULL,
    "rails_name" character varying(20) NOT NULL,
    "capacity" integer NOT NULL,
    CONSTRAINT "rails_pkey" PRIMARY KEY ("rails_id")
) WITH (oids = false);


CREATE SEQUENCE master_schedule_detail_master_schedule_detail_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE SEQUENCE master_schedule_detail_schedule_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."master_schedule_detail" (
    "master_schedule_detail_id" bigint DEFAULT nextval('master_schedule_detail_master_schedule_detail_id_seq') NOT NULL,
    "eta" time without time zone NOT NULL,
    "etd" time with time zone NOT NULL,
    "schedule_id" bigint DEFAULT nextval('master_schedule_detail_schedule_id_seq') NOT NULL,
    "rails_id" character varying(10) NOT NULL,
    CONSTRAINT "master_schedule_detail_pkey" PRIMARY KEY ("master_schedule_detail_id"),
    CONSTRAINT "rails" FOREIGN KEY (rails_id) REFERENCES rails(rails_id) NOT DEFERRABLE,
    CONSTRAINT "schedule" FOREIGN KEY (schedule_id) REFERENCES master_schedule(schedule_id) NOT DEFERRABLE
) WITH (oids = false);


-- 2017-09-18 11:16:04.04241+07

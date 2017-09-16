-- Adminer 4.3.1 PostgreSQL dump

\connect "didin";

DROP TABLE IF EXISTS "customer";
CREATE SEQUENCE customer_customer_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."customer" (
    "customer_id" bigint DEFAULT nextval('customer_customer_id_seq') NOT NULL,
    "name" character varying DEFAULT 50 NOT NULL,
    "identify_number" integer DEFAULT 40 NOT NULL,
    "customer_addres" text NOT NULL,
    "customer_email" character varying DEFAULT 40 NOT NULL,
    "costumer_phone" character varying(15) DEFAULT 13 NOT NULL,
    CONSTRAINT "customer_pkey" PRIMARY KEY ("customer_id")
) WITH (oids = false);

INSERT INTO "customer" ("customer_id", "name", "identify_number", "customer_addres", "customer_email", "costumer_phone") VALUES
(1,	'didin',	12121,	'jalan jahtot subroto',	'didinnuryahya@gmail.com',	'13'),
(2,	'ali',	31321,	'sjsjjs',	'alli@gmail.com',	'13'),
(3,	'tupel',	131233,	'pamulang',	'tupel@gmail.com',	'13'),
(4,	'hafi',	31312,	'dadasd',	'sdad@gmail.com',	'089293923');

DROP TABLE IF EXISTS "user";
CREATE SEQUENCE user_customer_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."user" (
    "user_id" character varying(20) NOT NULL,
    "password" character varying(20) NOT NULL,
    "customer_id" bigint DEFAULT nextval('user_customer_id_seq') NOT NULL,
    CONSTRAINT "user_pkey" PRIMARY KEY ("user_id"),
    CONSTRAINT "customer_id" FOREIGN KEY (customer_id) REFERENCES customer(customer_id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "user" ("user_id", "password", "customer_id") VALUES
('ajimumpung',	'12345',	3);

DROP TABLE IF EXISTS "master_schedule_detail";
CREATE SEQUENCE master_schedule_detail_master_schedule_detail_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE SEQUENCE master_schedule_detail_schedule_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE SEQUENCE master_schedule_detail_rails_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."master_schedule_detail" (
    "master_schedule_detail_id" bigint DEFAULT nextval('master_schedule_detail_master_schedule_detail_id_seq') NOT NULL,
    "eta" time without time zone NOT NULL,
    "etd" time without time zone NOT NULL,
    "schedule_id" bigint DEFAULT nextval('master_schedule_detail_schedule_id_seq') NOT NULL,
    "rails_id" bigint DEFAULT nextval('master_schedule_detail_rails_id_seq') NOT NULL,
    CONSTRAINT "master_schedule_detail_pkey" PRIMARY KEY ("master_schedule_detail_id"),
    CONSTRAINT "rails" FOREIGN KEY (rails_id) REFERENCES rails(rails_id) NOT DEFERRABLE,
    CONSTRAINT "schedule" FOREIGN KEY (schedule_id) REFERENCES master_schedule(schedule_id) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "ticket";
CREATE SEQUENCE ticket_master_schedule_detail_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."ticket" (
    "master_schedule_detail_id" bigint DEFAULT nextval('ticket_master_schedule_detail_id_seq') NOT NULL,
    "costumer_id" bigint NOT NULL,
    CONSTRAINT "ticket_pkey" PRIMARY KEY ("master_schedule_detail_id"),
    CONSTRAINT "costumer" FOREIGN KEY (costumer_id) REFERENCES customer(customer_id) NOT DEFERRABLE,
    CONSTRAINT "master_id" FOREIGN KEY (master_schedule_detail_id) REFERENCES master_schedule_detail(master_schedule_detail_id) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "master_schedule";
CREATE SEQUENCE master_schedule_schedule_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."master_schedule" (
    "schedule_id" bigint DEFAULT nextval('master_schedule_schedule_id_seq') NOT NULL,
    "route_id" bigint NOT NULL,
    "city_id" bigint NOT NULL,
    CONSTRAINT "master_schedule_pkey" PRIMARY KEY ("schedule_id"),
    CONSTRAINT "rails" FOREIGN KEY (city_id) REFERENCES city(city_id) NOT DEFERRABLE,
    CONSTRAINT "route" FOREIGN KEY (route_id) REFERENCES route(route_id) NOT DEFERRABLE
) WITH (oids = false);


DROP TABLE IF EXISTS "rails";
CREATE TABLE "public"."rails" (
    "rails_id" bigint NOT NULL,
    "rails_name" character varying(40) NOT NULL,
    "capacity_rails" integer NOT NULL,
    CONSTRAINT "rails_pkey" PRIMARY KEY ("rails_id")
) WITH (oids = false);


DROP TABLE IF EXISTS "route";
CREATE TABLE "public"."route" (
    "route_id" bigint NOT NULL,
    "route_name" character varying(40) NOT NULL,
    "valid" character varying(40),
    CONSTRAINT "route_pkey" PRIMARY KEY ("route_id")
) WITH (oids = false);

-- ERROR:  ijin ditolak untuk relasi route

DROP TABLE IF EXISTS "city";
CREATE TABLE "public"."city" (
    "city_id" bigint NOT NULL,
    "city_name" character varying(40) NOT NULL,
    "valid" character varying(40),
    CONSTRAINT "city_pkey" PRIMARY KEY ("city_id")
) WITH (oids = false);


-- 2017-09-16 22:03:45.422098+07

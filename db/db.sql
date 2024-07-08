CREATE DATABASE ayni;

CREATE TYPE "project_file_type" AS ENUM (
  'image',
  'extra_file'
);

CREATE TABLE "files" (
  "file_id" varchar2(36) PRIMARY KEY,
  "filename" varchar2(255) NOT NULL,
  "file_extension" varchar2(255) NOT NULL,
  "file_path" varchar2(255) NOT NULL,
  "full_path" varchar2(255) NOT NULL,
  "file_weight" decimal(15,2) NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null
);

CREATE TABLE "countries" (
  "code" varchar2(2) PRIMARY KEY,
  "country_name" varchar2(20) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null
);

CREATE TABLE "profile" (
  "profile_id" varchar(36) PRIMARY KEY,
  "profile_name" varchar(100) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null
);

CREATE TABLE "user_profile" (
  "user_id" varchar(36) NOT NULL,
  "profile_id" varchar(36) NOT NULL
);

CREATE TABLE "job" (
  "job_id" varchar2(36) PRIMARY KEY,
  "name" varchar2(150) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null
);

CREATE TABLE "users" (
  "user_id" varchar2(36) PRIMARY KEY,
  "name" varchar2(100) NOT NULL,
  "first_last_name" varchar(100) NOT NULL,
  "second_last_name" varchar(100) NOT NULL,
  "email" varchar(255) UNIQUE NOT NULL,
  "country_code" varchar2(2) NOT NULL,
  "linkedin_url" varchar2(255) DEFAULT null,
  "orcid_code" varchar2(255) DEFAULT null,
  "web_url" varchar2(255) DEFAULT null,
  "username" varchar(50),
  "verification" tinyint(1) NOT NULL DEFAULT 0,
  "file_id_avatar" varchar2(36) DEFAULT null,
  "file_id_banner" varchar2(36) DEFAULT null,
  "job_id" varchar2(36) NOT NULL,
  "job_description" varchar(150) DEFAULT null,
  "password" varchar(255) DEFAULT null,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null,
  "banned_at" timestamp DEFAULT null
);

CREATE TABLE "organization_type" (
  "organization_type_id" varchar(36) PRIMARY KEY,
  "organization_type" varchar(36) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null
);

CREATE TABLE "organizations" (
  "organization_id" varchar2(36) PRIMARY KEY,
  "name" varchar2(200) UNIQUE NOT NULL,
  "description" varchar2(255) NOT NULL,
  "country_code" varchar2(2) NOT NULL,
  "organization_type_id" varchar2(36) NOT NULL,
  "linkedin_url" varchar2(2) DEFAULT null,
  "web_url" varchar2(255) DEFAULT null,
  "verification" tinyint(1) NOT NULL DEFAULT 0,
  "latitude" float DEFAULT null,
  "longitude" float DEFAULT null,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null,
  "banned_at" timestamp DEFAULT null
);

CREATE TABLE "networks" (
  "network_id" varchar2(36) PRIMARY KEY,
  "name" varchar2(200) UNIQUE NOT NULL,
  "description" varchar2(255) NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null,
  "banned_at" timestamp DEFAULT null
);

CREATE TABLE "network_organization" (
  "network_id" varchar2(36),
  "organization_id" varchar2(36)
);

CREATE TABLE "project_type" (
  "project_type_id" varchar2(36) PRIMARY KEY,
  "project_type" varchar2(150) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null
);

CREATE TABLE "project_status" (
  "project_status_id" varchar(36) PRIMARY KEY,
  "project_status" varchar(150) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null
);

CREATE TABLE "currency" (
  "currency_id" varchar(36) PRIMARY KEY,
  "currency" varchar(100) UNIQUE NOT NULL,
  "symbol" varchar(10) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null
);

CREATE TABLE "projects" (
  "project_id" varchar2(36) PRIMARY KEY,
  "name" varchar2(200) UNIQUE NOT NULL,
  "project_url" varchar2(255) DEFAULT null,
  "description" varchar2(255) NOT NULL,
  "searching_investment" tinyint DEFAULT null,
  "searching_collaborators" tinyint DEFAULT null,
  "project_status_id" varchar(36) NOT NULL,
  "project_type_id" varchar(36) NOT NULL,
  "budgect" decimal(15,2) DEFAULT null,
  "budgect_currency_id" varchar2(36) DEFAULT null,
  "user_id" varchar2(36) NOT NULL,
  "organization_id" varchar2(36) DEFAULT null,
  "network_id" varchar2(36) DEFAULT null,
  "estimated_start" date NOT NULL,
  "estimated_end" date DEFAULT null,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null,
  "banned_at" timestamp DEFAULT null,
  "file_id_image" varchar2(36) DEFAULT null
);

CREATE TABLE "categories" (
  "category_id" varchar2(36) PRIMARY KEY,
  "name" varchar2(150) UNIQUE NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp DEFAULT null,
  "deleted_at" timestamp DEFAULT null
);

CREATE TABLE "tags" (
  "tag_id" VARCHAR2(36) PRIMARY KEY,
  "name" VARCHAR2(50),
  "category_id" varchar2(36) NOT NULL
);

CREATE TABLE "project_tag" (
  "project_id" varchar2(36) NOT NULL,
  "tag_id" varchar2(36) NOT NULL
);

CREATE TABLE "project_likes" (
  "user_id" varchar2(36) NOT NULL,
  "project_id" varchar2(36) NOT NULL
);

CREATE TABLE "project_files" (
  "project_id" varchar2(36) NOT NULL,
  "file_id" varchar2(36) NOT NULL,
  "type" project_file_type NOT NULL
);

CREATE UNIQUE INDEX "user_profile_idx" ON "user_profile" ("user_id", "profile_id");

CREATE UNIQUE INDEX "network_organization_idx" ON "network_organization" ("network_id", "organization_id");

CREATE UNIQUE INDEX "tag_category_idx" ON "tags" ("name", "category_id");

CREATE UNIQUE INDEX "tag_project_idx" ON "project_tag" ("project_id", "tag_id");

CREATE UNIQUE INDEX "user_project_idx" ON "project_likes" ("project_id", "user_id");

CREATE UNIQUE INDEX "project_file_idx" ON "project_files" ("project_id", "file_id");

ALTER TABLE "project_files" ADD FOREIGN KEY ("file_id") REFERENCES "files" ("file_id");

ALTER TABLE "project_files" ADD FOREIGN KEY ("project_id") REFERENCES "projects" ("project_id");

ALTER TABLE "job" ADD FOREIGN KEY ("job_id") REFERENCES "users" ("job_id");

ALTER TABLE "files" ADD FOREIGN KEY ("file_id") REFERENCES "projects" ("file_id_image");

ALTER TABLE "files" ADD FOREIGN KEY ("file_id") REFERENCES "users" ("file_id_avatar");

ALTER TABLE "files" ADD FOREIGN KEY ("file_id") REFERENCES "users" ("file_id_banner");

ALTER TABLE "tags" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id");

ALTER TABLE "project_tag" ADD FOREIGN KEY ("tag_id") REFERENCES "tags" ("tag_id");

ALTER TABLE "project_tag" ADD FOREIGN KEY ("project_id") REFERENCES "projects" ("project_id");

ALTER TABLE "project_likes" ADD FOREIGN KEY ("project_id") REFERENCES "projects" ("project_id");

ALTER TABLE "project_likes" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "organizations" ADD FOREIGN KEY ("organization_type_id") REFERENCES "organization_type" ("organization_type_id");

ALTER TABLE "users" ADD FOREIGN KEY ("country_code") REFERENCES "countries" ("code");

ALTER TABLE "user_profile" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "user_profile" ADD FOREIGN KEY ("profile_id") REFERENCES "profile" ("profile_id");

ALTER TABLE "projects" ADD FOREIGN KEY ("project_status_id") REFERENCES "project_status" ("project_status_id");

ALTER TABLE "projects" ADD FOREIGN KEY ("project_type_id") REFERENCES "project_type" ("project_type_id");

ALTER TABLE "projects" ADD FOREIGN KEY ("budgect_currency_id") REFERENCES "currency" ("currency_id");

ALTER TABLE "projects" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "projects" ADD FOREIGN KEY ("project_id") REFERENCES "organizations" ("organization_id");

ALTER TABLE "network_organization" ADD FOREIGN KEY ("network_id") REFERENCES "networks" ("network_id");

ALTER TABLE "network_organization" ADD FOREIGN KEY ("organization_id") REFERENCES "organizations" ("organization_id");

CREATE TABLE "User" (
	"id" uuid NOT NULL,
	"name" varchar(100) NOT NULL,
	"surname" varchar(100) NOT NULL,
	"patronymic" varchar(100) NOT NULL,
	"passport_id" uuid NOT NULL UNIQUE,
	"registration_region_id" int NOT NULL,
	CONSTRAINT User_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Passport" (
	"id" serial NOT NULL,
	"passport_number" bigint NOT NULL UNIQUE,
	"nationality" varchar(100) NOT NULL,
	"something_else" varchar(100) NOT NULL,
	CONSTRAINT Passport_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Roles" (
	"id" serial NOT NULL,
	"name" serial(100) NOT NULL,
	CONSTRAINT Roles_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "User_Role" (
	"id" serial NOT NULL,
	"user_id" uuid NOT NULL,
	"role_id" int NOT NULL,
	CONSTRAINT User_Role_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Region" (
	"id" serial NOT NULL,
	"name" varchar(200) NOT NULL UNIQUE,
	CONSTRAINT Region_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Test_request" (
	"id" serial NOT NULL,
	"user_id" uuid NOT NULL,
	"request_date" timestamp with time zone NOT NULL,
	"test_date" timestamp with time zone,
	"exam_id" uuid NOT NULL,
	"status" TEXT NOT NULL,
	CONSTRAINT Test_request_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "General_result" (
	"id" uuid NOT NULL,
	"test_request_id" uuid NOT NULL,
	"result_date" timestamp with time zone NOT NULL,
	"grade" int NOT NULL,
	CONSTRAINT General_result_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Exam" (
	"id" uuid NOT NULL,
	"status" varchar(100) NOT NULL,
	"test_id" uuid NOT NULL,
	"certificate_number" bigint NOT NULL,
	CONSTRAINT Exam_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Test_record" (
	"id" uuid NOT NULL,
	"test_request_id" uuid NOT NULL,
	"attachment_id" uuid NOT NULL,
	CONSTRAINT Test_record_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Answer_variative" (
	"id" uuid NOT NULL,
	"question_id" uuid NOT NULL,
	"answer_id" uuid NOT NULL,
	"test_request_id" uuid NOT NULL,
	CONSTRAINT Answer_variative_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Answer_free" (
	"id" uuid NOT NULL,
	"question_id" uuid NOT NULL,
	"attachment_id" uuid NOT NULL,
	"test_request_id" uuid NOT NULL,
	CONSTRAINT Answer_free_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Answer_audio" (
	"id" uuid NOT NULL,
	"question_id" uuid NOT NULL,
	"attachment_id" uuid NOT NULL,
	"test_request_id" bigint NOT NULL,
	CONSTRAINT Answer_audio_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Section_result" (
	"id" uuid NOT NULL,
	"grade_criteria_id" uuid NOT NULL,
	"grade" int NOT NULL,
	"test_request_id" uuid NOT NULL,
	CONSTRAINT Section_result_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Attachment" (
	"id" serial NOT NULL,
	"data" bytea NOT NULL,
	"path_to_file" TEXT NOT NULL,
	CONSTRAINT Attachment_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "User" ADD CONSTRAINT "User_fk0" FOREIGN KEY ("passport_id") REFERENCES "Passport"("id");
ALTER TABLE "User" ADD CONSTRAINT "User_fk1" FOREIGN KEY ("registration_region_id") REFERENCES "Region"("id");



ALTER TABLE "User_Role" ADD CONSTRAINT "User_Role_fk0" FOREIGN KEY ("user_id") REFERENCES "User"("id");
ALTER TABLE "User_Role" ADD CONSTRAINT "User_Role_fk1" FOREIGN KEY ("role_id") REFERENCES "Roles"("id");


ALTER TABLE "Test_request" ADD CONSTRAINT "Test_request_fk0" FOREIGN KEY ("user_id") REFERENCES "User"("id");
ALTER TABLE "Test_request" ADD CONSTRAINT "Test_request_fk1" FOREIGN KEY ("exam_id") REFERENCES "Exam"("id");

ALTER TABLE "General_result" ADD CONSTRAINT "General_result_fk0" FOREIGN KEY ("test_request_id") REFERENCES "Test_request"("id");

ALTER TABLE "Exam" ADD CONSTRAINT "Exam_fk0" FOREIGN KEY ("test_id") REFERENCES "Test"("id");

ALTER TABLE "Test_record" ADD CONSTRAINT "Test_record_fk0" FOREIGN KEY ("test_request_id") REFERENCES "Test_request"("id");
ALTER TABLE "Test_record" ADD CONSTRAINT "Test_record_fk1" FOREIGN KEY ("attachment_id") REFERENCES "Attachment"("id");

ALTER TABLE "Answer_variative" ADD CONSTRAINT "Answer_variative_fk0" FOREIGN KEY ("question_id") REFERENCES "Question"("id");
ALTER TABLE "Answer_variative" ADD CONSTRAINT "Answer_variative_fk1" FOREIGN KEY ("answer_id") REFERENCES "Variative_variance"("id");
ALTER TABLE "Answer_variative" ADD CONSTRAINT "Answer_variative_fk2" FOREIGN KEY ("test_request_id") REFERENCES "Test_request"("id");

ALTER TABLE "Answer_free" ADD CONSTRAINT "Answer_free_fk0" FOREIGN KEY ("question_id") REFERENCES "Question"("id");
ALTER TABLE "Answer_free" ADD CONSTRAINT "Answer_free_fk1" FOREIGN KEY ("attachment_id") REFERENCES "Attachment"("id");
ALTER TABLE "Answer_free" ADD CONSTRAINT "Answer_free_fk2" FOREIGN KEY ("test_request_id") REFERENCES "Test_request"("id");

ALTER TABLE "Answer_audio" ADD CONSTRAINT "Answer_audio_fk0" FOREIGN KEY ("question_id") REFERENCES "Question"("id");
ALTER TABLE "Answer_audio" ADD CONSTRAINT "Answer_audio_fk1" FOREIGN KEY ("attachment_id") REFERENCES "Attachment"("id");
ALTER TABLE "Answer_audio" ADD CONSTRAINT "Answer_audio_fk2" FOREIGN KEY ("test_request_id") REFERENCES "Test_request"("id");

ALTER TABLE "Section_result" ADD CONSTRAINT "Section_result_fk0" FOREIGN KEY ("grade_criteria_id") REFERENCES "Grade_criteria"("id");
ALTER TABLE "Section_result" ADD CONSTRAINT "Section_result_fk1" FOREIGN KEY ("test_request_id") REFERENCES "Test_request"("id");



CREATE TABLE "Test" (
	"id" uuid NOT NULL,
	"name" varchar(200) NOT NULL,
	"price" DECIMAL(200) NOT NULL,
	"is_free" DECIMAL(12,2) NOT NULL,
	"cert_type_id" bigint(12,2) NOT NULL,
	CONSTRAINT Test_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Certification_type" (
	"id" serial NOT NULL,
	"type" serial NOT NULL,
	CONSTRAINT Certification_type_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Question" (
	"id" uuid,
	"name" TEXT NOT NULL,
	"question_type" TEXT NOT NULL,
	"section_id" uuid NOT NULL,
	"attachment_id" uuid NOT NULL,
	CONSTRAINT Question_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Section" (
	"id" uuid NOT NULL,
	"name" TEXT NOT NULL,
	"description" TEXT NOT NULL,
	"test_id" uuid NOT NULL,
	CONSTRAINT Section_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Variative_task" (
	"id" uuid NOT NULL,
	"question_id" uuid NOT NULL,
	"answer_variant" TEXT,
	"isRight" bool NOT NULL,
	"attachment_id" uuid NOT NULL,
	CONSTRAINT Variative_task_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Attachment" (
	"id" uuid NOT NULL,
	"data" bytea,
	"path_to_file" TEXT,
	CONSTRAINT Attachment_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Grade_section" (
	"id" uuid NOT NULL,
	"section_id" uuid NOT NULL,
	"max_grade" int NOT NULL,
	CONSTRAINT Grade_section_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Grade_criteria" (
	"id" uuid NOT NULL,
	"name" TEXT NOT NULL,
	"section_id" uuid NOT NULL,
	CONSTRAINT Grade_criteria_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "Test" ADD CONSTRAINT "Test_fk0" FOREIGN KEY ("cert_type_id") REFERENCES "Certification_type"("id");


ALTER TABLE "Question" ADD CONSTRAINT "Question_fk0" FOREIGN KEY ("section_id") REFERENCES "Section"("id");
ALTER TABLE "Question" ADD CONSTRAINT "Question_fk1" FOREIGN KEY ("attachment_id") REFERENCES "Attachment"("id");

ALTER TABLE "Section" ADD CONSTRAINT "Section_fk0" FOREIGN KEY ("test_id") REFERENCES "Test"("id");

ALTER TABLE "Variative_task" ADD CONSTRAINT "Variative_task_fk0" FOREIGN KEY ("question_id") REFERENCES "Question"("id");
ALTER TABLE "Variative_task" ADD CONSTRAINT "Variative_task_fk1" FOREIGN KEY ("attachment_id") REFERENCES "Attachment"("id");


ALTER TABLE "Grade_section" ADD CONSTRAINT "Grade_section_fk0" FOREIGN KEY ("section_id") REFERENCES "Section"("id");

ALTER TABLE "Grade_criteria" ADD CONSTRAINT "Grade_criteria_fk0" FOREIGN KEY ("section_id") REFERENCES "Section"("id");


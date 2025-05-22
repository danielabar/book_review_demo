.changes on
.timer on
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "remember_created_at" datetime(6), "role" varchar DEFAULT 'user' NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email") /*application='BookReviewDemo'*/;
CREATE TABLE IF NOT EXISTS "books" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar NOT NULL, "author" varchar NOT NULL, "published_year" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE INDEX "index_books_on_title" ON "books" ("title") /*application='BookReviewDemo'*/;
CREATE INDEX "index_books_on_author" ON "books" ("author") /*application='BookReviewDemo'*/;
CREATE TABLE IF NOT EXISTS "reviews" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "book_id" integer NOT NULL, "rating" integer, "body" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_74a66bd6c5"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_924a0b30ca"
FOREIGN KEY ("book_id")
  REFERENCES "books" ("id")
);
CREATE INDEX "index_reviews_on_user_id" ON "reviews" ("user_id") /*application='BookReviewDemo'*/;
CREATE INDEX "index_reviews_on_book_id" ON "reviews" ("book_id") /*application='BookReviewDemo'*/;
CREATE UNIQUE INDEX "index_reviews_on_user_id_and_book_id" ON "reviews" ("user_id", "book_id") /*application='BookReviewDemo'*/;
INSERT INTO "schema_migrations" (version) VALUES
('20250430121821'),
('20250430121443'),
('20250429124816');


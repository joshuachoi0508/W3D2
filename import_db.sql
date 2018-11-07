-- require 'sqlite3'

-- PRAGMA foreign_keys = ON;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  author_id INTEGER,

  FOREIGN KEY(author_id) REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Josh', 'Choi'),
  ('Filipp', 'Kramer');


INSERT INTO
  questions(title, body, author_id)
VALUES
  ('SQL', 'What is SQL', 1),
  ('Military Service', 'Was I in the Military?', 2),
  ('App Academy', 'Will I make it?', 1);

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  follower_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY(follower_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  question_follows(follower_id, question_id)
VALUES
  (1, 1),
  (2, 2),
  (1, 3),
  (3, 1),
  (4, 1),
  (5, 1),
  (5, 2);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(parent_id) REFERENCES replies(id),
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  replies(parent_id, user_id, body, question_id)
VALUES
  (NULL, 1, 'YES!', 3);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  user_id INTEGER,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO
  question_likes(question_id, user_id)
VALUES
  (3, 2);

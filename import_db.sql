PRAGMA foreign_keys = ON;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255),
)

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  author_id INTEGER,

  FOREIGN KEY(author_id) REFERENCES users(id)
)

CREATE TABLE question_follows(
  author_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY(author_id) REFERENCES questions(author_id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
)

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(parent_id) REFERENCES replies(id),
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
)

CREATE TABLE question_likes (
  question_id INTEGER,
  user_id INTEGER,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
)


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

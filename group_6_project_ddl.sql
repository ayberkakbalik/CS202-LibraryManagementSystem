DROP TABLE IF EXISTS UserType;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Topic;
DROP TABLE IF EXISTS includes;
DROP TABLE IF EXISTS borrowing;
DROP TABLE IF EXISTS hold;


CREATE TABLE UserType
(
type_id        INT             NOT NULL AUTO_INCREMENT,
type_name      VARCHAR(30)     NOT NULL,
UNIQUE (type_name),
PRIMARY KEY (type_id)
);

CREATE TABLE Account
(
a_id         INT            NOT NULL AUTO_INCREMENT,
loginID  VARCHAR(30)        NOT NULL,
password     VARCHAR(40)    NOT NULL,
a_name       VARCHAR(50)    NOT NULL,
type_id      INT            NOT NULL,
UNIQUE (loginID),
PRIMARY KEY (a_id),
FOREIGN KEY (type_id) REFERENCES UserType (type_id)
);

CREATE TABLE Author
(
author_id        INT           NOT NULL AUTO_INCREMENT,
author_name      VARCHAR(50)    NOT NULL,
UNIQUE (author_name),
PRIMARY KEY (author_id)
);

CREATE TABLE Genre
(
genre_id        INT           NOT NULL AUTO_INCREMENT,
genre_name      VARCHAR(30)   NOT NULL,
UNIQUE (genre_name),
PRIMARY KEY (genre_id)
);


CREATE TABLE Book
(
book_id      INT              NOT NULL AUTO_INCREMENT,
title        VARCHAR(50)      NOT NULL,
publication_date  DATE        NOT NULL,
author_id    INT              NOT NULL,
genre_id     INT              ,
a_id         INT              ,
availability  BOOLEAN,
status       BOOLEAN DEFAULT FALSE,
UNIQUE (title, author_id),
PRIMARY KEY (book_id),
FOREIGN KEY (author_id) REFERENCES Author (author_id),
FOREIGN KEY (genre_id) REFERENCES Genre (genre_id) ON DELETE SET NULL,
FOREIGN KEY (a_id) REFERENCES Account (a_id) ON DELETE SET NULL
);

CREATE TABLE Topic
(
topic_id     INT             NOT NULL AUTO_INCREMENT,
topic_name   VARCHAR(50)     NOT NULL,
UNIQUE (topic_name),
PRIMARY KEY (topic_id)
);

CREATE TABLE includes
(
id            INT             NOT NULL AUTO_INCREMENT,
book_id       INT             NOT NULL,
topic_id      INT             NOT NULL,
UNIQUE (topic_id, book_id),
PRIMARY KEY (id),
FOREIGN KEY (book_id) REFERENCES Book (book_id) ON DELETE CASCADE,
FOREIGN KEY (topic_id) REFERENCES Topic (topic_id)
);

CREATE TABLE borrowing
(
reserve_id    INT       NOT NULL AUTO_INCREMENT,
a_id          INT       NOT NULL,
book_id       INT       NOT NULL,
borrowing_date  DATETIME    NOT NULL,
due_date      DATETIME      NOT NULL,
return_date   DATETIME,
PRIMARY KEY (reserve_id),
UNIQUE (book_id, borrowing_date),
FOREIGN KEY (a_id) REFERENCES Account (a_id) ON DELETE CASCADE,
FOREIGN KEY (book_id) REFERENCES Book (book_id) ON DELETE CASCADE
);

CREATE TABLE hold
(
a_id          INT       NOT NULL,
book_id       INT       NOT NULL,
reserve_date  DATETIME  NOT NULL,
PRIMARY KEY (book_id, reserve_date),
FOREIGN KEY (a_id) REFERENCES Account (a_id) ON DELETE CASCADE,
FOREIGN KEY (book_id) REFERENCES Book (book_id) ON DELETE CASCADE
);
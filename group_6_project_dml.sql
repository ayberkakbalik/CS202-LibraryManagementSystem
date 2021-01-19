-- UserType Table
INSERT INTO UserType (type_name) VALUES ('user');      
INSERT INTO UserType (type_name) VALUES ('publisher');    
INSERT INTO UserType (type_name) VALUES ('manager');         
-- 1 is user, 2 is publisher and 3 is manager
-- Account Table

INSERT INTO Account (loginID, password, a_name, type_id) VALUES ('firstuser','l+oV5bi5GIYDeLkhPuI68w==','Nurettin Altıntaş',1);    -- 123456
INSERT INTO Account (loginID, password, a_name, type_id) VALUES ('seconduser','l+oV5bi5GIYDeLkhPuI68w==','Ayberk Akbalık',1);
INSERT INTO Account (loginID, password, a_name, type_id) VALUES ('firstpublisher','FdWA+dIN/QcWT5lFzryowQ==','İş Bankası Yayınları',2);   -- 123
INSERT INTO Account (loginID, password, a_name, type_id) VALUES ('secondpublisher','FdWA+dIN/QcWT5lFzryowQ==','İletişim Yayınları',2);
INSERT INTO Account (loginID, password, a_name, type_id) VALUES ('thirdpublisher','FdWA+dIN/QcWT5lFzryowQ==','Can Yayınları',2);
INSERT INTO Account (loginID, password, a_name, type_id) VALUES ('firstmanager','f43XM33XuGng8SnEELhCVg==','Luke Skywalker',3);   -- 1234
INSERT INTO Account (loginID, password, a_name, type_id) VALUES ('secondmanager','f43XM33XuGng8SnEELhCVg==','Darth Vader',3);

-- Author Table
INSERT INTO Author (author_name) VALUES ('Dostoyevski');
INSERT INTO Author (author_name) VALUES ('Gogol');
INSERT INTO Author (author_name) VALUES ('Tolstoy');
INSERT INTO Author (author_name) VALUES ('Puşkin');
INSERT INTO Author (author_name) VALUES ('Halil İnalcık');
INSERT INTO Author (author_name) VALUES ('İlber Ortaylı');
INSERT INTO Author (author_name) VALUES ('Eric Hobsbawm');
INSERT INTO Author (author_name) VALUES ('Ayşen Yarat');
INSERT INTO Author (author_name) VALUES ('Gary Marcus');
INSERT INTO Author (author_name) VALUES ('Max Tegmark');
INSERT INTO Author (author_name) VALUES ('Stephan King');
INSERT INTO Author (author_name) VALUES ('Arthur Conan Doyle');
INSERT INTO Author (author_name) VALUES ('J.R.R. Tolkien');

-- Genre Table
INSERT INTO Genre (genre_name) VALUES ('Academic Literature');
INSERT INTO Genre (genre_name) VALUES ('Poetry');
INSERT INTO Genre (genre_name) VALUES ('Classics');
INSERT INTO Genre (genre_name) VALUES ('Art');
INSERT INTO Genre (genre_name) VALUES ('Philosophy');
INSERT INTO Genre (genre_name) VALUES ('History');
INSERT INTO Genre (genre_name) VALUES ('Popular Science');
INSERT INTO Genre (genre_name) VALUES ('Biography');
INSERT INTO Genre (genre_name) VALUES ('Business');
INSERT INTO Genre (genre_name) VALUES ('Cooking');
INSERT INTO Genre (genre_name) VALUES ('Contemporary');
INSERT INTO Genre (genre_name) VALUES ('Science Fiction');
INSERT INTO Genre (genre_name) VALUES ('Fantasy Fiction');
INSERT INTO Genre (genre_name) VALUES ('Detective Fiction');
INSERT INTO Genre (genre_name) VALUES ('Historical Fiction');
INSERT INTO Genre (genre_name) VALUES ('Horror');
INSERT INTO Genre (genre_name) VALUES ('Graphic Novel');
INSERT INTO Genre (genre_name) VALUES ('Short Stories');
INSERT INTO Genre (genre_name) VALUES ('Self-Help');
INSERT INTO Genre (genre_name) VALUES ('Travel');


-- Book Table
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Suç ve Ceza', '1867-10-10', 1, 3, 3, false, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Karamazov Kardeşler', '1873-11-11', 1, 3, 4, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Ölü Canlar', '1845-10-10', 2, 3, 5, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Bir Delinin Hatıra Defteri', '1842-10-10', 2, 18, 3, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Savaş ve Barış', '1888-10-10', 3, 3, 4, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Anna Karenina', '1888-10-10', 3, 3, 5, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Yüzbaşının Kızı', '1831-10-10', 4, 3, 3, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Devleti Aliyye I', '1998-10-10', 5, 6, 4, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Devleti Aliyye II', '2002-10-10', 5, 6, 5, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('İmparatorluktan Cumhuriyete', '2007-10-10', 5, 6, 3, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Eski Dünya Seyahatnamesi', '2016-10-10', 6, 20, 4, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Bir Ömür Nasıl Yaşanır?', '2016-10-10', 6, 19, 5, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Türklerin Tarihi', '2018-10-10', 6, 7, 3, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Sermaye Çağı', '2010-10-10', 7, 6, 3, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('İmparatorluk Çağı', '2011-10-10', 7, 6, 3, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Devrim Çağı', '2012-9-10', 7, 6, 4, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Aşırılıklar Çağı', '2013-12-10', 7, 6, 4, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Biyokimyada Temel Konular', '1998-12-12', 8, 7, 4, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Rebooting AI', '2019-01-18', 9, 1, 4, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('What is the Machine Learning?', '2019-01-18', 10, 1, 5, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('IT', '1993-01-18', 11, 1, 5, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('Sherlock Holmes', '1893-01-18', 12, 14, 5, true, true);
INSERT INTO Book (title, publication_date, author_id, genre_id, a_id, availability, status) VALUES ('The Lord of the Rings', '1934-01-18', 13, 13, 5, true, true);

-- Topic Table
INSERT INTO Topic (topic_name) VALUES ('Artificial Intelligence');
INSERT INTO Topic (topic_name) VALUES ('Machine Learning');
INSERT INTO Topic (topic_name) VALUES ('Introduction to Intelligent Systems');
INSERT INTO Topic (topic_name) VALUES ('Introduction to Calculus');
INSERT INTO Topic (topic_name) VALUES ('Intermediate Calculus');
INSERT INTO Topic (topic_name) VALUES ('Physics 101');
INSERT INTO Topic (topic_name) VALUES ('Atomic Theory');
INSERT INTO Topic (topic_name) VALUES ('Biology 101');
INSERT INTO Topic (topic_name) VALUES ('Biophysics');
INSERT INTO Topic (topic_name) VALUES ('Biochemistry');
INSERT INTO Topic (topic_name) VALUES ('Chemistry 101');
INSERT INTO Topic (topic_name) VALUES ('Organic Compounds');
INSERT INTO Topic (topic_name) VALUES ('War');
INSERT INTO Topic (topic_name) VALUES ('Love');
INSERT INTO Topic (topic_name) VALUES ('Ottoman Empire');
INSERT INTO Topic (topic_name) VALUES ('Live better');
INSERT INTO Topic (topic_name) VALUES ('History of 19th Century');
INSERT INTO Topic (topic_name) VALUES ('History of 20th Century');
INSERT INTO Topic (topic_name) VALUES ('Whodunit');
INSERT INTO Topic (topic_name) VALUES ('Good vs. Evil');
INSERT INTO Topic (topic_name) VALUES ('Conscience');
INSERT INTO Topic (topic_name) VALUES ('Conflict of Generations');
INSERT INTO Topic (topic_name) VALUES ('Turkish Modernization');
INSERT INTO Topic (topic_name) VALUES ('Turkish History');

-- includes Table
INSERT INTO includes (book_id, topic_id) VALUES (1, 20);
INSERT INTO includes (book_id, topic_id) VALUES (1, 21);
INSERT INTO includes (book_id, topic_id) VALUES (2, 22);
INSERT INTO includes (book_id, topic_id) VALUES (3, 22);
INSERT INTO includes (book_id, topic_id) VALUES (5, 13);
INSERT INTO includes (book_id, topic_id) VALUES (6, 14);
INSERT INTO includes (book_id, topic_id) VALUES (7, 14);
INSERT INTO includes (book_id, topic_id) VALUES (8, 15);
INSERT INTO includes (book_id, topic_id) VALUES (9, 15);
INSERT INTO includes (book_id, topic_id) VALUES (10, 23);
INSERT INTO includes (book_id, topic_id) VALUES (10, 24);
INSERT INTO includes (book_id, topic_id) VALUES (13, 24);
INSERT INTO includes (book_id, topic_id) VALUES (14, 17);
INSERT INTO includes (book_id, topic_id) VALUES (15, 17);
INSERT INTO includes (book_id, topic_id) VALUES (16, 18);
INSERT INTO includes (book_id, topic_id) VALUES (17, 18);
INSERT INTO includes (book_id, topic_id) VALUES (18, 10);
INSERT INTO includes (book_id, topic_id) VALUES (18, 12);
INSERT INTO includes (book_id, topic_id) VALUES (19, 1);
INSERT INTO includes (book_id, topic_id) VALUES (19, 3);
INSERT INTO includes (book_id, topic_id) VALUES (20, 1);
INSERT INTO includes (book_id, topic_id) VALUES (20, 2);
INSERT INTO includes (book_id, topic_id) VALUES (21, 20);
INSERT INTO includes (book_id, topic_id) VALUES (22, 19);
INSERT INTO includes (book_id, topic_id) VALUES (23, 20);

-- Borrowing Table
INSERT INTO borrowing (a_id, book_id, borrowing_date, due_date, return_date) VALUES (1, 1, NOW(), NOW(), null);


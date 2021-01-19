package edu.ozu.cs202project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.List;

@Service
public class AppService {
    @Autowired
    JdbcTemplate conn;

    //adds book to database
    public void addBook(String title, String genreId, String authorName, String publisherId, Date date, String topic, int status) {
        String id = getAuthor(authorName)[0]; //get author id
        topic = getTopic(topic)[0]; //get topic id

        conn.update("INSERT INTO Book " +
                "(title,publication_date,author_id, genre_id,a_id,availability,status) " +
                "VALUES (?,?,?,?,?,1,?)", title, date, id, genreId, publisherId, status);

        addToIncludes(title, id, topic); //add book to includes table
    }

    //returns topic
    private String[] getTopic(String topic) {
        String query = String.format("SELECT * FROM Topic WHERE topic_name = '%s'", topic);
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("topic_id"),
                    row.getString("topic_name")
            };
        });
        if (data.size() == 0) { //if there is no topic with name
            addTopic(topic); // adds topic to database
            return getTopic(topic); //returns topic
        }
        return data.get(0);
    }

    //adds topic to database
    private void addTopic(String topic) {
        conn.update("INSERT INTO Topic (topic_name) VALUES (?)", topic);
    }

    //adds book_id and topic_id to includes table
    private void addToIncludes(String title, String id, String topic) {
        conn.update("INSERT INTO includes (book_id,topic_id) VALUES ((SELECT book_id FROM Book WHERE title = ? AND author_id = ?),?)", title, id, topic);
    }

    //adds author to database
    private void addAuthor(String name) {
        conn.update("INSERT INTO Author (author_name) VALUES (?)", name);
    }

    //returns author
    public String[] getAuthor(String name) {
        String query = String.format("SELECT * FROM Author WHERE author_name = '%s'", name);
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("author_id"),
                    row.getString("author_name")
            };
        });
        if (data.size() == 0) { //if there is no author with name
            addAuthor(name); //adds author to database
            return getAuthor(name); //returns author
        }
        return data.get(0);
    }

    //returns all available books
    public List<String[]> getBooks() {
        List<String[]> data = conn.query("SELECT * FROM Book WHERE availability = 1", (row, index) -> {
            return new String[]{
                    row.getString("book_id"),
                    row.getString("title")
            };
        });
        return data;
    }

    //returns all genres
    public List<String[]> getGenres() {
        List<String[]> data = conn.query("SELECT * FROM Genre", (row, index) -> {
            return new String[]{
                    row.getString("genre_id"),
                    row.getString("genre_name")
            };
        });
        return data;
    }
    //returns all publishers
    public List<String[]> getPublishers() {
        List<String[]> data = conn.query("SELECT * FROM Account WHERE type_id = '2'", (row, index) -> {
            return new String[]{
                    row.getString("a_id"),
                    row.getString("a_name")
            };
        });
        return data;
    }
}

package edu.ozu.cs202project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Service
public class UserService {
    @Autowired
    JdbcTemplate conn;

    //returns all available books from library
    public List<String[]> getLibrary() {
        List<String[]> data = conn.query("SELECT * FROM Book WHERE availability = '1'", (row, index) -> {
            return new String[]{
                    row.getString("title"),
                    row.getString("publication_date"),
                    (String) conn.queryForList(" SELECT author_name FROM Author WHERE author_id = ?", row.getString("author_id")).get(0).get("author_name"),
                    (String) conn.queryForList(" SELECT genre_name FROM Genre WHERE genre_id = ?", row.getString("genre_id")).get(0).get("genre_name"),
                    (String) conn.queryForList(" SELECT a_name FROM Account WHERE a_id = ?", row.getString("a_id")).get(0).get("a_name"),
                    row.getString("availability"),
                    row.getString("book_id"),
            };
        });
        return data;
    }

    //borrows book
    public void borrowBook(String userId, String bookId) {
        Timestamp time = new Timestamp(System.currentTimeMillis()); //gets now date
        Timestamp due = new Timestamp(System.currentTimeMillis() + (14 * 24 * 3600 * 1000)); //set due date to 14 days later
        conn.update("INSERT INTO borrowing (a_id,book_id,borrowing_date,due_date) VALUES (?,?,?,?)", userId, bookId, time, due); //add data to borrowing table
        conn.update("UPDATE Book SET availability = 0 WHERE book_id = ?", bookId); //set availability of book 1 to 0
    }

    //returns user's borrowing history
    public List<String[]> getHistory(String id) {
        String query = String.format("SELECT * FROM borrowing WHERE a_id = %s", id);
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    (String) conn.queryForList(" SELECT title FROM Book WHERE book_id = ?", row.getString("book_id")).get(0).get(("title")),
                    row.getString("borrowing_date"),
                    row.getString("due_date"),
                    row.getString("reserve_id"),
                    row.getString("book_id"),
                    row.getString("return_date"),
            };
        });
        return data;
    }

    //returns book
    public void returnBook(String reserveId, String bookId) {
        Timestamp time = new Timestamp(System.currentTimeMillis()); //gets now date
        conn.update("UPDATE borrowing SET return_date = ? WHERE reserve_id = ?", time, reserveId); //set return date of the book to current date
        conn.update("UPDATE Book SET availability = 1 WHERE book_id = ?", bookId); //set availability of book 0 to 1
    }

    //returns search results
    public List<String[]> search(String title, String author, String availability, String year, String genre, String publisher) {
        String query = "SELECT * FROM Book WHERE book_id > 0";
        author = getAuthor(author);
        if (!title.isEmpty()) {
            query += String.format(" AND title = '%s'", title);
        }
        if (!author.isEmpty()) {
            query += String.format(" AND author_id = '%s'", author);
        }
        if (!availability.isEmpty()) {
            query += String.format(" AND availability = '%s'", availability);
        }
        if (!year.isEmpty()) {
            query += String.format(" AND publication_date > '%s-01-01' AND publication_date < '%s-12-31'", year, year);
        }
        if (!genre.isEmpty()) {
            query += String.format(" AND genre_id = '%s'", genre);
        }
        if (!publisher.isEmpty()) {
            query += String.format(" AND a_id = '%s'", publisher);
        }
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("title"),
                    row.getString("publication_date"),
                    (String) conn.queryForList(" SELECT author_name FROM Author WHERE author_id = ?", row.getString("author_id")).get(0).get(("author_name")),
                    (String) conn.queryForList(" SELECT genre_name FROM Genre WHERE genre_id = ?", row.getString("genre_id")).get(0).get("genre_name"),
                    (String) conn.queryForList(" SELECT a_name FROM Account WHERE a_id = ?", row.getString("a_id")).get(0).get("a_name"),
                    row.getString("availability"),
                    row.getString("book_id"),
            };
        });
        return data;
    }

    //returns author id
    public String getAuthor(String name) {
        List<Map<String, Object>> author = conn.queryForList(" SELECT author_id FROM Author WHERE author_name = ?", name);
        if (author.size() != 0) {
            return author.get(0).get("author_id").toString();
        }
        return "";
    }

    //returns overdue times
    public String getOverdueBooks(String id) {
        String query = String.format("SELECT count(*) AS overdue_times FROM ((borrowing INNER JOIN Book ON borrowing.book_id = Book.book_id) INNER JOIN Genre ON Book.genre_id = Genre.genre_id) WHERE due_date < return_date AND borrowing.a_id = '%s'", id);
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("overdue_times"),
            };
        });
        if (data.size() != 0) {
            return data.get(0)[0];
        }
        return "";
    }

    //returns favorite genre
    public String getFavoriteGenre(String id) {
        String query = String.format("SELECT count(*) AS counter,genre_name FROM ((borrowing INNER JOIN Book ON borrowing.book_id = Book.book_id) INNER JOIN Genre ON Book.genre_id = Genre.genre_id) WHERE borrowing.a_id = '%s' GROUP BY genre_name ORDER BY counter DESC LIMIT 1", id);
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("genre_name")
            };
        });
        if (data.size() != 0) {
            return data.get(0)[0];
        }
        return "";
    }

    //holds book
    public void holdBook(String userId, String bookId) {
        Timestamp date = new Timestamp(System.currentTimeMillis()); //get now date
        conn.update("INSERT INTO hold(a_id,book_id,reserve_date) VALUES (?,?,?)", userId, bookId, date); //add book to hold table
    }

    //returns books which availability is 0 and not held
    public List<String[]> getBooks(String id) {
        String query = String.format("SELECT * FROM Book where availability = 0 AND book_id NOT IN (SELECT book_id FROM hold WHERE hold.a_id= '%s')", id);
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("book_id"),
                    row.getString("title")
            };
        });
        return data;
    }

    //returns held books
    public List<String[]> getHolds(String id) {
        String query = String.format("SELECT * FROM hold INNER JOIN Book ON Book.book_id = hold.book_id WHERE hold.a_id = %s", id);
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("title"),
                    row.getString("reserve_date")
            };
        });
        return data;
    }
}

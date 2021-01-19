package edu.ozu.cs202project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.sql.Date;
import java.util.List;

@Service
public class ManagerService {
    @Autowired
    JdbcTemplate conn;

    //returns borrow history
    public List<String[]> getHistory() {
        List<String[]> data = conn.query("SELECT * FROM borrowing WHERE return_date IS NULL", (row, index) -> {
            return new String[]{
                    (String) conn.queryForList(" SELECT a_name FROM Account WHERE a_id = ?", row.getString("a_id")).get(0).get("a_name"),
                    (String) conn.queryForList(" SELECT title FROM Book WHERE book_id = ?", row.getString("book_id")).get(0).get("title"),
                    row.getString("borrowing_date"),
                    row.getString("due_date"),
                    row.getString("return_date"),
                    row.getString("reserve_id"),
                    row.getString("book_id"),
            };
        });
        return data;
    }

    //adds publisher to database
    public void addPublisher(String username, String password, String name) {
        conn.update("INSERT INTO Account (loginID,password,a_name,type_id) VALUES (?,?,?,2)", username, password, name);
    }

    //returns add requests
    public List<String[]> getRequests() {
        List<String[]> data = conn.query("SELECT * FROM Book WHERE status = 0", (row, index) -> {
            return new String[]{
                    row.getString("title"),
                    row.getString("publication_date"),
                    (String) conn.queryForList(" SELECT author_name FROM Author WHERE author_id = ?", row.getString("author_id")).get(0).get(("author_name")),
                    (String) conn.queryForList(" SELECT genre_name FROM Genre WHERE genre_id = ?", row.getString("genre_id")).get(0).get("genre_name"),
                    (String) conn.queryForList(" SELECT a_name FROM Account WHERE a_id = ?", row.getString("a_id")).get(0).get("a_name"),
                    row.getString("book_id"),
            };
        });
        return data;
    }

    //approves request of adding book.
    //updates status of book 0 to 1 in database
    public void approveRequest(String id) {
        conn.update("UPDATE Book SET status = 1 WHERE book_id = ?", id);
    }

    //declines request of adding book
    //removes book from database
    public void declineRequest(String id) {
        conn.update("DELETE FROM Book WHERE book_id = ?", id);
    }

    //returns all users from database
    public List<String[]> getUsers() {
        List<String[]> data = conn.query("SELECT * FROM Account WHERE type_id = 1", (row, index) -> {
            return new String[]{
                    row.getString("a_id"),
                    row.getString("a_name")
            };
        });
        return data;
    }

    //assigns book to user
    public void assign(String accountId, String bookId) {
        Timestamp time = new Timestamp(System.currentTimeMillis()); //gets now date
        Timestamp due = new Timestamp(System.currentTimeMillis() + (14 * 24 * 3600 * 1000)); //set due date to 14 days later
        conn.update("INSERT INTO borrowing (a_id,book_id,borrowing_date,due_date) VALUES (?,?,?,?)", accountId, bookId, time, due);
        conn.update("UPDATE Book SET availability = 0 WHERE book_id = ?", bookId);
    }

    //unassigns book
    public void unassign(String reserveId, String bookId) {
        Timestamp time = new Timestamp(System.currentTimeMillis()); //gets now date
        conn.update("UPDATE borrowing SET return_date = ? WHERE reserve_id = ?", time, reserveId);
        conn.update("UPDATE Book SET availability = 1 WHERE book_id = ?", bookId);
    }

    //removes book from database
    public void removeBook(String id) {
        conn.update("DELETE FROM Book WHERE book_id = ?", id);
    }

    //returns most borrowed genres
    public List<String[]> getMostBorrowed() {
        String query = String.format("SELECT count(*) AS borrowed_times, genre_name FROM ((borrowing INNER JOIN Book ON borrowing.book_id = Book.book_id) INNER JOIN Genre ON Book.genre_id = Genre.genre_id) Group BY genre_name ORDER BY borrowed_times DESC");
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("borrowed_times"),
                    row.getString("genre_name")
            };
        });
        return data;
    }

    //returns most borrowed books in last 3 months
    public List<String[]> getMostBorrowedLast3Months() {
        Date date = new Date(System.currentTimeMillis() - (90L * 24 * 3600 * 1000)); //set date to 3 months ago
        String query = String.format("SELECT count(*) as borrowed_times, title FROM ((borrowing INNER JOIN Book ON borrowing.book_id = Book.book_id)) WHERE borrowing_date > '%s' Group BY title ORDER BY borrowed_times DESC LIMIT 10", date);
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("borrowed_times"),
                    row.getString("title")
            };
        });
        return data;
    }

    //returns most borrowed publisher
    public List<String[]> getMostBorrowedPublishers() {
        String query = String.format("SELECT count(*) AS borrowed_times, a_name FROM ((borrowing INNER JOIN Book ON borrowing.book_id = Book.book_id) INNER JOIN Account ON Account.a_id = Book.a_id) Group BY a_name ORDER BY borrowed_times DESC");
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("borrowed_times"),
                    row.getString("a_name")
            };
        });
        return data;
    }

    //returns overdue times
    public String getOverdue() {
        List<String[]> data = conn.query("SELECT count(*) AS borrowed_times FROM ((borrowing INNER JOIN Book ON borrowing.book_id = Book.book_id) INNER JOIN Genre ON Book.genre_id = Genre.genre_id) WHERE due_date < return_date", (row, index) -> {
            return new String[]{
                    row.getString("borrowed_times"),
            };
        });
        return data.get(0)[0];
    }

    //returns users borrowed books
    public List<String[]> getBorrowedUsers() {
        List<String[]> data = conn.query("SELECT DISTINCT a_name FROM borrowing INNER JOIN Account ON borrowing.a_id = Account.a_id WHERE borrowing.book_id = (SELECT book_id FROM borrowing GROUP BY book_id LIMIT 1)", (row, index) -> {
            return new String[]{
                    row.getString("a_name")};
        });
        return data;
    }

    //returns overdue books
    public List<String[]> getOverdueBooks() {
        List<String[]> data = conn.query("SELECT count(*) AS borrowed_times,title FROM borrowing inner join Book on borrowing.book_id = Book.book_id where return_date > due_date group by title ORDER BY borrowed_times DESC", (row, index) -> {
            return new String[]{
                    row.getString("borrowed_times"),
                    row.getString("title")
            };
        });
        return data;
    }
}


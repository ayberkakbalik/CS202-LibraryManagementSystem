package edu.ozu.cs202project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PublisherService {
    @Autowired
    JdbcTemplate conn;

    //returns how many times borrowed publisher's books
    public String getBorrowedBooks(String id) {
        String query = String.format("SELECT count(*) AS borrowed_times FROM (borrowing INNER JOIN Book ON borrowing.book_id = Book.book_id) WHERE Book.a_id = '%s'", id);
        List<String[]> data = conn.query(query, (row, index) -> {
            return new String[]{
                    row.getString("borrowed_times"),
            };
        });
        return data.get(0)[0];
    }
}

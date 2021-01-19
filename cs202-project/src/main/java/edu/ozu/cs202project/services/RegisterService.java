package edu.ozu.cs202project.services;

import edu.ozu.cs202project.Salter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RegisterService {
    @Autowired
    JdbcTemplate conn;

    public Object register(String username, String password, String name) {

        conn.update("INSERT INTO Account (loginID,password,a_name,type_id) VALUES (?,?,?,1)", username, password, name);
        List<Map<String, Object>> response = conn.queryForList("SELECT a_id FROM Account WHERE loginID = ?", username);
        return response.get(0).get("a_id");
    }
}

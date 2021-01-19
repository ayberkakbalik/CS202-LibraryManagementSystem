package edu.ozu.cs202project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class LoginService {
    @Autowired
    JdbcTemplate conn;

    public Map<String, Object> validate(String username, String password) {
        List<Map<String, Object>> response = conn.queryForList("SELECT type_id,a_id FROM Account WHERE loginID = ? AND password = ?", new Object[]{username, password});
        if (response.size() == 0){
            return null;
        }
        return response.get(0);
    }
}

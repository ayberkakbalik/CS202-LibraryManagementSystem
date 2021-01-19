package edu.ozu.cs202project.controllers;

import edu.ozu.cs202project.Salter;
import edu.ozu.cs202project.services.LoginService;
import edu.ozu.cs202project.services.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

import java.util.Map;

@Controller
@RequestMapping("/")
@SessionAttributes({"username", "level", "id"})
public class AppController {
    @Autowired
    LoginService service;
    @Autowired
    RegisterService registerService;

    // Login
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(ModelMap model, @RequestParam String username, @RequestParam String password) {

        password = Salter.salt(password, "CS202Project");
        Map<String, Object> user = service.validate(username, password);
        if (user == null) {
            model.put("errorMessage", "Invalid User");
            return "login";
        }
        model.put("username", username);
        model.put("level", user.get("type_id"));
        model.addAttribute("id", user.get("a_id"));

        if (user.get("type_id").equals(1)) {
            return "redirect:/";          //user'ın anasayfasına yönlendir
        } else if (user.get("type_id").equals(2)) {
            return "redirect:/publisher";        //publisherın sayfasına yönlendir
        }
        return "redirect:/manager";
    }

    // Register
    @GetMapping("/register")
    public String registerPage(ModelMap model) {
        return "user/register";
    }

    @PostMapping("/register")
    public String register(ModelMap model, @RequestParam String username, @RequestParam String password, @RequestParam String name) {
        password = Salter.salt(password, "CS202Project");
        try {
            Object id = registerService.register(username, password, name);
            model.put("username", username);
            model.put("level", 1);
            model.put("id", id);
        } catch (Exception e) {
            model.put("message","There was an error occurred when tried to register");
            return "user/register";
        }

        return "redirect:/";        //user anasayfasına yönlendir
    }

    //Logout
    @GetMapping("/logout")
    public String logout(ModelMap model, WebRequest request, SessionStatus session) {
        session.setComplete();
        request.removeAttribute("username", WebRequest.SCOPE_SESSION);
        return "redirect:/login";
    }
}

package edu.ozu.cs202project.controllers;

import edu.ozu.cs202project.services.AppService;
import edu.ozu.cs202project.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/")
@SessionAttributes({"books", "history", "overdue", "genre", "id", "holds", "genres", "publishers","borrowedTime"})
@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private AppService appService;

    @GetMapping
    public String userPage(ModelMap model) {
        try {
            String id = model.getAttribute("id").toString();
            String overdue = userService.getOverdueBooks(id);
            String genre = userService.getFavoriteGenre(id);
            String borrowedTime = Integer.toString(userService.getHistory(id).size());
            model.addAttribute("overdue", overdue);
            model.addAttribute("genre", genre);
            model.addAttribute("borrowedTime", borrowedTime);
        }catch (Exception e) {
            model.put("message", "Not Allowed");
        }
        return "user/index";

    }

    @GetMapping("/library")
    public String libraryPage(ModelMap model) {
        List<String[]> library = userService.getLibrary();
        model.addAttribute("books", library.toArray(new String[0][7]));

        return "user/library";
    }

    @PostMapping("/borrow/{userId}/{BookId}")
    public String borrowBook(ModelMap map, @PathVariable String userId, @PathVariable String BookId) {
        userService.borrowBook(userId, BookId);
        return "redirect:/library";
    }

    @GetMapping("/hold/{id}")
    public String holdBookPage(ModelMap model, @PathVariable String id) {
        List<String[]> data = userService.getBooks(id);
        List<String[]> holds = userService.getHolds(id);
        model.addAttribute("books", data.toArray(new String[0][2]));
        model.addAttribute("holds", holds.toArray(new String[0][2]));
        return "user/hold";
    }

    @PostMapping("/hold/{id}")
    public String holdBook(ModelMap map, @PathVariable String id, @RequestParam String bookId) {
        userService.holdBook(id, bookId);
        return "redirect:/hold/{id}";
    }

    @PostMapping("/return/{userId}/{reserveId}/{BookId}")
    public String returnBook(ModelMap map, @PathVariable String reserveId, @PathVariable String BookId, @PathVariable String userId) {
        userService.returnBook(reserveId, BookId);
        return "redirect:/{userId}/borrow-history";
    }

    @GetMapping("/{id}/borrow-history")
    public String historyPage(ModelMap model, @PathVariable String id) {
        List<String[]> data = userService.getHistory(id);
        model.addAttribute("history", data.toArray(new String[0][6]));
        return "user/history";
    }

    @GetMapping("/search")
    public String searchPage(ModelMap model) {
        List<String[]> genres = appService.getGenres();
        List<String[]> publishers = appService.getPublishers();
        model.addAttribute("genres", genres.toArray(new String[0][2]));
        model.addAttribute("publishers", publishers.toArray(new String[0][2]));

        return "user/search";
    }

    @PostMapping("/search")
    public String search(ModelMap model, @RequestParam String title, @RequestParam String author, @RequestParam String availability, @RequestParam String year, @RequestParam String genre, @RequestParam String publisher) {

        List<String[]> data = userService.search(title, author, availability, year, genre, publisher);
        model.addAttribute("books", data.toArray(new String[0][7]));
        return "user/result";
    }

}

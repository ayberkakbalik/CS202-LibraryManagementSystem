package edu.ozu.cs202project.controllers;

import edu.ozu.cs202project.services.AppService;
import edu.ozu.cs202project.services.PublisherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;

@Controller
@RequestMapping("/publisher")
@SessionAttributes({"books", "genres", "borrowed", "id"})

public class PublisherController {
    @Autowired
    private PublisherService publisherService;
    @Autowired
    private AppService appService;

    @GetMapping
    public String publisher(ModelMap model) {
        try {
            String id = model.getAttribute("id").toString();
            String borrowed = publisherService.getBorrowedBooks(id);
            model.addAttribute("borrowed", borrowed);

        }catch (Exception e){
            model.put("message", "Not Allowed");
        }
        return "publisher/index";
    }

    @GetMapping("/add-book")
    public String addBookPage(ModelMap model) {
        List<String[]> genres = appService.getGenres();
        model.addAttribute("genres", genres.toArray(new String[0][2]));
        return "publisher/addBook";
    }

    @PostMapping("/add-book/{id}")
    public String addBook(ModelMap model, @RequestParam String title, @RequestParam String genreId, @RequestParam String authorId, @RequestParam Date date, @PathVariable String id, @RequestParam String topic) {
        try {
            appService.addBook(title, genreId, authorId, id, date, topic,0);
            model.put("message", "Book added");
        } catch (Exception e) {
            model.put("message", "There was an error occurred when tried to add book");
        }
        return "publisher/addBook";
    }

}

package edu.ozu.cs202project.controllers;

import edu.ozu.cs202project.Salter;
import edu.ozu.cs202project.services.AppService;
import edu.ozu.cs202project.services.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;

@Controller
@RequestMapping("/manager")
@SessionAttributes({"history", "requests", "users", "books", "genres", "publishers", "mostBorrowed", "mostBorrowed3Months", "overdue", "overdueBooks"})

public class ManagerController {
    @Autowired
    private ManagerService managerService;
    @Autowired
    private AppService appService;

    @GetMapping
    public String managerPage(ModelMap model) {
        List<String[]> mostBorrowed = managerService.getMostBorrowed();
        List<String[]> mostBorrowed3Months = managerService.getMostBorrowedLast3Months();
        List<String[]> publishers = managerService.getMostBorrowedPublishers();
        List<String[]> users = managerService.getBorrowedUsers();
        List<String[]> overdueBooks = managerService.getOverdueBooks();
        String overdue = managerService.getOverdue();

        model.addAttribute("mostBorrowed", mostBorrowed.toArray(new String[0][2]));
        model.addAttribute("mostBorrowed3Months", mostBorrowed3Months.toArray(new String[0][2]));
        model.addAttribute("publishers", publishers.toArray(new String[0][2]));
        model.addAttribute("users", users.toArray(new String[0][1]));
        model.addAttribute("overdue", overdue);
        model.addAttribute("overdueBooks", overdueBooks.toArray(new String[0][2]));

        return "manager/index";
    }

    // Add Book
    @GetMapping("/add-book")
    public String addBookPage(ModelMap model) {
        List<String[]> genres = appService.getGenres();
        List<String[]> publishers = appService.getPublishers();
        model.addAttribute("genres", genres.toArray(new String[0][2]));
        model.addAttribute("publishers", publishers.toArray(new String[0][2]));

        return "manager/addBook";
    }

    @PostMapping("/add-book")
    public String addBook(ModelMap model, @RequestParam String title, @RequestParam String genreId, @RequestParam String authorId, @RequestParam Date date, @RequestParam String publisherId, @RequestParam String topic) {
        try {
            appService.addBook(title, genreId, authorId, publisherId, date, topic,1);
            model.put("message", "Book added");
        } catch (Exception e) {
            model.put("message", "There was an error occurred when tried to add book");
        }
        return "manager/addBook";
    }

    // Remove Book
    @GetMapping("/remove-book")
    public String removeBookPage(ModelMap model) {
        List<String[]> data = appService.getBooks();
        model.put("books", data.toArray(new String[0][2]));
        return "manager/removeBook";
    }

    @PostMapping("/remove-book")
    public String removeBook(ModelMap model, @RequestParam String id) {
        managerService.removeBook(id);

        return "redirect:/manager/remove-book";
    }

    // Borrowed Books
    @GetMapping("/borrow-history")
    public String historyPage(ModelMap model) {
        List<String[]> data = managerService.getHistory();
        model.addAttribute("history", data.toArray(new String[0][6]));
        return "manager/history";
    }

    // Add Publisher
    @GetMapping("/add-publisher")
    public String addPublisherPage() {
        return "manager/createPublisher";
    }

    @PostMapping("/add-publisher")
    public String addPublisher(ModelMap model, @RequestParam String username, @RequestParam String password, @RequestParam String name) {
        password = Salter.salt(password, "CS202Project");
        try {
            managerService.addPublisher(username, password, name);
        } catch (Exception e) {
            model.put("message", "There was an error occurred when tried to add publisher");
        }
        return "manager/createPublisher";
    }

    // Approve requests
    @GetMapping("/requests")
    public String requestsPage(ModelMap model) {
        List<String[]> data = managerService.getRequests();
        model.addAttribute("requests", data.toArray(new String[0][6]));

        return "manager/request";
    }

    @PostMapping("/requests/{id}/approve")
    public String approveRequest(@PathVariable String id) {
        managerService.approveRequest(id);
        return "redirect:/manager/requests";
    }

    @PostMapping("/requests/{id}/decline")
    public String declineRequest(@PathVariable String id) {
        managerService.declineRequest(id);
        return "redirect:/manager/requests";
    }

    // assign
    @GetMapping("/assign")
    public String assignPage(ModelMap model) {
        List<String[]> users = managerService.getUsers();
        List<String[]> books = appService.getBooks();
        model.addAttribute("users", users.toArray(new String[0][2]));
        model.addAttribute("books", books.toArray(new String[0][2]));

        return "manager/assign";
    }

    @PostMapping("/assign")
    public String assign(@RequestParam String accountId, @RequestParam String bookId) {
        managerService.assign(accountId, bookId);
        return "redirect:/manager/assign";
    }

    @PostMapping("/borrow-history/{reserveId}/{bookId}")
    public String unassign(@PathVariable String reserveId, @PathVariable String bookId) {
        managerService.unassign(reserveId, bookId);
        return "redirect:/manager/borrow-history";
    }

}

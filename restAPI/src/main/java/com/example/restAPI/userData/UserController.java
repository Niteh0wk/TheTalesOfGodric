package com.example.restAPI.userData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/{userID}")
    public Optional<User> getUserByID(@PathVariable("userID") String userID) {
        return userService.getUserByID(userID);
    }

    // Method to get a user by email
    @GetMapping("/email")
    public ResponseEntity<?> getUserByEmail(@RequestParam("email") String email) {
        Optional<User> user = userService.getUserByEmail(email);

        if (user.isPresent()) {
            return ResponseEntity.ok(user);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }
    }

    @PutMapping("/{email}/updateBalance")
    public ResponseEntity<String> updateBalance(@PathVariable("email") String email, @RequestBody UpdateBalanceRequest request) {
        try {
            userService.updateBalance(email, request.getNewBalance());
            return ResponseEntity.ok("User data updated successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("message" + "Failed to update user data: " + "error" + e.getMessage());
        }
    }

    @PutMapping("/{email}/updateItemCount")
    public ResponseEntity<String> updateItemCount(@PathVariable("email") String email, @RequestBody UpdateItemCountRequest request) {
        try {
            userService.updateItemCount(email, request.getNewItemCount(), request.getItem());
            return ResponseEntity.ok("Item count updated successfully!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update item count: " + e.getMessage());
        }
    }

    // Method to add new User
    @PostMapping("/createUser")
    public ResponseEntity<String> createUser(@RequestBody User user) {
        try {
            userService.createUser(user);
            return ResponseEntity.status(HttpStatus.CREATED).body("User created successfully!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to create user: " + e.getMessage());
        }
    }
}

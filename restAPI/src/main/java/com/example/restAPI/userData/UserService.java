package com.example.restAPI.userData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public Optional<User> getUserByID(String userID) {
        return userRepository.findById(userID);
    }

    // Method to find a user by email
    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Transactional // Ensures atomicity of operations
    public void updateBalance(String email, int newBalance) throws Exception {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new Exception("Player not found"));

        user.setInGameBalance(newBalance);

        // Save the updated user object
        userRepository.save(user);
    }

    // Method to create a new user
    public void createUser(User user) throws Exception {
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new Exception("User with this email already exists");
        }

        userRepository.save(user);
    }
}

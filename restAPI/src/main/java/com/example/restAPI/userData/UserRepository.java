package com.example.restAPI.userData;

import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface UserRepository extends MongoRepository<User, String> {
    // Custom query method to find a user by their email
    Optional<User> findByEmail(String email);
}

package com.example.restAPI.userData;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "users")
public class User {

    @Id
    private String id;
    private String user_name;
    private String email;
    private String password;
    @Setter
    private int inGameBalance;

}

// The fields in this class have to be named EXACTLY like the attributes in the database!!!

// Spring Boot uses Jackson (spring boot library which translates JSON data to a POJO Class)
// by default to serialize objects into JSON.
// Jackson relies on getter methods to serialize the fields !!
// Ensure each field has a corresponding public getter method.
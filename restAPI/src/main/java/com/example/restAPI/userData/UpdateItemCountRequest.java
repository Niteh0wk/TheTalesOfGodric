package com.example.restAPI.userData;

import lombok.Getter;

@Getter
public class UpdateItemCountRequest {
    private String item;
    private int newItemCount;
}

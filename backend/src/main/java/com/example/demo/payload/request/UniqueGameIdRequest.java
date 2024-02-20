package com.example.demo.payload.request;

import jakarta.validation.constraints.NotNull;

public class UniqueGameIdRequest {
    
    @NotNull
    Long uniqueGameId;

    public Long getUniqueGameId() {
        return uniqueGameId;
    }
    public void setUniqueGameId(Long uniqueGameId) {
        this.uniqueGameId = uniqueGameId;
    }    
}

package com.example.demo.payload.request;

public class UpdateGroupPlayersRequest {

    Long[] newPlayers;

    public Long[] getNewPlayers() {
        return newPlayers;
    }

    public void setNewPlayers(Long[] newPlayers) {
        this.newPlayers = newPlayers;
    }
}

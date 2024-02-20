package com.tabletennis.app.payload.request;

public class UpdateGroupPlayersRequest {

    Long[] newPlayers;

    public Long[] getNewPlayers() {
        return newPlayers;
    }

    public void setNewPlayers(Long[] newPlayers) {
        this.newPlayers = newPlayers;
    }
}

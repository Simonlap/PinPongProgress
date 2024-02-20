package com.tabletennis.app.payload.request;

import java.time.LocalDateTime;

public class AddEloRatingRequest {
    private int elo;
    private LocalDateTime date;

    public int getElo() {
        return elo;
    }

    public void setElo(int elo) {
        this.elo = elo;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }
}

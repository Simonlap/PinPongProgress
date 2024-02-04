package com.example.demo.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "uniqueGames")
public class UniqueGame {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private int highestRound;

    @NotNull
    private boolean isFinished;

    @NotNull
    private Long userId;

    public void setId(Long id) {
        this.id = id;
    }
    public Long getId() {
        return id;
    }

    public int getHighestRound() {
        return highestRound;
    }
    public void setHighestRound(int highestRound) {
        this.highestRound = highestRound;
    }

    public boolean isFinished() {
        return isFinished;
    }
    public void setFinished(boolean isFinished) {
        this.isFinished = isFinished;
    }

    public Long isUserId() {return userId;}
    public void setUserId(Long userId) {this.userId = userId;}
}

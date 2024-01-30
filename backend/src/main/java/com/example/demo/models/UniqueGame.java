package com.example.demo.models;

import java.util.Map;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "games")
public class UniqueGame<dynamic> {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private int highest_round;

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

    public int getHighest_round() {
        return highest_round;
    }
    public void setHighest_round(int highest_round) {
        this.highest_round = highest_round;
    }

    public boolean isFinished() {
        return isFinished;
    }
    public void setFinished(boolean is_finished) {
        this.isFinished = is_finished;
    }

    public Long isUser_id() {return userId;}
    public void setUserId(Long userId) {this.userId = userId;}
}

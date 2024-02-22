package com.tabletennis.app.models;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "groups")
public class Group {

    @ElementCollection
    @CollectionTable(name = "group_players", joinColumns = @JoinColumn(name = "group_id"))
    @Column(name = "player_id")
    private List<Long> players;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long userId;

    @Column(nullable = false)
    private String groupName;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public List<Long> getPlayers() {
        return players;
    }

    public void setPlayers(List<Long> newPlayers) {// Clear the existing collection
        this.players = newPlayers; // Add all from the new collection
    }
    public void updatePlayers(List<Long> newPlayers) {
        this.players.clear();
        this.players.addAll(newPlayers);
    }
}

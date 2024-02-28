package com.tabletennis.app.dto;

import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PlayerDTO {

    private Long id;
    private String playerName;
    private Set<EloRatingDTO> eloRatings;
    private Set<Long> uniqueGameIds;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    } 

    public void setPlayerName(String playerName) {
        this.playerName = playerName;
    }

    public String getPlayerName() {
        return playerName;
    }

    public Set<EloRatingDTO> getEloRatings() {
        return eloRatings;
    }

    public void setEloRatings(Set<EloRatingDTO> eloRatings) {
        this.eloRatings = eloRatings;
    }

    public Set<Long> getUniqueGameIds() {
        return uniqueGameIds;
    }

    public void setUniqueGameIds(Set<Long> uniqueGameIds) {
        this.uniqueGameIds = uniqueGameIds;
    }
}

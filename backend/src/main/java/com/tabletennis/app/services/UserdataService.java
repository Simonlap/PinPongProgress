package com.tabletennis.app.services;


import com.tabletennis.app.dto.GroupDTO;
import com.tabletennis.app.models.EloRating;
import com.tabletennis.app.models.Group;
import com.tabletennis.app.repository.EloRatingRepository;
import com.tabletennis.app.repository.GroupRepository;

import com.tabletennis.app.models.Player;
import com.tabletennis.app.payload.request.AddEloRatingRequest;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tabletennis.app.dto.PlayerDTO;
import com.tabletennis.app.repository.PlayerRepository;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
public class UserdataService {

    @Autowired
    PlayerRepository playerRepository;

    @Autowired
    GroupRepository groupRepository;

    @Autowired
    EloRatingRepository eloRatingRepository;

    @Autowired
    ModelMapper modelMapper;

    public List<PlayerDTO> getPlayersForUserId(Long userId) {
        Set<Player> players = playerRepository.findByUserId(userId);

        return players.stream()
                .map(player -> modelMapper.map(player, PlayerDTO.class))
                .collect(Collectors.toList());
    }

    public PlayerDTO createPlayer(PlayerDTO playerDTO, Long userId) {
        Player player = new Player();
        player.setUserId(userId);
        player.setPlayerName(playerDTO.getPlayerName());

        if (playerDTO.getEloRatings() != null) {
            player.setEloRatings(
                playerDTO.getEloRatings().stream().map(eloRatingDTO -> {
                    EloRating eloRating = new EloRating();
                    eloRating.setElo(eloRatingDTO.getElo());
                    eloRating.setDate(eloRatingDTO.getDate());
                    eloRating.setPlayer(player);
                    return eloRating;
                }).collect(Collectors.toSet())
            );
        }

        Player savedPlayer = playerRepository.save(player);

        PlayerDTO savedPlayerDTO = modelMapper.map(savedPlayer, PlayerDTO.class);
        return savedPlayerDTO;
    }


    public PlayerDTO updatePlayer(PlayerDTO playerDTO, Long userId) {
        Player player = modelMapper.map(playerDTO, Player.class);
        player.setUserId(userId);
        Player savedPlayer = playerRepository.save(player);
        return modelMapper.map(savedPlayer, PlayerDTO.class);
    }

    public PlayerDTO changePlayerName(Long playerId, String newPlayerName) {
        Player player = playerRepository.findById(playerId).get();
        player.setPlayerName(newPlayerName);
        Player savedPlayer = playerRepository.save(player);
        return modelMapper.map(savedPlayer, PlayerDTO.class);
    }

    public void deletePlayer(Long playerId) {
        Optional<Player> playerOptional = playerRepository.findById(playerId);

        if (playerOptional.isPresent()) {
            Player player = playerOptional.get();

            player.getEloRatings().forEach(eloRating -> eloRatingRepository.delete(eloRating));
            player.getEloRatings().clear();
            player.getUniqueGames().forEach(uniqueGame -> uniqueGame.getPlayers().remove(player));

            playerRepository.delete(player);
        } else {
            throw new EntityNotFoundException("Player not found with ID: " + playerId);
        }
    }



    public Player addEloRatingToPlayer(Long playerId, AddEloRatingRequest addEloRatingRequest) {
        Player player = playerRepository.findById(playerId)
                            .orElseThrow(() -> new RuntimeException("Player not found with id: " + playerId));
    
        EloRating eloRating = new EloRating();
        eloRating.setElo(addEloRatingRequest.getElo());
        eloRating.setDate(addEloRatingRequest.getDate());
        eloRating.setPlayer(player);
    
        eloRatingRepository.save(eloRating);
        
        // Reload the player to ensure to have the latest state
        return playerRepository.findById(playerId).orElseThrow(() -> new RuntimeException("Player not found with id: " + playerId));
    }

    public List<GroupDTO> getGroupsForUserId(Long userId) {
        Set<Group> groups = groupRepository.findByUserId(userId);

        return groups.stream()
                .map(group -> modelMapper.map(group, GroupDTO.class))
                .collect(Collectors.toList());
    }

    public GroupDTO createGroup(GroupDTO groupDTO, Long userId) {
        Group group = modelMapper.map(groupDTO, Group.class);
        group.setUserId(userId);
        Group savedGroup = groupRepository.save(group);
        return modelMapper.map(savedGroup, GroupDTO.class);
    }

    public void deleteGroup(Long groupId) {
        groupRepository.deleteById(groupId);
    }

    public GroupDTO updateGroup(Long groupId, Long[] newPlayers) {
        Group group = groupRepository.findById(groupId).get();
        group.updatePlayers(List.of(newPlayers));
        Group savedGroup = groupRepository.save(group);

        return modelMapper.map(savedGroup, GroupDTO.class);
    }
}

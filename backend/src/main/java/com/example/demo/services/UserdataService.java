package com.example.demo.services;

import com.example.demo.dto.GroupDTO;
import com.example.demo.dto.PlayerDTO;
import com.example.demo.models.Group;
import com.example.demo.models.Player;
import com.example.demo.repository.GroupRepository;
import com.example.demo.repository.PlayerRepository;
import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional
public class UserdataService {

    @Autowired
    PlayerRepository playerRepository;

    @Autowired
    GroupRepository groupRepository;

    @Autowired
    ModelMapper modelMapper;

    public List<PlayerDTO> getPlayersForUserId(Long userId) {
        Set<Player> players = playerRepository.findByUserId(userId);

        return players.stream()
                .map(player -> modelMapper.map(player, PlayerDTO.class))
                .collect(Collectors.toList());
    }

    public PlayerDTO createPlayer(PlayerDTO playerDTO, Long userId) {
        Player player = modelMapper.map(playerDTO, Player.class);
        player.setUserId(userId);
        Player savedPlayer = playerRepository.save(player);
        return modelMapper.map(savedPlayer, PlayerDTO.class);
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
        playerRepository.deleteById(playerId);
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

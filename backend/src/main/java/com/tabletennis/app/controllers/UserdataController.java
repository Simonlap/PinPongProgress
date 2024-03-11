package com.tabletennis.app.controllers;


import com.tabletennis.app.dto.GroupDTO;
import com.tabletennis.app.payload.request.AddEloRatingRequest;
import com.tabletennis.app.payload.request.UpdateGroupPlayersRequest;

import com.tabletennis.app.services.UserdataService;
import jakarta.validation.Valid;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import com.tabletennis.app.dto.PlayerDTO;
import com.tabletennis.app.models.Player;
import com.tabletennis.app.payload.request.UpdatePlayerNameRequest;
import com.tabletennis.app.security.services.UserDetailsImpl;

import java.util.List;
import java.util.Map;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/userdata")
public class UserdataController {

    @Autowired
    UserdataService userdataService;

    @Autowired
    ModelMapper modelMapper;

    @GetMapping("/players")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<List<PlayerDTO>> getPlayersForUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        List<PlayerDTO> players = userdataService.getPlayersForUserId(userDetails.getId());

        return new ResponseEntity<>(players, HttpStatus.OK);
    }

    @PostMapping("/players")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<PlayerDTO> createPlayer(@Valid @RequestBody PlayerDTO playerDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        PlayerDTO createdPlayer = userdataService.createPlayer(playerDTO, userDetails.getId());

        return new ResponseEntity<>(createdPlayer, HttpStatus.CREATED);
    }


    @PutMapping("/player/{playerId}/changeName")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<PlayerDTO> updatePlayer(@PathVariable Long playerId, @Valid @RequestBody UpdatePlayerNameRequest updatePlayerNameRequest) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        PlayerDTO updatedPlayer = userdataService.changePlayerName(playerId, updatePlayerNameRequest.getNewPlayerName());

        return new ResponseEntity<>(updatedPlayer, HttpStatus.OK);
    }

    @DeleteMapping("/player/{playerId}")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<HttpStatus> deletePlayer(@PathVariable Long playerId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        userdataService.deletePlayer(playerId);

        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PostMapping("/player/{playerId}/eloRatings")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<PlayerDTO> addEloRatingToPlayer(@PathVariable Long playerId, @Valid @RequestBody AddEloRatingRequest addEloRatingRequest) {
        Player updatedPlayer = userdataService.addEloRatingToPlayer(playerId, addEloRatingRequest);
        PlayerDTO playerDTO = modelMapper.map(updatedPlayer, PlayerDTO.class);
        return new ResponseEntity<>(playerDTO, HttpStatus.CREATED);
    }

    @GetMapping("/groups")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<List<GroupDTO>> getGroupsForUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        List<GroupDTO> groups = userdataService.getGroupsForUserId(userDetails.getId());

        return new ResponseEntity<>(groups, HttpStatus.OK);
    }

    @PostMapping("/groups")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<GroupDTO> createGroup(@Valid @RequestBody GroupDTO groupDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        GroupDTO createdGroup = userdataService.createGroup(groupDTO, userDetails.getId());

        return new ResponseEntity<>(createdGroup, HttpStatus.CREATED);
    }

    @DeleteMapping("/group/{groupId}")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<HttpStatus> deleteGroup(@PathVariable Long groupId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        userdataService.deleteGroup(groupId);

        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PutMapping("/group/{groupId}/update")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<GroupDTO> updateGroup(@PathVariable Long groupId, @Valid @RequestBody UpdateGroupPlayersRequest updateGroupPlayersRequest) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        GroupDTO updatedGroup = userdataService.updateGroup(groupId, updateGroupPlayersRequest.getNewPlayers());

        return new ResponseEntity<>(updatedGroup, HttpStatus.OK);
    }
}

package com.example.demo.controllers;

import com.example.demo.dto.GroupDTO;
import com.example.demo.dto.PlayerDTO;
import com.example.demo.payload.request.UpdatePlayerNameRequest;
import com.example.demo.security.services.UserDetailsImpl;
import com.example.demo.services.UserdataService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/userdata")
public class UserdataController {

    @Autowired
    UserdataService userdataService;

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

    //endpoint to delete player
    @DeleteMapping("/player/{playerId}")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<HttpStatus> deletePlayer(@PathVariable Long playerId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        userdataService.deletePlayer(playerId);

        return new ResponseEntity<>(HttpStatus.OK);
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
}

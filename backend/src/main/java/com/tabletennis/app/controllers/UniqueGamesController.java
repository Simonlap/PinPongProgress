package com.tabletennis.app.controllers;

import com.tabletennis.app.payload.request.UniqueGameIdRequest;
import com.tabletennis.app.security.services.UserDetailsImpl;
import com.tabletennis.app.services.UniqueGamesService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import com.tabletennis.app.dto.UniqueGameDTO;

import java.util.List;


@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/uniqueGames")
public class   UniqueGamesController {

    @Autowired
    UniqueGamesService uniqueGamesService;

    @GetMapping("/running")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<List<UniqueGameDTO>> getRunningGames() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        List<UniqueGameDTO> results = uniqueGamesService.getRunningGames(userDetails.getId());

        return new ResponseEntity<>(results, HttpStatus.OK);
    }

    @PostMapping("/entry")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<UniqueGameDTO> createEntry(@Valid @RequestBody UniqueGameDTO uniqueGameDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        UniqueGameDTO createdResult = uniqueGamesService.createEntry(uniqueGameDTO, userDetails.getId());

        return new ResponseEntity<>(createdResult, HttpStatus.CREATED);
    }

    @PutMapping("/increaseRound")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<UniqueGameDTO> increaseRound(@Valid @RequestBody UniqueGameIdRequest updateRoundIdRequest) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        UniqueGameDTO createdResult = uniqueGamesService.increaseRound(updateRoundIdRequest, userDetails.getId());

        return new ResponseEntity<>(createdResult, HttpStatus.OK);
    }

    @PutMapping("/exitGame")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<UniqueGameDTO> exitRound(@Valid @RequestBody UniqueGameIdRequest updateRoundIdRequest) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        UniqueGameDTO createdResult = uniqueGamesService.exitRound(updateRoundIdRequest, userDetails.getId());

        return new ResponseEntity<>(createdResult, HttpStatus.OK);
    }
}

package com.example.demo.controllers;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import com.example.demo.dto.UniqueGameDTO;
import com.example.demo.payload.request.UniqueGameIdRequest;
import com.example.demo.security.services.UserDetailsImpl;
import com.example.demo.services.UniqueGamesService;

import java.util.List;


@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/uniqueGames")
public class UniqueGamesController {

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
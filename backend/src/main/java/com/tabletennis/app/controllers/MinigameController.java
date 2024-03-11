package com.tabletennis.app.controllers;

import com.tabletennis.app.payload.request.EditResultEntryRequest;
import com.tabletennis.app.security.services.UserDetailsImpl;
import com.tabletennis.app.services.MinigameService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import com.tabletennis.app.dto.ResultDTO;

import java.util.List;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/minigame")
public class MinigameController {

    @Autowired
    MinigameService minigameService;

    @GetMapping("/results/{uniqueGameId}/{roundId}")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<List<ResultDTO>> getResultsForUniqueGameAndRound(
            @PathVariable Long uniqueGameId,
            @PathVariable Long roundId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        List<ResultDTO> results = minigameService.getResultsForUniqueGameAndRoundId(uniqueGameId, roundId);

        return new ResponseEntity<>(results, HttpStatus.OK);
    }

    @PostMapping("/entry")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<ResultDTO> createResult(@Valid @RequestBody ResultDTO resultDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        ResultDTO createdResult = minigameService.createResultEntry(resultDTO);

        return new ResponseEntity<>(createdResult, HttpStatus.CREATED);
    }

    @PutMapping("/editEntry")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<ResultDTO> editResult(@Valid @RequestBody EditResultEntryRequest editResultEntryRequest) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        ResultDTO createdResult = minigameService.editResultEntry(editResultEntryRequest);

        return new ResponseEntity<>(createdResult, HttpStatus.OK);
    }
}

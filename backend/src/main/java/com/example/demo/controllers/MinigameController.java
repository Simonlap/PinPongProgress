package com.example.demo.controllers;

import com.example.demo.dto.ResultDTO;
import com.example.demo.security.services.UserDetailsImpl;
import com.example.demo.services.MinigameService;
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
@RequestMapping("/api/minigame")
public class MinigameController {

    @Autowired
    MinigameService minigameService;

    @GetMapping("/results")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<List<ResultDTO>> getResultsForUserIdAndRoundId(@RequestParam String roundId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        List<ResultDTO> results = minigameService.getResultsForUserIdAndRoundId(userDetails.getId(), roundId);

        return new ResponseEntity<>(results, HttpStatus.OK);
    }
    @PostMapping("/entry")
    @PreAuthorize("hasRole('USER') or hasRole('MODERATOR') or hasRole('ADMIN')")
    public ResponseEntity<ResultDTO> createResult(@Valid @RequestBody ResultDTO resultDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        ResultDTO createdResult = minigameService.createResultEntry(resultDTO, userDetails.getId());

        return new ResponseEntity<>(createdResult, HttpStatus.CREATED);
    }
}

package com.example.demo.controllers;

import com.example.demo.dto.PlayerDTO;
import com.example.demo.repository.PlayerRepository;
import com.example.demo.security.services.UserDetailsImpl;
import com.example.demo.services.UserdataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigureOrder;
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
        System.out.println(userDetails.getId());

        List<PlayerDTO> players = userdataService.getPlayersForUserId(userDetails.getId());

        return new ResponseEntity<>(players, HttpStatus.OK);
    }
}

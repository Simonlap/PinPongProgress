package com.tabletennis.app.repository;

import java.util.Optional;

import com.tabletennis.app.models.ERole;
import com.tabletennis.app.models.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    Optional<Role> findByName(ERole name);
}

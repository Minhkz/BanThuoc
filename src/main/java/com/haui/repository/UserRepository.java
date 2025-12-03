package com.haui.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.haui.model.User;

public interface UserRepository extends JpaRepository<User, Integer> {
    boolean existsByEmail(String email);

    boolean existsByUsername(String username);

    User findByUsername(String username);

    User findByEmail(String email);
}

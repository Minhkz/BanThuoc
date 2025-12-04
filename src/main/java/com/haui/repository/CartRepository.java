package com.haui.repository;

import com.haui.model.Cart;
import com.haui.model.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {

    // tìm cart theo user_id (bảng carts có cột user_id UNIQUE)
    Optional<Cart> findByUser_Id(Integer userId);

    Cart findByUser(User user);
}

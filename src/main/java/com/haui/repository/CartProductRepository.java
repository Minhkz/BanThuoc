package com.haui.repository;

import com.haui.model.Cart;
import com.haui.model.CartProduct;
import com.haui.model.CartProductId;
import com.haui.model.Product;

import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository

public interface CartProductRepository extends JpaRepository<CartProduct, CartProductId> {

    public CartProduct findByCartAndProduct(Cart cart, Product product);

    @Modifying
    @Transactional
    public void deleteByCartAndProduct(Cart cart, Product product);

    @Modifying
    @Transactional
    void deleteByCart(Cart cart);
}

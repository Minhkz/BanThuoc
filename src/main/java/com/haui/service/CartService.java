package com.haui.service;

import com.haui.model.*;
import com.haui.repository.CartProductRepository;
import com.haui.repository.CartRepository;
import com.haui.repository.ProductRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;
    private final CartProductRepository cartProductRepository;
    private final ProductRepository productRepository;

    public Cart geCartByUser(User user) {
        return cartRepository.findByUser(user);
    }

    public Cart savCart(Cart cart) {
        return cartRepository.save(cart);
    }

    public double calculateTotal(Cart cart) {

        if (cart == null || cart.getCartProduct() == null) {
            return 0.0;
        }

        return cart.getCartProduct().stream()
                .filter(item -> item.getProduct() != null)
                .mapToDouble(item -> {
                    double price = item.getProduct().getPrice() != null ? item.getProduct().getPrice() : 0.0;
                    int qty = item.getQuantity() != null ? item.getQuantity() : 0;
                    return price * qty;
                })
                .sum();
    }

}

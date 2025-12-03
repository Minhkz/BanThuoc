package com.haui.service;

import com.haui.model.*;
import com.haui.repository.CartProductRepository;
import com.haui.repository.CartRepository;
import com.haui.repository.ProductRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class CartService {

    private final CartRepository cartRepository;
    private final CartProductRepository cartProductRepository;
    private final ProductRepository productRepository;

    public CartService(CartRepository cartRepository,
                       CartProductRepository cartProductRepository,
                       ProductRepository productRepository) {
        this.cartRepository = cartRepository;
        this.cartProductRepository = cartProductRepository;
        this.productRepository = productRepository;
    }

    // tạo / lấy cart theo user
    public Cart getOrCreateCart(User user) {
        return cartRepository.findByUser_Id(user.getId())
                .orElseGet(() -> {
                    Cart c = new Cart(user);
                    return cartRepository.save(c);
                });
    }

    // Thêm sản phẩm
    public void addItem(User user, Integer productId, Integer quantity) {
        if (quantity == null || quantity <= 0) {
            quantity = 1;
        }

        Cart cart = getOrCreateCart(user);

        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        CartProduct cartProduct = cartProductRepository
                .findByCart_IdAndProduct_Id(cart.getId(), product.getId())
                .orElse(null);

        if (cartProduct == null) {
            cartProduct = new CartProduct(cart, product, quantity, product.getPrice());
        } else {
            cartProduct.setQuantity(cartProduct.getQuantity() + quantity);
        }

        cartProductRepository.save(cartProduct);
    }

    // Lấy danh sách item trong giỏ
    public List<CartProduct> getCartItems(User user) {
        Cart cart = cartRepository.findByUser_Id(user.getId())
                .orElse(null);
        if (cart == null) return List.of();
        return cartProductRepository.findByCart_Id(cart.getId());
    }

    // Xóa 1 sản phẩm
    public void removeItem(User user, Integer productId) {
        Cart cart = cartRepository.findByUser_Id(user.getId())
                .orElse(null);
        if (cart == null) return;

        cartProductRepository.deleteByCartIdAndProductId(cart.getId(), productId);
    }

    // Xóa toàn bộ giỏ
    public void clearCart(User user) {
        Cart cart = cartRepository.findByUser_Id(user.getId())
                .orElse(null);
        if (cart == null) return;

        cartProductRepository.deleteAll(cartProductRepository.findByCart_Id(cart.getId()));
    }

    // Tính subtotal
    public double calculateSubtotal(User user) {
        Cart cart = cartRepository.findByUser_Id(user.getId())
                .orElse(null);
        if (cart == null) return 0d;
        Double total = cartProductRepository.calculateCartTotal(cart.getId());
        return total != null ? total : 0d;
    }

    // Đếm tổng số lượng item
    public int countItems(User user) {
        Cart cart = cartRepository.findByUser_Id(user.getId())
                .orElse(null);
        if (cart == null) return 0;
        Integer count = cartProductRepository.countTotalQuantity(cart.getId());
        return count != null ? count : 0;
    }
}


package com.haui.controller;

import com.haui.model.CartProduct;
import com.haui.model.User;
import com.haui.service.CartService;
import com.haui.service.UserService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final CartService cartService;
    private final UserService userService; // cần để lấy User entity

    public CartController(CartService cartService, UserService userService) {
        this.cartService = cartService;
        this.userService = userService;
    }

    private User getUserFromPrincipal(UserDetails principal) {
        User user = userService.findByEmail(principal.getUsername());
        if (user == null)
            return userService.getUserByUsername(principal.getUsername());
        return user;
    }

    // GET /cart
    @GetMapping
    public String viewCart(@AuthenticationPrincipal UserDetails principal,
            Model model) {

        if (principal == null) {
            return "redirect:/login";
        }

        User user = getUserFromPrincipal(principal);

        List<CartProduct> items = cartService.getCartItems(user);
        double subtotal = cartService.calculateSubtotal(user);
        double shipping = items.isEmpty() ? 0 : 15000;
        double discount = 0;
        double total = subtotal + shipping - discount;

        model.addAttribute("cartItems", items);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("shipping", shipping);
        model.addAttribute("discount", discount);
        model.addAttribute("total", total);
        model.addAttribute("cartItemCount", cartService.countItems(user));

        return "client/cart";
    }

    // POST /cart/add
    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> addToCart(
            @AuthenticationPrincipal UserDetails principal,
            @RequestParam("productId") Integer productId,
            @RequestParam(value = "quantity", required = false, defaultValue = "1") Integer quantity) {

        Map<String, Object> res = new HashMap<>();

        if (principal == null) {
            res.put("success", false);
            res.put("message", "Bạn cần đăng nhập để thêm vào giỏ hàng.");
            return res;
        }

        User user = getUserFromPrincipal(principal);

        try {
            cartService.addItem(user, productId, quantity);
            res.put("success", true);
            res.put("cartCount", cartService.countItems(user));
        } catch (Exception ex) {
            res.put("success", false);
            res.put("message", ex.getMessage());
        }

        return res;
    }

    // POST /cart/remove
    @PostMapping("/remove")
    @ResponseBody
    public Map<String, Object> removeFromCart(
            @AuthenticationPrincipal UserDetails principal,
            @RequestParam("productId") Integer productId) {

        Map<String, Object> res = new HashMap<>();

        if (principal == null) {
            res.put("success", false);
            res.put("message", "Bạn cần đăng nhập.");
            return res;
        }

        User user = getUserFromPrincipal(principal);
        cartService.removeItem(user, productId);

        res.put("success", true);
        res.put("cartCount", cartService.countItems(user));
        return res;
    }

    // POST /cart/clear
    @PostMapping("/clear")
    @ResponseBody
    public Map<String, Object> clearCart(@AuthenticationPrincipal UserDetails principal) {

        Map<String, Object> res = new HashMap<>();

        if (principal == null) {
            res.put("success", false);
            res.put("message", "Bạn cần đăng nhập.");
            return res;
        }

        User user = getUserFromPrincipal(principal);
        cartService.clearCart(user);

        res.put("success", true);
        res.put("cartCount", 0);
        return res;
    }
}

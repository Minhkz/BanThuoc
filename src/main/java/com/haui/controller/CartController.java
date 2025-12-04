package com.haui.controller;

import com.haui.model.CartProduct;
import com.haui.model.User;
import com.haui.service.CartService;
import jakarta.servlet.http.HttpSession;
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

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    private User getCurrentUser(HttpSession session) {
        return (User) session.getAttribute("currentUser");
    }

    // GET /cart -> trả về cart.jsp
    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        User user = getCurrentUser(session);
        if (user == null) {
            // chưa login thì bắt về trang đăng nhập (anh đổi URL tùy cấu hình)
            return "redirect:/login";
        }

        List<CartProduct> items = cartService.getCartItems(user);
        double subtotal = cartService.calculateSubtotal(user);
        double shipping = items.isEmpty() ? 0 : 15000; // ví dụ
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
    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> addToCart(@RequestParam("productId") Integer productId,
                                         @RequestParam(value = "quantity", required = false, defaultValue = "1") Integer quantity,
                                         HttpSession session) {

        Map<String, Object> res = new HashMap<>();
        User user = getCurrentUser(session);

        if (user == null) {
            res.put("success", false);
            res.put("message", "Bạn cần đăng nhập để thêm vào giỏ hàng.");
            return res;
        }

        try {
            cartService.addItem(user, productId, quantity);
            int count = cartService.countItems(user);
            res.put("success", true);
            res.put("cartCount", count);
        } catch (Exception ex) {
            res.put("success", false);
            res.put("message", ex.getMessage());
        }

        return res;
    }

    // POST /cart/remove  (gọi từ cart.jsp: removeFromCart(productId))
    @PostMapping("/remove")
    @ResponseBody
    public Map<String, Object> removeFromCart(@RequestParam("productId") Integer productId,
                                              HttpSession session) {
        Map<String, Object> res = new HashMap<>();
        User user = getCurrentUser(session);

        if (user == null) {
            res.put("success", false);
            res.put("message", "Bạn cần đăng nhập.");
            return res;
        }

        cartService.removeItem(user, productId);
        res.put("success", true);
        res.put("cartCount", cartService.countItems(user));
        return res;
    }

    // POST /cart/clear  (gọi từ cart.jsp: clearCart())
    @PostMapping("/clear")
    @ResponseBody
    public Map<String, Object> clearCart(HttpSession session) {
        Map<String, Object> res = new HashMap<>();
        User user = getCurrentUser(session);

        if (user == null) {
            res.put("success", false);
            res.put("message", "Bạn cần đăng nhập.");
            return res;
        }

        cartService.clearCart(user);
        res.put("success", true);
        res.put("cartCount", 0);
        return res;
    }
}

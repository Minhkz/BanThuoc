package com.haui.controller;

import com.haui.model.Cart;
import com.haui.model.CartProduct;
import com.haui.model.CartProductId;
import com.haui.model.Product;
import com.haui.model.User;
import com.haui.repository.CartProductRepository;
import com.haui.service.CartService;
import com.haui.service.ProductService;
import com.haui.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;
    private final UserService userService;
    private final CartProductRepository cartProductRepository;
    private final ProductService productService;

    private User getUserFromPrincipal(UserDetails principal) {
        User user = userService.findByEmail(principal.getUsername());
        if (user == null)
            return userService.getUserByUsername(principal.getUsername());
        return user;
    }

    // GET /cart
    @GetMapping
    public String viewCart(@AuthenticationPrincipal UserDetails principal,
            Model model,
            HttpSession session) {

        if (principal == null) {
            return "redirect:/login";
        }

        User user = getUserFromPrincipal(principal);
        Cart cart = user.getCart();

        List<CartProduct> cartProducts = cart.getCartProduct();

        double total = cartProducts.stream()
                .mapToDouble(CartProduct::getPrice)
                .sum();

        // Cập nhật session sum (số loại sản phẩm)
        session.setAttribute("sum", cart.getSum());

        model.addAttribute("cartProducts", cartProducts);
        model.addAttribute("total", total);
        return "client/cart";
    }

    // POST /cart/add
    @PostMapping("/add")
    @Transactional
    public String addToCart(@AuthenticationPrincipal UserDetails principal,
            @RequestParam("id") int idProduct,
            HttpSession session) {

        User user = getUserFromPrincipal(principal);
        Cart cart = cartService.geCartByUser(user);

        if (cart == null) {
            cart = new Cart();
            cart.setUser(user);
            cart.setSum(0);
            cart = cartService.savCart(cart);
        }

        Product product = productService.getProductById(idProduct).orElse(null);
        CartProduct cartProduct = cartProductRepository.findByCartAndProduct(cart, product);

        if (cartProduct != null) {
            // chỉ tăng quantity, sum không tăng
            cartProduct.setQuantity(cartProduct.getQuantity() + 1);
            cartProductRepository.save(cartProduct);
        } else {
            // thêm dòng mới -> sum + 1
            cart.setSum(cart.getSum() + 1);

            CartProduct newCP = new CartProduct(
                    new CartProductId(cart.getId(), idProduct),
                    cart,
                    product,
                    1,
                    product.getPrice());
            cartProductRepository.save(newCP);
        }

        cartService.savCart(cart);

        // cập nhật session sum
        session.setAttribute("sum", cart.getSum());

        return "redirect:/cart";
    }

    @PostMapping("/cancel")
    @Transactional
    public String cancel(@RequestParam("id") int id,
            @AuthenticationPrincipal UserDetails principal,
            HttpSession session) {

        User user = getUserFromPrincipal(principal);
        Cart cart = user.getCart();
        Product product = productService.getProductById(id).orElse(null);

        // xóa đúng sản phẩm trong giỏ của user
        cartProductRepository.deleteByCartAndProduct(cart, product);

        // giảm số loại sản phẩm
        cart.setSum(cart.getSum() - 1);
        cartService.savCart(cart);

        // cập nhật session sum
        session.setAttribute("sum", cart.getSum());

        return "redirect:/cart";
    }

    @PostMapping("/clear")
    @Transactional
    public String clearCart(@AuthenticationPrincipal UserDetails principal,
            HttpSession session) {

        User user = getUserFromPrincipal(principal);
        Cart cart = user.getCart();

        // Xóa toàn bộ CartProduct của user
        cartProductRepository.deleteByCart(cart);

        // Reset số loại sản phẩm
        cart.setSum(0);
        cartService.savCart(cart);

        // cập nhật session
        session.setAttribute("sum", 0);

        return "redirect:/cart";
    }

}

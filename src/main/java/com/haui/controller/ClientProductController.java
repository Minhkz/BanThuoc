package com.haui.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import com.haui.model.Product;
import com.haui.service.ProductService;

@Controller
public class ClientProductController {

    private final ProductService productService;

    public ClientProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/category")
    public String showCategories(Model model) {

        List<Product> products = productService.getAllProducts();

        model.addAttribute("products", products);
        return "client/category";
    }
}

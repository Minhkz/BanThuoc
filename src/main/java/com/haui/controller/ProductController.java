package com.haui.controller;

import com.haui.model.Product;
import com.haui.service.ProductService;
import com.haui.service.UploadService;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/products")
public class ProductController {

    @Autowired
    private ProductService productService;
     @Autowired
    private UploadService uploadService;
    @GetMapping
    public String showProducts(Model model) {
        model.addAttribute("listProducts", productService.getAllProducts());
        model.addAttribute("product", new Product()); 
        return "admin/admin-products"; 
    }
   @PostMapping("/save")
public String saveProduct(
        @Valid @ModelAttribute("product") Product product,
        BindingResult result,
        @RequestParam("imageFile") MultipartFile imageFile,
        Model model,
        RedirectAttributes redirect
) {
    if (result.hasErrors()) {
        model.addAttribute("listProducts", productService.getAllProducts());
        return "admin/admin-products";
    }

    if (!imageFile.isEmpty()) {
        String fileName = uploadService.handleSaveUploadFile("user", imageFile);
        product.setImage(fileName);
    }

    productService.saveProduct(product);

    redirect.addFlashAttribute("success", "Lưu sản phẩm thành công!");
    return "redirect:/admin/products";
}

    @GetMapping("/edit/{id}")
    public String editProduct(@PathVariable Integer id, Model model) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        model.addAttribute("product", product);
        model.addAttribute("listProducts", productService.getAllProducts());
        return "admin/product-form";
    }
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Integer id, RedirectAttributes redirect) {
        productService.deleteProduct(id);
        redirect.addFlashAttribute("success", "Đã xóa sản phẩm");
        return "redirect:/admin/products";
    }
}

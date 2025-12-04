package com.haui.controller;

import java.io.File;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.haui.model.User;
import com.haui.service.UploadService;
import com.haui.service.UserService;

import jakarta.servlet.ServletContext;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Controller
@RequestMapping("/admin")
@FieldDefaults(level = lombok.AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class AdminController {
    UserService userService;

    UploadService uploadService;

    PasswordEncoder passwordEncoder;

    ServletContext servletContext;

    @GetMapping
    public String adminPage() {
        return "admin/admin";
    }

    @GetMapping("/users")
    public String usersPage(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/admin-users";
    }

    @GetMapping("/users/add")
    public String addUserPage(Model model) {
        User user = new User();
        model.addAttribute("newUser", user);
        return "admin/admin-users-add";
    }

    @PostMapping("/users/create")
    public String createUser(
            @ModelAttribute("newUser") @Valid User newUser,
            BindingResult bindingResult,
            @RequestParam("nhatminhFile") MultipartFile file) {

        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getField() + " - " + error.getDefaultMessage());
        }

        if (bindingResult.hasErrors()) {
            return "admin/admin-users-add";
        }
        String avatar = this.uploadService.handleSaveUploadFile("user", file);
        String hashPassword = this.passwordEncoder.encode(newUser.getPassword());
        newUser.setAvatar(avatar);
        newUser.setPassword(hashPassword);
        userService.saveUser(newUser);
        return "redirect:/admin/users";
    }

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable("id") int id) {
        userService.deleteUserById(id);
        return "redirect:/admin/users";
    }

    @GetMapping("/users/edit/{id}")
    public String editUserPage(@PathVariable("id") int id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("editUser", user);
        return "admin/admin-users-edit";
    }

    @PostMapping("/users/edit")
    public String editUser(
            @ModelAttribute("editUser") User editUser,
            @RequestParam("nhatminhFile") MultipartFile file) {
        User entity = userService.getUserById(editUser.getId());
        if (entity != null) {
            entity.setPhone(editUser.getPhone());
            entity.setFullName(editUser.getFullName());
            entity.setAddress(editUser.getAddress());

            if (file != null && !file.isEmpty()) {
                String avatar = this.uploadService.handleSaveUploadFile("user", file);
                if (entity.getAvatar() != null && !entity.getAvatar().isEmpty()) {
                    String path = this.servletContext.getRealPath("/uploads")
                            + "/user/" + entity.getAvatar();
                    File avatarFile = new File(path);
                    if (avatarFile.exists()) {
                        avatarFile.delete();
                    }
                }
                entity.setAvatar(avatar);
            }
            this.userService.saveUser(entity);
        }
        return "redirect:/admin/users";
    }

    @GetMapping("/users/view/{id}")
    public String viewUserPage(@PathVariable("id") int id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/admin-users-view";
    }
   
}

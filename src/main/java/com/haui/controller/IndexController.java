package com.haui.controller;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haui.dto.user.UserDto;
import com.haui.model.Role;
import com.haui.model.User;
import com.haui.repository.RoleRepository;
import com.haui.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Controller
@RequestMapping("/")
@FieldDefaults(level = lombok.AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class IndexController {
    UserService userService;
    RoleRepository roleRepository;
    PasswordEncoder passwordEncoder;

    @GetMapping
    public String index() {
        return "client/index";
    }

    @GetMapping("/login")
    public String login() {
        return "client/login";
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("register", new UserDto());
        return "client/register";
    }

    @PostMapping("/register/create")
    public String createAccount(@ModelAttribute("register") UserDto userDto) {
        User user = new User();
        String hashPassword = this.passwordEncoder.encode(userDto.getPassword());
        user.setUsername(userDto.getUsername());
        user.setPassword(hashPassword);
        user.setEmail(userDto.getEmail());
        user.setPhone(userDto.getPhone());
        user.setAddress(userDto.getAddress());
        user.setFullName(userDto.getFullName());
        user.setRole(roleRepository.findByName("USER"));
        userService.saveUser(user);
        return "redirect:/login";
    }
}

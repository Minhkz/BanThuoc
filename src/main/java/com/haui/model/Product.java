package com.haui.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Entity
@Table(name = "products")
@Data
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", length = 150, nullable = false)
    @NotBlank(message = "Product name cannot be empty")
    private String name;

    @Column(nullable = false)
    @NotNull(message = "Price cannot be null")
    @Min(value = 0, message = "Price must be >= 0")
    private Double price;

    @Column(name = "detail_desc", columnDefinition = "TEXT", nullable = false)
    @NotBlank(message = "Detail description cannot be empty")
    private String detailDesc;

    @Column(name = "short_desc", length = 600, nullable = false)
    @NotBlank(message = "Short description cannot be empty")
    private String shortDesc;

    @Column(nullable = false)
    @NotNull(message = "Quantity cannot be null")
    @Min(value = 0, message = "Quantity must be >= 0")
    private Integer quantity;

    @Column
    @Min(value = 0, message = "Sold must be >= 0")
    private Integer sold;

    @Column(length = 1000)
    private String image;

    @Column(name = "is_new")
    private Boolean isNew;

    @Column(name = "is_hot")
    private Boolean isHot;

    @Column(name = "created_date")
    private LocalDateTime createdDate;

    @PrePersist
    private void defaults() {
        if (createdDate == null) {
            createdDate = LocalDateTime.now();
        }
        if (sold == null) {
            sold = 0;
        }
        if (isNew == null) {
            isNew = false;
        }
        if (isHot == null) {
            isHot = false;
        }
    }
}

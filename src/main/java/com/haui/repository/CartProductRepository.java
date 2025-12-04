package com.haui.repository;

import com.haui.model.CartProduct;
import com.haui.model.CartProductId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartProductRepository extends JpaRepository<CartProduct, CartProductId> {

    // 1. lấy 1 dòng cart_product theo cartId + productId
    Optional<CartProduct> findByCart_IdAndProduct_Id(Integer cartId, Integer productId);

    // 2. lấy tất cả item trong 1 cart
    List<CartProduct> findByCart_Id(Integer cartId);

    // 3. lấy tất cả item trong cart theo user
    @Query("SELECT cp FROM CartProduct cp WHERE cp.cart.user.id = :userId")
    List<CartProduct> findByUserId(@Param("userId") Integer userId);

    // 4. xóa 1 item
    @Modifying
    @Query("DELETE FROM CartProduct cp WHERE cp.cart.id = :cartId AND cp.product.id = :productId")
    void deleteByCartIdAndProductId(@Param("cartId") Integer cartId, @Param("productId") Integer productId);

    // 5. tính tổng tiền của cart
    @Query("SELECT COALESCE(SUM(cp.quantity * cp.price), 0) FROM CartProduct cp WHERE cp.cart.id = :cartId")
    Double calculateCartTotal(@Param("cartId") Integer cartId);

    // 6. đếm tổng số sản phẩm (tổng quantity)
    @Query("SELECT COALESCE(SUM(cp.quantity), 0) FROM CartProduct cp WHERE cp.cart.id = :cartId")
    Integer countTotalQuantity(@Param("cartId") Integer cartId);
}

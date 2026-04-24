package com.webthuongmai.repository;
import com.webthuongmai.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByProductNameContainingIgnoreCase(String name);

    List<Product> findByCategory_CategoryID(Long categoryId);

    List<Product> findByProductNameContainingIgnoreCaseAndCategory_CategoryID(String name, Long categoryId);

    List<Product> findByCategory_CategoryIDAndProductIDNot(Long categoryId, Long productId);

    // Query lấy sản phẩm Trending dựa trên số lượt tương tác trong bảng user_activities
    // Lưu ý: Các tên trường (productid, productName...) phải khớp chính xác với file Product Entity của bạn
@Query("SELECT p FROM Product p JOIN UserActivity ua ON p.productID = ua.product.productID " +
           "GROUP BY p " + 
           "ORDER BY COUNT(ua) DESC")
    List<Product> findTrendingProducts(Pageable pageable);

    List<Product> findByShop_ShopIDAndProductIDNot(Long shopId, Long productId);
}

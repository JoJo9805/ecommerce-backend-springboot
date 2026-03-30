package com.webthuongmai.controller;
import com.webthuongmai.repository.CartItemRepository;
import com.webthuongmai.repository.CartRepository;
import com.webthuongmai.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import com.webthuongmai.entity.*;
import java.util.Optional;

@RestController
@RequestMapping("/api/carts")
@CrossOrigin("*")
public class CartController {
    @Autowired
    private CartService cartService;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    @GetMapping
    public List<Cart> getAll() {
        return cartService.getAllCarts();
    }

    @PostMapping
    public Cart create(@RequestBody Cart cart) {
        return cartService.createCart(cart);
    }
@PostMapping("/add")
public ResponseEntity<?> addToCart(
        @RequestParam Long userId, 
        @RequestParam Long variantId, 
        @RequestParam(defaultValue = "1") Integer quantity) {
    
    if (quantity < 1) {
        return ResponseEntity.badRequest().body("Số lượng phải lớn hơn hoặc bằng 1");
    }

    Cart cart = cartRepository.findByUser_UserID(userId)
            .orElseGet(() -> {
                Cart newCart = new Cart();
                User user = new User(); 
                user.setUserID(userId);
                newCart.setUser(user);
                return cartRepository.save(newCart);
            });
    Optional<CartItem> existingItem = cartItemRepository
            .findByCart_CartIDAndProductVariant_VariantID(cart.getCartID(), variantId);

    if (existingItem.isPresent()) {
        CartItem item = existingItem.get();
        item.setQuantity(item.getQuantity() + quantity);
        cartItemRepository.save(item);
        return ResponseEntity.ok("Đã tăng số lượng sản phẩm trong giỏ");
    } else {
        CartItem newItem = new CartItem();
        newItem.setCart(cart);
        
        ProductVariant variant = new ProductVariant();
        variant.setVariantID(variantId);
        newItem.setProductVariant(variant);
        
        newItem.setQuantity(quantity);
        cartItemRepository.save(newItem);
        return ResponseEntity.ok("Đã thêm sản phẩm mới vào giỏ hàng");
    }
}
}
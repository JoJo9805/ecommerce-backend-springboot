package com.webthuongmai.controller;
import com.webthuongmai.entity.Cart;
import com.webthuongmai.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/carts")
@CrossOrigin("*")
public class CartController {
    @Autowired
    private CartService cartService;

    @GetMapping
    public List<Cart> getAll() {
        return cartService.getAllCarts();
    }

    @PostMapping
    public Cart create(@RequestBody Cart cart) {
        return cartService.createCart(cart);
    }
}
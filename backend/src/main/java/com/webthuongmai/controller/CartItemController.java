package com.webthuongmai.controller;
import com.webthuongmai.entity.CartItem;
import com.webthuongmai.service.CartItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/cart-items")
@CrossOrigin("*")
public class CartItemController {
    @Autowired
    private CartItemService cartItemService;

    @GetMapping
    public List<CartItem> getAll() {
        return cartItemService.getAllCartItems();
    }

    @PostMapping
    public CartItem create(@RequestBody CartItem cartItem) {
        return cartItemService.createCartItem(cartItem);
    }
}
package com.webthuongmai.controller;
import com.webthuongmai.entity.Shop;
import com.webthuongmai.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/shops")
@CrossOrigin("*")
public class ShopController {
    @Autowired
    private ShopService shopService;

    @GetMapping
    public List<Shop> getAll() {
        return shopService.getAllShops();
    }

    @PostMapping
    public Shop create(@RequestBody Shop shop) {
        return shopService.createShop(shop);
    }
}
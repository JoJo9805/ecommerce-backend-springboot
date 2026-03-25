package com.webthuongmai.entity;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
@Entity
@Table(name = "Shop")
@Data
public class Shop {
    @Id
    private Long shopID;

    @OneToOne
    @MapsId
    @JoinColumn(name = "shopID")
    private User user;

    @Column(nullable = false)
    private String shopName;
    
    private String description;
    private Double rating = 0.0;
    
    @Column(updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
    private LocalDateTime updatedAt = LocalDateTime.now();
    private LocalDateTime deletedAt;
}
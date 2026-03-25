package com.webthuongmai.entity;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "Cart")
@Data
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long cartID;

    @OneToOne
    @JoinColumn(name = "UserID")
    private User user;
}
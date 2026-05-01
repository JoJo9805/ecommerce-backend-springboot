# Tài liệu API - Dự án Thương mại điện tử

Danh sách các endpoint dùng để kết nối Frontend và Backend.

---

# API Documentation

## 1. Đăng ký tài khoản
- **Method:** POST  
- **URL:** `/api/auth/register`

### Body (JSON)
```json
{
  "fullName": "Nguyễn Văn Test",
  "email": "test@gmail.com",
  "phone": "0987654321",
  "password": "123",
  "confirmPassword": "123",
  "birthday": "2005-01-01",
  "gender": "Nam"
}
```

---

## 2. Đăng nhập
- **Method:** POST  
- **URL:** `/api/auth/login`

### Body (JSON)
```json
{
  "emailOrPhone": "test@gmail.com",
  "password": "123"
}
```

---

## 3. Thêm mới danh mục
- **Method:** POST  
- **URL:** `/api/categories`

### Body (JSON)
```json
{
  "categoryName": "Điện thoại"
}
```

---

## 4. Thêm mới đơn vị vận chuyển
- **Method:** POST  
- **URL:** `/api/shipping-units`

### Body (JSON)
```json
{
  "name": "Giao Hàng Nhanh",
  "price": 30000
}
```

---

## 5. Thêm mới Role (Quyền)
- **Method:** POST  
- **URL:** `/api/roles`

### Body (JSON)
```json
{
  "roleName": "ADMIN"
}
```

---

## 6. Thêm mới Người dùng
- **Method:** POST  
- **URL:** `/api/users`

### Body (JSON)
```json
{
  "fullName": "Nguyen Van A",
  "email": "test_thanh_cong_123@gmail.com",
  "password": "123",
  "role": {
    "roleID": 1
  }
}
```

---

## 7. Thêm mới cửa hàng
- **Method:** POST  
- **URL:** `/api/shops`

### Body (JSON)
```json
{
  "shopName": "Cửa hàng Công nghệ",
  "user": {
    "userID": 1
  }
}
```

---

## 8. Thêm mới sản phẩm
- **Method:** POST  
- **URL:** `/api/products`

### Body (JSON)
```json
{
  "productName": "Laptop Gaming Pro 2026",
  "price": 25000000,
  "description": "Cấu hình mạnh mẽ cho lập trình viên",
  "category": {
    "categoryID": 1
  },
  "shop": {
    "shopID": 1
  }
}
```

---

## 9. Lấy danh sách tất cả sản phẩm
- **Method:** GET  
- **URL:** `/api/products`

---

## 10. Thêm sản phẩm vào giỏ
- **Method:** POST  
- **URL:** `/api/carts/add?userId=1&variantId=1`

---

## 11. Lấy danh sách & Tìm kiếm sản phẩm
- **Method:** GET  
- **URL:** `/api/products/search`

---

## 12. Lấy sản phẩm tương tự
- **Method:** GET  
- **URL:** `/api/products/5/similar?categoryId=1`

---

## 13. Lấy sản phẩm Trending hoặc Gợi ý cá nhân hóa
- **Method:** GET  
- **URL:** `/api/products/recommend?userId={userId}`

### Mô tả
- Nếu không truyền `userId` (hoặc tài khoản mới): Trả về danh sách sản phẩm **Trending**.  
- Nếu có `userId`: Trả về sản phẩm dựa trên lịch sử tìm kiếm và hành vi của người dùng.

---

## 14. Lấy sản phẩm theo Danh mục / Lựa chọn bên trái
- **Method:** GET  
- **URL:**  
  - `/api/products/search?categoryId={id}`  
  - `/api/products/filter?tag={tagName}`

### Mô tả
Lọc và hiển thị danh sách sản phẩm dựa trên danh mục được chọn từ menu bên trái hoặc theo các thẻ (**tags**).

---

## 15. Hiển thị đánh giá sản phẩm
- **Method:** GET  
- **URL:** `/api/products/{id}/reviews`

### Mô tả
Trả về danh sách tất cả đánh giá của khách hàng cho sản phẩm cụ thể (bao gồm số sao, bình luận và ngày đánh giá).

---

## 16. Hiển thị thông tin chi tiết Shop
- **Method:** GET  
- **URL:** `/api/shops/{id}`

### Mô tả
Trả về các thông tin cốt lõi của Shop như:
- Tên cửa hàng  
- Đánh giá trung bình  
- Số lượng người theo dõi (`follower_count`)

---

## 17. Sản phẩm của Shop (Trang cá nhân & Sản phẩm khác)
- **Method:** GET  
- **URL:** `/api/products/shop/{shopId}?excludeId={id}`

### Mô tả
- Nếu không có `excludeId`: Lấy toàn bộ sản phẩm của Shop (dùng cho trang cá nhân Shop).  
- Nếu có `excludeId`: Lấy sản phẩm cùng Shop nhưng loại trừ sản phẩm hiện tại (dùng cho mục **"Sản phẩm khác của Shop"**).

---

## 18. Lấy sản phẩm tương tự
- **Method:** GET  
- **URL:** `/api/products/{id}/similar`

### Mô tả
Trả về danh sách các sản phẩm có cùng danh mục hoặc cùng đặc tính với sản phẩm đang xem.

---

## 19. Cập nhật lượt theo dõi Shop (Follow / Unfollow)
- **Method:** POST  
- **URL:** `/api/shops/{id}/follow?isFollowing={true/false}`

### Params
- `isFollowing = true`: Tăng 1 lượt theo dõi  
- `isFollowing = false`: Giảm 1 lượt theo dõi  

---

## 20. Hiển thị Voucher của Shop
- **Method:** GET  
- **URL:** `/api/vouchers/shop/{shopId}`

### Mô tả
Lấy danh sách các mã giảm giá do Shop phát hành. Dữ liệu trả về qua DTO để đảm bảo an toàn thông tin.

---

## 21. Lưu Voucher vào ví người dùng (Sưu tầm)
- **Method:** POST  
- **URL:** `/api/vouchers/save?userId={userId}&voucherId={voucherId}`

### Mô tả
- Lưu mã voucher vào bảng `user_vouchers`  
- Chỉ những mã đã được lưu thành công vào ví mới có thể sử dụng khi thanh toán  
- Hệ thống tự động chặn lưu trùng  

---

## 22. Hiển thị thông báo người dùng
- **Method:** GET  
- **URL:** `/api/notifications/user/{userId}`

### Mô tả
Lấy danh sách thông báo (cập nhật đơn hàng, khuyến mãi, cảnh báo hệ thống), sắp xếp theo thời gian mới nhất lên đầu.

---

## 23. Hiển thị thông tin cá nhân người dùng
- Method: GET  
- URL: /api/users/{userId}/profile

### Response
{
  "userId": 1,
  "fullName": "Nguyễn Văn A",
  "email": "nguyenvana@gmail.com",
  "phone": "0987654321",
  "gender": "Nam",
  "birthday": "2004-05-15"
}

---

## 24. Cập nhật thông tin người dùng
- Method: PUT  
- URL: /api/users/{userId}/profile

### Body
{
  "fullName": "Nguyễn Văn A (Updated)",
  "phone": "0999888777",
  "gender": "Nam",
  "birthday": "2004-05-15",
  "password": "newpassword123"
}

---

## 25. Thông tin thanh toán
- Method: GET  
- URL: /api/checkout/payment-methods

---

## 26. Thông tin vận chuyển
- Method: GET  
- URL: /api/checkout/estimate-delivery

---

## 27. Voucher vận chuyển
- Method: GET  
- URL: /api/vouchers/shipping

---

## 28. Voucher hệ thống
- Method: GET  
- URL: /api/vouchers/platform

---

## 29. Voucher theo shop
- Method: GET  
- URL: /api/vouchers/cart-shops

---

## 30. Đặt hàng
- Method: POST  
- URL: /api/orders/place

---

## 31. Xóa giỏ hàng sau đặt
- Method: DELETE  
- URL: /api/cart/{userId}/remove-ordered

---

## 32. Lịch sử đơn hàng
- Method: GET  
- URL: /api/orders/user/{userId}

---

## 33. Chi tiết đơn hàng
- Method: GET  
- URL: /api/orders/items/{orderItemId}/details

---

## 34. Xác nhận nhận hàng
- Method: PUT  
- URL: /api/orders/{orderId}/receive

---

## 35. Đánh giá sản phẩm
- Method: POST  
- URL: /api/reviews/create
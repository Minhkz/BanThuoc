<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh - Giỏ hàng</title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
    />
    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
    />

  <link rel="stylesheet" href="${env}/client/css/cart.css">
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container py-2">
        <a class="navbar-brand" href="/">
            <span class="brand-badge">
                <i class="bi bi-capsule"></i>
            </span>
            <span>MediFresh</span>
        </a>

        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="bi bi-list fs-2"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-3">
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="/">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="/category">Danh mục</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="/login">Đăng nhập</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="/register">Đăng ký</a>
                </li>
                <li class="nav-item ms-lg-2">
                    <a class="btn btn-outline-primary rounded-pill position-relative" href="/cart">
                        <i class="bi bi-bag-check-fill me-1"></i>
                        Giỏ hàng
                        <span
                            id="cart-count"
                            class="badge bg-danger position-absolute top-0 start-100 translate-middle rounded-pill"
                            style="font-size:.7rem;min-width:1.5rem"
                        >0</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- HERO -->
<section class="container mt-4">
    <div class="cart-hero p-4 p-md-5">
        <div class="row g-4 align-items-center">
            <div class="col-md-8 text-white">
                <div class="hero-title mb-2">
                    Giỏ hàng của bạn 🛒
                </div>
                <div class="hero-desc">
                    Kiểm tra lại sản phẩm, số lượng và tổng tiền trước khi thanh toán.
                    Có thể tăng/giảm hoặc xóa từng món.
                </div>
            </div>
            <div class="col-md-4 text-white small opacity-75">
                <i class="bi bi-shield-lock me-1"></i>
                Thanh toán bảo mật.  
                <br class="d-none d-md-block">
                Chúng tôi không chia sẻ thông tin cá nhân.
            </div>
        </div>
    </div>
</section>

<!-- CART SECTION -->
<section class="container mb-5">
    <div class="cart-wrapper p-3 p-md-4 mt-n4">
        <div class="row g-4">
            <!-- BẢNG GIỎ HÀNG -->
            <div class="col-lg-8">
                <div id="cart-empty" class="d-none">
                    <div class="empty-state-card">
                        <div class="display-6 mb-3 text-muted">
                            <i class="bi bi-bag-x"></i>
                        </div>
                        <h5 class="fw-semibold">Giỏ hàng đang trống</h5>
                        <p class="text-muted small mb-4">
                            Có vẻ bạn chưa thêm sản phẩm nào.  
                            Khám phá danh mục và chọn thuốc/phụ kiện sức khỏe bạn cần nhé.
                        </p>
                        <a href="categories.html" class="btn btn-primary rounded-pill fw-semibold px-3">
                            <i class="bi bi-search-heart me-1"></i>
                            Mua ngay
                        </a>
                    </div>
                </div>

                <div id="cart-has-items">
                    <div class="table-responsive">
                        <table class="table align-middle cart-table">
                            <thead>
                                <tr>
                                    <th class="text-nowrap">Sản phẩm</th>
                                    <th class="text-nowrap text-end">Đơn giá</th>
                                    <th class="text-nowrap text-center">Số lượng</th>
                                    <th class="text-nowrap text-end">Thành tiền</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="cart-table-body">
                                <!-- JS sẽ render từng dòng -->
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mt-3">
                        <button class="btn btn-outline-danger btn-sm rounded-pill fw-semibold mb-2 mb-md-0"
                                onclick="clearCart()">
                            <i class="bi bi-trash3 me-1"></i>
                            Xóa toàn bộ giỏ
                        </button>

                        <a href="categories.html"
                           class="btn btn-outline-primary btn-sm rounded-pill fw-semibold">
                            <i class="bi bi-arrow-left-circle me-1"></i>
                            Tiếp tục mua sắm
                        </a>
                    </div>
                </div>
            </div>

            <!-- TÓM TẮT / THANH TOÁN -->
            <div class="col-lg-4">
                <div class="summary-card p-3 p-md-4">
                    <div class="summary-title mb-3">
                        Tóm tắt đơn hàng
                    </div>

                    <div class="summary-line mb-2">
                        <span>Tạm tính</span>
                        <span id="subtotal-amount">0₫</span>
                    </div>

                    <div class="summary-line mb-2">
                        <span>Phí vận chuyển</span>
                        <span id="shipping-amount">0₫</span>
                    </div>

                    <div class="summary-line mb-3">
                        <span>Mã giảm giá</span>
                        <span id="discount-amount">0₫</span>
                    </div>

                    <hr>

                    <div class="summary-total mb-3">
                        <span>Tổng thanh toán</span>
                        <span id="cart-total">0₫</span>
                    </div>

                    <div class="summary-note mb-3">
                        * Nếu có thuốc kê đơn, dược sĩ sẽ gọi xác nhận trước khi giao.
                    </div>

                    <button
                        class="btn btn-primary w-100 btn-lg btn-checkout"
                        onclick="checkoutNow()"
                    >
                        <i class="bi bi-credit-card me-1"></i>
                        Thanh toán
                    </button>

                    <div class="text-center small text-muted mt-3">
                        Bằng cách tiếp tục, bạn đồng ý với
                        <a href="#" class="text-decoration-none">Điều khoản sử dụng</a>
                        &amp;
                        <a href="#" class="text-decoration-none">Chính sách bảo mật</a>.
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer class="site-footer text-center">
    <div class="container">
        <div class="mb-2 fw-semibold text-dark">MediFresh - Nhà thuốc online</div>
        <div>Hỗ trợ 24/7 • Giao nhanh • Bảo mật đơn hàng</div>
        <div class="mt-2 text-muted">
            © 2025 MediFresh. All rights reserved.
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>
<script src="${env}/client/js/cart.js"></script>

</body>
</html>

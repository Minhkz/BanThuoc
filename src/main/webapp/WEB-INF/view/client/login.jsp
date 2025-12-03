<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh - Đăng nhập</title>

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

   <link rel="stylesheet" href="${env}/client/css/login.css">
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
                    <a class="nav-link fw-semibold active" href="/login">Đăng nhập</a>
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

<!-- AUTH SECTION -->
<section class="container mt-4 mb-5">
    <div class="row g-4 justify-content-center">
        <!-- Left panel -->
        <div class="col-md-5">
            <div class="gradient-panel h-100">
                <div class="panel-heading mb-2">
                    Chào mừng trở lại 👋
                </div>
                <div class="panel-desc mb-4">
                    Đăng nhập để xem lịch sử mua hàng, theo dõi đơn giao nhanh, và nhận tư vấn dược sĩ.
                </div>

                <div class="d-flex flex-column gap-3">
                    <div class="panel-bullet">
                        <i class="bi bi-truck"></i>
                        Theo dõi trạng thái giao hàng realtime
                    </div>
                    <div class="panel-bullet">
                        <i class="bi bi-heart-pulse"></i>
                        Lưu đơn thuốc cá nhân, nhắc giờ uống
                    </div>
                    <div class="panel-bullet">
                        <i class="bi bi-cash-coin"></i>
                        Nhận ưu đãi thành viên / mã giảm giá
                    </div>
                </div>

                <div class="small text-white-50 mt-4">
                    Chưa có tài khoản?
                    <a href="/register" class="text-white fw-semibold text-decoration-underline">
                        Đăng ký ngay
                    </a>
                </div>
            </div>
        </div>

        <!-- Right form -->
        <div class="col-md-5">
            <div class="auth-card">
                <div class="text-center mb-4">
                    <div class="auth-title">Đăng nhập</div>
                    <div class="auth-desc">
                        Vui lòng nhập email / số điện thoại và mật khẩu để tiếp tục.
                    </div>
                </div>

                <form onsubmit="handleLogin(event)">
                    <div class="mb-3">
                        <label class="form-label">Email hoặc SĐT</label>
                        <input
                            type="text"
                            class="form-control form-control-lg"
                            id="login-identifier"
                            placeholder="vd: user@gmail.com / 0901xxxxxx"
                            required
                        >
                    </div>

                    <div class="mb-2">
                        <label class="form-label d-flex justify-content-between">
                            <span>Mật khẩu</span>
                            <a href="#" class="text-decoration-none small text-primary">Quên mật khẩu?</a>
                        </label>

                        <div class="input-group input-group-lg">
                            <input
                                type="password"
                                class="form-control"
                                id="login-password"
                                placeholder="••••••••"
                                required
                            >
                            <span class="input-group-text bg-white toggle-password-btn" onclick="togglePassword('login-password', this)">
                                <i class="bi bi-eye-slash"></i>
                            </span>
                        </div>
                    </div>

                    <div class="form-check my-3">
                        <input class="form-check-input" type="checkbox" value="" id="rememberMe" checked>
                        <label class="form-check-label small" for="rememberMe">
                            Ghi nhớ đăng nhập trên thiết bị này
                        </label>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 btn-lg fw-semibold rounded-pill">
                        <i class="bi bi-door-open me-1"></i>
                        Đăng nhập
                    </button>

                    <div class="text-center mt-4 small text-muted">
                        Bằng cách đăng nhập, bạn đồng ý với
                        <a href="#" class="text-decoration-none">Điều khoản sử dụng</a>
                        &amp;
                        <a href="#" class="text-decoration-none">Chính sách bảo mật</a>.
                    </div>
                </form>
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
<script src="${env}/client/js/login.js"></script>

</body>
</html>

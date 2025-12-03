<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh - Đăng ký tài khoản</title>

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

  <link rel="stylesheet" href="${env}/client/css/register.css">
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
                    <a class="nav-link fw-semibold active" href="/register">Đăng ký</a>
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
                    Tạo tài khoản mới ✨
                </div>
                <div class="panel-desc mb-4">
                    Lưu lại thông tin sức khỏe, nhắc giờ uống thuốc và nhận ưu đãi chỉ dành cho thành viên.
                </div>

                <div class="d-flex flex-column gap-3">
                    <div class="panel-bullet">
                        <i class="bi bi-clipboard2-pulse"></i>
                        Lưu đơn thuốc cũ để mua lại nhanh
                    </div>
                    <div class="panel-bullet">
                        <i class="bi bi-capsule-pill"></i>
                        Nhắc giờ uống thuốc / nhắc mua lại
                    </div>
                    <div class="panel-bullet">
                        <i class="bi bi-percent"></i>
                        Voucher thành viên & mã freeship
                    </div>
                </div>

                <div class="small text-white-50 mt-4">
                    Đã có tài khoản?
                    <a href="/login" class="text-white fw-semibold text-decoration-underline">
                        Đăng nhập
                    </a>
                </div>
            </div>
        </div>

        <!-- Right form -->
        <div class="col-md-5">
            <div class="auth-card">
                <div class="text-center mb-4">
                    <div class="auth-title">Đăng ký tài khoản</div>
                    <div class="auth-desc">
                        Điền thông tin bên dưới để bắt đầu trải nghiệm mua thuốc an toàn.
                    </div>
                </div>

                <form onsubmit="handleRegister(event)">
                    <div class="mb-3">
                        <label class="form-label">Họ và tên</label>
                        <input
                            type="text"
                            class="form-control form-control-lg"
                            id="reg-fullname"
                            placeholder="VD: Nguyễn Văn A"
                            required
                        >
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input
                            type="email"
                            class="form-control form-control-lg"
                            id="reg-email"
                            placeholder="you@example.com"
                            required
                        >
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input
                            type="tel"
                            class="form-control form-control-lg"
                            id="reg-phone"
                            placeholder="09xxxxxxxx"
                            required
                        >
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mật khẩu</label>
                        <div class="input-group input-group-lg">
                            <input
                                type="password"
                                class="form-control"
                                id="reg-password"
                                placeholder="Tối thiểu 8 ký tự"
                                minlength="8"
                                required
                            >
                            <span class="input-group-text bg-white toggle-password-btn" onclick="togglePassword('reg-password', this)">
                                <i class="bi bi-eye-slash"></i>
                            </span>
                        </div>
                        <div class="form-text small text-muted">
                            Gợi ý: dùng ít nhất 1 chữ hoa, 1 số, 1 ký tự đặc biệt.
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Nhập lại mật khẩu</label>
                        <div class="input-group input-group-lg">
                            <input
                                type="password"
                                class="form-control"
                                id="reg-password-confirm"
                                placeholder="Nhập lại để xác nhận"
                                minlength="8"
                                required
                            >
                            <span class="input-group-text bg-white toggle-password-btn" onclick="togglePassword('reg-password-confirm', this)">
                                <i class="bi bi-eye-slash"></i>
                            </span>
                        </div>
                    </div>

                    <div class="form-check my-3">
                        <input class="form-check-input" type="checkbox" value="" id="agreeTerms" required>
                        <label class="form-check-label small" for="agreeTerms">
                            Tôi đồng ý với
                            <a href="#" class="text-decoration-none">Điều khoản sử dụng</a>
                            và
                            <a href="#" class="text-decoration-none">Chính sách bảo mật</a>.
                        </label>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 btn-lg fw-semibold rounded-pill">
                        <i class="bi bi-person-plus me-1"></i>
                        Tạo tài khoản
                    </button>

                    <div class="text-center mt-4 small text-muted">
                        Thông tin của bạn được bảo mật.  
                        Chúng tôi không chia sẻ số điện thoại cho bên thứ ba.
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
<script src="${env}/client/js/register.js"></script>

</body>
</html>

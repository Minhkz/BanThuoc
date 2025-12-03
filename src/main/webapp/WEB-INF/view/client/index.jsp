<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh - Nhà thuốc online</title>

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
   <link rel="stylesheet" href="${env}/client/css/index.css">
</head>
<body>

<!-- ========== NAVBAR ========== -->
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
                    <a class="nav-link fw-semibold active" href="/">Trang chủ</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="/category">Danh mục</a>
                </li>

                <!-- Giỏ hàng chỉ hiện khi đã login -->
                <c:if test="${not empty pageContext.request.userPrincipal}">
                    <li class="nav-item">
                        <a class="btn btn-outline-primary rounded-pill position-relative" href="/cart">
                            <i class="bi bi-bag-check-fill me-1"></i>
                            Giỏ hàng
                            <span id="cart-count"
                                class="badge bg-danger position-absolute top-0 start-100 translate-middle rounded-pill"
                                style="font-size:.7rem;min-width:1.5rem">0</span>
                        </a>
                    </li>
                </c:if>

                <!-- Nếu chưa login: nút Đăng nhập -->
                <c:if test="${empty pageContext.request.userPrincipal}">
                    <li class="nav-item ms-lg-2">
                        <a class="btn btn-primary rounded-pill fw-semibold" href="/login">
                            <i class="bi bi-person me-1"></i> Đăng nhập
                        </a>
                    </li>
                </c:if>

                <!-- Nếu đã login: nút Đăng xuất -->
                <c:if test="${not empty pageContext.request.userPrincipal}">
                    <li class="nav-item ms-lg-2">
                        <form action="/logout" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button class="btn btn-danger rounded-pill fw-semibold">
                                <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                            </button>
                        </form>
                    </li>
                </c:if>

            </ul>
        </div>
    </div>
</nav>







<!-- ========== HERO ========== -->
<section class="container mt-4">
    <div class="hero-wrapper p-4 p-md-5">
        <div class="row align-items-center g-4">
            <div class="col-md-6 text-white">
                <div class="hero-badge mb-3">
                    <i class="bi bi-shield-check"></i>
                    Thuốc chính hãng - Tư vấn dược sĩ
                </div>

                <h1 class="hero-title mb-3">
                    Mua thuốc online an toàn,<br/>
                    <span class="text-warning">giao nhanh trong 2h</span>
                </h1>

                <p class="hero-desc mb-4">
                    Giảm giá tới 30% cho các sản phẩm vitamin, giảm đau,
                    ho - cảm. Đội ngũ dược sĩ hỗ trợ 24/7.
                </p>

                <div class="d-flex flex-wrap gap-2">
                    <a href="categories.html" class="btn btn-light text-dark fw-semibold rounded-pill px-3">
                        <i class="bi bi-search-heart me-1"></i>
                        Khám phá danh mục
                    </a>

                    <!-- nút mở modal tư vấn nhanh -->
                    <button
                        class="btn btn-outline-light fw-semibold rounded-pill px-3"
                        data-bs-toggle="modal"
                        data-bs-target="#consultModal"
                    >
                        <i class="bi bi-chat-dots me-1"></i>
                        Tư vấn nhanh
                    </button>
                </div>
            </div>

            <div class="col-md-6 text-white">
                <div class="hero-illus-card">
                    <div class="d-flex align-items-center mb-2">
                        <div class="flex-shrink-0 me-3">
                            <div class="bg-white text-primary fw-bold rounded-3 d-flex align-items-center justify-content-center"
                                 style="width:48px;height:48px;font-size:.8rem;">
                                24/7
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <div class="fw-semibold small">
                                Hỗ trợ sức khỏe cá nhân
                            </div>
                            <div class="text-white-50 small">
                                Nhắn triệu chứng thường gặp:
                                đau đầu, sốt, đau bụng, ho khan...
                            </div>
                        </div>
                    </div>

                    <hr class="border-white border-opacity-25"/>

                    <div class="small text-white-50">
                        “Tư vấn sử dụng thuốc đúng liều, tránh tự ý dùng kháng sinh.”
                        <div class="d-flex align-items-center mt-2">
                            <img src="https://i.pravatar.cc/40?img=14"
                                 class="rounded-circle me-2 border border-white border-2"
                                 style="width:32px;height:32px;object-fit:cover;">
                            <div>
                                <div class="text-white fw-semibold" style="line-height:1;">Dược sĩ Linh</div>
                                <div style="line-height:1;" class="text-white-50">Nhà thuốc MediFresh</div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</section>

<!-- ========== FEATURES / CAM KẾT ========== -->
<section class="container mt-4">
    <div class="row g-3">
        <div class="col-12 col-md-4">
            <div class="feature-card h-100">
                <div class="d-flex align-items-start gap-3">
                    <div class="feature-icon">
                        <i class="bi bi-truck"></i>
                    </div>
                    <div>
                        <div class="feature-title">Giao siêu tốc 2 giờ</div>
                        <div class="feature-desc">Nhận thuốc tận tay, không cần ra tiệm, tiết kiệm thời gian khi đang mệt/ốm.</div>
                    </div>
                </div>
            </div>
        </div><!-- col -->

        <div class="col-12 col-md-4">
            <div class="feature-card h-100">
                <div class="d-flex align-items-start gap-3">
                    <div class="feature-icon">
                        <i class="bi bi-file-earmark-medical"></i>
                    </div>
                    <div>
                        <div class="feature-title">Nguồn gốc rõ ràng</div>
                        <div class="feature-desc">Chỉ bán hàng chính hãng. Lưu lô - hạn dùng, quản lý kho chặt chẽ.</div>
                    </div>
                </div>
            </div>
        </div><!-- col -->

        <div class="col-12 col-md-4">
            <div class="feature-card h-100">
                <div class="d-flex align-items-start gap-3">
                    <div class="feature-icon">
                        <i class="bi bi-heart-pulse"></i>
                    </div>
                    <div>
                        <div class="feature-title">Tư vấn miễn phí</div>
                        <div class="feature-desc">Dược sĩ trực 24/7 - hỏi liều dùng, tương tác thuốc, kiêng kỵ.</div>
                    </div>
                </div>
            </div>
        </div><!-- col -->
    </div>
</section>

<!-- ========== SẢN PHẨM NỔI BẬT ========== -->
<section class="container mt-5">
    <div class="section-title mb-3">
        <span>Sản phẩm nổi bật</span>
        <small>Xem tất cả ›</small>
    </div>

    <div class="row g-4">
        <!-- product 1 -->
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="product-card h-100">
                <div class="product-badge">-20%</div>
                <img class="product-img"
                     src="./img/paracetamol.jpg"
                     alt="Paracetamol 500mg">

                <div class="product-body">
                    <div class="product-name">
                        Paracetamol 500mg (Hạ sốt, giảm đau)
                    </div>
                    <div class="product-desc mb-2">
                        Dùng khi đau đầu, sốt nhẹ. Phù hợp người lớn.
                    </div>

                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                        <div class="price-row">
                            25.000₫
                            <span class="old-price">32.000₫</span>
                        </div>

                        <button
                            class="btn btn-primary btn-sm btn-add-cart mt-2 mt-sm-0"
                            onclick="addToCart('P001', 'Paracetamol 500mg', 25000, 'https://images.unsplash.com/photo-1584305574644-0d62611b5c44?auto=format&fit=crop&w=600&q=60')"
                        >
                            <i class="bi bi-bag-plus"></i>
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- product 2 -->
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="product-card h-100">
                <div class="product-badge bg-success" style="box-shadow:0 .5rem 1rem rgba(25,135,84,.4)">HOT</div>
                <img class="product-img"
                     src="./img/vitC.webp"
                     alt="Vitamin C 1000mg">

                <div class="product-body">
                    <div class="product-name">
                        Vitamin C 1000mg tăng đề kháng
                    </div>
                    <div class="product-desc mb-2">
                        Hỗ trợ miễn dịch, giảm mệt mỏi, đẹp da.
                    </div>

                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                        <div class="price-row">
                            89.000₫
                        </div>

                        <button
                            class="btn btn-primary btn-sm btn-add-cart mt-2 mt-sm-0"
                            onclick="addToCart('P002', 'Vitamin C 1000mg', 89000, 'https://images.unsplash.com/photo-1604582728858-027c23661db2?auto=format&fit=crop&w=600&q=60')"
                        >
                            <i class="bi bi-bag-plus"></i>
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- product 3 -->
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="product-card h-100">
                <img class="product-img"
                     src="./img/thuoc ho.webp"
                     alt="Siro ho thảo dược">

                <div class="product-body">
                    <div class="product-name">
                        Si-rô ho thảo dược cho người lớn
                    </div>
                    <div class="product-desc mb-2">
                        Giảm ho khan, dịu cổ họng, dễ ngủ hơn.
                    </div>

                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                        <div class="price-row">
                            59.000₫
                        </div>

                        <button
                            class="btn btn-primary btn-sm btn-add-cart mt-2 mt-sm-0"
                            onclick="addToCart('P003', 'Siro ho thảo dược', 59000, 'https://images.unsplash.com/photo-1599058918144-bf6a4f4377b3?auto=format&fit=crop&w=600&q=60')"
                        >
                            <i class="bi bi-bag-plus"></i>
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- product 4 -->
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="product-card h-100">
                <img class="product-img"
                     src="./img/khau trang.webp"
                     alt="Khẩu trang y tế 4 lớp">

                <div class="product-body">
                    <div class="product-name">
                        Khẩu trang y tế 4 lớp (Hộp 50 cái)
                    </div>
                    <div class="product-desc mb-2">
                        Lọc bụi mịn, giọt bắn. Phù hợp đi làm, đi học.
                    </div>

                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                        <div class="price-row">
                            42.000₫
                        </div>

                        <button
                            class="btn btn-primary btn-sm btn-add-cart mt-2 mt-sm-0"
                            onclick="addToCart('P004', 'Khẩu trang 4 lớp (50 cái)', 42000, 'https://images.unsplash.com/photo-1587854692152-326f72a5c28b?auto=format&fit=crop&w=600&q=60')"
                        >
                            <i class="bi bi-bag-plus"></i>
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>

    </div><!-- row -->
</section>

<!-- ========== CTA SỨC KHỎE / CẢNH BÁO ========== -->
<section class="container mt-5">
    <div class="alert alert-primary rounded-4 p-4 d-flex flex-column flex-md-row align-items-md-center justify-content-between">
        <div class="mb-3 mb-md-0">
            <div class="fw-semibold fs-6 text-primary">
                <i class="bi bi-bell-fill me-1"></i>
                Lưu ý quan trọng
            </div>
            <div class="text-body-secondary small">
                Sản phẩm hỗ trợ sức khỏe, không thay thế thuốc kê đơn.
                Nếu sốt cao liên tục &gt; 2 ngày hoặc khó thở: cần đi khám ngay.
            </div>
        </div>
        <button
            class="btn btn-primary fw-semibold rounded-pill px-3"
            data-bs-toggle="modal"
            data-bs-target="#consultModal"
        >
            Tư vấn nhanh
        </button>
    </div>
</section>

<!-- ========== MODAL TƯ VẤN NHANH ========== -->
<div class="modal fade" id="consultModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-4">

      <!-- Header -->
      <div
        class="modal-header border-0 text-white"
        style="background: linear-gradient(135deg,#0d6efd 0%,#6f42c1 100%);
               border-top-left-radius:1rem;
               border-top-right-radius:1rem;"
      >
        <div>
          <div class="fw-semibold d-flex align-items-center" style="font-size:1rem;">
            <i class="bi bi-headset me-2"></i>
            Tư vấn nhanh với dược sĩ
          </div>
          <div class="small text-white-50">
            Trung bình phản hồi trong ~15 phút
          </div>
        </div>

        <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <!-- Body -->
      <div class="modal-body p-4">
        <!-- FORM NHẬP THÔNG TIN -->
        <form id="consultForm" onsubmit="handleConsult(event)">
          <div class="mb-3">
            <label class="form-label fw-semibold small text-muted mb-1">
              Họ và tên
            </label>
            <input
              type="text"
              class="form-control form-control-lg"
              id="c-name"
              placeholder="VD: Trần Minh"
              required
            >
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold small text-muted mb-1">
              Số điện thoại để gọi lại
            </label>
            <input
              type="tel"
              class="form-control form-control-lg"
              id="c-phone"
              placeholder="09xxxxxxxx"
              required
            >
            <div class="form-text small text-muted">
              Dược sĩ sẽ gọi lại tư vấn liều dùng / tương tác thuốc.
            </div>
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold small text-muted mb-1">
              Bạn đang gặp vấn đề gì?
            </label>
            <textarea
              class="form-control"
              id="c-message"
              rows="3"
              placeholder="Ví dụ: sốt 38.5 từ tối qua, đau đầu và rát họng..."
              required
            ></textarea>
            <div class="form-text small text-muted">
              Không tự ý dùng kháng sinh nếu chưa được tư vấn.
            </div>
          </div>

          <button
            type="submit"
            class="btn btn-primary w-100 fw-semibold rounded-pill btn-lg"
          >
            <i class="bi bi-send-fill me-1"></i>
            Gửi yêu cầu tư vấn
          </button>

          <div class="small text-muted text-center mt-3">
            Thông tin sẽ được bảo mật.
            Nếu là trường hợp khẩn cấp (khó thở, ngất xỉu...) vui lòng đi cấp cứu ngay.
          </div>
        </form>

        <!-- TRẠNG THÁI SAU KHI GỬI THÀNH CÔNG -->
        <div id="consultSuccess" class="text-center d-none py-4">
          <div class="text-success fs-1 mb-2">
            <i class="bi bi-check-circle-fill"></i>
          </div>
          <div class="fw-semibold mb-1">
            Đã nhận thông tin 🎉
          </div>
          <div class="text-muted small mb-3">
            Dược sĩ sẽ liên hệ số điện thoại bạn cung cấp trong thời gian sớm nhất.
          </div>
          <button
            type="button"
            class="btn btn-outline-success rounded-pill fw-semibold px-3"
            data-bs-dismiss="modal"
          >
            Đóng
          </button>
        </div>

      </div>
    </div>
  </div>
</div>

<!-- ========== FOOTER ========== -->
<footer class="site-footer text-center">
    <div class="container">
        <div class="mb-2 fw-semibold text-dark">MediFresh - Nhà thuốc online</div>
        <div>Hỗ trợ 24/7 • Giao nhanh • Bảo mật đơn hàng</div>
        <div class="mt-2 text-muted">
            © 2025 MediFresh. All rights reserved.
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle (có Popper cho modal) -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>
<script src="${env}/client/js/index.js"></script>
</body>
</html>

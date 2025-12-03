<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh - Danh mục sản phẩm</title>

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

    <link rel="stylesheet" href="${env}/client/css/categories.css">
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
                    <a class="nav-link fw-semibold active" href="/category">Danh mục</a>
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

<!-- HERO / HEADER -->
<section class="container mt-4">
    <div class="category-hero p-4 p-md-5">
        <div class="row g-4 align-items-center">
            <div class="col-md-7 text-white">
                <div class="hero-title mb-2">
                    Danh mục sản phẩm & thuốc phổ biến
                </div>
                <div class="hero-desc">
                    Chọn nhóm nhu cầu (giảm đau, vitamin, ho cảm, bảo hộ...) hoặc gõ tên sản phẩm bạn muốn tìm.
                </div>
            </div>
            <div class="col-md-5 text-white">
                <div class="small opacity-75">
                    <i class="bi bi-info-circle me-1"></i>
                    Vui lòng đọc kỹ hướng dẫn sử dụng, không tự ý dùng kháng sinh dài ngày.
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FILTER CARD -->
<section class="container">
    <div class="filter-card p-3 p-md-4">
        <!-- search -->
        <div class="row g-3 align-items-center">
            <div class="col-lg-4">
                <label class="form-label fw-semibold small text-muted mb-1">Tìm kiếm nhanh</label>
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-white border-end-0">
                        <i class="bi bi-search text-muted"></i>
                    </span>
                    <input
                        id="searchInput"
                        type="text"
                        class="form-control border-start-0"
                        placeholder="Ví dụ: paracetamol, vitamin C..."
                        oninput="applyFilter()"
                    >
                </div>
            </div>

            <div class="col-lg-8">
                <label class="form-label fw-semibold small text-muted mb-1">Danh mục</label>
                <div class="d-flex flex-wrap gap-2">
                    <button
                        class="category-pill active"
                        data-cat="all"
                        onclick="selectCategory(this)"
                    >
                        <i class="bi bi-stars"></i>
                        Tất cả
                    </button>

                    <button
                        class="category-pill"
                        data-cat="giam-dau"
                        onclick="selectCategory(this)"
                    >
                        <i class="bi bi-emoji-dizzy"></i>
                        Giảm đau / Hạ sốt
                    </button>

                    <button
                        class="category-pill"
                        data-cat="vitamin"
                        onclick="selectCategory(this)"
                    >
                        <i class="bi bi-brightness-alt-high"></i>
                        Vitamin / Miễn dịch
                    </button>

                    <button
                        class="category-pill"
                        data-cat="ho-hen"
                        onclick="selectCategory(this)"
                    >
                        <i class="bi bi-wind"></i>
                        Ho / Cảm
                    </button>

                    <button
                        class="category-pill"
                        data-cat="bao-ho"
                        onclick="selectCategory(this)"
                    >
                        <i class="bi bi-shield-plus"></i>
                        Bảo hộ / Khẩu trang
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- LIST SẢN PHẨM -->
<section class="container mt-4">
    <div class="section-title mb-3">
        <span>Kết quả sản phẩm</span>
        <small id="result-count">0 sản phẩm</small>
    </div>

    <div id="productGrid" class="row g-4">

        <!-- PRODUCT: Paracetamol -->
        <div class="col-12 col-sm-6 col-lg-3 product-card-wrapper"
             data-category="giam-dau"
             data-name="Paracetamol 500mg Ha Sot Giam Dau">
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

        <!-- PRODUCT: Vitamin C -->
        <div class="col-12 col-sm-6 col-lg-3 product-card-wrapper"
             data-category="vitamin"
             data-name="Vitamin C 1000mg Tang De Khang">
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

        <!-- PRODUCT: Siro ho -->
        <div class="col-12 col-sm-6 col-lg-3 product-card-wrapper"
             data-category="ho-hen"
             data-name="Siro Ho Thao Duoc Giam Ho Khan">
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

        <!-- PRODUCT: Khẩu trang -->
        <div class="col-12 col-sm-6 col-lg-3 product-card-wrapper"
             data-category="bao-ho"
             data-name="Khau Trang Y Te 4 Lop Hop 50 Cai">
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

        <!-- PRODUCT: Vitamin tổng hợp -->
        <div class="col-12 col-sm-6 col-lg-3 product-card-wrapper"
             data-category="vitamin"
             data-name="Multivitamin Tong Hop Bo Sung Khoang Chat">
            <div class="product-card h-100">
                <img class="product-img"
                     src="./img/vitTonghop.webp"
                     alt="Multivitamin tổng hợp">

                <div class="product-body">
                    <div class="product-name">
                        Multivitamin tổng hợp hằng ngày
                    </div>
                    <div class="product-desc mb-2">
                        Bổ sung vitamin & khoáng chất cơ bản cho cơ thể.
                    </div>

                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                        <div class="price-row">
                            120.000₫
                        </div>

                        <button
                            class="btn btn-primary btn-sm btn-add-cart mt-2 mt-sm-0"
                            onclick="addToCart('P005', 'Multivitamin tổng hợp', 120000, 'https://images.unsplash.com/photo-1584305574760-9fed4adb4a21?auto=format&fit=crop&w=600&q=60')"
                        >
                            <i class="bi bi-bag-plus"></i>
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- PRODUCT: Gel rửa tay kháng khuẩn -->
        <div class="col-12 col-sm-6 col-lg-3 product-card-wrapper"
             data-category="bao-ho"
             data-name="Gel Rua Tay Khang Khuan Khong Can Nuoc">
            <div class="product-card h-100">
                <div class="product-badge bg-warning text-dark" style="box-shadow:0 .5rem 1rem rgba(255,193,7,.4)">NEW</div>
                <img class="product-img"
                     src="./img/gel.webp"
                     alt="Gel rửa tay kháng khuẩn">

                <div class="product-body">
                    <div class="product-name">
                        Gel rửa tay kháng khuẩn (không cần nước)
                    </div>
                    <div class="product-desc mb-2">
                        Sạch tay nhanh khi đi đường / nơi công cộng.
                    </div>

                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                        <div class="price-row">
                            35.000₫
                        </div>

                        <button
                            class="btn btn-primary btn-sm btn-add-cart mt-2 mt-sm-0"
                            onclick="addToCart('P006', 'Gel rửa tay kháng khuẩn', 35000, 'https://images.unsplash.com/photo-1583947581924-860bdaedbba6?auto=format&fit=crop&w=600&q=60')"
                        >
                            <i class="bi bi-bag-plus"></i>
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- PRODUCT: Thuốc ngậm ho -->
        <div class="col-12 col-sm-6 col-lg-3 product-card-wrapper"
             data-category="ho-hen"
             data-name="Vien Ngam Giam Ho Du An Hong">
            <div class="product-card h-100">
                <img class="product-img"
                     src="./img/ngamho.webp"
                     alt="Viên ngậm giảm ho dịu họng">

                <div class="product-body">
                    <div class="product-name">
                        Viên ngậm giảm ho dịu họng
                    </div>
                    <div class="product-desc mb-2">
                        Dễ mang theo, giảm rát cổ, thơm bạc hà nhẹ.
                    </div>

                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                        <div class="price-row">
                            29.000₫
                        </div>

                        <button
                            class="btn btn-primary btn-sm btn-add-cart mt-2 mt-sm-0"
                            onclick="addToCart('P007', 'Viên ngậm giảm ho', 29000, 'https://images.unsplash.com/photo-1588776814546-1f4240c8a138?auto=format&fit=crop&w=600&q=60')"
                        >
                            <i class="bi bi-bag-plus"></i>
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- PRODUCT: Thuốc giảm đau cơ-xương -->
        <div class="col-12 col-sm-6 col-lg-3 product-card-wrapper"
             data-category="giam-dau"
             data-name="Thuoc Giam Dau Co Xuong Vai Gay Lieu Vua">
            <div class="product-card h-100">
                <img class="product-img"
                     src="./img/thuoc dau.jpg"
                     alt="Giảm đau cơ-xương khớp">

                <div class="product-body">
                    <div class="product-name">
                        Thuốc giảm đau cơ - vai - gáy liều vừa
                    </div>
                    <div class="product-desc mb-2">
                        Hỗ trợ giảm đau cơ bắp sau vận động mạnh.
                    </div>

                    <div class="d-flex align-items-center justify-content-between flex-wrap">
                        <div class="price-row">
                            75.000₫
                        </div>

                        <button
                            class="btn btn-primary btn-sm btn-add-cart mt-2 mt-sm-0"
                            onclick="addToCart('P008', 'Thuốc giảm đau cơ vai gáy', 75000, 'https://images.unsplash.com/photo-1579165466741-7f35e4755592?auto=format&fit=crop&w=600&q=60')"
                        >
                            <i class="bi bi-bag-plus"></i>
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>

    </div><!-- /row -->
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

<script src="${env}/client/js/categories.js"></script>

</body>
</html>

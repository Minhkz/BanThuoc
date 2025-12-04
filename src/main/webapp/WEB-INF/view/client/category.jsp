<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <small id="result-count">
            <c:choose>
                <c:when test="${not empty products}">
                    ${fn:length(products)} sản phẩm
                </c:when>
                <c:otherwise>0 sản phẩm</c:otherwise>
            </c:choose>
        </small>
    </div>

    <div id="productGrid" class="row g-4">

        <c:forEach items="${products}" var="p">
            <%-- Xác định category ở view, không đụng DB --%>
            <c:set var="cat" value="all" />
            <c:if test="${fn:contains(p.name, 'Paracetamol')}">
                <c:set var="cat" value="giam-dau" />
            </c:if>
            <c:if test="${fn:contains(p.name, 'Giảm đau')}">
                <c:set var="cat" value="giam-dau" />
            </c:if>
            <c:if test="${fn:contains(p.name, 'Vitamin')}">
                <c:set var="cat" value="vitamin" />
            </c:if>
            <c:if test="${fn:contains(p.name, 'Ho') || fn:contains(p.name, 'Siro')}">
                <c:set var="cat" value="ho-hen" />
            </c:if>
            <c:if test="${fn:contains(p.name, 'Khẩu trang') || fn:contains(p.name, 'Gel')}">
                <c:set var="cat" value="bao-ho" />
            </c:if>

            <div class="col-12 col-sm-6 col-lg-3 product-card-wrapper"
                 data-category="${cat}"
                 data-name="${p.name}">
                <div class="product-card h-100">

                    <!-- BADGE -->
                    <c:if test="${p.isHot}">
                        <div class="product-badge bg-success">HOT</div>
                    </c:if>
                    <c:if test="${p.isNew}">
                        <div class="product-badge bg-warning text-dark">NEW</div>
                    </c:if>

                   <!-- IMAGE -->
<c:choose>
    <c:when test="${not empty p.image}">
        <img class="product-img"
             src="${pageContext.request.contextPath}/uploads/product/${p.image}"
             alt="${p.name}"
             onerror="this.src='https://via.placeholder.com/300x300?text=MediFresh';" />
    </c:when>

                    <div class="product-body">
                        <div class="product-name">
                            ${p.name}
                        </div>

                        <div class="product-desc mb-2">
                            ${p.shortDesc}
                        </div>

                        <div class="d-flex align-items-center justify-content-between flex-wrap">
                            <div class="price-row">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/>
                            </div>

                            <button
    type="button"
    class="btn btn-primary btn-sm btn-add-cart mt-2 mt-sm-0"
    onclick="addToCart(
        '${p.id}',
        '${fn:escapeXml(p.name)}',
        '${p.price}',
        '${pageContext.request.contextPath}/uploads/product/${p.image}'
    )">
    <i class="bi bi-bag-plus"></i> Thêm
</button>
                        </div>
                    </div>

                </div>
            </div>
        </c:forEach>

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

<script src="${env}/client/js/categories.js"></script>

<!-- JS tự xử lý filter + addToCart để chắc chắn chạy -->
<script>
    let currentCategory = 'all';

    function selectCategory(btn) {
        currentCategory = btn.getAttribute('data-cat');

        document.querySelectorAll('.category-pill').forEach(b => {
            b.classList.remove('active');
        });
        btn.classList.add('active');

        applyFilter();
    }

    function applyFilter() {
        const input = document.getElementById('searchInput');
        const keyword = input ? input.value.toLowerCase() : '';

        const cards = document.querySelectorAll('.product-card-wrapper');
        let visibleCount = 0;

        cards.forEach(card => {
            const name = (card.getAttribute('data-name') || '').toLowerCase();
            const cat = card.getAttribute('data-category') || 'all';

            const matchCat = (currentCategory === 'all' || cat === currentCategory);
            const matchName = (!keyword || name.includes(keyword));

            if (matchCat && matchName) {
                card.style.display = '';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        const resultCount = document.getElementById('result-count');
        if (resultCount) {
            resultCount.textContent = visibleCount + ' sản phẩm';
        }
    }

    // Khởi tạo filter lần đầu
    document.addEventListener('DOMContentLoaded', function () {
        applyFilter();
    });

    // Hàm thêm vào giỏ hàng – có thể chỉnh lại URL nếu controller khác
    function addToCart(id, name, price, imageUrl) {
        // Cách đơn giản: redirect sang controller xử lý thêm giỏ
        window.location.href = '${pageContext.request.contextPath}/cart/add?productId=' + encodeURIComponent(id);
    }
</script>

</body>
</html>

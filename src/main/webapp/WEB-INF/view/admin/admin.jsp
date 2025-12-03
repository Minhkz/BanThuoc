<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh Admin - Dashboard</title>

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

    <style>
        :root {
            --brand-start: #0d6efd;
            --brand-end:   #6f42c1;
        }

        body {
            background-color: #f5f7fa;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", sans-serif;
        }

        /* SIDEBAR */
        .admin-sidebar {
            width: 240px;
            background: #fff;
            border-right: 1px solid rgba(0,0,0,.05);
            box-shadow: 0 1rem 2rem rgba(0,0,0,.06);
            min-height: 100vh;
        }
        .sidebar-brand-badge {
            background: linear-gradient(135deg,var(--brand-start),var(--brand-end));
            color: #fff;
            font-weight: 600;
            font-size: .8rem;
            padding: .5rem .75rem;
            border-radius: .75rem;
            display: inline-flex;
            align-items: center;
            gap: .5rem;
            line-height: 1.2;
            box-shadow: 0 .75rem 1.5rem rgba(13,110,253,.35);
        }
        .sidebar-brand-text {
            font-weight: 600;
            font-size: 1rem;
            color: #212529;
        }
        .sidebar-section-title {
            font-size: .7rem;
            font-weight: 600;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: .05em;
            margin-top: 1rem;
            margin-bottom: .5rem;
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            gap: .75rem;
            text-decoration: none;
            font-size: .9rem;
            font-weight: 500;
            color: #495057;
            padding: .6rem .75rem;
            border-radius: .75rem;
            transition: all .12s;
        }
        .sidebar-link i {
            font-size: 1.1rem;
            width: 1.4rem;
            text-align: center;
        }
        .sidebar-link:hover {
            background-color: #f8f9fa;
            box-shadow: 0 .75rem 1.5rem rgba(0,0,0,.05);
        }
        .sidebar-link.active {
            color: #fff;
            background: linear-gradient(135deg,var(--brand-start),var(--brand-end));
            box-shadow: 0 .75rem 1.5rem rgba(13,110,253,.35);
        }

        /* TOPBAR */
        .admin-topbar .badge {
            font-size: .7rem;
        }

        /* HERO */
        .admin-hero {
            background: radial-gradient(circle at 20% 20%, rgba(255,255,255,.25) 0%, rgba(255,255,255,0) 60%),
                        linear-gradient(135deg, var(--brand-start) 0%, var(--brand-end) 100%);
            border-radius: 1.5rem;
            color: #fff;
            position: relative;
            overflow: hidden;
            box-shadow: 0 1rem 2rem rgba(13,110,253,.3);
        }
        .admin-hero::after {
            content: "";
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255,255,255,.12);
            filter: blur(40px);
            border-radius: 50%;
            right: -60px;
            bottom: -60px;
        }
        .hero-title {
            font-size: clamp(1.2rem, 0.6vw + 1rem, 1.5rem);
            font-weight: 600;
            line-height: 1.3;
            color: #fff;
        }
        .hero-desc {
            color: rgba(255,255,255,.9);
            font-size: .9rem;
        }

        /* KPI cards */
        .kpi-card {
            background:#fff;
            border-radius:1rem;
            border:1px solid rgba(0,0,0,.05);
            box-shadow:0 1rem 2rem rgba(0,0,0,.06);
            padding:1rem 1.25rem;
            height:100%;
        }
        .kpi-icon {
            font-size:1.2rem;
            width:2.5rem;
            height:2.5rem;
            border-radius:.75rem;
            display:flex;
            align-items:center;
            justify-content:center;
            color:#fff;
            background:linear-gradient(135deg,var(--brand-start),var(--brand-end));
            box-shadow:0 .75rem 1.5rem rgba(13,110,253,.35);
        }
        .kpi-label {
            font-size:.7rem;
            font-weight:600;
            color:#6c757d;
            text-transform:uppercase;
            letter-spacing:.05em;
        }
        .kpi-value {
            font-size:1.1rem;
            font-weight:600;
            line-height:1.3;
            color:#212529;
        }
        .kpi-note {
            font-size:.8rem;
            color:#6c757d;
        }

        /* table preview */
        .section-head-title {
            font-size:1rem;
            font-weight:600;
            color:#212529;
        }
        .section-head-desc {
            font-size:.8rem;
            color:#6c757d;
        }
        .table thead th {
            font-size:.75rem;
            font-weight:600;
            color:#6c757d;
            text-transform:uppercase;
            letter-spacing:.03em;
            border-top:none;
            background-color:#fff;
            white-space:nowrap;
        }
        .text-status {
            font-size:.8rem;
            font-weight:600;
        }
        .text-status.pending {
            color:#fd7e14;
        }
        .text-status.done {
            color:#198754;
        }
        .text-status.cancel {
            color:#dc3545;
        }
    </style>
</head>
<body>

<!-- OFFCANVAS (mobile menu) -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="adminMenuOffcanvas">
    <div class="offcanvas-header">
        <div>
            <div class="sidebar-brand-badge mb-2">
                <i class="bi bi-capsule"></i>
                <span>MediFresh</span>
            </div>
            <div class="sidebar-brand-text">Bảng điều khiển</div>
        </div>
        <button type="button" class="btn-close ms-auto" data-bs-dismiss="offcanvas" aria-label="Đóng"></button>
    </div>
    <div class="offcanvas-body">
        <div class="sidebar-section-title">Quản lý</div>
        <a class="sidebar-link active" href="admin-dashboard.html">
            <i class="bi bi-speedometer2"></i>
            Dashboard
        </a>
        <a class="sidebar-link" href="admin-products.html">
            <i class="bi bi-box-seam"></i>
            Sản phẩm
        </a>
        <a class="sidebar-link" href="admin-orders.html">
            <i class="bi bi-receipt"></i>
            Đơn hàng
        </a>
        <a class="sidebar-link" href="admin-users.html">
            <i class="bi bi-people"></i>
            Người dùng
        </a>

        <div class="sidebar-section-title">Hệ thống</div>
        <a class="sidebar-link text-danger" href="#">
            <i class="bi bi-box-arrow-right"></i>
            Đăng xuất
        </a>
    </div>
</div>

<div class="d-flex">
    <!-- SIDEBAR (desktop) -->
    <aside class="admin-sidebar d-none d-lg-flex flex-column p-3">
        <div class="mb-4">
            <div class="sidebar-brand-badge mb-2">
                <i class="bi bi-capsule"></i>
                <span>MediFresh</span>
            </div>
            <div class="sidebar-brand-text">Bảng điều khiển</div>
        </div>

        <div>
            <div class="sidebar-section-title">Quản lý</div>
            <a class="sidebar-link active" href="admin-dashboard.html">
                <i class="bi bi-speedometer2"></i>
                Dashboard
            </a>
            <a class="sidebar-link" href="admin-products.html">
                <i class="bi bi-box-seam"></i>
                Sản phẩm
            </a>
            <a class="sidebar-link" href="admin-orders.html">
                <i class="bi bi-receipt"></i>
                Đơn hàng
            </a>
            <a class="sidebar-link" href="admin-users.html">
                <i class="bi bi-people"></i>
                Người dùng
            </a>
        </div>

        <div class="mt-auto pt-3">
            <div class="sidebar-section-title">Hệ thống</div>
            <a class="sidebar-link text-danger" href="#">
                <i class="bi bi-box-arrow-right"></i>
                Đăng xuất
            </a>
        </div>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="flex-grow-1">

        <!-- Top bar -->
        <div class="admin-topbar d-flex align-items-center justify-content-between p-3 p-lg-4">
            <div class="d-flex align-items-center gap-2">
                <button
                    class="btn btn-outline-secondary d-lg-none"
                    data-bs-toggle="offcanvas"
                    data-bs-target="#adminMenuOffcanvas"
                >
                    <i class="bi bi-list"></i>
                </button>

                <div class="fw-semibold" style="font-size:.95rem;">
                    Dashboard
                </div>
                <span class="badge bg-primary-subtle text-primary rounded-pill fw-semibold">
                    Admin
                </span>
            </div>

            <div class="d-flex align-items-center gap-3">
                <div class="text-end d-none d-sm-block">
                    <div class="fw-semibold" style="font-size:.9rem;">Dược sĩ Linh</div>
                    <div class="text-muted" style="font-size:.8rem;">Quản lý kho</div>
                </div>
                <img
                    src="https://i.pravatar.cc/48?img=14"
                    class="rounded-circle border"
                    style="width:40px;height:40px;object-fit:cover;"
                    alt="user avatar"
                >
            </div>
        </div>

        <!-- Hero -->
        <section class="container-fluid px-3 px-lg-4">
            <div class="admin-hero p-4 mb-4">
                <div class="row g-3 align-items-center">
                    <div class="col-lg-8 text-white">
                        <div class="hero-title mb-2">
                            Tổng quan hoạt động hôm nay
                        </div>
                        <div class="hero-desc">
                            Xem nhanh doanh thu, đơn hàng, tồn kho và người dùng mới.
                        </div>
                    </div>
                    <div class="col-lg-4 text-white small opacity-75">
                        <i class="bi bi-shield-check me-1"></i>
                        Tối ưu tồn kho, đảm bảo thuốc chính hãng, theo dõi hết hạn.
                    </div>
                </div>
            </div>
        </section>

        <!-- KPI cards -->
        <section class="container-fluid px-3 px-lg-4 mb-4">
            <div class="row g-3">
                <div class="col-6 col-xl-3">
                    <div class="kpi-card h-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="kpi-label mb-1">Doanh thu hôm nay</div>
                                <div class="kpi-value">-</div>
                            </div>
                            <div class="kpi-icon">
                                <i class="bi bi-cash-stack"></i>
                            </div>
                        </div>
                        <div class="kpi-note mt-2">
                            Từ đơn đã thanh toán
                        </div>
                    </div>
                </div>

                <div class="col-6 col-xl-3">
                    <div class="kpi-card h-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="kpi-label mb-1">Đơn chờ xử lý</div>
                                <div class="kpi-value">-</div>
                            </div>
                            <div class="kpi-icon">
                                <i class="bi bi-clock-history"></i>
                            </div>
                        </div>
                        <div class="kpi-note mt-2">
                            Cần xác nhận / đóng gói
                        </div>
                    </div>
                </div>

                <div class="col-6 col-xl-3">
                    <div class="kpi-card h-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="kpi-label mb-1">Sản phẩm sắp hết</div>
                                <div class="kpi-value">-</div>
                            </div>
                            <div class="kpi-icon">
                                <i class="bi bi-exclamation-triangle"></i>
                            </div>
                        </div>
                        <div class="kpi-note mt-2">
                            &lt; 10 sản phẩm còn lại
                        </div>
                    </div>
                </div>

                <div class="col-6 col-xl-3">
                    <div class="kpi-card h-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="kpi-label mb-1">Người dùng mới</div>
                                <div class="kpi-value">-</div>
                            </div>
                            <div class="kpi-icon">
                                <i class="bi bi-person-plus"></i>
                            </div>
                        </div>
                        <div class="kpi-note mt-2">
                            Trong 24h gần nhất
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Preview tables -->
        <section class="container-fluid px-3 px-lg-4 mb-5">
            <div class="row g-4">
                <!-- Đơn hàng gần đây -->
                <div class="col-lg-6">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <div>
                            <div class="section-head-title">Đơn hàng gần đây</div>
                            <div class="section-head-desc">3 đơn gần nhất</div>
                        </div>
                        <a class="btn btn-sm btn-outline-primary rounded-pill fw-semibold" href="admin-orders.html">
                            Xem tất cả
                        </a>
                    </div>

                    <div class="table-responsive shadow-sm rounded-4 border bg-white">
                        <table class="table align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Khách hàng</th>
                                    <th class="text-end">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="text-muted text-center">
                                    <td colspan="3" class="py-4 small">
                                        Chưa có dữ liệu đơn hàng
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Sản phẩm cảnh báo -->
                <div class="col-lg-6">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <div>
                            <div class="section-head-title">Tồn kho cảnh báo</div>
                            <div class="section-head-desc">Sắp hết hoặc sắp hết hạn</div>
                        </div>
                        <a class="btn btn-sm btn-outline-primary rounded-pill fw-semibold" href="admin-products.html">
                            Xem kho
                        </a>
                    </div>

                    <div class="table-responsive shadow-sm rounded-4 border bg-white">
                        <table class="table align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th class="text-center">Tồn kho</th>
                                    <th class="text-end">Hạn dùng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="text-muted text-center">
                                    <td colspan="3" class="py-4 small">
                                        Chưa có cảnh báo tồn kho
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </section>

    </main>
</div>

<!-- Bootstrap JS -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>

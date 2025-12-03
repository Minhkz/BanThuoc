<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh Admin - Đơn hàng</title>

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

        /* HEADER STRIP */
        .page-header-strip {
            background: radial-gradient(circle at 20% 20%, rgba(255,255,255,.25) 0%, rgba(255,255,255,0) 60%),
                        linear-gradient(135deg, var(--brand-start) 0%, var(--brand-end) 100%);
            border-radius: 1rem;
            box-shadow: 0 1rem 2rem rgba(13,110,253,.3);
            color:#fff;
        }
        .page-header-title {
            font-weight:600;
            font-size:1.1rem;
            color:#fff;
            line-height:1.3;
        }
        .page-header-desc {
            font-size:.9rem;
            color:rgba(255,255,255,.9);
        }

        /* TABLE */
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
        .order-status-badge {
            font-size:.7rem;
            font-weight:600;
            border-radius:.5rem;
            padding:.25rem .5rem;
            display:inline-block;
            line-height:1.2;
        }
        .order-status-pending {
            background:#fff3cd;
            color:#856404;
            border:1px solid #ffeeba;
        }
        .order-status-paid {
            background:#d1e7dd;
            color:#0f5132;
            border:1px solid #badbcc;
        }
        .order-status-cancel {
            background:#f8d7da;
            color:#842029;
            border:1px solid #f5c2c7;
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
        <a class="sidebar-link" href="admin-dashboard.html">
            <i class="bi bi-speedometer2"></i>
            Dashboard
        </a>
        <a class="sidebar-link" href="admin-products.html">
            <i class="bi bi-box-seam"></i>
            Sản phẩm
        </a>
        <a class="sidebar-link active" href="admin-orders.html">
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
            <a class="sidebar-link" href="admin-dashboard.html">
                <i class="bi bi-speedometer2"></i>
                Dashboard
            </a>
            <a class="sidebar-link" href="admin-products.html">
                <i class="bi bi-box-seam"></i>
                Sản phẩm
            </a>
            <a class="sidebar-link active" href="admin-orders.html">
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
                    Đơn hàng
                </div>
                <span class="badge bg-primary-subtle text-primary rounded-pill fw-semibold">
                    Quản lý bán hàng
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

        <!-- Header strip -->
        <section class="container-fluid px-3 px-lg-4">
            <div class="page-header-strip p-4 mb-4">
                <div class="row g-3 align-items-center text-white">
                    <div class="col-md-8">
                        <div class="page-header-title mb-1">
                            Quản lý đơn hàng
                        </div>
                        <div class="page-header-desc">
                            Kiểm tra trạng thái thanh toán và giao hàng.
                        </div>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <button class="btn btn-light fw-semibold rounded-pill btn-sm">
                            <i class="bi bi-arrow-repeat me-1"></i>
                            Làm mới
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Filter + Table -->
        <section class="container-fluid px-3 px-lg-4 mb-5">
            <div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-end flex-wrap gap-3 mb-3">
                <div>
                    <div class="section-head-title">Danh sách đơn hàng</div>
                    <div class="section-head-desc">
                        Theo dõi mã đơn, khách hàng, tổng tiền, trạng thái
                    </div>
                </div>

                <div class="d-flex flex-wrap gap-2">
                    <div class="input-group input-group-sm" style="width:220px;">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="bi bi-search text-muted"></i>
                        </span>
                        <input
                            type="text"
                            class="form-control border-start-0"
                            placeholder="Tìm theo mã đơn..."
                        >
                    </div>

                    <select class="form-select form-select-sm" style="width:auto;">
                        <option selected>Lọc trạng thái</option>
                        <option>Chờ xử lý</option>
                        <option>Đã thanh toán</option>
                        <option>Đã huỷ</option>
                    </select>
                </div>
            </div>

            <div class="table-responsive shadow-sm rounded-4 border bg-white">
                <table class="table align-middle mb-0">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Khách hàng</th>
                            <th>SĐT</th>
                            <th class="text-end">Tổng tiền</th>
                            <th class="text-end">Trạng thái</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="text-muted text-center">
                            <td colspan="6" class="py-5 small">
                                <div class="mb-2">
                                    <i class="bi bi-receipt fs-4"></i>
                                </div>
                                <div class="fw-semibold">Chưa có đơn hàng</div>
                                <div class="text-muted small">
                                    Đơn hàng mới sẽ hiển thị ở đây để bạn xử lý.
                                </div>
                            </td>
                        </tr>
                        <!-- Ví dụ mẫu tĩnh nếu bạn muốn hiển thị:
                        <tr>
                            <td><span class="fw-semibold">HD001</span></td>
                            <td>Nguyễn Văn A</td>
                            <td>0901xxx...</td>
                            <td class="text-end">150.000₫</td>
                            <td class="text-end">
                                <span class="order-status-badge order-status-pending">Chờ xử lý</span>
                            </td>
                            <td class="text-end">
                                <button class="btn btn-sm btn-outline-primary rounded-pill fw-semibold">
                                    Chi tiết
                                </button>
                            </td>
                        </tr>
                        -->
                    </tbody>
                </table>
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

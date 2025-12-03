<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh Admin - Sản phẩm</title>

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

        /* TABLE / FORM */
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
        .product-row-img {
            width:48px;
            height:48px;
            border-radius:.5rem;
            border:1px solid rgba(0,0,0,.08);
            object-fit:cover;
            background:#f8f9fa;
        }
        .prod-name {
            font-size:.9rem;
            font-weight:600;
            color:#212529;
            line-height:1.3;
        }
        .prod-id {
            font-size:.8rem;
            color:#6c757d;
        }
        .prod-cat {
            font-size:.8rem;
            color:#495057;
            font-weight:500;
        }
        .qty-badge {
            color:#6c757d;
            background-color:#e9ecef;
            border-radius:.5rem;
            font-size:.7rem;
            font-weight:600;
            padding:.15rem .4rem;
        }
        .exp-text {
            color:#6c757d;
            font-size:.8rem;
        }
        .price-cell {
            font-weight:600;
            color:var(--brand-start);
        }

        /* MODAL */
        .modal-content {
            border-radius:1rem;
            border:0;
            box-shadow:0 1rem 2rem rgba(0,0,0,.15);
        }
        .modal-header {
            border-top-left-radius:1rem;
            border-top-right-radius:1rem;
            border-bottom:0;
        }
        .modal-header.bg-gradient-brand {
            background:linear-gradient(135deg,var(--brand-start),var(--brand-end));
            color:#fff;
            box-shadow:0 .75rem 1.5rem rgba(13,110,253,.35);
        }
        .modal-header .modal-title {
            font-size:1rem;
            font-weight:600;
        }
        .form-label {
            font-size:.85rem;
            font-weight:500;
            color:#343a40;
        }
        .form-text {
            font-size:.75rem;
        }
        .btn-rounded-pill {
            border-radius:.75rem;
            font-weight:600;
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
        <a class="sidebar-link active" href="admin-products.html">
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

        <div class="mt-auto pt-3">
    <div class="sidebar-section-title">Hệ thống</div>

    <!-- Đăng xuất (click link -> submit form POST) -->
    <a class="sidebar-link text-danger" href="#" 
       onclick="event.preventDefault(); document.getElementById('logoutForm').submit();">
        <i class="bi bi-box-arrow-right"></i>
        Đăng xuất
    </a>

    <form id="logoutForm" action="/logout" method="post" style="display:none;">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
</div>
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
            <a class="sidebar-link active" href="admin-products.html">
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

    <!-- Đăng xuất (click link -> submit form POST) -->
    <a class="sidebar-link text-danger" href="#" 
       onclick="event.preventDefault(); document.getElementById('logoutForm').submit();">
        <i class="bi bi-box-arrow-right"></i>
        Đăng xuất
    </a>

    <form id="logoutForm" action="/logout" method="post" style="display:none;">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
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
                    Sản phẩm
                </div>
                <span class="badge bg-primary-subtle text-primary rounded-pill fw-semibold">
                    Kho hàng
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
                            Quản lý sản phẩm / tồn kho
                        </div>
                        <div class="page-header-desc">
                            Thêm mới, chỉnh sửa giá bán, kiểm tra tồn và hạn dùng.
                        </div>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <button
                            class="btn btn-light fw-semibold rounded-pill btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#addProductModal"
                        >
                            <i class="bi bi-plus-lg me-1"></i>
                            Thêm sản phẩm
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Filter + Table -->
        <section class="container-fluid px-3 px-lg-4 mb-5">
            <div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-end flex-wrap gap-3 mb-3">
                <div>
                    <div class="section-head-title">Danh sách sản phẩm</div>
                    <div class="section-head-desc">
                        Kiểm tra số lượng còn lại và hạn dùng
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
                            placeholder="Tìm thuốc..."
                        >
                    </div>

                    <select class="form-select form-select-sm" style="width:auto;">
                        <option selected>Lọc theo danh mục</option>
                        <option>Giảm đau</option>
                        <option>Vitamin</option>
                        <option>Ho / Cảm</option>
                        <option>Bảo hộ</option>
                    </select>
                </div>
            </div>

            <div class="table-responsive shadow-sm rounded-4 border bg-white">
                <table class="table align-middle mb-0">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Danh mục</th>
                            <th class="text-center">Tồn kho</th>
                            <th>Hạn dùng</th>
                            <th class="text-end">Giá bán</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                <div class="mb-2">
                                    <i class="bi bi-box-seam fs-4"></i>
                                </div>
                                <div class="fw-semibold">Chưa có dữ liệu kho</div>
                                <div class="small text-muted mb-3">
                                    Hãy nhấn "Thêm sản phẩm" để tạo sản phẩm đầu tiên.
                                </div>
                                <button
                                    class="btn btn-outline-primary btn-sm btn-rounded-pill fw-semibold"
                                    data-bs-toggle="modal"
                                    data-bs-target="#addProductModal"
                                >
                                    <i class="bi bi-plus-lg me-1"></i>
                                    Thêm sản phẩm
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

    </main>
</div>

<!-- MODAL Thêm sản phẩm -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <form class="modal-content">
            <div class="modal-header bg-gradient-brand text-white">
                <h5 class="modal-title">
                    <i class="bi bi-plus-circle me-2"></i>
                    Thêm sản phẩm mới
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Tên sản phẩm</label>
                    <input type="text" class="form-control form-control-lg" placeholder="VD: Paracetamol 500mg" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mã sản phẩm (SKU)</label>
                    <input type="text" class="form-control form-control-lg" placeholder="VD: P001" required>
                    <div class="form-text">Mã duy nhất để tra cứu nhanh.</div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Danh mục</label>
                    <input type="text" class="form-control form-control-lg" placeholder="Giảm đau / Vitamin / Ho cảm..." required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Giá bán (VNĐ)</label>
                    <input type="number" min="0" step="1000" class="form-control form-control-lg" placeholder="25000" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Số lượng nhập ban đầu</label>
                    <input type="number" min="0" step="1" class="form-control form-control-lg" placeholder="50" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Hạn dùng (YYYY-MM-DD)</label>
                    <input type="date" class="form-control form-control-lg" required>
                    <div class="form-text">
                        Ngày hết hạn gần nhất của lô hàng.
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Ảnh minh họa (URL)</label>
                    <input type="url" class="form-control form-control-lg" placeholder="https://...jpg">
                    <div class="form-text">
                        Có thể để trống, sẽ dùng ảnh mặc định.
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button
                    type="button"
                    class="btn btn-outline-secondary btn-rounded-pill"
                    data-bs-dismiss="modal"
                >Hủy</button>
                <button
                    type="submit"
                    class="btn btn-primary btn-rounded-pill fw-semibold"
                >
                    <i class="bi bi-save me-1"></i>
                    Lưu sản phẩm
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>

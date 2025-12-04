<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh Admin - Sản phẩm</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>

    <style>
        :root { --brand-start:#0d6efd; --brand-end:#6f42c1; }
        body { background-color:#f5f7fa; font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",sans-serif; }
        .admin-sidebar{width:240px;background:#fff;border-right:1px solid rgba(0,0,0,.05);box-shadow:0 1rem 2rem rgba(0,0,0,.06);min-height:100vh;}
        .sidebar-brand-badge{background:linear-gradient(135deg,var(--brand-start),var(--brand-end));color:#fff;font-weight:600;font-size:.8rem;padding:.5rem .75rem;border-radius:.75rem;display:inline-flex;align-items:center;gap:.5rem;line-height:1.2;box-shadow:0 .75rem 1.5rem rgba(13,110,253,.35);}
        .sidebar-link{display:flex;align-items:center;gap:.75rem;text-decoration:none;font-size:.9rem;font-weight:500;color:#495057;padding:.6rem .75rem;border-radius:.75rem;transition:all .12s;}
        .sidebar-link:hover{background-color:#f8f9fa;box-shadow:0 .75rem 1.5rem rgba(0,0,0,.05);}
        .sidebar-link.active{color:#fff;background:linear-gradient(135deg,var(--brand-start),var(--brand-end));box-shadow:0 .75rem 1.5rem rgba(13,110,253,.35);}
        .page-header-strip{background:linear-gradient(135deg,var(--brand-start),var(--brand-end));border-radius:1rem;box-shadow:0 1rem 2rem rgba(13,110,253,.3);color:#fff;}
        .prod-name{font-size:.9rem;font-weight:600;color:#212529;}
        .product-row-img{width:48px;height:48px;border-radius:.5rem;border:1px solid rgba(0,0,0,.08);object-fit:cover;}
        .price-cell{font-weight:600;color:var(--brand-start);}
        .qty-badge{color:#6c757d;background-color:#e9ecef;border-radius:.5rem;font-size:.7rem;font-weight:600;padding:.15rem .4rem;}
        .modal-content{border-radius:1rem;border:0;box-shadow:0 1rem 2rem rgba(0,0,0,.15);}
        .modal-header.bg-gradient-brand{background:linear-gradient(135deg,var(--brand-start),var(--brand-end));color:#fff;box-shadow:0 .75rem 1.5rem rgba(13,110,253,.35);}
    </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="d-flex">
    <aside class="admin-sidebar d-none d-lg-flex flex-column p-3">
        <div class="mb-4">
            <div class="sidebar-brand-badge mb-2"><i class="bi bi-capsule"></i><span>MediFresh</span></div>
            <div class="fw-bold">Bảng điều khiển</div>
        </div>

        <div>
            <div class="text-uppercase text-muted small fw-bold mb-2">Quản lý</div>
            <a class="sidebar-link active" href="${pageContext.request.contextPath}/admin/products">
                <i class="bi bi-box-seam"></i> Sản phẩm
            </a>
            <a class="sidebar-link" href="#"><i class="bi bi-receipt"></i> Đơn hàng</a>
            <a class="sidebar-link" href="#"><i class="bi bi-people"></i> Người dùng</a>
        </div>

        <div class="mt-auto pt-3">
            <div class="text-uppercase text-muted small fw-bold mb-2">Hệ thống</div>
            <a class="sidebar-link text-danger" href="#" 
               onclick="event.preventDefault(); document.getElementById('logoutForm').submit();">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
            <form id="logoutForm" action="/logout" method="post" style="display:none;">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>
        </div>
    </aside>

    <!-- MAIN -->
    <main class="flex-grow-1">
        <!-- Header -->
        <section class="container-fluid px-4 py-3">
            <div class="page-header-strip p-4 mb-4">
                <div class="row align-items-center text-white">
                    <div class="col-md-8">
                        <h5 class="fw-semibold mb-1">Quản lý sản phẩm</h5>
                        <div class="small text-light">Thêm, sửa, xóa và kiểm tra tồn kho</div>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <button class="btn btn-light fw-semibold rounded-pill btn-sm"
                                data-bs-toggle="modal" data-bs-target="#addProductModal">
                            <i class="bi bi-plus-lg me-1"></i> Thêm sản phẩm
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Danh sách -->
        <section class="container-fluid px-4 mb-5">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="table-responsive shadow-sm rounded-4 border bg-white">
                <table class="table align-middle mb-0">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Trạng thái</th>
                            <th class="text-center">Tồn kho</th>
                            <th class="text-end">Giá bán</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${listProducts}">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-3">
                                        <img src="${pageContext.request.contextPath}/uploads/user/${p.image}"
     class="product-row-img"
     onerror="this.src='https://via.placeholder.com/48'">
                                        <div>
                                            <div class="prod-name">${p.name}</div>
                                            <div class="text-muted small">#${p.id}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.isHot}"><span class="badge bg-danger">Hot</span></c:when>
                                        <c:when test="${p.isNew}"><span class="badge bg-success">Mới</span></c:when>
                                        <c:otherwise><span class="badge bg-secondary">Thường</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center"><span class="qty-badge">${p.quantity}</span></td>
                                <td class="text-end price-cell">${p.price}</td>
                                <td class="text-end">
                                    <a href="${pageContext.request.contextPath}/admin/products/edit/${p.id}"
                                       class="btn btn-sm btn-outline-warning rounded-pill me-1">
                                       <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/products/delete/${p.id}"
                                       onclick="return confirm('Xóa sản phẩm này?')"
                                       class="btn btn-sm btn-outline-danger rounded-pill">
                                       <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listProducts}">
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <div class="mb-2"><i class="bi bi-box-seam fs-4"></i></div>
                                    <div class="fw-semibold">Chưa có sản phẩm nào</div>
                                    <div class="small text-muted mb-3">Nhấn "Thêm sản phẩm" để tạo mới.</div>
                                    <button class="btn btn-outline-primary btn-sm rounded-pill fw-semibold"
                                            data-bs-toggle="modal" data-bs-target="#addProductModal">
                                        <i class="bi bi-plus-lg me-1"></i> Thêm sản phẩm
                                    </button>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>

<!-- Modal thêm sản phẩm -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <form:form method="POST" modelAttribute="product"
           action="${pageContext.request.contextPath}/admin/products/save"
           enctype="multipart/form-data"
           class="modal-content">

            <div class="modal-header bg-gradient-brand text-white">
                <h5 class="modal-title"><i class="bi bi-plus-circle me-2"></i> Thêm sản phẩm mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Tên sản phẩm</label>
                    <form:input path="name" class="form-control form-control-lg" placeholder="VD: Paracetamol 500mg"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Giá bán (VNĐ)</label>
                    <form:input path="price" type="number" class="form-control form-control-lg" placeholder="25000"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Số lượng</label>
                    <form:input path="quantity" type="number" class="form-control form-control-lg" placeholder="50"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Mô tả ngắn</label>
                    <form:textarea path="shortDesc" class="form-control" rows="2"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Mô tả chi tiết</label>
                    <form:textarea path="detailDesc" class="form-control" rows="4"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Ảnh minh họa (URL)</label>
                   <input type="file" name="imageFile" class="form-control"/>

                </div>
                <div class="form-check mb-2">
                    <form:checkbox path="isNew" class="form-check-input" id="isNew"/>
                    <label for="isNew" class="form-check-label">Sản phẩm mới</label>
                </div>
                <div class="form-check mb-3">
                    <form:checkbox path="isHot" class="form-check-input" id="isHot"/>
                    <label for="isHot" class="form-check-label">Sản phẩm nổi bật</label>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-outline-secondary rounded-pill" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary rounded-pill fw-semibold">
                    <i class="bi bi-save me-1"></i> Lưu
                </button>
            </div>
        </form:form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
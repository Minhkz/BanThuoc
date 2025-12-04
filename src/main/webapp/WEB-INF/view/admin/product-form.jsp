<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa sản phẩm</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>

    <style>
        body {
            background:#f5f7fa;
        }
        .card {
            border-radius:1rem;
            box-shadow:0 1rem 2rem rgba(0,0,0,.1);
        }
        .form-label {
            font-weight:600;
        }
        .preview {
            width:120px;
            height:120px;
            object-fit:cover;
            border-radius:.75rem;
            border:1px solid #ddd;
        }
    </style>
</head>

<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="card">
                <div class="card-header bg-primary text-white fw-semibold">
                    <i class="bi bi-pencil-square me-2"></i>
                    Chỉnh sửa sản phẩm
                </div>

                <div class="card-body">

                    <form:form method="POST"
                               action="${pageContext.request.contextPath}/admin/products/save"
                               modelAttribute="product"
                               enctype="multipart/form-data">

                        <!-- ✅ CSRF Token -->
                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}" />

                        <!-- ✅ ID -->
                        <form:hidden path="id"/>

                        <!-- ✅ GIỮ ẢNH CŨ -->
                        <form:hidden path="image"/>

                        <!-- TÊN -->
                        <div class="mb-3">
                            <label class="form-label">Tên sản phẩm</label>
                            <form:input path="name" class="form-control"/>
                        </div>

                        <!-- GIÁ -->
                        <div class="mb-3">
                            <label class="form-label">Giá bán (VNĐ)</label>
                            <form:input path="price" type="number" class="form-control"/>
                        </div>

                        <!-- SỐ LƯỢNG -->
                        <div class="mb-3">
                            <label class="form-label">Số lượng</label>
                            <form:input path="quantity" type="number" class="form-control"/>
                        </div>

                        <!-- MÔ TẢ NGẮN -->
                        <div class="mb-3">
                            <label class="form-label">Mô tả ngắn</label>
                            <form:textarea path="shortDesc" class="form-control" rows="2"/>
                        </div>

                        <!-- MÔ TẢ CHI TIẾT -->
                        <div class="mb-3">
                            <label class="form-label">Mô tả chi tiết</label>
                            <form:textarea path="detailDesc" class="form-control" rows="4"/>
                        </div>

                        <!-- ẢNH HIỆN TẠI -->
                        <div class="mb-3">
                            <label class="form-label">Ảnh hiện tại</label><br>

                            <c:if test="${not empty product.image}">
                                <img class="preview"
                                     src="${pageContext.request.contextPath}/uploads/user/${product.image}"
                                     alt="Ảnh sản phẩm"/>
                            </c:if>

                            <c:if test="${empty product.image}">
                                <div class="text-muted">Chưa có ảnh</div>
                            </c:if>
                        </div>

                        <!-- UPLOAD ẢNH MỚI -->
                        <div class="mb-3">
                            <label class="form-label">Chọn ảnh mới (nếu muốn đổi)</label>
                            <input type="file"
                                   name="imageFile"
                                   accept="image/*"
                                   class="form-control"/>
                        </div>

                        <!-- TRẠNG THÁI -->
                        <div class="form-check mb-2">
                            <form:checkbox path="isNew" class="form-check-input" id="isNew"/>
                            <label for="isNew" class="form-check-label">
                                Sản phẩm mới
                            </label>
                        </div>

                        <div class="form-check mb-4">
                            <form:checkbox path="isHot" class="form-check-input" id="isHot"/>
                            <label for="isHot" class="form-check-label">
                                Sản phẩm nổi bật
                            </label>
                        </div>

                        <!-- NÚT -->
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/admin/products"
                               class="btn btn-outline-secondary">
                                Quay lại
                            </a>

                            <button type="submit"
                                    class="btn btn-success fw-semibold">
                                Cập nhật sản phẩm
                            </button>
                        </div>

                    </form:form>

                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>

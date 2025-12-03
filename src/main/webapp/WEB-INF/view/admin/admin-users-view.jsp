<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin người dùng - MediFresh</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root {
            --brand-start: #0d6efd;
            --brand-end:   #6f42c1;
        }

        body {
            background: #f5f7fa;
            font-family: system-ui, sans-serif;
        }

        .header-box {
            background: linear-gradient(135deg, var(--brand-start), var(--brand-end));
            border-radius: 1rem;
            padding: 1.5rem;
            color: #fff;
            box-shadow: 0 1rem 2rem rgba(13,110,253,.25);
        }

        .info-box {
            background: #fff;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.05);
        }

        .label {
            font-size: .8rem;
            font-weight: 600;
            color: #6c757d;
        }

        .value {
            font-size: 1rem;
            font-weight: 600;
            color: #212529;
        }

        .role-badge {
            background: #e7f1ff;
            color: #0d6efd;
            padding: .25rem .6rem;
            border-radius: .5rem;
            font-size: .75rem;
            font-weight: 600;
            border: 1px solid #cfe2ff;
        }

    </style>
</head>
<body>


<div class="container py-4">

    <!-- Tiêu đề -->
    <div class="header-box mb-4">
        <h4 class="mb-1">Thông tin người dùng</h4>
        <div class="opacity-75">Xem chi tiết hồ sơ người dùng</div>
    </div>

    <!-- Nội dung -->
    <div class="info-box">

        <div class="row">
            <div class="col-md-3 text-center">
                <img src="/uploads/user/${user.avatar}"
                     class="rounded-circle border"
                     style="width:120px; height:120px; object-fit:cover;">
                <div class="mt-3 fw-semibold">${user.fullName}</div>
                <div class="role-badge mt-1">
                    ${user.role.name}
                </div>
            </div>

            <div class="col-md-9">
                <div class="row g-3">

                    <div class="col-md-6">
                        <div class="label">Username</div>
                        <div class="value">${user.username}</div>
                    </div>

                    <div class="col-md-6">
                        <div class="label">Email</div>
                        <div class="value">${user.email}</div>
                    </div>

                    <div class="col-md-6">
                        <div class="label">Số điện thoại</div>
                        <div class="value">${user.phone}</div>
                    </div>

                    <div class="col-md-6">
                        <div class="label">Địa chỉ</div>
                        <div class="value">${user.address}</div>
                    </div>

                    <div class="col-md-6">
                        <div class="label">Ngày tạo</div>
                        <div class="value">
                            <fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy HH:mm" />
                        </div>
                    </div>

                </div>

                <div class="mt-4">
                    <a href="/admin/users" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Quay lại
                    </a>

                    <a href="/admin/users/edit/${user.id}" class="btn btn-primary">
                        <i class="bi bi-pencil"></i> Sửa hồ sơ
                    </a>
                </div>

            </div>
        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediFresh Admin - Người dùng</title>

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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL);
                $("#avatarPreview").css({ "display": "block" });
            });
        });
    </script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
        .user-role-badge {
            font-size:.7rem;
            font-weight:600;
            border-radius:.5rem;
            padding:.25rem .5rem;
            display:inline-block;
            line-height:1.2;
            color:#0d6efd;
            background:#e7f1ff;
            border:1px solid #cfe2ff;
        }
        .user-status-active {
            font-size:.7rem;
            font-weight:600;
            color:#198754;
        }
        .user-status-block {
            font-size:.7rem;
            font-weight:600;
            color:#dc3545;
        }
    </style>

</head>
<body>



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
            <a class="sidebar-link" href="/admin">
                <i class="bi bi-speedometer2"></i>
                Dashboard
            </a>
            <a class="sidebar-link" href="/admin/products">
                <i class="bi bi-box-seam"></i>
                Sản phẩm
            </a>
            <a class="sidebar-link" href="/admin/orders">
                <i class="bi bi-receipt"></i>
                Đơn hàng
            </a>
            <a class="sidebar-link active" href="/admin/users">
                <i class="bi bi-people"></i>
                Người dùng
            </a>
        </div>

        <div class="mt-auto pt-3">
            <div class="sidebar-section-title">Hệ thống</div>
            <a class="sidebar-link text-danger" href="/logout">
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
                    Người dùng
                </div>
                <span class="badge bg-primary-subtle text-primary rounded-pill fw-semibold">
                    Khách hàng & Quản trị viên
                </span>
            </div>

            <div class="d-flex align-items-center gap-3">
                <div class="text-end d-none d-sm-block">
                    <div class="fw-semibold" style="font-size:.9rem;">${sessionScope.fullName}</div>
                </div>
                <img
                    src="/uploads/user/${sessionScope.avatar}"
                    class="rounded-circle border"
                    style="width:40px;height:40px;object-fit:cover;"
                    alt="user avatar"
                >
            </div>
        </div>

        <div class="container-fluid px-6 px-lg-8 mb-5">
           <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Update a user</h3>
                            <hr />
                            <form:form method="post" action="/admin/users/edit"
                                       modelAttribute="editUser" class="row" enctype="multipart/form-data">
                                <div class="mb-3 col-12 col-md-6 d-none">
                                    <label class="form-label">Id:</label>
                                    <form:input type="text" class="form-control" path="id"/>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Username:</label>
                                    <form:input type="text" class="form-control" path="username" disabled="true" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Email:</label>
                                    <form:input type="email" class="form-control" path="email" disabled="true" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Phone number:</label>
                                    <form:input type="text" class="form-control" path="phone" />
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Full Name:</label>
                                    <form:input type="text" class="form-control" path="fullName" />
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Address:</label>
                                    <form:input type="text" class="form-control" path="address" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Role:</label>
                                    <form:select class="form-select" path="role.id" disabled="true">
                                        <form:option value="1">ADMIN</form:option>
                                        <form:option value="2">USER</form:option>
                                    </form:select>
                                    <form:hidden path="role.id"/>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label for="avatarFile" class="form-label">Avatar:</label>
                                    <input class="form-control" type="file" id="avatarFile"
                                           accept=".png, .jpg, .jpeg" name="nhatminhFile">
                                </div>
                                <div class="col-12 mb-3">
                                    <img style="max-height: 250px; display: none;" alt="avatar preview"
                                         id="avatarPreview" />
                                </div>
                                <div class="col-12 mb-5">
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </div>
                            </form:form>

                        </div>

                    </div>
                </div>
        </div>

 
    </main>
</div>

<!-- Bootstrap JS -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>

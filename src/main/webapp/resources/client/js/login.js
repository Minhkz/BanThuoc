// === CART COUNT (dùng lại logic như các trang kia) ===
    function getCart() {
        try {
            return JSON.parse(localStorage.getItem('cartItems')) || [];
        } catch (e) {
            return [];
        }
    }
    function renderCartCount() {
        const badge = document.getElementById('cart-count');
        if (!badge) return;
        const cart = getCart();
        const totalQty = cart.reduce((sum, item) => sum + item.qty, 0);
        badge.textContent = totalQty;
    }

    // === SHOW / HIDE PASSWORD ===
    function togglePassword(inputId, btnEl) {
        const input = document.getElementById(inputId);
        const icon = btnEl.querySelector('i');
        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("bi-eye-slash");
            icon.classList.add("bi-eye");
        } else {
            input.type = "password";
            icon.classList.remove("bi-eye");
            icon.classList.add("bi-eye-slash");
        }
    }

    // === GIẢ LẬP XỬ LÝ ĐĂNG NHẬP (chưa có backend) ===
    function handleLogin(e) {
        e.preventDefault();
        const idVal = document.getElementById('login-identifier').value.trim();
        const passVal = document.getElementById('login-password').value.trim();

        if (!idVal || !passVal) {
            alert("Vui lòng nhập đầy đủ thông tin.");
            return;
        }

        // chỗ này sau này sẽ gọi API thực tế.
        alert("Đăng nhập thành công (giả lập). Chào " + idVal + "!");
        window.location.href = "index.html";
    }

    // init
    renderCartCount();
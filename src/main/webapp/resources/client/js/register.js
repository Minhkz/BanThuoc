// === CART COUNT ===
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

    // === GIẢ LẬP XỬ LÝ ĐĂNG KÝ (frontend) ===
    function handleRegister(e) {
        e.preventDefault();

        const nameVal  = document.getElementById('reg-fullname').value.trim();
        const emailVal = document.getElementById('reg-email').value.trim();
        const phoneVal = document.getElementById('reg-phone').value.trim();
        const passVal  = document.getElementById('reg-password').value;
        const pass2Val = document.getElementById('reg-password-confirm').value;

        if (!nameVal || !emailVal || !phoneVal || !passVal || !pass2Val) {
            alert("Vui lòng nhập đầy đủ thông tin.");
            return;
        }

        if (passVal !== pass2Val) {
            alert("Mật khẩu nhập lại không khớp.");
            return;
        }

        if (passVal.length < 8) {
            alert("Mật khẩu phải có ít nhất 8 ký tự.");
            return;
        }

        // Sau này sẽ gọi API backend để tạo tài khoản.
        alert("Đăng ký thành công (giả lập). Chào " + nameVal + "!");
        window.location.href = "login.html";
    }

    // init
    renderCartCount();
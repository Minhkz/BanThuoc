// =========================
    // CART STORAGE HELPERS
    // =========================
    function getCart() {
        try {
            return JSON.parse(localStorage.getItem('cartItems')) || [];
        } catch (e) {
            return [];
        }
    }

    function saveCart(cart) {
        localStorage.setItem('cartItems', JSON.stringify(cart));
    }

    function formatCurrency(vndNumber) {
        // convert number -> tiền VNĐ có dấu chấm
        return vndNumber.toLocaleString('vi-VN', {
            style: 'currency',
            currency: 'VND'
        });
    }

    // =========================
    // NAVBAR BADGE
    // =========================
    function renderCartCount() {
        const badge = document.getElementById('cart-count');
        if (!badge) return;
        const cart = getCart();
        const totalQty = cart.reduce((sum, item) => sum + item.qty, 0);
        badge.textContent = totalQty;
    }

    // =========================
    // RENDER CART TABLE
    // =========================
    function renderCartPage() {
        const tbody = document.getElementById('cart-table-body');
        const subtotalEl = document.getElementById('subtotal-amount');
        const shippingEl = document.getElementById('shipping-amount');
        const discountEl = document.getElementById('discount-amount');
        const totalEl = document.getElementById('cart-total');

        const emptyBlock = document.getElementById('cart-empty');
        const hasItemsBlock = document.getElementById('cart-has-items');

        const cart = getCart();

        // Nếu giỏ trống => hiện empty state
        if (cart.length === 0) {
            emptyBlock.classList.remove('d-none');
            hasItemsBlock.classList.add('d-none');

            // reset số tiền
            subtotalEl.textContent = "0₫";
            shippingEl.textContent = "0₫";
            discountEl.textContent = "0₫";
            totalEl.textContent = "0₫";

            return;
        } else {
            emptyBlock.classList.add('d-none');
            hasItemsBlock.classList.remove('d-none');
        }

        tbody.innerHTML = '';
        let subtotal = 0;

        cart.forEach((item, index) => {
            const lineCost = item.price * item.qty;
            subtotal += lineCost;

            const tr = document.createElement('tr');

            tr.innerHTML = `
                <td style="max-width:260px;">
                    <div class="d-flex align-items-center">
                        <img src="${item.imgUrl}" alt="${item.name}" class="cart-item-img me-2">
                        <div>
                            <div class="cart-item-name">${item.name}</div>
                            <div class="cart-item-code">Mã: ${item.id}</div>
                        </div>
                    </div>
                </td>

                <td class="text-end align-middle">
                    ${formatCurrency(item.price)}
                </td>

                <td class="text-center align-middle">
                    <div class="input-group input-group-sm qty-group justify-content-center" style="max-width:110px;">
                        <button class="btn btn-outline-secondary" type="button" onclick="updateQty(${index}, -1)">
                            <i class="bi bi-dash"></i>
                        </button>
                        <input class="form-control text-center" value="${item.qty}" readonly style="max-width:45px;">
                        <button class="btn btn-outline-secondary" type="button" onclick="updateQty(${index}, 1)">
                            <i class="bi bi-plus"></i>
                        </button>
                    </div>
                </td>

                <td class="text-end align-middle fw-semibold">
                    ${formatCurrency(lineCost)}
                </td>

                <td class="text-end align-middle">
                    <button class="btn btn-sm btn-outline-danger" onclick="removeItem(${index})">
                        <i class="bi bi-trash3"></i>
                    </button>
                </td>
            `;

            tbody.appendChild(tr);
        });

        // giả lập phí ship: 15k nếu subtotal < 200k, ngược lại free
        let shippingFee = 0;
        if (subtotal > 0 && subtotal < 200000) {
            shippingFee = 15000;
        }

        // giả lập giảm giá: 0
        let discount = 0;

        const totalPay = subtotal + shippingFee - discount;

        subtotalEl.textContent = formatCurrency(subtotal);
        shippingEl.textContent = formatCurrency(shippingFee);
        discountEl.textContent = formatCurrency(discount);
        totalEl.textContent = formatCurrency(totalPay);
    }

    // =========================
    // UPDATE QUANTITY
    // =========================
    function updateQty(index, delta) {
        let cart = getCart();
        if (!cart[index]) return;

        cart[index].qty += delta;
        if (cart[index].qty < 1) {
            // Nếu giảm xuống 0 thì xóa luôn
            cart.splice(index, 1);
        }

        saveCart(cart);
        renderCartCount();
        renderCartPage();
    }

    // =========================
    // REMOVE ITEM
    // =========================
    function removeItem(index) {
        let cart = getCart();
        if (!cart[index]) return;
        const name = cart[index].name;
        cart.splice(index, 1);
        saveCart(cart);
        renderCartCount();
        renderCartPage();
        alert('Đã xóa "' + name + '" khỏi giỏ hàng.');
    }

    // =========================
    // CLEAR CART
    // =========================
    function clearCart() {
        if (!confirm("Bạn có chắc muốn xóa toàn bộ giỏ hàng?")) return;
        saveCart([]);
        renderCartCount();
        renderCartPage();
    }

    // =========================
    // CHECKOUT
    // =========================
    function checkoutNow() {
        const cart = getCart();
        if (cart.length === 0) {
            alert("Giỏ hàng trống. Vui lòng chọn sản phẩm trước khi thanh toán.");
            return;
        }

        // Ở đây bạn sẽ chuyển hướng qua trang thanh toán thực sự (checkout)
        // hoặc mở form nhập địa chỉ, phương thức thanh toán...
        alert("Chuyển sang bước thanh toán (demo).");
        // ví dụ:
        // window.location.href = "checkout.html";
    }

    // =========================
    // INIT KHI LOAD TRANG
    // =========================
    renderCartCount();
    renderCartPage();
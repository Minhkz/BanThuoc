// =========================
    // CART LOGIC (dùng localStorage)
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

    function renderCartCount() {
        const badge = document.getElementById('cart-count');
        if (!badge) return;
        const cart = getCart();
        const totalQty = cart.reduce((sum, item) => sum + item.qty, 0);
        badge.textContent = totalQty;
    }

    function addToCart(id, name, price, imgUrl) {
        let cart = getCart();
        const idx = cart.findIndex(p => p.id === id);

        if (idx >= 0) {
            cart[idx].qty += 1;
        } else {
            cart.push({
                id,
                name,
                price,
                imgUrl,
                qty: 1
            });
        }

        saveCart(cart);
        renderCartCount();
        alert('Đã thêm "' + name + '" vào giỏ hàng!');
    }

    // =========================
    // FILTER + SEARCH LOGIC
    // =========================
    let activeCategory = 'all';

    function selectCategory(btn) {
        // Cập nhật pill active
        document.querySelectorAll('.category-pill').forEach(p => {
            p.classList.remove('active');
        });
        btn.classList.add('active');

        // Lưu category đang chọn
        activeCategory = btn.getAttribute('data-cat');

        // Áp filter
        applyFilter();
    }

    function applyFilter() {
        const q = (document.getElementById('searchInput').value || '')
                    .toLowerCase()
                    .trim();

        const cards = document.querySelectorAll('.product-card-wrapper');
        let visibleCount = 0;

        cards.forEach(card => {
            const cardCat = card.getAttribute('data-category');
            const cardName = (card.getAttribute('data-name') || '').toLowerCase();

            const matchCat = (activeCategory === 'all' || cardCat === activeCategory);
            const matchText = (q === '' || cardName.includes(q));

            if (matchCat && matchText) {
                card.style.display = '';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        const resultCountEl = document.getElementById('result-count');
        if (resultCountEl) {
            resultCountEl.textContent = visibleCount + ' sản phẩm';
        }
    }

    // =========================
    // INIT KHI LOAD TRANG
    // =========================
    renderCartCount();
    applyFilter();
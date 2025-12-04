
    function handleConsult(e) {
        e.preventDefault();

        const nameVal = document.getElementById('c-name').value.trim();
        const phoneVal = document.getElementById('c-phone').value.trim();
        const msgVal = document.getElementById('c-message').value.trim();

        if (!nameVal || !phoneVal || !msgVal) {
            alert("Vui lòng điền đầy đủ thông tin.");
            return;
        }

        // Sau này bạn có thể gửi dữ liệu lên server qua fetch():
        // fetch('/api/consult', {...})

        // Hiển thị trạng thái thành công (demo front-end)
        document.getElementById('consultForm').classList.add('d-none');
        document.getElementById('consultSuccess').classList.remove('d-none');

        // clear form
        document.getElementById('consultForm').reset();
    }

    // Reset modal khi đóng -> quay lại form ban đầu
    const consultModalEl = document.getElementById('consultModal');
    if (consultModalEl) {
        consultModalEl.addEventListener('hidden.bs.modal', function () {
            document.getElementById('consultForm').classList.remove('d-none');
            document.getElementById('consultSuccess').classList.add('d-none');
        });
    }

    // =========================
    // INIT KHI LOAD TRANG
    // =========================
    renderCartCount();
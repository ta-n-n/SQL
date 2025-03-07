<?php
$conn = new mysqli("localhost", "root", "", "quanlysanpham");
if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}

// Xử lý thêm sản phẩm
if (isset($_POST['add'])) {
    $ten = $_POST['ten'];
    $gia = $_POST['gia'];
    $mota = $_POST['mota'];
    $sql = "INSERT INTO sanpham (ten, gia, mota) VALUES ('$ten', '$gia', '$mota')";
    $conn->query($sql);
    header("Location: index.php");
}

// Xử lý cập nhật sản phẩm
if (isset($_POST['edit'])) {
    $id = $_POST['id'];
    $ten = $_POST['ten'];
    $gia = $_POST['gia'];
    $mota = $_POST['mota'];
    $sql = "UPDATE sanpham SET ten='$ten', gia='$gia', mota='$mota' WHERE id=$id";
    $conn->query($sql);
    header("Location: index.php");
}

// Xử lý xóa sản phẩm
if (isset($_GET['delete'])) {
    $id = $_GET['delete'];
    $sql = "DELETE FROM sanpham WHERE id=$id";
    $conn->query($sql);
    header("Location: index.php");
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-4">
    <h2 class="text-center">Quản lý Sản Phẩm</h2>
    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addModal">Thêm Sản Phẩm</button>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Giá</th>
                <th>Mô Tả</th>
                <th>Hành Động</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $result = $conn->query("SELECT * FROM sanpham");
            while ($row = $result->fetch_assoc()):
            ?>
            <tr>
                <td><?= $row['id'] ?></td>
                <td><?= $row['ten'] ?></td>
                <td><?= $row['gia'] ?></td>
                <td><?= $row['mota'] ?></td>
                <td>
                    <button class="btn btn-warning btn-sm edit-btn"
                        data-id="<?= $row['id'] ?>"
                        data-ten="<?= $row['ten'] ?>"
                        data-gia="<?= $row['gia'] ?>"
                        data-mota="<?= $row['mota'] ?>"
                        data-bs-toggle="modal"
                        data-bs-target="#editModal">Sửa</button>
                    <a href="index.php?delete=<?= $row['id'] ?>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                </td>
            </tr>
            <?php endwhile; ?>
        </tbody>
    </table>
</div>

<!-- Modal Thêm -->
<div class="modal fade" id="addModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thêm Sản Phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form method="POST">
                    <label for="ten">Tên:</label>
                    <input type="text" class="form-control" name="ten" required>
                    <label for="gia">Giá:</label>
                    <input type="number" class="form-control" name="gia" required>
                    <label for="mota">Mô Tả:</label>
                    <textarea class="form-control" name="mota"></textarea>
                    <button type="submit" name="add" class="btn btn-primary mt-3">Thêm</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Sửa -->
<div class="modal fade" id="editModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Sửa Sản Phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form method="POST">
                    <input type="hidden" name="id" id="edit-id">
                    <label for="ten">Tên:</label>
                    <input type="text" class="form-control" name="ten" id="edit-ten" required>
                    <label for="gia">Giá:</label>
                    <input type="number" class="form-control" name="gia" id="edit-gia" required>
                    <label for="mota">Mô Tả:</label>
                    <textarea class="form-control" name="mota" id="edit-mota"></textarea>
                    <button type="submit" name="edit" class="btn btn-warning mt-3">Cập Nhật</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    let editButtons = document.querySelectorAll(".edit-btn");
    editButtons.forEach(btn => {
        btn.addEventListener("click", function () {
            document.getElementById("edit-id").value = this.getAttribute("data-id");
            document.getElementById("edit-ten").value = this.getAttribute("data-ten");
            document.getElementById("edit-gia").value = this.getAttribute("data-gia");
            document.getElementById("edit-mota").value = this.getAttribute("data-mota");
        });
    });
});
</script>

</body>
</html>


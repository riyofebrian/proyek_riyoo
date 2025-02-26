<?php
header('Content-Type: application/json');
include 'konekdb.php';

$id = $_POST['id'];
$nama = $_POST['nama'];
$nis = $_POST['nis'];
$tplahir = $_POST['tplahir'];
$tgllahir = $_POST['tgllahir'];
$kelamin = $_POST['kelamin'];
$agama = $_POST['agama'];
$alamat = $_POST['alamat'];

$stmt = $db->prepare("UPDATE siswa SET nis = ?, nama = ?, tplahir = ?, tgllahir = ?, kelamin = ?, 
                      agama = ?, alamat = ? WHERE id = ?");
$result = $stmt->execute([$nis, $nama, $tplahir, $tgllahir, $kelamin, $agama, $alamat, $id]);

echo json_encode([
    'success' => $result
]);
?>

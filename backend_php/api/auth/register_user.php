<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['nom'], $data['prenom'], $data['email'], $data['password'], $data['groupe_sanguin'])) {
    sendResponse(false, "Champs manquants");
}

$email = $data['email'];
$stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
$stmt->execute([$email]);
if ($stmt->fetch()) {
    sendResponse(false, "Email déjà utilisé");
}

$hash = password_hash($data['password'], PASSWORD_DEFAULT);

$stmt = $pdo->prepare("INSERT INTO users (nom, prenom, email, password, telephone, ville, groupe_sanguin, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->execute([
    $data['nom'],
    $data['prenom'],
    $data['email'],
    $hash,
    $data['telephone'] ?? null,
    $data['ville'] ?? 'Cotonou',
    $data['groupe_sanguin'],
    $data['latitude'] ?? null,
    $data['longitude'] ?? null
]);

sendResponse(true, "Inscription réussie", ["id" => $pdo->lastInsertId()]);

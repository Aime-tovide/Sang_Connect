<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['nom'], $data['email'], $data['password'])) {
    sendResponse(false, "Champs manquants");
}

$stmt = $pdo->prepare("SELECT id FROM hopitaux WHERE email = ?");
$stmt->execute([$data['email']]);
if ($stmt->fetch()) {
    sendResponse(false, "Email déjà utilisé");
}

$hash = password_hash($data['password'], PASSWORD_DEFAULT);

$stmt = $pdo->prepare("INSERT INTO hopitaux (nom, email, password, telephone, adresse, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?)");
$stmt->execute([
    $data['nom'],
    $data['email'],
    $hash,
    $data['telephone'] ?? null,
    $data['adresse'] ?? null,
    $data['latitude'] ?? null,
    $data['longitude'] ?? null
]);

sendResponse(true, "Hôpital inscrit avec succès", ["id" => $pdo->lastInsertId()]);

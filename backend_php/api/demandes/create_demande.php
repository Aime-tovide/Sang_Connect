<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['hopital_id'], $data['groupe_sanguin'], $data['quantite'])) {
    sendResponse(false, "Champs manquants");
}

$stmt = $pdo->prepare("INSERT INTO demandes (hopital_id, groupe_sanguin, quantite, urgence, description, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?)");
$stmt->execute([
    $data['hopital_id'],
    $data['groupe_sanguin'],
    $data['quantite'],
    $data['urgence'] ?? 'moyen',
    $data['description'] ?? null,
    $data['latitude'] ?? null,
    $data['longitude'] ?? null
]);

sendResponse(true, "Demande créée avec succès", ["id" => $pdo->lastInsertId()]);

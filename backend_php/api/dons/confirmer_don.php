<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['donneur_id'], $data['hopital_id'])) {
    sendResponse(false, "Champs manquants");
}

// Cherche une demande en attente de cet hôpital
$stmt = $pdo->prepare("SELECT id FROM demandes WHERE hopital_id = ? AND statut = 'en_attente' LIMIT 1");
$stmt->execute([$data['hopital_id']]);
$demande = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$demande) {
    sendResponse(false, "Aucune demande en attente");
}

// Crée le don
$stmt = $pdo->prepare("INSERT INTO dons (donneur_id, hopital_id, demande_id, statut) VALUES (?, ?, ?, 'confirme')");
$stmt->execute([$data['donneur_id'], $data['hopital_id'], $demande['id']]);

// Met à jour la disponibilité du donneur
$stmt = $pdo->prepare("UPDATE users SET disponible = 0 WHERE id = ?");
$stmt->execute([$data['donneur_id']]);

sendResponse(true, "Don confirmé avec succès");

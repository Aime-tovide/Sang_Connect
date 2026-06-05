<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$groupe_sanguin = $_GET['groupe_sanguin'] ?? null;

if ($groupe_sanguin) {
    $stmt = $pdo->prepare("
        SELECT d.*, h.nom as hopital_nom, h.telephone as hopital_telephone
        FROM demandes d
        JOIN hopitaux h ON d.hopital_id = h.id
        WHERE d.statut = 'en_attente' AND d.groupe_sanguin = ?
        ORDER BY d.created_at DESC
    ");
    $stmt->execute([$groupe_sanguin]);
} else {
    $stmt = $pdo->prepare("
        SELECT d.*, h.nom as hopital_nom, h.telephone as hopital_telephone
        FROM demandes d
        JOIN hopitaux h ON d.hopital_id = h.id
        WHERE d.statut = 'en_attente'
        ORDER BY d.created_at DESC
    ");
    $stmt->execute();
}

$demandes = $stmt->fetchAll(PDO::FETCH_ASSOC);
sendResponse(true, "Demandes récupérées", $demandes);

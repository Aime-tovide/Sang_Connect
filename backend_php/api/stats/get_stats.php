<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$hopital_id = $_GET['hopital_id'] ?? null;

// Demandes actives de cet hôpital
$stmt = $pdo->prepare("SELECT COUNT(*) as total FROM demandes WHERE statut = 'en_attente' AND hopital_id = ?");
$stmt->execute([$hopital_id]);
$demandes_actives = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

// Demandes aujourd'hui
$stmt = $pdo->prepare("SELECT COUNT(*) as total FROM demandes WHERE hopital_id = ? AND DATE(created_at) = CURDATE()");
$stmt->execute([$hopital_id]);
$demandes_aujourdhui = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

// Donneurs disponibles
$stmt = $pdo->prepare("SELECT COUNT(*) as total FROM users WHERE disponible = 1");
$stmt->execute();
$donneurs_disponibles = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

// Dons reçus
$stmt = $pdo->prepare("SELECT COUNT(*) as total FROM dons WHERE hopital_id = ? AND statut = 'confirme'");
$stmt->execute([$hopital_id]);
$dons_recus = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

sendResponse(true, "Stats récupérées", [
    'demandes_actives' => $demandes_actives,
    'demandes_aujourdhui' => $demandes_aujourdhui,
    'donneurs_disponibles' => $donneurs_disponibles,
    'dons_recus' => $dons_recus,
]);

<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$groupe_sanguin = $_GET['groupe_sanguin'] ?? null;

if ($groupe_sanguin) {
    $stmt = $pdo->prepare("
        SELECT id, nom, prenom, telephone, groupe_sanguin, latitude, longitude, disponible
        FROM users
        WHERE disponible = 1 AND groupe_sanguin = ?
    ");
    $stmt->execute([$groupe_sanguin]);
} else {
    $stmt = $pdo->prepare("
        SELECT id, nom, prenom, telephone, groupe_sanguin, latitude, longitude, disponible
        FROM users
        WHERE disponible = 1
    ");
    $stmt->execute();
}

$donneurs = $stmt->fetchAll(PDO::FETCH_ASSOC);
sendResponse(true, "Donneurs récupérés", $donneurs);

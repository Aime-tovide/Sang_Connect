<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['email'], $data['password'])) {
    sendResponse(false, "Champs manquants");
}

$stmt = $pdo->prepare("SELECT * FROM hopitaux WHERE email = ?");
$stmt->execute([$data['email']]);
$hopital = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$hopital || !password_verify($data['password'], $hopital['password'])) {
    sendResponse(false, "Email ou mot de passe incorrect");
}

unset($hopital['password']);
sendResponse(true, "Connexion réussie", $hopital);

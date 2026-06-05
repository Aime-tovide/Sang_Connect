<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['email'], $data['password'])) {
    sendResponse(false, "Champs manquants");
}

$stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
$stmt->execute([$data['email']]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user || !password_verify($data['password'], $user['password'])) {
    sendResponse(false, "Email ou mot de passe incorrect");
}

unset($user['password']);
sendResponse(true, "Connexion réussie", $user);

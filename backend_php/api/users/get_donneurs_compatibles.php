
<?php
require_once '../../config/database.php';
require_once '../../utils/response.php';

$groupe_sanguin = $_GET['groupe_sanguin'] ?? null;

if ($groupe_sanguin) {
    $stmt = $pdo->prepare("
        SELECT id, nom, prenom, email, telephone, ville, groupe_sanguin, 
               latitude, longitude, disponible,
               (SELECT COUNT(*) FROM dons WHERE donneur_id = users.id AND statut = 'confirme') as nb_dons,
               (SELECT DATE_FORMAT(date_don, '%d %M %Y') FROM dons WHERE donneur_id = users.id AND statut = 'confirme' ORDER BY date_don DESC LIMIT 1) as dernier_don
        FROM users
        WHERE groupe_sanguin = ?
        ORDER BY disponible DESC, id DESC
    ");
    $stmt->execute([$groupe_sanguin]);
} else {
    $stmt = $pdo->prepare("
        SELECT id, nom, prenom, email, telephone, groupe_sanguin,
               latitude, longitude, disponible,
               (SELECT COUNT(*) FROM dons WHERE donneur_id = users.id AND statut = 'confirme') as nb_dons,
               (SELECT DATE_FORMAT(date_don, '%d %M %Y') FROM dons WHERE donneur_id = users.id AND statut = 'confirme' ORDER BY date_don DESC LIMIT 1) as dernier_don
        FROM users
        ORDER BY disponible DESC, id DESC
    ");
    $stmt->execute();
}

$donneurs = $stmt->fetchAll(PDO::FETCH_ASSOC);
sendResponse(true, "Donneurs récupérés", $donneurs);
?>
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 05 juin 2026 à 12:47
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `blood_app`
--

-- --------------------------------------------------------

--
-- Structure de la table `demandes`
--

CREATE TABLE `demandes` (
  `id` int(11) NOT NULL,
  `hopital_id` int(11) NOT NULL,
  `groupe_sanguin` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `quantite` int(11) NOT NULL,
  `urgence` enum('faible','moyen','critique') DEFAULT 'moyen',
  `statut` enum('en_attente','satisfaite','annulee') DEFAULT 'en_attente',
  `description` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `demandes`
--

INSERT INTO `demandes` (`id`, `hopital_id`, `groupe_sanguin`, `quantite`, `urgence`, `statut`, `description`, `latitude`, `longitude`, `created_at`) VALUES
(1, 2, 'A+', 15, 'critique', 'en_attente', 'fggjj', NULL, NULL, '2026-05-28 19:35:52'),
(2, 3, 'O+', 55, 'moyen', 'en_attente', '', NULL, NULL, '2026-06-01 08:19:11'),
(3, 3, 'B+', 3, 'moyen', 'en_attente', '', NULL, NULL, '2026-06-01 08:22:35'),
(4, 3, 'A+', 2, 'moyen', 'en_attente', 'jhjj', NULL, NULL, '2026-06-01 08:32:11'),
(5, 4, 'A+', 3, 'moyen', 'en_attente', '', NULL, NULL, '2026-06-03 11:58:57'),
(6, 4, 'B-', 5, 'critique', 'en_attente', 'Très urgent', NULL, NULL, '2026-06-04 06:47:44'),
(7, 4, 'AB+', 12, 'moyen', 'en_attente', '', NULL, NULL, '2026-06-04 08:53:54'),
(8, 4, 'O+', 45, 'critique', 'en_attente', '', NULL, NULL, '2026-06-05 06:51:38'),
(9, 4, 'O+', 2, 'critique', 'en_attente', '', NULL, NULL, '2026-06-05 06:52:19');

-- --------------------------------------------------------

--
-- Structure de la table `dons`
--

CREATE TABLE `dons` (
  `id` int(11) NOT NULL,
  `donneur_id` int(11) NOT NULL,
  `hopital_id` int(11) NOT NULL,
  `demande_id` int(11) NOT NULL,
  `date_don` timestamp NOT NULL DEFAULT current_timestamp(),
  `statut` enum('en_attente','confirme','annule') DEFAULT 'en_attente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dons`
--

INSERT INTO `dons` (`id`, `donneur_id`, `hopital_id`, `demande_id`, `date_don`, `statut`) VALUES
(1, 8, 4, 5, '2026-06-04 08:21:03', 'confirme'),
(2, 6, 4, 5, '2026-06-04 08:22:04', 'confirme'),
(3, 1, 4, 5, '2026-06-04 08:22:20', 'confirme'),
(4, 3, 4, 5, '2026-06-04 08:23:52', 'confirme');

-- --------------------------------------------------------

--
-- Structure de la table `hopitaux`
--

CREATE TABLE `hopitaux` (
  `id` int(11) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `hopitaux`
--

INSERT INTO `hopitaux` (`id`, `nom`, `email`, `password`, `telephone`, `adresse`, `latitude`, `longitude`, `created_at`) VALUES
(1, 'agonlin', 'crabe@gmail.com', '$2y$10$TRWOmPhp57nMe8Dd7ZQsAuB2GWjPXHsDhIxA4gI6.XcckX0Mc9cja', '54605784', 'calavi', NULL, NULL, '2026-05-28 19:32:44'),
(2, 'bbb', 'triple@gmail.com', '$2y$10$krNVgXlH5vGSsypFVdclAeBLYu0NBjoi5jka7s.dB8ivpYqBCBNmC', '54605784', 'cotonou', NULL, NULL, '2026-05-28 19:34:19'),
(3, 'assouka', 'assouka@gmail.com', '$2y$10$ycSG896tBE/aIngZzMon7enb84lp/bmfKosxgVqPYqaTlGaENt0Ay', '44444444', 'cotonou', NULL, NULL, '2026-06-01 08:18:20'),
(4, 'Pixel point', 'pixel@gmail.com', '$2y$10$fQ9SpIhJiCKaIuKp7qQEkOSkCUps5brDmhDwIpCIPP6sKZyge.ugO', '44445555', '', NULL, NULL, '2026-06-03 11:55:14'),
(5, 'Hotel Assouka', 'hotel@gmail.com', '$2y$10$epFj3GLUm9kN660T8hqGz.gPWEsw/JzBHkj.NpRNrypMg7k4t3x8K', '55555555', '', NULL, NULL, '2026-06-03 11:57:47');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `ville` varchar(100) DEFAULT 'Cotonou',
  `groupe_sanguin` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `prenom`, `email`, `password`, `telephone`, `ville`, `groupe_sanguin`, `latitude`, `longitude`, `disponible`, `created_at`) VALUES
(1, 'Dupont', 'Jean', 'jean@gmail.com', '$2y$10$BReTcQLh.jho804OwKlUtONK.2VYDGsWPG5jvFxbVdEuv7pnexNu2', '0600000000', 'Cotonou', 'A+', 48.85660000, 2.35220000, 0, '2026-05-28 01:03:25'),
(2, 'AAA', 'BBB', 'cesaire883@gmail.com', '$2y$10$5.VOSOQ7jLlxP0bVKwwm9OMe/FdZyAIIYsclmjiFXx/yrGUdwy5be', '48804735', 'Cotonou', 'A+', NULL, NULL, 1, '2026-05-28 19:25:53'),
(3, 'ccc', 'nnnn', 'double@gmail.com', '$2y$10$uTESySzYLtraVch8QwWiVepgClscpM4ZzDUc3xUW2JpogwW7GTmHC', '48804735', 'Cotonou', 'A+', NULL, NULL, 0, '2026-05-28 19:29:07'),
(4, 'tre', 'tre', 'aime@gmail.com', '$2y$10$SxOc.BB46oyR4ztDBZUTDe/ZjlVqbWtWHdSe3PrsFBpkHPzJHJWam', '444444444', 'Cotonou', 'A+', NULL, NULL, 1, '2026-05-28 19:37:53'),
(5, 'raz', 'raz', 'raz@gmail.com', '$2y$10$TPECBafuW5klvAehUq5ApOWPQYU4NKlixLAwS.qvb6eR/yWGExdvm', '44444444', 'Cotonou', 'B+', NULL, NULL, 1, '2026-06-01 07:34:38'),
(6, 'TOVIDE', 'Aimé', 'tovide@gmail.com', '$2y$10$hd0X.nF4Ye/NmRYeymSPvu57NL8g0/GbhIYx0VBgUv0MA3vm1aApy', '55555555', 'Cotonou', 'O+', NULL, NULL, 0, '2026-06-01 07:58:29'),
(7, 'assouka', 'assouka', 'assouka@gmail.com', '$2y$10$A9IMog4Cw0tJCdhD4mt6LOh7Zwcn9.cYJ4rduS/2NOzY/PaqmvbHC', '55555555', 'Cotonou', 'O+', NULL, NULL, 1, '2026-06-01 08:15:56'),
(8, 'ddd', 'ddd', 'dossou@gmail.com', '$2y$10$CB1Mh3fz3k2R56T6WWjzxOPNlaRpoZSsKYSOviAkfygSerJsUsxM2', '44444444', 'Cotonou', 'A+', NULL, NULL, 0, '2026-06-01 08:31:27'),
(9, 'Cesaire', 'cesaire', 'job@gmail.com', '$2y$10$PKfbnK7Zg4DlicOWBuhLo.2.P2qrz2XRR9ivFglAdnn9isXnjgvhK', '54605784', 'Cotonou', 'AB-', NULL, NULL, 1, '2026-06-04 10:29:11');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `demandes`
--
ALTER TABLE `demandes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hopital_id` (`hopital_id`);

--
-- Index pour la table `dons`
--
ALTER TABLE `dons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `donneur_id` (`donneur_id`),
  ADD KEY `hopital_id` (`hopital_id`),
  ADD KEY `demande_id` (`demande_id`);

--
-- Index pour la table `hopitaux`
--
ALTER TABLE `hopitaux`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `demandes`
--
ALTER TABLE `demandes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `dons`
--
ALTER TABLE `dons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `hopitaux`
--
ALTER TABLE `hopitaux`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `demandes`
--
ALTER TABLE `demandes`
  ADD CONSTRAINT `demandes_ibfk_1` FOREIGN KEY (`hopital_id`) REFERENCES `hopitaux` (`id`);

--
-- Contraintes pour la table `dons`
--
ALTER TABLE `dons`
  ADD CONSTRAINT `dons_ibfk_1` FOREIGN KEY (`donneur_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `dons_ibfk_2` FOREIGN KEY (`hopital_id`) REFERENCES `hopitaux` (`id`),
  ADD CONSTRAINT `dons_ibfk_3` FOREIGN KEY (`demande_id`) REFERENCES `demandes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

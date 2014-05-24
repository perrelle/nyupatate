-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Dim 04 Mai 2014 à 21:25
-- Version du serveur: 5.6.12-log
-- Version de PHP: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `transversal_v2`
--
CREATE DATABASE IF NOT EXISTS `transversal_v2` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `transversal_v2`;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE IF NOT EXISTS `categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `categorie`
--

INSERT INTO `categorie` (`id`, `nom`) VALUES
(1, 'entrée'),
(2, 'plat'),
(3, 'dessert');

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

CREATE TABLE IF NOT EXISTS `commentaires` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `users_id` int(11) NOT NULL,
  `recettes_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_commentaires_users1_idx` (`users_id`),
  KEY `fk_commentaires_recettes1_idx` (`recettes_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `ingredients`
--

CREATE TABLE IF NOT EXISTS `ingredients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `rangement_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ingrédients_categories1_idx` (`type_id`),
  KEY `fk_ingrédients_rangement1_idx` (`rangement_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=74 ;

--
-- Contenu de la table `ingredients`
--

INSERT INTO `ingredients` (`id`, `nom`, `type_id`, `rangement_id`) VALUES
(1, 'pomme de terre', 4, 2),
(2, 'oignon', 1, 2),
(3, 'champignon', 1, 2),
(4, 'carotte', 1, 2),
(5, 'poireau', 1, 2),
(6, 'cresson', 1, 2),
(7, 'brocoli', 1, 1),
(8, 'céleri rave', 1, 2),
(9, 'crème fraiche', 2, 1),
(10, 'huile d''olive', 2, 2),
(11, 'poivron', 1, 2),
(12, 'courgette', 1, 2),
(13, 'asperge', 1, 2),
(14, 'artichaut', 1, 2),
(15, 'ail', 1, 2),
(16, 'pâte à pizza', 4, 2),
(17, 'olives', 1, 1),
(18, 'tomates pelées', 1, 2),
(19, 'boudin', 3, 1),
(20, 'manchons de canard', 3, 1),
(21, 'rognons', 3, 1),
(22, 'patate douce', 4, 2),
(23, 'oeuf', 3, 1),
(24, 'crevettes', 5, 1),
(25, 'riz', 4, 2),
(26, 'gingembre', 1, 2),
(27, 'filet de poulet', 3, 1),
(28, 'parmesan', 7, 1),
(29, 'viande hachée', 3, 1),
(30, 'steack haché', 3, 1),
(31, 'lasagnes', 4, 2),
(32, 'sauce tomate', 1, 1),
(33, 'gruyère', 7, 1),
(34, 'figue', 6, 2),
(35, 'noix', 6, 2),
(36, 'raisins secs', 6, 2),
(37, 'raisin', 6, 2),
(38, 'pomme', 6, 2),
(39, 'fromage de chèvre', 7, 1),
(40, 'fromage de brebis', 7, 1),
(41, 'pain', 4, 2),
(42, 'mangue', 6, 2),
(43, 'poire', 6, 2),
(44, 'yaourt', 7, 1),
(45, 'sucre', 2, 2),
(46, 'cannelle', 2, 2),
(47, 'orange', 6, 1),
(48, 'clémentine', 6, 1),
(49, 'cantal', 7, 1),
(50, 'bleu', 7, 1),
(51, 'roquefort', 7, 1),
(52, 'fleur d''oranger', 2, 2),
(53, 'potiron', 1, 2),
(54, 'avocat', 1, 2),
(55, 'endive', 1, 1),
(56, 'maïs', 1, 1),
(57, 'mâche', 1, 2),
(58, 'miel', 2, 2),
(59, 'beurre', 7, 1),
(60, 'farine', 4, 2),
(61, 'citron', 1, 2),
(62, 'curry', 2, 2),
(63, 'lait de coco', 7, 1),
(64, 'semoule', 4, 2),
(65, 'pois chiches', 4, 2),
(66, 'prunes', 6, 2),
(67, 'coing', 6, 2),
(68, 'banane', 6, 2),
(69, 'chocolat', 2, 2),
(70, 'fraises', 6, 2),
(71, 'spaghettis', 4, 2),
(72, 'lait', 7, 1),
(73, 'aubergine', 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `ingredients_has_saisons`
--

CREATE TABLE IF NOT EXISTS `ingredients_has_saisons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ingredients_id` int(11) NOT NULL,
  `saisons_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ingredients_has_saisons_ingredients1_idx` (`ingredients_id`),
  KEY `fk_ingredients_has_saisons_saisons1_idx` (`saisons_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=87 ;

--
-- Contenu de la table `ingredients_has_saisons`
--

INSERT INTO `ingredients_has_saisons` (`id`, `ingredients_id`, `saisons_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 2, 1),
(6, 2, 2),
(7, 2, 3),
(8, 2, 4),
(9, 3, 1),
(10, 3, 2),
(11, 3, 3),
(12, 3, 4),
(13, 4, 1),
(14, 4, 2),
(15, 4, 3),
(16, 4, 4),
(17, 5, 3),
(18, 5, 4),
(19, 6, 1),
(20, 6, 2),
(21, 6, 3),
(22, 6, 4),
(23, 7, 2),
(24, 7, 3),
(25, 8, 2),
(26, 8, 3),
(27, 8, 4),
(28, 11, 2),
(29, 11, 3),
(30, 12, 2),
(31, 13, 1),
(32, 14, 2),
(33, 15, 1),
(34, 15, 2),
(35, 17, 3),
(36, 17, 4),
(37, 18, 2),
(38, 18, 3),
(39, 26, 1),
(40, 26, 2),
(41, 26, 3),
(42, 26, 4),
(43, 32, 2),
(44, 32, 3),
(45, 53, 3),
(46, 54, 1),
(47, 54, 2),
(48, 54, 3),
(49, 54, 4),
(50, 55, 3),
(51, 55, 4),
(52, 56, 2),
(53, 56, 3),
(54, 57, 3),
(55, 57, 4),
(56, 61, 1),
(57, 61, 2),
(58, 61, 3),
(59, 61, 4),
(60, 34, 3),
(61, 35, 3),
(62, 36, 1),
(63, 36, 2),
(64, 36, 3),
(65, 36, 4),
(66, 37, 3),
(67, 38, 3),
(68, 38, 4),
(69, 42, 1),
(70, 42, 2),
(71, 42, 3),
(72, 42, 4),
(73, 43, 2),
(74, 43, 3),
(75, 43, 4),
(76, 47, 4),
(77, 48, 4),
(78, 66, 2),
(79, 66, 3),
(80, 67, 3),
(81, 68, 1),
(82, 68, 2),
(83, 68, 3),
(84, 68, 4),
(85, 70, 2),
(86, 70, 3);

-- --------------------------------------------------------

--
-- Structure de la table `liste_ingredients`
--

CREATE TABLE IF NOT EXISTS `liste_ingredients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ingrédients_id` int(11) NOT NULL,
  `recettes_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_liste_ingredients_ingrédients1_idx` (`ingrédients_id`),
  KEY `fk_liste_ingredients_recettes1_idx` (`recettes_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- Contenu de la table `liste_ingredients`
--

INSERT INTO `liste_ingredients` (`id`, `ingrédients_id`, `recettes_id`) VALUES
(9, 38, 1),
(10, 70, 1),
(11, 60, 1),
(12, 66, 1),
(13, 25, 2),
(14, 17, 2),
(15, 18, 2),
(16, 11, 2),
(17, 10, 2),
(18, 40, 2),
(19, 32, 3),
(20, 29, 3),
(21, 71, 3),
(22, 69, 6),
(23, 52, 6),
(24, 72, 6),
(25, 23, 6),
(26, 31, 5),
(27, 33, 3),
(28, 33, 5),
(29, 18, 5),
(30, 32, 5),
(31, 12, 5),
(32, 56, 2),
(33, 11, 5),
(34, 73, 5);

-- --------------------------------------------------------

--
-- Structure de la table `note`
--

CREATE TABLE IF NOT EXISTS `note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `recettes_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_note_users1_idx` (`users_id`),
  KEY `fk_note_recettes1_idx` (`recettes_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `process`
--

CREATE TABLE IF NOT EXISTS `process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `process`
--

INSERT INTO `process` (`id`, `nom`) VALUES
(1, 'pâtes'),
(2, 'tourte'),
(3, 'tarte'),
(4, 'salade'),
(9, 'crêpes');

-- --------------------------------------------------------

--
-- Structure de la table `rangement`
--

CREATE TABLE IF NOT EXISTS `rangement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `rangement`
--

INSERT INTO `rangement` (`id`, `nom`) VALUES
(1, 'frigo'),
(2, 'placard');

-- --------------------------------------------------------

--
-- Structure de la table `recettes`
--

CREATE TABLE IF NOT EXISTS `recettes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `submit_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `temps` int(11) DEFAULT NULL,
  `difficulte` int(11) DEFAULT NULL,
  `prix` int(11) DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `categorie_id` int(11) NOT NULL,
  `process_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_recettes_users_idx` (`users_id`),
  KEY `fk_recettes_categorie1_idx` (`categorie_id`),
  KEY `fk_recettes_process1_idx` (`process_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `recettes`
--

INSERT INTO `recettes` (`id`, `nom`, `submit_date`, `temps`, `difficulte`, `prix`, `users_id`, `categorie_id`, `process_id`) VALUES
(1, 'Tarte aux fruits', '2014-05-04 20:54:45', 20, 5, 5, 1, 3, 3),
(2, 'Salade de riz', '2014-05-04 21:07:05', 10, 1, 1, 1, 1, 4),
(3, 'Pâtes bolognaise', '2014-05-04 21:12:46', 15, 2, 1, 1, 2, 1),
(5, 'Lasagnes de légumes', '2014-05-04 21:16:16', 30, 4, 3, 1, 2, 1),
(6, 'Crêpes au chocolat', '2014-05-04 21:17:51', 60, 3, 2, 1, 3, 9);

-- --------------------------------------------------------

--
-- Structure de la table `recettes_has_saisons`
--

CREATE TABLE IF NOT EXISTS `recettes_has_saisons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saisons_id` int(11) NOT NULL,
  `recettes_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_recettes_has_ingredients_saisons1_idx` (`saisons_id`),
  KEY `fk_recettes_has_ingredients_recettes1_idx` (`recettes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `saisons`
--

CREATE TABLE IF NOT EXISTS `saisons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `saisons`
--

INSERT INTO `saisons` (`id`, `nom`) VALUES
(1, 'printemps'),
(2, 'été'),
(3, 'automne'),
(4, 'hiver');

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE IF NOT EXISTS `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `type`
--

INSERT INTO `type` (`id`, `nom`) VALUES
(1, 'légume'),
(2, 'condiment'),
(3, 'viande'),
(4, 'féculent'),
(5, 'poisson'),
(6, 'fruit'),
(7, 'laitage');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `register_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `rang` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `password`, `register_date`, `rang`) VALUES
(1, 'Admin', 'toto', '2014-05-04 20:51:22', 'admin');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD CONSTRAINT `fk_commentaires_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_commentaires_recettes1` FOREIGN KEY (`recettes_id`) REFERENCES `recettes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `fk_ingrédients_categories1` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingrédients_rangement1` FOREIGN KEY (`rangement_id`) REFERENCES `rangement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `ingredients_has_saisons`
--
ALTER TABLE `ingredients_has_saisons`
  ADD CONSTRAINT `fk_ingredients_has_saisons_ingredients1` FOREIGN KEY (`ingredients_id`) REFERENCES `ingredients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingredients_has_saisons_saisons1` FOREIGN KEY (`saisons_id`) REFERENCES `saisons` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `liste_ingredients`
--
ALTER TABLE `liste_ingredients`
  ADD CONSTRAINT `fk_liste_ingredients_ingrédients1` FOREIGN KEY (`ingrédients_id`) REFERENCES `ingredients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_liste_ingredients_recettes1` FOREIGN KEY (`recettes_id`) REFERENCES `recettes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `note`
--
ALTER TABLE `note`
  ADD CONSTRAINT `fk_note_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_note_recettes1` FOREIGN KEY (`recettes_id`) REFERENCES `recettes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `recettes`
--
ALTER TABLE `recettes`
  ADD CONSTRAINT `fk_recettes_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_recettes_categorie1` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_recettes_process1` FOREIGN KEY (`process_id`) REFERENCES `process` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `recettes_has_saisons`
--
ALTER TABLE `recettes_has_saisons`
  ADD CONSTRAINT `fk_recettes_has_ingredients_saisons1` FOREIGN KEY (`saisons_id`) REFERENCES `saisons` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_recettes_has_ingredients_recettes1` FOREIGN KEY (`recettes_id`) REFERENCES `recettes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

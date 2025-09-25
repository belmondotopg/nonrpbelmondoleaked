	 -- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Wersja serwera:               11.7.2-MariaDB - mariadb.org binary distribution
-- Serwer OS:                    Win64
-- HeidiSQL Wersja:              12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Zrzut struktury tabela non.baninfo
CREATE TABLE IF NOT EXISTS `baninfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `playername` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli non.baninfo: ~0 rows (około)

-- Zrzut struktury tabela non.banking
CREATE TABLE IF NOT EXISTS `banking` (
  `identifier` varchar(46) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `balance` int(11) DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.banking: ~0 rows (około)

-- Zrzut struktury tabela non.banlist
CREATE TABLE IF NOT EXISTS `banlist` (
  `license` varchar(50) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `targetplayername` varchar(32) DEFAULT NULL,
  `sourceplayername` varchar(32) DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `timeat` varchar(50) NOT NULL,
  `expiration` varchar(50) NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli non.banlist: ~0 rows (około)

-- Zrzut struktury tabela non.banlisthistory
CREATE TABLE IF NOT EXISTS `banlisthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `targetplayername` varchar(32) DEFAULT NULL,
  `sourceplayername` varchar(32) DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `timeat` int(11) NOT NULL,
  `added` varchar(40) NOT NULL,
  `expiration` int(11) NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli non.banlisthistory: ~0 rows (około)

-- Zrzut struktury tabela non.deposits
CREATE TABLE IF NOT EXISTS `deposits` (
  `identifier` varchar(46) NOT NULL,
  `items` longtext DEFAULT '[]',
  `money` int(11) DEFAULT 0,
  `kits` longtext DEFAULT '[]',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.deposits: ~1 rows (około)
INSERT INTO `deposits` (`identifier`, `items`, `money`, `kits`) VALUES
	('9c37597f213cb346e7a4a960f0bfeba204495a55', '[]', 0, '[]');

-- Zrzut struktury tabela non.items
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  `limit` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.items: ~120 rows (około)
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `limit`) VALUES
	('amulet_pancerz', 'Amulet Pancerza', 100, 0, 1, 5),
	('amulet_zdrowia', 'Amulet Zdrowia', 100, 0, 1, 5),
	('anziosniper', 'Snajper Anzio', 15, 0, 1, 5),
	('bandage', 'Bandaz', 10, 0, 1, 5),
	('bat', 'Kij Bejsbolowy', 1, 0, 1, 1),
	('boncrimepozdrocwelujebany', 'BON NA ORG', 0, 0, 1, 1),
	('boniklimitowanyez', 'Bon Limitowany', 1, 1, -1, 5),
	('cartokenikpozdro', 'Car Token', 1, 0, 1, -1),
	('ceramicpistol', 'Pistolet Ceramiczny', 10, 0, 1, -1),
	('clip', 'Magazynek do pistoletu', 10, 0, 1, -1),
	('clip_default', 'Standardowy magazynek', 1, 0, 1, 5),
	('clip_extended', 'Rozszerzony magazynek', 1, 0, 1, 5),
	('coke', 'Kokaina', 1, 0, 1, 770),
	('coke_pooch', 'Porcja kokainy', 1, 0, 1, 770),
	('cosmicweaponpart', 'Czesc Broni Kosmicznej', 1, 0, 1, 5),
	('cosmicweaponpart2', 'CzĂâ€žĂ˘â€žÂ˘Ăâ€¦Ă˘â‚¬ÂşĂâ€žĂ˘â‚¬Âˇ 2 Broni Kos', 1, 0, 1, 5),
	('cosmicweaponpart3', 'CzĂâ€žĂ˘â€žÂ˘Ăâ€¦Ă˘â‚¬ÂşĂâ€žĂ˘â‚¬Âˇ 3 Broni Kos', 1, 0, 1, 5),
	('crack', 'Porcja CRACK', 2, 0, 1, 200),
	('crowbar', 'Ĺom', 1, 0, 1, 1),
	('datadrive', 'Dysk Z Danymi', 10, 0, 1, 5),
	('debentures', 'Obligacje', 0, 0, 1, 5),
	('diamond', 'Diament', 0, 0, 1, 5),
	('documentscode', 'Dokumenty - Kod', 1, 0, 1, 5),
	('documentshumane', 'Dokumenty - Humane', 1, 0, 1, 5),
	('dostepdobitekkurwaten', 'Klucz na org', 1, 0, 1, 1),
	('doubleaction', 'Double Action Revolver', 25, 0, 1, -1),
	('easterbasket', 'Kosz Wielkanocny', 1, 0, 1, 5),
	('empcrate', 'Skrzynia EMP', 5, 0, 1, 5),
	('energydrink', 'Energetyk ', 1, 0, 1, 100),
	('extendedclip2', 'Powiekszony magazynek v2', 1, 0, 1, -1),
	('fentanyl', 'Plaster FENTANYL', 2, 0, 1, 200),
	('flashlight', 'Latarka', 1, 0, 1, 5),
	('FNX45', 'Pistolet FNX 45', 1, 0, 1, -1),
	('gigakodzik', 'Tajny Kod Rabatowy', 1, 0, -1, 5),
	('goldenmap', 'ZĂâ€¦Ă˘â‚¬Ĺˇota Mapa', 1, 0, 1, 5),
	('goldnecklace', 'ZĂâ€¦Ă˘â‚¬Ĺˇoty Naszyjnik', 0, 0, 1, 5),
	('goldring', 'ZĂâ€¦Ă˘â‚¬Ĺˇoty PierĂâ€¦Ă˘â‚¬Âşcionek', 0, 0, 1, 5),
	('gps', 'GPS', 1, 0, 1, 2),
	('handcuffs', 'Kajdanki', 2, 0, 1, 5),
	('heavypistol', 'Pistolet Heavy', 10, 0, 1, -1),
	('heroin', 'Heroina', 1, 0, 1, -1),
	('heroin_pooch', 'Porcja heroiny', 1, 0, 1, -1),
	('image17a', 'Obraz 17A', 3, 0, 1, 5),
	('joint', 'joint', 100, 0, 1, 5),
	('knife', 'NĂłĹĽ', 1, 0, 1, 1),
	('knuckle', 'Kastet', 1, 0, 1, 1),
	('kreciktaborecik', 'heavysniper_mk2', 1, 0, 1, 1),
	('kubus_water', 'Pistolet na Wode', 1, 0, 1, 0),
	('laptopwithdata', 'Laptop z Danymi', 2, 0, 1, 5),
	('largegoldbar', 'DuĂâ€¦Ă‚ÂĽa ZĂâ€¦Ă˘â‚¬Ĺˇota Sztabka', 1, 0, 1, 5),
	('limitowane_auto_indrop', 'Bon na limitke', 1, 0, 1, 1),
	('luxary_finish', 'Luksusowe wykoĂâ€¦Ă˘â‚¬Ĺľczenie', 1, 0, 1, 5),
	('M1911', 'Pistolet M1911', 1, 0, 1, -1),
	('machete', 'Maczeta from Warsaw', 1, 0, 1, 1),
	('makarov', 'Pistolet Makarov', 1, 0, 1, -1),
	('mammothbone', 'KoĂâ€¦Ă˘â‚¬ÂşĂâ€žĂ˘â‚¬Âˇ Mamuta', 5, 0, 1, 5),
	('mayanmask', 'Maska MajĂĆ’Ă‚Âłw', 1, 0, 1, 5),
	('medikit', 'Apteczka', 100, 0, 1, 1),
	('meth_pooch', 'Porcja Metamfetaminy', 1, 0, 1, 200),
	('microsmg', 'Micro SMG', 1, 0, 1, -1),
	('minismg', 'Mini SMG', 1, 0, 1, -1),
	('nightstick', 'Palka policyjna', 1, 0, 1, 1),
	('obywatelcase7615', 'Skrzynka Obywatela', 1, 0, 1, 100),
	('oldmusket', 'Stary Muszkiet', 4, 0, 1, 5),
	('oldpainting', 'Stara Malarstwo', 2, 0, 1, 5),
	('p250', 'Pistolet P250', 1, 0, 1, -1),
	('pisanka1312pozdro', 'Pisanka', 0, 0, 0, 1000),
	('pistol', 'Pistolet', 10, 0, 1, -1),
	('pistol_ammo', 'Amunicja do Pistoletu', 2, 0, 1, 50000),
	('pistol_ammo_box', 'Magazynek do Pistoletu', 1, 0, 1, 10000),
	('pistol_mk2', 'Pistolet (MK II)', 10, 0, 1, -1),
	('premiumcase8122', 'Skrzynka Premium', 1, 0, 1, 100),
	('pumpkin', 'Dynia [EVENT]', 0, 0, 1, 100),
	('rabacikdwazero', 'Kod Rabatowy', 1, 0, -1, -1),
	('radio', 'Radio', 1, 0, 1, -1),
	('radiocrime', 'Radio', 1, 0, 1, -1),
	('repairkit', 'Zestaw naprawczy', 1, 0, 1, -1),
	('revolver', 'Revolver', 1, 0, 1, 1),
	('rifle_ammo', 'Amunicja do Karabinu', 0, 0, 1, 10000),
	('rifle_ammo_box', 'Magazynek do Karabinu', 1, 0, 1, 5000),
	('rob_blowpipe_hangar', 'Flet - Hangar', 1, 0, 1, 5),
	('rob_card_pacific', 'Karta - Pacific', 0, 0, 1, 5),
	('rob_laptop', 'Laptop do hackowania', 1, 0, 1, -1),
	('rob_laptop_humane', 'Laptop - Humane', 2, 0, 1, 5),
	('rob_lifeinvader', 'Lom do napadu', 1, 0, 1, -1),
	('rob_pendrive_casino', 'Pendrive - Casino', 0, 0, 1, 5),
	('rob_tablet_union', 'Tablet - Union', 1, 0, 1, 5),
	('ruby', 'Rubin', 0, 0, 1, 5),
	('scope', 'Maly celownik', 1, 0, 1, -1),
	('scope2', 'Duzy celownik', 1, 0, 1, -1),
	('scratchcard', 'Zdrapka', 1, 0, 1, 100),
	('scratchcarddiamond', 'Zdrapka Diamond', 1, 0, 1, 100),
	('scratchcardgold', 'Zdrapka Gold', 1, 0, 1, 100),
	('smallgoldbar', 'MaĂâ€¦Ă˘â‚¬Ĺˇa ZĂâ€¦Ă˘â‚¬Ĺˇota Sztabka', 1, 0, 1, 5),
	('smg_ammo', 'Amunicja do SMG', 0, 0, 1, 10000),
	('smg_ammo_box', 'Magazynek do SMG', 1, 0, 1, 5000),
	('smg_mk2', 'SMG (MK II)', 1, 0, 1, -1),
	('sniper_ammo', 'Amunicja do Snajperki', 1, 0, 1, 10000),
	('snspistol', 'Pistolet SNS', 10, 0, 1, 100),
	('snspistol_mk2', 'Pistolet SNS (MK II)', 10, 0, 1, 100),
	('stungun', 'Paralizator', 1, 0, 1, 1),
	('suppressor', 'Tlumik', 1, 0, 1, 5),
	('suppressor2', 'Tlumik v2', 1, 0, 1, -1),
	('ticket_sponsor', 'Bon Na SPONSORA (7 Dni)', 0, 0, 0, 1),
	('ticket_sponsor2', 'Bon Na SPONSORA (30 Dni)', 0, 0, 0, 1),
	('ticket_svip', 'Bon Na SVIPA (7 Dni)', 0, 0, 0, 1),
	('ticket_svip2', 'Bon Na SVIPA (30 Dni)', 0, 0, 0, 1),
	('ticket_vip', 'Bon Na Vipa (7 Dni)', 1, 0, 0, 1),
	('ticket_vip2', 'Bon Na Vipa (30 Dni)', 1, 0, 0, 1),
	('vest_heavy', 'Kamizelka Ciezka', 1, 0, 1, -1),
	('vest_light', 'Kamizelka lekka', 1, 0, 1, -1),
	('vest_medium', 'Kamizelka Srednia', 1, 0, 1, -1),
	('vials', 'Fiolki', 0, 0, 1, 5),
	('vintagepistol', 'Pistolet Vintage', 10, 0, 1, -1),
	('weaponcase5156', 'Skrzynka Broni', 1, 0, 1, 100),
	('weaponchest', 'Skrzynia na BroĂâ€¦Ă˘â‚¬Ĺľ', 10, 0, 1, 5),
	('weed', 'Liscie marihuany', 1, 0, 1, -1),
	('weedzik', 'Weed AK47', 1, 0, 1, -1),
	('weed_pooch', 'Sativa haze', 1, 0, 1, -1),
	('zlom', 'ZĂâ€¦Ă˘â‚¬Ĺˇom', 1, 0, 1, 50);

-- Zrzut struktury tabela non.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(46) NOT NULL,
  `jail_time` int(11) NOT NULL,
  `items` longtext DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.jail: ~0 rows (około)

-- Zrzut struktury tabela non.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  `clothes` longtext DEFAULT NULL,
  `grades` longtext NOT NULL,
  `account` int(11) DEFAULT 0,
  `stash` longtext DEFAULT '[]',
  `webhooks` text DEFAULT '{}',
  `suspended` timestamp NULL DEFAULT current_timestamp(),
  `upgrades` text DEFAULT '{}',
  `kits` longtext DEFAULT '[]',
  `bitkipoints` int(11) DEFAULT 0,
  `wins` int(11) NOT NULL DEFAULT 0,
  `loses` int(11) NOT NULL DEFAULT 0,
  `settings` varchar(255) NOT NULL DEFAULT '''[]''',
  `capturedstrefa` longtext DEFAULT NULL,
  `lvl` int(11) DEFAULT 0,
  `blocked` tinyint(1) DEFAULT 1,
  `vehicles` longtext NOT NULL DEFAULT '[]',
  `color` longtext DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.jobs: ~4 rows (około)
INSERT INTO `jobs` (`name`, `label`, `whitelisted`, `clothes`, `grades`, `account`, `stash`, `webhooks`, `suspended`, `upgrades`, `kits`, `bitkipoints`, `wins`, `loses`, `settings`, `capturedstrefa`, `lvl`, `blocked`, `vehicles`, `color`) VALUES
	('mechanic', 'LSC', 0, '[{"label":"Deputy","skin":{"chimp_4":10,"moles_1":0,"age_1":0,"bodyb_4":0,"mask_1":0,"nose_1":-5,"decals_1":0,"nose_5":10,"face_2":0,"eye_squint":0,"sex":0,"chimp_1":10,"chin_13":0,"chain_2":0,"chin_2":0,"blend_skin":0,"lips":10,"bproof_2":0,"tshirt_2":0,"chimp_3":10,"jaw_1":0,"bracelets_2":0,"face_md_weight":61,"age_2":0,"eyebrow_2":10,"skin_md_weight":27,"nose_3":5,"shoes_1":110,"jaw_2":0,"eye_color":0,"bags_2":0,"face_3":0,"bproof_1":87,"complexion_2":0,"neck_thickness":0,"glasses_2":0,"torso_2":1,"pants_1":204,"bodyb_1":-1,"dad":29,"helmet_1":224,"glasses_1":0,"tshirt_1":218,"moles_2":0,"cheeks_1":0,"neck":10,"bracelets_1":-1,"complexion_1":0,"skin":0,"decals_2":0,"blend":0,"cheeks_2":0,"eyebrow_1":10,"nose_4":8,"blemishes_1":0,"ears_1":-1,"sun_2":0,"pants_2":4,"skin_3":0,"blend_face":0,"nose_2":6,"bags_1":0,"eyebrows_6":0,"bodyb_2":0,"chain_1":0,"ears_2":0,"arms":12,"mom":43,"mask_2":0,"torso_1":629,"chin_1":0,"watches_2":0,"chin_4":0,"cheeks_3":0,"sun_1":0,"watches_1":-1,"helmet_2":0,"nose_6":0,"chimp_2":10,"eyebrows_5":0,"bodyb_3":-1,"lip_thickness":0,"shoes_2":0,"arms_2":0,"blemishes_2":0,"skin_2":0}},{"label":"Senior Deputy","skin":{"chimp_4":10,"moles_1":0,"age_1":0,"bodyb_4":0,"mask_1":0,"nose_1":-5,"decals_1":0,"nose_5":10,"face_2":0,"eye_squint":0,"sex":0,"chimp_1":10,"chin_13":0,"chain_2":0,"chin_2":0,"blend_skin":0,"lips":10,"bproof_2":0,"tshirt_2":0,"chimp_3":10,"jaw_1":0,"bracelets_2":0,"face_md_weight":61,"age_2":0,"eyebrow_2":10,"skin_md_weight":27,"nose_3":5,"shoes_1":110,"jaw_2":0,"eye_color":0,"bags_2":0,"face_3":0,"bproof_1":87,"complexion_2":0,"neck_thickness":0,"glasses_2":0,"torso_2":1,"pants_1":204,"bodyb_1":-1,"dad":29,"helmet_1":224,"glasses_1":0,"tshirt_1":218,"moles_2":0,"cheeks_1":0,"neck":10,"bracelets_1":-1,"complexion_1":0,"skin":0,"decals_2":0,"blend":0,"cheeks_2":0,"eyebrow_1":10,"nose_4":8,"blemishes_1":0,"ears_1":-1,"sun_2":0,"pants_2":4,"skin_3":0,"blend_face":0,"nose_2":6,"bags_1":0,"eyebrows_6":0,"bodyb_2":0,"chain_1":0,"ears_2":0,"arms":12,"mom":43,"mask_2":0,"torso_1":629,"chin_1":0,"watches_2":0,"chin_4":0,"cheeks_3":0,"sun_1":0,"watches_1":-1,"helmet_2":0,"nose_6":0,"chimp_2":10,"eyebrows_5":0,"bodyb_3":-1,"lip_thickness":0,"shoes_2":0,"arms_2":0,"blemishes_2":0,"skin_2":0}},{"label":"Corporal 2nd","skin":{"chimp_4":10,"moles_1":0,"age_1":0,"bodyb_4":0,"mask_1":0,"nose_1":-5,"decals_1":0,"nose_5":10,"face_2":0,"eye_squint":0,"sex":0,"chimp_1":10,"chin_13":0,"chain_2":0,"chin_2":0,"blend_skin":0,"lips":10,"bproof_2":0,"tshirt_2":0,"chimp_3":10,"jaw_1":0,"bracelets_2":0,"face_md_weight":61,"age_2":0,"eyebrow_2":10,"skin_md_weight":27,"nose_3":5,"shoes_1":110,"jaw_2":0,"eye_color":0,"bags_2":0,"face_3":0,"bproof_1":87,"complexion_2":0,"neck_thickness":0,"glasses_2":0,"torso_2":4,"pants_1":204,"bodyb_1":-1,"dad":29,"helmet_1":224,"glasses_1":0,"tshirt_1":219,"moles_2":0,"cheeks_1":0,"neck":10,"bracelets_1":-1,"complexion_1":0,"skin":0,"decals_2":0,"blend":0,"cheeks_2":0,"eyebrow_1":10,"nose_4":8,"blemishes_1":0,"ears_1":-1,"sun_2":0,"pants_2":4,"skin_3":0,"blend_face":0,"nose_2":6,"bags_1":0,"eyebrows_6":0,"bodyb_2":0,"chain_1":0,"ears_2":0,"arms":12,"mom":43,"mask_2":0,"torso_1":623,"chin_1":0,"watches_2":0,"chin_4":0,"cheeks_3":0,"sun_1":0,"watches_1":-1,"helmet_2":0,"nose_6":0,"chimp_2":10,"eyebrows_5":0,"bodyb_3":-1,"lip_thickness":0,"shoes_2":0,"arms_2":0,"blemishes_2":0,"skin_2":0}},{"label":"Corporal 1st","skin":{"chimp_4":10,"moles_1":0,"age_1":0,"bodyb_4":0,"mask_1":0,"nose_1":-5,"decals_1":0,"nose_5":10,"face_2":0,"eye_squint":0,"sex":0,"chimp_1":10,"chin_13":0,"chain_2":0,"chin_2":0,"blend_skin":0,"lips":10,"bproof_2":0,"tshirt_2":0,"chimp_3":10,"jaw_1":0,"bracelets_2":0,"face_md_weight":61,"age_2":0,"eyebrow_2":10,"skin_md_weight":27,"nose_3":5,"shoes_1":110,"jaw_2":0,"eye_color":0,"bags_2":0,"face_3":0,"bproof_1":87,"complexion_2":0,"neck_thickness":0,"glasses_2":0,"torso_2":4,"pants_1":204,"bodyb_1":-1,"dad":29,"helmet_1":224,"glasses_1":0,"tshirt_1":219,"moles_2":0,"cheeks_1":0,"neck":10,"bracelets_1":-1,"complexion_1":0,"skin":0,"decals_2":0,"blend":0,"cheeks_2":0,"eyebrow_1":10,"nose_4":8,"blemishes_1":0,"ears_1":-1,"sun_2":0,"pants_2":4,"skin_3":0,"blend_face":0,"nose_2":6,"bags_1":0,"eyebrows_6":0,"bodyb_2":0,"chain_1":0,"ears_2":0,"arms":12,"mom":43,"mask_2":0,"torso_1":623,"chin_1":0,"watches_2":0,"chin_4":0,"cheeks_3":0,"sun_1":0,"watches_1":-1,"helmet_2":0,"nose_6":0,"chimp_2":10,"eyebrows_5":0,"bodyb_3":-1,"lip_thickness":0,"shoes_2":0,"arms_2":0,"blemishes_2":0,"skin_2":0}},{"label":"Sergeant","skin":{"chimp_4":10,"moles_1":0,"age_1":0,"bodyb_4":0,"mask_1":0,"nose_1":-5,"decals_1":0,"nose_5":10,"face_2":0,"eye_squint":0,"sex":0,"chimp_1":10,"chin_13":0,"chain_2":0,"chin_2":0,"blend_skin":0,"lips":10,"bproof_2":0,"tshirt_2":0,"chimp_3":10,"jaw_1":0,"bracelets_2":0,"face_md_weight":61,"age_2":0,"eyebrow_2":10,"skin_md_weight":27,"nose_3":5,"shoes_1":110,"jaw_2":0,"eye_color":0,"bags_2":0,"face_3":0,"bproof_1":87,"complexion_2":0,"neck_thickness":0,"glasses_2":0,"torso_2":4,"pants_1":204,"bodyb_1":-1,"dad":29,"helmet_1":224,"glasses_1":0,"tshirt_1":219,"moles_2":0,"cheeks_1":0,"neck":10,"bracelets_1":-1,"complexion_1":0,"skin":0,"decals_2":0,"blend":0,"cheeks_2":0,"eyebrow_1":10,"nose_4":8,"blemishes_1":0,"ears_1":-1,"sun_2":0,"pants_2":4,"skin_3":0,"blend_face":0,"nose_2":6,"bags_1":0,"eyebrows_6":0,"bodyb_2":0,"chain_1":0,"ears_2":0,"arms":27,"mom":43,"mask_2":0,"torso_1":623,"chin_1":0,"watches_2":0,"chin_4":0,"cheeks_3":0,"sun_1":0,"watches_1":-1,"helmet_2":0,"nose_6":0,"chimp_2":10,"eyebrows_5":0,"bodyb_3":-1,"lip_thickness":0,"shoes_2":0,"arms_2":0,"blemishes_2":0,"skin_2":0}},{"label":"Senior Sergeant","skin":{"chimp_4":10,"moles_1":0,"age_1":0,"bodyb_4":0,"mask_1":0,"nose_1":-5,"decals_1":0,"nose_5":10,"face_2":0,"eye_squint":0,"sex":0,"chimp_1":10,"chin_13":0,"chain_2":0,"chin_2":0,"blend_skin":0,"lips":10,"bproof_2":0,"tshirt_2":0,"chimp_3":10,"jaw_1":0,"bracelets_2":0,"face_md_weight":61,"age_2":0,"eyebrow_2":10,"skin_md_weight":27,"nose_3":5,"shoes_1":110,"jaw_2":0,"eye_color":0,"bags_2":0,"face_3":0,"bproof_1":87,"complexion_2":0,"neck_thickness":0,"glasses_2":0,"torso_2":4,"pants_1":204,"bodyb_1":-1,"dad":29,"helmet_1":224,"glasses_1":0,"tshirt_1":219,"moles_2":0,"cheeks_1":0,"neck":10,"bracelets_1":-1,"complexion_1":0,"skin":0,"decals_2":0,"blend":0,"cheeks_2":0,"eyebrow_1":10,"nose_4":8,"blemishes_1":0,"ears_1":-1,"sun_2":0,"pants_2":4,"skin_3":0,"blend_face":0,"nose_2":6,"bags_1":0,"eyebrows_6":0,"bodyb_2":0,"chain_1":0,"ears_2":0,"arms":27,"mom":43,"mask_2":0,"torso_1":623,"chin_1":0,"watches_2":0,"chin_4":0,"cheeks_3":0,"sun_1":0,"watches_1":-1,"helmet_2":0,"nose_6":0,"chimp_2":10,"eyebrows_5":0,"bodyb_3":-1,"lip_thickness":0,"shoes_2":0,"arms_2":0,"blemishes_2":0,"skin_2":0}},{"label":"Staff Sergeant","skin":{"chimp_4":10,"moles_1":0,"age_1":0,"bodyb_4":0,"mask_1":0,"nose_1":-5,"decals_1":0,"nose_5":10,"face_2":0,"eye_squint":0,"sex":0,"chimp_1":10,"chin_13":0,"chain_2":0,"chin_2":0,"blend_skin":0,"lips":10,"bproof_2":0,"tshirt_2":0,"chimp_3":10,"jaw_1":0,"bracelets_2":0,"face_md_weight":61,"age_2":0,"eyebrow_2":10,"skin_md_weight":27,"nose_3":5,"shoes_1":110,"jaw_2":0,"eye_color":0,"bags_2":0,"face_3":0,"bproof_1":87,"complexion_2":0,"neck_thickness":0,"glasses_2":0,"torso_2":4,"pants_1":204,"bodyb_1":-1,"dad":29,"helmet_1":224,"glasses_1":0,"tshirt_1":219,"moles_2":0,"cheeks_1":0,"neck":10,"bracelets_1":-1,"complexion_1":0,"skin":0,"decals_2":0,"blend":0,"cheeks_2":0,"eyebrow_1":10,"nose_4":8,"blemishes_1":0,"ears_1":-1,"sun_2":0,"pants_2":4,"skin_3":0,"blend_face":0,"nose_2":6,"bags_1":0,"eyebrows_6":0,"bodyb_2":0,"chain_1":0,"ears_2":0,"arms":27,"mom":43,"mask_2":0,"torso_1":623,"chin_1":0,"watches_2":0,"chin_4":0,"cheeks_3":0,"sun_1":0,"watches_1":-1,"helmet_2":0,"nose_6":0,"chimp_2":10,"eyebrows_5":0,"bodyb_3":-1,"lip_thickness":0,"shoes_2":0,"arms_2":0,"blemishes_2":0,"skin_2":0}},{"label":"Proobie Deputy","skin":{"chimp_4":10,"moles_1":0,"age_1":0,"bodyb_4":0,"mask_1":0,"nose_1":-5,"decals_1":0,"nose_5":10,"face_2":0,"eye_squint":0,"sex":0,"chimp_1":10,"chin_13":0,"chain_2":0,"chin_2":0,"blend_skin":0,"lips":10,"bproof_2":0,"tshirt_2":0,"chimp_3":10,"jaw_1":0,"bracelets_2":0,"face_md_weight":61,"age_2":0,"eyebrow_2":10,"skin_md_weight":27,"nose_3":5,"shoes_1":110,"jaw_2":0,"eye_color":0,"bags_2":0,"face_3":0,"bproof_1":91,"complexion_2":0,"neck_thickness":0,"glasses_2":0,"torso_2":1,"pants_1":204,"bodyb_1":-1,"dad":29,"helmet_1":224,"glasses_1":0,"tshirt_1":218,"moles_2":0,"cheeks_1":0,"neck":10,"bracelets_1":-1,"complexion_1":0,"skin":0,"decals_2":0,"blend":0,"cheeks_2":0,"eyebrow_1":10,"nose_4":8,"blemishes_1":0,"ears_1":-1,"sun_2":0,"pants_2":4,"skin_3":0,"blend_face":0,"nose_2":6,"bags_1":0,"eyebrows_6":0,"bodyb_2":0,"chain_1":0,"ears_2":0,"arms":12,"mom":43,"mask_2":0,"torso_1":629,"chin_1":0,"watches_2":0,"chin_4":0,"cheeks_3":0,"sun_1":0,"watches_1":-1,"helmet_2":0,"nose_6":0,"chimp_2":10,"eyebrows_5":0,"bodyb_3":-1,"lip_thickness":0,"shoes_2":0,"arms_2":0,"blemishes_2":0,"skin_2":0}},{"label":"01","skin":{"moles_1":0,"age_1":0,"blend_skin":0,"chain_2":0,"bags_2":0,"decals_1":0,"nose_5":10,"face_2":0,"eye_squint":0,"face_3":0,"sex":0,"chimp_1":10,"chin_13":0,"cheeks_3":0,"pants_2":1,"torso_1":618,"lips":10,"cheeks_2":0,"arms":0,"tshirt_2":0,"chimp_3":10,"jaw_1":0,"bracelets_2":0,"skin_md_weight":27,"helmet_1":222,"bodyb_4":0,"eyebrow_2":10,"decals_2":0,"nose_3":5,"blend_face":0,"shoes_1":25,"sun_2":0,"skin":15,"bproof_1":0,"skin_3":0,"chimp_4":10,"eye_color":26,"complexion_2":0,"blend":0,"dad":29,"neck_thickness":0,"glasses_1":0,"moles_2":0,"bodyb_1":-1,"glasses_2":0,"neck":10,"bracelets_1":-1,"complexion_1":0,"eyebrow_1":10,"jaw_2":0,"cheeks_1":0,"chin_4":0,"chin_2":0,"mask_1":0,"nose_1":-5,"bags_1":0,"tshirt_1":15,"mask_2":0,"torso_2":0,"nose_2":6,"eyebrows_6":0,"bodyb_2":0,"face_md_weight":61,"ears_2":0,"ears_1":-1,"mom":43,"blemishes_2":0,"bodyb_3":-1,"chin_1":0,"watches_2":0,"age_2":0,"pants_1":130,"chain_1":0,"sun_1":0,"watches_1":-1,"helmet_2":0,"nose_6":0,"chimp_2":10,"blemishes_1":0,"eyebrows_5":0,"arms_2":0,"lip_thickness":0,"shoes_2":0,"bproof_2":0,"nose_4":8,"skin_2":0}}]', '[{"salary":500,"permissions":[],"name":"Wlasciciel Warsztatu"},{"salary":0,"permissions":{"withdraw_money":true,"withdraw_item":true,"members_menager":true,"kits_menager":true,"edit_clothes":true,"deposit_money":true,"get_car":true},"name":"Szef Warsztatu"},{"salary":0,"permissions":{"withdraw_item":true,"withdraw_money":true,"members_menager":true,"kits_menager":true,"edit_clothes":true,"deposit_money":true,"get_car":true},"name":"Koordynator"},{"salary":0,"permissions":[],"name":"Zawodowiec"},{"salary":0,"permissions":[],"name":"Specjalista"},{"salary":0,"permissions":[],"name":"Fachowiec"},{"salary":0,"permissions":[],"name":"Majster"},{"salary":0,"permissions":[],"name":"Nowicjusz"},{"salary":0,"permissions":[],"name":"Rekrut"}]', 0, '[{"name":"pistol_ammo","count":103660,"label":"Amunicja do Pistoletu"},{"label":"Tabletka MDMA","count":8090,"name":"mdma"}]', '{"b198c4845d693825e371fe413fab5c0a817590d7":0,"50a5fa068797456fcf3a6f3e12f23ee50bdd2984":590,"819a21ac059478f05e76ab029cdfcd4ee9c1d74e":1030,"a563a6fa0843866252c5d3e1eda73d8e822a5ede":0,"dce867529af843ec98bab3258ed45c90f7990286":0,"72afedc8bf847bb35e1738feb00b981fcb8cf984":710,"36d162375c7d1c2b96942bd9be55c12fa09ae4a8":20,"719a6b517407e14ed24403f4fd88c190a3f3e719":0,"6f10b3273d00363d2803cc6ec7fada78fe91fd52":0,"4a893296971370395e6c34d55cd053e5c3d3870d":0,"2398cb66031f8e81a978d45c19f749aab0169c72":0,"1df54412ee44e0373bfcd46280abc9b024c84558":0,"599c368a8b6800cccdcda17e92963d44a2f62201":0,"93d7e45f444bc7d654e43f01ae0adb873a07feed":0,"cfe162cae237268aff64570670f47b142e679e39":2480,"edbeac17c97b0b9024b2e7a89d929237a680743e":100,"06b6eaab456ab3dccda65aa572d2ae0fb9123b5d":0,"45d2ae152e5b11961543ca21f9767d9602fb07ee":1310,"da2f46103fb913ed3c6fc9dc7ab408d11cedc41d":0,"d362327875654c678300196d4dbdb02c021d9983":420,"e4b191ebe63159f8bf6721bd232d259ac017dd33":0,"e1c8cb7dda3d0f94691e4f151edab52da0a0935a":0,"95062ebae5010a79cbacc1693acf4ce8665caf6d":0,"713ffda66bf974758c9d1be5e2b71f3bd0eb877b":3760,"25e66cc6bfd009c6ae66a0f02156702f1d90cc87":3460,"db221b66fba84e3b0031ad7007e72bcd101700e4":0,"a0f30b6863324fc857663ea4439831db290bdd36":2990,"341f9d3f0a03ad8ad182311d8b399864b4f7a1c3":0,"a8b58534866c3a441c3adbfea287e0e40a4843ef":0,"cb70f90e4899c6af5f61bffdcc6f5873479860b9":0,"f933102cbfad967835227223c5e2046137fe56f9":0,"e17fe0b252718e3e7f522c45a8fc703727171b2e":0,"7a7121c665202427d94b4d53ce881536e268c4b9":0,"535559cf632e9b2481b3966c5a84e42d24b0aad5":0,"28d9a37ca6e5ec1e881f1862952c8d082fe298a3":0,"7b12c042af2cff7ef9fbbe9bf38915ef0da73e74":620,"cbf6399898c0297e1afa7bcf588dcda10993a64a":0,"bd1730244a02e5dc485f5c8ac84c898f80fcbabf":0,"398e41a91c0e629f564f315c4c7137b8f4a46770":0,"34cb3683146fb383b9e5803a004e7975a4946f85":2570,"95593c932157b5061b66cb717f8f9a79ce5e182c":0,"36529720b56ce5fc10194eda6daee7f9f8c82275":110,"20498fcfef1f92d29451089711e061630482d872":10,"27665d78db1c8bcf5e234b978d9e1df80a604b1a":1270,"35b9b94ffc33af2e6bce41529d67a4e51d3150fb":1430,"3b837c10eacf691f2b7a92f1894a88ebc51fe4e0":380,"81b174f24070eec6babd75a3ec36fee71a06b558":2430,"ca180c182a648edda6836a649a6b482c97afed29":830,"1f59aebeab9f239f18f828d180b9a019f1a206f7":0,"010d436bfd3c924ec0fe26fb98005953671bb3b8":0,"184b8956ed04c267aaa48dfc282ee5058c1c2392":0,"d45d30090de101d0bc16a99249d96aff721da294":0,"680a6fb6242ea0dd65835a3a04650f8962ddc507":20,"2d8519c9a04479ec3f4e9938b75060957d53b783":0,"4529b251693e99f352c1adbcdf00b970e1660e9f":0,"7c30f62d5dbd225319b58e79cb7404dc096837e2":940,"add94238a29576005abbee3339c14163c8496c4e":2820,"4fc0b605d1dc5c0e9b40096feef693ef5147e2a1":0,"7483950d8c3ced9242527dedceab62cd3a8cad16":0,"9a092c598159f788cf37413a6afb23fd33f21c6c":0,"8a556e6e3556b4513d1635900ce14e3668e25122":1970,"f7b3bbccac295ff27d57e4b03d1f3ffa27b96f24":0,"b9a60fcca19b04e89abf227525757c158ce59bf9":330,"4ab9550d38ecff172d95c387dd278ce91efadbcb":1300,"da467df82517ae5c588914726433032010359ca8":3160,"387c384a709a01dd59c9db0cc9b664a332627e9e":3620,"32cbc44f81df9d4c65411943b9d4d70dcc2cab1c":0,"41991e43e91b8d2a335cea527458ea0d34ed1947":270,"bcde386691f670d43f46b323cb4369cd7dd44bff":0,"a8e970c2f49d04da33138ac78f6cdd708f30ca88":0,"c3f3b751fad08b9e320ce048a0da3f33555f7ad2":0,"d8144e9414eff21d0f1bbba405d7805e064cd0d7":30,"a47ddd26c1748551e6812d1a3696f745e9d4de02":160,"e221002e71f9320ed3bca460d155aadfbc465afa":0,"0c1c146bb5f7d9f0145597d8635afdddac39febd":1400,"f3a9d4d25027acd8377674c033e63c6081f4f3a4":0,"9c37597f213cb346e7a4a960f0bfeba204495a55":300,"4ee9fc52b72cbce6d48b28574961b74ed18be371":90,"a41a5c722ce4625332d8b12c8768cc7ec6283694":3470,"7120bdf4fa2e3f74a0e327de935f2ce27d13b3b0":30,"84e4278bf4fcf62861a5fdea90c1c0a65159bb61":0,"f4eac1d8e391123565a7775562c6cdb59f0c6120":0,"96663953f3c95b7bc192f4329dad9764538a352d":0}', NULL, '{"repairkit":false,"handcuffs":false}', '[]', 0, 0, 0, '[]', NULL, 0, 1, '', ''),
	('offpolice', 'LSPD(OFF)', 0, NULL, '[{"name":"Director of police","salary":500,"permissions":[]},{"name":"Chief of police","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"members_menager":true,"get_car":true}},{"name":"Under Sheriff","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Assistant Sheriff","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Area Commander","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Inspector SASP","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Deputy Chief Of Police","salary":0,"permissions":{"deposit_money":true,"withdraw_item":true,"members_menager":true,"get_car":true,"edit_clothes":true}},{"name":"Assistant Chief Of Police","salary":0,"permissions":{"withdraw_item":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Commander","salary":0,"permissions":{"withdraw_item":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"---------------------","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Capitan II","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Capitan I","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"----------------------","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Lieutenant II","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Lieutenant I","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"-----------------------------","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Sergeant III","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Sergeant II","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Sergeant I","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"------------------------","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Officer III","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Officer II","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Officer I","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Cadet","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}}]', 0, '[]', '{}', NULL, '{"handcuffs":false,"repairkit":false}', '[]', 0, 0, 0, '[]', NULL, 0, 1, '', ''),
	('police', 'LSPD', 0, '[{"label":"Officer","skin":{"neck":10,"skin":15,"blemishes_1":0,"torso_1":525,"mask_1":0,"chain_2":0,"cheeks_1":10,"arms_2":0,"eyebrow_1":10,"watches_1":-1,"bracelets_1":-1,"torso_2":0,"pants_2":0,"pants_1":193,"lips":10,"nose_5":10,"ears_2":0,"sun_2":0,"nose_1":10,"eye_color":0,"bags_2":0,"decals_1":0,"decals_2":0,"helmet_2":0,"watches_2":0,"complexion_2":0,"glasses_1":0,"bodyb_2":0,"bproof_1":0,"age_2":0,"helmet_1":214,"moles_1":0,"bproof_2":0,"glasses_2":0,"shoes_2":0,"mask_2":0,"blend_face":0,"shoes_1":73,"bodyb_1":0,"cheeks_3":10,"chain_1":0,"blend":0,"eyebrow_2":10,"skin_2":0,"arms":26,"sun_1":0,"bags_1":81,"skin_3":0,"chimp_3":10,"jaw_2":10,"chimp_1":10,"moles_2":0,"nose_2":10,"nose_4":10,"tshirt_2":0,"nose_3":10,"nose_6":10,"bracelets_2":0,"chimp_4":10,"age_1":0,"blend_skin":0,"cheeks_2":10,"jaw_1":10,"complexion_1":0,"chimp_2":10,"ears_1":-1,"face_3":10,"face_2":8,"blemishes_2":0,"tshirt_1":214,"sex":0}},{"label":"cadet","skin":{"neck":10,"skin":15,"blemishes_1":0,"torso_1":526,"mask_1":0,"chain_2":0,"cheeks_1":10,"arms_2":0,"eyebrow_1":10,"watches_1":-1,"bracelets_1":-1,"torso_2":0,"pants_2":0,"pants_1":193,"lips":10,"nose_5":10,"ears_2":0,"sun_2":0,"nose_1":10,"eye_color":0,"bags_2":0,"decals_1":0,"decals_2":0,"helmet_2":0,"watches_2":0,"complexion_2":0,"glasses_1":0,"bodyb_2":0,"bproof_1":75,"age_2":0,"helmet_1":214,"moles_1":0,"bproof_2":0,"glasses_2":0,"shoes_2":0,"mask_2":0,"blend_face":0,"shoes_1":73,"bodyb_1":0,"cheeks_3":10,"chain_1":0,"blend":0,"eyebrow_2":10,"skin_2":0,"arms":20,"sun_1":0,"bags_1":81,"skin_3":0,"chimp_3":10,"jaw_2":10,"chimp_1":10,"moles_2":0,"nose_2":10,"nose_4":10,"tshirt_2":0,"nose_3":10,"nose_6":10,"bracelets_2":0,"chimp_4":10,"age_1":0,"blend_skin":0,"cheeks_2":10,"jaw_1":10,"complexion_1":0,"chimp_2":10,"ears_1":-1,"face_3":10,"face_2":8,"blemishes_2":0,"tshirt_1":214,"sex":0}},{"label":"Sergeant","skin":{"neck":10,"skin":15,"blemishes_1":0,"torso_1":524,"mask_1":0,"chain_2":0,"cheeks_1":10,"arms_2":0,"eyebrow_1":10,"watches_1":-1,"bracelets_1":-1,"torso_2":0,"pants_2":1,"pants_1":130,"lips":10,"nose_5":10,"ears_2":0,"sun_2":0,"nose_1":10,"eye_color":0,"bags_2":0,"decals_1":0,"decals_2":0,"helmet_2":0,"watches_2":0,"complexion_2":0,"glasses_1":0,"bodyb_2":0,"bproof_1":69,"age_2":0,"helmet_1":214,"moles_1":0,"bproof_2":0,"glasses_2":0,"shoes_2":0,"mask_2":0,"blend_face":0,"shoes_1":81,"bodyb_1":0,"cheeks_3":10,"chain_1":0,"blend":0,"eyebrow_2":10,"skin_2":0,"arms":30,"sun_1":0,"bags_1":81,"skin_3":0,"chimp_3":10,"jaw_2":10,"chimp_1":10,"moles_2":0,"nose_2":10,"nose_4":10,"tshirt_2":0,"nose_3":10,"nose_6":10,"bracelets_2":0,"chimp_4":10,"age_1":0,"blend_skin":0,"cheeks_2":10,"jaw_1":10,"complexion_1":0,"chimp_2":10,"ears_1":-1,"face_3":10,"face_2":8,"blemishes_2":0,"tshirt_1":214,"sex":0}},{"label":"Lieutenant","skin":{"neck":10,"skin":15,"blemishes_1":0,"torso_1":533,"mask_1":0,"chain_2":0,"cheeks_1":10,"arms_2":0,"eyebrow_1":10,"watches_1":-1,"bracelets_1":-1,"torso_2":0,"pants_2":1,"pants_1":130,"lips":10,"nose_5":10,"ears_2":0,"sun_2":0,"nose_1":10,"eye_color":0,"bags_2":0,"decals_1":0,"decals_2":0,"helmet_2":0,"watches_2":0,"complexion_2":0,"glasses_1":0,"bodyb_2":0,"bproof_1":67,"age_2":0,"helmet_1":214,"moles_1":0,"bproof_2":1,"glasses_2":0,"shoes_2":0,"mask_2":0,"blend_face":0,"shoes_1":81,"bodyb_1":0,"cheeks_3":10,"chain_1":199,"blend":0,"eyebrow_2":10,"skin_2":0,"arms":30,"sun_1":0,"bags_1":81,"skin_3":0,"chimp_3":10,"jaw_2":10,"chimp_1":10,"moles_2":0,"nose_2":10,"nose_4":10,"tshirt_2":0,"nose_3":10,"nose_6":10,"bracelets_2":0,"chimp_4":10,"age_1":0,"blend_skin":0,"cheeks_2":10,"jaw_1":10,"complexion_1":0,"chimp_2":10,"ears_1":-1,"face_3":10,"face_2":8,"blemishes_2":0,"tshirt_1":214,"sex":0}},{"label":"Capitan","skin":{"neck":10,"skin":15,"blemishes_1":0,"torso_1":529,"mask_1":0,"chain_2":0,"cheeks_1":10,"arms_2":0,"eyebrow_1":10,"watches_1":-1,"bracelets_1":-1,"torso_2":0,"pants_2":1,"pants_1":130,"lips":10,"nose_5":10,"ears_2":0,"sun_2":0,"nose_1":10,"eye_color":0,"bags_2":0,"decals_1":0,"decals_2":0,"helmet_2":0,"watches_2":0,"complexion_2":0,"glasses_1":0,"bodyb_2":0,"bproof_1":66,"age_2":0,"helmet_1":214,"moles_1":0,"bproof_2":1,"glasses_2":0,"shoes_2":0,"mask_2":0,"blend_face":0,"shoes_1":81,"bodyb_1":0,"cheeks_3":10,"chain_1":199,"blend":0,"eyebrow_2":10,"skin_2":0,"arms":30,"sun_1":0,"bags_1":81,"skin_3":0,"chimp_3":10,"jaw_2":10,"chimp_1":10,"moles_2":0,"nose_2":10,"nose_4":10,"tshirt_2":0,"nose_3":10,"nose_6":10,"bracelets_2":0,"chimp_4":10,"age_1":0,"blend_skin":0,"cheeks_2":10,"jaw_1":10,"complexion_1":0,"chimp_2":10,"ears_1":-1,"face_3":10,"face_2":8,"blemishes_2":0,"tshirt_1":214,"sex":0}},{"label":"SWAT","skin":{"neck":10,"skin":15,"blemishes_1":0,"torso_1":532,"mask_1":104,"chain_2":0,"cheeks_1":10,"arms_2":0,"eyebrow_1":10,"watches_1":-1,"bracelets_1":-1,"torso_2":0,"pants_2":1,"pants_1":130,"lips":10,"nose_5":10,"ears_2":0,"sun_2":0,"nose_1":10,"eye_color":0,"bags_2":0,"decals_1":0,"decals_2":0,"helmet_2":0,"watches_2":0,"complexion_2":0,"glasses_1":0,"bodyb_2":0,"bproof_1":74,"age_2":0,"helmet_1":117,"moles_1":0,"bproof_2":1,"glasses_2":0,"shoes_2":0,"mask_2":25,"blend_face":0,"shoes_1":81,"bodyb_1":0,"cheeks_3":10,"chain_1":202,"blend":0,"eyebrow_2":10,"skin_2":0,"arms":30,"sun_1":0,"bags_1":143,"skin_3":0,"chimp_3":10,"jaw_2":10,"chimp_1":10,"moles_2":0,"nose_2":10,"nose_4":10,"tshirt_2":0,"nose_3":10,"nose_6":10,"bracelets_2":0,"chimp_4":10,"age_1":0,"blend_skin":0,"cheeks_2":10,"jaw_1":10,"complexion_1":0,"chimp_2":10,"ears_1":-1,"face_3":10,"face_2":8,"blemishes_2":0,"tshirt_1":214,"sex":0}}]', '[{"name":"Director of police","salary":500,"permissions":[]},{"name":"Chief of police","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"members_menager":true,"get_car":true}},{"name":"Under Sheriff","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Assistant Sheriff","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Area Commander","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Inspector SASP","salary":0,"permissions":{"edit_clothes":true,"withdraw_item":true,"withdraw_money":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Deputy Chief Of Police","salary":0,"permissions":{"deposit_money":true,"withdraw_item":true,"members_menager":true,"get_car":true,"edit_clothes":true}},{"name":"Assistant Chief Of Police","salary":0,"permissions":{"withdraw_item":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"Commander","salary":0,"permissions":{"withdraw_item":true,"deposit_money":true,"get_car":true,"members_menager":true}},{"name":"---------------------","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Capitan II","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Capitan I","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"----------------------","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Lieutenant II","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Lieutenant I","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"-----------------------------","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Sergeant III","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Sergeant II","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Sergeant I","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"------------------------","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Officer III","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Officer II","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Officer I","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}},{"name":"Cadet","salary":0,"permissions":{"deposit_money":true,"get_car":true,"withdraw_item":true}}]', 0, '[{"name":"pistol_ammo","label":"Amunicja do Pistoletu","count":124646},{"name":"mdma","label":"Tabletka MDMA","count":8090},{"name":"vintagepistol","count":1,"label":"Pistolet Vintage"},{"name":"snspistol_mk2","count":3,"label":"Pistolet SNS (MK II)"}]', '{"a8b58534866c3a441c3adbfea287e0e40a4843ef":0,"1f59aebeab9f239f18f828d180b9a019f1a206f7":0,"28d9a37ca6e5ec1e881f1862952c8d082fe298a3":0,"96663953f3c95b7bc192f4329dad9764538a352d":0,"3d8506a5fd8bf329a123c98d0cf24043f6319e00":30,"c9ad8851197f9175c810189183c89d0699ad58e7":40,"93d7e45f444bc7d654e43f01ae0adb873a07feed":0,"cbf6399898c0297e1afa7bcf588dcda10993a64a":0,"25e66cc6bfd009c6ae66a0f02156702f1d90cc87":1760,"ca180c182a648edda6836a649a6b482c97afed29":440,"1b07b7afcba060cf11121f4651acffb4318ca96a":30,"42ea1b257d25d7dfa39b9c6fad24670a8460371f":80,"da2f46103fb913ed3c6fc9dc7ab408d11cedc41d":0,"1df54412ee44e0373bfcd46280abc9b024c84558":0,"a41a5c722ce4625332d8b12c8768cc7ec6283694":840,"9a092c598159f788cf37413a6afb23fd33f21c6c":0,"50a5fa068797456fcf3a6f3e12f23ee50bdd2984":0,"7483950d8c3ced9242527dedceab62cd3a8cad16":0,"33226eeea5450b237adf4ab12df3176516eff707":0,"bcde386691f670d43f46b323cb4369cd7dd44bff":0,"e17fe0b252718e3e7f522c45a8fc703727171b2e":0,"b198c4845d693825e371fe413fab5c0a817590d7":0,"398e41a91c0e629f564f315c4c7137b8f4a46770":0,"010d436bfd3c924ec0fe26fb98005953671bb3b8":0,"6f10b3273d00363d2803cc6ec7fada78fe91fd52":0,"341f9d3f0a03ad8ad182311d8b399864b4f7a1c3":0,"599c368a8b6800cccdcda17e92963d44a2f62201":0,"48e6eb1dd669052878b5c3f64661323526815a9d":0,"95593c932157b5061b66cb717f8f9a79ce5e182c":0,"c70cc150f80453497c7512f4c5262d6cd50aef04":200,"060515975abf3cc5028af5b75f89261ef1d58e5b":2170,"0e8b1e46b15d595fee2aa47f0a871019a0210ff8":480,"7a7121c665202427d94b4d53ce881536e268c4b9":0,"2a3c28943a6b9013117da7a926584b4b85ad6e6c":0,"a0f30b6863324fc857663ea4439831db290bdd36":1570,"a47ddd26c1748551e6812d1a3696f745e9d4de02":290,"28873e1cf79c193c007f404bc115e16a10bc097f":40,"bd1730244a02e5dc485f5c8ac84c898f80fcbabf":0,"4a893296971370395e6c34d55cd053e5c3d3870d":0,"e221002e71f9320ed3bca460d155aadfbc465afa":0,"719a6b517407e14ed24403f4fd88c190a3f3e719":0,"d45d30090de101d0bc16a99249d96aff721da294":0,"a563a6fa0843866252c5d3e1eda73d8e822a5ede":0,"f3a9d4d25027acd8377674c033e63c6081f4f3a4":0,"e4b191ebe63159f8bf6721bd232d259ac017dd33":0,"a8e970c2f49d04da33138ac78f6cdd708f30ca88":0,"9c37597f213cb346e7a4a960f0bfeba204495a55":0,"dce867529af843ec98bab3258ed45c90f7990286":0,"713ffda66bf974758c9d1be5e2b71f3bd0eb877b":550,"20498fcfef1f92d29451089711e061630482d872":2690,"f7b3bbccac295ff27d57e4b03d1f3ffa27b96f24":0,"2d8519c9a04479ec3f4e9938b75060957d53b783":0,"e1c8cb7dda3d0f94691e4f151edab52da0a0935a":0,"2398cb66031f8e81a978d45c19f749aab0169c72":0}', NULL, '{"repairkit":false,"handcuffs":false}', '[]', 0, 0, 0, '[]', NULL, 0, 1, '', 'false'),
	('unemployed', 'Unemployed', 0, '[{"label":"1psgorg","skin":{"chimp_3":10,"nose_6":0,"chain_2":0,"shoes_1":148,"bodyb_4":0,"age_2":0,"bproof_2":0,"blemishes_1":0,"decals_2":0,"eye_color":0,"blend":0,"skin_md_weight":27,"cheeks_3":0,"helmet_1":189,"helmet_2":0,"torso_1":454,"lip_thickness":0,"dad":29,"decals_1":0,"bodyb_2":0,"bags_2":0,"mask_2":13,"shoes_2":0,"chin_2":0,"tshirt_2":0,"nose_1":-5,"jaw_2":0,"chin_1":0,"ears_2":0,"eyebrow_1":10,"cheeks_2":0,"sex":0,"skin_3":0,"jaw_1":0,"pants_1":42,"neck":10,"bodyb_1":-1,"complexion_1":0,"glasses_2":6,"chimp_1":10,"chain_1":182,"tshirt_1":15,"bodyb_3":-1,"chimp_4":10,"sun_1":0,"blend_face":0,"eyebrows_5":0,"watches_2":0,"pants_2":2,"ears_1":-1,"bracelets_1":-1,"eyebrow_2":10,"lips":10,"moles_2":0,"face_3":0,"chin_13":0,"nose_5":10,"mom":43,"face_md_weight":61,"bracelets_2":0,"bproof_1":0,"eyebrows_6":0,"skin":0,"eye_squint":0,"chin_4":0,"glasses_1":25,"sun_2":0,"nose_4":8,"watches_1":-1,"torso_2":3,"age_1":0,"arms":19,"complexion_2":0,"bags_1":145,"nose_3":5,"face_2":0,"cheeks_1":0,"chimp_2":10,"blemishes_2":0,"blend_skin":0,"neck_thickness":0,"arms_2":0,"skin_2":0,"moles_1":0,"nose_2":6,"mask_1":169}}]', '[{"name":"bezrobotny","salary":500,"permissions":[]},null,null,{"id":4,"name":"V-ka","salary":0,"permissions":{"withdraw_item":true,"withdraw_money":true,"members_menager":true,"edit_clothes":true,"bitki_menager":true,"deposit_money":true,"ranks_menager":true,"kits_menager":true,"deposit_item":true}}]', 0, '[]', '{}', NULL, '{"handcuffs":false,"repairkit":false}', '[]', 0, 0, 0, '[]', NULL, 0, 1, '', 'false');

-- Zrzut struktury tabela non.kits
CREATE TABLE IF NOT EXISTS `kits` (
  `identifier` varchar(46) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.kits: ~0 rows (około)

-- Zrzut struktury tabela non.lspdmdt_judgments
CREATE TABLE IF NOT EXISTS `lspdmdt_judgments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `fp` varchar(255) NOT NULL,
  `reason` longtext NOT NULL,
  `fee` int(11) NOT NULL,
  `length` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli non.lspdmdt_judgments: ~0 rows (około)

-- Zrzut struktury tabela non.lspdmdt_kartoteka_notatki
CREATE TABLE IF NOT EXISTS `lspdmdt_kartoteka_notatki` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `notatka` longtext NOT NULL,
  `fp` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli non.lspdmdt_kartoteka_notatki: ~0 rows (około)

-- Zrzut struktury tabela non.lspdmdt_notatki
CREATE TABLE IF NOT EXISTS `lspdmdt_notatki` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `notatka` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli non.lspdmdt_notatki: ~0 rows (około)

-- Zrzut struktury tabela non.lspdmdt_ogloszenia
CREATE TABLE IF NOT EXISTS `lspdmdt_ogloszenia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fp` varchar(255) DEFAULT NULL,
  `ogloszenie` longtext NOT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli non.lspdmdt_ogloszenia: ~0 rows (około)

-- Zrzut struktury tabela non.lspdmdt_poszukiwani
CREATE TABLE IF NOT EXISTS `lspdmdt_poszukiwani` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `fp` varchar(255) NOT NULL,
  `reason` longtext NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli non.lspdmdt_poszukiwani: ~0 rows (około)

-- Zrzut struktury tabela non.lspdmdt_raporty
CREATE TABLE IF NOT EXISTS `lspdmdt_raporty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fp` varchar(255) DEFAULT NULL,
  `raport` longtext NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli non.lspdmdt_raporty: ~0 rows (około)
INSERT INTO `lspdmdt_raporty` (`id`, `fp`, `raport`, `date`) VALUES
	(7, 'kaczynski_jaroslaw', 'dzisiaj bylem sobie na patrolu i jadac na jedno z wezwan zatrzymalem sie obok pewnej kobiety siedzacej na fotelu przy lesie poniewaz wydawalo mi sie ze prosi o pomoc, jak sie potem okazalo ma na imie ola i nie prosila o pomoc ale o 50 dolarow za ktore zrobila mi loda w moim radiowozie, jako ze polyka to nie bylo co sprzatac wiec tapicerka nadal jest jaka byla koniec...', '2025-02-17 19:04:27');

-- Zrzut struktury tabela non.nametags
CREATE TABLE IF NOT EXISTS `nametags` (
  `identifier` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `color` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Zrzucanie danych dla tabeli non.nametags: ~0 rows (około)

-- Zrzut struktury tabela non.non_coins
CREATE TABLE IF NOT EXISTS `non_coins` (
  `identifier` varchar(46) NOT NULL,
  `coins` int(11) NOT NULL DEFAULT 0,
  `points` int(11) NOT NULL DEFAULT 0,
  `freeCase` int(11) DEFAULT NULL,
  `boosterCase` int(11) DEFAULT NULL,
  `usedCodes` longtext NOT NULL DEFAULT '[]',
  `inventory` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.non_coins: ~1 rows (około)
INSERT INTO `non_coins` (`identifier`, `coins`, `points`, `freeCase`, `boosterCase`, `usedCodes`, `inventory`) VALUES
	('9c37597f213cb346e7a4a960f0bfeba204495a55', 500, 0, NULL, NULL, '[]', '[{"chance":50,"price":25,"name":"komoda","count":1,"category":"car","rarity":"blue","img":"https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image60.png","points":15,"title":"Samochód Komoda"},{"chance":13,"price":150,"name":"mdma","count":100,"category":"item","rarity":"purple","img":"https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/R.png","points":25,"title":"Porcja MDMA x100"}]');

-- Zrzut struktury tabela non.non_coins_promocodes
CREATE TABLE IF NOT EXISTS `non_coins_promocodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `usages` int(11) NOT NULL DEFAULT 0,
  `reward` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.non_coins_promocodes: ~64 rows (około)
INSERT INTO `non_coins_promocodes` (`id`, `name`, `usages`, `reward`) VALUES
	(2, 'FERIE', 1, 150),
	(3, 'FERIE', 1, 0),
	(4, 'FERIE', 1, 0),
	(5, 'FERIE', 1, 0),
	(6, 'FERIE', 1, 0),
	(7, 'FERIE', 1, 0),
	(8, 'FERIE', 1, 0),
	(9, 'FERIE', 1, 0),
	(10, 'FERIE', 1, 0),
	(11, 'FERIE', 1, 0),
	(12, 'FERIE', 1, 0),
	(13, 'FERIE', 1, 0),
	(14, 'FERIE', 1, 0),
	(15, 'FERIE', 1, 0),
	(16, 'FERIE', 1, 0),
	(17, 'FERIE', 1, 0),
	(18, 'FERIE', 1, 0),
	(19, 'FERIE', 1, 0),
	(20, 'FERIE', 1, 0),
	(21, 'FERIE', 1, 0),
	(22, 'FERIE', 1, 0),
	(23, 'FERIE', 1, 0),
	(24, 'FERIE', 1, 0),
	(25, 'FERIE', 1, 0),
	(26, 'FERIE', 1, 0),
	(27, 'FERIE', 1, 0),
	(28, 'FERIE', 1, 0),
	(29, 'FERIE', 1, 0),
	(30, 'FERIE', 1, 0),
	(31, 'FERIE', 1, 0),
	(32, 'FERIE', 1, 0),
	(33, 'FERIE', 1, 0),
	(34, 'FERIE', 1, 0),
	(35, 'FERIE', 1, 0),
	(36, 'FERIE', 1, 0),
	(37, 'FERIE', 1, 0),
	(38, 'FERIE', 1, 0),
	(39, 'FERIE', 1, 0),
	(40, 'FERIE', 1, 0),
	(41, 'FERIE', 1, 0),
	(42, 'FERIE', 1, 0),
	(43, 'FERIE', 1, 0),
	(44, 'FERIE', 1, 0),
	(45, 'FERIE', 1, 0),
	(46, 'FERIE', 1, 0),
	(47, 'FERIE', 1, 0),
	(48, 'FERIE', 1, 0),
	(49, 'FERIE', 1, 0),
	(50, 'FERIE', 1, 0),
	(51, 'FERIE', 1, 0),
	(52, 'FERIE', 1, 0),
	(53, 'FERIE', 1, 0),
	(54, 'FERIE', 1, 0),
	(55, 'FERIE', 1, 0),
	(56, 'FERIE', 1, 0),
	(57, 'FERIE', 1, 0),
	(58, 'FERIE', 1, 0),
	(59, 'FERIE', 1, 0),
	(60, 'FERIE', 1, 0),
	(61, 'FERIE', 1, 0),
	(62, 'FERIE', 1, 0),
	(63, 'FERIE', 1, 0),
	(64, 'FERIE', 1, 0),
	(65, 'FERIE', 1, 0);

-- Zrzut struktury tabela non.non_coins_shop
CREATE TABLE IF NOT EXISTS `non_coins_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.non_coins_shop: ~30 rows (około)
INSERT INTO `non_coins_shop` (`id`, `name`, `count`) VALUES
	(1, 'pistol_ammo', 8),
	(3, 'vintagepistol', 6),
	(5, 'money', 22),
	(8, '2022rs3h', 2),
	(10, 'RS6MANSORY', 1),
	(17, 'cash', 1),
	(33, 'pistolammo', 1),
	(34, 'ammopistol', 2),
	(35, 'ammo9', 1),
	(36, 'ammo', 1),
	(42, 'donporro', 1),
	(43, '404_m5off', 1),
	(44, 'combatpdw', 1),
	(45, 'combat_pdw', 1),
	(46, 'snspistol_mk2', 1),
	(49, 'doubleaction', 1),
	(51, 'vc_m3g80streetfighter', 1),
	(52, 'ag_minecraftpig', 1),
	(53, '17mansorypnmr', 1),
	(54, 'assaultrifle', 1),
	(55, 'revolver', 1),
	(56, 'revolvermk2', 1),
	(57, 'revolver_mk2', 1),
	(58, 'microsmg', 1),
	(60, 'm4gt3', 1),
	(61, '404illegal_rs6', 1),
	(62, '404illegal_m2', 1),
	(63, '404illegal_gt3rs', 1),
	(64, '2ncsx7', 1),
	(65, 'voucher', 3);

-- Zrzut struktury tabela non.owned_vehicles
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehProps` longtext NOT NULL,
  `state` varchar(10) NOT NULL,
  `vehicleName` varchar(50) NOT NULL,
  `org` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.owned_vehicles: ~1 rows (około)
INSERT INTO `owned_vehicles` (`id`, `identifier`, `plate`, `vehProps`, `state`, `vehicleName`, `org`) VALUES
	(1, '9c37597f213cb346e7a4a960f0bfeba204495a55', 'TJOK 394', '{"name":"josgtr34","model":"josgtr34","plate":"TJOK 394","bodyHealth":1000.0,"engineHealth":1000.0}', 'in-garage', 'josgtr34', NULL),
	(2, '9c37597f213cb346e7a4a960f0bfeba204495a55', 'EGKB 017', '{"name":"komoda","model":"komoda","plate":"EGKB 017","bodyHealth":1000.0,"engineHealth":1000.0}', 'in-garage', 'komoda', NULL);

-- Zrzut struktury tabela non.ox_doorlock
CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.ox_doorlock: ~15 rows (około)
INSERT INTO `ox_doorlock` (`id`, `name`, `data`) VALUES
	(14, 'wejscie', '{"autolock":30,"state":0,"coords":{"x":434.74786376953127,"y":-981.916748046875,"z":30.83926391601562},"doors":[{"coords":{"x":434.74786376953127,"y":-980.618408203125,"z":30.83926391601562},"heading":270,"model":-1215222675},{"coords":{"x":434.74786376953127,"y":-983.215087890625,"z":30.83926391601562},"heading":270,"model":320433149}],"groups":{"police":0},"maxDistance":2}'),
	(15, 'szef', '{"autolock":30,"state":1,"model":-1320876379,"coords":{"x":446.57281494140627,"y":-980.0105590820313,"z":30.83930206298828},"doors":false,"groups":{"police":0},"heading":180,"maxDistance":2}'),
	(16, 'przebieralnia', '{"autolock":30,"state":1,"model":1557126584,"coords":{"x":450.1041259765625,"y":-985.7384033203125,"z":30.83930206298828},"doors":false,"groups":{"police":0},"heading":90,"maxDistance":2}'),
	(17, 'zejscie', '{"autolock":30,"state":1,"coords":{"x":444.7078552246094,"y":-989.4454345703125,"z":30.83930206298828},"doors":[{"coords":{"x":443.40777587890627,"y":-989.4454345703125,"z":30.83930206298828},"heading":180,"model":185711165},{"coords":{"x":446.0079345703125,"y":-989.4454345703125,"z":30.83930206298828},"heading":0,"model":185711165}],"groups":{"police":0},"maxDistance":2}'),
	(18, 'cele wejscie', '{"autolock":30,"state":1,"model":631614199,"coords":{"x":464.57012939453127,"y":-992.6640625,"z":25.06442642211914},"doors":false,"groups":{"police":0},"heading":0,"maxDistance":2}'),
	(19, 'cele 1', '{"autolock":30,"state":1,"model":631614199,"coords":{"x":461.8065185546875,"y":-994.4085693359375,"z":25.06442642211914},"doors":false,"groups":{"police":0},"heading":270,"maxDistance":2}'),
	(20, 'cele 2', '{"autolock":30,"state":1,"model":631614199,"coords":{"x":461.8064880371094,"y":-997.6583251953125,"z":25.06442642211914},"doors":false,"groups":{"police":0},"heading":90,"maxDistance":2}'),
	(21, 'cele 3', '{"autolock":30,"state":1,"model":631614199,"coords":{"x":461.8065185546875,"y":-1001.301513671875,"z":25.06442642211914},"doors":false,"groups":{"police ":0},"heading":90,"maxDistance":2}'),
	(22, 'tyl', '{"autolock":30,"state":1,"coords":{"x":468.6697692871094,"y":-1014.4520263671875,"z":26.5362319946289},"doors":[{"coords":{"x":469.9678955078125,"y":-1014.4520263671875,"z":26.5362319946289},"heading":180,"model":-2023754432},{"coords":{"x":467.37164306640627,"y":-1014.4520263671875,"z":26.5362319946289},"heading":0,"model":-2023754432}],"groups":{"police":0},"maxDistance":2}'),
	(23, 'gora', '{"autolock":30,"state":1,"model":-340230128,"coords":{"x":464.361328125,"y":-984.6780395507813,"z":43.83443450927734},"doors":false,"groups":{"police":0},"heading":90,"maxDistance":2}'),
	(24, 'bramka', '{"autolock":30,"maxDistance":2,"groups":{"mechanic":0},"doors":false,"heading":250,"coords":{"x":-347.1109313964844,"y":-133.7510986328125,"z":38.6037368774414},"model":-38143579,"state":1}'),
	(25, 'brama 1', '{"maxDistance":2,"groups":{"mechanic":0},"doors":false,"heading":250,"coords":{"x":-355.8075256347656,"y":-134.8779296875,"z":40.00832748413086},"model":718507040,"state":1}'),
	(26, 'brama 2', '{"maxDistance":2,"groups":{"mechanic":0},"doors":false,"heading":250,"coords":{"x":-349.4925231933594,"y":-117.55015563964844,"z":40.01057434082031},"model":718507040,"state":1}'),
	(27, 'bramka 2', '{"model":-38143579,"doors":false,"coords":{"x":-343.4473571777344,"y":-123.6837387084961,"z":38.6037368774414},"state":1,"maxDistance":2,"groups":{"mechanic":0},"heading":70}'),
	(29, 'katakumby', '{"coords":{"x":-323.08831787109377,"y":-104.51521301269531,"z":38.01234817504883},"groups":{"mechanic":0},"state":1,"doors":[{"coords":{"x":-325.6688232421875,"y":-103.57598876953125,"z":38.01234817504883},"model":2134335554,"heading":340},{"coords":{"x":-320.5077819824219,"y":-105.4544448852539,"z":38.01234817504883},"model":758463511,"heading":340}],"maxDistance":5}');

-- Zrzut struktury tabela non.reportsystem
CREATE TABLE IF NOT EXISTS `reportsystem` (
  `license` varchar(255) NOT NULL,
  `discord` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.reportsystem: ~0 rows (około)

-- Zrzut struktury tabela non.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(46) NOT NULL,
  `name` varchar(255) NOT NULL,
  `discordid` varchar(255) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT NULL,
  `reports` int(255) NOT NULL DEFAULT 0,
  `premiumgroup` varchar(50) DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `secondjob` varchar(255) NOT NULL DEFAULT 'unemployed',
  `secondjob_grade` int(11) NOT NULL DEFAULT 0,
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `position` varchar(255) DEFAULT '{"x":-268.6598,"y":-956.7275,"z":31.2231,"heading":197.7355}',
  `skin` longtext DEFAULT NULL,
  `tattoos` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disabled` tinyint(1) DEFAULT 0,
  `last_property` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `last_seen` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `phone_number` int(11) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `weaponcd` varchar(255) DEFAULT NULL,
  `badge` varchar(255) DEFAULT NULL,
  `account_number` varchar(10) DEFAULT NULL,
  `duelaccount` varchar(255) DEFAULT NULL,
  `ranga` varchar(255) NOT NULL DEFAULT 'Brak',
  `received_car` int(11) NOT NULL DEFAULT 0,
  `xp` int(11) NOT NULL DEFAULT 0,
  `rank` int(11) NOT NULL DEFAULT 1,
  `czas_grania` int(255) NOT NULL DEFAULT 0,
  `points` int(11) NOT NULL DEFAULT 0,
  `kills` int(11) DEFAULT 0,
  `deaths` int(11) DEFAULT 0,
  `communityservices` int(255) DEFAULT 0,
  `strefki` int(255) DEFAULT 0,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `index_users_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.users: ~1 rows (około)
INSERT INTO `users` (`identifier`, `name`, `discordid`, `license`, `accounts`, `group`, `reports`, `premiumgroup`, `inventory`, `job`, `secondjob`, `secondjob_grade`, `job_grade`, `loadout`, `position`, `skin`, `tattoos`, `status`, `is_dead`, `id`, `disabled`, `last_property`, `created_at`, `last_seen`, `phone_number`, `pincode`, `weaponcd`, `badge`, `account_number`, `duelaccount`, `ranga`, `received_car`, `xp`, `rank`, `czas_grania`, `points`, `kills`, `deaths`, `communityservices`, `strefki`) VALUES
	('9c37597f213cb346e7a4a960f0bfeba204495a55', '! PaT', NULL, NULL, '{"bank":0,"black_money":0,"money":5000000}', 'user', 0, NULL, '{"pistol_ammo":214,"energydrink":25,"snspistol_mk2":1}', 'unemployed', 'unemployed', 0, 1, '[]', '{"x":1583.4,"heading":0.0,"z":210.2,"y":-315.5}', '{"torso_2":0,"shoes_2":2,"nose_5":10,"torso_1":0,"skin_md_weight":27,"eyebrows_1":0,"skin_3":0,"bags_2":0,"chimp_4":10,"eyebrows_4":0,"neck":10,"chin_1":0,"beard_4":0,"chin_13":0,"decals_1":0,"bodyb_2":0,"glasses_1":0,"beard_2":0,"ears_1":-1,"helmet_1":-1,"nose_1":-5,"eye_color":0,"blush_3":0,"blush_1":0,"bodyb_4":0,"blend":0,"lipstick_4":0,"bags_1":0,"face_2":0,"ears_2":0,"chin_2":0,"dad":29,"blemishes_2":0,"blush_2":0,"chest_2":0,"makeup_2":0,"mask_1":0,"hair_1":0,"shoes_1":149,"mom":43,"arms_2":0,"skin":0,"eyebrows_3":0,"eyebrows_2":0,"moles_1":0,"glasses_2":0,"lipstick_1":0,"watches_1":-1,"lipstick_2":0,"bracelets_2":0,"tshirt_1":15,"cheeks_2":0,"watches_2":0,"chain_1":0,"face":0,"chimp_2":10,"jaw_2":0,"makeup_4":0,"sun_2":0,"chain_2":0,"nose_3":5,"sun_1":0,"hair_color_1":0,"nose_6":0,"chin_4":0,"helmet_2":0,"age_1":0,"makeup_3":0,"blend_skin":0,"chest_3":0,"hair_2":0,"hair_color_2":0,"beard_1":0,"eyebrows_5":0,"chimp_3":10,"sex":0,"cheeks_1":0,"eyebrow_1":10,"hair_3":0,"blemishes_1":0,"cheeks_3":0,"chimp_1":10,"nose_2":6,"eye_squint":0,"jaw_1":0,"pants_2":0,"chest_1":0,"lip_thickness":0,"decals_2":0,"mask_2":0,"eyebrows_6":0,"bproof_1":0,"bodyb_3":-1,"neck_thickness":0,"tshirt_2":0,"complexion_1":0,"lipstick_3":0,"skin_2":0,"age_2":0,"nose_4":8,"eyebrow_2":10,"pants_1":7,"complexion_2":0,"bodyb_1":-1,"makeup_1":0,"lips":10,"face_md_weight":61,"blend_face":0,"moles_2":0,"beard_3":0,"arms":0,"face_3":0,"bproof_2":0,"bracelets_1":-1}', NULL, NULL, 0, 1, 0, NULL, '2025-06-02 16:58:38', '2025-06-02 17:47:45', NULL, NULL, NULL, NULL, NULL, NULL, 'Brak', 0, 0, 1, 0, 0, 0, 0, 0, 0);

-- Zrzut struktury tabela non.user_dressigns
CREATE TABLE IF NOT EXISTS `user_dressigns` (
  `identifier` varchar(46) NOT NULL,
  `dressigns` longtext DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.user_dressigns: ~0 rows (około)

-- Zrzut struktury tabela non.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.vehicles: ~12 rows (około)
INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
	('bmwm3g80', 'bmwm3g80', 150000000, 'Sportowe'),
	('cls63brabus', 'cls63brabus', 125000000, 'Sportowe'),
	('gt86', 'gt86', 20000000, 'Sportowe'),
	('gtr', 'gtr', 40000000, 'Sportowe'),
	('hummer', 'hummer', 25000000, 'Crime'),
	('humvee', 'humvee', 25000000, 'Crime'),
	('m4cs', 'm4cs', 175000000, 'Sportowe'),
	('p1', 'p1', 50000000, 'Crime'),
	('RAPTOR150', 'RAPTOR150', 25000000, 'Crime'),
	('rmodgt63', 'rmodgt63', 50000000, 'Sportowe'),
	('rs5', 'rs5', 30000000, 'Sportowe'),
	('rs6mansory', 'rs6mansory', 100000000, 'Sportowe');

-- Zrzut struktury tabela non.vehicle_categories
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli non.vehicle_categories: ~2 rows (około)
INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
	('Crime', 'Crime'),
	('Sportowe', 'Sportowe');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

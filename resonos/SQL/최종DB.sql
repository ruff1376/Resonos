-- Active: 1751337677491@@127.0.0.1@3306@resonos
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: resonos
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_log`
--

DROP TABLE IF EXISTS `admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(50) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `meta` json DEFAULT NULL,
  `reason` text,
  `description` text,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `created_at` datetime NOT NULL,
  `actor_id` bigint NOT NULL,
  `target_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_admin_log_1` (`actor_id`),
  KEY `FK_user_TO_admin_log_2` (`target_id`),
  CONSTRAINT `FK_user_TO_admin_log_1` FOREIGN KEY (`actor_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_user_TO_admin_log_2` FOREIGN KEY (`target_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_log`
--

/*!40000 ALTER TABLE `admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_log` ENABLE KEYS */;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `id` varchar(200) NOT NULL,
  `title` varchar(100) NOT NULL,
  `cover_image` varchar(200) DEFAULT NULL,
  `release_date` date NOT NULL,
  `genre` varchar(64) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL,
  `description` text,
  `artist_id` varchar(200) NOT NULL,
  `country` char(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_artist_TO_album_1` (`artist_id`),
  CONSTRAINT `FK_artist_TO_album_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES ('014jYCQMhNKWtaXPCqXoHR','담배가게 아가씨','https://i.scdn.co/image/ab67616d0000b273432ad96a3050cf5d8bb92634','2014-02-18',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('0219JhsyibMkftKsI94Mv1','That\'s What I Like (BLVK JVCK Remix)','https://i.scdn.co/image/ab67616d0000b273d48938159fc680e5faa85555','2017-04-18',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('031mrCnL4e0qsf5GQdH6ER','Trust Me (MIDZY)','https://i.scdn.co/image/ab67616d0000b2737403d1086aca8b4848b3238f','2021-03-20',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('04hy4jb1GDD00otiwzsFUB','Echoes Of Silence (Original)','https://i.scdn.co/image/ab67616d0000b27336fb79728dbb379579cef97e','2011-12-21',NULL,'Universal Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('05K5RSyTasOI8cQTFHhTLS','Better Things (Tropkillaz Remix)','https://i.scdn.co/image/ab67616d0000b273a6b1a4f70a5ecb1612b1eae7','2023-09-22',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('06me0leRR3AuF4IFiEytml','Push Ups','https://i.scdn.co/image/ab67616d0000b27384bfd0d363f0179ac7c97fa5','2024-04-19',NULL,'OVO/Republic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('07OCQAUAQaZmKORKt2StFm','Gorilla (feat. R. Kelly And Pharrell) [G-Mix]','https://i.scdn.co/image/ab67616d0000b273a13b695805ff7b0e176f76e8','2013-11-12',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('08ou14V2A0NWpvq7QkUWbM','\'BLACKPINK 2018 TOUR \'IN YOUR AREA\' SEOUL - Live','https://i.scdn.co/image/ab67616d0000b273df1580ff05c0fb1b0cd23e1a','2019-08-30',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('0bNfrGST1xSPZ3V3g5jjHT','What Did I Miss?','https://i.scdn.co/image/ab67616d0000b2739d22b70fe52340efb60ab681','2025-07-05',NULL,'OVO/Republic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('0bWcrwRhhxMaweFaBA8G1S','The Breeze Of Sea','https://i.scdn.co/image/ab67616d0000b27364a3d3330efb392beae949aa','2007-01-29',NULL,'아이에스뮤직스',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('0cLXqY56lwJjG7QNG2mzu7','Wake Me Up','https://i.scdn.co/image/ab67616d0000b2737ed15a8f5dc0060a449527a7','2025-01-29',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('0Ct52rooGyvjv6qXrBPNzm','Double Fantasy','https://i.scdn.co/image/ab67616d0000b273c7d6fe09dfe4af1580e59705','2023-04-21',NULL,'Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('0CYZzTggBObmmQQvl2XqU8','Like Magic','https://i.scdn.co/image/ab67616d0000b273d8583bf72028891202fe3f98','2023-02-20',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('0e9GAAJT7lX5C6RTZsCCDR','No Biggie','https://i.scdn.co/image/ab67616d0000b2736fb1a344e6f54f4e120fab05','2024-05-01',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('0EhZEM4RRz0yioTgucDhJq','How Sweet','https://i.scdn.co/image/ab67616d0000b273b657fbb27b17e7bd4691c2b2','2024-05-24',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('0FOOodYRlj7gzh7q7IjmNZ','SQUARE ONE','https://i.scdn.co/image/ab67616d0000b273ff4ec21d7817138cabcc19bc','2016-08-08',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('0FWdxPnncm63s91g0PkTvv','Timeless (Remix)','https://i.scdn.co/image/ab67616d0000b273245aa43805ea59914d8f59ee','2025-05-09',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('0ifQBUhPyd0KvlBmhGVVL0','RINGO','https://i.scdn.co/image/ab67616d0000b273053c7744182de2ff2a626b09','2023-09-27',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('0jiAYLsE1PumLJncO7vUIl','K-POP (Chopped & Screwed)','https://i.scdn.co/image/ab67616d0000b273dd8912dfae6121b0e25bcaec','2023-07-18',NULL,'Cactus Jack/Epic',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('0JQtZGkMyVK5SAAJlw4Qgt','창문너머 어렴풋이 옛 생각이 나겠지요 [From \"히말라야 스페셜 리메이크\"]','https://i.scdn.co/image/ab67616d0000b273775ae6c9b5a158ff616548e1','2015-12-18',NULL,'CJ E&M',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('0jXtQE6F6FYFLPx0S3Gp1D','Better Things (Sped Up + Slowed Down)','https://i.scdn.co/image/ab67616d0000b27375236d43c55ff3b5802a9215','2023-09-08',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('0MwPArEeQJx5GMc5Sz7kRV','Dancing In The Flames','https://i.scdn.co/image/ab67616d0000b273fd5cc07a72dda206535bcf9f','2024-09-13',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('0nhyyhprFn6lcIAzTpmFDo','Lovesick Girls (JP Ver.)','https://i.scdn.co/image/ab67616d0000b273157030e2a5235c649af7284d','2021-07-13',NULL,'Universal Music LLC',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('0oEsQwXJhNbbb8VT0xOMok','STAYING ALIVE (feat. Drake & Lil Baby)','https://i.scdn.co/image/ab67616d0000b273b690b30a50c94c6da49ba948','2022-08-05',NULL,'Epic/We The Best',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('0p0FGxiCrl3afABenvtWbQ','Popular','https://i.scdn.co/image/ab67616d0000b273f53930e3203b69952b4c5920','2024-01-26',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('0P3oVJBFOv3TDXlYRhGL7s','Beauty Behind The Madness','https://i.scdn.co/image/ab67616d0000b2737fcead687e99583072cc217b','2015-08-28',NULL,'Universal Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('0pjhLqD8bXav2eXgbnvzHE','꿈을 뺏고 있는 범인을 찾아라','https://i.scdn.co/image/ab67616d0000b2732cc4c9ca6a9ecd0329cf31d6','2011-11-20',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('0ptlfJfwGTy0Yvrk14JK1I','If You\'re Reading This It\'s Too Late','https://i.scdn.co/image/ab67616d0000b2732090f4f6cc406e6d3c306733','2015-02-12',NULL,'Cash Money Records/Young Money Ent./Universal Rec.',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('0qGdc7fNq9RNIPEzZufa43','Laugh Now Cry Later (feat. Lil Durk)','https://i.scdn.co/image/ab67616d0000b27352c75ed37313b889447011ef','2020-08-14',NULL,'OVO',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('0rAaP1OBxVCn2cIUZNjGRs','GODS','https://i.scdn.co/image/ab67616d0000b273e4179b3fb74beaf0cdfa7a13','2023-10-04',NULL,'Riot Games',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('0S4pP8MBY9p7ngFWIZQAJv','BORN PINK','https://i.scdn.co/image/ab67616d0000b273580ac3ad7dfc81e509171120','2022-09-16',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('0SbnkLLiTqVmoPmhY80s7S','Blah Blah Blah','https://i.scdn.co/image/ab67616d0000b273e8c488b71dfca2ef41f74d94','2022-10-05',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('0ssxpVNMYMHeKXV00VUCkJ','Sound of Winter','https://i.scdn.co/image/ab67616d0000b2739623798781eb5035f809a71f','2018-01-01',NULL,'HERBIGHARO',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('0sye9Q82C9Q4tTJN8b0aFq','Moth To A Flame','https://i.scdn.co/image/ab67616d0000b273b1d146bde876bf560eb1a089','2022-01-04',NULL,'Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('0t98iMat2EXJthAhr844Sx','CHECKMATE','https://i.scdn.co/image/ab67616d0000b273cb33130d5685061451fee97e','2022-07-15',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('0uWttVLwkFxcW1PkBAsmZd','KILL THIS LOVE (JP Ver.)','https://i.scdn.co/image/ab67616d0000b2739dd7b15113e3d73005713d03','2019-10-16',NULL,'Universal Music LLC',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('0Vz32hcNoqOZIpJVI0qExN','Dawn FM (OPN Remix)','https://i.scdn.co/image/ab67616d0000b2732756fcc016298cf16ccf6020','2022-07-08',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('0XgLshUzeE1QsmAKUyqZSc','[YB] Stream','https://i.scdn.co/image/ab67616d0000b27389d719bf16154b81215d2634','2010-01-01',NULL,'Universal Music Ltd.',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('0xjql3TEYd34hlAky4Ck2z','On The Radar Freestyle','https://i.scdn.co/image/ab67616d0000b2737f028c5cb134c02ee497eaf6','2023-07-26',NULL,'OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('0yDiMZdbFwO5lGB9Dq5wlL','Versace On The Floor (Bruno Mars vs. David Guetta)','https://i.scdn.co/image/ab67616d0000b27362dc1f2be95dc25beea9f857','2017-06-27',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('0YF085Qdh4HgdhZ8zjWkpo','Die For You','https://i.scdn.co/image/ab67616d0000b2738b5a9e7c56f01bec356de9d5','2023-02-27',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('10eNMeTimUzAKLhCOpIUlb','K-POP','https://i.scdn.co/image/ab67616d0000b273893489768de0c42b4d217b82','2023-07-21',NULL,'Cactus Jack/Epic',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('10SppFk45za4CHPEiiuQaD','The Idol Episode 5 Part 2 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b27338b9ba68af98c3c0855b47ee','2023-07-03',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('11lLYKMkFheiV7ObD7WCnx','Life\'s Too Short','https://i.scdn.co/image/ab67616d0000b273eb9bc74e6ced59a2638898b0','2022-06-24',NULL,'Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('12INlMsFtBjyehNnawBv36','Dawn FM (Alternate World)','https://i.scdn.co/image/ab67616d0000b273ade87e5f9c3764f0a1e5df64','2022-01-07',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('14JkAa6IiFaOh5s0nMyMU9','KPop Demon Hunters (Soundtrack from the Netflix Film)','https://i.scdn.co/image/ab67616d0000b2734dcb6c5df15cf74596ab25a4','2025-06-20',NULL,'K-Pop Demon Hunters',NULL,'2yNNYQBChuox9A5Ka93BIn',NULL),('15b9JCsZh7DkbA2EjBjPqc','Enjoy The Show','https://i.scdn.co/image/ab67616d0000b273c194d06cc0fd9a567e5a0b77','2025-01-29',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('17cYF29ZBcDYoRkWUzFWfQ','Moth To A Flame (Moojo Remix)','https://i.scdn.co/image/ab67616d0000b27366858daca33990b506aa62d0','2022-01-04',NULL,'Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('181WKxuhHzTyjMcYdI7UUe','How Do I Make You Love Me? (Sebastian Ingrosso & Salvatore Ganacci Remix)','https://i.scdn.co/image/ab67616d0000b27314cf4f2a3a808b716604d115','2022-07-22',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('19vSttgdhH7PoAbvXBY7VT','How You Like That','https://i.scdn.co/image/ab67616d0000b27357f5bb0f7a90c35a4bcbb727','2020-06-25',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('1ATL5GLyefJaxhQzSPVrLX','Scorpion','https://i.scdn.co/image/ab67616d0000b273f907de96b9a4fbc04accc0d5','2018-06-29',NULL,'Cash Money/Drake LP6',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('1atx6ADNPFNf3PKvBiSa6l','Strong Girl Nam-soon (Original Television Soundtrack), Pt.1','https://i.scdn.co/image/ab67616d0000b273a017b63185eb982fb2a795b1','2023-10-08',NULL,'MOST CONTENTS',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('1bV9UJSiCQOg5S786s2T9g','Dirty Work (Remixes)','https://i.scdn.co/image/ab67616d0000b2737564c89f5400489c156aabb7','2025-06-30',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('1dTqdCHDqUk9hbSsQOIxl0','Sugar-holic','https://i.scdn.co/image/ab67616d0000b273ff14cf0246532443589f5559','2023-10-11',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('1e5ELECrQq5yoquPwoXzkd','Winter Ahead (with PARK HYO SHIN) : YUNSEOKCHEOL TRIO Ver.','https://i.scdn.co/image/ab67616d0000b2737943ad19707eee754abdb693','2024-12-20',NULL,'BIGHIT MUSIC',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('1FVw30SoC91lq1UZ6N9rwN','Supernatural','https://i.scdn.co/image/ab67616d0000b2737e1eeb0d7cc374a168369c80','2024-06-21',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('1gIckYyr6GfiJJ2BtpDZXR','Fat Juicy &... (Radio Edit)','https://i.scdn.co/image/ab67616d0000b27392daae97859d04fff466ee18','2025-01-16',NULL,'gamma. / Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('1h3aXRHMtuiUTnEymDWKGo','Heukseok-dong 〈Sanullim\'s 50th Anniversary Collaboration Album〉','https://i.scdn.co/image/ab67616d0000b273a4ac5e86b6b0a46c167fb30f','2025-07-09',NULL,'Genie Music Corporation, Stone Music Entertainment',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('1HMLpmZAnNyl9pxvOnTovV','NewJeans 1st EP \'New Jeans\'','https://i.scdn.co/image/ab67616d0000b2739d28fd01859073a3ae6ea209','2022-08-01',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('1JirxaiYwz8hAxAk38rkeH','The Grenade Remixes','https://i.scdn.co/image/ab67616d0000b27333a2e5a15938f68786a0ea7c','2011-03-01',NULL,'Elektra (NEK)',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('1K3oVG8AwSSs66wACKd95b','Treasure Remix EP','https://i.scdn.co/image/ab67616d0000b273b7ecc33314c16f804aba6435','2013-08-12',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('1LShhEEKRT5MNPcO7jtYHh','So Far Gone','https://i.scdn.co/image/ab67616d0000b27354ef13c30a024a7f1ba79efd','2009-01-01',NULL,'Young Money/Cash Money Records',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('1lXY618HWkwYKJWBRYR4MK','More Life','https://i.scdn.co/image/ab67616d0000b2734f0fd9dad63977146e685700','2017-03-18',NULL,'Cash Money Records/Young Money Ent./Universal Rec.',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('1NCgEqPlo1t2jCvmjpyiqD','Twilight State','https://i.scdn.co/image/ab67616d0000b27365b107de98bb5e122378242c','2019-10-10',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('1OARrXe5sB0gyy3MhQ8h92','Live At SoFi Stadium','https://i.scdn.co/image/ab67616d0000b273308f9319a3d6f6737f43b3fc','2023-03-03',NULL,'Universal Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('1oJztb2MfwieRwHZ1t4NrN','Dirty Work','https://i.scdn.co/image/ab67616d0000b273bf35cc79c5b22b1c19065272','2025-06-27',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('1oniugll0x2gZ3l7o4z9iG','Beautiful Christmas','https://i.scdn.co/image/ab67616d0000b273d3f431dc2bee60eac129a8ba','2022-12-14',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('1onK6XeDccA2NW6SlzQMNK','24K Magic (R3hab Remix)','https://i.scdn.co/image/ab67616d0000b2734a444edc610388167c9dd1b9','2017-05-26',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('1ozpmkWcCHwsQ4QTnxOOdT','What A Time To Be Alive','https://i.scdn.co/image/ab67616d0000b273d6adfbd3f091d6f2b9af6507','2015-09-20',NULL,'Cash Money Records Inc.',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('1Pk1W5xbmAqG6wBNL4sjq5','Be Who You Are (Real Magic)','https://i.scdn.co/image/ab67616d0000b273a1214ad1ca57685349932cea','2023-05-31',NULL,'JB Be Who You Are w/Coke',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('1QpbqEgoFTEgqur3Odrcqc','Over The Top (feat. Drake)','https://i.scdn.co/image/ab67616d0000b273582d61f1e2bc5769e94ddc28','2021-07-23',NULL,'OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('1SHLOv0DDdRecK60z86Lth','Better Things','https://i.scdn.co/image/ab67616d0000b273c2bcf77ad1fe40f6c7b88609','2023-08-18',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('1V8uYmO4nGulH3YnSbBbWZ','The New Star (Digital Single)','https://i.scdn.co/image/ab67616d0000b27328684d6d7453208f08b6b8a8','2010-09-13',NULL,'JELLYFISH ENTERTAINMENT',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('1XEhQ2S7OHDa9Zm635Jyww','Stay Alive (B.K Remix)','https://i.scdn.co/image/ab67616d0000b273e4fdaf94fee904f9c695825b','2018-11-28',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('1XslIirSxfAhhxRdn4Li9t','Nothing Was The Same','https://i.scdn.co/image/ab67616d0000b273a90d170c61fb7d063d47161d','2013-01-01',NULL,'Cash Money Records/Young Money Ent./Universal Rec.',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('1y2OfMwyaRDmtbQNl0DnQa','Fat Juicy & Wet','https://i.scdn.co/image/ab67616d0000b27382097ce9e19cee164a8d8a9e','2025-01-24',NULL,'gamma. / Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('1YItIfS2HNJkWIgaoj50SM','Dark Arts','https://i.scdn.co/image/ab67616d0000b273ec607ab359aa2071ae805c21','2025-07-15',NULL,'SM Entertainment, PUBG: BATTLEGROUNDS',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('1YsrB8P1PfVxuY9HeD7lkN','CRAZY IN LOVE','https://i.scdn.co/image/ab67616d0000b273bdcef415fe998484f8050081','2021-09-24',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('1z4Zl2hcCiRyB4uIPeqEfr','That\'s What I Like (feat. Gucci Mane) [Remix]','https://i.scdn.co/image/ab67616d0000b273b5595f8eddba5334f694bce6','2017-04-21',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('20NFMkVsRGm7WpID420oTQ','Reel Impulse','https://i.scdn.co/image/ab67616d0000b273b7a6644226cc87ffe691dfc9','2013-06-25',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('21NNancB4Bdre5c5VRnbHk','ITZY Taiwan Live Experience Set Playlist Assets','https://i.scdn.co/image/ab67616d0000b273b1d4117f349d3679ac4b6975','2024-07-26',NULL,'Spotify',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('26KTR4BV6sZ7jh0BxO3zIj','Neo Classicism','https://i.scdn.co/image/ab67616d0000b273c1a3abf5511964b5be00b9b0','2005-06-02',NULL,'아이에스뮤직스',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('29uwnLOApt6HvRw3Ll83vG','Die With A Smile','https://i.scdn.co/image/ab67616d0000b2733fbf8c62688f7c4002188101','2024-10-17',NULL,'Interscope',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('2AgHdKsWib9wJJjQ1ohVHS','Can\'t Leave You Alone','https://i.scdn.co/image/ab67616d0000b2730ab1d68afd80186d4f5146e4','2025-03-27',NULL,'Royal Music Group LLC',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('2CzbrboOLzeRoaaH1N5K0N','Next Level','https://i.scdn.co/image/ab67616d0000b2737a393b04e8ced571618223e8','2021-05-17',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('2dXi7YAiDy1IVruIAu5tH8','강승원 1집 만들기 프로젝트 Part 2 : 오늘도 어제 같','https://i.scdn.co/image/ab67616d0000b273c5ed1928114d4564790eed82','2014-07-31',NULL,'A&G',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('2Fna4Tb7fme5aHsNMJtVtp','SQUARE TWO','https://i.scdn.co/image/ab67616d0000b27318a4a215052e9f396864bd73','2016-11-01',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('2gNPnKP1PDkB5SZz3IMKuX','THE ALBUM','https://i.scdn.co/image/ab67616d0000b2731895052324f123becdd0d53d','2020-10-02',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('2hBmWglh3PlaUzTrzP1meY','Sad But True','https://i.scdn.co/image/ab67616d0000b2736d24680234cf4703157f907d','2021-09-10',NULL,'Blackened Recordings / Universal Music',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('2jchmY4qmN4Zsp1L3cSFIA','The Other Day','https://i.scdn.co/image/ab67616d0000b273ea4ba0f07975198dbbfd79eb','2018-04-30',NULL,'Glove Entertainment',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('2jK7H4A5Y2xJaoOyzBedaS','iScreaM Vol.18 : Girls Remixes','https://i.scdn.co/image/ab67616d0000b2730d1cda2195c32c0b6d36ed0f','2022-10-21',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('2KnWel482zu05nLvSqNEzI','Gift (Part.2)','https://i.scdn.co/image/ab67616d0000b2733212f9f2a891c4f28ab4b9fb','2010-12-13',NULL,'JELLYFISH ENTERTAINMENT',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('2L5mYNO7vicA2geMVVY7QN','JUMP','https://i.scdn.co/image/ab67616d0000b27374c923a5320cb6be10f6abd8','2025-07-11',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('2lzV5TIBiLED8eCjwsGBIv','MELTDOWN (feat. Drake) [Instrumental]','https://i.scdn.co/image/ab67616d0000b2736a541ea818dc7cbf6d534f98','2023-07-25',NULL,'Cactus Jack/Epic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('2m4QXzB2MdqvFNnpPx4YnQ','Time-Honored Voice','https://i.scdn.co/image/ab67616d0000b273c0ded1afec6f5b8b5178e7b1','2002-09-13',NULL,'Beyond Music',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('2nLOHgzXzwFEpl62zAgCEC','Dawn FM','https://i.scdn.co/image/ab67616d0000b2734ab2520c2c77a1d66b9ee21d','2022-01-06',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('2nT4Iz2CKZNpHE4E9tEFwD','MARRY HIM IF YOU DARE OST Part 4','https://i.scdn.co/image/ab67616d0000b27360f4cfb7df2d29d60f536508','2013-11-12',NULL,'FNC ENTERTAINMENT',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('2o35lokKrBVG73xWFDEVsX','Welcome To MY World (feat. nævis)','https://i.scdn.co/image/ab67616d0000b273220771be23654c95cf787349','2023-05-02',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('2ODvWsOgouMbaA5xf0RkJe','Starboy','https://i.scdn.co/image/ab67616d0000b2734718e2b124f79258be7bc452','2016-11-25',NULL,'Universal Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('2Ov7bn3HyDgvAxtYPLosUR','Die Trying','https://i.scdn.co/image/ab67616d0000b27311c27127b91e1e4266152362','2024-04-04',NULL,'Netflix Music',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('2P8trIADhHx8fJAdC7ud40','Better Things (Dance Remix)','https://i.scdn.co/image/ab67616d0000b273912ace777590a8b0bf419ecc','2023-10-27',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('2q4uMcogIfSvbjZevQTIDL','Golden (from the Netflix film KPop Demon Hunters)','https://i.scdn.co/image/ab67616d0000b273333392a83a4514ae635ed982','2025-06-19',NULL,'K-Pop Demon Hunters',NULL,'2yNNYQBChuox9A5Ka93BIn',NULL),('2qIw3nzBegLwRZYj0sGnkS','Trust Me (MIDZY) -Japanese ver.-','https://i.scdn.co/image/ab67616d0000b27338f9f09f774bde3049c9ed4f','2023-08-30',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('2rTc5TdRP7hr7gE4h4lUR1','Pokémon 2023 (Original TV Series Soundtrack, Korea)','https://i.scdn.co/image/ab67616d0000b2739652d22bb039c408990dcc7b','2023-08-23',NULL,'㈜포켓몬코리아',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('2rwRvLdjGzjSYl9AS3UbvH','Girls - The 2nd Mini Album','https://i.scdn.co/image/ab67616d0000b273ea957604eae136d0681ceaff','2022-07-08',NULL,'Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('2tj99zihwANHtqmEC2QpCn','IT\'z ICY','https://i.scdn.co/image/ab67616d0000b2731227366b152d2cc9855bc4e1','2019-07-29',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('2u0QU6DP2HL5t9cp04vzBT','Voltage','https://i.scdn.co/image/ab67616d0000b27315c62870c5ba84e52eed47ed','2022-04-06',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('2vA3dDRHJtEeThXAlf1L8z','Die With A Smile (Live in Las Vegas)','https://i.scdn.co/image/ab67616d0000b27336881c811ce9fd57f71706f8','2024-10-17',NULL,'Interscope',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('2vf1K6KumbRZnRHa1JeKyD','Locked out of Heaven (Remix)','https://i.scdn.co/image/ab67616d0000b273374ea1730985555f1b1f6328','2013-01-21',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('2wA8OXIv1JXX9kTY2ddfR4','REMIND','https://i.scdn.co/image/ab67616d0000b2739892b860923495dbd27c1aab','2016-10-26',NULL,'디컴퍼니',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('2wEGWJx63eWqMBIudI3LsZ','Never give up, Pt. 1 (Original Soundtrack)','https://i.scdn.co/image/ab67616d0000b273e9526a230855790e9e3294b8','2022-05-05',NULL,'NEW ERA PROJECT',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('2xclonI4faQWl6lhqecGM5','That\'s What I Like (PARTYNEXTDOOR Remix)','https://i.scdn.co/image/ab67616d0000b273a3c2532b1d1dfbeb71314a80','2017-04-18',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('2XGEyGU76kj55OdHWynX0S','Trilogy','https://i.scdn.co/image/ab67616d0000b273158c84a1b6f8b935dc7fa9a9','2012-11-13',NULL,'Universal Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('2XHxh8kzvY06Nf79fhyeQ3','정글의 법칙','https://i.scdn.co/image/ab67616d0000b273ae29ed70f8a82906c86bbb79','2012-05-07',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('2xnqikpcvH2vBYc89VnwwL','Another One Of Me (feat. 21 Savage)','https://i.scdn.co/image/ab67616d0000b273ade39d626a4c337679cf8959','2023-09-15',NULL,'Love Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('2yupj6Bwjo1m6Jew5uscif','Coexistence','https://i.scdn.co/image/ab67616d0000b2732d0eba25cda6785128b33c97','2010-01-01',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('2YVpqON0I1KS8LjQLqV0uH','YB vs RRM','https://i.scdn.co/image/ab67616d0000b2733e791094261a0b17408292e5','2010-07-20',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('2ZUFSbIkmFkGag000RWOpA','Nothing Was The Same (Deluxe)','https://i.scdn.co/image/ab67616d0000b273adfb5909ec66db5fbb4d06c8','2013-01-01',NULL,'Cash Money Records/Young Money Ent./Universal Rec.',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('2zYcjcNUzcgMntymoukwZR','Zero','https://i.scdn.co/image/ab67616d0000b2732e31a8a740f621473d21dc75','2023-04-03',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('31chdu7JhVd0sC9X7sURNb','NewJeans X MY DEMON','https://i.scdn.co/image/ab67616d0000b2732509e504c96367276ca6d1dd','2023-11-24',NULL,'SBS Contents Hub Co., Ltd.',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('35dut3ICqF3NEDkjxfzJJ1','Starboy (Deluxe)','https://i.scdn.co/image/ab67616d0000b2738ad8f5243d6534e03b656c8b','2023-03-14',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('36cJnr7GCuGbuw0YQpjmTY','iScreaM Vol.10 : Next Level Remixes','https://i.scdn.co/image/ab67616d0000b2738bcda1592f94261aaa7c9fe0','2021-09-14',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('379aiwnVtBtkphDqU2qFIg','BORN TO BE','https://i.scdn.co/image/ab67616d0000b27398bef2ab8c03317970df3994','2024-01-08',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('39ezXXrm2nHqhuErFyPAsO','Shine Your Light','https://i.scdn.co/image/ab67616d0000b2733293b6324f3b9dd8f1ca689c','2015-04-06',NULL,'JELLYFISH ENTERTAINMENT',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('3BQuktwdgPu30k6QSUslCr','Die With A Smile (Main + Instrumental)','https://i.scdn.co/image/ab67616d0000b2736f920735d70e4869328f1fa2','2024-10-16',NULL,'Interscope',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('3bXzKLtI7059uh33uiL9GD','GOLD (English Ver.)','https://i.scdn.co/image/ab67616d0000b2731b23980c880675a34ea22859','2024-10-25',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('3CExk4WgPxe0lOwoOhuMWj','Forever (약속)','https://i.scdn.co/image/ab67616d0000b2737fdc50db3e3b281109f5a831','2021-02-05',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('3cf4iSSKd8ffTncbtKljXw','Honestly, Nevermind','https://i.scdn.co/image/ab67616d0000b2738dc0d801766a5aa6a33cbe37','2022-06-17',NULL,'OVO',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('3CHCm9n05a3tG4cQJ4rJwq','For All The Dogs Scary Hours Edition (Instrumental)','https://i.scdn.co/image/ab67616d0000b2731d6afa81a70dc075a7a3dfa9','2023-11-16',NULL,'OVO/Republic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('3cjssumQEsRatYlYG5K86T','2018 YB Live in Pyongyang','https://i.scdn.co/image/ab67616d0000b2731107187bae170973f5ade656','2018-04-24',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('3frr94sbeGqX7kCBgxOa7L','Fat Juicy & Wet','https://i.scdn.co/image/ab67616d0000b27301c87607599f47f70ff71bee','2025-01-23',NULL,'gamma. / Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('3gHhPm8z8tid1kvpniUKuK','Armageddon - The 1st Album','https://i.scdn.co/image/ab67616d0000b2730fc598038040859794c600e2','2024-05-27',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('3hhDpPtCFuQbppwYgsVhMO','Kiss Land','https://i.scdn.co/image/ab67616d0000b273e4860d5331509e2c9ee4de10','2013-09-10',NULL,'CP Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('3KJrNl6UCBBXF7f4Fu14fG','Ice Cream (with Selena Gomez)','https://i.scdn.co/image/ab67616d0000b2737af53cc2d4a7068b49c165bc','2020-08-28',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('3l1V6pEtFQLpbfAyfrSWhW','BLACKPINK 2021 \'THE SHOW\' LIVE','https://i.scdn.co/image/ab67616d0000b273273773a63f11a55524203ad9','2021-06-01',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('3O6ywzP5LE5msmuBBTpaIN','GREECE (feat. Drake)','https://i.scdn.co/image/ab67616d0000b2737db0d21fc5696a3fcedfb933','2020-07-16',NULL,'OVO/We The Best/Epic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('3OaW4df1SA62k0arNpn6bK','Whiplash - The 5th Mini Album','https://i.scdn.co/image/ab67616d0000b273e467a8e8d7b0aa92d354aa75','2024-10-21',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('3OxfaVgvTxUTy7276t7SPU','Hurry Up Tomorrow','https://i.scdn.co/image/ab67616d0000b273982320da137d0de34410df61','2025-01-31',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('3OzSEoUPp5sNGtzXftotKm','Break Ice','https://i.scdn.co/image/ab67616d0000b273116a2104cc3af7cbab902f84','2021-07-01',NULL,'Genie Music Corporation, Stone Music Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('3P2UkOkqWp8ucd1EOnVAH7','Creepin\' (Remix)','https://i.scdn.co/image/ab67616d0000b273bd7aa72e76037ccd81e21a13','2023-03-17',NULL,'Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('3PJbTq65fNFTzXt26YEp0p','GOLD','https://i.scdn.co/image/ab67616d0000b273fde9edcf5d8de459ddacce11','2024-10-15',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('3PNXlS9tggXmCm1hrlHDcQ','Taxidriver OST Part.1','https://i.scdn.co/image/ab67616d0000b2732ced1760b648799e697e8e02','2021-04-16',NULL,'SBS Contents Hub Co., Ltd., Music Recipe',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('3pp3XBxtrrNDi2kcS6mdao','RINGO','https://i.scdn.co/image/ab67616d0000b273a6dced9d8585ecae1724996a','2023-10-18',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('3qw2vm3uqKT3EIg95wbg83','Kill This Love','https://i.scdn.co/image/ab67616d0000b2732d602ab2d4acff0c2cf57683','2019-04-05',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('3qwCuSISrIUpyt6sB5edmQ','Family Matters','https://i.scdn.co/image/ab67616d0000b273a0ac23f4b446a7264e67bf0e','2024-05-03',NULL,'OVO/Republic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('3SpBlxme9WbeQdI9kx7KAV','Certified Lover Boy','https://i.scdn.co/image/ab67616d0000b273cd945b4e3de57edd28481a3f','2021-09-03',NULL,'OVO',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('3syEYrKIsgxaZMB5t1dVG7','Black Mamba','https://i.scdn.co/image/ab67616d0000b2736f248f7695eb544a3a1955c5','2020-11-17',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('3ukWjsUrP70en9dcpt01Hs','Better Things (RAYE Remix)','https://i.scdn.co/image/ab67616d0000b27375da471a6fd8923ccf9be980','2023-09-29',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('3V7QIawybrAdBFNgS4ba6X','Second Story','https://i.scdn.co/image/ab67616d0000b2730c1a79a72168d975a52d59ec','2001-02-01',NULL,'Beyond Music',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('3vyyDkvYWC36DwgZCYd3Wu','Savage - The 1st Mini Album','https://i.scdn.co/image/ab67616d0000b273d8cc2281fcd4519ca020926b','2021-10-05',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('3wtbBSjOhKOw7UdngHEDiO','Hwang Project Vol.1 (Welcome To The Fantastic World)','https://i.scdn.co/image/ab67616d0000b2733736060cbdf800cf314d4d2f','2008-11-20',NULL,'JELLYFISH ENTERTAINMENT',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('3X801hUAmbUAHmatvmMhfA','Versace on the Floor','https://i.scdn.co/image/ab67616d0000b273c903a07b07abc204765d761c','2016-11-04',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('3xIwVbGJuAcovYIhzbLO3J','Toosie Slide','https://i.scdn.co/image/ab67616d0000b2736443676b54522a86f6323e65','2020-04-03',NULL,'OVO',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('40GMAhriYJRO1rsY4YdrZb','Views','https://i.scdn.co/image/ab67616d0000b2739416ed64daf84936d89e671c','2016-05-06',NULL,'Cash Money Records/Young Money Ent./Universal Rec.',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('42sfDq59SJCXfzBduOJlzA','Park Hyo Shin Best (Voice=2003-1999)','https://i.scdn.co/image/ab67616d0000b2736d21a5346c4c26a422ddb83e','2003-10-30',NULL,'Beyond Music',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('45K2dXJLXF4ItsTdEmbQzO','Just the Way You Are (Skrillex BatBoi Remix)','https://i.scdn.co/image/ab67616d0000b273680ee3cfb6a705ddfd5dac8a','2010-12-06',NULL,'Elektra Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('45ozep8uHHnj5CCittuyXj','NewJeans \'OMG\'','https://i.scdn.co/image/ab67616d0000b273d70036292d54f29e8b68ec01','2023-01-02',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('45wwQll1Ay4A1Rz79wWuNt','Zero (J.I.D Remix)','https://i.scdn.co/image/ab67616d0000b27366daf96fd3f1a920cd2053e6','2023-06-20',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('49avguRc9qHbWv5Gjmj4nQ','Bonde do Brunão','https://i.scdn.co/image/ab67616d0000b273613f87e023e5c44ad32b8263','2024-10-15',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('4A0vJtV9ok7vmr9ursSKj8','It Will Rain','https://i.scdn.co/image/ab67616d0000b273dec2e6bae5062b94fc4eeb84','2011-09-28',NULL,'Elektra (NEK)',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('4a8uxN5j5ZSWuioZ9cHqWk','Best Friends (Remix)','https://i.scdn.co/image/ab67616d0000b2735c1ecd80ec5f25b556052431','2022-08-05',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('4aLnzOsnBf5gqTDMJn3XLz','Wild Flower','https://i.scdn.co/image/ab67616d0000b2737645cbd0f9fefff1771ea50c','2014-03-28',NULL,'JELLYFISH ENTERTAINMENT',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('4bWGRs1SqNwFXaRDXRAANN','Hold On Tight','https://i.scdn.co/image/ab67616d0000b273fe31201bbc019b1636066dc3','2023-03-30',NULL,'Parlophone UK',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('4bXChblbwpUdYMI3hEu5IF','해줄 수 없는 일','https://i.scdn.co/image/ab67616d0000b273108107ef8ff1cc74a8ddde0d','2000-01-24',NULL,'Beyond Music',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('4CoKhy1Ew4kb4kgonvnMXy','You Never Know (JP Ver.)','https://i.scdn.co/image/ab67616d0000b27329b0e2247c443a608d894a2d','2021-08-03',NULL,'Universal Music LLC',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('4czdORdCWP9umpbhFXK2fW','For All The Dogs','https://i.scdn.co/image/ab67616d0000b2737d384516b23347e92a587ed1','2023-10-06',NULL,'OVO/Republic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('4DjJtllSDzVDBf7PYtsHaT','Slime You Out','https://i.scdn.co/image/ab67616d0000b2733b2df9103b8b1bad69ec4aa9','2023-09-15',NULL,'OVO',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('4Epq84TTM5hHH5jI78R271','B.B. King Freestyle','https://i.scdn.co/image/ab67616d0000b2737f06ef8f9489978f59ebe74a','2020-11-30',NULL,'Republic Records',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('4gH7f7Wlmj4CP6K2VrSwIt','LOVER','https://i.scdn.co/image/ab67616d0000b27304a4420c2f8099d77f3b82fe','2019-06-29',NULL,'(주)글러브엔터테인먼트',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('4hcghI7Io7BFdHHsiaAylg','Winter Ahead (with PARK HYO SHIN) : Silent Carol Ver.','https://i.scdn.co/image/ab67616d0000b273d2c098f8557224a8c5863d69','2024-12-03',NULL,'BIGHIT MUSIC',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('4iL0sqHuipLrqy4y8HRYsZ','CHESHIRE','https://i.scdn.co/image/ab67616d0000b273b2fe0129c0be1d3ce2b70656','2022-11-30',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('4IUWHnLG3hwdi6a4pcFnoa','Fat Juicy & Wet','https://i.scdn.co/image/ab67616d0000b273f922561230918e636f4e130c','2025-01-24',NULL,'gamma. / Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('4Jzx0XAORPKQ3v7EaL8Ful','Dreams Come True - SM STATION','https://i.scdn.co/image/ab67616d0000b2735b1ee39743c40b88a80b4ccf','2021-12-20',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('4lAdPVMD5IK4JrTkiQoaRf','YB 15주년 기념 Live Best `나는 나비`','https://i.scdn.co/image/ab67616d0000b273a339c7cd9efb9e24c1e55cca','2010-11-09',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('4lBrDelXR6Sn0k54a7UWMz','Take My Breath','https://i.scdn.co/image/ab67616d0000b273e6c40bd47002f3faffb31ebe','2021-08-05',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('4MNtFZXiyx5ltdldHFKQSg','IT\'z Different','https://i.scdn.co/image/ab67616d0000b273dd692ed10f85341e49191a37','2019-02-12',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('4MtUmggE3ExRmzshLvmU9o','Song of the Angry Whale','https://i.scdn.co/image/ab67616d0000b27333cd08da31a0ed7fb315cf2f','2022-09-19',NULL,'Universal Music Ltd.',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('4N1fROq2oeyLGAlQ1C1j18','NewJeans 2nd EP \'Get Up\'','https://i.scdn.co/image/ab67616d0000b2730744690248ef3ba7b776ea7b','2023-07-21',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('4Nav3JE8TIOFiuY5x95MIh','Regret of the Times (2024 aespa Remake Version) - SM STATION','https://i.scdn.co/image/ab67616d0000b273c74be23f27696b57c67f5489','2024-01-15',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('4nGujzCa6JLhMx7rHXE4J9','Whiplash (English Version)','https://i.scdn.co/image/ab67616d0000b27335fc1c7098811dcabfb279ec','2025-03-27',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('4o2xz4a9BjYCHh2xfYH50t','Seeing Green','https://i.scdn.co/image/ab67616d0000b27343a149ab4009e7969544af07','2021-05-14',NULL,'Republic Records',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('4OIA4iFFUPeDVODUJ98tmm','THE GIRLS (BLACKPINK THE GAME OST)','https://i.scdn.co/image/ab67616d0000b2735e213a69bc261b67b1abf5cf','2023-08-25',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('4OQEGCbts7MiJm8wfwC9BX','LOYAL (feat. Drake)','https://i.scdn.co/image/ab67616d0000b2737dac93132ac21c963f489833','2019-11-22',NULL,'OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('4PgleR09JVnm3zY1fW3XBA','24K Magic','https://i.scdn.co/image/ab67616d0000b273232711f7d66a1e19e89e28c5','2016-11-17',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('4q3wUuIReEjGSYzmSsxtl6','The Idol Episode 5 Part 1 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b27337a61e7106ce1b3628e4af8d','2023-06-30',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('4Q7cRXio6mF2ImVUCcezPO','For All The Dogs Scary Hours Edition','https://i.scdn.co/image/ab67616d0000b273e286ee36b4015afa8832356a','2023-11-17',NULL,'OVO/Republic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('4qZBW3f2Q8y0k1A84d4iAO','My Dear Melancholy,','https://i.scdn.co/image/ab67616d0000b2731f6a2a40bb692936879db730','2018-03-30',NULL,'Universal Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('4rRB9bAIwawVcrdLXuq9Qu','Leave The Door Open (Live)','https://i.scdn.co/image/ab67616d0000b2730d18a58b311b58820ba4735f','2021-04-02',NULL,'Aftermath Entertainment/Atlantic',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('4S5PRo1gVG9BvRnCcdYzdS','Why Be?','https://i.scdn.co/image/ab67616d0000b2738c8c1c48b862cdf22a5b3d3f','2010-01-01',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('4sfwHIxFU5kcDqSdMENQsy','Winter Ahead (with PARK HYO SHIN)','https://i.scdn.co/image/ab67616d0000b27316ba2a3622bd0d0d985e3234','2024-11-29',NULL,'BIGHIT MUSIC',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('4T8wBxIvoSRVfoFZzuwOXR','One of the Girls','https://i.scdn.co/image/ab67616d0000b273fab8b9788d94224614c49185','2023-12-08',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('4uoEruXjt0APvHaSqrwqPH','BLOW (with Chris Stapleton & Bruno Mars)','https://i.scdn.co/image/ab67616d0000b2733d75fe24ebd1741bb74603b9','2019-07-05',NULL,'Atlantic Records UK',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('4vLGHlTnlIIxMSfefCY0cU','SYNK : PARALLEL LINE - Special Digital Single','https://i.scdn.co/image/ab67616d0000b273253096eda3b7826c11c7fab8','2024-10-09',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('4VZ7jhV0wHpoNPCB7Vmiml','An Evening With Silk Sonic','https://i.scdn.co/image/ab67616d0000b273d0bbd3ea2ec554f17a6603cc','2021-11-12',NULL,'Aftermath Entertainment/Atlantic',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('4WL52EyorI85Tip01sXmmT','눈의 꽃 - 미안하다, 사랑한다 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273a96f6560c7e9f8ff05dbf284','2008-11-26',NULL,'스펀지사운드',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('4WnNx3UFK6RtaY3HezgC8E','GUESS WHO','https://i.scdn.co/image/ab67616d0000b273929ca29b56c51ef519e5ef9a','2021-04-30',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('4Wo9ttaSJZeISISGeUCQHD','December','https://i.scdn.co/image/ab67616d0000b273d383f693a95af64989747ec1','2013-11-19',NULL,'Blueprint Music',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('4XpRhJEAxvXbKvOElITs0Z','스무살','https://i.scdn.co/image/ab67616d0000b273bc07638960996e057d5fca05','2015-10-05',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('4y0RwaWQvfCzYgbUrWwNl8','Next Destination... New York (Live Concert)','https://i.scdn.co/image/ab67616d0000b273e85355ed1eaae357091bebb8','2005-12-22',NULL,'Beyond Music',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('4yJNcgX3otzDbMMyrdJBN5','We Caa Done (feat. Drake)','https://i.scdn.co/image/ab67616d0000b27331964d5b752d199f3febe389','2023-01-06',NULL,'OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('4yP0hdKOZPNshxUOjY0cZj','After Hours','https://i.scdn.co/image/ab67616d0000b2738863bc11d2aa12b54f5aeb36','2020-03-20',NULL,'Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('4YV1qBdn6O6thyg18kBo0N','Hurricane','https://i.scdn.co/image/ab67616d0000b27331a80d2686b8a10d7925efb6','2021-08-27',NULL,'Getting Out Our Dreams II, LLC / Def Jam Recordings',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('54DNHFsfCa7nlQFWXMg7y3','The Grenade Sessions','https://i.scdn.co/image/ab67616d0000b273c97f38f487e3c07fc63f48e8','2011-02-08',NULL,'Elektra (NEK)',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('55N0UTP5992idhnEYOKYd9','iScreaM Vol.26 : Spicy Remix','https://i.scdn.co/image/ab67616d0000b27324936098cb2874153291a3f9','2023-09-15',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('56eyAyu9JO0vSKijY3cKPh','Odyssey','https://i.scdn.co/image/ab67616d0000b2739d7e778ddeefeb2bd6717d99','2025-02-26',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('58ufpQsJ1DS5kq4hhzQDiI','Unorthodox Jukebox','https://i.scdn.co/image/ab67616d0000b273926f43e7cce571e62720fd46','2012-12-07',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('59vClLXHQp6vY4IfO0SDmm','IT\'z ITZY','https://i.scdn.co/image/ab67616d0000b2739f5467604bbd630ae773cba3','2021-12-22',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('5a4sJJ3qjn6hqRsvm0Veso','Please Me','https://i.scdn.co/image/ab67616d0000b273288883647008cefba0db5402','2019-02-15',NULL,'Atlantic/KSR',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('5AQdhXDCLTUZNHYH1hMIdF','Who Told You (feat. Drake)','https://i.scdn.co/image/ab67616d0000b273f6aca6a7d4132d9b2d15e0f0','2023-06-08',NULL,'Black Butter',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('5AVEtKtguEa8sqYhSj3zFW','Finesse (Remix) [feat. Cardi B]','https://i.scdn.co/image/ab67616d0000b273ec9f67dfe2aa11fbbc304c17','2018-03-23',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('5aX2plzPm0m6zk4ZFuqbuI','The Idol Episode 3 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b273c2f472bdfc7ad0883c933ab4','2023-06-19',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('5bKmRG1QsggSXoHxYUnPIY','Pink Venom','https://i.scdn.co/image/ab67616d0000b273d8c2bf84c41ec28dc6fb8926','2022-08-19',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('5bx7i3cuSfXBPF7Li8kUR7','The Idol Episode 2 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b273221ffa4ab2c5e4511563fb57','2023-06-12',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('5Dz30uiKFlqDemyDhW63ZL','Girls Will Be Girls (Remixes)','https://i.scdn.co/image/ab67616d0000b273232b3f37c5c2c39800efb5cd','2025-06-13',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('5EA4kogB3cZr2qykFlZDYV','24K Magic','https://i.scdn.co/image/ab67616d0000b2738b36ce22ea4b5e64bb03582c','2016-10-07',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('5eLr5u0UcnXjtNZgbnsoYS','Die With A Smile (Acoustic)','https://i.scdn.co/image/ab67616d0000b27335b56028ff1b13347a8aa5b6','2024-10-17',NULL,'Interscope Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('5FAPIZrpcxQLLte8PlUvxS','How You Like That (JP Ver.)','https://i.scdn.co/image/ab67616d0000b2734685829353fb0a3bf3e61f32','2021-07-27',NULL,'Universal Music LLC',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('5I5Bz7STXgcn5X2NYrDl2I','Jingle Bell Rock (Sped Up Version)','https://i.scdn.co/image/ab67616d0000b27316a6e2ee47a08165186acd2c','2023-12-14',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('5iOt5bH6SPHqKYCPNy6Pkc','Boys Like You','https://i.scdn.co/image/ab67616d0000b273efc24a7cd467d086825de8d2','2022-10-21',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('5L6DR2YmRLRZ4CmR91l3Z4','Only You Freestyle','https://i.scdn.co/image/ab67616d0000b27395716719bcb760795a0c15bf','2020-07-20',NULL,'Relentless Records',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('5LuoozUhs2pl3glZeAJl89','Scary Hours 2','https://i.scdn.co/image/ab67616d0000b2738b20e4631fa15d3953528bbc','2021-03-05',NULL,'OVO',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('5MS3MvWHJ3lOZPLiMxzOU6','Her Loss','https://i.scdn.co/image/ab67616d0000b27302854a7060fccc1a66a4b5ad','2022-11-04',NULL,'OVO / Republic Records',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('5n7H2BKGE34RggAeZOFbin','Destitute','https://i.scdn.co/image/ab67616d0000b2739e81cfe93b86615129e806f5','2010-01-01',NULL,'Universal Music Ltd.',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('5NMtxQJy4wq3mpo3ERVnLs','Drama - The 4th Mini Album','https://i.scdn.co/image/ab67616d0000b273c54e39f2ae0dd10731f93c08','2023-11-10',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('5nNtpPsSUgb9Hlb3dF1gXa','POPSTAR (feat. Drake)','https://i.scdn.co/image/ab67616d0000b273efaecb4b9cbae7c120d14617','2020-07-17',NULL,'OVO/We The Best/Epic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('5O0zUvdnJr0RbWzLFneN2i','Popular (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b2734c8f092adc59b4bf4212389d','2023-06-02',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('5oT8PMXGWiPlhcl930fkII','100 GIGS','https://i.scdn.co/image/ab67616d0000b273e955f0f0a0471ace604ecdf6','2024-08-30',NULL,'OVO/Republic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('5qHH0SHWf5yQxG4yqHnIzY','A Time Called You (Original Soundtrack from the Netflix Series)','https://i.scdn.co/image/ab67616d0000b2738745052bd0875c90d9c0c8bb','2023-09-01',NULL,'Genie Music Corporation, Stone Music Entertainment',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('5RylhkCb6kzwJDokcvQZeE','Hot Mess','https://i.scdn.co/image/ab67616d0000b27386ed11a147dbe7eaa9ca31dd','2024-07-03',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('5t3AooZ5peKSKltkjr12Qm','You’re Mines Still (feat. Drake)','https://i.scdn.co/image/ab67616d0000b273fb2fbb14fb726e1c9da20d34','2020-10-15',NULL,'OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('5tXD77S3yCWTToU5eMLnlo','KILL MY DOUBT','https://i.scdn.co/image/ab67616d0000b2735e674180b1fe79181853f911','2023-07-31',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('5uCEoLCj3ZZZ1EtzQdQWVl','Life Is Good (feat. Drake)','https://i.scdn.co/image/ab67616d0000b2738a01c7b77a34378a62f46402','2020-01-10',NULL,'Epic/Freebandz',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('5UnM35MmXsDGzNvFx5u9uO','Soul Tree','https://i.scdn.co/image/ab67616d0000b273ba7af59e1e79f1f7a3e44b13','2004-04-20',NULL,'(주)글러브엔터테인먼트',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('5V729UqvhwNOcMejx0m55I','NewJeans \'Super Shy\'','https://i.scdn.co/image/ab67616d0000b2733d98a0ae7c78a3a9babaf8af','2023-07-07',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('5vgkX6abffhom2ejVI11yq','Die For It (ft. Nas)','https://i.scdn.co/image/ab67616d0000b2736c1f7876d7322a196d9880ca','2021-08-26',NULL,'XO | Roc Nation Records, LLC',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('5wybcI0Q4wJh6IJtqXqeJ6','YB 2ND','https://i.scdn.co/image/ab67616d0000b2739666266d6eb081fe3d08de11','2010-01-01',NULL,'Universal Music Ltd.',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('61XhXTtorAgw4lRnh8GN0c','MELTDOWN (feat. Drake)','https://i.scdn.co/image/ab67616d0000b27324938858a3971f09da45d3f2','2023-07-27',NULL,'Cactus Jack/Epic',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('61ZCeqzP8onzBEP7dR0P5t','ZOOM ZOOM','https://i.scdn.co/image/ab67616d0000b2735b38b036c66d46f02371ec3c','2023-10-06',NULL,'WARNER MUSIC JAPAN INC.',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('63W6Zfm99reI0hTeMpRtUO','The wind is blowing','https://i.scdn.co/image/ab67616d0000b2736d792e0c4a23f6a400b3c4f3','2019-03-10',NULL,'(주)글러브엔터테인먼트',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('67WUCOjyl44d8fAFzHONjW','Search & Rescue','https://i.scdn.co/image/ab67616d0000b273cace8a4b2ff924c9e12e3a96','2023-04-07',NULL,'OVO/Republic Records',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('69eqA59bgh09wQ2MT1AlnL','Sideways','https://i.scdn.co/image/ab67616d0000b273c2e28a191c07eb707003cc91','2024-07-26',NULL,'Ultra Records, LLC',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('69xF8jTd0c4Zoo7DT3Rwrn','MY WORLD - The 3rd Mini Album','https://i.scdn.co/image/ab67616d0000b27304878afb19613a94d37b29ce','2023-05-08',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('6agmeioaDOBupymziJihgB','Thank Me Later (Int\'l Version)','https://i.scdn.co/image/ab67616d0000b27372babba16ea5e3afe690b4f1','2010-01-01',NULL,'Cash Money Records/Young Money Ent./Universal Rec.',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('6cBEXcGAITJteTAkbSneXd','Thank Me Later','https://i.scdn.co/image/ab67616d0000b27367c313102651aea2374438b0','2010-01-01',NULL,'Cash Money Records/Young Money Ent./Universal Rec.',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('6ceHoTiPm8m5gera0XdBOW','I am A Dreamer','https://i.scdn.co/image/ab67616d0000b273d3430c9daa4cf3572627c420','2016-10-03',NULL,'(주)글러브엔터테인먼트, 젤리피쉬엔터테인먼트(주)',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('6DmXKM13nNgIIby2FdK0f8','Take My Breath','https://i.scdn.co/image/ab67616d0000b2733c041e53cb5c38b6de03e758','2021-08-06',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('6E3IPXh38G7UHLqVdfIY5h','The Idol Episode 1 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b2736d20a763ad0e31c924c5e176','2023-06-09',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('6Exo0MYoL3XammoTDeihFy','Die For You (Remix)','https://i.scdn.co/image/ab67616d0000b2738de12a274f6e1df6634f57ec','2023-02-24',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('6F87lH0I09qlrzvCCKc7lz','Thursday (Original)','https://i.scdn.co/image/ab67616d0000b273e01c2631218e2de27765b7d5','2011-08-18',NULL,'Universal Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('6FbwZcLd2Wqx0vDR2JfvQe','HAPPY TOGETHER','https://i.scdn.co/image/ab67616d0000b27351ced1698d5470ab43187b53','2014-11-24',NULL,'JELLYFISH ENTERTAINMENT',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('6fgSKdHloRioPrZ9oJC7FH','One Right Now','https://i.scdn.co/image/ab67616d0000b2734158fe41143182ec16ead070','2021-11-05',NULL,'Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('6gCLXpitNrlglz2pg7WrAN','Rebellion','https://i.scdn.co/image/ab67616d0000b273b1a5758ad7c976dcb5559300','2025-02-05',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('6HmUGM55FYKtA0jm3lgyFW','We Go (English Version)','https://i.scdn.co/image/ab67616d0000b273418e2c9e674ca6704e182387','2024-09-20',NULL,'Pokémon',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('6HqiFsktBxto6ushwmDOUj','RE:WORKS','https://i.scdn.co/image/ab67616d0000b273764f05a8507a4012afbca027','2024-10-07',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('6j5wyAhR4ijdLQfJrYDkNN','YB vs RRM','https://i.scdn.co/image/ab67616d0000b2736d8cb09bb75fff98ca8a62dc','2010-01-01',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('6J84szYCnMfzEcvIcfWMFL','Doo-Wops & Hooligans','https://i.scdn.co/image/ab67616d0000b273f60070dce96a2c1b70cf6ff0','2010-05-11',NULL,'Elektra (NEK)',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('6LD3J50OxLEQbAB8ahoj1S','That\'s What I Like (Alan Walker Remix)','https://i.scdn.co/image/ab67616d0000b273185522533982fce28baace9c','2017-04-20',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('6LuY3APmuxui8BM2oibkrZ','Out Of Time (Remix Bundle)','https://i.scdn.co/image/ab67616d0000b273c34dffa3ee633fa3915c6806','2022-04-22',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('6nHECY2OnWXVmd4QjGhJEm','Break My Heart Myself (feat. YEJI & RYUJIN of ITZY)','https://i.scdn.co/image/ab67616d0000b2732c960195315acacaaabf1271','2022-07-29',NULL,'Warner Records',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('6OQ9gBfg5EXeNAEwGSs6jK','Dark Lane Demo Tapes','https://i.scdn.co/image/ab67616d0000b273bba7cfaf7c59ff0898acba1f','2020-05-01',NULL,'OVO',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('6OVeP3PqCTxyGrTxKWJB7H','The Gold (Original Recording Remastered)','https://i.scdn.co/image/ab67616d0000b2738f198dce1221c6edbbea67b7','2016-06-01',NULL,'Beyond Music',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('6OZ8ZANoibZBNM7948KPjn','EPIC SEVEN (Original Soundtrack) \'Invincible\'','https://i.scdn.co/image/ab67616d0000b273fc0e351745310290a29c4c52','2022-06-28',NULL,'Epic Seven',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('6Rl6YoCarF2GHPSQmmFjuR','$ome $exy $ongs 4 U','https://i.scdn.co/image/ab67616d0000b273cc392813bfd8f63d4d5f4a95','2025-02-14',NULL,'OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('6RP5wCF7u2WDFiuyQ0loNS','IT\'z ME','https://i.scdn.co/image/ab67616d0000b273f919f966de2e069bb709d4ab','2020-03-09',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('6TA0VcPiUH1a3tPRp3SjbC','Girls Will Be Girls','https://i.scdn.co/image/ab67616d0000b2736ec0ea1afe86b93fb1840366','2025-06-09',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('6ULNJ3uohkBFzsHLowkS12','Un Urbanite','https://i.scdn.co/image/ab67616d0000b273759dd4c8aacd8ce8b43bcb7d','2010-01-01',NULL,'Universal Music Ltd.',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('6uWbkjA7Osh3VNnnGeyfl6','iScreaM Vol.33 : Supernova / Armageddon Remixes','https://i.scdn.co/image/ab67616d0000b2738ea1c16ce57f0a2b171bebfd','2024-09-20',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('6VfBBrRc9CiWisIAoBeTqs','Open Hearts','https://i.scdn.co/image/ab67616d0000b2739d70654ee9ed03bbc86facf1','2025-01-29',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('6vJRxj9GnmwXT7mKJqE61n','Starry Eyes (MIKE DEAN Remix)','https://i.scdn.co/image/ab67616d0000b273b85976e1b1bd2d00ff551a01','2022-07-01',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('6wlo2cGnBTzluPkeMDiOy0','Drama (Sped Up Version)','https://i.scdn.co/image/ab67616d0000b273c9a86dfd2da4ce51cfdd4652','2023-12-15',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('6wRev1uYL0JsMsWqktJuVi','Kiss Land (Deluxe)','https://i.scdn.co/image/ab67616d0000b273b06645ac5eaf2249c4f5fac7','2013-09-10',NULL,'Universal Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('6X1x82kppWZmDzlXXK3y3q','Take Care (Deluxe)','https://i.scdn.co/image/ab67616d0000b273c7ea04a9b455e3f68ef82550','2011-11-15',NULL,'Cash Money Records/Young Money Ent./Universal Rec.',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('6xA5SblTTyphoYnDQoYeVc','Drifting Free','https://i.scdn.co/image/ab67616d0000b273876e824a2f1aec04b99aed55','2018-07-12',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('6XRGc3GNodkhSrPwHnx1KX','NJWMX','https://i.scdn.co/image/ab67616d0000b273782a8cae588fee29eefec8b6','2023-12-19',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('6y6lP1WRfqEhv8RLy4ufZB','Sour Candy (with BLACKPINK)','https://i.scdn.co/image/ab67616d0000b273348a8b432f3e8e02f342056e','2020-05-28',NULL,'Interscope Records',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('6yetqbA9vli7RLoUWYZLsq','SQUARE UP','https://i.scdn.co/image/ab67616d0000b27314d1e0d0aba77339c007ed92','2018-06-15',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('6YWeTsiWmZlWj6mXtYFvxA','The Day (From \"Mr. Sunshine\", Pt. 1) [Original Television Soundtrack]','https://i.scdn.co/image/ab67616d0000b2731d736ce4d39ee47ba34da1a3','2018-07-08',NULL,'Stone Music Entertainment, hwa$dam pictures',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('6ZvAEVWfmlycs7w7ICS95k','왕관 쓴 바보','https://i.scdn.co/image/ab67616d0000b273790f647dd03dc0fbd7a7b668','2014-06-12',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('6zWajG8oLkshBrkjIMPbjQ','Not Shy (English Ver.)','https://i.scdn.co/image/ab67616d0000b27371ab8cb5a915d344e8900248','2021-01-22',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('73B0Ru9CdUgVoi5AGmLe99','LOYAL (feat. Drake and Bad Bunny) [Remix]','https://i.scdn.co/image/ab67616d0000b273c0e6a546ff74ddb60040094b','2020-02-07',NULL,'OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('73O0qUbaKCFbJ2EfZID1uo','Stay Alive (with the London Symphony Orchestra)','https://i.scdn.co/image/ab67616d0000b273540e0e176010911ce858e500','2018-11-06',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('742eAldb4AJKLoPgJhGRE7','After Hours (Deluxe)','https://i.scdn.co/image/ab67616d0000b273ef017e899c0547766997d874','2020-03-20',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('75fZ4eJHsRFNpn4VDoQbKb','흰수염고래','https://i.scdn.co/image/ab67616d0000b2735126142151ebce9c31aa2d3c','2011-11-24',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('78NIQe42qKXahAeZAb3w0h','No Face','https://i.scdn.co/image/ab67616d0000b273cf05fc616cf7e38c0e52b888','2024-08-31',NULL,'OVO',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('7AeJIhR7oTd7l6A1hZNbmS','도깨비불 (Illusion)','https://i.scdn.co/image/ab67616d0000b27366c78ec4b271cc582fef3618','2022-06-01',NULL,'Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('7AVPWq0bdemQcflSSHMfBx','Goodbye','https://i.scdn.co/image/ab67616d0000b273ede80f85e3454b8eb3ab16f1','2019-05-06',NULL,'(주)글러브엔터테인먼트',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('7bnqo1fdJU9nSfXQd3bSMe','Ditto','https://i.scdn.co/image/ab67616d0000b273edf5b257be1d6593e81bb45f','2022-12-19',NULL,'ADOR',NULL,'6HvZYsbFfjnjFrWF950C9d',NULL),('7BzP09BlvvE4ioNgvdLrdm','Just the Way You Are (Remix)','https://i.scdn.co/image/ab67616d0000b27372251863ae2a411a35dc6c47','2010-11-02',NULL,'Elektra Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('7DoTPRCQRYuLO5rxA11G0m','우리들의 법칙','https://i.scdn.co/image/ab67616d0000b2736c1ceff2d8ce878abcf0f801','2016-06-15',NULL,'디컴퍼니',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('7dqpveMVcWgbzqYrOdkFTD','Care Package','https://i.scdn.co/image/ab67616d0000b2739c1e02d4becb7c5bbca01e2a','2019-08-02',NULL,'OVO',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('7dSaBwUid0hjWdJ5QzIKyu','Jingle Bell Rock','https://i.scdn.co/image/ab67616d0000b2731ca13e5d59a3a25e68fd7764','2023-11-24',NULL,'SM Entertainment / Warner Records',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('7e6PkMzboUpQPcnDiDQMOk','Promise','https://i.scdn.co/image/ab67616d0000b27353eb97a377be338824f36472','2023-02-03',NULL,'GoRae music inc.',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('7eNsf4qcc9uV6IklAlPp4b','Algorhythm','https://i.scdn.co/image/ab67616d0000b273178b7b66248f9370cff13514','2024-05-15',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('7eSSfgp09p31q3tH5ziNWx','HERO (From the Film \"Firefighters\")','https://i.scdn.co/image/ab67616d0000b2735663bf334f41be6cd2277fa7','2024-12-16',NULL,'HERBIGHARO',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('7GHiMUbLhh67dWSN1xGUcP','Dancing In The Flames (Live from São Paulo)','https://i.scdn.co/image/ab67616d0000b273fad79f4bab30cd048821e186','2024-09-13',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('7GiJLfFllsMNTwMZlFxzIK','Not Shy','https://i.scdn.co/image/ab67616d0000b273a2d16d93aeaa4f05a20a43e0','2020-08-18',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('7GSCElvTHw10xFfIHdibF1','Pretty Savage (JP Ver.)','https://i.scdn.co/image/ab67616d0000b2736b3f72663aefd9c39dd0dca4','2021-08-03',NULL,'Universal Music LLC',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('7ikmjsvRzDRzxHN0KXSQdv','As If It\'s Your Last','https://i.scdn.co/image/ab67616d0000b273ac93d8b1bd84fa6b5291ba21','2017-06-22',NULL,'YG Entertainment',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('7iLdPmU6eUTwKsYifBQ6zb','TWIST & TURN (feat. Drake & PARTYNEXTDOOR)','https://i.scdn.co/image/ab67616d0000b2736a3983e9bfb719157aaa70c8','2020-08-06',NULL,'OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('7J4ASJD3IvdANlrPkmeVP0','BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME- (Live)','https://i.scdn.co/image/ab67616d0000b27323c5b62995e1610ef9f7c137','2020-05-14',NULL,'Universal Music LLC',NULL,'41MozSoPIsD1dJM0CLPjZF',NULL),('7J6hCmiXbY36PVOTFAeGAc','내 사람이여','https://i.scdn.co/image/ab67616d0000b273e670827a0040fe49e45ebef7','2017-04-16',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('7j7jQK2aD7e167FY7WpIvP','꽃비','https://i.scdn.co/image/ab67616d0000b273818e5027e4148e6f0c299c11','2016-02-05',NULL,'Universal Music Ltd. Distributed Labels',NULL,'1rpgxJZxZMLnFNc1Jmyov5',NULL),('7l5z6PdgRUaww549kUVeGO','Gift E.C.H.O','https://i.scdn.co/image/ab67616d0000b27304f70644da711f17cb871303','2012-03-22',NULL,'JELLYFISH ENTERTAINMENT',NULL,'57htMBtzpppc1yoXgjbslj',NULL),('7luH8lI8B6c4r3TxLJ2aU1','act ii: date @ 8 (feat. Drake) [remix]','https://i.scdn.co/image/ab67616d0000b273612543615ab7c221057cbf10','2024-03-08',NULL,'4batz / OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('7mkyc2BUahNfo0orKzqNGB','Wake Up in the Sky','https://i.scdn.co/image/ab67616d0000b273b64fc7036d0fccef26f9f7e8','2018-09-14',NULL,'Guwop Enterprises/Atlantic',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('7mpWlMAMdCErqVquIUHsiN','Supernova','https://i.scdn.co/image/ab67616d0000b273115d1e2cfde4e387f0a13ce2','2024-05-13',NULL,'SM Entertainment',NULL,'6YVMFz59CuY7ngCxTxjpxE',NULL),('7oibrqlZZtzsxjYDcHQjEU','In the morning (English Ver.)','https://i.scdn.co/image/ab67616d0000b27378b0cb7c506fa778d32e860a','2021-05-14',NULL,'JYP Entertainment',NULL,'2KC9Qb60EaY0kW4eH68vr3',NULL),('7tzVd1fwkxsorytCBjEJkU','The Idol Episode 4 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b273b0dd6a5cd1dec96c4119c262','2023-06-23',NULL,'XO / Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL),('7yBnuW3SpMKy3EB9iU0C7p','Treasure Remix EP','https://i.scdn.co/image/ab67616d0000b273b108d6fa7e486b08eefabce8','2013-08-13',NULL,'Atlantic Records',NULL,'0du5cEVh5yTK9QJze8zA0C',NULL),('7ybV3NCogLGAhBx75pB3ih','Ela É do Tipo (feat. Drake) [Remix]','https://i.scdn.co/image/ab67616d0000b27325c0a26ca22419123b3c5563','2019-11-06',NULL,'OVO Sound',NULL,'3TVXtAsR1Inumwj472S9r4',NULL),('7zCODUHkfuRxsUjtuzNqbd','House Of Balloons (Original)','https://i.scdn.co/image/ab67616d0000b273274b406a7e18acebcf743079','2011-03-21',NULL,'Universal Republic Records',NULL,'1Xyo4u8uXC1ZmMpatF05PJ',NULL);
/*!40000 ALTER TABLE `album` ENABLE KEYS */;

--
-- Table structure for table `album_review`
--

DROP TABLE IF EXISTS `album_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rating` int NOT NULL,
  `content` text NOT NULL,
  `blinded` tinyint(1) NOT NULL,
  `likes` int NOT NULL DEFAULT '0',
  `dislikes` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `critic` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  `album_id` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`album_id`),
  KEY `FK_album_TO_album_review_1` (`album_id`),
  CONSTRAINT `FK_album_TO_album_review_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_user_TO_album_review_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_review`
--

/*!40000 ALTER TABLE `album_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `album_review` ENABLE KEYS */;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `id` varchar(200) NOT NULL,
  `name` varchar(100) NOT NULL,
  `profile_image` varchar(200) DEFAULT NULL,
  `genres` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES ('0du5cEVh5yTK9QJze8zA0C','Bruno Mars','https://i.scdn.co/image/ab6761610000e5ebc36dd9eb55fb0db4911f25dd',NULL),('1rpgxJZxZMLnFNc1Jmyov5','YB','https://i.scdn.co/image/ab6761610000e5eb4a10fa9cabfb1c7e0904d336','k-rock,k-ballad'),('1Xyo4u8uXC1ZmMpatF05PJ','The Weeknd','https://i.scdn.co/image/ab6761610000e5eb9e528993a2820267b97f6aae',NULL),('2KC9Qb60EaY0kW4eH68vr3','ITZY','https://i.scdn.co/image/ab6761610000e5eb2f46a5bb5ab0c93e47244a32','k-pop'),('2yNNYQBChuox9A5Ka93BIn','HUNTR/X','https://i.scdn.co/image/ab67616d0000b2736c1334650ced0e28f0b2e13f','k-pop'),('3TVXtAsR1Inumwj472S9r4','Drake','https://i.scdn.co/image/ab6761610000e5eb4293385d324db8558179afd9','rap'),('41MozSoPIsD1dJM0CLPjZF','BLACKPINK','https://i.scdn.co/image/ab6761610000e5eb9b57f5eccf180a0049be84b3','k-pop'),('57htMBtzpppc1yoXgjbslj','Park Hyo Shin','https://i.scdn.co/image/ab6761610000e5eb1e93f18daa7131d2e61b7728','k-ballad'),('6HvZYsbFfjnjFrWF950C9d','NewJeans','https://i.scdn.co/image/ab6761610000e5eb80668ba2b15094d083780ea9','k-pop'),('6YVMFz59CuY7ngCxTxjpxE','aespa','https://i.scdn.co/image/ab6761610000e5eb927f1260251e32135287e032','k-pop');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;

--
-- Table structure for table `artist_follow`
--

DROP TABLE IF EXISTS `artist_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_follow` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` bigint NOT NULL,
  `artist_id` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`artist_id`),
  KEY `FK_artist_TO_artist_follow_1` (`artist_id`),
  CONSTRAINT `FK_artist_TO_artist_follow_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_user_TO_artist_follow_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_follow`
--

/*!40000 ALTER TABLE `artist_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `artist_follow` ENABLE KEYS */;

--
-- Table structure for table `artist_mood_vote`
--

DROP TABLE IF EXISTS `artist_mood_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_mood_vote` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `artist_id` varchar(200) NOT NULL,
  `mood` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`artist_id`),
  KEY `FK_artist_TO_artist_mood_vote_1` (`artist_id`),
  CONSTRAINT `FK_artist_TO_artist_mood_vote_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`),
  CONSTRAINT `FK_user_TO_artist_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_mood_vote`
--

/*!40000 ALTER TABLE `artist_mood_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `artist_mood_vote` ENABLE KEYS */;

--
-- Table structure for table `badge`
--

DROP TABLE IF EXISTS `badge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `badge` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `icon_url` varchar(200) DEFAULT NULL,
  `criteria` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badge`
--

/*!40000 ALTER TABLE `badge` DISABLE KEYS */;
/*!40000 ALTER TABLE `badge` ENABLE KEYS */;

--
-- Table structure for table `badge_condition`
--

DROP TABLE IF EXISTS `badge_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `badge_condition` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `badge_id` bigint NOT NULL,
  `badge_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `condition_type` varchar(50) DEFAULT NULL,
  `condition_value` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_badge_TO_badge_condition_1` (`badge_id`),
  CONSTRAINT `FK_badge_TO_badge_condition_1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badge_condition`
--

/*!40000 ALTER TABLE `badge_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `badge_condition` ENABLE KEYS */;

--
-- Table structure for table `board_post`
--

DROP TABLE IF EXISTS `board_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `community_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_community_TO_board_post_1` (`community_id`),
  KEY `FK_user_TO_board_post_1` (`user_id`),
  CONSTRAINT `FK_community_TO_board_post_1` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`),
  CONSTRAINT `FK_user_TO_board_post_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_post`
--

/*!40000 ALTER TABLE `board_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_post` ENABLE KEYS */;

--
-- Table structure for table `chart_element`
--

DROP TABLE IF EXISTS `chart_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chart_element` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `lyric` int NOT NULL,
  `sound` int NOT NULL,
  `melody` int NOT NULL,
  `storytelling` int NOT NULL,
  `cohesiveness` int NOT NULL,
  `creativity` int NOT NULL,
  `album_id` varchar(200) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`album_id`),
  KEY `FK_album_TO_chart_element_1` (`album_id`),
  CONSTRAINT `FK_album_TO_chart_element_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_user_TO_chart_element_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chart_element`
--

/*!40000 ALTER TABLE `chart_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `chart_element` ENABLE KEYS */;

--
-- Table structure for table `chart_entry`
--

DROP TABLE IF EXISTS `chart_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chart_entry` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `rank` int DEFAULT NULL,
  `calculated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `track_id` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_track_TO_chart_entry_1` (`track_id`),
  CONSTRAINT `FK_track_TO_chart_entry_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chart_entry`
--

/*!40000 ALTER TABLE `chart_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `chart_entry` ENABLE KEYS */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` bigint NOT NULL,
  `type` enum('posts','playlist','comment') NOT NULL,
  `target_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_comment_1` (`user_id`),
  CONSTRAINT `FK_user_TO_comment_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;

--
-- Table structure for table `community`
--

DROP TABLE IF EXISTS `community`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `community` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_community_1` (`creator_id`),
  CONSTRAINT `FK_user_TO_community_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `community`
--

/*!40000 ALTER TABLE `community` DISABLE KEYS */;
/*!40000 ALTER TABLE `community` ENABLE KEYS */;

--
-- Table structure for table `external_api_config`
--

DROP TABLE IF EXISTS `external_api_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_api_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider` varchar(100) NOT NULL,
  `apiKey` varchar(100) NOT NULL,
  `secret` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_api_config`
--

/*!40000 ALTER TABLE `external_api_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_api_config` ENABLE KEYS */;

--
-- Table structure for table `liked_album`
--

DROP TABLE IF EXISTS `liked_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liked_album` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` bigint NOT NULL,
  `album_id` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`album_id`),
  KEY `FK_album_TO_liked_album_1` (`album_id`),
  CONSTRAINT `FK_album_TO_liked_album_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_user_TO_liked_album_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liked_album`
--

/*!40000 ALTER TABLE `liked_album` DISABLE KEYS */;
/*!40000 ALTER TABLE `liked_album` ENABLE KEYS */;

--
-- Table structure for table `liked_playlist`
--

DROP TABLE IF EXISTS `liked_playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liked_playlist` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` bigint NOT NULL,
  `playlist_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`playlist_id`),
  UNIQUE KEY `UK_user_playlist` (`user_id`,`playlist_id`),
  KEY `FK_playlist_TO_liked_playlist_1` (`playlist_id`),
  CONSTRAINT `FK_playlist_TO_liked_playlist_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user_TO_liked_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liked_playlist`
--

/*!40000 ALTER TABLE `liked_playlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `liked_playlist` ENABLE KEYS */;

--
-- Table structure for table `liked_track`
--

DROP TABLE IF EXISTS `liked_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liked_track` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` bigint NOT NULL,
  `track_id` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`track_id`),
  KEY `FK_track_TO_liked_track_1` (`track_id`),
  CONSTRAINT `FK_track_TO_liked_track_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`),
  CONSTRAINT `FK_user_TO_liked_track_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liked_track`
--

/*!40000 ALTER TABLE `liked_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `liked_track` ENABLE KEYS */;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL,
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `author_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_notice_1` (`author_id`),
  CONSTRAINT `FK_user_TO_notice_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `message` text NOT NULL,
  `content` text,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `target_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_notification_1` (`user_id`),
  CONSTRAINT `FK_user_TO_notification_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;

--
-- Table structure for table `persistent_logins`
--

DROP TABLE IF EXISTS `persistent_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persistent_logins` (
  `username` varchar(64) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` timestamp NOT NULL,
  PRIMARY KEY (`series`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persistent_logins`
--

/*!40000 ALTER TABLE `persistent_logins` DISABLE KEYS */;
/*!40000 ALTER TABLE `persistent_logins` ENABLE KEYS */;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `thumbnail_url` varchar(200) NOT NULL DEFAULT '/img/profileImg.png',
  `is_public` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_playlist_1` (`user_id`),
  CONSTRAINT `FK_user_TO_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;

--
-- Table structure for table `playlist_detail`
--

DROP TABLE IF EXISTS `playlist_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `track_id` varchar(200) NOT NULL,
  `playlist_id` bigint NOT NULL,
  `order_no` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_track_playlist` (`track_id`,`playlist_id`),
  KEY `FK_playlist_TO_playlist_detail_1` (`playlist_id`),
  CONSTRAINT `FK_playlist_TO_playlist_detail_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_track_TO_playlist_detail_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist_detail`
--

/*!40000 ALTER TABLE `playlist_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist_detail` ENABLE KEYS */;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plugin` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `config_json` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin`
--

/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin` ENABLE KEYS */;

--
-- Table structure for table `policy`
--

DROP TABLE IF EXISTS `policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `content` text,
  `version` varchar(100) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy`
--

/*!40000 ALTER TABLE `policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `policy` ENABLE KEYS */;

--
-- Table structure for table `qna`
--

DROP TABLE IF EXISTS `qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_qna_1` (`user_id`),
  CONSTRAINT `FK_user_TO_qna_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna`
--

/*!40000 ALTER TABLE `qna` DISABLE KEYS */;
/*!40000 ALTER TABLE `qna` ENABLE KEYS */;

--
-- Table structure for table `qna_answer`
--

DROP TABLE IF EXISTS `qna_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna_answer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `answered_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `qna_id` bigint NOT NULL,
  `admin_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_qna_TO_qna_answer_1` (`qna_id`),
  KEY `FK_user_TO_qna_answer_1` (`admin_id`),
  CONSTRAINT `FK_qna_TO_qna_answer_1` FOREIGN KEY (`qna_id`) REFERENCES `qna` (`id`),
  CONSTRAINT `FK_user_TO_qna_answer_1` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna_answer`
--

/*!40000 ALTER TABLE `qna_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `qna_answer` ENABLE KEYS */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `target_type` enum('boardPost','comment','review','playlist','album','track','user','artist','qna') NOT NULL,
  `target_id` bigint NOT NULL,
  `reason` text NOT NULL,
  `status` enum('PENDING','DONE','REJECTED') NOT NULL DEFAULT 'PENDING',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reporter_id` bigint NOT NULL,
  `processed_by` bigint DEFAULT NULL,
  `processed_at` datetime DEFAULT NULL,
  `process_memo` text,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_report_1` (`reporter_id`),
  CONSTRAINT `FK_user_TO_report_1` FOREIGN KEY (`reporter_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;

--
-- Table structure for table `review_like`
--

DROP TABLE IF EXISTS `review_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_like` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `review_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `review_type` enum('TRACK','ALBUM') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `review_id` (`review_id`,`user_id`,`review_type`),
  UNIQUE KEY `review_id_2` (`review_id`,`user_id`,`review_type`),
  KEY `FK_user_TO_review_like_1` (`user_id`),
  CONSTRAINT `FK_user_TO_review_like_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_like`
--

/*!40000 ALTER TABLE `review_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_like` ENABLE KEYS */;

--
-- Table structure for table `review_report`
--

DROP TABLE IF EXISTS `review_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_report` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `review_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `review_type` enum('TRACK','ALBUM') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `review_id` (`review_id`,`user_id`,`review_type`),
  UNIQUE KEY `review_id_2` (`review_id`,`user_id`,`review_type`),
  KEY `FK_user_TO_review_report_1` (`user_id`),
  CONSTRAINT `FK_user_TO_review_report_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_report`
--

/*!40000 ALTER TABLE `review_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_report` ENABLE KEYS */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_setting_value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;

--
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `track` (
  `id` varchar(200) NOT NULL,
  `title` text NOT NULL,
  `duration` int NOT NULL,
  `genre` varchar(64) DEFAULT NULL,
  `streaming_url` varchar(200) DEFAULT NULL,
  `mv_url` varchar(200) DEFAULT NULL,
  `album_id` varchar(200) NOT NULL,
  `artist_id` varchar(200) NOT NULL,
  `popularity` int NOT NULL,
  `track_no` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_album_TO_track_1` (`album_id`),
  KEY `FK_artist_TO_track_1` (`artist_id`),
  CONSTRAINT `FK_album_TO_track_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_artist_TO_track_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track`
--

/*!40000 ALTER TABLE `track` DISABLE KEYS */;
INSERT INTO `track` VALUES ('00aqkszH1FdUiJJWvX6iEl','Wicked Games',325,NULL,'https://open.spotify.com/track/00aqkszH1FdUiJJWvX6iEl',NULL,'7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',74,5),('00Blm7zeNqgYLPtW6zg8cj','One Right Now (with The Weeknd)',193,NULL,'https://open.spotify.com/track/00Blm7zeNqgYLPtW6zg8cj',NULL,'6fgSKdHloRioPrZ9oJC7FH','1Xyo4u8uXC1ZmMpatF05PJ',70,1),('00dFEbKmQSwBTkHYV6xVTX','Beautiful Tomorrow',294,NULL,'https://open.spotify.com/track/00dFEbKmQSwBTkHYV6xVTX',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',35,4),('00J8yszzb5PR6ZIvSBtg0Y','You Never Know',229,NULL,'https://open.spotify.com/track/00J8yszzb5PR6ZIvSBtg0Y',NULL,'2gNPnKP1PDkB5SZz3IMKuX','41MozSoPIsD1dJM0CLPjZF',63,8),('00NAQYOP4AmWR549nnYJZu','Secrets',265,NULL,'https://open.spotify.com/track/00NAQYOP4AmWR549nnYJZu',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',67,6),('010ZkIVv6Ay5vqqHVCCiKB','Fill The Void (with Lily Rose Depp, Ramsey)',185,NULL,'https://open.spotify.com/track/010ZkIVv6Ay5vqqHVCCiKB',NULL,'7tzVd1fwkxsorytCBjEJkU','1Xyo4u8uXC1ZmMpatF05PJ',74,3),('01sdh37jvLGU1t2O6uxJbn','Grenade - Michael Meds Mix',410,NULL,'https://open.spotify.com/track/01sdh37jvLGU1t2O6uxJbn',NULL,'1JirxaiYwz8hAxAk38rkeH','0du5cEVh5yTK9QJze8zA0C',31,1),('01vqYIICqqLqqVyOFoDa0o','위안',242,NULL,'https://open.spotify.com/track/01vqYIICqqLqqVyOFoDa0o',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',11,11),('02iXInevQEAlihE3IPF0eh','Finesse - Remix; feat. Cardi B',217,NULL,'https://open.spotify.com/track/02iXInevQEAlihE3IPF0eh',NULL,'5AVEtKtguEa8sqYhSj3zFW','0du5cEVh5yTK9QJze8zA0C',53,3),('02SDFsqWGN9683KclprnFR','88만원의 Losing Game',192,NULL,'https://open.spotify.com/track/02SDFsqWGN9683KclprnFR',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',4,2),('02sy7FAs8dkDNYsHp4Ul3f','Soda Pop',150,NULL,'https://open.spotify.com/track/02sy7FAs8dkDNYsHp4Ul3f',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',96,3),('02w1rM6spvEcbFxd63xCl2','Less Than Zero',211,NULL,'https://open.spotify.com/track/02w1rM6spvEcbFxd63xCl2',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',59,15),('02wk5BttM0QL38ERjLPQJB','Cool With You',147,NULL,'https://open.spotify.com/track/02wk5BttM0QL38ERjLPQJB',NULL,'4N1fROq2oeyLGAlQ1C1j18','6HvZYsbFfjnjFrWF950C9d',74,4),('02YlAvsmptN8LisZqrWBIb','Take My Breath - Live',235,NULL,'https://open.spotify.com/track/02YlAvsmptN8LisZqrWBIb',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,7),('031EUIoek6o9JgkGqLOq1g','Shine Your Light (Inst.)',254,NULL,'https://open.spotify.com/track/031EUIoek6o9JgkGqLOq1g',NULL,'39ezXXrm2nHqhuErFyPAsO','57htMBtzpppc1yoXgjbslj',3,2),('03BpMAiFJ0b9c47Ntt8MRf','Locked out of Heaven - Paul Oakenfold Remix',317,NULL,'https://open.spotify.com/track/03BpMAiFJ0b9c47Ntt8MRf',NULL,'2vf1K6KumbRZnRHa1JeKyD','0du5cEVh5yTK9QJze8zA0C',32,4),('03H6iCycyxfB2mZzIOEeKJ','Crew Love - Live',113,NULL,'https://open.spotify.com/track/03H6iCycyxfB2mZzIOEeKJ',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,11),('03j354P848KtNU2FVSwkDG','Real Life',223,NULL,'https://open.spotify.com/track/03j354P848KtNU2FVSwkDG',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',60,1),('03L2AoiRbWhvt7BDMx1jUB','U With Me?',297,NULL,'https://open.spotify.com/track/03L2AoiRbWhvt7BDMx1jUB',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',67,3),('03mq0kiUpHJtq7px3ZSTYK','옛 친구에게',299,NULL,'https://open.spotify.com/track/03mq0kiUpHJtq7px3ZSTYK',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',13,6),('03rwnftfgpYVO6QDWOZcG6','Drew A Picasso',262,NULL,'https://open.spotify.com/track/03rwnftfgpYVO6QDWOZcG6',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',68,13),('047fCsbO4NdmwCBn8pcUXl','Marvins Room',347,NULL,'https://open.spotify.com/track/047fCsbO4NdmwCBn8pcUXl',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',79,6),('04BF53Rb6LOpDUJG518IqS','All The Parties (feat. Chief Keef)',218,NULL,'https://open.spotify.com/track/04BF53Rb6LOpDUJG518IqS',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',50,16),('04gylrYCqoQQ9mL1zaRgKc','우리들의 법칙',214,NULL,'https://open.spotify.com/track/04gylrYCqoQQ9mL1zaRgKc',NULL,'7DoTPRCQRYuLO5rxA11G0m','1rpgxJZxZMLnFNc1Jmyov5',0,1),('04Hw5Dz4VHROkOtVxqMXGk','Me Too',239,NULL,'https://open.spotify.com/track/04Hw5Dz4VHROkOtVxqMXGk',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',2,13),('04LWm93tY9nwdlI9EO54HP','DDU-DU DDU-DU - Remix -JP Ver.-',201,NULL,'https://open.spotify.com/track/04LWm93tY9nwdlI9EO54HP',NULL,'0uWttVLwkFxcW1PkBAsmZd','41MozSoPIsD1dJM0CLPjZF',0,5),('04OERuULAbFq54j25v5dZ4','Finesse - James Hype Remix; feat. Cardi B',235,NULL,'https://open.spotify.com/track/04OERuULAbFq54j25v5dZ4',NULL,'5AVEtKtguEa8sqYhSj3zFW','0du5cEVh5yTK9QJze8zA0C',39,1),('04T47lGsiQU6x1cV9GhgDN','Just the Way You Are - Manufactured Superstars and Jquintal Remix',444,NULL,'https://open.spotify.com/track/04T47lGsiQU6x1cV9GhgDN',NULL,'7BzP09BlvvE4ioNgvdLrdm','0du5cEVh5yTK9QJze8zA0C',32,5),('04xEHIAK4MsI7ZSN1hSDQN','HOPE NOT - JP Ver.',191,NULL,'https://open.spotify.com/track/04xEHIAK4MsI7ZSN1hSDQN',NULL,'0uWttVLwkFxcW1PkBAsmZd','41MozSoPIsD1dJM0CLPjZF',39,4),('05aZ9sAU1YXndHv0FMi9iW','Demons (feat. Fivio Foreign & Sosa Geek)',204,NULL,'https://open.spotify.com/track/05aZ9sAU1YXndHv0FMi9iW',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',58,13),('05KOgYg8PGeJyyWBPi5ja8','Free Smoke',218,NULL,'https://open.spotify.com/track/05KOgYg8PGeJyyWBPi5ja8',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',64,1),('05nsilBAHgLy2KXLeqaR6h','Embrace - English Ver.',223,NULL,'https://open.spotify.com/track/05nsilBAHgLy2KXLeqaR6h',NULL,'7e6PkMzboUpQPcnDiDQMOk','1rpgxJZxZMLnFNc1Jmyov5',3,2),('06Ai7l5EODiJQ6dMFfh2Vj','PLAYING WITH FIRE (Live)',199,NULL,'https://open.spotify.com/track/06Ai7l5EODiJQ6dMFfh2Vj',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',35,9),('06TPLtYu6CyxXIQyFgJrl5','내 사람이여',374,NULL,'https://open.spotify.com/track/06TPLtYu6CyxXIQyFgJrl5',NULL,'7J6hCmiXbY36PVOTFAeGAc','1rpgxJZxZMLnFNc1Jmyov5',5,1),('06WghRVH4Yyvu4mtDJ0bfU','SEE U LATER - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',195,NULL,'https://open.spotify.com/track/06WghRVH4Yyvu4mtDJ0bfU',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',36,8),('07fqC2Puj13frv9iYtlcri','Girls',240,NULL,'https://open.spotify.com/track/07fqC2Puj13frv9iYtlcri',NULL,'2rwRvLdjGzjSYl9AS3UbvH','6YVMFz59CuY7ngCxTxjpxE',43,1),('08XWh5c0BMyD1nKVxxl91z','Fountains (with Tems)',192,NULL,'https://open.spotify.com/track/08XWh5c0BMyD1nKVxxl91z',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',74,16),('09mBPwUMt1TXNtneqvmZZ5','Ordinary Life',221,NULL,'https://open.spotify.com/track/09mBPwUMt1TXNtneqvmZZ5',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',47,14),('09mEdoA6zrmBPgTEN5qXmN','Call Out My Name',228,NULL,'https://open.spotify.com/track/09mEdoA6zrmBPgTEN5qXmN',NULL,'4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',87,1),('0a4MMyCrzT0En247IhqZbD','Hype Boy',179,NULL,'https://open.spotify.com/track/0a4MMyCrzT0En247IhqZbD',NULL,'1HMLpmZAnNyl9pxvOnTovV','6HvZYsbFfjnjFrWF950C9d',80,2),('0AeXK2C6ATGERSn5rVWoF3','가리지좀 마',257,NULL,'https://open.spotify.com/track/0AeXK2C6ATGERSn5rVWoF3',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',4,6),('0al8OjzUJWUQ779pp4ZvB3','Orchid - Instrumental',418,NULL,'https://open.spotify.com/track/0al8OjzUJWUQ779pp4ZvB3',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',7,8),('0anW9Vnb6lW1R3KLGTVMRv','그 흔한 남자여서',275,NULL,'https://open.spotify.com/track/0anW9Vnb6lW1R3KLGTVMRv',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',24,14),('0ArVfVP8B5svkfj8clHNzB','Screw The World - Interlude',112,NULL,'https://open.spotify.com/track/0ArVfVP8B5svkfj8clHNzB',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',51,12),('0awWj9Wzj375IL5etqa1Dk','Die For You',260,NULL,'https://open.spotify.com/track/0awWj9Wzj375IL5etqa1Dk',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',51,17),('0awY0gg3Mla7fUbavFrVco','Mirror',258,NULL,'https://open.spotify.com/track/0awY0gg3Mla7fUbavFrVco',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',10,9),('0AYt6NMyyLd0rLuvr0UkMH','Slime You Out (feat. SZA)',310,NULL,'https://open.spotify.com/track/0AYt6NMyyLd0rLuvr0UkMH',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',69,9),('0B0tYbVp7pDQAqKDhgMeaL','Too Good to Say Goodbye',281,NULL,'https://open.spotify.com/track/0B0tYbVp7pDQAqKDhgMeaL',NULL,'4PgleR09JVnm3zY1fW3XBA','0du5cEVh5yTK9QJze8zA0C',75,9),('0B5OTb36fzLayn6XQHg5A1','Scholarships',209,NULL,'https://open.spotify.com/track/0B5OTb36fzLayn6XQHg5A1',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',66,5),('0BbD6NaKDO4FOcZ8DwbusS','이 땅에 살기 위하여',248,NULL,'https://open.spotify.com/track/0BbD6NaKDO4FOcZ8DwbusS',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',2,7),('0bcZ7xN9IcjSNxLerzR2yl','I Can\'t Wait To Get There',188,NULL,'https://open.spotify.com/track/0bcZ7xN9IcjSNxLerzR2yl',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',71,12),('0BjwL3YD48FtGt9rC5t5fY','후회 없어 - Live',248,NULL,'https://open.spotify.com/track/0BjwL3YD48FtGt9rC5t5fY',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,4),('0BsZkMfQV2hoVbAjbSanr9','STYLE',183,NULL,'https://open.spotify.com/track/0BsZkMfQV2hoVbAjbSanr9',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',8,4),('0bvIYGiJURbIbJ663yZR2g','친구라는 건 (with 김범수)',260,NULL,'https://open.spotify.com/track/0bvIYGiJURbIbJ663yZR2g',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',27,8),('0C9WCzHmvl6GvIIn7Tq3pn','Love Barista (Feat. Seo In Guk)',266,NULL,'https://open.spotify.com/track/0C9WCzHmvl6GvIIn7Tq3pn',NULL,'2KnWel482zu05nLvSqNEzI','57htMBtzpppc1yoXgjbslj',23,5),('0cEgzplIhHjImUGWyBwglY','Stay Alive',333,NULL,'https://open.spotify.com/track/0cEgzplIhHjImUGWyBwglY',NULL,'2YVpqON0I1KS8LjQLqV0uH','1rpgxJZxZMLnFNc1Jmyov5',1,2),('0Cgdo1QPOxmTkb3uMZcLch','Walk',175,NULL,'https://open.spotify.com/track/0Cgdo1QPOxmTkb3uMZcLch',NULL,'6TA0VcPiUH1a3tPRp3SjbC','2KC9Qb60EaY0kW4eH68vr3',28,5),('0CklyLJ62EoAjWSxJJcav2','머리 아파',184,NULL,'https://open.spotify.com/track/0CklyLJ62EoAjWSxJJcav2',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',2,10),('0CSHnXB4sGdmOtsPzbaW5D','DALLA DALLA -Japanese ver.-',199,NULL,'https://open.spotify.com/track/0CSHnXB4sGdmOtsPzbaW5D',NULL,'59vClLXHQp6vY4IfO0SDmm','2KC9Qb60EaY0kW4eH68vr3',2,1),('0dAazo1qC2K70pDrYMOPZ7','나는 나비',215,NULL,'https://open.spotify.com/track/0dAazo1qC2K70pDrYMOPZ7',NULL,'75fZ4eJHsRFNpn4VDoQbKb','1rpgxJZxZMLnFNc1Jmyov5',26,4),('0dkB3lhbWvyCq7nQTMokQ0','THE GIRLS (BLACKPINK THE GAME OST)',162,NULL,'https://open.spotify.com/track/0dkB3lhbWvyCq7nQTMokQ0',NULL,'4OIA4iFFUPeDVODUJ98tmm','41MozSoPIsD1dJM0CLPjZF',62,1),('0DLL0X9fQKdI4VMUepA092','야간마차',253,NULL,'https://open.spotify.com/track/0DLL0X9fQKdI4VMUepA092',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',6,3),('0DULYwlJVbkTTqA8ji6uSR','By Your Side',167,NULL,'https://open.spotify.com/track/0DULYwlJVbkTTqA8ji6uSR',NULL,'2rTc5TdRP7hr7gE4h4lUR1','6YVMFz59CuY7ngCxTxjpxE',38,2),('0DvtQkuaV0VrSHgb5pwRke','Phantom Regret by Jim',179,NULL,'https://open.spotify.com/track/0DvtQkuaV0VrSHgb5pwRke',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',42,16),('0EEWTcPyVbce01VoNSWYgF','Magical Dragon',264,NULL,'https://open.spotify.com/track/0EEWTcPyVbce01VoNSWYgF',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',0,6),('0ei3uNcwJOiUocuks1vWcb','Pretty',375,NULL,'https://open.spotify.com/track/0ei3uNcwJOiUocuks1vWcb',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',57,9),('0f7XQMRTgsTa7RjrWcUpOc','세상속의 아이',335,NULL,'https://open.spotify.com/track/0f7XQMRTgsTa7RjrWcUpOc',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',2,8),('0f8PmjBDqhUYDipxqMieOY','Gas Me Up',149,NULL,'https://open.spotify.com/track/0f8PmjBDqhUYDipxqMieOY',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',9,6),('0Fhjm06qP0LUF6NHzNfmOp','Imaginary Friend (English Ver.)',202,NULL,'https://open.spotify.com/track/0Fhjm06qP0LUF6NHzNfmOp',NULL,'3bXzKLtI7059uh33uiL9GD','2KC9Qb60EaY0kW4eH68vr3',9,2),('0FIDCNYYjNvPVimz5icugS','Timeless (feat Playboi Carti)',256,NULL,'https://open.spotify.com/track/0FIDCNYYjNvPVimz5icugS',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',94,13),('0FmRbstZaP0L8Uj0LLzCTD','Sorry Not Sorry',189,NULL,'https://open.spotify.com/track/0FmRbstZaP0L8Uj0LLzCTD',NULL,'4WnNx3UFK6RtaY3HezgC8E','2KC9Qb60EaY0kW4eH68vr3',15,2),('0fmtziRRsJocN4Sv5I0vkr','달라달라 (DallasK Remix)',190,NULL,'https://open.spotify.com/track/0fmtziRRsJocN4Sv5I0vkr',NULL,'2tj99zihwANHtqmEC2QpCn','2KC9Qb60EaY0kW4eH68vr3',8,4),('0FnxK9FEAQyPJ284QcieNb','5 Am in Toronto',205,NULL,'https://open.spotify.com/track/0FnxK9FEAQyPJ284QcieNb',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',62,8),('0FolPJnYMo71Z7qasTuoJT','Given Up On Me',354,NULL,'https://open.spotify.com/track/0FolPJnYMo71Z7qasTuoJT',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',72,11),('0FPVmgKKm0vsCD2Zd7eMqp','물고기와 자전거 - Live',256,NULL,'https://open.spotify.com/track/0FPVmgKKm0vsCD2Zd7eMqp',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',2,5),('0FPYpKHJ3SuxKLaToGajtY','내 마음속의 땅',219,NULL,'https://open.spotify.com/track/0FPYpKHJ3SuxKLaToGajtY',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',5,11),('0Fsl0mlmjIrAwjIwjFQ8NC','Save Me',241,NULL,'https://open.spotify.com/track/0Fsl0mlmjIrAwjIwjFQ8NC',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',5,8),('0Fvjxlox1kvoNLHKgbEnhQ','Thank Me Now',328,NULL,'https://open.spotify.com/track/0Fvjxlox1kvoNLHKgbEnhQ',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',23,14),('0g2Bbgy7P41pFjMWJuzsf4','STAYING ALIVE (feat. Drake & Lil Baby)',178,NULL,'https://open.spotify.com/track/0g2Bbgy7P41pFjMWJuzsf4',NULL,'0oEsQwXJhNbbb8VT0xOMok','3TVXtAsR1Inumwj472S9r4',63,1),('0G9Umz9jxpkOpfGnhuAyAU','Can\'t tie me down',185,NULL,'https://open.spotify.com/track/0G9Umz9jxpkOpfGnhuAyAU',NULL,'0SbnkLLiTqVmoPmhY80s7S','2KC9Qb60EaY0kW4eH68vr3',4,2),('0GaBIpyHvytM1UBYmqXu08','From Time',322,NULL,'https://open.spotify.com/track/0GaBIpyHvytM1UBYmqXu08',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',70,7),('0GjbixPkXeAT7WnkjeK0OW','SNEAKERS (English Ver.)',179,NULL,'https://open.spotify.com/track/0GjbixPkXeAT7WnkjeK0OW',NULL,'0t98iMat2EXJthAhr844Sx','2KC9Qb60EaY0kW4eH68vr3',3,7),('0GR7iJLhj80KD5LkA14ZRn','Digital Dash',231,NULL,'https://open.spotify.com/track/0GR7iJLhj80KD5LkA14ZRn',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',68,1),('0GROiXm03OrMC5ltXLhGIu','The Party & The After Party',459,NULL,'https://open.spotify.com/track/0GROiXm03OrMC5ltXLhGIu',NULL,'7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',79,6),('0HFHNzO0YNjeLMFkRponJW','Algorhythm (Instrumental)',187,NULL,'https://open.spotify.com/track/0HFHNzO0YNjeLMFkRponJW',NULL,'7eNsf4qcc9uV6IklAlPp4b','2KC9Qb60EaY0kW4eH68vr3',1,3),('0HHKGXT6NQ83tUbVI31O1H','Wake Me Up (feat. Justice) - Single Version',210,NULL,'https://open.spotify.com/track/0HHKGXT6NQ83tUbVI31O1H',NULL,'0cLXqY56lwJjG7QNG2mzu7','1Xyo4u8uXC1ZmMpatF05PJ',49,1),('0HhSydjvwLiBjnVQCG5SjK','Heartless',198,NULL,'https://open.spotify.com/track/0HhSydjvwLiBjnVQCG5SjK',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',61,7),('0HlrCqaOwX1OELVHazSViS','나비의 겨울 (Live Version)',259,NULL,'https://open.spotify.com/track/0HlrCqaOwX1OELVHazSViS',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',4,4),('0Hs5enNuaAXmJssAybWbOw','XO / The Host',444,NULL,'https://open.spotify.com/track/0Hs5enNuaAXmJssAybWbOw',NULL,'04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',59,4),('0HyYb90jIOngSSLH5XfiAC','Treasure - Robert DeLong Instrumental',238,NULL,'https://open.spotify.com/track/0HyYb90jIOngSSLH5XfiAC',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',27,8),('0ifooM33X1iBxVYyOkSbXW','A Lonely Night',220,NULL,'https://open.spotify.com/track/0ifooM33X1iBxVYyOkSbXW',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',65,12),('0ijCESscFXtRc0dtDgu1Uv','Jingle Bell Rock',130,NULL,'https://open.spotify.com/track/0ijCESscFXtRc0dtDgu1Uv',NULL,'7dSaBwUid0hjWdJ5QzIKyu','6YVMFz59CuY7ngCxTxjpxE',50,1),('0ijomTqDdgr5eJZh3fhEWB','Not Shy - Inst.',177,NULL,'https://open.spotify.com/track/0ijomTqDdgr5eJZh3fhEWB',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',3,14),('0inMKhbKWOTDA9UBUAKoU6','Natalie',225,NULL,'https://open.spotify.com/track/0inMKhbKWOTDA9UBUAKoU6',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',62,7),('0iURDeNo6p5nSZfSQa0CX0','10E',252,NULL,'https://open.spotify.com/track/0iURDeNo6p5nSZfSQa0CX0',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',6,9),('0JaVdpmiex2EP7bBzyKVTa','November 18th',188,NULL,'https://open.spotify.com/track/0JaVdpmiex2EP7bBzyKVTa',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',61,5),('0jcXavoOHe9f99PE2sLg6T','WHISTLE (Remix Version) [Live]',194,NULL,'https://open.spotify.com/track/0jcXavoOHe9f99PE2sLg6T',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',33,12),('0jF2AdhsalO1L7KkhK4LE5','Practice',237,NULL,'https://open.spotify.com/track/0jF2AdhsalO1L7KkhK4LE5',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',79,17),('0jFFMDli8OnwhjeafpCudl','Believe In You',232,NULL,'https://open.spotify.com/track/0jFFMDli8OnwhjeafpCudl',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',10,4),('0JGoOLSl8A80mSPBL7ya9U','The Fall',345,NULL,'https://open.spotify.com/track/0JGoOLSl8A80mSPBL7ya9U',NULL,'04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',53,7),('0jmBgrVr9o9SlqHwZXrxL2','The Resistance',225,NULL,'https://open.spotify.com/track/0jmBgrVr9o9SlqHwZXrxL2',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',32,3),('0jQwDtWRc0SMKg038cKzEV','조금씩, 아주 조금씩 - Live',273,NULL,'https://open.spotify.com/track/0jQwDtWRc0SMKg038cKzEV',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,2),('0k1WUmIRnG3xU6fvvDVfRG','Way 2 Sexy (with Future & Young Thug)',257,NULL,'https://open.spotify.com/track/0k1WUmIRnG3xU6fvvDVfRG',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',76,7),('0K3w6WNawZlv6Izmsrye8o','Give Me Mercy',216,NULL,'https://open.spotify.com/track/0K3w6WNawZlv6Izmsrye8o',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',68,17),('0K75S1dgcmYDewhPR8Y0j6','Magical Dragon Sundance Mix',240,NULL,'https://open.spotify.com/track/0K75S1dgcmYDewhPR8Y0j6',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',0,13),('0kHlKWunEQ5zoQmKHNJT6P','K-POP - Chopped & Screwed',273,NULL,'https://open.spotify.com/track/0kHlKWunEQ5zoQmKHNJT6P',NULL,'0jiAYLsE1PumLJncO7vUIl','1Xyo4u8uXC1ZmMpatF05PJ',30,2),('0khQeEwEv6GndVypzpGOG5','Here We Go… Again (feat. Tyler, the Creator)',209,NULL,'https://open.spotify.com/track/0khQeEwEv6GndVypzpGOG5',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',47,8),('0KKkJNfGyhkQ5aFogxQAPU','That\'s What I Like',206,NULL,'https://open.spotify.com/track/0KKkJNfGyhkQ5aFogxQAPU',NULL,'4PgleR09JVnm3zY1fW3XBA','0du5cEVh5yTK9QJze8zA0C',89,4),('0kN8xEmgMW9mh7UmDYHlJP','Versace on the Floor',261,NULL,'https://open.spotify.com/track/0kN8xEmgMW9mh7UmDYHlJP',NULL,'4PgleR09JVnm3zY1fW3XBA','0du5cEVh5yTK9QJze8zA0C',82,5),('0koCW3qYu6cpHvLA61AEPQ','Treasure - Cash Cash Dub',280,NULL,'https://open.spotify.com/track/0koCW3qYu6cpHvLA61AEPQ',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',28,6),('0KqCs7XM8rsaRg9Kv8PbUa','Winter Ahead (with PARK HYO SHIN) : Silent Carol Ver.',214,NULL,'https://open.spotify.com/track/0KqCs7XM8rsaRg9Kv8PbUa',NULL,'4hcghI7Io7BFdHHsiaAylg','57htMBtzpppc1yoXgjbslj',58,3),('0kwrPQkiGVE8KTHalH1uMo','Super Shy',154,NULL,'https://open.spotify.com/track/0kwrPQkiGVE8KTHalH1uMo',NULL,'4N1fROq2oeyLGAlQ1C1j18','6HvZYsbFfjnjFrWF950C9d',62,2),('0l1p13Fbujayv894H0hfpS','Thursday',320,NULL,'https://open.spotify.com/track/0l1p13Fbujayv894H0hfpS',NULL,'6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',57,3),('0Lln3avC4adYwbWmVWEYKJ','Not Shy -Japanese ver.-',177,NULL,'https://open.spotify.com/track/0Lln3avC4adYwbWmVWEYKJ',NULL,'59vClLXHQp6vY4IfO0SDmm','2KC9Qb60EaY0kW4eH68vr3',2,4),('0LukDtOZSbHMxt69F4AZHO','You Broke My Heart - Instrumental',230,NULL,'https://open.spotify.com/track/0LukDtOZSbHMxt69F4AZHO',NULL,'3CHCm9n05a3tG4cQJ4rJwq','3TVXtAsR1Inumwj472S9r4',30,6),('0luScPN4CGX9SjAhvM6PcH','너에게',232,NULL,'https://open.spotify.com/track/0luScPN4CGX9SjAhvM6PcH',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',7,4),('0lUWGCpXozLqApCdup94Tu','Die For You',260,NULL,'https://open.spotify.com/track/0lUWGCpXozLqApCdup94Tu',NULL,'0YF085Qdh4HgdhZ8zjWkpo','1Xyo4u8uXC1ZmMpatF05PJ',40,2),('0m1KYWlT6LhFRBDVq9UNx4','HYFR (Hell Ya Fucking Right)',206,NULL,'https://open.spotify.com/track/0m1KYWlT6LhFRBDVq9UNx4',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',74,16),('0M3HkE321xpCbCYqVKzr1q','It Will Rain',257,NULL,'https://open.spotify.com/track/0M3HkE321xpCbCYqVKzr1q',NULL,'4A0vJtV9ok7vmr9ursSKj8','0du5cEVh5yTK9QJze8zA0C',84,1),('0mBKv9DkYfQHjdMcw2jdyI','Chunky',186,NULL,'https://open.spotify.com/track/0mBKv9DkYfQHjdMcw2jdyI',NULL,'4PgleR09JVnm3zY1fW3XBA','0du5cEVh5yTK9QJze8zA0C',72,2),('0MHStU0muAIEMbwdnebYu2','Takedown',182,NULL,'https://open.spotify.com/track/0MHStU0muAIEMbwdnebYu2',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',94,6),('0MjRPE2eH1ZQm9DC3BtZyq','추억은 사랑을 닮아',329,NULL,'https://open.spotify.com/track/0MjRPE2eH1ZQm9DC3BtZyq',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',39,2),('0mL82sxCRjrs3br407IdJh','Is There Someone Else?',199,NULL,'https://open.spotify.com/track/0mL82sxCRjrs3br407IdJh',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',84,10),('0Mrnt1YqVuW2bqmwu4VxDt','Amen (feat. Teezo Touchdown)',141,NULL,'https://open.spotify.com/track/0Mrnt1YqVuW2bqmwu4VxDt',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',60,2),('0Mt4kFSqMDBX4jezEUtujl','Evil Ways (feat. J. Cole) - Instrumental',227,NULL,'https://open.spotify.com/track/0Mt4kFSqMDBX4jezEUtujl',NULL,'3CHCm9n05a3tG4cQJ4rJwq','3TVXtAsR1Inumwj472S9r4',29,5),('0MVwfxOXQSzKkb8MxNS6WD','바보',281,NULL,'https://open.spotify.com/track/0MVwfxOXQSzKkb8MxNS6WD',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',8,5),('0MW6ssRaOVUfMToUp3YEZW','1178',301,NULL,'https://open.spotify.com/track/0MW6ssRaOVUfMToUp3YEZW',NULL,'3cjssumQEsRatYlYG5K86T','1rpgxJZxZMLnFNc1Jmyov5',1,5),('0mYUUdELRyMK4jf4LTrvNl','Deja-Vu',173,NULL,'https://open.spotify.com/track/0mYUUdELRyMK4jf4LTrvNl',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',12,7),('0MzhwexwISJcZjCl1XQDKR','사랑...그 흔한 말',268,NULL,'https://open.spotify.com/track/0MzhwexwISJcZjCl1XQDKR',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',24,9),('0n9tJMt5qtXOoPVlaNPvIM','Supernova - KENZIE RE:WORKS',212,NULL,'https://open.spotify.com/track/0n9tJMt5qtXOoPVlaNPvIM',NULL,'6HqiFsktBxto6ushwmDOUj','6YVMFz59CuY7ngCxTxjpxE',41,1),('0nAZGkBGKQCXyaoSJfRhC1','A Keeper',173,NULL,'https://open.spotify.com/track/0nAZGkBGKQCXyaoSJfRhC1',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',70,5),('0nJW01T7XtvILxQgC5J7Wh','When I Was Your Man',213,NULL,'https://open.spotify.com/track/0nJW01T7XtvILxQgC5J7Wh',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',89,6),('0NUqi0ps17YpLUC3kgsZq0','DIE TRYING',195,NULL,'https://open.spotify.com/track/0NUqi0ps17YpLUC3kgsZq0',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',86,15),('0Nwar8rweBUyfyuoyjjUvk','Privilege',170,NULL,'https://open.spotify.com/track/0Nwar8rweBUyfyuoyjjUvk',NULL,'4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',66,6),('0NWqNXBJTpXbkI5rPWNy3p','All I Know',321,NULL,'https://open.spotify.com/track/0NWqNXBJTpXbkI5rPWNy3p',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',64,16),('0NxzThg96Dvwu5qIjYFvgu','덤벼',247,NULL,'https://open.spotify.com/track/0NxzThg96Dvwu5qIjYFvgu',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',5,5),('0o5p5zzRN84q6qVbOVONPM','MEET YOUR PADRE',271,NULL,'https://open.spotify.com/track/0o5p5zzRN84q6qVbOVONPM',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',68,13),('0O9WkgPDfZ7A9DMDocF6ur','MELTDOWN (feat. Drake)',246,NULL,'https://open.spotify.com/track/0O9WkgPDfZ7A9DMDocF6ur',NULL,'61XhXTtorAgw4lRnh8GN0c','3TVXtAsR1Inumwj472S9r4',48,1),('0OajXvsbkfhx5CTn4gsAdB','The Lure (Main Theme) (with Mike Dean)',277,NULL,'https://open.spotify.com/track/0OajXvsbkfhx5CTn4gsAdB',NULL,'6E3IPXh38G7UHLqVdfIY5h','1Xyo4u8uXC1ZmMpatF05PJ',49,1),('0oB0vosSYizd8KQZvTYWeE','스무살',202,NULL,'https://open.spotify.com/track/0oB0vosSYizd8KQZvTYWeE',NULL,'4XpRhJEAxvXbKvOElITs0Z','1rpgxJZxZMLnFNc1Jmyov5',4,1),('0OPx1iz5ElDOcryHdwWfce','Millimicron Bomb',100,NULL,'https://open.spotify.com/track/0OPx1iz5ElDOcryHdwWfce',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',1,1),('0pdMOh52apEWAS1xELJY7Q','7969 Santa',259,NULL,'https://open.spotify.com/track/0pdMOh52apEWAS1xELJY7Q',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',53,8),('0PG9fbaaHFHfre2gUVo7AN','Please Me',200,NULL,'https://open.spotify.com/track/0PG9fbaaHFHfre2gUVo7AN',NULL,'5a4sJJ3qjn6hqRsvm0Veso','0du5cEVh5yTK9QJze8zA0C',81,1),('0q7LGcVSpsIoSbjChtZ8lI','Uptown (feat. Bun B & Lil Wayne)',382,NULL,'https://open.spotify.com/track/0q7LGcVSpsIoSbjChtZ8lI',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',62,12),('0QA625OAs3ZI7Eeu1Q2hZV','No Biggie (Instrumental)',181,NULL,'https://open.spotify.com/track/0QA625OAs3ZI7Eeu1Q2hZV',NULL,'7eNsf4qcc9uV6IklAlPp4b','2KC9Qb60EaY0kW4eH68vr3',0,4),('0qBeDyhZu5oER3MEu3lQ3P','거짓',257,NULL,'https://open.spotify.com/track/0qBeDyhZu5oER3MEu3lQ3P',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',4,13),('0QE33jkiMTzCI8momkDmQY','Sacrifice (Remix) (feat. Swedish House Mafia)',238,NULL,'https://open.spotify.com/track/0QE33jkiMTzCI8momkDmQY',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',46,20),('0QIjsbm2fh1cJ45XO9eGqq','Wake Up in the Sky',204,NULL,'https://open.spotify.com/track/0QIjsbm2fh1cJ45XO9eGqq',NULL,'7mkyc2BUahNfo0orKzqNGB','0du5cEVh5yTK9QJze8zA0C',74,1),('0QTSn3s6sd9Cq0N7Ir1wdA','꽃잎',368,NULL,'https://open.spotify.com/track/0QTSn3s6sd9Cq0N7Ir1wdA',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',0,1),('0QU89iGQgyw6f3wNkRJelN','편지',198,NULL,'https://open.spotify.com/track/0QU89iGQgyw6f3wNkRJelN',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',9,10),('0r9tyybf8eV2cvSpBnQH0e','칼',194,NULL,'https://open.spotify.com/track/0r9tyybf8eV2cvSpBnQH0e',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',8,9),('0sf62tS5AFYKV32QtcykFa','Moth To A Flame (with The Weeknd) - Extended Mix',298,NULL,'https://open.spotify.com/track/0sf62tS5AFYKV32QtcykFa',NULL,'0sye9Q82C9Q4tTJN8b0aFq','1Xyo4u8uXC1ZmMpatF05PJ',36,4),('0sSRLXxknVTQDStgU1NqpY','Hours In Silence',399,NULL,'https://open.spotify.com/track/0sSRLXxknVTQDStgU1NqpY',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',76,7),('0sTBOp1hdayTjw6UOyPyi6','Open Hearts',234,NULL,'https://open.spotify.com/track/0sTBOp1hdayTjw6UOyPyi6',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',78,7),('0SZZOg2yCKMN4VMAsrIDaK','나는 나비 - Live',263,NULL,'https://open.spotify.com/track/0SZZOg2yCKMN4VMAsrIDaK',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',2,1),('0Tacxc5lDJ8LwiO1pWNSl8','The Motion',240,NULL,'https://open.spotify.com/track/0Tacxc5lDJ8LwiO1pWNSl8',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',67,2),('0TieB6yzsEcyS85grL6MRv','Last Farewell Part.II (Bossa Nova Ver.)',206,NULL,'https://open.spotify.com/track/0TieB6yzsEcyS85grL6MRv',NULL,'3wtbBSjOhKOw7UdngHEDiO','57htMBtzpppc1yoXgjbslj',9,4),('0TlLq3lA83rQOYtrqBqSct','Nonstop',238,NULL,'https://open.spotify.com/track/0TlLq3lA83rQOYtrqBqSct',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',79,2),('0Tz1yVE10zhJZtz6WmRPYv','Girl Of My Dreams (Live Version)',258,NULL,'https://open.spotify.com/track/0Tz1yVE10zhJZtz6WmRPYv',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',0,10),('0u24lLekIGJ0CifIrHdD8N','Long Chat (#♥)',195,NULL,'https://open.spotify.com/track/0u24lLekIGJ0CifIrHdD8N',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',51,7),('0UGdO687azruy9tFlCxO6F','Montreal',250,NULL,'https://open.spotify.com/track/0UGdO687azruy9tFlCxO6F',NULL,'04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',61,2),('0uggesQXJQLUaZKCcVAAjj','Stormborn',251,NULL,'https://open.spotify.com/track/0uggesQXJQLUaZKCcVAAjj',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',16,3),('0UJRzax7oFLoK8Sb9IcPcm','Lovesick Girls - JP Ver.',192,NULL,'https://open.spotify.com/track/0UJRzax7oFLoK8Sb9IcPcm',NULL,'0nhyyhprFn6lcIAzTpmFDo','41MozSoPIsD1dJM0CLPjZF',47,1),('0Ul7obXHe7Ri1xRuQUZNwX','Story Of The Sea… - Outro',30,NULL,'https://open.spotify.com/track/0Ul7obXHe7Ri1xRuQUZNwX',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',8,17),('0uqrx65MT81Pz5hXQBCPDJ','먼 곳에서',227,NULL,'https://open.spotify.com/track/0uqrx65MT81Pz5hXQBCPDJ',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',17,14),('0V4l4GQhgnWQGtCWpvA7va','Crew Love',208,NULL,'https://open.spotify.com/track/0V4l4GQhgnWQGtCWpvA7va',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',74,4),('0VjIjW4GlUZAMYd2vXMi3b','Blinding Lights',200,NULL,'https://open.spotify.com/track/0VjIjW4GlUZAMYd2vXMi3b',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',92,9),('0vuiKizDyUXdIge9npkEKn','Double Fantasy (with Future) - Radio Edit',235,NULL,'https://open.spotify.com/track/0vuiKizDyUXdIge9npkEKn',NULL,'0Ct52rooGyvjv6qXrBPNzm','1Xyo4u8uXC1ZmMpatF05PJ',50,2),('0VXtmiTxjXHU8RlUObkhZj','해줄 수 없는 일',260,NULL,'https://open.spotify.com/track/0VXtmiTxjXHU8RlUObkhZj',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',3,14),('0w3Mfe4PIVjuFjJbe3OlYv','8am in Charlotte',266,NULL,'https://open.spotify.com/track/0w3Mfe4PIVjuFjJbe3OlYv',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',71,17),('0Wc5M4FK9Md0ZfMm6suCRN','Feel... Me.! (Feat. As One)',235,NULL,'https://open.spotify.com/track/0Wc5M4FK9Md0ZfMm6suCRN',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',6,11),('0WdJTI3UVvUMbLwPk5ObKI','D.D.',274,NULL,'https://open.spotify.com/track/0WdJTI3UVvUMbLwPk5ObKI',NULL,'04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',57,1),('0WiadRUdgEIjgmYFAmTttb','Life\'s Too Short',178,NULL,'https://open.spotify.com/track/0WiadRUdgEIjgmYFAmTttb',NULL,'2rwRvLdjGzjSYl9AS3UbvH','6YVMFz59CuY7ngCxTxjpxE',32,4),('0wQAFwLtz1WSfFALy5iOyN','사랑할 거야',222,NULL,'https://open.spotify.com/track/0wQAFwLtz1WSfFALy5iOyN',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',10,3),('0WrIAsGJOei2FGeakvpTDU','Heartless - Live',124,NULL,'https://open.spotify.com/track/0WrIAsGJOei2FGeakvpTDU',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,13),('0wshkEEcJUQU33RSRBb5dv','BackOutsideBoyz',152,NULL,'https://open.spotify.com/track/0wshkEEcJUQU33RSRBb5dv',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',66,4),('0WtNwdHv8UiDSVKDr3yRXn','그럴 이유가 하나도 없다',153,NULL,'https://open.spotify.com/track/0WtNwdHv8UiDSVKDr3yRXn',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',3,10),('0wwPcA6wtMf6HUMpIRdeP7','Hotline Bling',267,NULL,'https://open.spotify.com/track/0wwPcA6wtMf6HUMpIRdeP7',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',82,20),('0wzPHTgOtFIDhk2rD3Au4x','Angel',377,NULL,'https://open.spotify.com/track/0wzPHTgOtFIDhk2rD3Au4x',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',63,14),('0xa4hvXeYHRRNhA7wBfUar','Sacrifice',188,NULL,'https://open.spotify.com/track/0xa4hvXeYHRRNhA7wBfUar',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',59,5),('0XhOgqDKTQJhGfD1WBuTdC','Unforgettable',213,NULL,'https://open.spotify.com/track/0XhOgqDKTQJhGfD1WBuTdC',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',60,9),('0xl1w2q4VLojeXp4JfazPL','Sacrifices',307,NULL,'https://open.spotify.com/track/0xl1w2q4VLojeXp4JfazPL',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',61,12),('0XzH9qwVZaGdj73WR9k2cr','Goodbye Love (Inst.)',236,NULL,'https://open.spotify.com/track/0XzH9qwVZaGdj73WR9k2cr',NULL,'1V8uYmO4nGulH3YnSbBbWZ','57htMBtzpppc1yoXgjbslj',4,2),('0ya6ZVY40IOuWWrzTV3cjk','Close My Eyes',279,NULL,'https://open.spotify.com/track/0ya6ZVY40IOuWWrzTV3cjk',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',3,10),('0YDUEgoZd0ES5ru0UOCWQW','Only U',206,NULL,'https://open.spotify.com/track/0YDUEgoZd0ES5ru0UOCWQW',NULL,'2KnWel482zu05nLvSqNEzI','57htMBtzpppc1yoXgjbslj',14,4),('0yi180gAOIJhcRo7wY4Htl','I Feel It Coming (feat. Daft Punk)',269,NULL,'https://open.spotify.com/track/0yi180gAOIJhcRo7wY4Htl',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',54,18),('0YkUwXxnTkeJBvt5upeEtP','From Florida With Love',234,NULL,'https://open.spotify.com/track/0YkUwXxnTkeJBvt5upeEtP',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',62,12),('0ymDgXNt5qdPZmeSpAf3P0','Dawn FM - OPN Remix',184,NULL,'https://open.spotify.com/track/0ymDgXNt5qdPZmeSpAf3P0',NULL,'0Vz32hcNoqOZIpJVI0qExN','1Xyo4u8uXC1ZmMpatF05PJ',34,1),('0YQ7hl18bXabKzuTE0VwMV','WHISTLE',213,NULL,'https://open.spotify.com/track/0YQ7hl18bXabKzuTE0VwMV',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',42,12),('0YRxvM2dnH5ikS3nIxGUnj','숙녀예찬',267,NULL,'https://open.spotify.com/track/0YRxvM2dnH5ikS3nIxGUnj',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',8,2),('0yUjUg9LUFWyxmQtcUndw4','좋아 가는거야',228,NULL,'https://open.spotify.com/track/0yUjUg9LUFWyxmQtcUndw4',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',4,7),('0yvvXndlocJeq0ODgfKSaq','Better Things - Snack Version',45,NULL,'https://open.spotify.com/track/0yvvXndlocJeq0ODgfKSaq',NULL,'0jXtQE6F6FYFLPx0S3Gp1D','6YVMFz59CuY7ngCxTxjpxE',39,3),('0z7S7ArhLtHl2vzXyYPfIH','MENT 2',61,NULL,'https://open.spotify.com/track/0z7S7ArhLtHl2vzXyYPfIH',NULL,'21NNancB4Bdre5c5VRnbHk','2KC9Qb60EaY0kW4eH68vr3',11,6),('0zqy3ss4CwD6u4QPksS0nI','8 Out Of 10',195,NULL,'https://open.spotify.com/track/0zqy3ss4CwD6u4QPksS0nI',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',65,7),('10y0YlUXAEb8VUJ3HHQ6yY','Supernova',178,NULL,'https://open.spotify.com/track/10y0YlUXAEb8VUJ3HHQ6yY',NULL,'6uWbkjA7Osh3VNnnGeyfl6','6YVMFz59CuY7ngCxTxjpxE',27,5),('11L064movtyopGdLiX4sVg','Peak',206,NULL,'https://open.spotify.com/track/11L064movtyopGdLiX4sVg',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',63,1),('11pEKMLmavDu8fxOB5QjbQ','Pipe Down',205,NULL,'https://open.spotify.com/track/11pEKMLmavDu8fxOB5QjbQ',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',77,10),('11YovYUVkZdLyOFncbecWL','Our Night is more beautiful than your Day',192,NULL,'https://open.spotify.com/track/11YovYUVkZdLyOFncbecWL',NULL,'31chdu7JhVd0sC9X7sURNb','6HvZYsbFfjnjFrWF950C9d',62,1),('124NFj84ppZ5pAxTuVQYCQ','Take Care',277,NULL,'https://open.spotify.com/track/124NFj84ppZ5pAxTuVQYCQ',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',79,5),('127QTOFJsJQp5LbJbu3A1y','Toosie Slide',247,NULL,'https://open.spotify.com/track/127QTOFJsJQp5LbJbu3A1y',NULL,'3xIwVbGJuAcovYIhzbLO3J','3TVXtAsR1Inumwj472S9r4',73,1),('12d5QFwzh60IIHlsSnAvps','10 Bands',177,NULL,'https://open.spotify.com/track/12d5QFwzh60IIHlsSnAvps',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',65,3),('12Yy0hZrUebGnr3IrppPnW','Zero (J.I.D Remix)',224,NULL,'https://open.spotify.com/track/12Yy0hZrUebGnr3IrppPnW',NULL,'45wwQll1Ay4A1Rz79wWuNt','6HvZYsbFfjnjFrWF950C9d',55,1),('13e6f8t7RKXuxZ0JdaaJRG','Jorja Interlude',107,NULL,'https://open.spotify.com/track/13e6f8t7RKXuxZ0JdaaJRG',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',64,4),('13MF2TYuyfITClL1R2ei6e','BOOMBAYAH',240,NULL,'https://open.spotify.com/track/13MF2TYuyfITClL1R2ei6e',NULL,'0FOOodYRlj7gzh7q7IjmNZ','41MozSoPIsD1dJM0CLPjZF',79,2),('13NAmCCRYxRcr2NEtiWGa8','LOYAL (feat. Drake)',197,NULL,'https://open.spotify.com/track/13NAmCCRYxRcr2NEtiWGa8',NULL,'4OQEGCbts7MiJm8wfwC9BX','3TVXtAsR1Inumwj472S9r4',38,1),('147TR5QZzxTnnwqltaRi4N','Cece\'s Interlude',154,NULL,'https://open.spotify.com/track/147TR5QZzxTnnwqltaRi4N',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',57,12),('14OYmvxPRx8lABHthDN4AX','Get It B4',262,NULL,'https://open.spotify.com/track/14OYmvxPRx8lABHthDN4AX',NULL,'5aX2plzPm0m6zk4ZFuqbuI','1Xyo4u8uXC1ZmMpatF05PJ',42,3),('14p9UeyB3zxuo62wRjk5iR','Wanderlust',305,NULL,'https://open.spotify.com/track/14p9UeyB3zxuo62wRjk5iR',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',45,11),('14qKA9KZm3wfYjEMPQqRYb','애써 (Duet. 박화요비)',241,NULL,'https://open.spotify.com/track/14qKA9KZm3wfYjEMPQqRYb',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',15,3),('1560osUcXrnov6yuOjXvc1','No Face',137,NULL,'https://open.spotify.com/track/1560osUcXrnov6yuOjXvc1',NULL,'78NIQe42qKXahAeZAb3w0h','3TVXtAsR1Inumwj472S9r4',77,1),('15FZ1dQ8dTWMD6FUKzP3Zl','대꾸가 없네',264,NULL,'https://open.spotify.com/track/15FZ1dQ8dTWMD6FUKzP3Zl',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',2,3),('15k2nBQJ0teDmPZHrOXL2N','Ordinary Life',221,NULL,'https://open.spotify.com/track/15k2nBQJ0teDmPZHrOXL2N',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',63,14),('15ztraEuvqoyZIbu5lgevU','내게 와 줘 - Live',266,NULL,'https://open.spotify.com/track/15ztraEuvqoyZIbu5lgevU',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,4),('167wD7BlzcLxsX8PlSujCa','Dancing In The Flames - Acapella',203,NULL,'https://open.spotify.com/track/167wD7BlzcLxsX8PlSujCa',NULL,'0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',34,5),('16FRIbCsgA60AiJpTh2wYX','Creepin\' - Instrumental',221,NULL,'https://open.spotify.com/track/16FRIbCsgA60AiJpTh2wYX',NULL,'3P2UkOkqWp8ucd1EOnVAH7','1Xyo4u8uXC1ZmMpatF05PJ',28,3),('16u4IJEMSaTdIuWfvYBR9k','LOCO -Japanese ver.-',191,NULL,'https://open.spotify.com/track/16u4IJEMSaTdIuWfvYBR9k',NULL,'59vClLXHQp6vY4IfO0SDmm','2KC9Qb60EaY0kW4eH68vr3',2,6),('172dNs9GzyTXN6Sgs3Mr1O','Can\'t Leave You Alone',174,NULL,'https://open.spotify.com/track/172dNs9GzyTXN6Sgs3Mr1O',NULL,'2AgHdKsWib9wJJjQ1ohVHS','1rpgxJZxZMLnFNc1Jmyov5',7,1),('17pCKJQPDu0ms0xVgUObY7','철문을 열어',289,NULL,'https://open.spotify.com/track/17pCKJQPDu0ms0xVgUObY7',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',2,9),('18IC9WNmgzBORG9BPLX7vh','Sneakers',236,NULL,'https://open.spotify.com/track/18IC9WNmgzBORG9BPLX7vh',NULL,'6j5wyAhR4ijdLQfJrYDkNN','1rpgxJZxZMLnFNc1Jmyov5',2,1),('18nZWRpJIHzgb1SQr4ncwb','Supernova',178,NULL,'https://open.spotify.com/track/18nZWRpJIHzgb1SQr4ncwb',NULL,'7mpWlMAMdCErqVquIUHsiN','6YVMFz59CuY7ngCxTxjpxE',63,1),('18PSaTJMLkFNWnW0NWdOAW','Find Your Love',208,NULL,'https://open.spotify.com/track/18PSaTJMLkFNWnW0NWdOAW',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',62,13),('18t8ypY0HYaQuGBxg2KdT2','Free Spirit (feat. Rick Ross)',252,NULL,'https://open.spotify.com/track/18t8ypY0HYaQuGBxg2KdT2',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',58,13),('19ClKDKtc1a4tjtoluSpRO','해줄 수 없는 일',261,NULL,'https://open.spotify.com/track/19ClKDKtc1a4tjtoluSpRO',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',38,1),('19D8LNpWwIPpi6hs9BG7dq','Bubble Gum',200,NULL,'https://open.spotify.com/track/19D8LNpWwIPpi6hs9BG7dq',NULL,'0EhZEM4RRz0yioTgucDhJq','6HvZYsbFfjnjFrWF950C9d',75,2),('19ExOQdDvJTIzz2DV0dce2','창문너머 어렴풋이 옛 생각이 나겠지요 [From \"히말라야 스페셜 리메이크\"]',209,NULL,'https://open.spotify.com/track/19ExOQdDvJTIzz2DV0dce2',NULL,'0JQtZGkMyVK5SAAJlw4Qgt','1rpgxJZxZMLnFNc1Jmyov5',9,1),('1aQjCPrIvQm5cfY7FhAOhq','Over The Top (feat. Drake)',153,NULL,'https://open.spotify.com/track/1aQjCPrIvQm5cfY7FhAOhq',NULL,'1QpbqEgoFTEgqur3Odrcqc','3TVXtAsR1Inumwj472S9r4',58,1),('1AqyAbANWcx0B4f0WpYeM2','Life\'s Too Short (English Version)',178,NULL,'https://open.spotify.com/track/1AqyAbANWcx0B4f0WpYeM2',NULL,'2rwRvLdjGzjSYl9AS3UbvH','6YVMFz59CuY7ngCxTxjpxE',28,6),('1aRyIsgzfUdSGAGz8zgFR2','Flights, Not Feelings',181,NULL,'https://open.spotify.com/track/1aRyIsgzfUdSGAGz8zgFR2',NULL,'3OaW4df1SA62k0arNpn6bK','6YVMFz59CuY7ngCxTxjpxE',52,3),('1aYbbNLHNm6DZqlB7bFM4O','Embrace',223,NULL,'https://open.spotify.com/track/1aYbbNLHNm6DZqlB7bFM4O',NULL,'7e6PkMzboUpQPcnDiDQMOk','1rpgxJZxZMLnFNc1Jmyov5',16,1),('1b8L7w2aOmmaZ1BbWJurZZ','STAY (Live)',261,NULL,'https://open.spotify.com/track/1b8L7w2aOmmaZ1BbWJurZZ',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',32,14),('1bAvtmTl0F9loyz9AwPwp7','Losers',281,NULL,'https://open.spotify.com/track/1bAvtmTl0F9loyz9AwPwp7',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',61,2),('1bDbXMyjaUIooNwFE9wn0N','Rich Flex',239,NULL,'https://open.spotify.com/track/1bDbXMyjaUIooNwFE9wn0N',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',78,1),('1BEMASUZQDqN5UGxMb1m6A','That\'s What I Like (feat. Gucci Mane)',234,NULL,'https://open.spotify.com/track/1BEMASUZQDqN5UGxMb1m6A',NULL,'1z4Zl2hcCiRyB4uIPeqEfr','0du5cEVh5yTK9QJze8zA0C',52,1),('1bZE8AKQ7Y6x3qcD4zt1qw','Hey U Come On',288,NULL,'https://open.spotify.com/track/1bZE8AKQ7Y6x3qcD4zt1qw',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',9,2),('1C7KSXR2GVxknex6I4ANco','9',255,NULL,'https://open.spotify.com/track/1C7KSXR2GVxknex6I4ANco',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',84,2),('1CatlSR0Kh0hsvGF2Z8l3s','Family (with Suzanna Son)',183,NULL,'https://open.spotify.com/track/1CatlSR0Kh0hsvGF2Z8l3s',NULL,'5bx7i3cuSfXBPF7Li8kUR7','1Xyo4u8uXC1ZmMpatF05PJ',52,1),('1cdbkpZ3q1KYZDNSrOpdkb','Ice Cream (with Selena Gomez)',175,NULL,'https://open.spotify.com/track/1cdbkpZ3q1KYZDNSrOpdkb',NULL,'2gNPnKP1PDkB5SZz3IMKuX','41MozSoPIsD1dJM0CLPjZF',68,2),('1cKHdTo9u0ZymJdPGSh6nq','I Was Never There',241,NULL,'https://open.spotify.com/track/1cKHdTo9u0ZymJdPGSh6nq',NULL,'4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',86,4),('1cLrKzoZsqdoazJAzNvBEJ','HAPPY TOGETHER',252,NULL,'https://open.spotify.com/track/1cLrKzoZsqdoazJAzNvBEJ',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',31,7),('1CPZ5BxNNd0n0nF4Orb9JS','Golden',194,NULL,'https://open.spotify.com/track/1CPZ5BxNNd0n0nF4Orb9JS','UFlLTAag2bE','14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',99,4),('1cSh61cAJBP25IsXo59V2S','UNTOUCHABLE',194,NULL,'https://open.spotify.com/track/1cSh61cAJBP25IsXo59V2S',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',36,2),('1czrq37TgpyHwILAkY3y72','Show Your Love (Live Version)',223,NULL,'https://open.spotify.com/track/1czrq37TgpyHwILAkY3y72',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',2,14),('1D9XLqQp2YYiOxrr5KLb8K','Under Ground Kings',212,NULL,'https://open.spotify.com/track/1D9XLqQp2YYiOxrr5KLb8K',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',66,8),('1DAibqbopEYULPEtE8WHTE','What Would Pluto Do',182,NULL,'https://open.spotify.com/track/1DAibqbopEYULPEtE8WHTE',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',65,15),('1dKXBUKx7oCB2UXlkihNn8','8am in Charlotte',266,NULL,'https://open.spotify.com/track/1dKXBUKx7oCB2UXlkihNn8',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',54,17),('1dLDAay6eB0CWDus6V5TcY','Crazy Over You',176,NULL,'https://open.spotify.com/track/1dLDAay6eB0CWDus6V5TcY',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',44,2),('1DmnEYXa4WfbdhAPwNzgD8','30 for 30 Freestyle',253,NULL,'https://open.spotify.com/track/1DmnEYXa4WfbdhAPwNzgD8',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',59,11),('1DQGIcihPgi4kDCdx1fEn0','How Do I Make You Love Me? - Sebastian Ingrosso & Salvatore Ganacci Remix',217,NULL,'https://open.spotify.com/track/1DQGIcihPgi4kDCdx1fEn0',NULL,'181WKxuhHzTyjMcYdI7UUe','1Xyo4u8uXC1ZmMpatF05PJ',41,1),('1dUHF4RyMmMTveJ0Rby6Xm','Can’t Take A Joke',163,NULL,'https://open.spotify.com/track/1dUHF4RyMmMTveJ0Rby6Xm',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',67,9),('1E5Xu8dur0fAjSP1VpVhAZ','Best Friends',163,NULL,'https://open.spotify.com/track/1E5Xu8dur0fAjSP1VpVhAZ',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',65,9),('1eCFz60zd7mAXgWLapPd9B','Currents',157,NULL,'https://open.spotify.com/track/1eCFz60zd7mAXgWLapPd9B',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',63,4),('1EoHEkVcysf4WVDx6r9WzQ','Over',233,NULL,'https://open.spotify.com/track/1EoHEkVcysf4WVDx6r9WzQ',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',65,4),('1eoHLwYFCgpemHFQuMsV9w','Mr. Vampire',170,NULL,'https://open.spotify.com/track/1eoHLwYFCgpemHFQuMsV9w',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',19,3),('1EOWf8bsePF6QtiDUAclrJ','Catch a Grenade - The Hooligans Remix',210,NULL,'https://open.spotify.com/track/1EOWf8bsePF6QtiDUAclrJ',NULL,'54DNHFsfCa7nlQFWXMg7y3','0du5cEVh5yTK9QJze8zA0C',62,2),('1eroCliWpJrEu1V7VSObcO','Circadian Rhythm',126,NULL,'https://open.spotify.com/track/1eroCliWpJrEu1V7VSObcO',NULL,'5oT8PMXGWiPlhcl930fkII','3TVXtAsR1Inumwj472S9r4',78,1),('1ewMCmw7qCb5a9ttqiyemu','Liquor Store Blues (feat. Damian Marley)',229,NULL,'https://open.spotify.com/track/1ewMCmw7qCb5a9ttqiyemu',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',60,8),('1F6nHHDJyTHLgDDFj1ZZDt','SOMETHING ABOUT YOU',218,NULL,'https://open.spotify.com/track/1F6nHHDJyTHLgDDFj1ZZDt',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',78,3),('1Ffw1qFqCw2IaozOJ5mL2O','Leave The Door Open - Live',260,NULL,'https://open.spotify.com/track/1Ffw1qFqCw2IaozOJ5mL2O',NULL,'4rRB9bAIwawVcrdLXuq9Qu','0du5cEVh5yTK9QJze8zA0C',59,1),('1FvR2eCb9CUwpEpc9soD0V','반딧불 … 그 슬픔에 대한 질문',301,NULL,'https://open.spotify.com/track/1FvR2eCb9CUwpEpc9soD0V',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',4,7),('1FwyGcGpRmbpESxc80WNix','Ment 2_CHALLENGE',101,NULL,'https://open.spotify.com/track/1FwyGcGpRmbpESxc80WNix',NULL,'21NNancB4Bdre5c5VRnbHk','2KC9Qb60EaY0kW4eH68vr3',11,4),('1G0JddH0MHVg4VE03vheBm','Show Me A Good Time',210,NULL,'https://open.spotify.com/track/1G0JddH0MHVg4VE03vheBm',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',51,5),('1G2X1zx9IIuAB2N9qsB25a','그녀를 알아요',255,NULL,'https://open.spotify.com/track/1G2X1zx9IIuAB2N9qsB25a',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',11,9),('1G73gINM14qd8cE3Lf8V1z','Dancing In The Flames - Live from São Paulo',312,NULL,'https://open.spotify.com/track/1G73gINM14qd8cE3Lf8V1z',NULL,'0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',37,3),('1GaV3vb90TFmiSJFuljrN1','바보 (Instrumental)',282,NULL,'https://open.spotify.com/track/1GaV3vb90TFmiSJFuljrN1',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',4,15),('1gGU3FKR2pXcYpaLb4fAVn','DDU-DU DDU-DU (Remix Version) [Live]',207,NULL,'https://open.spotify.com/track/1gGU3FKR2pXcYpaLb4fAVn',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',32,13),('1GIEA7uraLfdQbLiPsgPoH','Sound of Winter - Inst.',411,NULL,'https://open.spotify.com/track/1GIEA7uraLfdQbLiPsgPoH',NULL,'0ssxpVNMYMHeKXV00VUCkJ','57htMBtzpppc1yoXgjbslj',8,2),('1GLElUfcuWfcYLVNxL3Wvh','왕관 쓴 바보',251,NULL,'https://open.spotify.com/track/1GLElUfcuWfcYLVNxL3Wvh',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',2,2),('1GMufNnkKAnPLnqKJ5HHxW','Lovesick Girls',192,NULL,'https://open.spotify.com/track/1GMufNnkKAnPLnqKJ5HHxW',NULL,'2gNPnKP1PDkB5SZz3IMKuX','41MozSoPIsD1dJM0CLPjZF',74,5),('1GpWY5RiInhezB8wGWs6oN','7969 Santa',259,NULL,'https://open.spotify.com/track/1GpWY5RiInhezB8wGWs6oN',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',63,8),('1Gsw3AyAvDulZI9lHIRr3E','A Flying Butterfly',352,NULL,'https://open.spotify.com/track/1Gsw3AyAvDulZI9lHIRr3E',NULL,'2YVpqON0I1KS8LjQLqV0uH','1rpgxJZxZMLnFNc1Jmyov5',0,5),('1GxHeBvQ9935Dd3cSfsfBa','Best I Ever Had',258,NULL,'https://open.spotify.com/track/1GxHeBvQ9935Dd3cSfsfBa',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',58,15),('1gZADNt16Oh23jWyMYRk4p','Prisoner',274,NULL,'https://open.spotify.com/track/1gZADNt16Oh23jWyMYRk4p',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',68,13),('1h345CZmt3uU9bym4GETWd','Dancing In The Flames - Instrumental',221,NULL,'https://open.spotify.com/track/1h345CZmt3uU9bym4GETWd',NULL,'0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',34,4),('1HnhCD1u0c4dHSMazmWGyM','Wu-Tang Forever',217,NULL,'https://open.spotify.com/track/1HnhCD1u0c4dHSMazmWGyM',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',58,4),('1Hp7vdJwQ4ozmAJzPAJpfX','Snowchild',247,NULL,'https://open.spotify.com/track/1Hp7vdJwQ4ozmAJzPAJpfX',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',48,5),('1hPIpoUwxbXBp5fGMSDcXx','AS IF IT’S YOUR LAST - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',223,NULL,'https://open.spotify.com/track/1hPIpoUwxbXBp5fGMSDcXx',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',39,12),('1HsI8FQIwXXGWce9MlPMlF','사랑은 교통사고',234,NULL,'https://open.spotify.com/track/1HsI8FQIwXXGWce9MlPMlF',NULL,'75fZ4eJHsRFNpn4VDoQbKb','1rpgxJZxZMLnFNc1Jmyov5',3,1),('1I2FQg7ki1sySmsN8lKqpw','조금씩 아주 조금씩',273,NULL,'https://open.spotify.com/track/1I2FQg7ki1sySmsN8lKqpw',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',2,9),('1I2MEjnS9c4OPMnKWbIuYs','Hard to Love',162,NULL,'https://open.spotify.com/track/1I2MEjnS9c4OPMnKWbIuYs',NULL,'0S4pP8MBY9p7ngFWIZQAJv','41MozSoPIsD1dJM0CLPjZF',65,5),('1I37Zz2g3hk9eWxaNkj031','Your Idol',191,NULL,'https://open.spotify.com/track/1I37Zz2g3hk9eWxaNkj031','2FS3JAPTKXs','14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',97,7),('1I55Ea0zVoSKs6MqW7DQ3i','War',180,NULL,'https://open.spotify.com/track/1I55Ea0zVoSKs6MqW7DQ3i',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',62,14),('1I6pKIyaBp4OebTGLJpCCC','Perm',210,NULL,'https://open.spotify.com/track/1I6pKIyaBp4OebTGLJpCCC',NULL,'4PgleR09JVnm3zY1fW3XBA','0du5cEVh5yTK9QJze8zA0C',66,3),('1I7C8U5MLwQtn7qOl38hFI','담배가게 아가씨 - Live',281,NULL,'https://open.spotify.com/track/1I7C8U5MLwQtn7qOl38hFI',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',13,9),('1IA9021Q5gkRwTM99Xtsqh','Spice',191,NULL,'https://open.spotify.com/track/1IA9021Q5gkRwTM99Xtsqh',NULL,'2u0QU6DP2HL5t9cp04vzBT','2KC9Qb60EaY0kW4eH68vr3',7,2),('1ID1QFSNNxi0hiZCNcwjUC','Legend',241,NULL,'https://open.spotify.com/track/1ID1QFSNNxi0hiZCNcwjUC',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',66,1),('1IIW2rIolLy3kJpx4QOJRN','Like Magic',164,NULL,'https://open.spotify.com/track/1IIW2rIolLy3kJpx4QOJRN',NULL,'0CYZzTggBObmmQQvl2XqU8','2KC9Qb60EaY0kW4eH68vr3',39,1),('1ImRS2KtSaDZcj9vQTxwFA','Dirty Work',180,NULL,'https://open.spotify.com/track/1ImRS2KtSaDZcj9vQTxwFA',NULL,'1oJztb2MfwieRwHZ1t4NrN','6YVMFz59CuY7ngCxTxjpxE',80,1),('1iNvVaWmlKJns2LNTXN39Q','aenergy',147,NULL,'https://open.spotify.com/track/1iNvVaWmlKJns2LNTXN39Q',NULL,'3vyyDkvYWC36DwgZCYd3Wu','6YVMFz59CuY7ngCxTxjpxE',62,1),('1iyUHRKh3Z4nnfeNBMdHqy','딴짓거리',191,NULL,'https://open.spotify.com/track/1iyUHRKh3Z4nnfeNBMdHqy',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',7,1),('1JdqLu74P8HXiie7i8e0ks','Never give up - Instrumental',199,NULL,'https://open.spotify.com/track/1JdqLu74P8HXiie7i8e0ks',NULL,'2wEGWJx63eWqMBIudI3LsZ','1rpgxJZxZMLnFNc1Jmyov5',0,2),('1jT1njjQ3JU6DYonYRG8MU','RINGO',209,NULL,'https://open.spotify.com/track/1jT1njjQ3JU6DYonYRG8MU',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',14,1),('1Jz0fAhw41suiAVekjAoLi','Dawn FM - OPN Remix',183,NULL,'https://open.spotify.com/track/1Jz0fAhw41suiAVekjAoLi',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',42,18),('1kHAbyXgMowPPZfpxDImL3','MENT 2_SOLO STAGE INTRODUCING',583,NULL,'https://open.spotify.com/track/1kHAbyXgMowPPZfpxDImL3',NULL,'21NNancB4Bdre5c5VRnbHk','2KC9Qb60EaY0kW4eH68vr3',12,5),('1kNdtonJXHorsVpWerK8C2','Intro',36,NULL,'https://open.spotify.com/track/1kNdtonJXHorsVpWerK8C2',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',58,1),('1KtU0WCq472KzqCXgMOxkS','That\'s What I Like - Alan Walker Remix',195,NULL,'https://open.spotify.com/track/1KtU0WCq472KzqCXgMOxkS',NULL,'6LD3J50OxLEQbAB8ahoj1S','0du5cEVh5yTK9QJze8zA0C',62,1),('1L0OmJV0LnPDWuHCIGmBV6','On The Radar Freestyle',275,NULL,'https://open.spotify.com/track/1L0OmJV0LnPDWuHCIGmBV6',NULL,'0xjql3TEYd34hlAky4Ck2z','3TVXtAsR1Inumwj472S9r4',67,1),('1L8ObNUDCh7k6GwDIbfx9Q','Popular (with Playboi Carti & Madonna)',215,NULL,'https://open.spotify.com/track/1L8ObNUDCh7k6GwDIbfx9Q',NULL,'0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',59,1),('1lqzBlNSznB837gImhxRQO','ICY (English Ver.)',191,NULL,'https://open.spotify.com/track/1lqzBlNSznB837gImhxRQO',NULL,'6zWajG8oLkshBrkjIMPbjQ','2KC9Qb60EaY0kW4eH68vr3',1,3),('1luU6xtDRnYekLvVM1gzoy','그래 그건 그냥 그런 걸 꺼야',274,NULL,'https://open.spotify.com/track/1luU6xtDRnYekLvVM1gzoy',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',2,7),('1lwYe6UZTE4anFP1MCBbf8','애화',247,NULL,'https://open.spotify.com/track/1lwYe6UZTE4anFP1MCBbf8',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',7,12),('1mdtLny0zugh89vokWGG80','Hot Air Balloon',198,NULL,'https://open.spotify.com/track/1mdtLny0zugh89vokWGG80',NULL,'5NMtxQJy4wq3mpo3ERVnLs','6YVMFz59CuY7ngCxTxjpxE',54,4),('1mhVXWduD8ReDwusfaHNwU','Tell Your Friends',334,NULL,'https://open.spotify.com/track/1mhVXWduD8ReDwusfaHNwU',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',68,3),('1mjAD7IYvI5UGiB7WnppMf','BBL Love - Interlude',161,NULL,'https://open.spotify.com/track/1mjAD7IYvI5UGiB7WnppMf',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',57,18),('1mKNJs35ede94bTPWveVOo','GLORIOUS',205,NULL,'https://open.spotify.com/track/1mKNJs35ede94bTPWveVOo',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',65,19),('1MTXYvJ9TSqg9x6WPCDx2n','3AM on Glenwood',178,NULL,'https://open.spotify.com/track/1MTXYvJ9TSqg9x6WPCDx2n',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',59,15),('1ndfrDQJSPh7KsAgfMtuYL','Armageddon',196,NULL,'https://open.spotify.com/track/1ndfrDQJSPh7KsAgfMtuYL',NULL,'6uWbkjA7Osh3VNnnGeyfl6','6YVMFz59CuY7ngCxTxjpxE',28,6),('1nH2PkJL1XoUq8oE6tBZoU','Sacrifice',188,NULL,'https://open.spotify.com/track/1nH2PkJL1XoUq8oE6tBZoU',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',73,5),('1NhjYYcYTRywc0di98xHxf','Here We Go… Again (feat. Tyler, the Creator)',209,NULL,'https://open.spotify.com/track/1NhjYYcYTRywc0di98xHxf',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',63,8),('1nLJnhpZYz3358KBYqjHJk','Treasure - Robert DeLong Remix',240,NULL,'https://open.spotify.com/track/1nLJnhpZYz3358KBYqjHJk',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',27,7),('1NlK2NtpuUazpziLhnJwEV','Phantom Regret by Jim',179,NULL,'https://open.spotify.com/track/1NlK2NtpuUazpziLhnJwEV',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',54,16),('1nSzCAvAvzJj5oIt7m90G0','24K Magic - R3hab Remix',158,NULL,'https://open.spotify.com/track/1nSzCAvAvzJj5oIt7m90G0',NULL,'1onK6XeDccA2NW6SlzQMNK','0du5cEVh5yTK9QJze8zA0C',59,1),('1o844wI52S3TjXGBwvGcc7','Hold On Tight',149,NULL,'https://open.spotify.com/track/1o844wI52S3TjXGBwvGcc7',NULL,'4bWGRs1SqNwFXaRDXRAANN','6YVMFz59CuY7ngCxTxjpxE',73,1),('1oCyEPXnvytOWS5S9mBE8N','Alone Again',250,NULL,'https://open.spotify.com/track/1oCyEPXnvytOWS5S9mBE8N',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',50,1),('1oERlssLrpssCAY6Yqqs6c','Smokin Out The Window',197,NULL,'https://open.spotify.com/track/1oERlssLrpssCAY6Yqqs6c',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',66,5),('1oeUB0uN1MpMPJnGxb77xG','Lovesick Girls',193,NULL,'https://open.spotify.com/track/1oeUB0uN1MpMPJnGxb77xG',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',43,6),('1oGdVdYjeQvojGKDddxLQQ','True Colors',206,NULL,'https://open.spotify.com/track/1oGdVdYjeQvojGKDddxLQQ',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',63,7),('1OHoBC4icbuNhpSxP400sv','Preach',236,NULL,'https://open.spotify.com/track/1OHoBC4icbuNhpSxP400sv',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',71,9),('1OscRS80PF5n0hDkI9S1F2','Next Level - IMLAY Remix',225,NULL,'https://open.spotify.com/track/1OscRS80PF5n0hDkI9S1F2',NULL,'36cJnr7GCuGbuw0YQpjmTY','6YVMFz59CuY7ngCxTxjpxE',36,2),('1oYV1xSoGhxG0AY4SJVT76','ICY - Inst.',191,NULL,'https://open.spotify.com/track/1oYV1xSoGhxG0AY4SJVT76',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',4,12),('1p92v8Plu8rO08f97Lu7Vo','머리 아파',215,NULL,'https://open.spotify.com/track/1p92v8Plu8rO08f97Lu7Vo',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',4,13),('1PDP7mLiAMwhfmgIwzhOm2','Yebba’s Heartbreak',133,NULL,'https://open.spotify.com/track/1PDP7mLiAMwhfmgIwzhOm2',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',80,11),('1PIgY9ybyFT9uWLM5POYGY','All The Parties (feat. Chief Keef)',218,NULL,'https://open.spotify.com/track/1PIgY9ybyFT9uWLM5POYGY',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',65,16),('1q9V1vsIEehAm2hDT6l53g','Hurt (250 Remix) (Instrumental)',216,NULL,'https://open.spotify.com/track/1q9V1vsIEehAm2hDT6l53g',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',47,12),('1QBwk6GTCxVdC2hoSw9tlM','Lord Knows',307,NULL,'https://open.spotify.com/track/1QBwk6GTCxVdC2hoSw9tlM',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',67,11),('1qibkzndwqYaj6dwGx92p1','Escalator',200,NULL,'https://open.spotify.com/track/1qibkzndwqYaj6dwGx92p1',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',10,10),('1qIwin7JMVuX70qN6wD8ww','It\'s Up (feat. Young Thug & 21 Savage)',278,NULL,'https://open.spotify.com/track/1qIwin7JMVuX70qN6wD8ww',NULL,'5oT8PMXGWiPlhcl930fkII','3TVXtAsR1Inumwj472S9r4',73,2),('1qyFlfPREPbRcS2BNszdYI','Dreams Money Can Buy',253,NULL,'https://open.spotify.com/track/1qyFlfPREPbRcS2BNszdYI',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',59,1),('1R0lSA8A8nN88U0TVUev9p','I Promise You',263,NULL,'https://open.spotify.com/track/1R0lSA8A8nN88U0TVUev9p',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',15,9),('1Rfs2vkaFqvAPk6x3bEc6v','바다',305,NULL,'https://open.spotify.com/track/1Rfs2vkaFqvAPk6x3bEc6v',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',2,7),('1rKQjUhF9zFJmuUotr3VkV','TAKEDOWN (JEONGYEON, JIHYO, CHAEYOUNG)',181,NULL,'https://open.spotify.com/track/1rKQjUhF9zFJmuUotr3VkV',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',91,1),('1RlcvK95g0XfRpDvFbGLUO','K-POP',185,NULL,'https://open.spotify.com/track/1RlcvK95g0XfRpDvFbGLUO',NULL,'0jiAYLsE1PumLJncO7vUIl','1Xyo4u8uXC1ZmMpatF05PJ',40,1),('1s3p7Zb6CzuDS42whlymwj','Jingle Bell Rock',130,NULL,'https://open.spotify.com/track/1s3p7Zb6CzuDS42whlymwj',NULL,'5I5Bz7STXgcn5X2NYrDl2I','6YVMFz59CuY7ngCxTxjpxE',33,2),('1S9DHKpS73KFVN7nnIql3f','Moth To A Flame (with The Weeknd)',234,NULL,'https://open.spotify.com/track/1S9DHKpS73KFVN7nnIql3f',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',56,17),('1Sj81sMg37Hd4omn7Ow2qR','Connect',296,NULL,'https://open.spotify.com/track/1Sj81sMg37Hd4omn7Ow2qR',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',53,9),('1SLsDrKugNzhjksXYMDkm5','BORN TO BE (Final Ver.)',178,NULL,'https://open.spotify.com/track/1SLsDrKugNzhjksXYMDkm5',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',13,7),('1sOW4PuG5X3Ie3EXUhAopJ','Escape From LA',355,NULL,'https://open.spotify.com/track/1sOW4PuG5X3Ie3EXUhAopJ',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',68,6),('1t2qYCAjUAoGfeFeoBlK51','Black Mamba',174,NULL,'https://open.spotify.com/track/1t2qYCAjUAoGfeFeoBlK51',NULL,'3syEYrKIsgxaZMB5t1dVG7','6YVMFz59CuY7ngCxTxjpxE',65,1),('1tcWDBYQbJZVixZzsBWB0P','Die For You - Instrumental',259,NULL,'https://open.spotify.com/track/1tcWDBYQbJZVixZzsBWB0P',NULL,'0YF085Qdh4HgdhZ8zjWkpo','1Xyo4u8uXC1ZmMpatF05PJ',36,3),('1tLjui35K8JiKJtggk7dRZ','뱃노래',265,NULL,'https://open.spotify.com/track/1tLjui35K8JiKJtggk7dRZ',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',4,15),('1Tnw0ItH1Macok8gblnPPd','Is There More',226,NULL,'https://open.spotify.com/track/1Tnw0ItH1Macok8gblnPPd',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',57,12),('1Tr5FhvxC4IlRXYJHCXJdZ','Creepin\'',221,NULL,'https://open.spotify.com/track/1Tr5FhvxC4IlRXYJHCXJdZ',NULL,'3P2UkOkqWp8ucd1EOnVAH7','1Xyo4u8uXC1ZmMpatF05PJ',51,2),('1TXdmgWRlemXq8d8Q8OLRX','좋은 사람',234,NULL,'https://open.spotify.com/track/1TXdmgWRlemXq8d8Q8OLRX',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',11,3),('1ULdASrNy5rurl1TZfFaMP','Spicy',197,NULL,'https://open.spotify.com/track/1ULdASrNy5rurl1TZfFaMP',NULL,'69xF8jTd0c4Zoo7DT3Rwrn','6YVMFz59CuY7ngCxTxjpxE',67,2),('1us5wNgZc0YLT8RQQs2Q7L','Daylight',164,NULL,'https://open.spotify.com/track/1us5wNgZc0YLT8RQQs2Q7L',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',51,5),('1v24T2ug4TlssYZvI3aL4O','Lust For Life',176,NULL,'https://open.spotify.com/track/1v24T2ug4TlssYZvI3aL4O',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',57,1),('1vbn9fEyw1IYhqgZJdu9ZB','Falling Back',266,NULL,'https://open.spotify.com/track/1vbn9fEyw1IYhqgZJdu9ZB',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',64,2),('1VJI7olL2jgFIaefxSnEXp','Love Barista (Feat. Seo In Guk)',266,NULL,'https://open.spotify.com/track/1VJI7olL2jgFIaefxSnEXp',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',11,12),('1vvK3Ey7LxgAFidEmU3QvC','Treasure - Audien Radio Edit',232,NULL,'https://open.spotify.com/track/1vvK3Ey7LxgAFidEmU3QvC',NULL,'7yBnuW3SpMKy3EB9iU0C7p','0du5cEVh5yTK9QJze8zA0C',34,2),('1vZlLxDDSn6JE0aSC1KHnx','외람된 말씀',202,NULL,'https://open.spotify.com/track/1vZlLxDDSn6JE0aSC1KHnx',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',5,4),('1wFFFzJ5EsKbBWZriAcubN','Family Matters',456,NULL,'https://open.spotify.com/track/1wFFFzJ5EsKbBWZriAcubN',NULL,'3qwCuSISrIUpyt6sB5edmQ','3TVXtAsR1Inumwj472S9r4',73,1),('1WFj1P1TUJJXH1R41PP9Vg','Blue Whale - 2016 Version',201,NULL,'https://open.spotify.com/track/1WFj1P1TUJJXH1R41PP9Vg',NULL,'2wA8OXIv1JXX9kTY2ddfR4','1rpgxJZxZMLnFNc1Jmyov5',48,2),('1wHApxTRenieRzK9SwK3yQ','꿈꾸는 소녀',245,NULL,'https://open.spotify.com/track/1wHApxTRenieRzK9SwK3yQ',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',13,5),('1wUnuiXMMvhudmzvcCtlZP','Get Up',36,NULL,'https://open.spotify.com/track/1wUnuiXMMvhudmzvcCtlZP',NULL,'4N1fROq2oeyLGAlQ1C1j18','6HvZYsbFfjnjFrWF950C9d',71,5),('1wVuPmvt6AWvTL5W2GJnzZ','Talking to the Moon',217,NULL,'https://open.spotify.com/track/1wVuPmvt6AWvTL5W2GJnzZ',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',78,7),('1WWR7F24UbFi06sfvcnvD8','Grenade',222,NULL,'https://open.spotify.com/track/1WWR7F24UbFi06sfvcnvD8',NULL,'54DNHFsfCa7nlQFWXMg7y3','0du5cEVh5yTK9QJze8zA0C',58,1),('1X1BT1SyKnzrvsjao6R5wN','Whiplash - Steve Aoki Remix',225,NULL,'https://open.spotify.com/track/1X1BT1SyKnzrvsjao6R5wN',NULL,'4nGujzCa6JLhMx7rHXE4J9','6YVMFz59CuY7ngCxTxjpxE',51,2),('1x1oCGsFUDViOvcISuoKW0','Live My Life',159,NULL,'https://open.spotify.com/track/1x1oCGsFUDViOvcISuoKW0',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',63,9),('1XsRwo2it6QHdV2OiT6IzF','Tie That Binds',336,NULL,'https://open.spotify.com/track/1XsRwo2it6QHdV2OiT6IzF',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',60,12),('1xWhryugRBpNXx4o947UVh','스니커즈 - Live',240,NULL,'https://open.spotify.com/track/1xWhryugRBpNXx4o947UVh',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,6),('1yeB8MUNeLo9Ek1UEpsyz6','Rich Baby Daddy (feat. Sexyy Red & SZA)',319,NULL,'https://open.spotify.com/track/1yeB8MUNeLo9Ek1UEpsyz6',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',81,20),('1YHQQFtKqFSFrqL4cNvstU','SMALL TOWN FAME',148,NULL,'https://open.spotify.com/track/1YHQQFtKqFSFrqL4cNvstU',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',71,7),('1ywwObadN3168Hibf5yblZ','어느새',296,NULL,'https://open.spotify.com/track/1ywwObadN3168Hibf5yblZ',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',12,5),('1zi7xx7UVEFkmKfv06H8x0','One Dance',173,NULL,'https://open.spotify.com/track/1zi7xx7UVEFkmKfv06H8x0',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',90,12),('1ZJpYHYLZoxaJcBhBplwtb','Li-La',232,NULL,'https://open.spotify.com/track/1ZJpYHYLZoxaJcBhBplwtb',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',24,8),('1ZyudLFv35SRvY5SvTZqJx','Buried Alive Interlude',150,NULL,'https://open.spotify.com/track/1ZyudLFv35SRvY5SvTZqJx',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',62,7),('2022B8GxEstpvibwgbJ15s','Starry Eyes',148,NULL,'https://open.spotify.com/track/2022B8GxEstpvibwgbJ15s',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',47,11),('204p2kPUerKlRtDOBDJhrG','마.피.아. In the morning - Inst.',172,NULL,'https://open.spotify.com/track/204p2kPUerKlRtDOBDJhrG',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',3,15),('20E7RyoUockrRsSorCsESR','다시 사랑했으면',78,NULL,'https://open.spotify.com/track/20E7RyoUockrRsSorCsESR',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',13,6),('20kWpXaYo8igmrdwwy8OSE','We Go - English Version',189,NULL,'https://open.spotify.com/track/20kWpXaYo8igmrdwwy8OSE',NULL,'6HmUGM55FYKtA0jm3lgyFW','6YVMFz59CuY7ngCxTxjpxE',50,1),('20MOKIGONywL5xIoB7RRAR','WHISTLE - Acoustic Ver.',212,NULL,'https://open.spotify.com/track/20MOKIGONywL5xIoB7RRAR',NULL,'2Fna4Tb7fme5aHsNMJtVtp','41MozSoPIsD1dJM0CLPjZF',57,3),('210JJAa9nJOgNa0YNrsT5g','GODS',220,NULL,'https://open.spotify.com/track/210JJAa9nJOgNa0YNrsT5g',NULL,'0rAaP1OBxVCn2cIUZNjGRs','6HvZYsbFfjnjFrWF950C9d',75,1),('21hB8x6QTEsTfIDENPcyXm','The Happiest Girl',222,NULL,'https://open.spotify.com/track/21hB8x6QTEsTfIDENPcyXm',NULL,'0S4pP8MBY9p7ngFWIZQAJv','41MozSoPIsD1dJM0CLPjZF',61,6),('21HriDvqeoSKkZxbM5mVTw','Supernova - Grimes Remix',227,NULL,'https://open.spotify.com/track/21HriDvqeoSKkZxbM5mVTw',NULL,'6uWbkjA7Osh3VNnnGeyfl6','6YVMFz59CuY7ngCxTxjpxE',39,1),('21J5UuwP43cOhx4S5DMPRp','Like Magic - Instrumental',164,NULL,'https://open.spotify.com/track/21J5UuwP43cOhx4S5DMPRp',NULL,'0CYZzTggBObmmQQvl2XqU8','2KC9Qb60EaY0kW4eH68vr3',11,2),('21qPw0CUs61qIHogIlXWSV','머리 아파 - Live',517,NULL,'https://open.spotify.com/track/21qPw0CUs61qIHogIlXWSV',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,11),('21tsRwilbdY4zybfafpt9n','Dirty Work - 2Spade Remix',177,NULL,'https://open.spotify.com/track/21tsRwilbdY4zybfafpt9n',NULL,'1bV9UJSiCQOg5S786s2T9g','6YVMFz59CuY7ngCxTxjpxE',39,3),('226N2wdNqO79fC8idg6bPE','너를 꿈꾸며 (Interlude)',59,NULL,'https://open.spotify.com/track/226N2wdNqO79fC8idg6bPE',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',8,6),('227GVulwnhNRo4TJvL0IpA','해줄 수 없는 일',259,NULL,'https://open.spotify.com/track/227GVulwnhNRo4TJvL0IpA',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',7,11),('22VdIZQfgXJea34mQxlt81','Can\'t Feel My Face',213,NULL,'https://open.spotify.com/track/22VdIZQfgXJea34mQxlt81',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',85,7),('238Sekyg7DyN2XDm0z4oWY','Fancy',319,NULL,'https://open.spotify.com/track/238Sekyg7DyN2XDm0z4oWY',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',74,7),('23Cx5Jv0bsCMoUnoygy5jy','Light Up',274,NULL,'https://open.spotify.com/track/23Cx5Jv0bsCMoUnoygy5jy',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',50,10),('23FnV9ThaK01oNWc3E87yh','Take My Breath - Extended Version',351,NULL,'https://open.spotify.com/track/23FnV9ThaK01oNWc3E87yh',NULL,'4lBrDelXR6Sn0k54a7UWMz','1Xyo4u8uXC1ZmMpatF05PJ',41,3),('23FwN0VQYsThf9rtKcghSo','HAPPY TOGETHER',249,NULL,'https://open.spotify.com/track/23FwN0VQYsThf9rtKcghSo',NULL,'6FbwZcLd2Wqx0vDR2JfvQe','57htMBtzpppc1yoXgjbslj',15,1),('23iLEDPEJpcfYOw1tVhd2o','A Tale By Quincy',96,NULL,'https://open.spotify.com/track/23iLEDPEJpcfYOw1tVhd2o',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',43,6),('23TP6Un2LWuBH13dCymqAt','Sooo LUCKY',202,NULL,'https://open.spotify.com/track/23TP6Un2LWuBH13dCymqAt',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',12,3),('24FUBxaAYSBlWsbSnEzDcn','Members Only (feat. PARTYNEXTDOOR)',277,NULL,'https://open.spotify.com/track/24FUBxaAYSBlWsbSnEzDcn',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',69,14),('24hyxhmnwutr6ncxX9ALIU','CAKE',198,NULL,'https://open.spotify.com/track/24hyxhmnwutr6ncxX9ALIU',NULL,'5tXD77S3yCWTToU5eMLnlo','2KC9Qb60EaY0kW4eH68vr3',37,2),('24U2Psvkehn58QdLvZ50s8','By Your Side - Instrumental',167,NULL,'https://open.spotify.com/track/24U2Psvkehn58QdLvZ50s8',NULL,'2rTc5TdRP7hr7gE4h4lUR1','6YVMFz59CuY7ngCxTxjpxE',24,4),('25C86uEjQ0fjj3bvsxIusO','Out of Time',214,NULL,'https://open.spotify.com/track/25C86uEjQ0fjj3bvsxIusO',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',54,7),('25KybV9BOUlvcnv7nN3Pyo','In The Night',235,NULL,'https://open.spotify.com/track/25KybV9BOUlvcnv7nN3Pyo',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',74,10),('25paAMh66DSVgqYTOlVeHC','Voltage（Instrumental）',221,NULL,'https://open.spotify.com/track/25paAMh66DSVgqYTOlVeHC',NULL,'2u0QU6DP2HL5t9cp04vzBT','2KC9Qb60EaY0kW4eH68vr3',0,3),('26gaGxSnZ4CudxpUdHZBoF','The Dreamer (I am A Dreamer)',274,NULL,'https://open.spotify.com/track/26gaGxSnZ4CudxpUdHZBoF',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',30,5),('26YNVqHuwAPeBVfDscTPds','Forever (약속)',298,NULL,'https://open.spotify.com/track/26YNVqHuwAPeBVfDscTPds',NULL,'3CExk4WgPxe0lOwoOhuMWj','6YVMFz59CuY7ngCxTxjpxE',52,1),('27BgDmciSjoxTG0almHTpZ','Love To Lay',223,NULL,'https://open.spotify.com/track/27BgDmciSjoxTG0almHTpZ',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',61,11),('27GmP9AWRs744SzKcpJsTZ','Jumpman',205,NULL,'https://open.spotify.com/track/27GmP9AWRs744SzKcpJsTZ',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',72,9),('27LqJ29VMqwKQQC2CE9FHr','Set The Tone',202,NULL,'https://open.spotify.com/track/27LqJ29VMqwKQQC2CE9FHr',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',55,3),('27Tqjd2nMW2mIp6Yk1ovwY','Heat Of The Moment',343,NULL,'https://open.spotify.com/track/27Tqjd2nMW2mIp6Yk1ovwY',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',51,14),('285Bh5EkbxGGE76ge8JDbH','Lucid Dream',210,NULL,'https://open.spotify.com/track/285Bh5EkbxGGE76ge8JDbH',NULL,'3vyyDkvYWC36DwgZCYd3Wu','6YVMFz59CuY7ngCxTxjpxE',64,6),('28BsYQIzC8Q5eST3WL1ovj','긴 여행',343,NULL,'https://open.spotify.com/track/28BsYQIzC8Q5eST3WL1ovj',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',9,1),('28irpKCCK9nn9DZSik2zEx','Glow',206,NULL,'https://open.spotify.com/track/28irpKCCK9nn9DZSik2zEx',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',57,18),('28JBD8p18xNuOfyV7Cotdn','Massive',336,NULL,'https://open.spotify.com/track/28JBD8p18xNuOfyV7Cotdn',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',75,8),('28JjasggXwc0EMZJVM3gVk','Show Your Love',280,NULL,'https://open.spotify.com/track/28JjasggXwc0EMZJVM3gVk',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',7,9),('28miNmOY5T8wtfUVIZWACF','난 멋있어 - Live',177,NULL,'https://open.spotify.com/track/28miNmOY5T8wtfUVIZWACF',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',5,10),('28N8gvR5Mo8d23XL4cFptk','Chillin\' Chillin\'',206,NULL,'https://open.spotify.com/track/28N8gvR5Mo8d23XL4cFptk',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',12,8),('28QyjEeOgirjfCjKSntPF4','사랑을 비우다',278,NULL,'https://open.spotify.com/track/28QyjEeOgirjfCjKSntPF4',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',12,11),('28tufPkTcXmdNqTvi9hsoG','Pretty Savage',199,NULL,'https://open.spotify.com/track/28tufPkTcXmdNqTvi9hsoG',NULL,'2gNPnKP1PDkB5SZz3IMKuX','41MozSoPIsD1dJM0CLPjZF',73,3),('28vrWVhhVnyQKJKk4nzWjF','푸른구슬',191,NULL,'https://open.spotify.com/track/28vrWVhhVnyQKJKk4nzWjF',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',3,6),('28vy7I63Gtqw90rvgxw8sU','Die For You - Sped Up',223,NULL,'https://open.spotify.com/track/28vy7I63Gtqw90rvgxw8sU',NULL,'0YF085Qdh4HgdhZ8zjWkpo','1Xyo4u8uXC1ZmMpatF05PJ',45,4),('29fsVDL9T36N0tyD7ByLdI','Hope Not',191,NULL,'https://open.spotify.com/track/29fsVDL9T36N0tyD7ByLdI',NULL,'3qw2vm3uqKT3EIg95wbg83','41MozSoPIsD1dJM0CLPjZF',59,4),('29hOV4CLKzJBQRJDtdH5ay','Whiplash (English Version) - Sped Up Version',161,NULL,'https://open.spotify.com/track/29hOV4CLKzJBQRJDtdH5ay',NULL,'4nGujzCa6JLhMx7rHXE4J9','6YVMFz59CuY7ngCxTxjpxE',46,3),('29lXN1aoaL6HE72BOvknyr','Dancing In The Flames',220,NULL,'https://open.spotify.com/track/29lXN1aoaL6HE72BOvknyr',NULL,'0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',57,1),('29ON2ad7IdIjSPbhBn7gR7','나처럼',284,NULL,'https://open.spotify.com/track/29ON2ad7IdIjSPbhBn7gR7',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',25,1),('29YW2xXlo6Pc6M0SBTCXYN','More M’s',221,NULL,'https://open.spotify.com/track/29YW2xXlo6Pc6M0SBTCXYN',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',64,14),('2ACys0pX0SjmpQmQWzp7wt','Jersey',188,NULL,'https://open.spotify.com/track/2ACys0pX0SjmpQmQWzp7wt',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',69,10),('2aEaejrhOecAdVvifXidcm','Heukseok-dong',413,NULL,'https://open.spotify.com/track/2aEaejrhOecAdVvifXidcm',NULL,'1h3aXRHMtuiUTnEymDWKGo','1rpgxJZxZMLnFNc1Jmyov5',31,1),('2AGottAzfC8bHzF7kEJ3Wa','Diamonds Dancing',314,NULL,'https://open.spotify.com/track/2AGottAzfC8bHzF7kEJ3Wa',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',63,4),('2AIjSWNQRXGemKc6zl22DP','Better Things - Slowed Down Version',227,NULL,'https://open.spotify.com/track/2AIjSWNQRXGemKc6zl22DP',NULL,'0jXtQE6F6FYFLPx0S3Gp1D','6YVMFz59CuY7ngCxTxjpxE',30,2),('2akxtSALPUX8orriSWyDi4','Cookie (FRNK Remix) (Instrumental)',212,NULL,'https://open.spotify.com/track/2akxtSALPUX8orriSWyDi4',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',47,11),('2ALh2jqA7KldpHMUHvRomw','Love\'s Train',307,NULL,'https://open.spotify.com/track/2ALh2jqA7KldpHMUHvRomw',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',61,9),('2aSC2xhRxOLiiZZVjhbylH','Hold On, We\'re Going Home',227,NULL,'https://open.spotify.com/track/2aSC2xhRxOLiiZZVjhbylH',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',76,8),('2AYmPq5Vs5dzLIWU0dPIaR','혈액형 - Live',332,NULL,'https://open.spotify.com/track/2AYmPq5Vs5dzLIWU0dPIaR',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',3,5),('2BcMwX1MPV6ZHP4tUT9uq6','Knife Talk (with 21 Savage ft. Project Pat)',242,NULL,'https://open.spotify.com/track/2BcMwX1MPV6ZHP4tUT9uq6',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',78,13),('2BcnxwxBuar5wjCaLqm5N3','Until I Bleed Out',190,NULL,'https://open.spotify.com/track/2BcnxwxBuar5wjCaLqm5N3',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',64,14),('2bjwRfXMk4uRgOD9IBYl9h','Portland',236,NULL,'https://open.spotify.com/track/2bjwRfXMk4uRgOD9IBYl9h',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',71,11),('2BTkcHMf8j5pqa5UIMFGcy','Until I Bleed Out',192,NULL,'https://open.spotify.com/track/2BTkcHMf8j5pqa5UIMFGcy',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',48,14),('2C39jkUPAsQzwBSshsaCfX','Winter Ahead (with PARK HYO SHIN) : YUNSEOKCHEOL TRIO Ver.',224,NULL,'https://open.spotify.com/track/2C39jkUPAsQzwBSshsaCfX',NULL,'1e5ELECrQq5yoquPwoXzkd','57htMBtzpppc1yoXgjbslj',58,2),('2CFhTND54uE5carTvSeILv','Trust Me (MIDZY) -Japanese ver.-',221,NULL,'https://open.spotify.com/track/2CFhTND54uE5carTvSeILv',NULL,'2qIw3nzBegLwRZYj0sGnkS','2KC9Qb60EaY0kW4eH68vr3',0,1),('2cGf0hmhkACTwRj58XNGlP','도깨비불 (Illusion)',195,NULL,'https://open.spotify.com/track/2cGf0hmhkACTwRj58XNGlP',NULL,'2rwRvLdjGzjSYl9AS3UbvH','6YVMFz59CuY7ngCxTxjpxE',43,2),('2Ch7LmS7r2Gy2kc64wv3Bz','Die For You',260,NULL,'https://open.spotify.com/track/2Ch7LmS7r2Gy2kc64wv3Bz',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',82,17),('2cniVkzQqT9Bm957QH9WXM','혈액형',509,NULL,'https://open.spotify.com/track/2cniVkzQqT9Bm957QH9WXM',NULL,'2YVpqON0I1KS8LjQLqV0uH','1rpgxJZxZMLnFNc1Jmyov5',1,4),('2D4dV2KXDTszzJ3p3cFqhA','Less Than Zero',211,NULL,'https://open.spotify.com/track/2D4dV2KXDTszzJ3p3cFqhA',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',75,15),('2D5fYMRm0Fm1kDt4IvccGM','눈앞에서',288,NULL,'https://open.spotify.com/track/2D5fYMRm0Fm1kDt4IvccGM',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',0,10),('2d8xiUGjUalhOp4t6M2i0w','Girls',240,NULL,'https://open.spotify.com/track/2d8xiUGjUalhOp4t6M2i0w',NULL,'2jK7H4A5Y2xJaoOyzBedaS','6YVMFz59CuY7ngCxTxjpxE',38,3),('2dfqS3MRtbLZSZA1IL8xY5','Skepta Interlude',143,NULL,'https://open.spotify.com/track/2dfqS3MRtbLZSZA1IL8xY5',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',59,10),('2DsrtZoRxeHdCSGRlQVQtj','Attention',197,NULL,'https://open.spotify.com/track/2DsrtZoRxeHdCSGRlQVQtj',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',45,13),('2DSy4HfDQoBsPPcRSoeM16','Rich Baby Daddy (feat. Sexyy Red & SZA)',319,NULL,'https://open.spotify.com/track/2DSy4HfDQoBsPPcRSoeM16',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',54,20),('2durxb17bXcmQJHSt8JAdO','No Tellin\'',310,NULL,'https://open.spotify.com/track/2durxb17bXcmQJHSt8JAdO',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',61,5),('2DwUdMJ5uxv20EhAildreg','Cookie',235,NULL,'https://open.spotify.com/track/2DwUdMJ5uxv20EhAildreg',NULL,'1HMLpmZAnNyl9pxvOnTovV','6HvZYsbFfjnjFrWF950C9d',74,3),('2E4D4IuFauEfAjpAamK8HU','IT\'z SUMMER',197,NULL,'https://open.spotify.com/track/2E4D4IuFauEfAjpAamK8HU',NULL,'2tj99zihwANHtqmEC2QpCn','2KC9Qb60EaY0kW4eH68vr3',12,3),('2EVbppK8oLZrQaYNDekaMQ','B[OO]M-BOXX',193,NULL,'https://open.spotify.com/track/2EVbppK8oLZrQaYNDekaMQ',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',8,5),('2evYKtXNAdn60ANNEdjH7V','Alone Again - Live',167,NULL,'https://open.spotify.com/track/2evYKtXNAdn60ANNEdjH7V',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,2),('2eWQpIEAfotVXiIZPtvMqr','#Twenty',174,NULL,'https://open.spotify.com/track/2eWQpIEAfotVXiIZPtvMqr',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',17,4),('2FauI2onZLXgsr9dz6HWKn','Fat Juicy & Wet',141,NULL,'https://open.spotify.com/track/2FauI2onZLXgsr9dz6HWKn',NULL,'4IUWHnLG3hwdi6a4pcFnoa','0du5cEVh5yTK9QJze8zA0C',36,1),('2FbGlEPAjNhWvrVvlentVq','Cameras / Good Ones Go Interlude - Medley',434,NULL,'https://open.spotify.com/track/2FbGlEPAjNhWvrVvlentVq',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',77,12),('2fkeWbM6iqTw7oGHTYm2lw','4422',186,NULL,'https://open.spotify.com/track/2fkeWbM6iqTw7oGHTYm2lw',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',69,8),('2fmAQSxtxL8av0VA8MVFVl','Escalator (Final Ver.)',200,NULL,'https://open.spotify.com/track/2fmAQSxtxL8av0VA8MVFVl',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',9,11),('2Fql94zGWvYo7ihqIOpje0','Promise',224,NULL,'https://open.spotify.com/track/2Fql94zGWvYo7ihqIOpje0',NULL,'6TA0VcPiUH1a3tPRp3SjbC','2KC9Qb60EaY0kW4eH68vr3',31,4),('2fTe41iso7GyCLuRu3UmJh','Popular (Slowed) (with Playboi Carti & Madonna)',258,NULL,'https://open.spotify.com/track/2fTe41iso7GyCLuRu3UmJh',NULL,'0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',47,3),('2GdcDOXu8HLFAP9hxANXb7','Just the Way You Are - Steve Smart & Westfunk Club Mix',426,NULL,'https://open.spotify.com/track/2GdcDOXu8HLFAP9hxANXb7',NULL,'7BzP09BlvvE4ioNgvdLrdm','0du5cEVh5yTK9QJze8zA0C',38,6),('2gFvRmQiWg9fN9i74Q0aiw','24K Magic',225,NULL,'https://open.spotify.com/track/2gFvRmQiWg9fN9i74Q0aiw',NULL,'5EA4kogB3cZr2qykFlZDYV','0du5cEVh5yTK9QJze8zA0C',61,1),('2Ghp894n1laIf2w98VeAOJ','How Do I Make You Love Me?',214,NULL,'https://open.spotify.com/track/2Ghp894n1laIf2w98VeAOJ',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',68,3),('2GkxcNcIy05smHTiG88fet','Treasure - Sharam Dub',432,NULL,'https://open.spotify.com/track/2GkxcNcIy05smHTiG88fet',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',28,2),('2Gnsof1hvZzjE1xdLRpjtf','Over My Dead Body',272,NULL,'https://open.spotify.com/track/2Gnsof1hvZzjE1xdLRpjtf',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',78,1),('2GunxLIF4vI2rV218VktP6','이 땅에 살기 위하여 - Live',311,NULL,'https://open.spotify.com/track/2GunxLIF4vI2rV218VktP6',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,8),('2gWWYL6iXZKkOqCE3TQHBM','Hurt (250 Remix)',224,NULL,'https://open.spotify.com/track/2gWWYL6iXZKkOqCE3TQHBM',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',54,6),('2gyHr9WqZeMtzJOpWGuGo6','Reflections Laughing (feat. Travis Scott, Florence + The Machine)',291,NULL,'https://open.spotify.com/track/2gyHr9WqZeMtzJOpWGuGo6',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',75,9),('2GyuqH5D6TZCF11d07suGM','Trust Me (MIDZY) -Japanese ver.-',221,NULL,'https://open.spotify.com/track/2GyuqH5D6TZCF11d07suGM',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',4,11),('2h3ZotklPN6aD7OuHz7bFZ','Gasoline - Live',195,NULL,'https://open.spotify.com/track/2h3ZotklPN6aD7OuHz7bFZ',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,3),('2hcohLIysMxofYziluXCoX','Ignant Shit (feat. Lil Wayne)',302,NULL,'https://open.spotify.com/track/2hcohLIysMxofYziluXCoX',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',58,6),('2HSmyk2qMN8WQjuGhaQgCk','Champagne Poetry',336,NULL,'https://open.spotify.com/track/2HSmyk2qMN8WQjuGhaQgCk',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',74,1),('2HYXkqIePIgkWDAwcMQtXQ','니가 들려준 말',224,NULL,'https://open.spotify.com/track/2HYXkqIePIgkWDAwcMQtXQ',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',10,13),('2iBF7hOOvvbHJZBQs7LmIh','Better Things',203,NULL,'https://open.spotify.com/track/2iBF7hOOvvbHJZBQs7LmIh',NULL,'2P8trIADhHx8fJAdC7ud40','6YVMFz59CuY7ngCxTxjpxE',34,2),('2ifcb0VFNwl5U8gXvr7lVx','차라리 몰랐더라면',231,NULL,'https://open.spotify.com/track/2ifcb0VFNwl5U8gXvr7lVx',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',5,6),('2ih2U8ttFzCjnQ5njF3SrR','Gorilla',244,NULL,'https://open.spotify.com/track/2ih2U8ttFzCjnQ5njF3SrR',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',67,3),('2ijoRedysVbf8oFJdyMady','Show Me A Good Time',210,NULL,'https://open.spotify.com/track/2ijoRedysVbf8oFJdyMady',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',26,5),('2IYnnkPXK1zvoCIHAkyiFA','WANNABE',191,NULL,'https://open.spotify.com/track/2IYnnkPXK1zvoCIHAkyiFA',NULL,'6RP5wCF7u2WDFiuyQ0loNS','2KC9Qb60EaY0kW4eH68vr3',42,1),('2j1lH8K6luee5lvCPNKQ1u','Etude (feat. Jin Bora) - Interlude',34,NULL,'https://open.spotify.com/track/2j1lH8K6luee5lvCPNKQ1u',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',8,4),('2jTujnt0y344ai1rNOywgr','KMT',162,NULL,'https://open.spotify.com/track/2jTujnt0y344ai1rNOywgr',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',64,15),('2jxAjrgyJbabAQoyrd98iP','PLAYING WITH FIRE',196,NULL,'https://open.spotify.com/track/2jxAjrgyJbabAQoyrd98iP',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',44,5),('2JXtnYipvED0oh36MJ9YyM','Voltage',221,NULL,'https://open.spotify.com/track/2JXtnYipvED0oh36MJ9YyM',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',10,5),('2k0PMMQw04p2dFO1lxZC6b','WHAT I WANT',143,NULL,'https://open.spotify.com/track/2k0PMMQw04p2dFO1lxZC6b',NULL,'0t98iMat2EXJthAhr844Sx','2KC9Qb60EaY0kW4eH68vr3',11,3),('2K6vUau7bnZUamjbRSOOvJ','777',165,NULL,'https://open.spotify.com/track/2K6vUau7bnZUamjbRSOOvJ',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',62,7),('2K9Ovn1o2bTGqbsABGC6m3','Too Late',239,NULL,'https://open.spotify.com/track/2K9Ovn1o2bTGqbsABGC6m3',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',68,2),('2Kf6WQmc6TU4bYIu3Szsz2','Pink Hoodie',146,NULL,'https://open.spotify.com/track/2Kf6WQmc6TU4bYIu3Szsz2',NULL,'3OaW4df1SA62k0arNpn6bK','6YVMFz59CuY7ngCxTxjpxE',54,4),('2KkwatFSB6jXTAOt653W0e','DOMINO',186,NULL,'https://open.spotify.com/track/2KkwatFSB6jXTAOt653W0e',NULL,'0t98iMat2EXJthAhr844Sx','2KC9Qb60EaY0kW4eH68vr3',11,6),('2KLL68vmqVDdhL7J9lquMb','눈의 꽃 - 미안하다, 사랑한다 (Original Television Soundtrack)',339,NULL,'https://open.spotify.com/track/2KLL68vmqVDdhL7J9lquMb',NULL,'4WL52EyorI85Tip01sXmmT','57htMBtzpppc1yoXgjbslj',45,1),('2KLwPaRDOB87XOYAT2fgxh','Pussy & Millions (feat. Travis Scott)',242,NULL,'https://open.spotify.com/track/2KLwPaRDOB87XOYAT2fgxh',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',73,10),('2knCRriRayEz85DspnEYzD','Want It !!?',237,NULL,'https://open.spotify.com/track/2knCRriRayEz85DspnEYzD',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',6,11),('2kvzSGkSaU9z3uywQIrhAg','K-POP - Instrumental',185,NULL,'https://open.spotify.com/track/2kvzSGkSaU9z3uywQIrhAg',NULL,'0jiAYLsE1PumLJncO7vUIl','1Xyo4u8uXC1ZmMpatF05PJ',35,3),('2kZoOj1n5vk9BuF0sih58M','SOMEBODY LOVES ME',182,NULL,'https://open.spotify.com/track/2kZoOj1n5vk9BuF0sih58M',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',82,16),('2kZrNgPMKiFH64LXWeWciR','나는 나비 - Live',438,NULL,'https://open.spotify.com/track/2kZrNgPMKiFH64LXWeWciR',NULL,'3cjssumQEsRatYlYG5K86T','1rpgxJZxZMLnFNc1Jmyov5',19,3),('2lru9kAhhVCuz7lkm3VRAH','Ment 4_ENCORE + FAN EVENT',278,NULL,'https://open.spotify.com/track/2lru9kAhhVCuz7lkm3VRAH',NULL,'21NNancB4Bdre5c5VRnbHk','2KC9Qb60EaY0kW4eH68vr3',11,8),('2Mdwtq37upAaTrghSA1RnF','FIVE',201,NULL,'https://open.spotify.com/track/2Mdwtq37upAaTrghSA1RnF',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',17,5),('2mgzUVvDpb1zMSB4glLQ6T','Life\'s Too Short (English Version)',178,NULL,'https://open.spotify.com/track/2mgzUVvDpb1zMSB4glLQ6T',NULL,'11lLYKMkFheiV7ObD7WCnx','6YVMFz59CuY7ngCxTxjpxE',56,1),('2mmUoyPxzbxehpfm1TpTRK','Star67',294,NULL,'https://open.spotify.com/track/2mmUoyPxzbxehpfm1TpTRK',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',66,8),('2mrZYZGmPFV3QOyYPZ1zsn','Straight up & Down',198,NULL,'https://open.spotify.com/track/2mrZYZGmPFV3QOyYPZ1zsn',NULL,'4PgleR09JVnm3zY1fW3XBA','0du5cEVh5yTK9QJze8zA0C',66,6),('2Na0z2gfN67Rzf0vp74Wi3','Lose You',305,NULL,'https://open.spotify.com/track/2Na0z2gfN67Rzf0vp74Wi3',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',68,16),('2nibvvDdAQkVraYP00z2RS','Calling For You (feat. 21 Savage)',285,NULL,'https://open.spotify.com/track/2nibvvDdAQkVraYP00z2RS',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',64,3),('2nL8LgN6BC2HVYh7aAy7kq','흑백사진',256,NULL,'https://open.spotify.com/track/2nL8LgN6BC2HVYh7aAy7kq',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',3,6),('2NqyjfDXy0XfXCSPXMsKzi','Blast Off',284,NULL,'https://open.spotify.com/track/2NqyjfDXy0XfXCSPXMsKzi',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',56,10),('2nW48vXnZZ5EYka46v7GOk','Attention (250 Remix)',181,NULL,'https://open.spotify.com/track/2nW48vXnZZ5EYka46v7GOk',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',58,3),('2oGCuDkdDmd1OTVNMJqfFO','Invincible',211,NULL,'https://open.spotify.com/track/2oGCuDkdDmd1OTVNMJqfFO',NULL,'6OZ8ZANoibZBNM7948KPjn','1rpgxJZxZMLnFNc1Jmyov5',16,1),('2oLVT9Lo0SavCNpGw4WfPp','OMG (FRNK Remix) (Instrumental)',210,NULL,'https://open.spotify.com/track/2oLVT9Lo0SavCNpGw4WfPp',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',47,8),('2OWXH98HPXFR7uelLTVF8y','Outro',70,NULL,'https://open.spotify.com/track/2OWXH98HPXFR7uelLTVF8y',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',8,11),('2p8IUWQDrpjuFltbdgLOag','After Hours',361,NULL,'https://open.spotify.com/track/2p8IUWQDrpjuFltbdgLOag',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',84,13),('2pGp7wk76ZfbxYG5MRwfcs','Save Your Tears',215,NULL,'https://open.spotify.com/track/2pGp7wk76ZfbxYG5MRwfcs',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',57,11),('2PipF4mcI9d6cqq5AAp7GU','Save Your Tears (Remix) (with Ariana Grande) - Bonus Track',191,NULL,'https://open.spotify.com/track/2PipF4mcI9d6cqq5AAp7GU',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',50,18),('2pIUpMhHL6L9Z5lnKxJJr9','Attention',180,NULL,'https://open.spotify.com/track/2pIUpMhHL6L9Z5lnKxJJr9',NULL,'1HMLpmZAnNyl9pxvOnTovV','6HvZYsbFfjnjFrWF950C9d',78,1),('2Pp9osgyIcw6o1avfDDDhH','Forever Young',237,NULL,'https://open.spotify.com/track/2Pp9osgyIcw6o1avfDDDhH',NULL,'6yetqbA9vli7RLoUWYZLsq','41MozSoPIsD1dJM0CLPjZF',71,2),('2pSZy7Zx2AT1wGtbCfvVtQ','Fat Juicy &... - Radio Edit',141,NULL,'https://open.spotify.com/track/2pSZy7Zx2AT1wGtbCfvVtQ',NULL,'1gIckYyr6GfiJJ2BtpDZXR','0du5cEVh5yTK9QJze8zA0C',38,1),('2pt2kyz1awkjq3CJxt1SnE','Fat Juicy & Wet',141,NULL,'https://open.spotify.com/track/2pt2kyz1awkjq3CJxt1SnE',NULL,'3frr94sbeGqX7kCBgxOa7L','0du5cEVh5yTK9QJze8zA0C',28,1),('2pZcdLQkRmH9T3oajmlxuO','Tears are About Shedding',232,NULL,'https://open.spotify.com/track/2pZcdLQkRmH9T3oajmlxuO',NULL,'2KnWel482zu05nLvSqNEzI','57htMBtzpppc1yoXgjbslj',12,3),('2Q3jFbyE61mCjS3SkW4toJ','Race My Mind',269,NULL,'https://open.spotify.com/track/2Q3jFbyE61mCjS3SkW4toJ',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',72,15),('2qLcJOLrh6Djda4uLbldSA','Faithful',290,NULL,'https://open.spotify.com/track/2qLcJOLrh6Djda4uLbldSA',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',60,9),('2qLtbOJxJAJma5WnZt8X6m','Algorhythm',187,NULL,'https://open.spotify.com/track/2qLtbOJxJAJma5WnZt8X6m',NULL,'7eNsf4qcc9uV6IklAlPp4b','2KC9Qb60EaY0kW4eH68vr3',13,1),('2QRvliBEcGIEgTrjVfxmXo','True Colors',206,NULL,'https://open.spotify.com/track/2QRvliBEcGIEgTrjVfxmXo',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',46,7),('2QXhmsocxY611wCuVZAYe7','그것만이 내 세상 (with 권인하)',360,NULL,'https://open.spotify.com/track/2QXhmsocxY611wCuVZAYe7',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',12,8),('2R30S0W4JCM9JaQWlpmeWn','Calling For You (feat. 21 Savage)',285,NULL,'https://open.spotify.com/track/2R30S0W4JCM9JaQWlpmeWn',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',53,3),('2r7BPog74oaTG5shNYiUnV','House Of Balloons / Glass Table Girls',407,NULL,'https://open.spotify.com/track/2r7BPog74oaTG5shNYiUnV',NULL,'7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',81,3),('2Rkxg16NLttUUANMABlj8O','Stormborn - Instrumental',255,NULL,'https://open.spotify.com/track/2Rkxg16NLttUUANMABlj8O',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',7,9),('2rOJPyasbcVXcsLheZEVt0','Forever Young',384,NULL,'https://open.spotify.com/track/2rOJPyasbcVXcsLheZEVt0',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',41,15),('2rtvBPl6YXick3vbPBnDF4','I Promise You',263,NULL,'https://open.spotify.com/track/2rtvBPl6YXick3vbPBnDF4',NULL,'2KnWel482zu05nLvSqNEzI','57htMBtzpppc1yoXgjbslj',26,2),('2s0TqmdHw01MNIpXyyP5t1','WANNABE (English Ver.)',191,NULL,'https://open.spotify.com/track/2s0TqmdHw01MNIpXyyP5t1',NULL,'6zWajG8oLkshBrkjIMPbjQ','2KC9Qb60EaY0kW4eH68vr3',2,2),('2s2YQjNsQBySa4afdcoY7q','Girls Will Be Girls - English Ver.',167,NULL,'https://open.spotify.com/track/2s2YQjNsQBySa4afdcoY7q',NULL,'5Dz30uiKFlqDemyDhW63ZL','2KC9Qb60EaY0kW4eH68vr3',22,1),('2S8dhO9HpJHEHPTEwQCCVd','Voyeurist - Instrumental',267,NULL,'https://open.spotify.com/track/2S8dhO9HpJHEHPTEwQCCVd',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',9,7),('2SAqBLGA283SUiwJ3xOUVI','Laugh Now Cry Later (feat. Lil Durk)',261,NULL,'https://open.spotify.com/track/2SAqBLGA283SUiwJ3xOUVI',NULL,'0qGdc7fNq9RNIPEzZufa43','3TVXtAsR1Inumwj472S9r4',79,1),('2SEJ2NT4dzggwtmsmVUUYb','I Promise You (Inst.)',263,NULL,'https://open.spotify.com/track/2SEJ2NT4dzggwtmsmVUUYb',NULL,'2KnWel482zu05nLvSqNEzI','57htMBtzpppc1yoXgjbslj',8,7),('2SLwbpExuoBDZBpjfefCtV','Out of Time',214,NULL,'https://open.spotify.com/track/2SLwbpExuoBDZBpjfefCtV',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',79,7),('2sULZYmipgXLPkL5nq8g1f','MENT 1_BAND INTRODUCING',195,NULL,'https://open.spotify.com/track/2sULZYmipgXLPkL5nq8g1f',NULL,'21NNancB4Bdre5c5VRnbHk','2KC9Qb60EaY0kW4eH68vr3',13,1),('2T0cn0hvGrG8vqqB8sK4zX','SUPERPOWERS',175,NULL,'https://open.spotify.com/track/2T0cn0hvGrG8vqqB8sK4zX',NULL,'1atx6ADNPFNf3PKvBiSa6l','2KC9Qb60EaY0kW4eH68vr3',40,1),('2t9f491bZPReKdu6hH4dRk','Blah Blah Blah',185,NULL,'https://open.spotify.com/track/2t9f491bZPReKdu6hH4dRk',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',10,7),('2T9O6E83LKAWNAs4FD4TqD','SILENCE',205,NULL,'https://open.spotify.com/track/2T9O6E83LKAWNAs4FD4TqD',NULL,'3PNXlS9tggXmCm1hrlHDcQ','1rpgxJZxZMLnFNc1Jmyov5',35,1),('2tbAo6xAEfHYuo4m7c0BxM','Find Your Love',208,NULL,'https://open.spotify.com/track/2tbAo6xAEfHYuo4m7c0BxM',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',31,13),('2tCPIp83mRXvVTytTAf1W4','Show Me',207,NULL,'https://open.spotify.com/track/2tCPIp83mRXvVTytTAf1W4',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',66,8),('2tUL6dZf1mywCj5WvCPZw6','No Friends In The Industry',204,NULL,'https://open.spotify.com/track/2tUL6dZf1mywCj5WvCPZw6',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',72,12),('2TWSilrWcTrgVKcP8kfEfg','Unstoppable (feat. Santigold & Lil Wayne)',209,NULL,'https://open.spotify.com/track/2TWSilrWcTrgVKcP8kfEfg',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',48,11),('2U4eZBbH8n1PzVMONGqeqr','Sound of Winter',411,NULL,'https://open.spotify.com/track/2U4eZBbH8n1PzVMONGqeqr',NULL,'0ssxpVNMYMHeKXV00VUCkJ','57htMBtzpppc1yoXgjbslj',32,1),('2u8Msh7gewUrmJ74K8HZNq','BOOMBAYAH - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',243,NULL,'https://open.spotify.com/track/2u8Msh7gewUrmJ74K8HZNq',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',40,11),('2u9S9JJ6hTZS3Vf22HOZKg','NOKIA',241,NULL,'https://open.spotify.com/track/2u9S9JJ6hTZS3Vf22HOZKg',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',92,14),('2uJEnyojuGg31VVlLTQFpp','Don\'t Blink',169,NULL,'https://open.spotify.com/track/2uJEnyojuGg31VVlLTQFpp',NULL,'5NMtxQJy4wq3mpo3ERVnLs','6YVMFz59CuY7ngCxTxjpxE',55,3),('2UPYasw4V9TeDcibLYDxRF','Better Things',203,NULL,'https://open.spotify.com/track/2UPYasw4V9TeDcibLYDxRF',NULL,'3ukWjsUrP70en9dcpt01Hs','6YVMFz59CuY7ngCxTxjpxE',30,2),('2urqWNGpjl07PLAafoa5nT','How Do I Make You Love Me? - Sebastian Ingrosso & Salvatore Ganacci Remix',217,NULL,'https://open.spotify.com/track/2urqWNGpjl07PLAafoa5nT',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',48,19),('2uTG00P1DkhB97pdITkl2O','Live From The Gutter',211,NULL,'https://open.spotify.com/track/2uTG00P1DkhB97pdITkl2O',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',62,3),('2uUnODsWs7UZhXjmcKM9J6','Don\'t Know Why',209,NULL,'https://open.spotify.com/track/2uUnODsWs7UZhXjmcKM9J6',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',22,15),('2uvBprdlMpzeN5Bq0PzMBI','IDGAF (feat. Yeat)',260,NULL,'https://open.spotify.com/track/2uvBprdlMpzeN5Bq0PzMBI',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',52,7),('2UYg7TfmY0pD0BeE8YCGSs','Playlist',224,NULL,'https://open.spotify.com/track/2UYg7TfmY0pD0BeE8YCGSs',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',8,3),('2v0AG62ZHtD3I4YmTb3WYM','Niagara Falls',277,NULL,'https://open.spotify.com/track/2v0AG62ZHtD3I4YmTb3WYM',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',75,14),('2V7SddXJg23TDxMEm9z6WL','꽃비',204,NULL,'https://open.spotify.com/track/2V7SddXJg23TDxMEm9z6WL',NULL,'7j7jQK2aD7e167FY7WpIvP','1rpgxJZxZMLnFNc1Jmyov5',17,1),('2vDmBkhsSCITBNt9u2nYSD','Run Away (류진)',216,NULL,'https://open.spotify.com/track/2vDmBkhsSCITBNt9u2nYSD',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',14,7),('2VdSktBqFfkW7y6q5Ik4Z4','Supernova',178,NULL,'https://open.spotify.com/track/2VdSktBqFfkW7y6q5Ik4Z4',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',74,1),('2vgUijXOTRMnWXDtvgMp2b','Take My Breath',339,NULL,'https://open.spotify.com/track/2vgUijXOTRMnWXDtvgMp2b',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',73,4),('2vjFTjmvpFjFM01cNdG2ik','LASERS',198,NULL,'https://open.spotify.com/track/2vjFTjmvpFjFM01cNdG2ik',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',69,12),('2vy9Ry1TNjCD85TiCbTz0r','Liability',237,NULL,'https://open.spotify.com/track/2vy9Ry1TNjCD85TiCbTz0r',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',63,13),('2w1jteTsYA63w6MOfLPZA2','You & Me (Live Version)',282,NULL,'https://open.spotify.com/track/2w1jteTsYA63w6MOfLPZA2',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',3,7),('2WC4sK0ryyysQhtDok9Ytr','From Time',322,NULL,'https://open.spotify.com/track/2WC4sK0ryyysQhtDok9Ytr',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',71,7),('2wmYDj7JwiZOc8EwtRU72N','STAY (Remix Version) [Live]',222,NULL,'https://open.spotify.com/track/2wmYDj7JwiZOc8EwtRU72N',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',34,3),('2WP8G2pdddDmnh1xbfKBOI','Finesse',182,NULL,'https://open.spotify.com/track/2WP8G2pdddDmnh1xbfKBOI',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',77,5),('2wRXvIGUTRWod4yp1k3bGN','Dark Arts',181,NULL,'https://open.spotify.com/track/2wRXvIGUTRWod4yp1k3bGN',NULL,'1YItIfS2HNJkWIgaoj50SM','6YVMFz59CuY7ngCxTxjpxE',68,1),('2WxcXtp6kuC7biYBxBbeeG','Double Fantasy (with Future)',268,NULL,'https://open.spotify.com/track/2WxcXtp6kuC7biYBxBbeeG',NULL,'5bx7i3cuSfXBPF7Li8kUR7','1Xyo4u8uXC1ZmMpatF05PJ',49,3),('2X0AvJYmIKm1XwpV4R5x0Y','It Burns',232,NULL,'https://open.spotify.com/track/2X0AvJYmIKm1XwpV4R5x0Y',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',6,18),('2x1zfAwLW8p0XQdZ6uC4Hq','스토킹',240,NULL,'https://open.spotify.com/track/2x1zfAwLW8p0XQdZ6uC4Hq',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',10,5),('2X32KinciUCloLWMGpTCFU','Treasure - Cash Cash Remix',311,NULL,'https://open.spotify.com/track/2X32KinciUCloLWMGpTCFU',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',28,5),('2XlHu0HcujBCkWMdIAvrqt','Blem',216,NULL,'https://open.spotify.com/track/2XlHu0HcujBCkWMdIAvrqt',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',66,7),('2xM0QbC1oPaRfxFp7uVi7h','메아리',301,NULL,'https://open.spotify.com/track/2xM0QbC1oPaRfxFp7uVi7h',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',17,3),('2xoA126GEgFhrYzRaTH7E4','Spark - WINTER Solo',201,NULL,'https://open.spotify.com/track/2xoA126GEgFhrYzRaTH7E4',NULL,'4vLGHlTnlIIxMSfefCY0cU','6YVMFz59CuY7ngCxTxjpxE',66,4),('2xqYe0JXuRj68Cu9pw1Htq','빨간 숲 속 - Korean Version',232,NULL,'https://open.spotify.com/track/2xqYe0JXuRj68Cu9pw1Htq',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',10,4),('2xUHiyGeGrWmmfv7NbDTWC','Jodeci Freestyle (feat. J. Cole)',254,NULL,'https://open.spotify.com/track/2xUHiyGeGrWmmfv7NbDTWC',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',57,11),('2xxb5zW09uwbgyLprALi9E','RAINING IN HOUSTON',244,NULL,'https://open.spotify.com/track/2xxb5zW09uwbgyLprALi9E',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',72,11),('2YaDRtIlQiZ5WDDB2YuEOC','You & The 6',264,NULL,'https://open.spotify.com/track/2YaDRtIlQiZ5WDDB2YuEOC',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',63,15),('2yBz1hupoOBncorzuKcJ2z','Loft Music',363,NULL,'https://open.spotify.com/track/2yBz1hupoOBncorzuKcJ2z',NULL,'7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',62,8),('2yD6jt9CQQApZc9MAVHeJn','Beautiful Day (Feat. SKULL)',221,NULL,'https://open.spotify.com/track/2yD6jt9CQQApZc9MAVHeJn',NULL,'2KnWel482zu05nLvSqNEzI','57htMBtzpppc1yoXgjbslj',8,1),('2ye9iWj5V4g6k6HFeTTAKa','High For This',249,NULL,'https://open.spotify.com/track/2ye9iWj5V4g6k6HFeTTAKa',NULL,'7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',70,1),('2YFMY6G9ir042Wz1J5Cora','동경',315,NULL,'https://open.spotify.com/track/2YFMY6G9ir042Wz1J5Cora',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',31,2),('2yG8TVQ30Rp42peemOmvTV','It\'s Gonna Be Rolling (Live Version)',234,NULL,'https://open.spotify.com/track/2yG8TVQ30Rp42peemOmvTV',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',3,13),('2yg9UN4eo5eMVJ7OB4RWj3','Survival',136,NULL,'https://open.spotify.com/track/2yg9UN4eo5eMVJ7OB4RWj3',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',60,1),('2YI8oiiImLkZvVgP33xrjD','Kiss Land - Live',110,NULL,'https://open.spotify.com/track/2YI8oiiImLkZvVgP33xrjD',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',45,16),('2YSzYUF3jWqb9YP9VXmpjE','IDGAF (feat. Yeat)',260,NULL,'https://open.spotify.com/track/2YSzYUF3jWqb9YP9VXmpjE',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',78,7),('2yYDijitHN6psA2tH0ndXs','The Birds Pt. 2',350,NULL,'https://open.spotify.com/track/2yYDijitHN6psA2tH0ndXs',NULL,'6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',62,6),('2Z7DOCFmui7BBB8vbLlgR1','Life\'s Too Short - Instrumental',178,NULL,'https://open.spotify.com/track/2Z7DOCFmui7BBB8vbLlgR1',NULL,'11lLYKMkFheiV7ObD7WCnx','6YVMFz59CuY7ngCxTxjpxE',32,2),('2ZL7WZcjuYKi1KUDtp4kCC','Spin Bout U',214,NULL,'https://open.spotify.com/track/2ZL7WZcjuYKi1KUDtp4kCC',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',77,6),('2ZlABhxMMa43COmZ97kKsJ','Jumbotron Shit Poppin',137,NULL,'https://open.spotify.com/track/2ZlABhxMMa43COmZ97kKsJ',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',69,13),('2zrhoHlFKxFTRF5aMyxMoQ','Next Level',221,NULL,'https://open.spotify.com/track/2zrhoHlFKxFTRF5aMyxMoQ',NULL,'2CzbrboOLzeRoaaH1N5K0N','6YVMFz59CuY7ngCxTxjpxE',74,1),('30nRBCh0wGhKiTLNWN3k3L','Just the Way You Are - Simon Steur Club Mix',337,NULL,'https://open.spotify.com/track/30nRBCh0wGhKiTLNWN3k3L',NULL,'7BzP09BlvvE4ioNgvdLrdm','0du5cEVh5yTK9QJze8zA0C',44,1),('30raivfq7rSt5nKltiHfzG','Moonshine',228,NULL,'https://open.spotify.com/track/30raivfq7rSt5nKltiHfzG',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',61,5),('311yZZsI1VeKucIBm2dxvK','가',252,NULL,'https://open.spotify.com/track/311yZZsI1VeKucIBm2dxvK',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',10,4),('31bsuKDOzFGzBAoXxtnAJm','I Guess It’s Fuck Me',263,NULL,'https://open.spotify.com/track/31bsuKDOzFGzBAoXxtnAJm',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',66,16),('31FWGQxshq14SCZvvyHae1','The Resistance',225,NULL,'https://open.spotify.com/track/31FWGQxshq14SCZvvyHae1',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',63,3),('31kNjKUQC8pMaEyY4BSdba','Who Am I',258,NULL,'https://open.spotify.com/track/31kNjKUQC8pMaEyY4BSdba',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',0,8),('32HKm4gUeUqQ8SQ28uGYUo','After Hours',361,NULL,'https://open.spotify.com/track/32HKm4gUeUqQ8SQ28uGYUo',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',63,13),('330IIz7d75eqAsKq1xhzXR','Better Things',203,NULL,'https://open.spotify.com/track/330IIz7d75eqAsKq1xhzXR',NULL,'5NMtxQJy4wq3mpo3ERVnLs','6YVMFz59CuY7ngCxTxjpxE',61,7),('33TCfb4mgWlCTzxb1q21r9','Winter Ahead (with PARK HYO SHIN)',234,NULL,'https://open.spotify.com/track/33TCfb4mgWlCTzxb1q21r9',NULL,'1e5ELECrQq5yoquPwoXzkd','57htMBtzpppc1yoXgjbslj',81,1),('343YBumqHu19cGoGARUTsd','Fake Love',210,NULL,'https://open.spotify.com/track/343YBumqHu19cGoGARUTsd',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',73,20),('346ThSMhw0l2rcWjsm0bZ7','거울',255,NULL,'https://open.spotify.com/track/346ThSMhw0l2rcWjsm0bZ7',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',2,4),('34D6FJysnQioVingDKufuf','N 2 Deep',273,NULL,'https://open.spotify.com/track/34D6FJysnQioVingDKufuf',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',70,9),('34nSJrquH2c8LNbfnRffMF','Dancing In The Flames - Acoustic',208,NULL,'https://open.spotify.com/track/34nSJrquH2c8LNbfnRffMF',NULL,'0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',51,2),('34QlcZ3BZxRrZh4x3jMm1A','You & Me (Instrumental)',278,NULL,'https://open.spotify.com/track/34QlcZ3BZxRrZh4x3jMm1A',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',2,17),('34r29cNzzV4elD0XTz1ihT','Next Level - Habstrakt Remix',200,NULL,'https://open.spotify.com/track/34r29cNzzV4elD0XTz1ihT',NULL,'36cJnr7GCuGbuw0YQpjmTY','6YVMFz59CuY7ngCxTxjpxE',42,1),('34scBtso4UA1hjju5t5FYE','She′s Mine',224,NULL,'https://open.spotify.com/track/34scBtso4UA1hjju5t5FYE',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',4,1),('34tz0eDhGuFErIuW3q4mPX','On BS',261,NULL,'https://open.spotify.com/track/34tz0eDhGuFErIuW3q4mPX',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',73,3),('35RJhm1pEovTBwnNR0zWad','GREECE (feat. Drake)',218,NULL,'https://open.spotify.com/track/35RJhm1pEovTBwnNR0zWad',NULL,'3O6ywzP5LE5msmuBBTpaIN','3TVXtAsR1Inumwj472S9r4',72,1),('364ciSfW74iruR0KZcycP4','스니커즈',238,NULL,'https://open.spotify.com/track/364ciSfW74iruR0KZcycP4',NULL,'2YVpqON0I1KS8LjQLqV0uH','1rpgxJZxZMLnFNc1Jmyov5',1,1),('36CVpUB9PJ8SOzEcf2q6os','Crown On My Head (예지)',192,NULL,'https://open.spotify.com/track/36CVpUB9PJ8SOzEcf2q6os',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',14,5),('36K5mnqwfxGS0rvxz7FPyq','Secrets',265,NULL,'https://open.spotify.com/track/36K5mnqwfxGS0rvxz7FPyq',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',48,6),('36LdTnEWBDLDDA3hEsSLvi','High For This',249,NULL,'https://open.spotify.com/track/36LdTnEWBDLDDA3hEsSLvi',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',55,1),('36YCdzT57us0LhDmCYtrNE','Rockin’',232,NULL,'https://open.spotify.com/track/36YCdzT57us0LhDmCYtrNE',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',65,5),('37F0uwRSrdzkBiuj0D5UHI','Reminder',218,NULL,'https://open.spotify.com/track/37F0uwRSrdzkBiuj0D5UHI',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',84,4),('37KFAFhcMGZg3CcAUBVu52','CHERRY',190,NULL,'https://open.spotify.com/track/37KFAFhcMGZg3CcAUBVu52',NULL,'2tj99zihwANHtqmEC2QpCn','2KC9Qb60EaY0kW4eH68vr3',10,2),('37Nqx7iavZpotJSDXZWbJ3','Girls Want Girls (with Lil Baby)',221,NULL,'https://open.spotify.com/track/37Nqx7iavZpotJSDXZWbJ3',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',79,3),('37rYTgp8QkSMyDPgIkGNkf','SWIPE',177,NULL,'https://open.spotify.com/track/37rYTgp8QkSMyDPgIkGNkf',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',20,2),('37vULhf6YM1HbrqcZmbxOV','It′s Gonna Be Rolling',303,NULL,'https://open.spotify.com/track/37vULhf6YM1HbrqcZmbxOV',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',14,7),('37zcCimcUGurQoLEAuN8nR','Is There Someone Else?',199,NULL,'https://open.spotify.com/track/37zcCimcUGurQoLEAuN8nR',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',55,10),('37zSTGaP8bfBDGpJnUmSDl','Same Old Song',312,NULL,'https://open.spotify.com/track/37zSTGaP8bfBDGpJnUmSDl',NULL,'04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',56,6),('386RUes7n1uM1yfzgeUuwp','The Lazy Song',189,NULL,'https://open.spotify.com/track/386RUes7n1uM1yfzgeUuwp',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',82,5),('3899iOqKw5rguY18v7LXXY','A Promise not to Lose - Instrumental',232,NULL,'https://open.spotify.com/track/3899iOqKw5rguY18v7LXXY',NULL,'4MtUmggE3ExRmzshLvmU9o','1rpgxJZxZMLnFNc1Jmyov5',1,2),('38eKmp6QjELXKgLh0pePfG','DON\'T KNOW WHAT TO DO - JP Ver.',200,NULL,'https://open.spotify.com/track/38eKmp6QjELXKgLh0pePfG',NULL,'0uWttVLwkFxcW1PkBAsmZd','41MozSoPIsD1dJM0CLPjZF',42,2),('38tXZcL1gZRfbqfOG0VMTH','How Sweet',219,NULL,'https://open.spotify.com/track/38tXZcL1gZRfbqfOG0VMTH',NULL,'0EhZEM4RRz0yioTgucDhJq','6HvZYsbFfjnjFrWF950C9d',79,1),('39jZHXtH3eNuXhLdgsslsu','고개 숙인 사람들',277,NULL,'https://open.spotify.com/track/39jZHXtH3eNuXhLdgsslsu',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',4,1),('39PgM7eFpkCYFENXgdFQnG','거짓',242,NULL,'https://open.spotify.com/track/39PgM7eFpkCYFENXgdFQnG',NULL,'2YVpqON0I1KS8LjQLqV0uH','1rpgxJZxZMLnFNc1Jmyov5',0,3),('3a8tAZFJxlmBwOtrf5L1oC','6 God',180,NULL,'https://open.spotify.com/track/3a8tAZFJxlmBwOtrf5L1oC',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',64,7),('3ABi5sVjvEp08IQEKh8BmG','Yeah Yeah Yeah',178,NULL,'https://open.spotify.com/track/3ABi5sVjvEp08IQEKh8BmG',NULL,'0S4pP8MBY9p7ngFWIZQAJv','41MozSoPIsD1dJM0CLPjZF',61,4),('3AgMOlgdrG9RJXDWifcjVd','Bet You Wanna (Feat. Cardi B)',159,NULL,'https://open.spotify.com/track/3AgMOlgdrG9RJXDWifcjVd',NULL,'2gNPnKP1PDkB5SZz3IMKuX','41MozSoPIsD1dJM0CLPjZF',62,4),('3aJkV6DUTSCqOwVwaBDG9B','With You',195,NULL,'https://open.spotify.com/track/3aJkV6DUTSCqOwVwaBDG9B',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',66,8),('3aMnOwZbJAYblHeYkT77a4','반쪽게임',207,NULL,'https://open.spotify.com/track/3aMnOwZbJAYblHeYkT77a4',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',4,2),('3aQem4jVGdhtg116TmJnHz','What’s Next',178,NULL,'https://open.spotify.com/track/3aQem4jVGdhtg116TmJnHz',NULL,'5LuoozUhs2pl3glZeAJl89','3TVXtAsR1Inumwj472S9r4',70,1),('3AWDeHLc88XogCaCnZQLVI','Cry For Me',224,NULL,'https://open.spotify.com/track/3AWDeHLc88XogCaCnZQLVI',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',86,2),('3B5UbSndRz907IZhhmUfLi','Count on Me',197,NULL,'https://open.spotify.com/track/3B5UbSndRz907IZhhmUfLi',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',72,9),('3b7trEcKoglybN5MxGuSaw','You Never Know - JP Ver.',229,NULL,'https://open.spotify.com/track/3b7trEcKoglybN5MxGuSaw',NULL,'4CoKhy1Ew4kb4kgonvnMXy','41MozSoPIsD1dJM0CLPjZF',40,1),('3BE3IYsAhqkTiRIR7T7x7M','Gently (feat. Bad Bunny)',133,NULL,'https://open.spotify.com/track/3BE3IYsAhqkTiRIR7T7x7M',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',50,19),('3BHR1mJOqn2UZyq98YKPgd','Typa Girl',179,NULL,'https://open.spotify.com/track/3BHR1mJOqn2UZyq98YKPgd',NULL,'0S4pP8MBY9p7ngFWIZQAJv','41MozSoPIsD1dJM0CLPjZF',70,3),('3bnVNMCk5FJulcpS7aXJbY','Karaoke',227,NULL,'https://open.spotify.com/track/3bnVNMCk5FJulcpS7aXJbY',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',50,2),('3BtuIIrQlkujKPuWF2B85z','Too Good',263,NULL,'https://open.spotify.com/track/3BtuIIrQlkujKPuWF2B85z',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',76,16),('3bWm8ejTzkMhPSdBnpxLvl','One Of The Girls - Slowed',305,NULL,'https://open.spotify.com/track/3bWm8ejTzkMhPSdBnpxLvl',NULL,'4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',56,3),('3ByGktOSPYajR9YOGJKqkc','Voyeurist',268,NULL,'https://open.spotify.com/track/3ByGktOSPYajR9YOGJKqkc',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',21,1),('3C0qDXxwGqc8EyqX0iVndT','넌 언제나',303,NULL,'https://open.spotify.com/track/3C0qDXxwGqc8EyqX0iVndT',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',22,8),('3CA9pLiwRIGtUBiMjbZmRw','Nice For What',210,NULL,'https://open.spotify.com/track/3CA9pLiwRIGtUBiMjbZmRw',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',80,4),('3CAbZ3HKpn3uQwhTjRGbfD','Daydream - Instrumental',288,NULL,'https://open.spotify.com/track/3CAbZ3HKpn3uQwhTjRGbfD',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',5,12),('3cjF2OFRmip8spwZYQRKxP','Feel No Ways',240,NULL,'https://open.spotify.com/track/3cjF2OFRmip8spwZYQRKxP',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',79,4),('3CktmDvZGj21m3pNFj5Lr3','Stargirl Interlude (feat. Lana Del Rey)',111,NULL,'https://open.spotify.com/track/3CktmDvZGj21m3pNFj5Lr3',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',55,8),('3CRYykOC8kHuSUWKPOmpgN','I Guess I Loved You - 2016 Version',232,NULL,'https://open.spotify.com/track/3CRYykOC8kHuSUWKPOmpgN',NULL,'2wA8OXIv1JXX9kTY2ddfR4','1rpgxJZxZMLnFNc1Jmyov5',39,6),('3cVjoFIZmyZQd1ouT78biR','Psychic Lover',164,NULL,'https://open.spotify.com/track/3cVjoFIZmyZQd1ouT78biR',NULL,'5tXD77S3yCWTToU5eMLnlo','2KC9Qb60EaY0kW4eH68vr3',17,5),('3CY3zAjrxKVInh2Lq1QiRb','PIMMIE\'S DILEMMA',118,NULL,'https://open.spotify.com/track/3CY3zAjrxKVInh2Lq1QiRb',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',71,8),('3d4KH7YQwsb7Af3da6Dx8l','Dirty Work - Instrumental',180,NULL,'https://open.spotify.com/track/3d4KH7YQwsb7Af3da6Dx8l',NULL,'1oJztb2MfwieRwHZ1t4NrN','6YVMFz59CuY7ngCxTxjpxE',54,4),('3D7izPzeEcz7lBhcCZJccl','Belong To The World',307,NULL,'https://open.spotify.com/track/3D7izPzeEcz7lBhcCZJccl',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',54,5),('3dbLT62Cvs46Ju7a8gpr36','Savage',238,NULL,'https://open.spotify.com/track/3dbLT62Cvs46Ju7a8gpr36',NULL,'3vyyDkvYWC36DwgZCYd3Wu','6YVMFz59CuY7ngCxTxjpxE',74,2),('3DBumrwaikaisVDQdcM7jU','Life Of The Party',296,NULL,'https://open.spotify.com/track/3DBumrwaikaisVDQdcM7jU',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',54,2),('3DCc4HPrVukBeaDGe3Cosk','Starboy (feat. Daft Punk) - Kygo Remix',244,NULL,'https://open.spotify.com/track/3DCc4HPrVukBeaDGe3Cosk',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',56,20),('3dCCHYqCAMdm1GCuklUaZG','Ditto (250 Remix) (Instrumental)',201,NULL,'https://open.spotify.com/track/3dCCHYqCAMdm1GCuklUaZG',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',48,7),('3DD2VHxnv7C9Hew8s7Zgjf','Not Shy',177,NULL,'https://open.spotify.com/track/3DD2VHxnv7C9Hew8s7Zgjf',NULL,'7GiJLfFllsMNTwMZlFxzIK','2KC9Qb60EaY0kW4eH68vr3',39,1),('3dgQqOiQ9fCKVhNOedd2lf','Started From the Bottom',174,NULL,'https://open.spotify.com/track/3dgQqOiQ9fCKVhNOedd2lf',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',68,3),('3dhjNA0jGA8vHBQ1VdD6vV','I Feel It Coming',269,NULL,'https://open.spotify.com/track/3dhjNA0jGA8vHBQ1VdD6vV',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',80,18),('3dkuTvO5013XHxiofIW9Qg','Just the Way You Are - Carl Louis & Martin Danielle Classic Mix',317,NULL,'https://open.spotify.com/track/3dkuTvO5013XHxiofIW9Qg',NULL,'7BzP09BlvvE4ioNgvdLrdm','0du5cEVh5yTK9QJze8zA0C',42,4),('3dojEtzUKwDAzLyRDdi8WD','LOCO - English Ver.',191,NULL,'https://open.spotify.com/track/3dojEtzUKwDAzLyRDdi8WD',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',3,10),('3dQEShIMs5TW8H3eUh11r7','Twenty Eight',258,NULL,'https://open.spotify.com/track/3dQEShIMs5TW8H3eUh11r7',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',63,10),('3DV2xXDpxZKF0taEowHh5D','사랑 사랑 사랑',207,NULL,'https://open.spotify.com/track/3DV2xXDpxZKF0taEowHh5D',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',9,1),('3dvBEwRdcnh1aZVdT87GN1','Drama',214,NULL,'https://open.spotify.com/track/3dvBEwRdcnh1aZVdT87GN1',NULL,'6wlo2cGnBTzluPkeMDiOy0','6YVMFz59CuY7ngCxTxjpxE',44,2),('3e0ZGE7Gp034iLknjQk4QW','Can I',189,NULL,'https://open.spotify.com/track/3e0ZGE7Gp034iLknjQk4QW',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',69,17),('3eCIjeKAdjt5UrtfnptHTI','Drifting Free',206,NULL,'https://open.spotify.com/track/3eCIjeKAdjt5UrtfnptHTI',NULL,'6xA5SblTTyphoYnDQoYeVc','1rpgxJZxZMLnFNc1Jmyov5',14,1),('3eh51r6rFWAlGQRlHx9QnQ','Push Ups',232,NULL,'https://open.spotify.com/track/3eh51r6rFWAlGQRlHx9QnQ',NULL,'06me0leRR3AuF4IFiEytml','3TVXtAsR1Inumwj472S9r4',75,1),('3EI3OLBeM89B0o0UsIGCOx','Trick or Trick',175,NULL,'https://open.spotify.com/track/3EI3OLBeM89B0o0UsIGCOx',NULL,'5NMtxQJy4wq3mpo3ERVnLs','6YVMFz59CuY7ngCxTxjpxE',58,2),('3EJ9ZuqkL1kwgouugqsLu8','Own It',252,NULL,'https://open.spotify.com/track/3EJ9ZuqkL1kwgouugqsLu8',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',56,5),('3eP13S8D5m2cweMEg3ZDed','Virginia Beach',251,NULL,'https://open.spotify.com/track/3eP13S8D5m2cweMEg3ZDed',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',75,1),('3Ew4e1bJrauWCkS5ef7iiL','좋은 사람 (Live Version)',254,NULL,'https://open.spotify.com/track/3Ew4e1bJrauWCkS5ef7iiL',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',5,1),('3F5CgOj3wFlRv51JsHbxhe','Jimmy Cooks (feat. 21 Savage)',218,NULL,'https://open.spotify.com/track/3F5CgOj3wFlRv51JsHbxhe',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',83,14),('3F7VrA3ttl6i6Z4b2KJ9YR','FOREVER YOUNG - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',255,NULL,'https://open.spotify.com/track/3F7VrA3ttl6i6Z4b2KJ9YR',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',40,2),('3Ff0mxSOEJbjLVkwghCZZ3','Girls Will Be Girls - Tech House Remix',166,NULL,'https://open.spotify.com/track/3Ff0mxSOEJbjLVkwghCZZ3',NULL,'5Dz30uiKFlqDemyDhW63ZL','2KC9Qb60EaY0kW4eH68vr3',16,2),('3FGERgCbqbX0h5SiTsiSvf','기억속의 먼 그대에게',289,NULL,'https://open.spotify.com/track/3FGERgCbqbX0h5SiTsiSvf',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',34,9),('3FHO87BSOEVAsedSnCTnvz','BRIAN STEEL',111,NULL,'https://open.spotify.com/track/3FHO87BSOEVAsedSnCTnvz',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',69,9),('3fow3JdYxM1AXAt4otZPlt','하노이의 별',372,NULL,'https://open.spotify.com/track/3fow3JdYxM1AXAt4otZPlt',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',1,9),('3fUfgvE2JbbvVNlfiDJzNM','나는 상수역이 좋다',262,NULL,'https://open.spotify.com/track/3fUfgvE2JbbvVNlfiDJzNM',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',11,8),('3FvDYk5IC5Um84kK5FbJGR','Adaptation',283,NULL,'https://open.spotify.com/track/3FvDYk5IC5Um84kK5FbJGR',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',47,3),('3FwCFPLwoGcN28wIM6owbc','ICY -Japanese ver.-',191,NULL,'https://open.spotify.com/track/3FwCFPLwoGcN28wIM6owbc',NULL,'59vClLXHQp6vY4IfO0SDmm','2KC9Qb60EaY0kW4eH68vr3',2,2),('3G5iN5QBqMeXx3uZPy8tgB','Young Girls',228,NULL,'https://open.spotify.com/track/3G5iN5QBqMeXx3uZPy8tgB',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',69,1),('3gj1hwjku4JaoamjJVqIIl','Dawn FM',96,NULL,'https://open.spotify.com/track/3gj1hwjku4JaoamjJVqIIl',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',44,1),('3Gk1LfB771PIEGgsEa7gcV','Love To Hate Me',169,NULL,'https://open.spotify.com/track/3Gk1LfB771PIEGgsEa7gcV',NULL,'2gNPnKP1PDkB5SZz3IMKuX','41MozSoPIsD1dJM0CLPjZF',64,7),('3GoTryTXWTbnGqPt2k1OaO','1178',272,NULL,'https://open.spotify.com/track/3GoTryTXWTbnGqPt2k1OaO',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',10,10),('3gtlthEgyulDfT8dWdKsnv','Spicy',197,NULL,'https://open.spotify.com/track/3gtlthEgyulDfT8dWdKsnv',NULL,'55N0UTP5992idhnEYOKYd9','6YVMFz59CuY7ngCxTxjpxE',71,2),('3H3qBumaYj67PT3aMEBvAP','As You Are',340,NULL,'https://open.spotify.com/track/3H3qBumaYj67PT3aMEBvAP',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',67,11),('3hDLtzsTx5uRVzIfc2hXvW','Itr\'s Gone',256,NULL,'https://open.spotify.com/track/3hDLtzsTx5uRVzIfc2hXvW',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',5,6),('3hvdNPn0NK0Nj6J49NFGww','The wind is blowing',281,NULL,'https://open.spotify.com/track/3hvdNPn0NK0Nj6J49NFGww',NULL,'63W6Zfm99reI0hTeMpRtUO','57htMBtzpppc1yoXgjbslj',31,1),('3i2w6O98pzUUmqRJavWF6f','Dirty Work (feat. Flo Milli)',180,NULL,'https://open.spotify.com/track/3i2w6O98pzUUmqRJavWF6f',NULL,'1oJztb2MfwieRwHZ1t4NrN','6YVMFz59CuY7ngCxTxjpxE',70,2),('3I71PFicYG614VGl6hqcUK','나는 나비',214,NULL,'https://open.spotify.com/track/3I71PFicYG614VGl6hqcUK',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',53,2),('3iC3qlIi0KqATuA86pRGcZ','WHISTLE - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',214,NULL,'https://open.spotify.com/track/3iC3qlIi0KqATuA86pRGcZ',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',39,4),('3IDZYcnTpLKKaB0KoW3BoE','Blah Blah Blah',186,NULL,'https://open.spotify.com/track/3IDZYcnTpLKKaB0KoW3BoE',NULL,'0SbnkLLiTqVmoPmhY80s7S','2KC9Qb60EaY0kW4eH68vr3',2,1),('3IEhmU6zqpzGBnVWxLgs6S','Up All Night',234,NULL,'https://open.spotify.com/track/3IEhmU6zqpzGBnVWxLgs6S',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',28,6),('3IHt4j5uAEl7iBu8Utn985','Tried Our Best',209,NULL,'https://open.spotify.com/track/3IHt4j5uAEl7iBu8Utn985',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',71,11),('3iONHeDoMOEB5ctRtrufAk','꿈을 뺏고 있는 범인을 찾아라',222,NULL,'https://open.spotify.com/track/3iONHeDoMOEB5ctRtrufAk',NULL,'0pjhLqD8bXav2eXgbnvzHE','1rpgxJZxZMLnFNc1Jmyov5',0,1),('3IOVhVnwfw2xglOYei2JAn','Better Things - RAYE Remix',205,NULL,'https://open.spotify.com/track/3IOVhVnwfw2xglOYei2JAn',NULL,'3ukWjsUrP70en9dcpt01Hs','6YVMFz59CuY7ngCxTxjpxE',41,1),('3iPmwJh56xbDF7Xduimf0d','Nothing Without You',198,NULL,'https://open.spotify.com/track/3iPmwJh56xbDF7Xduimf0d',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',44,15),('3IQgeOgdHIag6mu0mgKRgQ','The Language',224,NULL,'https://open.spotify.com/track/3IQgeOgdHIag6mu0mgKRgQ',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',56,10),('3iRYyU6LhuBD2uXsDjEsRw','Stay Alive',221,NULL,'https://open.spotify.com/track/3iRYyU6LhuBD2uXsDjEsRw',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',4,10),('3IvMYBE7A3c7to1aEcfFJk','Deep Pockets',222,NULL,'https://open.spotify.com/track/3IvMYBE7A3c7to1aEcfFJk',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',58,1),('3iZSEyp262Fg2wclEO0UOJ','Me Too',240,NULL,'https://open.spotify.com/track/3iZSEyp262Fg2wclEO0UOJ',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',10,5),('3Jpy6YZ1LNxEAJPDhcD0C5','Girls Will Be Girls - EDM Remix',155,NULL,'https://open.spotify.com/track/3Jpy6YZ1LNxEAJPDhcD0C5',NULL,'5Dz30uiKFlqDemyDhW63ZL','2KC9Qb60EaY0kW4eH68vr3',16,3),('3jSimkYPNkbOdRhlx2dUw6','보낼 수 없는 너',247,NULL,'https://open.spotify.com/track/3jSimkYPNkbOdRhlx2dUw6',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',24,9),('3jtGERvgDc2saUnWCY8f1d','WANNABE - Inst.',191,NULL,'https://open.spotify.com/track/3jtGERvgDc2saUnWCY8f1d',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',4,13),('3JvdrCezbM6DQOjNiBiX5q','Die For It (ft. Nas)',199,NULL,'https://open.spotify.com/track/3JvdrCezbM6DQOjNiBiX5q',NULL,'5vgkX6abffhom2ejVI11yq','1Xyo4u8uXC1ZmMpatF05PJ',46,1),('3JZjcKImHcmOI9ylL4zrSc','Bahamas Promises',184,NULL,'https://open.spotify.com/track/3JZjcKImHcmOI9ylL4zrSc',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',68,10),('3k7FTBQkstaBcYHamx9jqe','Beautiful Christmas',209,NULL,'https://open.spotify.com/track/3k7FTBQkstaBcYHamx9jqe',NULL,'1oniugll0x2gZ3l7o4z9iG','6YVMFz59CuY7ngCxTxjpxE',48,1),('3k9WRYmrEqCyrtzE4Lf3hv','Better Things',203,NULL,'https://open.spotify.com/track/3k9WRYmrEqCyrtzE4Lf3hv',NULL,'0jXtQE6F6FYFLPx0S3Gp1D','6YVMFz59CuY7ngCxTxjpxE',32,4),('3kbfF595mo5Ly6P57KnMLC','Girl Of My Dreams (Feat. Anny)',234,NULL,'https://open.spotify.com/track/3kbfF595mo5Ly6P57KnMLC',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',7,5),('3kdEGx81MR9ftxRbF3Zf84','Often - Live',148,NULL,'https://open.spotify.com/track/3kdEGx81MR9ftxRbF3Zf84',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',49,10),('3kgqHVqfiabABjaFi9Tnhn','Live For',222,NULL,'https://open.spotify.com/track/3kgqHVqfiabABjaFi9Tnhn',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',55,6),('3KixNgUEaDtrKJVzdqjU5q','Landed',152,NULL,'https://open.spotify.com/track/3KixNgUEaDtrKJVzdqjU5q',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',60,8),('3KlSnskwESm6SsfVw2RvPQ','Talk To Me',197,NULL,'https://open.spotify.com/track/3KlSnskwESm6SsfVw2RvPQ',NULL,'73O0qUbaKCFbJ2EfZID1uo','1rpgxJZxZMLnFNc1Jmyov5',0,2),('3kOtREqmcGaEA2KhqffFnw','How Do I Make You Love Me?',214,NULL,'https://open.spotify.com/track/3kOtREqmcGaEA2KhqffFnw',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',59,3),('3KyKxJ4P3pVCgaZwaq2rUC','Gasoline',212,NULL,'https://open.spotify.com/track/3KyKxJ4P3pVCgaZwaq2rUC',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',70,2),('3lcEVP5beEkAFiFIG5D0QF','The Town',307,NULL,'https://open.spotify.com/track/3lcEVP5beEkAFiFIG5D0QF',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',49,2),('3lkkkYc1wBj5l3FVlpqvP6','A Night Off (feat. Lloyd)',193,NULL,'https://open.spotify.com/track/3lkkkYc1wBj5l3FVlpqvP6',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',59,7),('3LuHhVQHeHRY0qTAPdl2rx','Christ mas Serendipity - Hidden Track Version',288,NULL,'https://open.spotify.com/track/3LuHhVQHeHRY0qTAPdl2rx',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',9,15),('3mHO1J6kfiArjBo1zhLFGP','Coming Down',295,NULL,'https://open.spotify.com/track/3mHO1J6kfiArjBo1zhLFGP',NULL,'7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',81,7),('3MJdKvdoEFwKyrD4rznLAI','Die With A Smile - Instrumental',251,NULL,'https://open.spotify.com/track/3MJdKvdoEFwKyrD4rznLAI',NULL,'29uwnLOApt6HvRw3Ll83vG','0du5cEVh5yTK9QJze8zA0C',41,4),('3mpGXkkjhY8K5C9OsaCMBo','KILL THIS LOVE - JP Ver.',189,NULL,'https://open.spotify.com/track/3mpGXkkjhY8K5C9OsaCMBo',NULL,'0uWttVLwkFxcW1PkBAsmZd','41MozSoPIsD1dJM0CLPjZF',48,1),('3mynPhglTz2Ggh8SxA34kR','Rockin’',232,NULL,'https://open.spotify.com/track/3mynPhglTz2Ggh8SxA34kR',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',47,5),('3MZGszylNMcgLz4ZfM6dHd','DDU-DU-DDU-DU',241,NULL,'https://open.spotify.com/track/3MZGszylNMcgLz4ZfM6dHd',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',43,11),('3N3d4OWbPVxTQVBFqNyykk','Down Hill',250,NULL,'https://open.spotify.com/track/3N3d4OWbPVxTQVBFqNyykk',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',59,11),('3nHat22UwPywIevUrXIhy1','Bahamas Promises',184,NULL,'https://open.spotify.com/track/3nHat22UwPywIevUrXIhy1',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',53,10),('3NxAG2ni1lLa8RKL6a0INc','Childs Play',241,NULL,'https://open.spotify.com/track/3NxAG2ni1lLa8RKL6a0INc',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',70,14),('3o09hPONBfGOdH2lKq1lLC','Only U',206,NULL,'https://open.spotify.com/track/3o09hPONBfGOdH2lKq1lLC',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',15,11),('3O8NlPh2LByMU9lSRSHedm','Controlla',245,NULL,'https://open.spotify.com/track/3O8NlPh2LByMU9lSRSHedm',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',76,11),('3oCixmy05T9pCmpf6Xafe5','Cece\'s Interlude',154,NULL,'https://open.spotify.com/track/3oCixmy05T9pCmpf6Xafe5',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',25,12),('3oCrC1928WBf3P3kgDQNx9','깃발',204,NULL,'https://open.spotify.com/track/3oCrC1928WBf3P3kgDQNx9',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',3,3),('3OGlklVPmFmu6Tm0fQ1JpB','Sideways',253,NULL,'https://open.spotify.com/track/3OGlklVPmFmu6Tm0fQ1JpB',NULL,'69eqA59bgh09wQ2MT1AlnL','3TVXtAsR1Inumwj472S9r4',60,1),('3Oi1pDSYLVkz3i8jOXaQdt','Just Another Girl',184,NULL,'https://open.spotify.com/track/3Oi1pDSYLVkz3i8jOXaQdt',NULL,'3OaW4df1SA62k0arNpn6bK','6YVMFz59CuY7ngCxTxjpxE',53,6),('3oJ2x2zkGfmzk7ZT3lpAUG','Last Farewell',227,NULL,'https://open.spotify.com/track/3oJ2x2zkGfmzk7ZT3lpAUG',NULL,'3wtbBSjOhKOw7UdngHEDiO','57htMBtzpppc1yoXgjbslj',9,3),('3OJrmjJW9EZAqyEjHl0qEc','아리랑',229,NULL,'https://open.spotify.com/track/3OJrmjJW9EZAqyEjHl0qEc',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',8,16),('3OQWohbPUsvbXaH1AiRazX','YOLO',189,NULL,'https://open.spotify.com/track/3OQWohbPUsvbXaH1AiRazX',NULL,'5NMtxQJy4wq3mpo3ERVnLs','6YVMFz59CuY7ngCxTxjpxE',54,5),('3orEOtd8CPL8GFlpRpKuoE','Faith',283,NULL,'https://open.spotify.com/track/3orEOtd8CPL8GFlpRpKuoE',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',70,8),('3oZWZlxfXuUbbUPndAfmRR','Kick It - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',193,NULL,'https://open.spotify.com/track/3oZWZlxfXuUbbUPndAfmRR',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',36,10),('3p2uELYRSpa4KNH6Ufp57I','Treasure - Bailey Smalls Dub',288,NULL,'https://open.spotify.com/track/3p2uELYRSpa4KNH6Ufp57I',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',27,10),('3P4v70V3Zt804r2c9dZivK','Somewhere in Brooklyn',181,NULL,'https://open.spotify.com/track/3P4v70V3Zt804r2c9dZivK',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',56,11),('3PbGhkiH1yyumkzmpF1J1G','None of My Business',202,NULL,'https://open.spotify.com/track/3PbGhkiH1yyumkzmpF1J1G',NULL,'5tXD77S3yCWTToU5eMLnlo','2KC9Qb60EaY0kW4eH68vr3',22,3),('3pkIaou3w14ytyKYZbg0hc','DDU-DU DDU-DU (Remix)',201,NULL,'https://open.spotify.com/track/3pkIaou3w14ytyKYZbg0hc',NULL,'3qw2vm3uqKT3EIg95wbg83','41MozSoPIsD1dJM0CLPjZF',54,5),('3ppVO2tyWRRznNmONvt7Se','Summers Over Interlude',106,NULL,'https://open.spotify.com/track/3ppVO2tyWRRznNmONvt7Se',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',75,17),('3PUF79SWDEwh0JBKyMdhRO','남자는 배 여자는 항구 - Live',218,NULL,'https://open.spotify.com/track/3PUF79SWDEwh0JBKyMdhRO',NULL,'3cjssumQEsRatYlYG5K86T','1rpgxJZxZMLnFNc1Jmyov5',3,1),('3Q4gttWQ6hxqWOa3tHoTNi','Not You Too (feat. Chris Brown)',269,NULL,'https://open.spotify.com/track/3Q4gttWQ6hxqWOa3tHoTNi',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',82,4),('3q5qpprtugUIEPExuI7tRD','Welcome To MY World (feat. nævis)',206,NULL,'https://open.spotify.com/track/3q5qpprtugUIEPExuI7tRD',NULL,'69xF8jTd0c4Zoo7DT3Rwrn','6YVMFz59CuY7ngCxTxjpxE',54,1),('3q6TQTEbiLNv3RfNQfPgo3','You’re Mines Still (feat. Drake)',226,NULL,'https://open.spotify.com/track/3q6TQTEbiLNv3RfNQfPgo3',NULL,'5t3AooZ5peKSKltkjr12Qm','3TVXtAsR1Inumwj472S9r4',54,1),('3qGJF4e78Qmq1rbZbWXQn0','그대로',337,NULL,'https://open.spotify.com/track/3qGJF4e78Qmq1rbZbWXQn0',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',2,8),('3QLjDkgLh9AOEHlhQtDuhs','Best I Ever Had',257,NULL,'https://open.spotify.com/track/3QLjDkgLh9AOEHlhQtDuhs',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',80,10),('3qN5qMTKyEEmiTZD38BNTT','I\'m Upset',214,NULL,'https://open.spotify.com/track/3qN5qMTKyEEmiTZD38BNTT',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',67,6),('3QQyaBhRNcDmqpWRssT7dh','Goodbye',288,NULL,'https://open.spotify.com/track/3QQyaBhRNcDmqpWRssT7dh',NULL,'7AVPWq0bdemQcflSSHMfBx','57htMBtzpppc1yoXgjbslj',49,1),('3QS9ZCtoSCJhmaJ7QNXSAS','act ii: date @ 8 (feat. Drake) - remix',231,NULL,'https://open.spotify.com/track/3QS9ZCtoSCJhmaJ7QNXSAS',NULL,'7luH8lI8B6c4r3TxLJ2aU1','3TVXtAsR1Inumwj472S9r4',74,1),('3QWENKFYGEgp3itgTnrgq9','Initiation',260,NULL,'https://open.spotify.com/track/3QWENKFYGEgp3itgTnrgq9',NULL,'04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',54,5),('3QXov5M0VLI3ROldfiSwj0','Lingo',156,NULL,'https://open.spotify.com/track/3QXov5M0VLI3ROldfiSwj0',NULL,'2rwRvLdjGzjSYl9AS3UbvH','6YVMFz59CuY7ngCxTxjpxE',27,3),('3r3IAoLN0q8XrYhl4YUZIO','물고기와 자전거',234,NULL,'https://open.spotify.com/track/3r3IAoLN0q8XrYhl4YUZIO',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',12,8),('3r5lHFACTti0w2REN5tcrn','Sidewalks (feat. Kendrick Lamar)',231,NULL,'https://open.spotify.com/track/3r5lHFACTti0w2REN5tcrn',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',49,9),('3R5OJb8qtWPat81CZwjYNM','처음처럼',311,NULL,'https://open.spotify.com/track/3R5OJb8qtWPat81CZwjYNM',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',2,4),('3r8RuvgbX9s7ammBn07D3W','Ditto',185,NULL,'https://open.spotify.com/track/3r8RuvgbX9s7ammBn07D3W',NULL,'7bnqo1fdJU9nSfXQd3bSMe','6HvZYsbFfjnjFrWF950C9d',81,1),('3r9jWD2MMaRN3ptJGt4nec','You & Me',279,NULL,'https://open.spotify.com/track/3r9jWD2MMaRN3ptJGt4nec',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',9,3),('3RaCGXCiiMufRPoexXxGkV','Slime You Out (feat. SZA)',310,NULL,'https://open.spotify.com/track/3RaCGXCiiMufRPoexXxGkV',NULL,'4DjJtllSDzVDBf7PYtsHaT','3TVXtAsR1Inumwj472S9r4',70,1),('3rE5PBReux0vbrIqbWFLnt','Tuscan Leather',366,NULL,'https://open.spotify.com/track/3rE5PBReux0vbrIqbWFLnt',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',58,1),('3RkNXZvOSMMElmmXztDc94','F*****g Fans',245,NULL,'https://open.spotify.com/track/3RkNXZvOSMMElmmXztDc94',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',66,20),('3RUVLIRUNA3KHLt8pd8PL6','Golden - Acapella',192,NULL,'https://open.spotify.com/track/3RUVLIRUNA3KHLt8pd8PL6',NULL,'2q4uMcogIfSvbjZevQTIDL','2yNNYQBChuox9A5Ka93BIn',77,3),('3RXUgPNIbUgFxsDWuBQEt6','How It’s Done',176,NULL,'https://open.spotify.com/track/3RXUgPNIbUgFxsDWuBQEt6',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',96,2),('3s4nSw9yp1wdyHCmRFYvtI','Wild Flower (Inst.)',312,NULL,'https://open.spotify.com/track/3s4nSw9yp1wdyHCmRFYvtI',NULL,'4aLnzOsnBf5gqTDMJn3XLz','57htMBtzpppc1yoXgjbslj',12,2),('3sDIlJZzYNHtnSuuOxvTal','Die With A Smile - Acoustic',251,NULL,'https://open.spotify.com/track/3sDIlJZzYNHtnSuuOxvTal',NULL,'29uwnLOApt6HvRw3Ll83vG','0du5cEVh5yTK9QJze8zA0C',50,3),('3sgxEZJ4uBcRpC5ZKdKtC6','Shine Your Light',255,NULL,'https://open.spotify.com/track/3sgxEZJ4uBcRpC5ZKdKtC6',NULL,'39ezXXrm2nHqhuErFyPAsO','57htMBtzpppc1yoXgjbslj',10,1),('3SLIkSNtoRyCaoQbitw88X','Die With A Smile - Instrumental',251,NULL,'https://open.spotify.com/track/3SLIkSNtoRyCaoQbitw88X',NULL,'3BQuktwdgPu30k6QSUslCr','0du5cEVh5yTK9QJze8zA0C',45,2),('3sMC6vfTTSa0mMAPTwzDVD','I Get Lonely',253,NULL,'https://open.spotify.com/track/3sMC6vfTTSa0mMAPTwzDVD',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',63,9),('3SnXwQUrvSacFziUYXTNKY','Congratulations',332,NULL,'https://open.spotify.com/track/3SnXwQUrvSacFziUYXTNKY',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',51,18),('3SReOm0IHFtzUGNEfpWH1V','Treasure - Robert DeLong Radio Edit',178,NULL,'https://open.spotify.com/track/3SReOm0IHFtzUGNEfpWH1V',NULL,'7yBnuW3SpMKy3EB9iU0C7p','0du5cEVh5yTK9QJze8zA0C',41,4),('3SYaLJHfxIDeJAirXoTquF','Trust Me (MIDZY) (English Ver.)',221,NULL,'https://open.spotify.com/track/3SYaLJHfxIDeJAirXoTquF',NULL,'031mrCnL4e0qsf5GQdH6ER','2KC9Qb60EaY0kW4eH68vr3',0,2),('3szf2z1Cy1QMrtHrbn8rz9','Elevate',184,NULL,'https://open.spotify.com/track/3szf2z1Cy1QMrtHrbn8rz9',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',62,3),('3t8pnImpBpOwxdtYBpKvA9','The Motion',241,NULL,'https://open.spotify.com/track/3t8pnImpBpOwxdtYBpKvA9',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',66,16),('3TBFOYhRrY2lL4lcmtvIrU','My Sweet Lord',192,NULL,'https://open.spotify.com/track/3TBFOYhRrY2lL4lcmtvIrU',NULL,'10SppFk45za4CHPEiiuQaD','1Xyo4u8uXC1ZmMpatF05PJ',47,2),('3Tjupe9BJ6gfGbQIgtmrMX','Die With A Smile - Live in Las Vegas',280,NULL,'https://open.spotify.com/track/3Tjupe9BJ6gfGbQIgtmrMX',NULL,'2vA3dDRHJtEeThXAlf1L8z','0du5cEVh5yTK9QJze8zA0C',53,1),('3Tk59JmTIsIpBRL1bBwhMe','Dark Arts - Instrumental',181,NULL,'https://open.spotify.com/track/3Tk59JmTIsIpBRL1bBwhMe',NULL,'1YItIfS2HNJkWIgaoj50SM','6YVMFz59CuY7ngCxTxjpxE',50,2),('3tP6QKbXvtrxiDI7QwKyUf','STAY',230,NULL,'https://open.spotify.com/track/3tP6QKbXvtrxiDI7QwKyUf',NULL,'2Fna4Tb7fme5aHsNMJtVtp','41MozSoPIsD1dJM0CLPjZF',71,2),('3trg82Eql6tqi2EAxluhy8','Versace on the Floor',261,NULL,'https://open.spotify.com/track/3trg82Eql6tqi2EAxluhy8',NULL,'3X801hUAmbUAHmatvmMhfA','0du5cEVh5yTK9QJze8zA0C',55,1),('3TVnaEVbUBFmWYk9IOIwRo','Don’t Break My Heart',205,NULL,'https://open.spotify.com/track/3TVnaEVbUBFmWYk9IOIwRo',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',46,13),('3u6Knotm44XwggprlvmPtW','Don’t Know What To Do - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',203,NULL,'https://open.spotify.com/track/3u6Knotm44XwggprlvmPtW',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',38,6),('3uF1OWGo2QpS00xbtsrMX0','Locked N Loaded',145,NULL,'https://open.spotify.com/track/3uF1OWGo2QpS00xbtsrMX0',NULL,'6TA0VcPiUH1a3tPRp3SjbC','2KC9Qb60EaY0kW4eH68vr3',31,3),('3UKKwGrpWWamc0XNSKXjmz','YEPPI YEPPI',213,NULL,'https://open.spotify.com/track/3UKKwGrpWWamc0XNSKXjmz',NULL,'3vyyDkvYWC36DwgZCYd3Wu','6YVMFz59CuY7ngCxTxjpxE',58,4),('3uO7ElBnVSrqUteXcWqBXF','동경',315,NULL,'https://open.spotify.com/track/3uO7ElBnVSrqUteXcWqBXF',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',4,10),('3Upq1Ljn7YpFS6jJL13glH','Show Your Love',238,NULL,'https://open.spotify.com/track/3Upq1Ljn7YpFS6jJL13glH',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',7,1),('3Urv3Mi2c9Lt52TDEcvYay','묻어버린 아픔 (Live Version)',257,NULL,'https://open.spotify.com/track/3Urv3Mi2c9Lt52TDEcvYay',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',3,8),('3V8wDzLWWl1O1Hdldf3TsF','Take My Breath - Instrumental',220,NULL,'https://open.spotify.com/track/3V8wDzLWWl1O1Hdldf3TsF',NULL,'4lBrDelXR6Sn0k54a7UWMz','1Xyo4u8uXC1ZmMpatF05PJ',36,2),('3V937b8IsyJ0ZvVHxreiMs','Faith',283,NULL,'https://open.spotify.com/track/3V937b8IsyJ0ZvVHxreiMs',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',60,8),('3vAdBZvbr3bFBiSLT4iVap','Another One Of Me (feat. 21 Savage)',220,NULL,'https://open.spotify.com/track/3vAdBZvbr3bFBiSLT4iVap',NULL,'2xnqikpcvH2vBYc89VnwwL','1Xyo4u8uXC1ZmMpatF05PJ',51,1),('3vJcz8exedHCjQ9ed95NqU','Every Angel is Terrifying',167,NULL,'https://open.spotify.com/track/3vJcz8exedHCjQ9ed95NqU',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',55,12),('3VMIzuJihoqsgtVDnFB573','Louder',201,NULL,'https://open.spotify.com/track/3VMIzuJihoqsgtVDnFB573',NULL,'7GiJLfFllsMNTwMZlFxzIK','2KC9Qb60EaY0kW4eH68vr3',7,3),('3VN74YiIjtY5ouKahBjmRX','Kick It',191,NULL,'https://open.spotify.com/track/3VN74YiIjtY5ouKahBjmRX',NULL,'3qw2vm3uqKT3EIg95wbg83','41MozSoPIsD1dJM0CLPjZF',62,3),('3VrjgpzoorLGYfaOXaOXOT','How You Like That - JP Ver.',180,NULL,'https://open.spotify.com/track/3VrjgpzoorLGYfaOXaOXOT',NULL,'5FAPIZrpcxQLLte8PlUvxS','41MozSoPIsD1dJM0CLPjZF',46,1),('3VZYMT2OSYxCKPjXCRNgUb','Boys Like You',223,NULL,'https://open.spotify.com/track/3VZYMT2OSYxCKPjXCRNgUb',NULL,'4iL0sqHuipLrqy4y8HRYsZ','2KC9Qb60EaY0kW4eH68vr3',9,4),('3W3FVHEDetkiRkkGKDmdir','Draft Day',266,NULL,'https://open.spotify.com/track/3W3FVHEDetkiRkkGKDmdir',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',56,6),('3w3y8KPTfNeOKPiqUTakBh','Locked out of Heaven',233,NULL,'https://open.spotify.com/track/3w3y8KPTfNeOKPiqUTakBh',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',89,2),('3weHnt82LuCTMa2AnZFM78','Echoes Of Silence',239,NULL,'https://open.spotify.com/track/3weHnt82LuCTMa2AnZFM78',NULL,'04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',55,9),('3WKYPmiPpJas9j5Aari5iK','Love In The Sky',267,NULL,'https://open.spotify.com/track/3WKYPmiPpJas9j5Aari5iK',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',56,4),('3WlbeuhfRSqU7ylK2Ui5U7','Snowchild',247,NULL,'https://open.spotify.com/track/3WlbeuhfRSqU7ylK2Ui5U7',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',65,5),('3WTWh2WDk4j8GUCGj4xfOd','Skate',203,NULL,'https://open.spotify.com/track/3WTWh2WDk4j8GUCGj4xfOd',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',64,8),('3Wuke7oLz3OUMTIeHiWG6V','End And End',239,NULL,'https://open.spotify.com/track/3Wuke7oLz3OUMTIeHiWG6V',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',16,4),('3WXyY2PxX88kpBtB0GH61w','Take My Breath',339,NULL,'https://open.spotify.com/track/3WXyY2PxX88kpBtB0GH61w',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',60,4),('3X37NtwadSS0RM20dh2IgP','Worst Behavior',270,NULL,'https://open.spotify.com/track/3X37NtwadSS0RM20dh2IgP',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',58,6),('3x9eOpLSmtgKgrIdhK0n5B','No Biggie',181,NULL,'https://open.spotify.com/track/3x9eOpLSmtgKgrIdhK0n5B',NULL,'7eNsf4qcc9uV6IklAlPp4b','2KC9Qb60EaY0kW4eH68vr3',3,2),('3XLSlQLJf3Ut0zvMUxnF1h','Houstatlantavegas',290,NULL,'https://open.spotify.com/track/3XLSlQLJf3Ut0zvMUxnF1h',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',68,2),('3xqvU1qJnsIh2aSTVo2DS0','동경',325,NULL,'https://open.spotify.com/track/3xqvU1qJnsIh2aSTVo2DS0',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',9,2),('3xrYWQcYn1mcix1xc3m4BR','변심',270,NULL,'https://open.spotify.com/track/3xrYWQcYn1mcix1xc3m4BR',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',9,3),('3XuUzHVw3f2wZRE6RyoMtM','Run',245,NULL,'https://open.spotify.com/track/3XuUzHVw3f2wZRE6RyoMtM',NULL,'2dXi7YAiDy1IVruIAu5tH8','1rpgxJZxZMLnFNc1Jmyov5',0,2),('3Xz0rSC29WbaobyJQfeYsp','All I Know (feat. Future)',321,NULL,'https://open.spotify.com/track/3Xz0rSC29WbaobyJQfeYsp',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',46,16),('3y8jFVB4SVPiOXWRnOWiWj','타잔 - 2016 Version',288,NULL,'https://open.spotify.com/track/3y8jFVB4SVPiOXWRnOWiWj',NULL,'2wA8OXIv1JXX9kTY2ddfR4','1rpgxJZxZMLnFNc1Jmyov5',19,5),('3YB8sWCxfQyjevEwCrWdiU','Imaginary Friend',202,NULL,'https://open.spotify.com/track/3YB8sWCxfQyjevEwCrWdiU',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',38,2),('3YcDJOpqGjXj6AYhneCXGX','Moth To A Flame (with The Weeknd, feat. Tourist) - Tourist Remix',293,NULL,'https://open.spotify.com/track/3YcDJOpqGjXj6AYhneCXGX',NULL,'0sye9Q82C9Q4tTJN8b0aFq','1Xyo4u8uXC1ZmMpatF05PJ',42,3),('3YPEtDvQWStCH8eCq0Fl8Z','Housekeeping Knows (feat. Latto)',186,NULL,'https://open.spotify.com/track/3YPEtDvQWStCH8eCq0Fl8Z',NULL,'5oT8PMXGWiPlhcl930fkII','3TVXtAsR1Inumwj472S9r4',64,3),('3YQLmSVH53eao8Whgzipuy','MENT 3_SHOW ENDING',141,NULL,'https://open.spotify.com/track/3YQLmSVH53eao8Whgzipuy',NULL,'21NNancB4Bdre5c5VRnbHk','2KC9Qb60EaY0kW4eH68vr3',11,7),('3YZmW6AUHsbN7KhOTd944i','Best Friends - Remix',175,NULL,'https://open.spotify.com/track/3YZmW6AUHsbN7KhOTd944i',NULL,'4a8uxN5j5ZSWuioZ9cHqWk','1Xyo4u8uXC1ZmMpatF05PJ',51,1),('3Z1L6Ydho7WZHFWHsdDsiA','피터팬',273,NULL,'https://open.spotify.com/track/3Z1L6Ydho7WZHFWHsdDsiA',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',13,9),('3z9Oy9V7H2svQSNceTaUHw','Tears Are About Shedding',232,NULL,'https://open.spotify.com/track/3z9Oy9V7H2svQSNceTaUHw',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',14,10),('3zEgr0sLYIGT3WPhAjksCa','Beautiful Day (Feat. SKULL)',221,NULL,'https://open.spotify.com/track/3zEgr0sLYIGT3WPhAjksCa',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',11,8),('3ZevOBi8eQE5OhP3TO1JQA','Karaoke',227,NULL,'https://open.spotify.com/track/3ZevOBi8eQE5OhP3TO1JQA',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',26,2),('3ZhnXFSunfOPWSqfLLQA9W','Pretty',375,NULL,'https://open.spotify.com/track/3ZhnXFSunfOPWSqfLLQA9W',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',45,9),('3ZQFwnUZ8xuKrX4K9XLmOv','Kill Shot',136,NULL,'https://open.spotify.com/track/3ZQFwnUZ8xuKrX4K9XLmOv',NULL,'5tXD77S3yCWTToU5eMLnlo','2KC9Qb60EaY0kW4eH68vr3',19,6),('3ztIMNMX0vlvCYHt1oD51d','Girls Will Be Girls - Rock Remix',147,NULL,'https://open.spotify.com/track/3ztIMNMX0vlvCYHt1oD51d',NULL,'5Dz30uiKFlqDemyDhW63ZL','2KC9Qb60EaY0kW4eH68vr3',18,4),('3ZWo7WYNgYco57owYuMNvg','Jingle Bell Rock - Sped Up Version',93,NULL,'https://open.spotify.com/track/3ZWo7WYNgYco57owYuMNvg',NULL,'5I5Bz7STXgcn5X2NYrDl2I','6YVMFz59CuY7ngCxTxjpxE',31,1),('40bVWtmpb7MSSNM8eblDew','박하사탕２',230,NULL,'https://open.spotify.com/track/40bVWtmpb7MSSNM8eblDew',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',24,14),('40EXFgNMOIQRQOwJZ8mJkC','Who Told You (feat. Drake)',208,NULL,'https://open.spotify.com/track/40EXFgNMOIQRQOwJZ8mJkC',NULL,'5AQdhXDCLTUZNHYH1hMIdF','3TVXtAsR1Inumwj472S9r4',68,1),('40iJIUlhi6renaREYGeIDS','Fair Trade (with Travis Scott)',291,NULL,'https://open.spotify.com/track/40iJIUlhi6renaREYGeIDS',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',82,6),('40MXr7BMh3ShPf2b9giSRt','Moth To A Flame (with The Weeknd, Moojo) - Moojo Remix',436,NULL,'https://open.spotify.com/track/40MXr7BMh3ShPf2b9giSRt',NULL,'17cYF29ZBcDYoRkWUzFWfQ','1Xyo4u8uXC1ZmMpatF05PJ',57,1),('40U8d12pC5UHqmHwXjHjjl','Repeat After Me (Interlude)',195,NULL,'https://open.spotify.com/track/40U8d12pC5UHqmHwXjHjjl',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',64,12),('410TZrK18uRjtsTunG14cl','Middle of the Ocean',356,NULL,'https://open.spotify.com/track/410TZrK18uRjtsTunG14cl',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',65,12),('41a7dZcq30Ss5kPMayWRV0','That’s How You Feel',157,NULL,'https://open.spotify.com/track/41a7dZcq30Ss5kPMayWRV0',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',67,7),('41BXE3fjq0mYCgu0y7evlB','You & Me',277,NULL,'https://open.spotify.com/track/41BXE3fjq0mYCgu0y7evlB',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',9,12),('41J8SYwb9YHzPjpbXouIkS','No Biggie',181,NULL,'https://open.spotify.com/track/41J8SYwb9YHzPjpbXouIkS',NULL,'0e9GAAJT7lX5C6RTZsCCDR','2KC9Qb60EaY0kW4eH68vr3',9,1),('41Kf9FQ2Dxj81cjQpEWDUJ','Spicy - Nitepunk Remix',190,NULL,'https://open.spotify.com/track/41Kf9FQ2Dxj81cjQpEWDUJ',NULL,'55N0UTP5992idhnEYOKYd9','6YVMFz59CuY7ngCxTxjpxE',44,1),('41xk0ywScyKRdj2MLdWEXL','LOVE is',207,NULL,'https://open.spotify.com/track/41xk0ywScyKRdj2MLdWEXL',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',14,7),('42c2SOf86tKhsFfynzGNyT','살아있는 건...',246,NULL,'https://open.spotify.com/track/42c2SOf86tKhsFfynzGNyT',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',9,12),('42m3eP1JJhtzffal9B136J','7am On Bridle Path',239,NULL,'https://open.spotify.com/track/42m3eP1JJhtzffal9B136J',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',64,14),('431r2Qg4I2qFIKdSFCJN4s','Low Life - Live',107,NULL,'https://open.spotify.com/track/431r2Qg4I2qFIKdSFCJN4s',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,14),('433P7tDcIAi6NLnf4Sh6tI','Still Here',189,NULL,'https://open.spotify.com/track/433P7tDcIAi6NLnf4Sh6tI',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',68,10),('433ykR1mhzAJgyt5qVKShn','바보',282,NULL,'https://open.spotify.com/track/433ykR1mhzAJgyt5qVKShn',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',33,2),('43cJX4OV9uhfMDewuErelv','오늘은',248,NULL,'https://open.spotify.com/track/43cJX4OV9uhfMDewuErelv',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',20,1),('43iKgGbmfqPLh3mxUlospI','Sooner Than Later',262,NULL,'https://open.spotify.com/track/43iKgGbmfqPLh3mxUlospI',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',60,13),('44I7sqKYCAa7bQdVywkShO','Hurricane',238,NULL,'https://open.spotify.com/track/44I7sqKYCAa7bQdVywkShO',NULL,'4YV1qBdn6O6thyg18kBo0N','1Xyo4u8uXC1ZmMpatF05PJ',62,1),('44mXea90sdkzwv2qqDuOKX','피아니스트',253,NULL,'https://open.spotify.com/track/44mXea90sdkzwv2qqDuOKX',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',14,6),('44qlcokPO2RjD8791ohJFR','Bored! - NINGNING Solo',171,NULL,'https://open.spotify.com/track/44qlcokPO2RjD8791ohJFR',NULL,'4vLGHlTnlIIxMSfefCY0cU','6YVMFz59CuY7ngCxTxjpxE',65,3),('44uutxt81rrT9V9vsK32FN','Wick Man - Instrumental',181,NULL,'https://open.spotify.com/track/44uutxt81rrT9V9vsK32FN',NULL,'3CHCm9n05a3tG4cQJ4rJwq','3TVXtAsR1Inumwj472S9r4',28,4),('44Vzd5QhPFN0ydfw9Hwou2','Moth To A Flame (with The Weeknd, Chris Lake) - Chris Lake Remix',278,NULL,'https://open.spotify.com/track/44Vzd5QhPFN0ydfw9Hwou2',NULL,'0sye9Q82C9Q4tTJN8b0aFq','1Xyo4u8uXC1ZmMpatF05PJ',30,2),('4523QJggj8ZHat1ABu747i','Lost',334,NULL,'https://open.spotify.com/track/4523QJggj8ZHat1ABu747i',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',27,5),('458HH88Ju8bzMoMts1961m','Unforgettable',213,NULL,'https://open.spotify.com/track/458HH88Ju8bzMoMts1961m',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',30,9),('45pUWUeEWGoSdH6UF162G8','Broke Boys',225,NULL,'https://open.spotify.com/track/45pUWUeEWGoSdH6UF162G8',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',68,11),('45ypYpAdgoneWcBT0Wba3p','Hurricane - Live',127,NULL,'https://open.spotify.com/track/45ypYpAdgoneWcBT0Wba3p',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,8),('466cKvZn1j45IpxDdYZqdA','Toosie Slide',247,NULL,'https://open.spotify.com/track/466cKvZn1j45IpxDdYZqdA',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',72,5),('46CYSG1HW7aAEj2okqQDGz','링이',224,NULL,'https://open.spotify.com/track/46CYSG1HW7aAEj2okqQDGz',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',7,8),('46kFAYvmV6lVbT5xN5qlCH','Gone',99,NULL,'https://open.spotify.com/track/46kFAYvmV6lVbT5xN5qlCH',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',50,9),('46s57QULU02Voy0Kup6UEb','Major Distribution',170,NULL,'https://open.spotify.com/track/46s57QULU02Voy0Kup6UEb',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',69,2),('47A15d7bYtiyVhEUutgrdq','Not Shy (English Ver.)',177,NULL,'https://open.spotify.com/track/47A15d7bYtiyVhEUutgrdq',NULL,'6zWajG8oLkshBrkjIMPbjQ','2KC9Qb60EaY0kW4eH68vr3',3,1),('47SC5wI2ZEd2DwQuJNzCHL','너를 보내고 - Live',273,NULL,'https://open.spotify.com/track/47SC5wI2ZEd2DwQuJNzCHL',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',16,6),('47Slg6LuqLaX0VodpSCvPt','Just the Way You Are',220,NULL,'https://open.spotify.com/track/47Slg6LuqLaX0VodpSCvPt',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',83,2),('47vfGRaXEGzcM2vI7JC2OO','Can\'t Feel My Face - Live',183,NULL,'https://open.spotify.com/track/47vfGRaXEGzcM2vI7JC2OO',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',46,6),('4823f9W4xmR3n1BebPyNaR','Supernatural (Instrumental)',191,NULL,'https://open.spotify.com/track/4823f9W4xmR3n1BebPyNaR',NULL,'1FVw30SoC91lq1UZ6N9rwN','6HvZYsbFfjnjFrWF950C9d',49,3),('48M09QX0lRHWaRALakeFhK','Treasure - Audien Dub',320,NULL,'https://open.spotify.com/track/48M09QX0lRHWaRALakeFhK',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',27,4),('48RN2EOOyG2Gs5Pyla7ZJj','Worst Behavior',270,NULL,'https://open.spotify.com/track/48RN2EOOyG2Gs5Pyla7ZJj',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',58,6),('48W5Lr7Mmgr2aF0SJ4MfzX','가을편지',242,NULL,'https://open.spotify.com/track/48W5Lr7Mmgr2aF0SJ4MfzX',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',12,10),('49PBvg9QELHDx3bMHRTA2s','Red Button - Instrumental',160,NULL,'https://open.spotify.com/track/49PBvg9QELHDx3bMHRTA2s',NULL,'3CHCm9n05a3tG4cQJ4rJwq','3TVXtAsR1Inumwj472S9r4',39,1),('4agiUIvyUVUREo85T80SWe','찾을 수 없는 길',272,NULL,'https://open.spotify.com/track/4agiUIvyUVUREo85T80SWe',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',10,7),('4alHkxxwAhvoGg3dJCATKV','My Side',294,NULL,'https://open.spotify.com/track/4alHkxxwAhvoGg3dJCATKV',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',52,10),('4AtXMDQiztBcGVcLTBrcCQ','LOYAL (feat. Drake and Bad Bunny) - Remix',281,NULL,'https://open.spotify.com/track/4AtXMDQiztBcGVcLTBrcCQ',NULL,'73B0Ru9CdUgVoi5AGmLe99','3TVXtAsR1Inumwj472S9r4',52,1),('4AZ4Y1QAOLBwnWaX9cguoF','Mine',193,NULL,'https://open.spotify.com/track/4AZ4Y1QAOLBwnWaX9cguoF',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',51,4),('4BDgGQXx7jO2JgC7bpFsIv','Shut It Down',419,NULL,'https://open.spotify.com/track/4BDgGQXx7jO2JgC7bpFsIv',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',66,8),('4bF4MxTGnNj8dTW0LZmAx5','BBL Love - Interlude',161,NULL,'https://open.spotify.com/track/4bF4MxTGnNj8dTW0LZmAx5',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',48,18),('4BGZF4oLbTL0pWm7C18pbv','Scared To Live',191,NULL,'https://open.spotify.com/track/4BGZF4oLbTL0pWm7C18pbv',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',65,4),('4bHdoeTBtVCSgu87hTP17c','Inside Love',257,NULL,'https://open.spotify.com/track/4bHdoeTBtVCSgu87hTP17c',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',8,10),('4bhdXu37gtEm2q68PBIHtY','Treasure - Audien Remix',289,NULL,'https://open.spotify.com/track/4bhdXu37gtEm2q68PBIHtY',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',28,3),('4BhGTc3Cgay2U1QcTS7vQe','Fire & Desire',238,NULL,'https://open.spotify.com/track/4BhGTc3Cgay2U1QcTS7vQe',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',76,18),('4bPsiRqWPFPgLiPQR7jNo4','A Lesser Man',298,NULL,'https://open.spotify.com/track/4bPsiRqWPFPgLiPQR7jNo4',NULL,'5aX2plzPm0m6zk4ZFuqbuI','1Xyo4u8uXC1ZmMpatF05PJ',56,1),('4c2xt1trwYZpMqPWY35Xi9','Jaded',262,NULL,'https://open.spotify.com/track/4c2xt1trwYZpMqPWY35Xi9',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',74,3),('4cm7Ap6IWH6m8JyB9IXT3x','Best Friends',163,NULL,'https://open.spotify.com/track/4cm7Ap6IWH6m8JyB9IXT3x',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',48,9),('4coENUbKuiuFb0C38uqFTi','Lonely Star',349,NULL,'https://open.spotify.com/track/4coENUbKuiuFb0C38uqFTi',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',53,1),('4cRBqWBjuccCowYVHFlXK6','Redemption',333,NULL,'https://open.spotify.com/track/4cRBqWBjuccCowYVHFlXK6',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',70,7),('4CrzO8fDPh3lNmhaiE4olL','Like a Star (feat. Choi Arom)',276,NULL,'https://open.spotify.com/track/4CrzO8fDPh3lNmhaiE4olL',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',11,9),('4czcw3NVLY0of5hTD7OufN','Days in The East',353,NULL,'https://open.spotify.com/track/4czcw3NVLY0of5hTD7OufN',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',60,5),('4D1ixkJ5oQwLangrMs8TyB','미워하자',240,NULL,'https://open.spotify.com/track/4D1ixkJ5oQwLangrMs8TyB',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',24,7),('4DAA64qpKvOZHlGC4VGCF2','좋은사람',236,NULL,'https://open.spotify.com/track/4DAA64qpKvOZHlGC4VGCF2',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',36,2),('4dfyVGfkeCsByVAmkRr65q','Breath - Instrumental',283,NULL,'https://open.spotify.com/track/4dfyVGfkeCsByVAmkRr65q',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',19,12),('4dQKl7ixo4Aw395DDW1Rmy','하늘은 왜 내게',266,NULL,'https://open.spotify.com/track/4dQKl7ixo4Aw395DDW1Rmy',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',13,7),('4dXnS1YXBkn4oAIxRLPJcK','Rolling Stone',230,NULL,'https://open.spotify.com/track/4dXnS1YXBkn4oAIxRLPJcK',NULL,'6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',57,8),('4dyB6o3A5ymFCNhz0yBW8y','無',217,NULL,'https://open.spotify.com/track/4dyB6o3A5ymFCNhz0yBW8y',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',2,7),('4e0uZkMYa8e8HJ5TEUN417','What Would Pluto Do',182,NULL,'https://open.spotify.com/track/4e0uZkMYa8e8HJ5TEUN417',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',51,15),('4ecccIn5ZRgSeES5D2wXs0','Now & Forever',274,NULL,'https://open.spotify.com/track/4ecccIn5ZRgSeES5D2wXs0',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',14,10),('4EDijkJdHBZZ0GwJ12iTAj','Stargirl Interlude',111,NULL,'https://open.spotify.com/track/4EDijkJdHBZZ0GwJ12iTAj',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',76,8),('4EEhhbFjJzgFuiQqJgvbR2','Nameless Bird',234,NULL,'https://open.spotify.com/track/4EEhhbFjJzgFuiQqJgvbR2',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',23,6),('4eKvCOwmsa5HRtpF34BFp3','Gift',208,NULL,'https://open.spotify.com/track/4eKvCOwmsa5HRtpF34BFp3',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',30,2),('4eQO9RHTjYT1O9DTuZLj9v','Blinding Lights',200,NULL,'https://open.spotify.com/track/4eQO9RHTjYT1O9DTuZLj9v',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',51,9),('4ER9305DBAmJqj2P96TfBr','Live For',222,NULL,'https://open.spotify.com/track/4ER9305DBAmJqj2P96TfBr',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',44,6),('4ESFBj73tp3JbZiALSjQZr','내가 사랑한 사람',237,NULL,'https://open.spotify.com/track/4ESFBj73tp3JbZiALSjQZr',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',11,6),('4eSGSqP2TZvvX0kadZZttM','Doing It Wrong',265,NULL,'https://open.spotify.com/track/4eSGSqP2TZvvX0kadZZttM',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',74,13),('4eYZ3PHp1kTXLHNonG66hD','It Burns',223,NULL,'https://open.spotify.com/track/4eYZ3PHp1kTXLHNonG66hD',NULL,'75fZ4eJHsRFNpn4VDoQbKb','1rpgxJZxZMLnFNc1Jmyov5',4,5),('4F7A0DXBrmUAkp32uenhZt','Party Monster',249,NULL,'https://open.spotify.com/track/4F7A0DXBrmUAkp32uenhZt',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',80,2),('4FDSPGncHRpr6yB8DD4CtI','Let’s Call It Off (feat. Peter Bjorn and John)',234,NULL,'https://open.spotify.com/track/4FDSPGncHRpr6yB8DD4CtI',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',59,4),('4fen6YZEyvpi9X75JXarFL','Stay Alive',346,NULL,'https://open.spotify.com/track/4fen6YZEyvpi9X75JXarFL',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,7),('4FIgHqXd4KkOwxrGeLDYM2','Texts Go Green',308,NULL,'https://open.spotify.com/track/4FIgHqXd4KkOwxrGeLDYM2',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',66,3),('4FKKZh8VPGrjFTpnBtVPQ7','End And End - Instrumental',241,NULL,'https://open.spotify.com/track/4FKKZh8VPGrjFTpnBtVPQ7',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',6,10),('4Flfb4fGscN9kXPOduQLrv','Treacherous Twins',180,NULL,'https://open.spotify.com/track/4Flfb4fGscN9kXPOduQLrv',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',64,8),('4frLb7nWtsz2ymBE6k2GRP','Earned It (Fifty Shades Of Grey)',277,NULL,'https://open.spotify.com/track/4frLb7nWtsz2ymBE6k2GRP',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',76,9),('4FRW5Nza1Ym91BGV4nFWXI','Lemon Pepper Freestyle (feat. Rick Ross)',383,NULL,'https://open.spotify.com/track/4FRW5Nza1Ym91BGV4nFWXI',NULL,'5LuoozUhs2pl3glZeAJl89','3TVXtAsR1Inumwj472S9r4',68,3),('4FuSnjXKARcUOwiPnEnh1p','The Knowing',342,NULL,'https://open.spotify.com/track/4FuSnjXKARcUOwiPnEnh1p',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',52,9),('4fZf8HmsLThUcqxSj0m989','비싸 보여',232,NULL,'https://open.spotify.com/track/4fZf8HmsLThUcqxSj0m989',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',2,4),('4ghGrdxwqLA6ZoCiu0u4IR','Don\'t Know What To Do',201,NULL,'https://open.spotify.com/track/4ghGrdxwqLA6ZoCiu0u4IR',NULL,'3qw2vm3uqKT3EIg95wbg83','41MozSoPIsD1dJM0CLPjZF',68,2),('4GjPsuW89QcC2RDFX3upTV','좋은 사람 (Instrumental)',235,NULL,'https://open.spotify.com/track/4GjPsuW89QcC2RDFX3upTV',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',6,16),('4gowy3WT6D1yhMLgRBlf9C','Change Locations',220,NULL,'https://open.spotify.com/track/4gowy3WT6D1yhMLgRBlf9C',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',61,8),('4gpvij8x9fk6khmUeQnLKc','공상과학 개꿈',250,NULL,'https://open.spotify.com/track/4gpvij8x9fk6khmUeQnLKc',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',2,8),('4gQBXN2GBRpemMuxg5y3h9','Slime You Out (feat. SZA)',310,NULL,'https://open.spotify.com/track/4gQBXN2GBRpemMuxg5y3h9',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',53,9),('4GqhG9rDuRUoNyDSMJ0Brq','SPIDER-MAN SUPERMAN',203,NULL,'https://open.spotify.com/track/4GqhG9rDuRUoNyDSMJ0Brq',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',74,5),('4h4xDpXA8Os4VG39uDxzSj','Goodbye Love',236,NULL,'https://open.spotify.com/track/4h4xDpXA8Os4VG39uDxzSj',NULL,'2KnWel482zu05nLvSqNEzI','57htMBtzpppc1yoXgjbslj',23,6),('4h7lqCKAQXpJHzxDmiMOxQ','정글의 법칙',220,NULL,'https://open.spotify.com/track/4h7lqCKAQXpJHzxDmiMOxQ',NULL,'2XHxh8kzvY06Nf79fhyeQ3','1rpgxJZxZMLnFNc1Jmyov5',5,1),('4h90qkbnW1Qq6pBhoPvwko','Sidewalks',231,NULL,'https://open.spotify.com/track/4h90qkbnW1Qq6pBhoPvwko',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',74,9),('4HG1YiGBseVKzjyKcmAJen','Summer Games',247,NULL,'https://open.spotify.com/track/4HG1YiGBseVKzjyKcmAJen',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',68,2),('4HxVweMysEnuYxy3gkFtKk','Really',197,NULL,'https://open.spotify.com/track/4HxVweMysEnuYxy3gkFtKk',NULL,'6yetqbA9vli7RLoUWYZLsq','41MozSoPIsD1dJM0CLPjZF',62,3),('4i3GraNMzBKze1WsVl38DS','Bria\'s Interlude (feat. Omarion)',139,NULL,'https://open.spotify.com/track/4i3GraNMzBKze1WsVl38DS',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',68,14),('4iEeJKOE5zjsRbWBGkj9lS','Break Ice',176,NULL,'https://open.spotify.com/track/4iEeJKOE5zjsRbWBGkj9lS',NULL,'3OzSEoUPp5sNGtzXftotKm','2KC9Qb60EaY0kW4eH68vr3',36,1),('4ioOuBakOUKAdSpm9E46kP','SOLO (Live)',182,NULL,'https://open.spotify.com/track/4ioOuBakOUKAdSpm9E46kP',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',33,6),('4iSiRU5nGU7EP5TbkEEcsj','Licorice',158,NULL,'https://open.spotify.com/track/4iSiRU5nGU7EP5TbkEEcsj',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',51,5),('4iYX8fLOdOWd5lGGr7U4gc','Blah Blah Blah（Instrumental）',186,NULL,'https://open.spotify.com/track/4iYX8fLOdOWd5lGGr7U4gc',NULL,'0SbnkLLiTqVmoPmhY80s7S','2KC9Qb60EaY0kW4eH68vr3',0,3),('4J7aZtcc2TrCJkXY1WWebG','Blossom (리아)',194,NULL,'https://open.spotify.com/track/4J7aZtcc2TrCJkXY1WWebG',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',13,6),('4J9R9HD1fW4PYFzVnj0CMA','하루살이',278,NULL,'https://open.spotify.com/track/4J9R9HD1fW4PYFzVnj0CMA',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',3,2),('4jBfUB4kQJCWOrjGLQqhO0','The Morning',314,NULL,'https://open.spotify.com/track/4jBfUB4kQJCWOrjGLQqhO0',NULL,'7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',78,4),('4jDyIdXDXe9zM6QbeoXRWp','Better Things - Sped Up Version',180,NULL,'https://open.spotify.com/track/4jDyIdXDXe9zM6QbeoXRWp',NULL,'0jXtQE6F6FYFLPx0S3Gp1D','6YVMFz59CuY7ngCxTxjpxE',34,1),('4JeD0FGslDsMeeahEGZa2L','DEEPER',172,NULL,'https://open.spotify.com/track/4JeD0FGslDsMeeahEGZa2L',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',74,6),('4JjJ1KNRrzqstSY0uDuys3','JUMP',164,NULL,'https://open.spotify.com/track/4JjJ1KNRrzqstSY0uDuys3',NULL,'2L5mYNO7vicA2geMVVY7QN','41MozSoPIsD1dJM0CLPjZF',64,1),('4JNdwEfqwFRiAeEISC8RU8','Die For You (with Ariana Grande) - Remix',232,NULL,'https://open.spotify.com/track/4JNdwEfqwFRiAeEISC8RU8',NULL,'0YF085Qdh4HgdhZ8zjWkpo','1Xyo4u8uXC1ZmMpatF05PJ',71,1),('4JoV6ys443Oxx4SUxlA8yt','Winter Ahead (with PARK HYO SHIN) (Instrumental)',234,NULL,'https://open.spotify.com/track/4JoV6ys443Oxx4SUxlA8yt',NULL,'4hcghI7Io7BFdHHsiaAylg','57htMBtzpppc1yoXgjbslj',53,2),('4jQQMqEehKjPYL6vSXXrwj','NOBODY LIKE YOU',197,NULL,'https://open.spotify.com/track/4jQQMqEehKjPYL6vSXXrwj',NULL,'6RP5wCF7u2WDFiuyQ0loNS','2KC9Qb60EaY0kW4eH68vr3',13,4),('4jzrYUhlzXROpV5M944Yvu','ICU (쉬어가도 돼)',221,NULL,'https://open.spotify.com/track/4jzrYUhlzXROpV5M944Yvu',NULL,'2rwRvLdjGzjSYl9AS3UbvH','6YVMFz59CuY7ngCxTxjpxE',33,5),('4K09vJ27xCOreumtSuU6Ao','Silk Sonic Intro',63,NULL,'https://open.spotify.com/track/4K09vJ27xCOreumtSuU6Ao',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',63,1),('4k2iYdpCZYH3eQX2bVKOku','DDU-DU DDU-DU (Live)',210,NULL,'https://open.spotify.com/track/4k2iYdpCZYH3eQX2bVKOku',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',45,1),('4K3BhUMfBHZuUfeC3kbhrQ','Connect',296,NULL,'https://open.spotify.com/track/4K3BhUMfBHZuUfeC3kbhrQ',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',54,9),('4k47x4UkxG215nFLMFna8A','False Alarm',220,NULL,'https://open.spotify.com/track/4k47x4UkxG215nFLMFna8A',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',48,3),('4kdfjhj9xNkYU0R8xlDy8k','6 Man',167,NULL,'https://open.spotify.com/track/4kdfjhj9xNkYU0R8xlDy8k',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',62,12),('4kiCS23srHAIEy8YUTLzjQ','박하사탕',290,NULL,'https://open.spotify.com/track/4kiCS23srHAIEy8YUTLzjQ',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',40,1),('4kJn7armCJDav48yCu3yKh','MELTDOWN (feat. Drake) - Instrumental',247,NULL,'https://open.spotify.com/track/4kJn7armCJDav48yCu3yKh',NULL,'2lzV5TIBiLED8eCjwsGBIv','3TVXtAsR1Inumwj472S9r4',37,1),('4KMXwUE5yhDPg8q814awJ4','The Castle Of Zoltar',233,NULL,'https://open.spotify.com/track/4KMXwUE5yhDPg8q814awJ4',NULL,'3wtbBSjOhKOw7UdngHEDiO','57htMBtzpppc1yoXgjbslj',14,2),('4KSlrpUUdgHnPQAoMZjcfS','위안',242,NULL,'https://open.spotify.com/track/4KSlrpUUdgHnPQAoMZjcfS',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',3,16),('4ksuI04WMvUnJbHQjgs3L5','Talk Up (feat. Jay-Z)',223,NULL,'https://open.spotify.com/track/4ksuI04WMvUnJbHQjgs3L5',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',59,11),('4Kz4RdRCceaA9VgTqBhBfa','The Motto',181,NULL,'https://open.spotify.com/track/4Kz4RdRCceaA9VgTqBhBfa',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',77,19),('4lhbi81RlXmH7TZxC3uw5E','DALLA DALLA (English Ver.)',199,NULL,'https://open.spotify.com/track/4lhbi81RlXmH7TZxC3uw5E',NULL,'6zWajG8oLkshBrkjIMPbjQ','2KC9Qb60EaY0kW4eH68vr3',2,4),('4LjkHlY5qDz0hhFJJH5M7a','Our First Time',243,NULL,'https://open.spotify.com/track/4LjkHlY5qDz0hhFJJH5M7a',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',56,3),('4LKx0dlvzsmntdhMCTtV97','Too Late',239,NULL,'https://open.spotify.com/track/4LKx0dlvzsmntdhMCTtV97',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',50,2),('4lLtanYk6tkMvooU0tWzG8','Grenade',222,NULL,'https://open.spotify.com/track/4lLtanYk6tkMvooU0tWzG8',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',82,1),('4m1ljdrm6B5j4mz61vw2rN','My Love - Original Sounds Track',222,NULL,'https://open.spotify.com/track/4m1ljdrm6B5j4mz61vw2rN',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',5,11),('4MhgDz4lSj2HtlUcpe3yrd','Attention (250 Remix) (Instrumental)',181,NULL,'https://open.spotify.com/track/4MhgDz4lSj2HtlUcpe3yrd',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',51,9),('4MM8LAr36FoyGg5Gvb5jHr','생일',291,NULL,'https://open.spotify.com/track/4MM8LAr36FoyGg5Gvb5jHr',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',11,2),('4Mnnd0fBRucoxGhtG7MccI','The Birds Pt. 2',350,NULL,'https://open.spotify.com/track/4Mnnd0fBRucoxGhtG7MccI',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',59,6),('4mOWnjz30frv1pKMM6DNfv','Bonde do Brunão',57,NULL,'https://open.spotify.com/track/4mOWnjz30frv1pKMM6DNfv',NULL,'49avguRc9qHbWv5Gjmj4nQ','0du5cEVh5yTK9QJze8zA0C',75,1),('4Msr8L0gHGDsLSBlk7pSPU','Opening Night',96,NULL,'https://open.spotify.com/track/4Msr8L0gHGDsLSBlk7pSPU',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',70,8),('4mtl4zf8EsbFElYAybIcrK','사랑한걸로 됐어요',245,NULL,'https://open.spotify.com/track/4mtl4zf8EsbFElYAybIcrK',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',12,10),('4MTzEtZG2iinE0ulL3pyup','Pretty Savage',202,NULL,'https://open.spotify.com/track/4MTzEtZG2iinE0ulL3pyup',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',44,10),('4mU5iXHeLgbR94siF7p1sY','Six Feet Under',237,NULL,'https://open.spotify.com/track/4mU5iXHeLgbR94siF7p1sY',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',69,10),('4n1bdaKwynQndm47x5HqWX','Blue Tint',162,NULL,'https://open.spotify.com/track/4n1bdaKwynQndm47x5HqWX',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',62,8),('4n4BflhWjCHIxrI4v7Xt9s','How Bout Now',235,NULL,'https://open.spotify.com/track/4n4BflhWjCHIxrI4v7Xt9s',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',67,3),('4nH3FZGy1rISIuGXUwsDi8','YOU MAKE ME',183,NULL,'https://open.spotify.com/track/4nH3FZGy1rISIuGXUwsDi8',NULL,'6RP5wCF7u2WDFiuyQ0loNS','2KC9Qb60EaY0kW4eH68vr3',7,5),('4NVNapccSX7E5JLiW0uQEy','Pound Cake / Paris Morton Music 2',432,NULL,'https://open.spotify.com/track/4NVNapccSX7E5JLiW0uQEy',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',64,13),('4oBpXs4KppprE6ql0Dmr2O','Prologue',194,NULL,'https://open.spotify.com/track/4oBpXs4KppprE6ql0Dmr2O',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',53,8),('4oeaIftdpT3JuZLcCkKmVE','False Alarm',220,NULL,'https://open.spotify.com/track/4oeaIftdpT3JuZLcCkKmVE',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',66,3),('4OENnoidV0h8gJV6bhrw7r','Only You Freestyle',248,NULL,'https://open.spotify.com/track/4OENnoidV0h8gJV6bhrw7r',NULL,'5L6DR2YmRLRZ4CmR91l3Z4','3TVXtAsR1Inumwj472S9r4',59,1),('4oN4odRiXgTMnaAjz7kinV','One Of The Girls - A Cappella',249,NULL,'https://open.spotify.com/track/4oN4odRiXgTMnaAjz7kinV',NULL,'4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',51,5),('4PA16FAl8LPmFmOhARawdV','Weston Road Flows',253,NULL,'https://open.spotify.com/track/4PA16FAl8LPmFmOhARawdV',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',69,6),('4pHQ9RYFhn3W0ha5KEuMnj','Adaptation',283,NULL,'https://open.spotify.com/track/4pHQ9RYFhn3W0ha5KEuMnj',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',56,3),('4PhsKqMdgMEUSstTDAmMpg','Often',249,NULL,'https://open.spotify.com/track/4PhsKqMdgMEUSstTDAmMpg',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',82,4),('4Poz3qJ8a4NJWDGWDS3a94','Grenade - John de Sohn Mix',378,NULL,'https://open.spotify.com/track/4Poz3qJ8a4NJWDGWDS3a94',NULL,'1JirxaiYwz8hAxAk38rkeH','0du5cEVh5yTK9QJze8zA0C',29,2),('4ppTAJUbNXELZcoUaL90wo','Try Me',221,NULL,'https://open.spotify.com/track/4ppTAJUbNXELZcoUaL90wo',NULL,'4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',72,2),('4PqZpidNfcpIiWVPW8L8nQ','In the morning -Japanese ver.-',172,NULL,'https://open.spotify.com/track/4PqZpidNfcpIiWVPW8L8nQ',NULL,'59vClLXHQp6vY4IfO0SDmm','2KC9Qb60EaY0kW4eH68vr3',1,5),('4pryE6cN2gFL1FVF5fYINl','Leave The Door Open',242,NULL,'https://open.spotify.com/track/4pryE6cN2gFL1FVF5fYINl',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',73,2),('4pUUhsc8fmZqnsPaOSU5CP','Fireworks',313,NULL,'https://open.spotify.com/track/4pUUhsc8fmZqnsPaOSU5CP',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',61,1),('4PxQyXDCoEM56YngnJujgm','아직도 널',192,NULL,'https://open.spotify.com/track/4PxQyXDCoEM56YngnJujgm',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',7,4),('4Q5XBV4sCvggtvFuVORCkF','After Love',230,NULL,'https://open.spotify.com/track/4Q5XBV4sCvggtvFuVORCkF',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',32,3),('4q75XguyPrsduy70hcBVFu','Coming Down',295,NULL,'https://open.spotify.com/track/4q75XguyPrsduy70hcBVFu',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',58,7),('4q9JTfPeglRMrfbmN6lAB8','The Day (From \"Mr. Sunshine\", Pt. 1) [Original Television Soundtrack]',292,NULL,'https://open.spotify.com/track/4q9JTfPeglRMrfbmN6lAB8',NULL,'6YWeTsiWmZlWj6mXtYFvxA','57htMBtzpppc1yoXgjbslj',41,1),('4QOlJe0YH6R5mVUtwelGov','마지막 시간',398,NULL,'https://open.spotify.com/track/4QOlJe0YH6R5mVUtwelGov',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',2,11),('4QOZCYcZYf35zWewgZrlOE','zoozuhl zoozuhl',57,NULL,'https://open.spotify.com/track/4QOZCYcZYf35zWewgZrlOE',NULL,'2wA8OXIv1JXX9kTY2ddfR4','1rpgxJZxZMLnFNc1Jmyov5',3,4),('4QYEtbfsqusrXN5A49LG53','Six Feet Under',237,NULL,'https://open.spotify.com/track/4QYEtbfsqusrXN5A49LG53',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',48,10),('4RI9eX7jNcdaQOJifn7t6z','Pound Cake / Paris Morton Music 2',433,NULL,'https://open.spotify.com/track/4RI9eX7jNcdaQOJifn7t6z',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',65,13),('4rmVZajAF7PkrCagGPHbqa','Sticky',243,NULL,'https://open.spotify.com/track/4rmVZajAF7PkrCagGPHbqa',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',73,7),('4rnSu96y9IYtpJzfPt73bl','WANNABE -Japanese ver.-',191,NULL,'https://open.spotify.com/track/4rnSu96y9IYtpJzfPt73bl',NULL,'59vClLXHQp6vY4IfO0SDmm','2KC9Qb60EaY0kW4eH68vr3',2,3),('4Rrj1QxDqsj28gv9SiHQRA','Out of Time - KAYTRANADA Remix',275,NULL,'https://open.spotify.com/track/4Rrj1QxDqsj28gv9SiHQRA',NULL,'6LuY3APmuxui8BM2oibkrZ','1Xyo4u8uXC1ZmMpatF05PJ',45,1),('4s7QLoImIwmPi9L6dq1nVW','TSU',308,NULL,'https://open.spotify.com/track/4s7QLoImIwmPi9L6dq1nVW',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',76,8),('4S8XuHosOw3qXFtJyOfBdB','Rebellion - Instrumental',222,NULL,'https://open.spotify.com/track/4S8XuHosOw3qXFtJyOfBdB',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',9,11),('4SAdGgCEZ5S8wtcDcGxjDN','Freaky',175,NULL,'https://open.spotify.com/track/4SAdGgCEZ5S8wtcDcGxjDN',NULL,'4iL0sqHuipLrqy4y8HRYsZ','2KC9Qb60EaY0kW4eH68vr3',9,3),('4SaGaLbcshvQ4admgCkYdP','Leave The Door Open',242,NULL,'https://open.spotify.com/track/4SaGaLbcshvQ4admgCkYdP',NULL,'4rRB9bAIwawVcrdLXuq9Qu','0du5cEVh5yTK9QJze8zA0C',46,2),('4SUwJA3eUVNHExxMPEUhQe','Ratchet Happy Birthday',207,NULL,'https://open.spotify.com/track/4SUwJA3eUVNHExxMPEUhQe',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',54,6),('4sWQbsLLH2NEbO79DSZCL9','Big Sleep (feat. Giorgio Moroder)',225,NULL,'https://open.spotify.com/track/4sWQbsLLH2NEbO79DSZCL9',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',67,16),('4T5AbXz68PpZyKewHO5Tqw','Melody',187,NULL,'https://open.spotify.com/track/4T5AbXz68PpZyKewHO5Tqw',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',53,10),('4TA5KWeqdDmgdVPHE7Yj3B','Final Lullaby - Bonus Track',185,NULL,'https://open.spotify.com/track/4TA5KWeqdDmgdVPHE7Yj3B',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',53,17),('4ToOfelAD6oEqbeHyTTKMS','Die Trying',175,NULL,'https://open.spotify.com/track/4ToOfelAD6oEqbeHyTTKMS',NULL,'2Ov7bn3HyDgvAxtYPLosUR','6YVMFz59CuY7ngCxTxjpxE',52,1),('4typI7T0Lsum7TDGqPFoow','Happy Christmas',230,NULL,'https://open.spotify.com/track/4typI7T0Lsum7TDGqPFoow',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',16,15),('4u22BVdDV2pXxpaqfKoBaU','Sugar-holic',183,NULL,'https://open.spotify.com/track/4u22BVdDV2pXxpaqfKoBaU',NULL,'1dTqdCHDqUk9hbSsQOIxl0','2KC9Qb60EaY0kW4eH68vr3',3,1),('4u43I0LP2Xf85OAS85eG0R','CN TOWER',241,NULL,'https://open.spotify.com/track/4u43I0LP2Xf85OAS85eG0R',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',76,1),('4u9cOL7R5OjAmlWkeEFXzf','Flowers',190,NULL,'https://open.spotify.com/track/4u9cOL7R5OjAmlWkeEFXzf',NULL,'3OaW4df1SA62k0arNpn6bK','6YVMFz59CuY7ngCxTxjpxE',56,5),('4uByZRg9FnjUdzFKqvppfW','Daydream',288,NULL,'https://open.spotify.com/track/4uByZRg9FnjUdzFKqvppfW',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',18,6),('4UEcgapaOf3Y1azxXPDjz1','WHISTLE (Live)',218,NULL,'https://open.spotify.com/track/4UEcgapaOf3Y1azxXPDjz1',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',33,4),('4urC5Cfmgpvzm73LYHIHUV','Don\'t Give A What',196,NULL,'https://open.spotify.com/track/4urC5Cfmgpvzm73LYHIHUV',NULL,'7GiJLfFllsMNTwMZlFxzIK','2KC9Qb60EaY0kW4eH68vr3',12,2),('4utrFHD3PZDq5GI9C5XcTz','HAPPY TOGETHER (Inst.)',249,NULL,'https://open.spotify.com/track/4utrFHD3PZDq5GI9C5XcTz',NULL,'6FbwZcLd2Wqx0vDR2JfvQe','57htMBtzpppc1yoXgjbslj',3,2),('4uUVeOIWjJSVbYT2XEeX3h','Bratty (나쁜 애)',162,NULL,'https://open.spotify.com/track/4uUVeOIWjJSVbYT2XEeX3h',NULL,'5tXD77S3yCWTToU5eMLnlo','2KC9Qb60EaY0kW4eH68vr3',10,4),('4UUxU54xVGD8Dri8hrvEJp','WANT IT? (Imad Royal Remix)',207,NULL,'https://open.spotify.com/track/4UUxU54xVGD8Dri8hrvEJp',NULL,'2tj99zihwANHtqmEC2QpCn','2KC9Qb60EaY0kW4eH68vr3',4,5),('4UVgc46bNblcuD6nj0RsXF','Forever (약속)',298,NULL,'https://open.spotify.com/track/4UVgc46bNblcuD6nj0RsXF',NULL,'2rwRvLdjGzjSYl9AS3UbvH','6YVMFz59CuY7ngCxTxjpxE',25,8),('4V239n5yBIZAyvxisyvfAx','Love To Hate Me + You Never Know',374,NULL,'https://open.spotify.com/track/4V239n5yBIZAyvxisyvfAx',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',42,7),('4v7SAP4KD96BFLWiCd1vF0','Madonna',177,NULL,'https://open.spotify.com/track/4v7SAP4KD96BFLWiCd1vF0',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',58,6),('4v9xEvL0XmVkdDfnzfJbEL','SURF',193,NULL,'https://open.spotify.com/track/4v9xEvL0XmVkdDfnzfJbEL',NULL,'7GiJLfFllsMNTwMZlFxzIK','2KC9Qb60EaY0kW4eH68vr3',16,5),('4VAsrWzd1MZbRdKzf35K4U','RINGO',209,NULL,'https://open.spotify.com/track/4VAsrWzd1MZbRdKzf35K4U',NULL,'0ifQBUhPyd0KvlBmhGVVL0','2KC9Qb60EaY0kW4eH68vr3',8,1),('4VCbgIdr8ptegWeJpqLVHH','Love All (with JAY-Z)',228,NULL,'https://open.spotify.com/track/4VCbgIdr8ptegWeJpqLVHH',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',73,5),('4Vdlt72CFQprR2kf2jeSaL','Comments II',108,NULL,'https://open.spotify.com/track/4Vdlt72CFQprR2kf2jeSaL',NULL,'3cjssumQEsRatYlYG5K86T','1rpgxJZxZMLnFNc1Jmyov5',0,4),('4VMRsbfZzd3SfQtaJ1Wpwi','Double Fantasy (with Future)',268,NULL,'https://open.spotify.com/track/4VMRsbfZzd3SfQtaJ1Wpwi',NULL,'0Ct52rooGyvjv6qXrBPNzm','1Xyo4u8uXC1ZmMpatF05PJ',72,1),('4vy0kVo1ygAIKTZU3F5OoT','Just the Way You Are - Skrillex BatBoi Remix',229,NULL,'https://open.spotify.com/track/4vy0kVo1ygAIKTZU3F5OoT',NULL,'7BzP09BlvvE4ioNgvdLrdm','0du5cEVh5yTK9QJze8zA0C',34,7),('4vz3UReBbxyPuVqgIjTCeA','Rolling Stone',230,NULL,'https://open.spotify.com/track/4vz3UReBbxyPuVqgIjTCeA',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',51,8),('4w1dIZxwO83XpKo5wgLhkk','Belong To The World',307,NULL,'https://open.spotify.com/track/4w1dIZxwO83XpKo5wgLhkk',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',46,5),('4W4fNrZYkobj539TOWsLO2','Die For You (with Ariana Grande) - Remix',232,NULL,'https://open.spotify.com/track/4W4fNrZYkobj539TOWsLO2',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',78,19),('4WfGDkm99oLJSAtELYZYEd','One Of The Girls - Sped Up',215,NULL,'https://open.spotify.com/track/4WfGDkm99oLJSAtELYZYEd',NULL,'4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',64,2),('4WHWrDfGoTa18JWaGd7Gko','Me Too (Live Version)',120,NULL,'https://open.spotify.com/track/4WHWrDfGoTa18JWaGd7Gko',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',3,6),('4Wjhj0WjkyECccfHVIgaTq','Trust Issues',281,NULL,'https://open.spotify.com/track/4Wjhj0WjkyECccfHVIgaTq',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',81,4),('4WlnsX6Mpgv1tZ3Vwtrdsc','Dirty Work - RayRay Remix',201,NULL,'https://open.spotify.com/track/4WlnsX6Mpgv1tZ3Vwtrdsc',NULL,'1bV9UJSiCQOg5S786s2T9g','6YVMFz59CuY7ngCxTxjpxE',45,1),('4wQDjZtXjsFtU3BLSiIH4t','Salty & Sweet',201,NULL,'https://open.spotify.com/track/4wQDjZtXjsFtU3BLSiIH4t',NULL,'69xF8jTd0c4Zoo7DT3Rwrn','6YVMFz59CuY7ngCxTxjpxE',59,3),('4wVOKKEHUJxHCFFNUWDn0B','Chicago Freestyle (feat. Giveon)',220,NULL,'https://open.spotify.com/track/4wVOKKEHUJxHCFFNUWDn0B',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',80,3),('4WZZeEjRqC4tV8rFljQzEo','Heaven Or Las Vegas',353,NULL,'https://open.spotify.com/track/4WZZeEjRqC4tV8rFljQzEo',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',48,9),('4xRxYWgAtL6pzRz94GlZlA','The Ride',351,NULL,'https://open.spotify.com/track/4xRxYWgAtL6pzRz94GlZlA',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',66,18),('4XTXamS1g4g93jPxyuFJJ6','Brand New',213,NULL,'https://open.spotify.com/track/4XTXamS1g4g93jPxyuFJJ6',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',58,17),('4YHnjkaMCgODdtjb7rX922','ZOOM ZOOM',192,NULL,'https://open.spotify.com/track/4YHnjkaMCgODdtjb7rX922',NULL,'61ZCeqzP8onzBEP7dR0P5t','6YVMFz59CuY7ngCxTxjpxE',34,1),('4yjDMKCAeLovlo9ih0AgXW','OMG (FRNK Remix)',210,NULL,'https://open.spotify.com/track/4yjDMKCAeLovlo9ih0AgXW',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',55,2),('4yrdTx61xR97aEi6qsyFbT','Really (Reggae Version) [Live]',210,NULL,'https://open.spotify.com/track/4yrdTx61xR97aEi6qsyFbT',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',33,7),('4YS0JF9kSLe15ggwOQqQit','That\'s What I Like - BLVK JVCK Remix',225,NULL,'https://open.spotify.com/track/4YS0JF9kSLe15ggwOQqQit',NULL,'0219JhsyibMkftKsI94Mv1','0du5cEVh5yTK9QJze8zA0C',42,1),('4Yw8TyBm9J8cpy2guHUYog','What You Need',206,NULL,'https://open.spotify.com/track/4Yw8TyBm9J8cpy2guHUYog',NULL,'7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',74,2),('4YxbIKcZR2EnDLVvC0ztNW','Girls Will Be Girls',168,NULL,'https://open.spotify.com/track/4YxbIKcZR2EnDLVvC0ztNW',NULL,'6TA0VcPiUH1a3tPRp3SjbC','2KC9Qb60EaY0kW4eH68vr3',48,1),('4yyMDjNuPaeHMCVUjjOenj','늘 그대로',247,NULL,'https://open.spotify.com/track/4yyMDjNuPaeHMCVUjjOenj',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',10,10),('4Z3DK6g92f9DGfVHKoEF9a','자유',224,NULL,'https://open.spotify.com/track/4Z3DK6g92f9DGfVHKoEF9a',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',1,4),('4z58YfbLph7Z7l7DhkdctO','Armageddon - Mount XLR Remix',224,NULL,'https://open.spotify.com/track/4z58YfbLph7Z7l7DhkdctO',NULL,'6uWbkjA7Osh3VNnnGeyfl6','6YVMFz59CuY7ngCxTxjpxE',37,4),('4z66pUh3MsTiZIofVjKLuE','Goodbye Love',236,NULL,'https://open.spotify.com/track/4z66pUh3MsTiZIofVjKLuE',NULL,'1V8uYmO4nGulH3YnSbBbWZ','57htMBtzpppc1yoXgjbslj',15,1),('4zHa39io9pjsiAE6LwM2NH','Reminder',218,NULL,'https://open.spotify.com/track/4zHa39io9pjsiAE6LwM2NH',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',52,4),('4zLOwx1yRJXWkHKt1XzF1p','Now & Forever',281,NULL,'https://open.spotify.com/track/4zLOwx1yRJXWkHKt1XzF1p',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',67,13),('4ZT0wGKwlJRjpMUuwZVy3p','Daylight',164,NULL,'https://open.spotify.com/track/4ZT0wGKwlJRjpMUuwZVy3p',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',63,5),('4zwSYiO3hXJhf3kbdOTDAU','SNEAKERS -Japanese ver.-',181,NULL,'https://open.spotify.com/track/4zwSYiO3hXJhf3kbdOTDAU',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',1,9),('4ZxOuNHhpyOj4gv52MtQpT','As If It\'s Your Last',213,NULL,'https://open.spotify.com/track/4ZxOuNHhpyOj4gv52MtQpT',NULL,'7ikmjsvRzDRzxHN0KXSQdv','41MozSoPIsD1dJM0CLPjZF',80,1),('4ZYGm4xWPhsZVijqtpWn4C','Starboy - Live',245,NULL,'https://open.spotify.com/track/4ZYGm4xWPhsZVijqtpWn4C',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',49,12),('50ceCGZ3oD3U5caQV5bP6f','You Only Live Twice (with Lil Wayne & Rick Ross)',213,NULL,'https://open.spotify.com/track/50ceCGZ3oD3U5caQV5bP6f',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',67,18),('50LbU49cudbIw8SBdE9DDQ','그립고… 그리운…',296,NULL,'https://open.spotify.com/track/50LbU49cudbIw8SBdE9DDQ',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',29,8),('50YTkoLSKReei2YwDg9cOH','Maria Maria (Live Version)',268,NULL,'https://open.spotify.com/track/50YTkoLSKReei2YwDg9cOH',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',3,5),('51a6oFNsFpB2zew1tdzT6I','Escape From LA',355,NULL,'https://open.spotify.com/track/51a6oFNsFpB2zew1tdzT6I',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',50,6),('51jiSRzeecKDqQmqm7Qm9C','I\'ll Forget You - 2016 Version',269,NULL,'https://open.spotify.com/track/51jiSRzeecKDqQmqm7Qm9C',NULL,'2wA8OXIv1JXX9kTY2ddfR4','1rpgxJZxZMLnFNc1Jmyov5',35,3),('524wvipGqxPKYWxkjf9y46','Little Bit (feat. Lykke Li)',230,NULL,'https://open.spotify.com/track/524wvipGqxPKYWxkjf9y46',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',72,9),('52lsilmqW7xWeJXARzwz3z','Pretty Savage - JP Ver.',199,NULL,'https://open.spotify.com/track/52lsilmqW7xWeJXARzwz3z',NULL,'7GSCElvTHw10xFfIHdibF1','41MozSoPIsD1dJM0CLPjZF',44,1),('52qof5uEYA0TV0EpR7jNxs','You',203,NULL,'https://open.spotify.com/track/52qof5uEYA0TV0EpR7jNxs',NULL,'5NMtxQJy4wq3mpo3ERVnLs','6YVMFz59CuY7ngCxTxjpxE',56,6),('52R4BAN4L4nN0uuD91B9yz','Die With A Smile - Live in Las Vegas',280,NULL,'https://open.spotify.com/track/52R4BAN4L4nN0uuD91B9yz',NULL,'29uwnLOApt6HvRw3Ll83vG','0du5cEVh5yTK9QJze8zA0C',44,2),('53CYnfMw3X2gbN6WHOIpEj','Over',233,NULL,'https://open.spotify.com/track/53CYnfMw3X2gbN6WHOIpEj',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',33,4),('53KaP77tkliz36LPxWGlWK','Fear Of Heights',155,NULL,'https://open.spotify.com/track/53KaP77tkliz36LPxWGlWK',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',62,4),('53qYItjefG5SUf62428dIw','The Zone',418,NULL,'https://open.spotify.com/track/53qYItjefG5SUf62428dIw',NULL,'6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',65,4),('53VIWPPMz9S7ob0D8JxF9N','Miss Me',305,NULL,'https://open.spotify.com/track/53VIWPPMz9S7ob0D8JxF9N',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',56,11),('54KjiczcYLLYNVX49JtFKA','VAY (Feat. 창빈 of Stray Kids)',161,NULL,'https://open.spotify.com/track/54KjiczcYLLYNVX49JtFKA',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',14,6),('54tBIDmNdxGp04gPNWCCbi','How Sweet (Instrumental)',219,NULL,'https://open.spotify.com/track/54tBIDmNdxGp04gPNWCCbi',NULL,'0EhZEM4RRz0yioTgucDhJq','6HvZYsbFfjnjFrWF950C9d',47,3),('54uNtM77iZ5gawWBQGnEar','Bubble Gum (Instrumental)',200,NULL,'https://open.spotify.com/track/54uNtM77iZ5gawWBQGnEar',NULL,'0EhZEM4RRz0yioTgucDhJq','6HvZYsbFfjnjFrWF950C9d',46,4),('54wv48DETGI2gSJkqTCSyJ','Timeless - Instrumental',256,NULL,'https://open.spotify.com/track/54wv48DETGI2gSJkqTCSyJ',NULL,'0FWdxPnncm63s91g0PkTvv','1Xyo4u8uXC1ZmMpatF05PJ',52,3),('54XqJ3fP3GxmUejMsKwCaK','One Of The Girls',244,NULL,'https://open.spotify.com/track/54XqJ3fP3GxmUejMsKwCaK',NULL,'4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',63,1),('5594ru3efvd674gEeSaJYU','The Breeze Of Sea - Intro(Instrumental)',71,NULL,'https://open.spotify.com/track/5594ru3efvd674gEeSaJYU',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',8,1),('55h7vJchibLdUkxdlX3fK7','Treasure',178,NULL,'https://open.spotify.com/track/55h7vJchibLdUkxdlX3fK7',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',81,4),('55QbtNuyJb65fpPfQNCLvE','사랑 그 흔한 말 (Live Version)',279,NULL,'https://open.spotify.com/track/55QbtNuyJb65fpPfQNCLvE',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',5,3),('55rfzSRfZ1XhG9bNqyiJ5r','December',256,NULL,'https://open.spotify.com/track/55rfzSRfZ1XhG9bNqyiJ5r',NULL,'4Wo9ttaSJZeISISGeUCQHD','1rpgxJZxZMLnFNc1Jmyov5',4,1),('55YHftnlehUQQJoTSLKCxj','Up All Night',234,NULL,'https://open.spotify.com/track/55YHftnlehUQQJoTSLKCxj',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',62,6),('5673WA8EEUSPx1ir26lhGW','Wake Me Up (feat. Justice)',308,NULL,'https://open.spotify.com/track/5673WA8EEUSPx1ir26lhGW',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',75,1),('56NDFbD0tCUawnqeU2wcvv','Girls Love Beyoncé (feat. James Fauntleroy)',225,NULL,'https://open.spotify.com/track/56NDFbD0tCUawnqeU2wcvv',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',61,15),('56S6RjGVEkUmJpUKK0WRAt','도대체 사람들은',213,NULL,'https://open.spotify.com/track/56S6RjGVEkUmJpUKK0WRAt',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',3,2),('56v8WEnGzLByGsDAXDiv4d','ETA',151,NULL,'https://open.spotify.com/track/56v8WEnGzLByGsDAXDiv4d',NULL,'4N1fROq2oeyLGAlQ1C1j18','6HvZYsbFfjnjFrWF950C9d',79,3),('5702raF31K9rvD6KZ6sCTo','Ditto',185,NULL,'https://open.spotify.com/track/5702raF31K9rvD6KZ6sCTo',NULL,'45ozep8uHHnj5CCittuyXj','6HvZYsbFfjnjFrWF950C9d',64,2),('5712uOEqMoPURMtR2QtJGF','In the morning',172,NULL,'https://open.spotify.com/track/5712uOEqMoPURMtR2QtJGF',NULL,'4WnNx3UFK6RtaY3HezgC8E','2KC9Qb60EaY0kW4eH68vr3',35,1),('578CwfxpfH2HxlENOCHc2n','CELIBACY',235,NULL,'https://open.spotify.com/track/578CwfxpfH2HxlENOCHc2n',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',68,17),('57GsLpRtEtrzcPGPop20rS','What Did I Miss?',194,NULL,'https://open.spotify.com/track/57GsLpRtEtrzcPGPop20rS',NULL,'0bNfrGST1xSPZ3V3g5jjHT','3TVXtAsR1Inumwj472S9r4',90,1),('57olj5GnAUyVo6touOTgWl','Devil\'s Paradise',338,NULL,'https://open.spotify.com/track/57olj5GnAUyVo6touOTgWl',NULL,'5bx7i3cuSfXBPF7Li8kUR7','1Xyo4u8uXC1ZmMpatF05PJ',43,2),('57qiTKh8bVX0VtfUNTQqhw','Nothing Without You',198,NULL,'https://open.spotify.com/track/57qiTKh8bVX0VtfUNTQqhw',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',60,15),('57ud1FGpT32QWH2NKHK1Ex','TING TING TING (with Oliver Heldens)',219,NULL,'https://open.spotify.com/track/57ud1FGpT32QWH2NKHK1Ex',NULL,'6RP5wCF7u2WDFiuyQ0loNS','2KC9Qb60EaY0kW4eH68vr3',8,2),('57zypVDrqyXAJhnfvd3v8j','GOLD (English Ver.)',187,NULL,'https://open.spotify.com/track/57zypVDrqyXAJhnfvd3v8j',NULL,'3bXzKLtI7059uh33uiL9GD','2KC9Qb60EaY0kW4eH68vr3',4,1),('58gGH6ezvusTaqWKJRqHPC','Whiplash - English Version',183,NULL,'https://open.spotify.com/track/58gGH6ezvusTaqWKJRqHPC',NULL,'4nGujzCa6JLhMx7rHXE4J9','6YVMFz59CuY7ngCxTxjpxE',55,1),('58Q3FZFs1YXPpliWQB5kXB','Right Now',160,NULL,'https://open.spotify.com/track/58Q3FZFs1YXPpliWQB5kXB',NULL,'1FVw30SoC91lq1UZ6N9rwN','6HvZYsbFfjnjFrWF950C9d',72,2),('58yC1Q6XKjmHeWkEWh9O6B','Outside',259,NULL,'https://open.spotify.com/track/58yC1Q6XKjmHeWkEWh9O6B',NULL,'04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',55,3),('59LCK6UpQY1qhGPEp66AZp','흩어진 나날들',231,NULL,'https://open.spotify.com/track/59LCK6UpQY1qhGPEp66AZp',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',30,3),('59PATAuhwksxKQUsUHCp3X','죽든지 말든지',162,NULL,'https://open.spotify.com/track/59PATAuhwksxKQUsUHCp3X',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',1,9),('59ZmQR4pwCaa5iM3veM7Cs','Amen (feat. Teezo Touchdown)',141,NULL,'https://open.spotify.com/track/59ZmQR4pwCaa5iM3veM7Cs',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',51,2),('5ahYwEgkErOdz6wi6e8lyZ','Sugar-holic',183,NULL,'https://open.spotify.com/track/5ahYwEgkErOdz6wi6e8lyZ',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',8,2),('5aIEFCKhVUM5sKkwOSdFiM','CRYING IN CHANEL',199,NULL,'https://open.spotify.com/track/5aIEFCKhVUM5sKkwOSdFiM',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',70,4),('5Av4jZOAbtY8STz7KPsNDB','Break My Heart Myself (feat. YEJI & RYUJIN of ITZY)',162,NULL,'https://open.spotify.com/track/5Av4jZOAbtY8STz7KPsNDB',NULL,'6nHECY2OnWXVmd4QjGhJEm','2KC9Qb60EaY0kW4eH68vr3',52,1),('5Bk9c44CuJAsekptAplhWD','Mine (채령)',168,NULL,'https://open.spotify.com/track/5Bk9c44CuJAsekptAplhWD',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',13,8),('5bKPVy1ZIAucDWYcK2ZEDE','운명이란 뜻이죠',248,NULL,'https://open.spotify.com/track/5bKPVy1ZIAucDWYcK2ZEDE',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',8,14),('5bmHOXZ1UhiyjaoX5AbsgL','동경 (Live Version)',200,NULL,'https://open.spotify.com/track/5bmHOXZ1UhiyjaoX5AbsgL',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',5,12),('5bMHrigI1EAmZdiyRzKoQi','ICONIC',191,NULL,'https://open.spotify.com/track/5bMHrigI1EAmZdiyRzKoQi',NULL,'3vyyDkvYWC36DwgZCYd3Wu','6YVMFz59CuY7ngCxTxjpxE',56,5),('5bMRkNIp6Dxokj8SAOjFZE','24HRS',127,NULL,'https://open.spotify.com/track/5bMRkNIp6Dxokj8SAOjFZE',NULL,'6RP5wCF7u2WDFiuyQ0loNS','2KC9Qb60EaY0kW4eH68vr3',8,7),('5BRtwCczOItgTOfabyWgkJ','Never give up',199,NULL,'https://open.spotify.com/track/5BRtwCczOItgTOfabyWgkJ',NULL,'2wEGWJx63eWqMBIudI3LsZ','1rpgxJZxZMLnFNc1Jmyov5',4,1),('5BTu8L170anjdgSohdBkkv','Tried Our Best',209,NULL,'https://open.spotify.com/track/5BTu8L170anjdgSohdBkkv',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',55,11),('5bwpbZBOY0mrmRhZ94c0kW','Cookie (FRNK Remix)',212,NULL,'https://open.spotify.com/track/5bwpbZBOY0mrmRhZ94c0kW',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',53,5),('5c5FujzDDLo3XYss4OO3hi','Please',221,NULL,'https://open.spotify.com/track/5c5FujzDDLo3XYss4OO3hi',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',4,12),('5cAhEZ3hAKFMyke5ip6eeO','그곳에 서서',254,NULL,'https://open.spotify.com/track/5cAhEZ3hAKFMyke5ip6eeO',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',29,3),('5ck9P3yEwc8w2Z1oE0CRlz','Popular (A Cappella) (with Playboi Carti & Madonna)',215,NULL,'https://open.spotify.com/track/5ck9P3yEwc8w2Z1oE0CRlz',NULL,'0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',37,5),('5Cp75TUMrHF6c8xbhdligS','Golden',194,NULL,'https://open.spotify.com/track/5Cp75TUMrHF6c8xbhdligS',NULL,'2q4uMcogIfSvbjZevQTIDL','2yNNYQBChuox9A5Ka93BIn',74,1),('5cVALf3PKOmtXBYrsMUXlq','꿈꾸는 소녀 Part Two - Live',254,NULL,'https://open.spotify.com/track/5cVALf3PKOmtXBYrsMUXlq',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',2,8),('5d6lYplVOV4xJ37EVCpHqB','House Of Balloons / Glass Table Girls',407,NULL,'https://open.spotify.com/track/5d6lYplVOV4xJ37EVCpHqB',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',58,3),('5dFh0Y8Idp0vlSdGkzx8O2','꿈꾸는 소녀 - Live',237,NULL,'https://open.spotify.com/track/5dFh0Y8Idp0vlSdGkzx8O2',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',1,9),('5dHpbFmZjWucrol0M7aNGU','The Language',224,NULL,'https://open.spotify.com/track/5dHpbFmZjWucrol0M7aNGU',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',54,10),('5DI9jxTHrEiFAhStG7VA8E','Started From the Bottom',174,NULL,'https://open.spotify.com/track/5DI9jxTHrEiFAhStG7VA8E',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',66,3),('5dkjKoFSjCeGmR1P7wGlxF','Girls - BRLLNT Remix',175,NULL,'https://open.spotify.com/track/5dkjKoFSjCeGmR1P7wGlxF',NULL,'2jK7H4A5Y2xJaoOyzBedaS','6YVMFz59CuY7ngCxTxjpxE',35,1),('5dMVtDN1RDNTOL92oDncwd','Repeat After Me (Interlude)',195,NULL,'https://open.spotify.com/track/5dMVtDN1RDNTOL92oDncwd',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',48,12),('5DxDLsW6PsLz5gkwC7Mk5S','Free',187,NULL,'https://open.spotify.com/track/5DxDLsW6PsLz5gkwC7Mk5S',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',94,8),('5Dxoukq4UC29A7OjQTbHgw','THAT\'S A NO NO',180,NULL,'https://open.spotify.com/track/5Dxoukq4UC29A7OjQTbHgw',NULL,'6RP5wCF7u2WDFiuyQ0loNS','2KC9Qb60EaY0kW4eH68vr3',10,3),('5e574bhjycX1eH2l4Auage','Grammys',220,NULL,'https://open.spotify.com/track/5e574bhjycX1eH2l4Auage',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',61,13),('5e5h9GeNY6janbVi34tn9e','Gone',486,NULL,'https://open.spotify.com/track/5e5h9GeNY6janbVi34tn9e',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',52,7),('5ECz2phQLQWNGbKUlN8AAS','그 보다 더',295,NULL,'https://open.spotify.com/track/5ECz2phQLQWNGbKUlN8AAS',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',9,8),('5Ee4IyhPaOVRMc15fUOeG9','Creepin\' (feat. 21 Savage) - Remix',232,NULL,'https://open.spotify.com/track/5Ee4IyhPaOVRMc15fUOeG9',NULL,'3P2UkOkqWp8ucd1EOnVAH7','1Xyo4u8uXC1ZmMpatF05PJ',52,1),('5ejT19NfiINj4cFmjRHwAC','Love To Lay',223,NULL,'https://open.spotify.com/track/5ejT19NfiINj4cFmjRHwAC',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',46,11),('5eJvtHFpdYgzHbcidqijCy','UNTOUCHABLE (Final Ver.)',194,NULL,'https://open.spotify.com/track/5eJvtHFpdYgzHbcidqijCy',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',14,8),('5eMbkNvdn4VbUQaJmqyalo','As If It\'s Your Last (Live)',224,NULL,'https://open.spotify.com/track/5eMbkNvdn4VbUQaJmqyalo',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',34,11),('5Ermk04tSk2Z7mfVDcP6EG','잊을께',279,NULL,'https://open.spotify.com/track/5Ermk04tSk2Z7mfVDcP6EG',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',39,11),('5eWcGfUCrVFMoYskyfkEPE','Armageddon',196,NULL,'https://open.spotify.com/track/5eWcGfUCrVFMoYskyfkEPE',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',75,2),('5expoVGQPvXuwBBFuNGqBd','Hurt',177,NULL,'https://open.spotify.com/track/5expoVGQPvXuwBBFuNGqBd',NULL,'1HMLpmZAnNyl9pxvOnTovV','6HvZYsbFfjnjFrWF950C9d',74,4),('5f5r2N4Lp9WoULWPH9zp2W','Can\'t Have Everything',228,NULL,'https://open.spotify.com/track/5f5r2N4Lp9WoULWPH9zp2W',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',61,17),('5fHrHoJKfCgBd35zwIBmUK','D4L',189,NULL,'https://open.spotify.com/track/5fHrHoJKfCgBd35zwIBmUK',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',60,9),('5fPtS47kDZFCZ5Txt6j4SX','Wonderland',325,NULL,'https://open.spotify.com/track/5fPtS47kDZFCZ5Txt6j4SX',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',23,3),('5fpyAakgFOm4YTXkgfPzvV','ASAP',134,NULL,'https://open.spotify.com/track/5fpyAakgFOm4YTXkgfPzvV',NULL,'4N1fROq2oeyLGAlQ1C1j18','6HvZYsbFfjnjFrWF950C9d',71,6),('5FUn6vN4PDHXxqnb5LQhJQ','Kiss Land',455,NULL,'https://open.spotify.com/track/5FUn6vN4PDHXxqnb5LQhJQ',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',57,8),('5FUtACXX7AniiESuPD8Ohw','Home',368,NULL,'https://open.spotify.com/track/5FUtACXX7AniiESuPD8Ohw',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',35,1),('5gAtG93v0kjsZt3zPi4WE5','Embrace - Instrumental',223,NULL,'https://open.spotify.com/track/5gAtG93v0kjsZt3zPi4WE5',NULL,'7e6PkMzboUpQPcnDiDQMOk','1rpgxJZxZMLnFNc1Jmyov5',0,3),('5Ggfa9cpkpfp5D6Rg0Yyw1','Come Thru',236,NULL,'https://open.spotify.com/track/5Ggfa9cpkpfp5D6Rg0Yyw1',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',64,14),('5GK7eDDTVz7CTge1wJrDQW','Kill This Love',189,NULL,'https://open.spotify.com/track/5GK7eDDTVz7CTge1wJrDQW',NULL,'3qw2vm3uqKT3EIg95wbg83','41MozSoPIsD1dJM0CLPjZF',75,1),('5GM4EsVHaxGjzgQ81S2J61','Hardest To Love',211,NULL,'https://open.spotify.com/track/5GM4EsVHaxGjzgQ81S2J61',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',49,3),('5gSbJzx22IffLytwZLSQgs','Can\'t tie me down',183,NULL,'https://open.spotify.com/track/5gSbJzx22IffLytwZLSQgs',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',3,8),('5gZNoZaayKrDOmVJFgJGQU','BET ON ME',199,NULL,'https://open.spotify.com/track/5gZNoZaayKrDOmVJFgJGQU',NULL,'5tXD77S3yCWTToU5eMLnlo','2KC9Qb60EaY0kW4eH68vr3',18,1),('5H4mXWKcicuLKDn4Jy0sK7','Time Flies',192,NULL,'https://open.spotify.com/track/5H4mXWKcicuLKDn4Jy0sK7',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',76,7),('5HFQB9ENLGBHTci7xPmLk6','A Lonely Night',220,NULL,'https://open.spotify.com/track/5HFQB9ENLGBHTci7xPmLk6',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',48,12),('5hFWGFM4sAebbkwR74loGH','Treasure - Bailey Smalls Remix',288,NULL,'https://open.spotify.com/track/5hFWGFM4sAebbkwR74loGH',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',27,9),('5homruRi0m4GuyJBod3kcn','달라달라 - Inst.',199,NULL,'https://open.spotify.com/track/5homruRi0m4GuyJBod3kcn',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',5,11),('5HQjwHGA0z4ehhM9ZeoIoC','말 없는 축제',303,NULL,'https://open.spotify.com/track/5HQjwHGA0z4ehhM9ZeoIoC',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',3,11),('5hse7JC8DFwZInsvw1Dobl','HERO (From the Film ″Firefighters″)',334,NULL,'https://open.spotify.com/track/5hse7JC8DFwZInsvw1Dobl',NULL,'7eSSfgp09p31q3tH5ziNWx','57htMBtzpppc1yoXgjbslj',40,1),('5HUQPQ9E1a4er4UhB8C7Rc','Dollhouse (with Lily Rose Depp)',239,NULL,'https://open.spotify.com/track/5HUQPQ9E1a4er4UhB8C7Rc',NULL,'10SppFk45za4CHPEiiuQaD','1Xyo4u8uXC1ZmMpatF05PJ',66,1),('5idmfDT06TjCQ1SPDsa5qh','Kiss Land',455,NULL,'https://open.spotify.com/track/5idmfDT06TjCQ1SPDsa5qh',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',67,8),('5IKRga8drUYZ5IqON5xXbx','REALLY - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',206,NULL,'https://open.spotify.com/track/5IKRga8drUYZ5IqON5xXbx',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',37,7),('5ImHZesSZv6lk84fiK3WLZ','Sun and Moon',199,NULL,'https://open.spotify.com/track/5ImHZesSZv6lk84fiK3WLZ',NULL,'5RylhkCb6kzwJDokcvQZeE','6YVMFz59CuY7ngCxTxjpxE',35,2),('5InOp6q2vvx0fShv3bzFLZ','Know Yourself',275,NULL,'https://open.spotify.com/track/5InOp6q2vvx0fShv3bzFLZ',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',69,4),('5JA4q7xkeSxmhgfAkPWnWW','달라달라 (DALLA DALLA)',199,NULL,'https://open.spotify.com/track/5JA4q7xkeSxmhgfAkPWnWW',NULL,'4MNtFZXiyx5ltdldHFKQSg','2KC9Qb60EaY0kW4eH68vr3',44,1),('5JaqApg5415jtjdyjY3wa9','Valerie',286,NULL,'https://open.spotify.com/track/5JaqApg5415jtjdyjY3wa9',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',59,10),('5JpSjNcjuP8L9QrYmv3xcn','Lonely Star',349,NULL,'https://open.spotify.com/track/5JpSjNcjuP8L9QrYmv3xcn',NULL,'6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',59,1),('5JQ5Acrgv1VrO9UtMUN052','Heaven Or Las Vegas',353,NULL,'https://open.spotify.com/track/5JQ5Acrgv1VrO9UtMUN052',NULL,'6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',52,9),('5JUu0unA8VwhTZ9LkMWUVI','Since Way Back',368,NULL,'https://open.spotify.com/track/5JUu0unA8VwhTZ9LkMWUVI',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',67,19),('5jWlPvvUAhN27DVvtM3n3f','Voltage',221,NULL,'https://open.spotify.com/track/5jWlPvvUAhN27DVvtM3n3f',NULL,'2u0QU6DP2HL5t9cp04vzBT','2KC9Qb60EaY0kW4eH68vr3',3,1),('5k58Fbi1th2ITcaweRSbVq','Treasure - Sharam Radio Remix',221,NULL,'https://open.spotify.com/track/5k58Fbi1th2ITcaweRSbVq',NULL,'7yBnuW3SpMKy3EB9iU0C7p','0du5cEVh5yTK9QJze8zA0C',42,1),('5kdt3O2kCcXE7mSGKaiW6V','사랑한걸로 됐어요',244,NULL,'https://open.spotify.com/track/5kdt3O2kCcXE7mSGKaiW6V',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',4,2),('5KNNUrjAuBzPhNZ5JHjSJI','모래성',263,NULL,'https://open.spotify.com/track/5KNNUrjAuBzPhNZ5JHjSJI',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',13,13),('5kuFnOKZYkBfZA7ng2e47C','독백',276,NULL,'https://open.spotify.com/track/5kuFnOKZYkBfZA7ng2e47C',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',2,10),('5kYbCBVmANyEBAEEencFfo','흰수염고래',279,NULL,'https://open.spotify.com/track/5kYbCBVmANyEBAEEencFfo',NULL,'75fZ4eJHsRFNpn4VDoQbKb','1rpgxJZxZMLnFNc1Jmyov5',46,2),('5L29d3WeVDxvQYC2sNdj3b','Miss Me',305,NULL,'https://open.spotify.com/track/5L29d3WeVDxvQYC2sNdj3b',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',27,11),('5L3ecxQnQ9qTBmnLQiwf0C','K-POP',185,NULL,'https://open.spotify.com/track/5L3ecxQnQ9qTBmnLQiwf0C',NULL,'10eNMeTimUzAKLhCOpIUlb','1Xyo4u8uXC1ZmMpatF05PJ',72,1),('5LAKjqbB5uurPpxFEicd9S','Wu-Tang Forever',217,NULL,'https://open.spotify.com/track/5LAKjqbB5uurPpxFEicd9S',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',59,4),('5LByxLn1X1Q9vr0xa4ZLYf','Golden - Instrumental',192,NULL,'https://open.spotify.com/track/5LByxLn1X1Q9vr0xa4ZLYf',NULL,'2q4uMcogIfSvbjZevQTIDL','2yNNYQBChuox9A5Ka93BIn',71,2),('5LeEtVq2My5JlRDvEOzvsb','7년의 그리움',250,NULL,'https://open.spotify.com/track/5LeEtVq2My5JlRDvEOzvsb',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',3,6),('5LffvExhQQFcfwqkGNpFpM','Jealous Guy',209,NULL,'https://open.spotify.com/track/5LffvExhQQFcfwqkGNpFpM',NULL,'7tzVd1fwkxsorytCBjEJkU','1Xyo4u8uXC1ZmMpatF05PJ',56,2),('5LgFeUn0Jx8UVkPlrMbTOc','Finesse - Pink Panda Remix; feat. Cardi B',148,NULL,'https://open.spotify.com/track/5LgFeUn0Jx8UVkPlrMbTOc',NULL,'5AVEtKtguEa8sqYhSj3zFW','0du5cEVh5yTK9QJze8zA0C',47,2),('5lka5RUbLVQGO94mKAPMRO','Put On A Smile',255,NULL,'https://open.spotify.com/track/5lka5RUbLVQGO94mKAPMRO',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',59,6),('5LMoKDVzW2kDneNu2UbspP','Zero',154,NULL,'https://open.spotify.com/track/5LMoKDVzW2kDneNu2UbspP',NULL,'2zYcjcNUzcgMntymoukwZR','6HvZYsbFfjnjFrWF950C9d',64,1),('5LnXWeA9tuWKI2C1H74iiJ','Too Much',261,NULL,'https://open.spotify.com/track/5LnXWeA9tuWKI2C1H74iiJ',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',64,12),('5LUI2ZPwvJezp4bQ9DtIGK','Dirty Work',180,NULL,'https://open.spotify.com/track/5LUI2ZPwvJezp4bQ9DtIGK',NULL,'1bV9UJSiCQOg5S786s2T9g','6YVMFz59CuY7ngCxTxjpxE',49,4),('5M1n6xeBtHTgg50ztjGgRw','Enjoy The Show (feat. Future) - Single Version',224,NULL,'https://open.spotify.com/track/5M1n6xeBtHTgg50ztjGgRw',NULL,'15b9JCsZh7DkbA2EjBjPqc','1Xyo4u8uXC1ZmMpatF05PJ',43,1),('5M2lX0ZAYSAzCs1xPPi9BX','Fat Juicy & Wet',141,NULL,'https://open.spotify.com/track/5M2lX0ZAYSAzCs1xPPi9BX',NULL,'1y2OfMwyaRDmtbQNl0DnQa','0du5cEVh5yTK9QJze8zA0C',75,1),('5mCPDVBb16L4XQwDdbRUpz','Passionfruit',298,NULL,'https://open.spotify.com/track/5mCPDVBb16L4XQwDdbRUpz',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',88,3),('5mEE5p155rwEwxk83wcRIZ','K-POP - Sped Up',145,NULL,'https://open.spotify.com/track/5mEE5p155rwEwxk83wcRIZ',NULL,'0jiAYLsE1PumLJncO7vUIl','1Xyo4u8uXC1ZmMpatF05PJ',29,4),('5MKacSdARIq0fCf9BQNKNq','동백 아가씨 - Live',181,NULL,'https://open.spotify.com/track/5MKacSdARIq0fCf9BQNKNq',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,7),('5mPSyjLatqB00IkPqRlbTE','Pop Style',212,NULL,'https://open.spotify.com/track/5mPSyjLatqB00IkPqRlbTE',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',62,15),('5mZJwWdxAOR4xUvSGZvvMU','6PM In New York',283,NULL,'https://open.spotify.com/track/5mZJwWdxAOR4xUvSGZvvMU',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',62,17),('5n03LAVixLBSDcSo0UMhc1','Spice（Instrumental）',191,NULL,'https://open.spotify.com/track/5n03LAVixLBSDcSo0UMhc1',NULL,'2u0QU6DP2HL5t9cp04vzBT','2KC9Qb60EaY0kW4eH68vr3',1,4),('5n6XDt43EpXIVxt1pyslIj','내게 와 줘',261,NULL,'https://open.spotify.com/track/5n6XDt43EpXIVxt1pyslIj',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',10,3),('5NFYuqu8V6QXc6mzcLImd6','Hype',209,NULL,'https://open.spotify.com/track/5NFYuqu8V6QXc6mzcLImd6',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',62,5),('5ngydCLbzCEdtu8SEOXhPU','All Me',271,NULL,'https://open.spotify.com/track/5ngydCLbzCEdtu8SEOXhPU',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',60,15),('5nvRWKWqHFMAxAxPTzDr0R','How You Like That',181,NULL,'https://open.spotify.com/track/5nvRWKWqHFMAxAxPTzDr0R',NULL,'19vSttgdhH7PoAbvXBY7VT','41MozSoPIsD1dJM0CLPjZF',49,1),('5Nz7hI3cCOHmMR4vSLJ1An','GIMME A HUG',193,NULL,'https://open.spotify.com/track/5Nz7hI3cCOHmMR4vSLJ1An',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',78,10),('5NzsuVrkbi7nRsmZR8WYDK','BOOMBAYAH (Live)',247,NULL,'https://open.spotify.com/track/5NzsuVrkbi7nRsmZR8WYDK',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',34,10),('5o0hXCXwwswm8Ij2w2ZxfK','도깨비불 (Illusion)',195,NULL,'https://open.spotify.com/track/5o0hXCXwwswm8Ij2w2ZxfK',NULL,'7AeJIhR7oTd7l6A1hZNbmS','6YVMFz59CuY7ngCxTxjpxE',34,1),('5o6GTzoPXDGEMkF74w64eK','Goodbye Love',236,NULL,'https://open.spotify.com/track/5o6GTzoPXDGEMkF74w64eK',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',17,13),('5oAOK7xCJD8hzp9PuxjULL','Tears In The Rain',444,NULL,'https://open.spotify.com/track/5oAOK7xCJD8hzp9PuxjULL',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',58,10),('5ocSQW5sIUIOFojwXEz9Ki','Supernatural',191,NULL,'https://open.spotify.com/track/5ocSQW5sIUIOFojwXEz9Ki',NULL,'1FVw30SoC91lq1UZ6N9rwN','6HvZYsbFfjnjFrWF950C9d',78,1),('5OmX5lXxZ5sQgPuSHDn293','Wanderlust',306,NULL,'https://open.spotify.com/track/5OmX5lXxZ5sQgPuSHDn293',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',49,7),('5ONnknPrFf58QVxCBRcofB','Starry Eyes - MIKE DEAN Remix',198,NULL,'https://open.spotify.com/track/5ONnknPrFf58QVxCBRcofB',NULL,'6vJRxj9GnmwXT7mKJqE61n','1Xyo4u8uXC1ZmMpatF05PJ',41,1),('5P3o95Jf0YBQRQ4j2XPpfC','Pink Venom',186,NULL,'https://open.spotify.com/track/5P3o95Jf0YBQRQ4j2XPpfC',NULL,'0S4pP8MBY9p7ngFWIZQAJv','41MozSoPIsD1dJM0CLPjZF',75,1),('5pa3YnjQ4rHeHAyoCEYYNX','Mr. Vampire (Final Ver.)',170,NULL,'https://open.spotify.com/track/5pa3YnjQ4rHeHAyoCEYYNX',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',12,9),('5pJgTFVTia5c8B65Cfw85d','Better Things',203,NULL,'https://open.spotify.com/track/5pJgTFVTia5c8B65Cfw85d',NULL,'05K5RSyTasOI8cQTFHhTLS','6YVMFz59CuY7ngCxTxjpxE',29,2),('5PjyQ1UDDAT4mIiTYI320C','Bad Boy (with Jeon So Young)',269,NULL,'https://open.spotify.com/track/5PjyQ1UDDAT4mIiTYI320C',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',6,8),('5PMcoXXq1foyS8VFmJQvjt','RACER',192,NULL,'https://open.spotify.com/track/5PMcoXXq1foyS8VFmJQvjt',NULL,'0t98iMat2EXJthAhr844Sx','2KC9Qb60EaY0kW4eH68vr3',11,2),('5Psnhdkyanjpgc2P8A5TSM','Emotionless',302,NULL,'https://open.spotify.com/track/5Psnhdkyanjpgc2P8A5TSM',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',68,4),('5PTfZsGlsDDPH8i3PdQnXJ','Call Out My Name - A Cappella',224,NULL,'https://open.spotify.com/track/5PTfZsGlsDDPH8i3PdQnXJ',NULL,'4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',57,7),('5qMYSBKAxiuTGqFgsMhxLR','LOCO - Inst.',191,NULL,'https://open.spotify.com/track/5qMYSBKAxiuTGqFgsMhxLR',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',3,16),('5QO79kh1waicV47BqGRL3g','Save Your Tears',215,NULL,'https://open.spotify.com/track/5QO79kh1waicV47BqGRL3g',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',88,11),('5qoFAPkedVs1aKaK50tyxG','이 땅에 살기 위하여',210,NULL,'https://open.spotify.com/track/5qoFAPkedVs1aKaK50tyxG',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',2,3),('5qw6fieMlvOWhpMcoldr7C','Can\'t tie me down（Instrumental）',184,NULL,'https://open.spotify.com/track/5qw6fieMlvOWhpMcoldr7C',NULL,'0SbnkLLiTqVmoPmhY80s7S','2KC9Qb60EaY0kW4eH68vr3',0,4),('5qwjdbcy6uaZpQNSbB7zXB','A Promise not to Lose',232,NULL,'https://open.spotify.com/track/5qwjdbcy6uaZpQNSbB7zXB',NULL,'4MtUmggE3ExRmzshLvmU9o','1rpgxJZxZMLnFNc1Jmyov5',13,1),('5qYL0psWtYZK5iYowCTUOt','오늘 나는 윤기사',220,NULL,'https://open.spotify.com/track/5qYL0psWtYZK5iYowCTUOt',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',3,8),('5R08wmXUd31d6InEtWZEKi','나비의 겨울',254,NULL,'https://open.spotify.com/track/5R08wmXUd31d6InEtWZEKi',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',9,9),('5r6dnnBEstYJ08H1Hl9TBL','뚜껑별꽃',278,NULL,'https://open.spotify.com/track/5r6dnnBEstYJ08H1Hl9TBL',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',15,7),('5RBH8ypFAj5HTZTPRpI1XL','See U Later',198,NULL,'https://open.spotify.com/track/5RBH8ypFAj5HTZTPRpI1XL',NULL,'6yetqbA9vli7RLoUWYZLsq','41MozSoPIsD1dJM0CLPjZF',61,4),('5RlqhZfTao31aQUO2QjpkG','Faith - Live',185,NULL,'https://open.spotify.com/track/5RlqhZfTao31aQUO2QjpkG',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',46,18),('5RoqWTV72C8GZhHmQqBh7O','SNEAKERS',179,NULL,'https://open.spotify.com/track/5RoqWTV72C8GZhHmQqBh7O',NULL,'0t98iMat2EXJthAhr844Sx','2KC9Qb60EaY0kW4eH68vr3',38,1),('5rzI6Jnlhx8DgVgsOLorfW','Baptized In Fear',232,NULL,'https://open.spotify.com/track/5rzI6Jnlhx8DgVgsOLorfW',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',76,6),('5sBDrrtLGbV64QJnEqfjer','What It Sounds Like',250,NULL,'https://open.spotify.com/track/5sBDrrtLGbV64QJnEqfjer',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',94,9),('5ScbulRnixQ2XAdvrPMFjz','Get Along Better',229,NULL,'https://open.spotify.com/track/5ScbulRnixQ2XAdvrPMFjz',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',73,17),('5sdQOyqq2IDhvmx2lHOpwd','Super Shy',154,NULL,'https://open.spotify.com/track/5sdQOyqq2IDhvmx2lHOpwd',NULL,'5V729UqvhwNOcMejx0m55I','6HvZYsbFfjnjFrWF950C9d',81,2),('5SF1kcOiOmtZFUIQNGC4TC','The Birds Pt. 1',214,NULL,'https://open.spotify.com/track/5SF1kcOiOmtZFUIQNGC4TC',NULL,'6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',60,5),('5SGEPm9ge10bD4j3ec9UHV','Missed You - Bonus Track',144,NULL,'https://open.spotify.com/track/5SGEPm9ge10bD4j3ec9UHV',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',60,16),('5sjnkOfTLCLNfkkchI2re2','UP - KARINA Solo',166,NULL,'https://open.spotify.com/track/5sjnkOfTLCLNfkkchI2re2',NULL,'4vLGHlTnlIIxMSfefCY0cU','6YVMFz59CuY7ngCxTxjpxE',78,1),('5syO3TqduLpA8GcQqPfLAE','Fantastic World',44,NULL,'https://open.spotify.com/track/5syO3TqduLpA8GcQqPfLAE',NULL,'3wtbBSjOhKOw7UdngHEDiO','57htMBtzpppc1yoXgjbslj',5,1),('5TCBWmEBrin7etRa4Lswr1','When To Say When',223,NULL,'https://open.spotify.com/track/5TCBWmEBrin7etRa4Lswr1',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',60,2),('5ThJAPtuOCTV8owZUop495','305 To My City',255,NULL,'https://open.spotify.com/track/5ThJAPtuOCTV8owZUop495',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',48,11),('5U1OAxSjxlmLNvfll1SJDC','Be In Love',200,NULL,'https://open.spotify.com/track/5U1OAxSjxlmLNvfll1SJDC',NULL,'7GiJLfFllsMNTwMZlFxzIK','2KC9Qb60EaY0kW4eH68vr3',15,6),('5UJshy5HDHdNEVqlJwzsQB','Versace on the Floor (Bruno Mars vs. David Guetta)',228,NULL,'https://open.spotify.com/track/5UJshy5HDHdNEVqlJwzsQB',NULL,'0yDiMZdbFwO5lGB9Dq5wlL','0du5cEVh5yTK9QJze8zA0C',59,1),('5uOKUtDbZ4c5jib0Mnayoa','Dynamite (Final Ver.)',169,NULL,'https://open.spotify.com/track/5uOKUtDbZ4c5jib0Mnayoa',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',9,10),('5Us8wh9hCAQ8Uq1ast5CWz','Thank Me Now',328,NULL,'https://open.spotify.com/track/5Us8wh9hCAQ8Uq1ast5CWz',NULL,'6agmeioaDOBupymziJihgB','3TVXtAsR1Inumwj472S9r4',46,14),('5vjgyZm1Zhtg4RptN4evNQ','Love In The Sky',267,NULL,'https://open.spotify.com/track/5vjgyZm1Zhtg4RptN4evNQ',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',46,4),('5VtRJCH4htsNSCQd4teG6K','새로운 약속',239,NULL,'https://open.spotify.com/track/5VtRJCH4htsNSCQd4teG6K',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',1,10),('5Wcvle7c2jTMh5FFimP6Dw','Ela É do Tipo (feat. Drake) [Remix]',212,NULL,'https://open.spotify.com/track/5Wcvle7c2jTMh5FFimP6Dw',NULL,'7ybV3NCogLGAhBx75pB3ih','3TVXtAsR1Inumwj472S9r4',52,1),('5WD8WEfxb8xRyNhi8eJEZh','WANT IT?',200,NULL,'https://open.spotify.com/track/5WD8WEfxb8xRyNhi8eJEZh',NULL,'4MNtFZXiyx5ltdldHFKQSg','2KC9Qb60EaY0kW4eH68vr3',12,2),('5weiiKJieLj9jOL9u2F34z','오솔길 Path',221,NULL,'https://open.spotify.com/track/5weiiKJieLj9jOL9u2F34z',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',80,11),('5wi8GRfa0JIv9cx5jCGkQB','ZOOM ZOOM',192,NULL,'https://open.spotify.com/track/5wi8GRfa0JIv9cx5jCGkQB',NULL,'5RylhkCb6kzwJDokcvQZeE','6YVMFz59CuY7ngCxTxjpxE',23,3),('5WlVx0a6VedSJ60JFYpRBp','Locked out of Heaven - The M Machine Remix',242,NULL,'https://open.spotify.com/track/5WlVx0a6VedSJ60JFYpRBp',NULL,'2vf1K6KumbRZnRHa1JeKyD','0du5cEVh5yTK9QJze8zA0C',43,3),('5wQgwLigxPtDwDMMFCu2tV','Wild Flower',314,NULL,'https://open.spotify.com/track/5wQgwLigxPtDwDMMFCu2tV',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',49,6),('5wTRsfZKeaQnQn8JeW8QYQ','305 To My City',255,NULL,'https://open.spotify.com/track/5wTRsfZKeaQnQn8JeW8QYQ',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',47,11),('5wyFsVGDdrOZM0nf2D4p8f','Out of Time - KAYTRANADA Remix / Radio Edit',155,NULL,'https://open.spotify.com/track/5wyFsVGDdrOZM0nf2D4p8f',NULL,'6LuY3APmuxui8BM2oibkrZ','1Xyo4u8uXC1ZmMpatF05PJ',36,2),('5XbA7TAqsD0fj0dGBrbb0D','I Heard You’re Married (feat. Lil Wayne)',263,NULL,'https://open.spotify.com/track/5XbA7TAqsD0fj0dGBrbb0D',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',62,14),('5XMkENs3GfeRza8MfVAhjK','Finesse',191,NULL,'https://open.spotify.com/track/5XMkENs3GfeRza8MfVAhjK',NULL,'4PgleR09JVnm3zY1fW3XBA','0du5cEVh5yTK9QJze8zA0C',74,8),('5XWlyfo0kZ8LF7VSyfS4Ew','Drama',214,NULL,'https://open.spotify.com/track/5XWlyfo0kZ8LF7VSyfS4Ew',NULL,'5NMtxQJy4wq3mpo3ERVnLs','6YVMFz59CuY7ngCxTxjpxE',80,1),('5y7y60SRQ1Sa36RXDfYkmY','Wild Wild West',203,NULL,'https://open.spotify.com/track/5y7y60SRQ1Sa36RXDfYkmY',NULL,'4WnNx3UFK6RtaY3HezgC8E','2KC9Qb60EaY0kW4eH68vr3',7,4),('5YeBR4m1LavfioB9rcoQMW','BORN TO BE',178,NULL,'https://open.spotify.com/track/5YeBR4m1LavfioB9rcoQMW',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',21,1),('5YjTawmFVPxnKcO3RktXGs','GOLD',187,NULL,'https://open.spotify.com/track/5YjTawmFVPxnKcO3RktXGs',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',32,1),('5yLfbMfduI2PEP48xMdfWa','It`s Gonna Be Rolling',301,NULL,'https://open.spotify.com/track/5yLfbMfduI2PEP48xMdfWa',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',5,4),('5yY9lUy8nbvjM1Uyo1Uqoc','Life Is Good (feat. Drake)',237,NULL,'https://open.spotify.com/track/5yY9lUy8nbvjM1Uyo1Uqoc',NULL,'5uCEoLCj3ZZZ1EtzQdQWVl','3TVXtAsR1Inumwj472S9r4',75,1),('5ZDKPFRZC6QlJpf8bCIXTs','The Abyss (feat. Lana Del Rey)',282,NULL,'https://open.spotify.com/track/5ZDKPFRZC6QlJpf8bCIXTs',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',78,19),('5ZicFGBDAi9J2YCVesboUp','Professional',368,NULL,'https://open.spotify.com/track/5ZicFGBDAi9J2YCVesboUp',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',58,1),('5zJl9VWCSdpu3ZJayP8CdB','88만원의 Losing Game - Live',228,NULL,'https://open.spotify.com/track/5zJl9VWCSdpu3ZJayP8CdB',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,2),('5ZWKe9ULA7mGtwmhyNCDeu','개는 달린다, 사랑처럼.',149,NULL,'https://open.spotify.com/track/5ZWKe9ULA7mGtwmhyNCDeu',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',9,5),('5zwQd8YaicbTm082uRbDZn','몰랐죠 (with 앤)',292,NULL,'https://open.spotify.com/track/5zwQd8YaicbTm082uRbDZn',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',9,5),('60IHvjpylI1IZHVSZnQSKJ','Kill This Love - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',204,NULL,'https://open.spotify.com/track/60IHvjpylI1IZHVSZnQSKJ',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',41,5),('60Uio68M57PwKEgZxSutL6','\'Til We Meet Again',218,NULL,'https://open.spotify.com/track/60Uio68M57PwKEgZxSutL6',NULL,'69xF8jTd0c4Zoo7DT3Rwrn','6YVMFz59CuY7ngCxTxjpxE',53,6),('60XAS1A7ABO58GeofeVs9W','Heukseok-dong - Instrumental',413,NULL,'https://open.spotify.com/track/60XAS1A7ABO58GeofeVs9W',NULL,'1h3aXRHMtuiUTnEymDWKGo','1rpgxJZxZMLnFNc1Jmyov5',10,2),('614TWJTbiXsJCPxMpnKi0L','PLAYING WITH FIRE - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',197,NULL,'https://open.spotify.com/track/614TWJTbiXsJCPxMpnKi0L',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',37,9),('61S79KIVA4I9FXbnsylEHT','In The Bible (with Lil Durk & Giveon)',296,NULL,'https://open.spotify.com/track/61S79KIVA4I9FXbnsylEHT',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',67,4),('61tqrU7wp1EnoJ5ajtYXMl','Ready For Love',184,NULL,'https://open.spotify.com/track/61tqrU7wp1EnoJ5ajtYXMl',NULL,'0S4pP8MBY9p7ngFWIZQAJv','41MozSoPIsD1dJM0CLPjZF',62,8),('62puT51UXXLEO7I60DMDwC','LOVER',360,NULL,'https://open.spotify.com/track/62puT51UXXLEO7I60DMDwC',NULL,'4gH7f7Wlmj4CP6K2VrSwIt','57htMBtzpppc1yoXgjbslj',32,1),('62Q8xON11csaJlfmRF7Y5O','Better Things - Dance Remix',194,NULL,'https://open.spotify.com/track/62Q8xON11csaJlfmRF7Y5O',NULL,'2P8trIADhHx8fJAdC7ud40','6YVMFz59CuY7ngCxTxjpxE',34,1),('637oNhilCI9UlkWkUW4Grt','Enjoy The Show (feat. Future)',301,NULL,'https://open.spotify.com/track/637oNhilCI9UlkWkUW4Grt',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',72,10),('63p3Slj0shAFP0Q7dQetj5','Used To',268,NULL,'https://open.spotify.com/track/63p3Slj0shAFP0Q7dQetj5',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',61,11),('63RDKBQabA00X6EeU5dhke','Sinchon Studio에서의 하루',117,NULL,'https://open.spotify.com/track/63RDKBQabA00X6EeU5dhke',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',4,18),('64JIAZ0bS7WoARYfWQGCoz','I Can\'t Fucking Sing',12,NULL,'https://open.spotify.com/track/64JIAZ0bS7WoARYfWQGCoz',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',22,3),('64TkpV7m7f09JY7K436pju','That\'s What I Like - PARTYNEXTDOOR Remix',206,NULL,'https://open.spotify.com/track/64TkpV7m7f09JY7K436pju',NULL,'2xclonI4faQWl6lhqecGM5','0du5cEVh5yTK9QJze8zA0C',50,1),('65FftemJ1DbbZ45DUfHJXE','OMG',212,NULL,'https://open.spotify.com/track/65FftemJ1DbbZ45DUfHJXE',NULL,'45ozep8uHHnj5CCittuyXj','6HvZYsbFfjnjFrWF950C9d',81,1),('65OVbaJR5O1RmwOQx0875b','Wants and Needs (feat. Lil Baby)',192,NULL,'https://open.spotify.com/track/65OVbaJR5O1RmwOQx0875b',NULL,'5LuoozUhs2pl3glZeAJl89','3TVXtAsR1Inumwj472S9r4',80,2),('66ckS4bg3DD2kNQEPWX2m3','Just the Way You Are - Simon Steur Dub',337,NULL,'https://open.spotify.com/track/66ckS4bg3DD2kNQEPWX2m3',NULL,'7BzP09BlvvE4ioNgvdLrdm','0du5cEVh5yTK9QJze8zA0C',29,2),('66VTPZBGWqsiDZdyNUdLIp','iD',206,NULL,'https://open.spotify.com/track/66VTPZBGWqsiDZdyNUdLIp',NULL,'7GiJLfFllsMNTwMZlFxzIK','2KC9Qb60EaY0kW4eH68vr3',8,4),('67c5z7yzP6Hlsz2DZtxMxG','Ice Cream (with Selena Gomez)',175,NULL,'https://open.spotify.com/track/67c5z7yzP6Hlsz2DZtxMxG',NULL,'3KJrNl6UCBBXF7f4Fu14fG','41MozSoPIsD1dJM0CLPjZF',45,1),('67yDGKXKIkyBhwbey8AmEU','BAHAMA',190,NULL,'https://open.spotify.com/track/67yDGKXKIkyBhwbey8AmEU',NULL,'3gHhPm8z8tid1kvpniUKuK','6YVMFz59CuY7ngCxTxjpxE',56,6),('69BIczdH6QMnFx7dsSssN8','DDU-DU DDU-DU',209,NULL,'https://open.spotify.com/track/69BIczdH6QMnFx7dsSssN8',NULL,'6yetqbA9vli7RLoUWYZLsq','41MozSoPIsD1dJM0CLPjZF',72,1),('69dF0bCa5X3sMQatT3vW31','후회 없어',248,NULL,'https://open.spotify.com/track/69dF0bCa5X3sMQatT3vW31',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',9,6),('69gz9onZQNVw55cMQsaYii','Tuscan Leather',366,NULL,'https://open.spotify.com/track/69gz9onZQNVw55cMQsaYii',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',59,1),('69wXLEvLCgLqW72hkrSWVQ','사랑 그 흔한 말',267,NULL,'https://open.spotify.com/track/69wXLEvLCgLqW72hkrSWVQ',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',4,13),('6a4GH1gljLL7VvmO9u5O92','Don’t Break My Heart',205,NULL,'https://open.spotify.com/track/6a4GH1gljLL7VvmO9u5O92',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',63,13),('6a8vt3DULkInboV43feS5I','1991年, 찬바람이 불던 밤…',247,NULL,'https://open.spotify.com/track/6a8vt3DULkInboV43feS5I',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',28,13),('6aH5nGord27nkzlp99vYiB','Wind Child - Interlude',40,NULL,'https://open.spotify.com/track/6aH5nGord27nkzlp99vYiB',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',7,12),('6AIxmLiDNHFQgZstB4lzDB','Locked out of Heaven - Sultan and Ned Shepard Remix',410,NULL,'https://open.spotify.com/track/6AIxmLiDNHFQgZstB4lzDB',NULL,'2vf1K6KumbRZnRHa1JeKyD','0du5cEVh5yTK9QJze8zA0C',42,2),('6b5P51m8xx2XA6U7sdNZ5E','Alone Again',250,NULL,'https://open.spotify.com/track/6b5P51m8xx2XA6U7sdNZ5E',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',68,1),('6b8Be6ljOzmkOmFslEb23P','24K Magic',225,NULL,'https://open.spotify.com/track/6b8Be6ljOzmkOmFslEb23P',NULL,'4PgleR09JVnm3zY1fW3XBA','0du5cEVh5yTK9QJze8zA0C',85,1),('6BCDS43QqQkK6TWg9F2YhO','The Shoe Fits - Instrumental',374,NULL,'https://open.spotify.com/track/6BCDS43QqQkK6TWg9F2YhO',NULL,'3CHCm9n05a3tG4cQJ4rJwq','3TVXtAsR1Inumwj472S9r4',28,3),('6bDNjqza0hqoZ16XpK331T','It\'s Strange (Acoustic Ver.)',266,NULL,'https://open.spotify.com/track/6bDNjqza0hqoZ16XpK331T',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',18,1),('6bh0MGGMNKeyjN8yWkImVQ','Dirty Work - Arkins Remix',196,NULL,'https://open.spotify.com/track/6bh0MGGMNKeyjN8yWkImVQ',NULL,'1bV9UJSiCQOg5S786s2T9g','6YVMFz59CuY7ngCxTxjpxE',38,2),('6bnF93Rx87YqUBLSgjiMU8','Heartless',198,NULL,'https://open.spotify.com/track/6bnF93Rx87YqUBLSgjiMU8',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',81,7),('6bpn1BPAXOTBv14AG5EwG3','Rebellion',224,NULL,'https://open.spotify.com/track/6bpn1BPAXOTBv14AG5EwG3',NULL,'6gCLXpitNrlglz2pg7WrAN','1rpgxJZxZMLnFNc1Jmyov5',40,1),('6bqtKURdSWkInAJHDkuaL0','I\'m The Plug',180,NULL,'https://open.spotify.com/track/6bqtKURdSWkInAJHDkuaL0',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',59,7),('6bvZRLLkBKkmgpBJTTj3QK','How You Like That',180,NULL,'https://open.spotify.com/track/6bvZRLLkBKkmgpBJTTj3QK',NULL,'2gNPnKP1PDkB5SZz3IMKuX','41MozSoPIsD1dJM0CLPjZF',75,1),('6BxIcrkPEbin4OVKkVf7m1','365',185,NULL,'https://open.spotify.com/track/6BxIcrkPEbin4OVKkVf7m1',NULL,'0t98iMat2EXJthAhr844Sx','2KC9Qb60EaY0kW4eH68vr3',8,5),('6bxOENNYFWqNLsPMxy5nKi','꿈을 뺏고 있는 범인을 찾아라',222,NULL,'https://open.spotify.com/track/6bxOENNYFWqNLsPMxy5nKi',NULL,'75fZ4eJHsRFNpn4VDoQbKb','1rpgxJZxZMLnFNc1Jmyov5',4,3),('6C6fHTuFUxVtJpBOOaMvJr','Shameless',253,NULL,'https://open.spotify.com/track/6C6fHTuFUxVtJpBOOaMvJr',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',66,8),('6C8shP6brcY6EsFRpIj5tP','긴 여행 - Live',505,NULL,'https://open.spotify.com/track/6C8shP6brcY6EsFRpIj5tP',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',2,3),('6C9SwoZ5OrxcvkntgA5t8s','4pm in Calabasas',240,NULL,'https://open.spotify.com/track/6C9SwoZ5OrxcvkntgA5t8s',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',58,7),('6cblRiEGDRNZgowcm951R3','Sandra’s Rose',216,NULL,'https://open.spotify.com/track/6cblRiEGDRNZgowcm951R3',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',68,10),('6cdwquXfsPCZzau5EHoM7m','HERO - Instrumental',334,NULL,'https://open.spotify.com/track/6cdwquXfsPCZzau5EHoM7m',NULL,'7eSSfgp09p31q3tH5ziNWx','57htMBtzpppc1yoXgjbslj',18,2),('6CfrYuD3YRDYdYvH9jNtXY','No Long Talk',149,NULL,'https://open.spotify.com/track/6CfrYuD3YRDYdYvH9jNtXY',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',58,2),('6CLsZXEXaOluoSm9fmrd04','Rebellion',224,NULL,'https://open.spotify.com/track/6CLsZXEXaOluoSm9fmrd04',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',37,5),('6cS2LXKE1gsLi9V1JvwKUQ','Kiss & Tell',166,NULL,'https://open.spotify.com/track/6cS2LXKE1gsLi9V1JvwKUQ',NULL,'6TA0VcPiUH1a3tPRp3SjbC','2KC9Qb60EaY0kW4eH68vr3',35,2),('6CUKsv928uT4561qJovhhG','Hype Boy (250 Remix)',251,NULL,'https://open.spotify.com/track/6CUKsv928uT4561qJovhhG',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',55,4),('6cViXqp01e3FrAaseuiSAV','False Idols (with Lil Baby, Suzanna Son)',262,NULL,'https://open.spotify.com/track/6cViXqp01e3FrAaseuiSAV',NULL,'4q3wUuIReEjGSYzmSsxtl6','1Xyo4u8uXC1ZmMpatF05PJ',65,2),('6DCZcSspjsKoFjzjrWoCdn','God\'s Plan',198,NULL,'https://open.spotify.com/track/6DCZcSspjsKoFjzjrWoCdn',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',86,5),('6DO4hUFQKjYzyQ8sD2ovfu','Peppermint Candy - 2016 Version',273,NULL,'https://open.spotify.com/track/6DO4hUFQKjYzyQ8sD2ovfu',NULL,'2wA8OXIv1JXX9kTY2ddfR4','1rpgxJZxZMLnFNc1Jmyov5',36,1),('6DP1QaE3viq6wdUfyMdEvo','Dirty Work - English Version',180,NULL,'https://open.spotify.com/track/6DP1QaE3viq6wdUfyMdEvo',NULL,'1oJztb2MfwieRwHZ1t4NrN','6YVMFz59CuY7ngCxTxjpxE',61,3),('6EbduYTr62sSzvl36wWiFM','BLOW (with Chris Stapleton & Bruno Mars)',209,NULL,'https://open.spotify.com/track/6EbduYTr62sSzvl36wWiFM',NULL,'4uoEruXjt0APvHaSqrwqPH','0du5cEVh5yTK9QJze8zA0C',64,1),('6EDO9iiTtwNv6waLwa1UUq','POPSTAR (feat. Drake)',200,NULL,'https://open.spotify.com/track/6EDO9iiTtwNv6waLwa1UUq',NULL,'5nNtpPsSUgb9Hlb3dF1gXa','3TVXtAsR1Inumwj472S9r4',70,1),('6eJbjaoLRlfwrfWpeS6alF','Life Of The Party',296,NULL,'https://open.spotify.com/track/6eJbjaoLRlfwrfWpeS6alF',NULL,'6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',58,2),('6EW1fwOk4JHmTZKINZsyjB','B.B. King Freestyle (with Drake)',222,NULL,'https://open.spotify.com/track/6EW1fwOk4JHmTZKINZsyjB',NULL,'4Epq84TTM5hHH5jI78R271','3TVXtAsR1Inumwj472S9r4',62,1),('6fbPZpcAQLJ5xnPPKzSPWw','스토킹 (Live Version)',256,NULL,'https://open.spotify.com/track/6fbPZpcAQLJ5xnPPKzSPWw',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',1,9),('6fIYR2aSdWgQRgYmQ1Wahh','MENT 1_MEMBER GREEETING',41,NULL,'https://open.spotify.com/track/6fIYR2aSdWgQRgYmQ1Wahh',NULL,'21NNancB4Bdre5c5VRnbHk','2KC9Qb60EaY0kW4eH68vr3',12,2),('6fLVTVaHWaEfVKfEgbkf4D','Losses',271,NULL,'https://open.spotify.com/track/6fLVTVaHWaEfVKfEgbkf4D',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',59,11),('6FPQabaldvKE5cjqRfY9Os','Money Make Her Smile',203,NULL,'https://open.spotify.com/track/6FPQabaldvKE5cjqRfY9Os',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',57,9),('6fSvz9yrQY407xmr7cdjuA','Party Monster',249,NULL,'https://open.spotify.com/track/6fSvz9yrQY407xmr7cdjuA',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',52,2),('6fzio74FGqFFsenYkbGPzR','I\'m Unhappy',205,NULL,'https://open.spotify.com/track/6fzio74FGqFFsenYkbGPzR',NULL,'69xF8jTd0c4Zoo7DT3Rwrn','6YVMFz59CuY7ngCxTxjpxE',57,5),('6GEXMJbxVTh3AXxXsifEdo','Just The Two Of Us (Live Version)',295,NULL,'https://open.spotify.com/track/6GEXMJbxVTh3AXxXsifEdo',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',3,2),('6GRwto16rPuypVyb2Z5rLh','How You Like That',179,NULL,'https://open.spotify.com/track/6GRwto16rPuypVyb2Z5rLh',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',44,3),('6gSkYEONe1fCvrOUgmXZTy','Die With A Smile - Acoustic',251,NULL,'https://open.spotify.com/track/6gSkYEONe1fCvrOUgmXZTy',NULL,'5eLr5u0UcnXjtNZgbnsoYS','0du5cEVh5yTK9QJze8zA0C',66,1),('6gzR5GdZTevJT8OWW0NeGa','Kill This Love',191,NULL,'https://open.spotify.com/track/6gzR5GdZTevJT8OWW0NeGa',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',46,1),('6H0uHtgOFj6EGmnJfVwXpx','Just the Way You Are - Skrillex BatBoi Remix',229,NULL,'https://open.spotify.com/track/6H0uHtgOFj6EGmnJfVwXpx',NULL,'45K2dXJLXF4ItsTdEmbQzO','0du5cEVh5yTK9QJze8zA0C',1,1),('6hAznmvhIfHE4vSZYsyONI','LOCO',191,NULL,'https://open.spotify.com/track/6hAznmvhIfHE4vSZYsyONI',NULL,'1YsrB8P1PfVxuY9HeD7lkN','2KC9Qb60EaY0kW4eH68vr3',39,1),('6HHbjSWWGh6j9JcmLZ41Py','KICK IT - JP Ver.',191,NULL,'https://open.spotify.com/track/6HHbjSWWGh6j9JcmLZ41Py',NULL,'0uWttVLwkFxcW1PkBAsmZd','41MozSoPIsD1dJM0CLPjZF',41,3),('6hHKFReuQR9VQp39ev43wY','Outro (feat. Chilly Gonzales)',174,NULL,'https://open.spotify.com/track/6hHKFReuQR9VQp39ev43wY',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',45,16),('6Ho58vQUjGnBU9m8Z6uNcv','Tally',184,NULL,'https://open.spotify.com/track/6Ho58vQUjGnBU9m8Z6uNcv',NULL,'0S4pP8MBY9p7ngFWIZQAJv','41MozSoPIsD1dJM0CLPjZF',69,7),('6HrLsSVEk6C1X2EKmOEBxA','The Zone',418,NULL,'https://open.spotify.com/track/6HrLsSVEk6C1X2EKmOEBxA',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',55,4),('6Hs7qgX88vA6e4vYXYRw5B','Shut It Down',417,NULL,'https://open.spotify.com/track/6Hs7qgX88vA6e4vYXYRw5B',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',32,8),('6hU8kY1Pot3gvEHb9CVj3F','Scared To Live',191,NULL,'https://open.spotify.com/track/6hU8kY1Pot3gvEHb9CVj3F',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',48,4),('6hXOnR5g0O36tFFf2P0eZw','Stay Alive (with the London Symphony Orchestra)',291,NULL,'https://open.spotify.com/track/6hXOnR5g0O36tFFf2P0eZw',NULL,'73O0qUbaKCFbJ2EfZID1uo','1rpgxJZxZMLnFNc1Jmyov5',6,1),('6hYigmTwbw1OoCiSPfu9EH','Treasure - Sharam Club Remix',379,NULL,'https://open.spotify.com/track/6hYigmTwbw1OoCiSPfu9EH',NULL,'1K3oVG8AwSSs66wACKd95b','0du5cEVh5yTK9QJze8zA0C',28,1),('6i5fDaCzwxRrZtuvvcqoIf','Drive',188,NULL,'https://open.spotify.com/track/6i5fDaCzwxRrZtuvvcqoIf',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',69,18),('6ImxYXeLDQPIv4qo7bMhSk','Company',252,NULL,'https://open.spotify.com/track/6ImxYXeLDQPIv4qo7bMhSk',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',66,14),('6IskVxt4kTLI1OBqcsIRg0','Love Is Blind',249,NULL,'https://open.spotify.com/track/6IskVxt4kTLI1OBqcsIRg0',NULL,'4bXChblbwpUdYMI3hEu5IF','57htMBtzpppc1yoXgjbslj',13,4),('6j2bB0QY86xeeESfdA8Tn3','Find Us',224,NULL,'https://open.spotify.com/track/6j2bB0QY86xeeESfdA8Tn3',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',4,12),('6j6F1Y7axFvgjuiRsEQCWO','Moth To A Flame (with The Weeknd)',234,NULL,'https://open.spotify.com/track/6j6F1Y7axFvgjuiRsEQCWO',NULL,'0sye9Q82C9Q4tTJN8b0aFq','1Xyo4u8uXC1ZmMpatF05PJ',49,1),('6J7PIkhtHwmFjPLq0SyuPj','Dark Times',260,NULL,'https://open.spotify.com/track/6J7PIkhtHwmFjPLq0SyuPj',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',62,12),('6jAlVriR897wijOjOuI6rT','다시 한번',247,NULL,'https://open.spotify.com/track/6jAlVriR897wijOjOuI6rT',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',3,11),('6jDGDtQPC46pFqxph3qdbD','Until We\'re Skin & Bones',22,NULL,'https://open.spotify.com/track/6jDGDtQPC46pFqxph3qdbD',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',26,5),('6jdOi5U5LBzQrc4c1VT983','Hold On, We\'re Going Home',227,NULL,'https://open.spotify.com/track/6jdOi5U5LBzQrc4c1VT983',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',79,8),('6jfCSH3je1KU6IYlBc2vVH','We Go - Instrumental',188,NULL,'https://open.spotify.com/track/6jfCSH3je1KU6IYlBc2vVH',NULL,'2rTc5TdRP7hr7gE4h4lUR1','6YVMFz59CuY7ngCxTxjpxE',26,3),('6jGAh1bFnXt1Muj9zeHveZ','After Last Night (with Thundercat & Bootsy Collins)',249,NULL,'https://open.spotify.com/track/6jGAh1bFnXt1Muj9zeHveZ',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',68,4),('6jgUrLEivd4DaiYb1izJLF','Right Now (Instrumental)',160,NULL,'https://open.spotify.com/track/6jgUrLEivd4DaiYb1izJLF',NULL,'1FVw30SoC91lq1UZ6N9rwN','6HvZYsbFfjnjFrWF950C9d',47,4),('6jPWEBEMUkp50GA9e9GWDT','사랑보다 깊은 상처 (Feat. Ann)',281,NULL,'https://open.spotify.com/track/6jPWEBEMUkp50GA9e9GWDT',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',5,6),('6JVXVLqCPaodBSEwRFUN8w','Ditto (250 Remix)',201,NULL,'https://open.spotify.com/track/6JVXVLqCPaodBSEwRFUN8w',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',56,1),('6jy9yJfgCsMHdu2Oz4BGKX','Papi’s Home',178,NULL,'https://open.spotify.com/track/6jy9yJfgCsMHdu2Oz4BGKX',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',66,2),('6kHsOozOJ1xve7PP8ke2Xi','In the morning (English Ver.)',172,NULL,'https://open.spotify.com/track/6kHsOozOJ1xve7PP8ke2Xi',NULL,'7oibrqlZZtzsxjYDcHQjEU','2KC9Qb60EaY0kW4eH68vr3',1,1),('6Kj17Afjo1OKJYpf5VzCeo','Pain 1993 (with Playboi Carti)',149,NULL,'https://open.spotify.com/track/6Kj17Afjo1OKJYpf5VzCeo',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',75,10),('6knNhL3mIaackJvtjmUrfN','Party Monster - Live',189,NULL,'https://open.spotify.com/track/6knNhL3mIaackJvtjmUrfN',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',48,17),('6krYS8KtmNAYyb5uTZiYW4','Dawn FM',96,NULL,'https://open.spotify.com/track/6krYS8KtmNAYyb5uTZiYW4',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',57,1),('6kWxIqQDsKFYCJGbU4AjCX','Hardest To Love',211,NULL,'https://open.spotify.com/track/6kWxIqQDsKFYCJGbU4AjCX',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',67,3),('6l1dTAhX7P6EKvA11NLNuW','I\'ll Make You Cry',214,NULL,'https://open.spotify.com/track/6l1dTAhX7P6EKvA11NLNuW',NULL,'3vyyDkvYWC36DwgZCYd3Wu','6YVMFz59CuY7ngCxTxjpxE',54,3),('6L2krdgbmcdsFX9unFWv5d','묻어버린 아픔',248,NULL,'https://open.spotify.com/track/6L2krdgbmcdsFX9unFWv5d',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',9,4),('6lBwIazZrd0hGXq6HFN8YF','담배가게 아가씨',270,NULL,'https://open.spotify.com/track/6lBwIazZrd0hGXq6HFN8YF',NULL,'014jYCQMhNKWtaXPCqXoHR','1rpgxJZxZMLnFNc1Jmyov5',16,1),('6LFW4dEsLeiGluniXRgVYr','Fear Of Heights',155,NULL,'https://open.spotify.com/track/6LFW4dEsLeiGluniXRgVYr',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',51,4),('6LRLy3SmtsPJaopCiavbme','Popular (Instrumental) (with Playboi Carti & Madonna)',215,NULL,'https://open.spotify.com/track/6LRLy3SmtsPJaopCiavbme',NULL,'0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',37,4),('6LxSe8YmdPxy095Ux6znaQ','Headlines',235,NULL,'https://open.spotify.com/track/6LxSe8YmdPxy095Ux6znaQ',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',86,3),('6LXXBD3LxPqwNm9AheNmJZ','Fireworks',313,NULL,'https://open.spotify.com/track/6LXXBD3LxPqwNm9AheNmJZ',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',32,1),('6M3PsepEj5gyJoIi7Xvr7u','Take My Breath - Single Version',220,NULL,'https://open.spotify.com/track/6M3PsepEj5gyJoIi7Xvr7u',NULL,'4lBrDelXR6Sn0k54a7UWMz','1Xyo4u8uXC1ZmMpatF05PJ',58,1),('6m4ZvAgNP53HfG8YXZ1pN9','그 후',292,NULL,'https://open.spotify.com/track/6m4ZvAgNP53HfG8YXZ1pN9',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',4,7),('6MbH1QiphMCPTqVEVC7UYi','Nothings Into Somethings',153,NULL,'https://open.spotify.com/track/6MbH1QiphMCPTqVEVC7UYi',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',68,13),('6MEgCPsZ85jsMRswd0yPi9','사랑보다 깊은 상처 (Duet. Ann)',281,NULL,'https://open.spotify.com/track/6MEgCPsZ85jsMRswd0yPi9',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',22,8),('6MlGqWzDiLkZ0vmAEsisEk','The Calm',243,NULL,'https://open.spotify.com/track/6MlGqWzDiLkZ0vmAEsisEk',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',52,15),('6mmPe3Y3SEtYb9HZsHTyrj','WHEN HE\'S GONE',209,NULL,'https://open.spotify.com/track/6mmPe3Y3SEtYb9HZsHTyrj',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',71,20),('6MR5IBSNfDmiwnrlQpVw4w','Club Paradise',283,NULL,'https://open.spotify.com/track/6MR5IBSNfDmiwnrlQpVw4w',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',70,12),('6n3HGiq4v35D6eFOSwqYuo','Teenage Fever',219,NULL,'https://open.spotify.com/track/6n3HGiq4v35D6eFOSwqYuo',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',83,14),('6N8W7Dbcsg9tRDxn0wjFkR','The Hills - Live',185,NULL,'https://open.spotify.com/track/6N8W7Dbcsg9tRDxn0wjFkR',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',49,9),('6NAUMYtmSx2i9IWCcgbSrJ','I Love You',242,NULL,'https://open.spotify.com/track/6NAUMYtmSx2i9IWCcgbSrJ',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',25,14),('6nbJFllBYdd2ZKZuM5D4do','Dreamer',218,NULL,'https://open.spotify.com/track/6nbJFllBYdd2ZKZuM5D4do',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',15,19),('6NEoeBLQbOMw92qMeLfI40','WHISTLE',211,NULL,'https://open.spotify.com/track/6NEoeBLQbOMw92qMeLfI40',NULL,'0FOOodYRlj7gzh7q7IjmNZ','41MozSoPIsD1dJM0CLPjZF',77,1),('6nICBdDevG4NZysIqDFPEa','Thirsty',193,NULL,'https://open.spotify.com/track/6nICBdDevG4NZysIqDFPEa',NULL,'69xF8jTd0c4Zoo7DT3Rwrn','6YVMFz59CuY7ngCxTxjpxE',66,4),('6NwhtCYkfwWlcR62Ac4E7y','Successful (feat. Trey Songz & Lil Wayne)',375,NULL,'https://open.spotify.com/track/6NwhtCYkfwWlcR62Ac4E7y',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',62,3),('6ObpR8ek44tvWefQRcSo8K','Calling All My Lovelies',250,NULL,'https://open.spotify.com/track/6ObpR8ek44tvWefQRcSo8K',NULL,'4PgleR09JVnm3zY1fW3XBA','0du5cEVh5yTK9QJze8zA0C',64,7),('6OGogr19zPTM4BALXuMQpF','Take My Breath - Single Version',220,NULL,'https://open.spotify.com/track/6OGogr19zPTM4BALXuMQpF',NULL,'6DmXKM13nNgIIby2FdK0f8','1Xyo4u8uXC1ZmMpatF05PJ',64,1),('6ojrylBvc8SkXGjr02FjRX','The Birds Pt. 1',214,NULL,'https://open.spotify.com/track/6ojrylBvc8SkXGjr02FjRX',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',55,5),('6oLHyWvmk6bKrA91EIYZBp','Wednesday Night Interlude',212,NULL,'https://open.spotify.com/track/6oLHyWvmk6bKrA91EIYZBp',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',65,10),('6oYRgLK4B38yYy9TeTpMjn','Out of Time - Instrumental',214,NULL,'https://open.spotify.com/track/6oYRgLK4B38yYy9TeTpMjn',NULL,'6LuY3APmuxui8BM2oibkrZ','1Xyo4u8uXC1ZmMpatF05PJ',40,4),('6P8Rrx5cnxee40GPieLvhc','Like A God',226,NULL,'https://open.spotify.com/track/6P8Rrx5cnxee40GPieLvhc',NULL,'4q3wUuIReEjGSYzmSsxtl6','1Xyo4u8uXC1ZmMpatF05PJ',50,1),('6pDVjCUA3B1vg9waKutAsv','Attention',197,NULL,'https://open.spotify.com/track/6pDVjCUA3B1vg9waKutAsv',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',63,13),('6pG3yiKNsX03ZFTFWdOasv','Next',361,NULL,'https://open.spotify.com/track/6pG3yiKNsX03ZFTFWdOasv',NULL,'04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',58,8),('6pIuPm3u7QgUFAX1V0D9wY','Dopamine - GISELLE Solo',194,NULL,'https://open.spotify.com/track/6pIuPm3u7QgUFAX1V0D9wY',NULL,'4vLGHlTnlIIxMSfefCY0cU','6YVMFz59CuY7ngCxTxjpxE',66,2),('6pMDxb7SwKwiH8CVjaqkKp','스토킹',241,NULL,'https://open.spotify.com/track/6pMDxb7SwKwiH8CVjaqkKp',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',3,15),('6PQmdkH9fRdQkWaVInbwKS','Cheshire -Japanese ver.-',183,NULL,'https://open.spotify.com/track/6PQmdkH9fRdQkWaVInbwKS',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',2,10),('6PX9XFzdYQcQxikyGzQJah','Orchid',419,NULL,'https://open.spotify.com/track/6PX9XFzdYQcQxikyGzQJah',NULL,'56eyAyu9JO0vSKijY3cKPh','1rpgxJZxZMLnFNc1Jmyov5',21,2),('6Q3lFQgpvhA9VApFKLFZtZ','Strategy',168,NULL,'https://open.spotify.com/track/6Q3lFQgpvhA9VApFKLFZtZ',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',87,5),('6QdnKD1zwEgyOWtkrdzlOF','Hurt You',230,NULL,'https://open.spotify.com/track/6QdnKD1zwEgyOWtkrdzlOF',NULL,'4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',73,5),('6qVqWJxIpsabUKBILG7d6N','Welcome To MY World (feat. nævis)',206,NULL,'https://open.spotify.com/track/6qVqWJxIpsabUKBILG7d6N',NULL,'2o35lokKrBVG73xWFDEVsX','6YVMFz59CuY7ngCxTxjpxE',58,1),('6QZePG40wT3i7bIRlmauTm','Take Me Back',227,NULL,'https://open.spotify.com/track/6QZePG40wT3i7bIRlmauTm',NULL,'5aX2plzPm0m6zk4ZFuqbuI','1Xyo4u8uXC1ZmMpatF05PJ',55,2),('6R1eAccx1fnh8P5HhFzn84','TWIST & TURN (feat. Drake & PARTYNEXTDOOR)',259,NULL,'https://open.spotify.com/track/6R1eAccx1fnh8P5HhFzn84',NULL,'7iLdPmU6eUTwKsYifBQ6zb','3TVXtAsR1Inumwj472S9r4',38,1),('6R6ZoHTypt5lt68MWbzZXv','Sour Candy (with BLACKPINK)',157,NULL,'https://open.spotify.com/track/6R6ZoHTypt5lt68MWbzZXv',NULL,'6y6lP1WRfqEhv8RLy4ufZB','41MozSoPIsD1dJM0CLPjZF',66,1),('6rb3wFQ66EWR7DcPG0oEE1','We Caa Done (feat. Drake)',245,NULL,'https://open.spotify.com/track/6rb3wFQ66EWR7DcPG0oEE1',NULL,'4yJNcgX3otzDbMMyrdJBN5','3TVXtAsR1Inumwj472S9r4',61,1),('6rdkCkjk6D12xRpdMXy0I2','New Jeans',108,NULL,'https://open.spotify.com/track/6rdkCkjk6D12xRpdMXy0I2',NULL,'5V729UqvhwNOcMejx0m55I','6HvZYsbFfjnjFrWF950C9d',81,1),('6RQm1foz7qduRVaCQBZdzf','See U Later (Live)',303,NULL,'https://open.spotify.com/track/6RQm1foz7qduRVaCQBZdzf',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',31,8),('6rVCUwfnuYTAsX4P9fIdIu','Dreams Come True',204,NULL,'https://open.spotify.com/track/6rVCUwfnuYTAsX4P9fIdIu',NULL,'4Jzx0XAORPKQ3v7EaL8Ful','6YVMFz59CuY7ngCxTxjpxE',60,1),('6rZ1ZoOM1FaX3RU5FXUDlk','Winter Ahead (with PARK HYO SHIN)',234,NULL,'https://open.spotify.com/track/6rZ1ZoOM1FaX3RU5FXUDlk',NULL,'4hcghI7Io7BFdHHsiaAylg','57htMBtzpppc1yoXgjbslj',82,1),('6s64FyS9n0XYbGMLH3LOWU','Furthest Thing',267,NULL,'https://open.spotify.com/track/6s64FyS9n0XYbGMLH3LOWU',NULL,'2ZUFSbIkmFkGag000RWOpA','3TVXtAsR1Inumwj472S9r4',63,2),('6saOZuU1qAiPKfeWglYuEi','Spice',191,NULL,'https://open.spotify.com/track/6saOZuU1qAiPKfeWglYuEi',NULL,'3pp3XBxtrrNDi2kcS6mdao','2KC9Qb60EaY0kW4eH68vr3',7,6),('6sJ6EoG4vyUC1tW718ww7f','Our Night is more beautiful than your Day (Inst.)',192,NULL,'https://open.spotify.com/track/6sJ6EoG4vyUC1tW718ww7f',NULL,'31chdu7JhVd0sC9X7sURNb','6HvZYsbFfjnjFrWF950C9d',39,2),('6SKwQghsR8AISlxhcwyA9R','Marry You',230,NULL,'https://open.spotify.com/track/6SKwQghsR8AISlxhcwyA9R',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',83,6),('6tB01QHgH9YuVA8TomAzni','Or Nah - Live',101,NULL,'https://open.spotify.com/track/6tB01QHgH9YuVA8TomAzni',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,15),('6tCd8bPvYnceDG7W9M1RMk','Shut Down',175,NULL,'https://open.spotify.com/track/6tCd8bPvYnceDG7W9M1RMk',NULL,'0S4pP8MBY9p7ngFWIZQAJv','41MozSoPIsD1dJM0CLPjZF',75,2),('6tjsbysvZh8Pq8DZA5ldrn','The Knowing',342,NULL,'https://open.spotify.com/track/6tjsbysvZh8Pq8DZA5ldrn',NULL,'7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',61,9),('6tohHT5sQRMjdWHMNn190u','Wild Flower',312,NULL,'https://open.spotify.com/track/6tohHT5sQRMjdWHMNn190u',NULL,'4aLnzOsnBf5gqTDMJn3XLz','57htMBtzpppc1yoXgjbslj',44,1),('6tU4EeTSSawN9sbfAjWPX4','Hype Boy (250 Remix) (Instrumental)',251,NULL,'https://open.spotify.com/track/6tU4EeTSSawN9sbfAjWPX4',NULL,'6XRGc3GNodkhSrPwHnx1KX','6HvZYsbFfjnjFrWF950C9d',47,10),('6TZFNPSXXXBakzy5oUDQhc','Out of Time',214,NULL,'https://open.spotify.com/track/6TZFNPSXXXBakzy5oUDQhc',NULL,'6LuY3APmuxui8BM2oibkrZ','1Xyo4u8uXC1ZmMpatF05PJ',41,3),('6U3nX1tFDJ9tttibIoslFg','Dynamite',169,NULL,'https://open.spotify.com/track/6U3nX1tFDJ9tttibIoslFg',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',11,4),('6uBQ90PzdL0GfpW2evGEXd','It\'s Strange',229,NULL,'https://open.spotify.com/track/6uBQ90PzdL0GfpW2evGEXd',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',20,5),('6UgxOrbHWJeqHvh0ost7Aa','Too Much',261,NULL,'https://open.spotify.com/track/6UgxOrbHWJeqHvh0ost7Aa',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',63,12),('6Uj2XaahtYXK2WeD7GGwBY','Gasoline',212,NULL,'https://open.spotify.com/track/6Uj2XaahtYXK2WeD7GGwBY',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',49,2),('6UjfByV1lDLW0SOVQA4NAi','Gyalchester',189,NULL,'https://open.spotify.com/track/6UjfByV1lDLW0SOVQA4NAi',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',70,9),('6UkgaDUQTK0QnOhNNDtY0A','나비의 겨울',262,NULL,'https://open.spotify.com/track/6UkgaDUQTK0QnOhNNDtY0A',NULL,'6OVeP3PqCTxyGrTxKWJB7H','57htMBtzpppc1yoXgjbslj',6,1),('6uN5DrTZAG6bhPnYasfQOt','Supernova',178,NULL,'https://open.spotify.com/track/6uN5DrTZAG6bhPnYasfQOt',NULL,'6HqiFsktBxto6ushwmDOUj','6YVMFz59CuY7ngCxTxjpxE',27,2),('6UOp98xCbsrLAfSjpjdIAj','Invincible - Instrumental',211,NULL,'https://open.spotify.com/track/6UOp98xCbsrLAfSjpjdIAj',NULL,'6OZ8ZANoibZBNM7948KPjn','1rpgxJZxZMLnFNc1Jmyov5',0,2),('6uPnrBgweGOcwjFL4ItAvV','Whiplash',183,NULL,'https://open.spotify.com/track/6uPnrBgweGOcwjFL4ItAvV',NULL,'3OaW4df1SA62k0arNpn6bK','6YVMFz59CuY7ngCxTxjpxE',77,1),('6utQlfLooYsUkq5xUg3vxt','Nothing Compares - Bonus Track',222,NULL,'https://open.spotify.com/track/6utQlfLooYsUkq5xUg3vxt',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',63,15),('6V9TlCdwLeQes4FX5zxz3f','Wanderlust',306,NULL,'https://open.spotify.com/track/6V9TlCdwLeQes4FX5zxz3f',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',57,7),('6vLEVk6tX8RSMTHlwT7Ecm','Trust Me (MIDZY)',221,NULL,'https://open.spotify.com/track/6vLEVk6tX8RSMTHlwT7Ecm',NULL,'031mrCnL4e0qsf5GQdH6ER','2KC9Qb60EaY0kW4eH68vr3',15,1),('6VMnrvyjB5TpALix4Bgoqk','ＹＢ　스토리',280,NULL,'https://open.spotify.com/track/6VMnrvyjB5TpALix4Bgoqk',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',0,2),('6VpW9I9gaAHC0k20934fEb','Snowy',173,NULL,'https://open.spotify.com/track/6VpW9I9gaAHC0k20934fEb',NULL,'4iL0sqHuipLrqy4y8HRYsZ','2KC9Qb60EaY0kW4eH68vr3',14,2),('6W0FmAYWXjnUi7ltauF0og','I\'m your friend',300,NULL,'https://open.spotify.com/track/6W0FmAYWXjnUi7ltauF0og',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',27,10),('6WJTEsLxWtSIlXML3NVSzA','Regret of the Times - 2024 aespa Remake Version',171,NULL,'https://open.spotify.com/track/6WJTEsLxWtSIlXML3NVSzA',NULL,'4Nav3JE8TIOFiuY5x95MIh','6YVMFz59CuY7ngCxTxjpxE',51,1),('6wjUN6sWrP2tfisGocGKG9','Jumping To You',227,NULL,'https://open.spotify.com/track/6wjUN6sWrP2tfisGocGKG9',NULL,'1NCgEqPlo1t2jCvmjpyiqD','1rpgxJZxZMLnFNc1Jmyov5',11,11),('6wQrE3kTN0YZKXCsjOwElq','미스터리',166,NULL,'https://open.spotify.com/track/6wQrE3kTN0YZKXCsjOwElq',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',11,3),('6WzRpISELf3YglGAh7TXcG','Popular (with Playboi Carti & Madonna) - From The Idol Vol. 1 (Music from the HBO Original Series)',215,NULL,'https://open.spotify.com/track/6WzRpISELf3YglGAh7TXcG',NULL,'5O0zUvdnJr0RbWzLFneN2i','1Xyo4u8uXC1ZmMpatF05PJ',84,1),('6X82sQak20qTRvZ0YZa9qi','Yet, but (유나)',205,NULL,'https://open.spotify.com/track/6X82sQak20qTRvZ0YZa9qi',NULL,'379aiwnVtBtkphDqU2qFIg','2KC9Qb60EaY0kW4eH68vr3',11,9),('6xAYr19aF3qVOSngfe0BZS','선인장',257,NULL,'https://open.spotify.com/track/6xAYr19aF3qVOSngfe0BZS',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',4,9),('6xIsHPRHdbzU6UMVFn4wh8','First Person Shooter (feat. J. Cole)',247,NULL,'https://open.spotify.com/track/6xIsHPRHdbzU6UMVFn4wh8',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',54,6),('6XZ8C5etRn0kiS1wwuW0SO','Out of Time - Live',200,NULL,'https://open.spotify.com/track/6XZ8C5etRn0kiS1wwuW0SO',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,20),('6Yc42RxAOOGkLkRsoTHmJf','I DON’T WANNA DANCE',189,NULL,'https://open.spotify.com/track/6Yc42RxAOOGkLkRsoTHmJf',NULL,'6RP5wCF7u2WDFiuyQ0loNS','2KC9Qb60EaY0kW4eH68vr3',7,6),('6YDzHGpFbJS8JlwxnBpbkX','사랑 그 흔한 말',268,NULL,'https://open.spotify.com/track/6YDzHGpFbJS8JlwxnBpbkX',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',5,6),('6yeafctTvo9al34RfVpT3e','Armageddon - 2Spade Remix',188,NULL,'https://open.spotify.com/track/6yeafctTvo9al34RfVpT3e',NULL,'6uWbkjA7Osh3VNnnGeyfl6','6YVMFz59CuY7ngCxTxjpxE',39,3),('6Yj7Zhxt73uvwFFvzQXdxO','Flight\'s Booked',254,NULL,'https://open.spotify.com/track/6Yj7Zhxt73uvwFFvzQXdxO',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',73,9),('6YkQWC5qUEsI6omCEtljo2','해줄 수 없는 일 (Live Version)',332,NULL,'https://open.spotify.com/track/6YkQWC5qUEsI6omCEtljo2',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',1,15),('6YKT5HoPwjTwhHiCNQsBMK','Talking to the Moon - Acoustic Piano',217,NULL,'https://open.spotify.com/track/6YKT5HoPwjTwhHiCNQsBMK',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',56,12),('6YUP0VOn2P8ShAiULxSykr','Wishing For You',248,NULL,'https://open.spotify.com/track/6YUP0VOn2P8ShAiULxSykr',NULL,'7l5z6PdgRUaww549kUVeGO','57htMBtzpppc1yoXgjbslj',23,4),('6YV2AI87l1n2fzqU8Dyo05','Virginia Beach',251,NULL,'https://open.spotify.com/track/6YV2AI87l1n2fzqU8Dyo05',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',58,1),('6Z01gUquJsjJC67uNWm6P0','Shot For Me',224,NULL,'https://open.spotify.com/track/6Z01gUquJsjJC67uNWm6P0',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',74,2),('6zKlGJXteHq8KRKaLnUfCs','What You Need',206,NULL,'https://open.spotify.com/track/6zKlGJXteHq8KRKaLnUfCs',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',55,2),('6ZprqcYFC6D9eIZaCoqrSn','Gently (feat. Bad Bunny)',133,NULL,'https://open.spotify.com/track/6ZprqcYFC6D9eIZaCoqrSn',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',69,19),('6ZSUXDASDxfude4QKF7fqp','Armageddon - Flava D Remix',247,NULL,'https://open.spotify.com/track/6ZSUXDASDxfude4QKF7fqp',NULL,'6uWbkjA7Osh3VNnnGeyfl6','6YVMFz59CuY7ngCxTxjpxE',38,2),('6ZtXETPT1OYmTUyawcaYLc','어디로',288,NULL,'https://open.spotify.com/track/6ZtXETPT1OYmTUyawcaYLc',NULL,'5wybcI0Q4wJh6IJtqXqeJ6','1rpgxJZxZMLnFNc1Jmyov5',2,12),('6zzdyvVWjGrQBraSvuqJPY','Starry Eyes',148,NULL,'https://open.spotify.com/track/6zzdyvVWjGrQBraSvuqJPY',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',65,11),('6zZWoHlF2zNSLUNLvx4GUl','Better Things',203,NULL,'https://open.spotify.com/track/6zZWoHlF2zNSLUNLvx4GUl',NULL,'1SHLOv0DDdRecK60z86Lth','6YVMFz59CuY7ngCxTxjpxE',64,1),('716nouwS8Bg17xgo5Sj4Th','다시 내게로 돌아와',281,NULL,'https://open.spotify.com/track/716nouwS8Bg17xgo5Sj4Th',NULL,'26KTR4BV6sZ7jh0BxO3zIj','57htMBtzpppc1yoXgjbslj',15,7),('717s9KFmHhyy5t3xkStS56','Red Terror',231,NULL,'https://open.spotify.com/track/717s9KFmHhyy5t3xkStS56',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',67,20),('71nQb7Dvib94mk8Q9PgUUU','Run To You (Live Version)',201,NULL,'https://open.spotify.com/track/71nQb7Dvib94mk8Q9PgUUU',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',2,16),('71VKjJjn76sn5Tt8X8Ay8c','Screw The World - Interlude',112,NULL,'https://open.spotify.com/track/71VKjJjn76sn5Tt8X8Ay8c',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',45,12),('72fcuveJcHQ61u25WHQhjw','Open Hearts - Single Version',211,NULL,'https://open.spotify.com/track/72fcuveJcHQ61u25WHQhjw',NULL,'6VfBBrRc9CiWisIAoBeTqs','1Xyo4u8uXC1ZmMpatF05PJ',64,1),('72Oliqc3JRn4MddvndTh7P','먼곳에서',225,NULL,'https://open.spotify.com/track/72Oliqc3JRn4MddvndTh7P',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',26,3),('72SxWvaYsDgix2N3sjCjT1','How Do I Make You Love Me? - Live',209,NULL,'https://open.spotify.com/track/72SxWvaYsDgix2N3sjCjT1',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',46,5),('734WuFbTDxTPMU1lBP6e0M','Score Suite',180,NULL,'https://open.spotify.com/track/734WuFbTDxTPMU1lBP6e0M',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',80,12),('73IE87H0g2MBmdn41lkVto','Paris Morton Music',251,NULL,'https://open.spotify.com/track/73IE87H0g2MBmdn41lkVto',NULL,'7dqpveMVcWgbzqYrOdkFTD','3TVXtAsR1Inumwj472S9r4',65,16),('73lwp9JhdXb4a0aS6Cyses','Shine your light',255,NULL,'https://open.spotify.com/track/73lwp9JhdXb4a0aS6Cyses',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',28,2),('7470s7SMyvDU6wHH6bG1yN','편지',225,NULL,'https://open.spotify.com/track/7470s7SMyvDU6wHH6bG1yN',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',3,5),('74atKkOasLOVzvqB6mYgga','The Real Her',321,NULL,'https://open.spotify.com/track/74atKkOasLOVzvqB6mYgga',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',66,14),('74D9n9uLTLWXkfKJ6W09UV','왜 눈물만 나는지',234,NULL,'https://open.spotify.com/track/74D9n9uLTLWXkfKJ6W09UV',NULL,'5UnM35MmXsDGzNvFx5u9uO','57htMBtzpppc1yoXgjbslj',18,12),('74hOHSIvlcsnDmc1OvKg32','Dream',299,NULL,'https://open.spotify.com/track/74hOHSIvlcsnDmc1OvKg32',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',27,11),('755xxrmlLAC1WexjXYQ7Dp','Boys Like You',223,NULL,'https://open.spotify.com/track/755xxrmlLAC1WexjXYQ7Dp',NULL,'5iOt5bH6SPHqKYCPNy6Pkc','2KC9Qb60EaY0kW4eH68vr3',22,1),('759ndr57jb0URg4j9YSWml','A Tale By Quincy',96,NULL,'https://open.spotify.com/track/759ndr57jb0URg4j9YSWml',NULL,'2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',56,6),('75biajlde0kapYK9otcdVc','Light Up',274,NULL,'https://open.spotify.com/track/75biajlde0kapYK9otcdVc',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',24,10),('75FDap9b84WfutMC0nJBa6','Supernatural',188,NULL,'https://open.spotify.com/track/75FDap9b84WfutMC0nJBa6',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',16,4),('76gUmNLXGQVOsGhfcshkFP','Madiba Riddim',205,NULL,'https://open.spotify.com/track/76gUmNLXGQVOsGhfcshkFP',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',65,6),('76kyKtPLsFbQkdQ86QrkF4','Plastic Bag',202,NULL,'https://open.spotify.com/track/76kyKtPLsFbQkdQ86QrkF4',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',61,6),('76yLBykniz0SSNv0jj17M2','Starboy (feat. Daft Punk)',230,NULL,'https://open.spotify.com/track/76yLBykniz0SSNv0jj17M2',NULL,'35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',58,1),('775a936b2Vzl3fw86FaVat','OMW',233,NULL,'https://open.spotify.com/track/775a936b2Vzl3fw86FaVat',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',69,18),('7783fkueZzorVTq8G65P9K','바보 (Live Version)',357,NULL,'https://open.spotify.com/track/7783fkueZzorVTq8G65P9K',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',2,17),('78Af1SkRTxLg3fgb3Js3nV','MENT 1_OPENING',32,NULL,'https://open.spotify.com/track/78Af1SkRTxLg3fgb3Js3nV',NULL,'21NNancB4Bdre5c5VRnbHk','2KC9Qb60EaY0kW4eH68vr3',13,3),('78aURwMzynDMan7DfSWwsI','Loft Music',363,NULL,'https://open.spotify.com/track/78aURwMzynDMan7DfSWwsI',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',53,8),('78mE33YpoWqMQTwgUQRhyo','Die With A Smile',251,NULL,'https://open.spotify.com/track/78mE33YpoWqMQTwgUQRhyo',NULL,'3BQuktwdgPu30k6QSUslCr','0du5cEVh5yTK9QJze8zA0C',63,1),('78Z199FfQHt4VpnJzlYaIe','The Other Side (feat. CeeLo Green and B.o.B)',228,NULL,'https://open.spotify.com/track/78Z199FfQHt4VpnJzlYaIe',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',56,10),('79XrkTOfV1AqySNjVlygpW','Energy',181,NULL,'https://open.spotify.com/track/79XrkTOfV1AqySNjVlygpW',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',73,2),('79zebGtzDy5IszMYi2Ast9','먼곳에서 (Live Version)',173,NULL,'https://open.spotify.com/track/79zebGtzDy5IszMYi2Ast9',NULL,'4y0RwaWQvfCzYgbUrWwNl8','57htMBtzpppc1yoXgjbslj',0,11),('7a1KekmeJYAZmyIfbnQovg','천국으로 가는 버스 - Korean Version',276,NULL,'https://open.spotify.com/track/7a1KekmeJYAZmyIfbnQovg',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',12,3),('7aLwuGyYNWKnxOSWXQK88V','Dreams Come True',204,NULL,'https://open.spotify.com/track/7aLwuGyYNWKnxOSWXQK88V',NULL,'2rwRvLdjGzjSYl9AS3UbvH','6YVMFz59CuY7ngCxTxjpxE',37,9),('7anfnzisBo4Kvw625EwMLY','Comment I',115,NULL,'https://open.spotify.com/track/7anfnzisBo4Kvw625EwMLY',NULL,'3cjssumQEsRatYlYG5K86T','1rpgxJZxZMLnFNc1Jmyov5',0,2),('7aNMx0co48fxSA3CCnYUs7','Drama - Sped Up Version',184,NULL,'https://open.spotify.com/track/7aNMx0co48fxSA3CCnYUs7',NULL,'6wlo2cGnBTzluPkeMDiOy0','6YVMFz59CuY7ngCxTxjpxE',37,1),('7ANz7bzchgtFGyqbjAqyse','MENT 4_FINALE',630,NULL,'https://open.spotify.com/track/7ANz7bzchgtFGyqbjAqyse',NULL,'21NNancB4Bdre5c5VRnbHk','2KC9Qb60EaY0kW4eH68vr3',11,9),('7aqfrAY2p9BUSiupwk3svU','First Person Shooter (feat. J. Cole)',247,NULL,'https://open.spotify.com/track/7aqfrAY2p9BUSiupwk3svU',NULL,'4czdORdCWP9umpbhFXK2fW','3TVXtAsR1Inumwj472S9r4',76,6),('7aRCf5cLOFN1U7kvtChY1G','Search & Rescue',272,NULL,'https://open.spotify.com/track/7aRCf5cLOFN1U7kvtChY1G',NULL,'67WUCOjyl44d8fAFzHONjW','3TVXtAsR1Inumwj472S9r4',75,1),('7bGF2hNOP6SROacsxo1fCk','Wicked Games',325,NULL,'https://open.spotify.com/track/7bGF2hNOP6SROacsxo1fCk',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',58,5),('7bi5vk9KoY6Flkat31ViYD','Crazy Over You',161,NULL,'https://open.spotify.com/track/7bi5vk9KoY6Flkat31ViYD',NULL,'2gNPnKP1PDkB5SZz3IMKuX','41MozSoPIsD1dJM0CLPjZF',64,6),('7bmnHlBzC81MeN7NObBnJw','Sad But True',243,NULL,'https://open.spotify.com/track/7bmnHlBzC81MeN7NObBnJw',NULL,'2hBmWglh3PlaUzTrzP1meY','1rpgxJZxZMLnFNc1Jmyov5',8,1),('7bvkyTwVkylUGJvz1UMjFk','The Party & The After Party',459,NULL,'https://open.spotify.com/track/7bvkyTwVkylUGJvz1UMjFk',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',59,6),('7Cb7ti05a8UmHWirTxkSQy','Bad Girls R Us',182,NULL,'https://open.spotify.com/track/7Cb7ti05a8UmHWirTxkSQy',NULL,'3PJbTq65fNFTzXt26YEp0p','2KC9Qb60EaY0kW4eH68vr3',14,3),('7CHDUDw89DCR8vvI0yTXGa','Beautiful Restriction',232,NULL,'https://open.spotify.com/track/7CHDUDw89DCR8vvI0yTXGa',NULL,'5qHH0SHWf5yQxG4yqHnIzY','6HvZYsbFfjnjFrWF950C9d',58,1),('7cHZIHlewdmRCBmuOn4ssV','Treasure - Bailey Smalls Radio Edit',212,NULL,'https://open.spotify.com/track/7cHZIHlewdmRCBmuOn4ssV',NULL,'7yBnuW3SpMKy3EB9iU0C7p','0du5cEVh5yTK9QJze8zA0C',42,5),('7Cj2tT0m2SBeIO1PsGfk8A','Grenade - Acoustic',249,NULL,'https://open.spotify.com/track/7Cj2tT0m2SBeIO1PsGfk8A',NULL,'54DNHFsfCa7nlQFWXMg7y3','0du5cEVh5yTK9QJze8zA0C',64,4),('7cJm6ENCOTONwAMBPN1U9r','Forever Young (Live)',257,NULL,'https://open.spotify.com/track/7cJm6ENCOTONwAMBPN1U9r',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',36,2),('7ck44AbzxRnmxi0zAbw6gs','Push Off',158,NULL,'https://open.spotify.com/track/7ck44AbzxRnmxi0zAbw6gs',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',3,4),('7CLoebg1iJuvFKwfuSj6ll','Feel Free',274,NULL,'https://open.spotify.com/track/7CLoebg1iJuvFKwfuSj6ll',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',2,20),('7cvmSgYgySWSuW6nJ2qAKt','괜찮아',272,NULL,'https://open.spotify.com/track/7cvmSgYgySWSuW6nJ2qAKt',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',11,6),('7cw1tFoH677J2zytWQvh5r','SILENCE (Inst.)',205,NULL,'https://open.spotify.com/track/7cw1tFoH677J2zytWQvh5r',NULL,'3PNXlS9tggXmCm1hrlHDcQ','1rpgxJZxZMLnFNc1Jmyov5',13,2),('7CyPwkp0oE8Ro9Dd5CUDjW','One Of The Girls (with JENNIE, Lily Rose Depp)',244,NULL,'https://open.spotify.com/track/7CyPwkp0oE8Ro9Dd5CUDjW',NULL,'7tzVd1fwkxsorytCBjEJkU','1Xyo4u8uXC1ZmMpatF05PJ',94,1),('7D5ElMtI2mcfvAKo5lstZ4','The Other Day',282,NULL,'https://open.spotify.com/track/7D5ElMtI2mcfvAKo5lstZ4',NULL,'2jchmY4qmN4Zsp1L3cSFIA','57htMBtzpppc1yoXgjbslj',30,1),('7DJiHj3AaaG0Rw35sibG96','Don\'t Know What To Do',198,NULL,'https://open.spotify.com/track/7DJiHj3AaaG0Rw35sibG96',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',44,4),('7DKS0rX27cCEPsK0R6tFWS','Wasted Times',220,NULL,'https://open.spotify.com/track/7DKS0rX27cCEPsK0R6tFWS',NULL,'4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',70,3),('7DL2F2bueQycqYjqsjHYjG','MOTH BALLS',212,NULL,'https://open.spotify.com/track/7DL2F2bueQycqYjqsjHYjG',NULL,'6Rl6YoCarF2GHPSQmmFjuR','3TVXtAsR1Inumwj472S9r4',72,2),('7dLtUiDlZBpd9C18BOqfJT','My Love',358,NULL,'https://open.spotify.com/track/7dLtUiDlZBpd9C18BOqfJT',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',16,16),('7dnixpDdQlIOX1L7O0pdFM','World Class Sinner / I’m A Freak',199,NULL,'https://open.spotify.com/track/7dnixpDdQlIOX1L7O0pdFM',NULL,'6E3IPXh38G7UHLqVdfIY5h','1Xyo4u8uXC1ZmMpatF05PJ',62,2),('7dQGDSVjt1vS6BsDURjYhS','Treasure - Cash Cash Radio Mix',208,NULL,'https://open.spotify.com/track/7dQGDSVjt1vS6BsDURjYhS',NULL,'7yBnuW3SpMKy3EB9iU0C7p','0du5cEVh5yTK9QJze8zA0C',54,3),('7DrZotCVwheRlevj6tJDxZ','좋은 사람',234,NULL,'https://open.spotify.com/track/7DrZotCVwheRlevj6tJDxZ',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',5,5),('7DY756WOLyOz2Xnhw4EFiC','São Paulo (feat. Anitta)',301,NULL,'https://open.spotify.com/track/7DY756WOLyOz2Xnhw4EFiC',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',88,4),('7dYEUpcXJLDcI22m0dgmnH','Kill It',199,NULL,'https://open.spotify.com/track/7dYEUpcXJLDcI22m0dgmnH',NULL,'3OaW4df1SA62k0arNpn6bK','6YVMFz59CuY7ngCxTxjpxE',54,2),('7e7aslhXJZj4d0trBrensY','Timeless (feat. Playboi Carti)',256,NULL,'https://open.spotify.com/track/7e7aslhXJZj4d0trBrensY',NULL,'0FWdxPnncm63s91g0PkTvv','1Xyo4u8uXC1ZmMpatF05PJ',54,2),('7ED4Z1cZWZ4mFTuhzmKJ61','Hot Mess',192,NULL,'https://open.spotify.com/track/7ED4Z1cZWZ4mFTuhzmKJ61',NULL,'5RylhkCb6kzwJDokcvQZeE','6YVMFz59CuY7ngCxTxjpxE',43,1),('7EdJ8z6IBotTjO50DfzzuV','Furthest Thing',267,NULL,'https://open.spotify.com/track/7EdJ8z6IBotTjO50DfzzuV',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',64,2),('7ELPgV93FRXeOJKVljpDnL','First Love (with. Dohyun Yoon)',333,NULL,'https://open.spotify.com/track/7ELPgV93FRXeOJKVljpDnL',NULL,'2dXi7YAiDy1IVruIAu5tH8','1rpgxJZxZMLnFNc1Jmyov5',0,1),('7eYAHC0RbBF9eaqWzT34Aq','Desires (with Future)',237,NULL,'https://open.spotify.com/track/7eYAHC0RbBF9eaqWzT34Aq',NULL,'6OQ9gBfg5EXeNAEwGSs6jK','3TVXtAsR1Inumwj472S9r4',68,6),('7EyhPjrJzjx0fk2i7vUJCS','Pink Venom',186,NULL,'https://open.spotify.com/track/7EyhPjrJzjx0fk2i7vUJCS',NULL,'5bKmRG1QsggSXoHxYUnPIY','41MozSoPIsD1dJM0CLPjZF',62,1),('7F9cT6hIRhnFCYP6GKS0tf','IMY2 (with Kid Cudi)',252,NULL,'https://open.spotify.com/track/7F9cT6hIRhnFCYP6GKS0tf',NULL,'3SpBlxme9WbeQdI9kx7KAV','3TVXtAsR1Inumwj472S9r4',67,19),('7fBv7CLKzipRk6EC6TWHOB','The Hills',242,NULL,'https://open.spotify.com/track/7fBv7CLKzipRk6EC6TWHOB',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',88,5),('7fcZk7OXeFWD7DWybltVVf','Be Who You Are (Real Magic) (feat. JID, NewJeans & Camilo)',189,NULL,'https://open.spotify.com/track/7fcZk7OXeFWD7DWybltVVf',NULL,'1Pk1W5xbmAqG6wBNL4sjq5','6HvZYsbFfjnjFrWF950C9d',56,1),('7FeSiBUEyqxlKvjGbfwKku','Tears In The Rain',444,NULL,'https://open.spotify.com/track/7FeSiBUEyqxlKvjGbfwKku',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',50,10),('7fKRGSEsy6Y5e1gE7trjAv','Next Level - Lionclad Remix',225,NULL,'https://open.spotify.com/track/7fKRGSEsy6Y5e1gE7trjAv',NULL,'36cJnr7GCuGbuw0YQpjmTY','6YVMFz59CuY7ngCxTxjpxE',33,3),('7fqjqOu4HKTN2yP6aV8lpQ','DDU-DU DDU-DU - JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',207,NULL,'https://open.spotify.com/track/7fqjqOu4HKTN2yP6aV8lpQ',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',41,1),('7fscJhHWqkZOHEaZf2yHek','상남자',245,NULL,'https://open.spotify.com/track/7fscJhHWqkZOHEaZf2yHek',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',13,5),('7Fws24pbVO8RqDMTCbOU7b','난 나를 사랑할 줄 몰랐습니다',320,NULL,'https://open.spotify.com/track/7Fws24pbVO8RqDMTCbOU7b',NULL,'6ULNJ3uohkBFzsHLowkS12','1rpgxJZxZMLnFNc1Jmyov5',3,5),('7G0by64JaYIEnkFqDb1cZ6','Locked out of Heaven - CAZZETTE\'s Answering Machine Mix',401,NULL,'https://open.spotify.com/track/7G0by64JaYIEnkFqDb1cZ6',NULL,'2vf1K6KumbRZnRHa1JeKyD','0du5cEVh5yTK9QJze8zA0C',33,1),('7g1AgkH6Yl566hdrb2b9km','Untruth',240,NULL,'https://open.spotify.com/track/7g1AgkH6Yl566hdrb2b9km',NULL,'6j5wyAhR4ijdLQfJrYDkNN','1rpgxJZxZMLnFNc1Jmyov5',0,2),('7G7mSV4BebkoHWwKTDvXu9','Winter Ahead (with PARK HYO SHIN)',234,NULL,'https://open.spotify.com/track/7G7mSV4BebkoHWwKTDvXu9',NULL,'4sfwHIxFU5kcDqSdMENQsy','57htMBtzpppc1yoXgjbslj',84,1),('7GB0eMFLxuwS8eu22NvOEJ','KIDDING ME',213,NULL,'https://open.spotify.com/track/7GB0eMFLxuwS8eu22NvOEJ',NULL,'4WnNx3UFK6RtaY3HezgC8E','2KC9Qb60EaY0kW4eH68vr3',12,3),('7gCFW1KSX4gDgAhro23URU','In Your Eyes',237,NULL,'https://open.spotify.com/track/7gCFW1KSX4gDgAhro23URU',NULL,'742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',50,10),('7GeTsDIc5ykNB6lORO6Cee','Circo Loco',236,NULL,'https://open.spotify.com/track/7GeTsDIc5ykNB6lORO6Cee',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',71,9),('7gNB9Xa5NBY2Y8tFmpOlwk','Seeing Green (with Drake & Lil Wayne)',339,NULL,'https://open.spotify.com/track/7gNB9Xa5NBY2Y8tFmpOlwk',NULL,'4o2xz4a9BjYCHh2xfYH50t','3TVXtAsR1Inumwj472S9r4',44,1),('7gSjRw3wKuTeDdM0lwp9rv','Professional',368,NULL,'https://open.spotify.com/track/7gSjRw3wKuTeDdM0lwp9rv',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',48,1),('7Gvjyorf9YUq4RgJ3hAYuk','행복한가요',280,NULL,'https://open.spotify.com/track/7Gvjyorf9YUq4RgJ3hAYuk',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',10,15),('7gyMqraZYOpfxiKesSMK04','The Lullaby',95,NULL,'https://open.spotify.com/track/7gyMqraZYOpfxiKesSMK04',NULL,'0bWcrwRhhxMaweFaBA8G1S','57htMBtzpppc1yoXgjbslj',13,14),('7h2fuB9cDFhdq9q3DsjiwY','Cheshire',182,NULL,'https://open.spotify.com/track/7h2fuB9cDFhdq9q3DsjiwY',NULL,'4iL0sqHuipLrqy4y8HRYsZ','2KC9Qb60EaY0kW4eH68vr3',33,1),('7H3cuCPaX9WHZXQ0Q9RlxH','Popular (Sped Up) (with Playboi Carti & Madonna)',187,NULL,'https://open.spotify.com/track/7H3cuCPaX9WHZXQ0Q9RlxH',NULL,'0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',50,2),('7hCNBVRhHzcsRAv0TQnOzq','Runaway Baby',148,NULL,'https://open.spotify.com/track/7hCNBVRhHzcsRAv0TQnOzq',NULL,'6J84szYCnMfzEcvIcfWMFL','0du5cEVh5yTK9QJze8zA0C',75,4),('7Hg27Pwfh9iTgHUdGS5rTx','Just the Way You Are - Carl Louis & Martin Danielle Club Mix',319,NULL,'https://open.spotify.com/track/7Hg27Pwfh9iTgHUdGS5rTx',NULL,'7BzP09BlvvE4ioNgvdLrdm','0du5cEVh5yTK9QJze8zA0C',32,3),('7HjK2whApIuUgRVP8akqjk','Grenade - Passion Pit Remix',370,NULL,'https://open.spotify.com/track/7HjK2whApIuUgRVP8akqjk',NULL,'54DNHFsfCa7nlQFWXMg7y3','0du5cEVh5yTK9QJze8zA0C',50,3),('7HK0ZDEsW0lGKKIVYvni2z','After Hours - Live',267,NULL,'https://open.spotify.com/track/7HK0ZDEsW0lGKKIVYvni2z',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',51,19),('7HLn9FW7A3XPb5JVYN1090','Dancing In The Flames - Live from São Paulo',312,NULL,'https://open.spotify.com/track/7HLn9FW7A3XPb5JVYN1090',NULL,'7GHiMUbLhh67dWSN1xGUcP','1Xyo4u8uXC1ZmMpatF05PJ',46,1),('7hNt3FV7cxcagH4TSWaHze','It`s You',231,NULL,'https://open.spotify.com/track/7hNt3FV7cxcagH4TSWaHze',NULL,'2nT4Iz2CKZNpHE4E9tEFwD','57htMBtzpppc1yoXgjbslj',29,1),('7hRlTK3mgFTBEjX7DjqBsI','Overdrive',202,NULL,'https://open.spotify.com/track/7hRlTK3mgFTBEjX7DjqBsI',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',62,10),('7HrMyzQE6fFdjuagqrcBlY','Fancy',319,NULL,'https://open.spotify.com/track/7HrMyzQE6fFdjuagqrcBlY',NULL,'6cBEXcGAITJteTAkbSneXd','3TVXtAsR1Inumwj472S9r4',39,7),('7hucY2CNu0KJALIU2nMXbb','TENNIS (0:0)',219,NULL,'https://open.spotify.com/track/7hucY2CNu0KJALIU2nMXbb',NULL,'4WnNx3UFK6RtaY3HezgC8E','2KC9Qb60EaY0kW4eH68vr3',9,6),('7HX1VOiPj1oMlgZ3OQ92B6','Intro - Live',95,NULL,'https://open.spotify.com/track/7HX1VOiPj1oMlgZ3OQ92B6',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',44,1),('7hxvMTEUOXEKDZ3nnUqbdJ','We Go',188,NULL,'https://open.spotify.com/track/7hxvMTEUOXEKDZ3nnUqbdJ',NULL,'2rTc5TdRP7hr7gE4h4lUR1','6YVMFz59CuY7ngCxTxjpxE',54,1),('7J1P951xPFJa07HNTDnmxy','ICY',191,NULL,'https://open.spotify.com/track/7J1P951xPFJa07HNTDnmxy',NULL,'2tj99zihwANHtqmEC2QpCn','2KC9Qb60EaY0kW4eH68vr3',36,1),('7J2orRXjH1Y2vkCA7zEIhW','SUPERPOWERS - inst.',175,NULL,'https://open.spotify.com/track/7J2orRXjH1Y2vkCA7zEIhW',NULL,'1atx6ADNPFNf3PKvBiSa6l','2KC9Qb60EaY0kW4eH68vr3',15,2),('7JeEzyBLiEDw9PDNczZ85h','Please',221,NULL,'https://open.spotify.com/track/7JeEzyBLiEDw9PDNczZ85h',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',18,13),('7jGr8wzgwOVLuktY66qM5f','The Town',307,NULL,'https://open.spotify.com/track/7jGr8wzgwOVLuktY66qM5f',NULL,'3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',57,2),('7jKNxYzPFGDWEemcRVebLb','Drew A Picasso',262,NULL,'https://open.spotify.com/track/7jKNxYzPFGDWEemcRVebLb',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',54,13),('7jrfvMNEXE71RN1CpdawGl','우린 짝패다!',90,NULL,'https://open.spotify.com/track/7jrfvMNEXE71RN1CpdawGl',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',3,1),('7jslhIiELQkgW9IHeYNOWE','Big Rings',217,NULL,'https://open.spotify.com/track/7jslhIiELQkgW9IHeYNOWE',NULL,'1ozpmkWcCHwsQ4QTnxOOdT','3TVXtAsR1Inumwj472S9r4',60,2),('7JXZq0JgG2zTrSOAgY8VMC','Jungle',320,NULL,'https://open.spotify.com/track/7JXZq0JgG2zTrSOAgY8VMC',NULL,'0ptlfJfwGTy0Yvrk14JK1I','3TVXtAsR1Inumwj472S9r4',75,16),('7Kd39JsnLyJLEXNeWUi3T9','Thursday',320,NULL,'https://open.spotify.com/track/7Kd39JsnLyJLEXNeWUi3T9',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',51,3),('7KeE0mNu7ONWN4xTWtwt4Q','친구',273,NULL,'https://open.spotify.com/track/7KeE0mNu7ONWN4xTWtwt4Q',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',0,7),('7kJyHFVVZMv1wQYRU9de9d','Timeless (feat. Playboi Carti & Doechii) - Remix',228,NULL,'https://open.spotify.com/track/7kJyHFVVZMv1wQYRU9de9d',NULL,'0FWdxPnncm63s91g0PkTvv','1Xyo4u8uXC1ZmMpatF05PJ',75,1),('7kkTxGgEzFzNVMORmTN06P','Shout Asia',298,NULL,'https://open.spotify.com/track/7kkTxGgEzFzNVMORmTN06P',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',0,12),('7KU3A1fotuV0GXY1doHFT8','사랑인가 봐 Love, Maybe',185,NULL,'https://open.spotify.com/track/7KU3A1fotuV0GXY1doHFT8',NULL,'14JkAa6IiFaOh5s0nMyMU9','2yNNYQBChuox9A5Ka93BIn',83,10),('7KxWAxnc5v27PO8YyhySn8','Better Things - Tropkillaz Remix',180,NULL,'https://open.spotify.com/track/7KxWAxnc5v27PO8YyhySn8',NULL,'05K5RSyTasOI8cQTFHhTLS','6YVMFz59CuY7ngCxTxjpxE',35,1),('7l2nxyx7IkBX5orhkALg0V','Privileged Rappers',160,NULL,'https://open.spotify.com/track/7l2nxyx7IkBX5orhkALg0V',NULL,'5MS3MvWHJ3lOZPLiMxzOU6','3TVXtAsR1Inumwj472S9r4',71,5),('7LgNjQL79QIxTpYOJ4c0R2','YOU & I + ONLY LOOK AT ME (Live)',190,NULL,'https://open.spotify.com/track/7LgNjQL79QIxTpYOJ4c0R2',NULL,'08ou14V2A0NWpvq7QkUWbM','41MozSoPIsD1dJM0CLPjZF',42,5),('7LOV1wyhrT7XjFgbz5sJ88','Dreams Come True - Instrumental',204,NULL,'https://open.spotify.com/track/7LOV1wyhrT7XjFgbz5sJ88',NULL,'4Jzx0XAORPKQ3v7EaL8Ful','6YVMFz59CuY7ngCxTxjpxE',38,2),('7lR5trNlnfQ60CW8he96yt','Talk to Me',218,NULL,'https://open.spotify.com/track/7lR5trNlnfQ60CW8he96yt',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',3,9),('7LrJvgTAuXnRgJvnsrHx57','Close My Eyes',278,NULL,'https://open.spotify.com/track/7LrJvgTAuXnRgJvnsrHx57',NULL,'3V7QIawybrAdBFNgS4ba6X','57htMBtzpppc1yoXgjbslj',12,7),('7LT5HRxYa3QGKibJfdhDh6','As If It\'s Your Last',223,NULL,'https://open.spotify.com/track/7LT5HRxYa3QGKibJfdhDh6',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',42,13),('7lXOqE38eCr979gp27O5wr','If I Knew',132,NULL,'https://open.spotify.com/track/7lXOqE38eCr979gp27O5wr',NULL,'58ufpQsJ1DS5kq4hhzQDiI','0du5cEVh5yTK9QJze8zA0C',69,10),('7MjSipTto9QljYzZnloXOn','Views',311,NULL,'https://open.spotify.com/track/7MjSipTto9QljYzZnloXOn',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',64,19),('7mPoCVGP752A5DtHf1SKkM','Say What\'s Real',230,NULL,'https://open.spotify.com/track/7mPoCVGP752A5DtHf1SKkM',NULL,'1LShhEEKRT5MNPcO7jtYHh','3TVXtAsR1Inumwj472S9r4',56,8),('7MwYXhh2dTqc7fiwkwPZo1','Crocodile Tears',182,NULL,'https://open.spotify.com/track/7MwYXhh2dTqc7fiwkwPZo1',NULL,'10SppFk45za4CHPEiiuQaD','1Xyo4u8uXC1ZmMpatF05PJ',43,3),('7MXVkk9YMctZqd1Srtv4MB','Starboy',230,NULL,'https://open.spotify.com/track/7MXVkk9YMctZqd1Srtv4MB',NULL,'2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',92,1),('7n3BFJwucmfA5pPMtEoNKb','그것만이 내 세상 - Live',531,NULL,'https://open.spotify.com/track/7n3BFJwucmfA5pPMtEoNKb',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',6,1),('7nEHTOQJqKCx7Dvgng3l8t','Die With A Smile',251,NULL,'https://open.spotify.com/track/7nEHTOQJqKCx7Dvgng3l8t',NULL,'29uwnLOApt6HvRw3Ll83vG','0du5cEVh5yTK9QJze8zA0C',57,1),('7nexXM8SDFu9TJ8CzVANKE','열아홉',211,NULL,'https://open.spotify.com/track/7nexXM8SDFu9TJ8CzVANKE',NULL,'20NFMkVsRGm7WpID420oTQ','1rpgxJZxZMLnFNc1Jmyov5',11,10),('7noW8HUez2ndOvFq5kBD1S','나비의 겨울',262,NULL,'https://open.spotify.com/track/7noW8HUez2ndOvFq5kBD1S',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',23,1),('7oDd86yk8itslrA9HRP2ki','Die For You - Remix',232,NULL,'https://open.spotify.com/track/7oDd86yk8itslrA9HRP2ki',NULL,'6Exo0MYoL3XammoTDeihFy','1Xyo4u8uXC1ZmMpatF05PJ',76,1),('7oEfuMrKMK9WXx1dXyv6em','You & Me',279,NULL,'https://open.spotify.com/track/7oEfuMrKMK9WXx1dXyv6em',NULL,'42sfDq59SJCXfzBduOJlzA','57htMBtzpppc1yoXgjbslj',2,7),('7oSjDQf4kkFTxWWgdrgy3h','Regret of the Times (2024 aespa Remake Version) - Instrumental',171,NULL,'https://open.spotify.com/track/7oSjDQf4kkFTxWWgdrgy3h',NULL,'4Nav3JE8TIOFiuY5x95MIh','6YVMFz59CuY7ngCxTxjpxE',29,2),('7p2wRa4m9KVXEXUlkJLhUi','I Heard You\'re Married (feat. Lil Wayne)',263,NULL,'https://open.spotify.com/track/7p2wRa4m9KVXEXUlkJLhUi',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',45,14),('7p6lEaIvj7VhG4RSn4daIq','왕관 쓴 바보',202,NULL,'https://open.spotify.com/track/7p6lEaIvj7VhG4RSn4daIq',NULL,'6ZvAEVWfmlycs7w7ICS95k','1rpgxJZxZMLnFNc1Jmyov5',1,1),('7pJcMkVanPZDqWrF7Rxml6','Breath',284,NULL,'https://open.spotify.com/track/7pJcMkVanPZDqWrF7Rxml6',NULL,'6ceHoTiPm8m5gera0XdBOW','57htMBtzpppc1yoXgjbslj',45,9),('7pjJBo6DULg6YK66PA8v7r','Own It',251,NULL,'https://open.spotify.com/track/7pjJBo6DULg6YK66PA8v7r',NULL,'1XslIirSxfAhhxRdn4Li9t','3TVXtAsR1Inumwj472S9r4',58,5),('7pqKvKrPK0ZVyGQjWBReXR','하루살이',227,NULL,'https://open.spotify.com/track/7pqKvKrPK0ZVyGQjWBReXR',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',4,17),('7pt16OMGqeqivEeI1PzkfC','STAY - Remix / JP Ver./ BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME-',224,NULL,'https://open.spotify.com/track/7pt16OMGqeqivEeI1PzkfC',NULL,'7J4ASJD3IvdANlrPkmeVP0','41MozSoPIsD1dJM0CLPjZF',38,3),('7pxDPXacBRqfV0ZGh9WtFD','그 후',293,NULL,'https://open.spotify.com/track/7pxDPXacBRqfV0ZGh9WtFD',NULL,'2m4QXzB2MdqvFNnpPx4YnQ','57htMBtzpppc1yoXgjbslj',12,4),('7q9Sr5kCkha0L49GAQctHl','Every Angel is Terrifying',167,NULL,'https://open.spotify.com/track/7q9Sr5kCkha0L49GAQctHl',NULL,'12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',43,12),('7qmvLmX9tyaTiBAVNI6YEn','PLAYING WITH FIRE',197,NULL,'https://open.spotify.com/track/7qmvLmX9tyaTiBAVNI6YEn',NULL,'2Fna4Tb7fme5aHsNMJtVtp','41MozSoPIsD1dJM0CLPjZF',77,1),('7rC5Pl8rQSX4myONQHYPBK','Mob Ties',205,NULL,'https://open.spotify.com/track/7rC5Pl8rQSX4myONQHYPBK',NULL,'1ATL5GLyefJaxhQzSPVrLX','3TVXtAsR1Inumwj472S9r4',69,8),('7rVmzyFA7f4rNGl9onF21E','Take Me Back To LA',253,NULL,'https://open.spotify.com/track/7rVmzyFA7f4rNGl9onF21E',NULL,'3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',72,15),('7s5wLBop2stFi3ESiULbeO','먼 훗날',233,NULL,'https://open.spotify.com/track/7s5wLBop2stFi3ESiULbeO',NULL,'5n7H2BKGE34RggAeZOFbin','1rpgxJZxZMLnFNc1Jmyov5',20,5),('7sBwAWyXfiIgrYQ8BaJESH','Keep The Family Close',328,NULL,'https://open.spotify.com/track/7sBwAWyXfiIgrYQ8BaJESH',NULL,'40GMAhriYJRO1rsY4YdrZb','3TVXtAsR1Inumwj472S9r4',65,1),('7skxtd9x0d05fjz4D7w3t2','Sacrifice - Live',263,NULL,'https://open.spotify.com/track/7skxtd9x0d05fjz4D7w3t2',NULL,'1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',48,4),('7sT7kZEYd1MrmzLLIRVZas','Calling My Name',129,NULL,'https://open.spotify.com/track/7sT7kZEYd1MrmzLLIRVZas',NULL,'3cf4iSSKd8ffTncbtKljXw','3TVXtAsR1Inumwj472S9r4',63,6),('7suB6D6uKX5DfPukdGaz0W','Fly As Me',219,NULL,'https://open.spotify.com/track/7suB6D6uKX5DfPukdGaz0W',NULL,'4VZ7jhV0wHpoNPCB7Vmiml','0du5cEVh5yTK9QJze8zA0C',61,3),('7szuecWAPwGoV1e5vGu8tl','In Your Eyes',237,NULL,'https://open.spotify.com/track/7szuecWAPwGoV1e5vGu8tl',NULL,'4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',78,10),('7t1lBIr3WIEtqQEOdZFMUf','Look What You\'ve Done',301,NULL,'https://open.spotify.com/track/7t1lBIr3WIEtqQEOdZFMUf',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',74,15),('7tHM0tYPQkgqFX3lGMz8qb','엄마의 노래',203,NULL,'https://open.spotify.com/track/7tHM0tYPQkgqFX3lGMz8qb',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',3,12),('7ttkH1wGR3R3llS9txSgY3','깃발 - Live',230,NULL,'https://open.spotify.com/track/7ttkH1wGR3R3llS9txSgY3',NULL,'4lAdPVMD5IK4JrTkiQoaRf','1rpgxJZxZMLnFNc1Jmyov5',0,3),('7udsBKuqnJ5csWTAkR0vEI','We\'ll Be Fine',247,NULL,'https://open.spotify.com/track/7udsBKuqnJ5csWTAkR0vEI',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',62,9),('7uHF03xE84sQ5PicRNH3yu','Members Only (feat. PARTYNEXTDOOR)',277,NULL,'https://open.spotify.com/track/7uHF03xE84sQ5PicRNH3yu',NULL,'4Q7cRXio6mF2ImVUCcezPO','3TVXtAsR1Inumwj472S9r4',52,14),('7uJH0YdSZL6psjxI6Xy08b','Acquainted',348,NULL,'https://open.spotify.com/track/7uJH0YdSZL6psjxI6Xy08b',NULL,'0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',75,6),('7uVKvaDWDpss7Ldj9kypLX','Gorilla (feat. R. Kelly and Pharrell) - G-Mix',265,NULL,'https://open.spotify.com/track/7uVKvaDWDpss7Ldj9kypLX',NULL,'07OCQAUAQaZmKORKt2StFm','0du5cEVh5yTK9QJze8zA0C',48,1),('7v1X2PGU3uZXu7tzFTTsSh','Black Mamba',174,NULL,'https://open.spotify.com/track/7v1X2PGU3uZXu7tzFTTsSh',NULL,'2rwRvLdjGzjSYl9AS3UbvH','6YVMFz59CuY7ngCxTxjpxE',42,7),('7vZr8pndLknGVHsiRggr7w','Free Fall',179,NULL,'https://open.spotify.com/track/7vZr8pndLknGVHsiRggr7w',NULL,'0t98iMat2EXJthAhr844Sx','2KC9Qb60EaY0kW4eH68vr3',9,4),('7woEDtme8YkFiWeyiinIjy','New Jeans',108,NULL,'https://open.spotify.com/track/7woEDtme8YkFiWeyiinIjy',NULL,'4N1fROq2oeyLGAlQ1C1j18','6HvZYsbFfjnjFrWF950C9d',65,1),('7wPTyxE1PNemZuyuOOaQ8q','The Morning',314,NULL,'https://open.spotify.com/track/7wPTyxE1PNemZuyuOOaQ8q',NULL,'2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',65,4),('7x1SmtU8ggofPXnqPCgnK8','SHOOT!',139,NULL,'https://open.spotify.com/track/7x1SmtU8ggofPXnqPCgnK8',NULL,'4WnNx3UFK6RtaY3HezgC8E','2KC9Qb60EaY0kW4eH68vr3',21,5),('7xcqbjV2NfxlnJzqdRuO7E','Odd Look',252,NULL,'https://open.spotify.com/track/7xcqbjV2NfxlnJzqdRuO7E',NULL,'6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',57,12),('7xgYvziLsxNd0UznaEw8Oi','Gone',486,NULL,'https://open.spotify.com/track/7xgYvziLsxNd0UznaEw8Oi',NULL,'6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',54,7),('7xUr4wLAxiez3rwWzvhMlE','꿈은 내곁에',236,NULL,'https://open.spotify.com/track/7xUr4wLAxiez3rwWzvhMlE',NULL,'4S5PRo1gVG9BvRnCcdYzdS','1rpgxJZxZMLnFNc1Jmyov5',3,12),('7y6c07pgjZvtHI9kuMVqk1','Get It Together',250,NULL,'https://open.spotify.com/track/7y6c07pgjZvtHI9kuMVqk1',NULL,'1lXY618HWkwYKJWBRYR4MK','3TVXtAsR1Inumwj472S9r4',77,5),('7yAy2gL2rtatS56jzkakhr','SOLO',165,NULL,'https://open.spotify.com/track/7yAy2gL2rtatS56jzkakhr',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',54,8),('7ycJMzTmqClQdZsWdWxC3v','Stay Alive - B.K Remix',218,NULL,'https://open.spotify.com/track/7ycJMzTmqClQdZsWdWxC3v',NULL,'1XEhQ2S7OHDa9Zm635Jyww','1rpgxJZxZMLnFNc1Jmyov5',0,1),('7yfg0Eer6UZZt5tZ1XdsWz','Make Me Proud',219,NULL,'https://open.spotify.com/track/7yfg0Eer6UZZt5tZ1XdsWz',NULL,'6X1x82kppWZmDzlXXK3y3q','3TVXtAsR1Inumwj472S9r4',70,10),('7yJktKsS9pNnEpwZWTdX5C','Girls - Minit Remix',222,NULL,'https://open.spotify.com/track/7yJktKsS9pNnEpwZWTdX5C',NULL,'2jK7H4A5Y2xJaoOyzBedaS','6YVMFz59CuY7ngCxTxjpxE',34,2),('7yoHYSunDSmdYrORIOYVHX','Stories About My Brother - Instrumental',264,NULL,'https://open.spotify.com/track/7yoHYSunDSmdYrORIOYVHX',NULL,'3CHCm9n05a3tG4cQJ4rJwq','3TVXtAsR1Inumwj472S9r4',30,2),('7zNS5065xzKyhOBMOj7pCr','One Of The Girls - Instrumental',244,NULL,'https://open.spotify.com/track/7zNS5065xzKyhOBMOj7pCr',NULL,'4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',54,4),('7zoCEGc64EHQiCtpOgxnrT','꿈꾸는 소녀 Two',263,NULL,'https://open.spotify.com/track/7zoCEGc64EHQiCtpOgxnrT',NULL,'2yupj6Bwjo1m6Jew5uscif','1rpgxJZxZMLnFNc1Jmyov5',2,11),('7zYINyILSPRlfVbV78rUI0','박하사탕２FEAT. DRUNKEN TIGER',296,NULL,'https://open.spotify.com/track/7zYINyILSPRlfVbV78rUI0',NULL,'0XgLshUzeE1QsmAKUyqZSc','1rpgxJZxZMLnFNc1Jmyov5',0,5),('7zZb7Eh3OcB1JPEHvf0Lyw','BOOMBAYAH',173,NULL,'https://open.spotify.com/track/7zZb7Eh3OcB1JPEHvf0Lyw',NULL,'3l1V6pEtFQLpbfAyfrSWhW','41MozSoPIsD1dJM0CLPjZF',42,14);
/*!40000 ALTER TABLE `track` ENABLE KEYS */;

--
-- Table structure for table `track_mood_vote`
--

DROP TABLE IF EXISTS `track_mood_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `track_mood_vote` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `track_id` varchar(200) NOT NULL,
  `mood` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`track_id`),
  KEY `FK_track_TO_track_mood_vote_1` (`track_id`),
  KEY `FK_tag_TO_track_mood_vote_1` (`mood`),
  CONSTRAINT `FK_tag_TO_track_mood_vote_1` FOREIGN KEY (`mood`) REFERENCES `tag` (`id`),
  CONSTRAINT `FK_track_TO_track_mood_vote_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`),
  CONSTRAINT `FK_user_TO_track_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track_mood_vote`
--

/*!40000 ALTER TABLE `track_mood_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `track_mood_vote` ENABLE KEYS */;

--
-- Table structure for table `track_review`
--

DROP TABLE IF EXISTS `track_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `track_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rating` int NOT NULL,
  `content` text NOT NULL,
  `blinded` tinyint(1) NOT NULL,
  `likes` int NOT NULL DEFAULT '0',
  `dislikes` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `critic` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  `track_id` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_track` (`user_id`,`track_id`),
  KEY `FK_track_TO_track_review_1` (`track_id`),
  CONSTRAINT `FK_track_TO_track_review_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`),
  CONSTRAINT `FK_user_TO_track_review_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track_review`
--

/*!40000 ALTER TABLE `track_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `track_review` ENABLE KEYS */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nickname` varchar(100) NOT NULL,
  `profile_image` varchar(200) NOT NULL DEFAULT '/img/profileImg.png',
  `bio` text,
  `is_pro` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `ban` tinyint(1) NOT NULL DEFAULT '0' COMMENT '회원 제재 여부',
  `ban_reason` varchar(255) DEFAULT NULL COMMENT '제재 사유',
  `ban_at` timestamp NULL DEFAULT NULL COMMENT '제재 일시',
  `provider` varchar(200) DEFAULT NULL,
  `provider_id` varchar(200) DEFAULT NULL,
  `current_badge` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_username` (`username`),
  KEY `FK_use_badge_TO_user` (`current_badge`),
  CONSTRAINT `FK_use_badge_TO_user` FOREIGN KEY (`current_badge`) REFERENCES `user_badge` (`badge_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

--
-- Table structure for table `user_activity_log`
--

DROP TABLE IF EXISTS `user_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_activity_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(50) NOT NULL,
  `target_type` varchar(50) DEFAULT NULL,
  `target_id` bigint DEFAULT NULL,
  `detail` text,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `created_at` datetime NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_user_activity_log_1` (`user_id`),
  CONSTRAINT `FK_user_TO_user_activity_log_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_activity_log`
--

/*!40000 ALTER TABLE `user_activity_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_activity_log` ENABLE KEYS */;

--
-- Table structure for table `user_auth`
--

DROP TABLE IF EXISTS `user_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_auth` (
  `no` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `auth` varchar(100) NOT NULL,
  PRIMARY KEY (`no`),
  KEY `FK_user_TO_user_auth` (`username`),
  CONSTRAINT `FK_user_TO_user_auth` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_auth`
--

/*!40000 ALTER TABLE `user_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_auth` ENABLE KEYS */;

--
-- Table structure for table `user_badge`
--

DROP TABLE IF EXISTS `user_badge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_badge` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` bigint NOT NULL,
  `badge_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_badge` (`user_id`,`badge_id`),
  KEY `FK_badge_TO_user_badge_1` (`badge_id`),
  CONSTRAINT `FK_badge_TO_user_badge_1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user_TO_user_badge_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_badge`
--

/*!40000 ALTER TABLE `user_badge` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_badge` ENABLE KEYS */;

--
-- Table structure for table `user_badge_log`
--

DROP TABLE IF EXISTS `user_badge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_badge_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `badge_id` bigint NOT NULL,
  `action` varchar(10) NOT NULL,
  `actor_id` bigint DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ubl_user_badge_created` (`user_id`,`badge_id`,`created_at`),
  KEY `FK_ubl_badge` (`badge_id`),
  KEY `FK_ubl_actor` (`actor_id`),
  CONSTRAINT `FK_ubl_actor` FOREIGN KEY (`actor_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_ubl_badge` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ubl_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_badge_log`
--

/*!40000 ALTER TABLE `user_badge_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_badge_log` ENABLE KEYS */;

--
-- Table structure for table `user_follow`
--

DROP TABLE IF EXISTS `user_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_follow` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `follower_id` bigint NOT NULL,
  `following_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `follower_id` (`follower_id`,`following_id`),
  UNIQUE KEY `UK_following_and_follower` (`follower_id`,`following_id`),
  KEY `FK_user_TO_user_follow_2` (`following_id`),
  CONSTRAINT `FK_user_TO_user_follow_1` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user_TO_user_follow_2` FOREIGN KEY (`following_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_follow`
--

/*!40000 ALTER TABLE `user_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_follow` ENABLE KEYS */;

--
-- Table structure for table `user_notification`
--

DROP TABLE IF EXISTS `user_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_notification` (
  `user_id` bigint NOT NULL,
  `type` enum('comment','mention','like','follow','reply','badge','qna','announcement','system') NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`type`),
  UNIQUE KEY `UK_user_type` (`user_id`,`type`),
  CONSTRAINT `FK_user_TO_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_notification`
--

/*!40000 ALTER TABLE `user_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_notification` ENABLE KEYS */;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assigned_at` datetime NOT NULL,
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_user_role_1` (`user_id`),
  KEY `FK_role_TO_user_role_1` (`role_id`),
  CONSTRAINT `FK_role_TO_user_role_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `FK_user_TO_user_role_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;

--
-- Table structure for table `user_sanction`
--

DROP TABLE IF EXISTS `user_sanction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_sanction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `reason` text NOT NULL,
  `start_at` datetime NOT NULL,
  `end_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `user_id` bigint NOT NULL,
  `admin_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_user_sanction_1` (`user_id`),
  KEY `FK_user_TO_user_sanction_2` (`admin_id`),
  CONSTRAINT `FK_user_TO_user_sanction_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_user_TO_user_sanction_2` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sanction`
--

/*!40000 ALTER TABLE `user_sanction` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_sanction` ENABLE KEYS */;

--
-- Dumping routines for database 'resonos'
--
/*!50003 DROP PROCEDURE IF EXISTS `create_tables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_tables`()
BEGIN

    -- 1. 외래키 제약 조건 비활성화

    SET FOREIGN_KEY_CHECKS = 0;



    -- 2. 테이블 삭제

    DROP TABLE IF EXISTS

        user_auth, liked_album, album_review, user_follow, user_badge,

        track_review, notification, chart_entry,

        board_post, playlist_detail, artist_follow, album,

        playlist, comment, chart_element, report,

        liked_playlist, liked_track, qna_answer, qna, community,

        track_mood_vote, artist_mood_vote, user_sanction, admin_log, user_role, review_like, review_report,

        notice, setting, badge, policy, external_api_config, plugin,

        track, artist, user, role, tag, user_activity_log,

        badge_condition;



    CREATE TABLE IF NOT EXISTS `notice` (

        `id` BIGINT NOT NULL,

        `title` VARCHAR(200) NOT NULL,

        `content` TEXT NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

        `is_active` BOOLEAN NOT NULL,

        `start_at` DATETIME NULL,

        `end_at` DATETIME NULL,

        `author_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `qna_answer` (

        `id` BIGINT NOT NULL,

        `content` TEXT NOT NULL,

        `answered_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `qna_id` BIGINT NOT NULL,

        `admin_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `role` (

        `id` BIGINT NOT NULL,

        `name` VARCHAR(100) NOT NULL,

        `description` VARCHAR(200) NULL

    );



    CREATE TABLE IF NOT EXISTS `community` (

        `id` BIGINT NOT NULL,

        `name` VARCHAR(200) NOT NULL,

        `description` TEXT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `creator_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `qna` (

        `id` BIGINT NOT NULL,

        `type` VARCHAR(50) NOT NULL,

        `title` VARCHAR(100) NOT NULL,

        `content` TEXT NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `status` BOOLEAN NOT NULL DEFAULT FALSE,

        `user_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `liked_track` (

        `id` BIGINT NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `user_id` BIGINT NOT NULL,

        `track_id` VARCHAR(200) NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `artist` (

        `id` VARCHAR(200) NOT NULL,

        `name` VARCHAR(100) NOT NULL,

        `profile_image` VARCHAR(200) NULL,

        `genres` VARCHAR(64) NULL

    );



    CREATE TABLE IF NOT EXISTS `tag` (

        `id` BIGINT NOT NULL,

        `name` VARCHAR(50) NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `track` (

        `id` VARCHAR(200) NOT NULL,

        `title` TEXT NOT NULL,

        `duration` INT NOT NULL,

        `genre` VARCHAR(64) NULL,

        `streaming_url` VARCHAR(200) NULL,

        `mv_url` VARCHAR(200) NULL,

        `album_id` VARCHAR(200) NOT NULL,

        `artist_id` VARCHAR(200) NOT NULL,

        `popularity` INT NOT NULL,

        `track_no` INT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `user` (

        `id` BIGINT NOT NULL,

        `username` VARCHAR(100) NOT NULL,

        `email` VARCHAR(100) NOT NULL,

        `password` VARCHAR(100) NOT NULL,

        `nickname` VARCHAR(100) NOT NULL,

        `profile_image` VARCHAR(200) NOT NULL DEFAULT '/img/profileImg.png',

        `bio` TEXT NULL,

        `is_pro` BOOLEAN NOT NULL DEFAULT FALSE,

        `enabled` BOOLEAN NOT NULL DEFAULT TRUE,

        `ban` BOOLEAN NOT NULL DEFAULT FALSE COMMENT '회원 제재 여부',

        `ban_reason` VARCHAR(255) NULL COMMENT '제재 사유',

        `ban_at` TIMESTAMP NULL DEFAULT NULL COMMENT '제재 일시',

        `provider` VARCHAR(200) NULL,

        `provider_id` VARCHAR(200) NULL,

        `current_badge` BIGINT NULL,

        `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,

        `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

    );



    CREATE TABLE IF NOT EXISTS `external_api_config` (

        `id` BIGINT NOT NULL,

        `provider` VARCHAR(100) NOT NULL,

        `apiKey` VARCHAR(100) NOT NULL,

        `secret` VARCHAR(100) NOT NULL,

        `enabled` BOOLEAN NOT NULL DEFAULT FALSE,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP

    );



    CREATE TABLE IF NOT EXISTS `plugin` (

        `id` BIGINT NOT NULL,

        `name` VARCHAR(100) NOT NULL,

        `enabled` BOOLEAN NOT NULL DEFAULT FALSE,

        `config_json` TEXT,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP

    );



    CREATE TABLE IF NOT EXISTS `liked_playlist` (

        `id` BIGINT NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `user_id` BIGINT NOT NULL,

        `playlist_id` BIGINT NOT NULL,

        UNIQUE (user_id, playlist_id)

    );



    CREATE TABLE IF NOT EXISTS `report` (

        `id` BIGINT NOT NULL,

        `target_type` ENUM('boardPost', 'comment', 'review', 'playlist', 'album', 'track', 'user', 'artist', 'qna') NOT NULL,

        `target_id` BIGINT NOT NULL,

        `reason` TEXT NOT NULL,

        `status` ENUM('PENDING', 'DONE', 'REJECTED') NOT NULL DEFAULT 'PENDING',

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `reporter_id` BIGINT NOT NULL,

        `processed_by` BIGINT NULL,

        `processed_at` DATETIME NULL,

        `process_memo` TEXT NULL

    );



    CREATE TABLE IF NOT EXISTS `chart_element` (

        `id` BIGINT NOT NULL,

        `lyric` INT NOT NULL,

        `sound` INT NOT NULL,

        `melody` INT NOT NULL,

        `storytelling` INT NOT NULL,

        `cohesiveness` INT NOT NULL,

        `creativity` INT NOT NULL,

        `album_id` VARCHAR(200) NOT NULL,

        `user_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `comment` (

        `id` BIGINT NOT NULL,

        `content` TEXT NULL,

        `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,

        `user_id` BIGINT NOT NULL,

        `type` ENUM('posts', 'playlist', 'comment') NOT NULL,

        `target_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `playlist` (

        `id` BIGINT NOT NULL,

        `user_id` BIGINT NOT NULL,

        `title` VARCHAR(200) NOT NULL,

        `description` TEXT NULL,

        `thumbnail_url` VARCHAR(200) NOT NULL DEFAULT '/img/profileImg.png',

        `is_public` BOOLEAN NOT NULL,

        `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

    );



    CREATE TABLE IF NOT EXISTS `album` (

        `id` VARCHAR(200) NOT NULL,

        `title` VARCHAR(100) NOT NULL,

        `cover_image` VARCHAR(200) NULL,

        `release_date` DATE NOT NULL,

        `genre` VARCHAR(64) NULL,

        `label` VARCHAR(100) NULL,

        `description` TEXT NULL,

        `artist_id` VARCHAR(200) NOT NULL,

        `country` CHAR(3) NULL

    );



    CREATE TABLE IF NOT EXISTS `user_sanction` (

        `id` BIGINT NOT NULL,

        `type` VARCHAR(50) NOT NULL,

        `reason` TEXT NOT NULL,

        `start_at` DATETIME NOT NULL,

        `end_at` DATETIME NULL,

        `created_at` DATETIME NOT NULL,

        `user_id` BIGINT NOT NULL,

        `admin_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `admin_log` (

        `id` BIGINT NOT NULL,

        `action` VARCHAR(50) NOT NULL,

        `target_type` VARCHAR(50) NOT NULL,

        `meta` JSON NULL,

        `reason` TEXT NULL,

        `description` TEXT NULL,

        `ip_address` VARCHAR(45) NULL,

        `user_agent` TEXT NULL,

        `created_at` DATETIME NOT NULL,

        `actor_id` BIGINT NOT NULL,

        `target_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `artist_follow` (

        `id` BIGINT NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `user_id` BIGINT NOT NULL,

        `artist_id` VARCHAR(200) NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `playlist_detail` (

        `id` BIGINT NOT NULL,

        `track_id` VARCHAR(200) NOT NULL,

        `playlist_id` BIGINT NOT NULL,

        `order_no` INT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `policy` (

        `id` BIGINT NOT NULL,

        `type` VARCHAR(100) NULL,

        `content` TEXT NULL,

        `version` VARCHAR(100) NULL,

        `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP

    );



    CREATE TABLE IF NOT EXISTS `board_post` (

        `id` BIGINT NOT NULL,

        `title` VARCHAR(200) NOT NULL,

        `content` TEXT NOT NULL,

        `type` VARCHAR(50) NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `community_id` BIGINT NOT NULL,

        `user_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `chart_entry` (

        `id` BIGINT NOT NULL,

        `type` VARCHAR(100) NULL,

        `rank` INT NULL,

        `calculated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `track_id` VARCHAR(200) NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `user_role` (

        `id` BIGINT NOT NULL,

        `assigned_at` DATETIME NOT NULL,

        `user_id` BIGINT NOT NULL,

        `role_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `badge` (

        `id` BIGINT NOT NULL,

        `name` VARCHAR(100) NULL,

        `description` TEXT NULL,

        `icon_url` VARCHAR(200) NULL,

        `criteria` VARCHAR(200) NULL,

        `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP

    );



    CREATE TABLE IF NOT EXISTS `notification` (

        `id` BIGINT NOT NULL,

        `type` VARCHAR(32) NOT NULL,

        `message` TEXT NOT NULL,

        `content` TEXT NULL,

        `is_read` BOOLEAN NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `target_id` BIGINT NULL,

        `user_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `setting` (

        `id` BIGINT NOT NULL,

        `name` VARCHAR(255) NULL,

        `description` VARCHAR(255) NULL,

        `value` VARCHAR(100) NULL,

        `updated_at` DATETIME NULL,

        `created_at` DATETIME NULL

    );





    CREATE TABLE IF NOT EXISTS `track_mood_vote` (

        `id` BIGINT NOT NULL,

        `user_id` BIGINT NOT NULL,

        `track_id` VARCHAR(200) NOT NULL,

        `mood` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `artist_mood_vote` (

        `id` BIGINT NOT NULL,

        `user_id` BIGINT NOT NULL,

        `artist_id` VARCHAR(200) NOT NULL,

        `mood` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `track_review` (

        `id` BIGINT NOT NULL,

        `rating` INT NOT NULL,

        `content` TEXT NOT NULL,

        `blinded` BOOLEAN NOT NULL,

        `likes` INT NOT NULL DEFAULT 0,

        `dislikes` INT NOT NULL DEFAULT 0,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `critic` BOOLEAN NOT NULL,

        `user_id` BIGINT NOT NULL,

        `track_id` VARCHAR(200) NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `user_activity_log` (

        `id` BIGINT NOT NULL,

        `action` VARCHAR(50) NOT NULL,

        `target_type` VARCHAR(50) NULL,

        `target_id` BIGINT NULL,

        `detail` TEXT NULL,

        `ip_address` VARCHAR(45) NULL,

        `user_agent` TEXT NULL,

        `created_at` DATETIME NOT NULL,

        `user_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `user_badge` (

        `id` BIGINT NOT NULL,

        `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,

        `user_id` BIGINT NOT NULL,

        `badge_id` BIGINT NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `badge_condition` (

        `id` BIGINT NOT NULL,

        `badge_id` BIGINT NOT NULL,

        `badge_name` VARCHAR(100) NOT NULL,

        `description` VARCHAR(255),

        `condition_type` VARCHAR(50),

        `condition_value` INT

    );



    CREATE TABLE IF NOT EXISTS `review_like` (

        `id` BIGINT NOT NULL,

        `review_id` BIGINT NOT NULL,

        `user_id` BIGINT NOT NULL,

        `review_type` ENUM('TRACK', 'ALBUM') NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        UNIQUE (review_id, user_id, review_type)

    );



    CREATE TABLE IF NOT EXISTS `review_report` (

        `id` BIGINT NOT NULL,

        `review_id` BIGINT NOT NULL,

        `user_id` BIGINT NOT NULL,

        `review_type` ENUM('TRACK', 'ALBUM') NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        UNIQUE (review_id, user_id, review_type)

    );



    CREATE TABLE IF NOT EXISTS `user_follow` (

        `id` BIGINT NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `follower_id` BIGINT NOT NULL,

        `following_id` BIGINT NOT NULL,

        UNIQUE (follower_id, following_id)

    );



    CREATE TABLE IF NOT EXISTS `album_review` (

        `id` BIGINT NOT NULL,

        `rating` INT NOT NULL,

        `content` TEXT NOT NULL,

        `blinded` BOOLEAN NOT NULL,

        `likes` INT NOT NULL DEFAULT 0,

        `dislikes` INT NOT NULL DEFAULT 0,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `critic` BOOLEAN NOT NULL,

        `user_id` BIGINT NOT NULL,

        `album_id` VARCHAR(200) NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `liked_album` (

        `id` BIGINT NOT NULL,

        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

        `user_id` BIGINT NOT NULL,

        `album_id` VARCHAR(200) NOT NULL

    );



    CREATE TABLE IF NOT EXISTS `user_auth` (

        `no` BIGINT NOT NULL,

        `username` VARCHAR(100) NOT NULL,

        `auth` VARCHAR(100) NOT NULL

    );

-- 1. 테이블 생성 (id에 PK, AUTO_INCREMENT 없이)

CREATE TABLE IF NOT EXISTS user_badge_log (

    id BIGINT NOT NULL,

    user_id BIGINT NOT NULL,

    badge_id BIGINT NOT NULL,

    action VARCHAR(10) NOT NULL,

    actor_id BIGINT DEFAULT NULL,

    reason VARCHAR(255) DEFAULT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_ubl_user_badge_created (user_id, badge_id, created_at)

);



CREATE TABLE IF NOT EXISTS  `user_notification` (

    `user_id` BIGINT NOT NULL,

    `type` enum('comment','mention','like','follow','reply','badge','qna','announcement','system') NOT NULL,

    `is_enabled` tinyint(1) NOT NULL DEFAULT '1'

);





    -- 4. PK, AUTO_INCREMENT, UNIQUE, FK 일괄 추가



    -- PK & AUTO_INCREMENT

    ALTER TABLE `notice` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `qna_answer` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `role` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `community` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `qna` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `liked_track` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `artist` MODIFY COLUMN `id` VARCHAR(200) NOT NULL, ADD PRIMARY KEY (`id`);

    ALTER TABLE `tag` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `track` MODIFY COLUMN `id` VARCHAR(200) NOT NULL, ADD PRIMARY KEY (`id`);

    ALTER TABLE `user` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `external_api_config` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `liked_playlist` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `report` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `chart_element` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `comment` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `playlist` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `album` MODIFY COLUMN `id` VARCHAR(200) NOT NULL, ADD PRIMARY KEY (`id`);

    ALTER TABLE `user_sanction` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `admin_log` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `artist_follow` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `playlist_detail` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `policy` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `board_post` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `chart_entry` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `user_role` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `badge` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `notification` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `setting`MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`), ADD CONSTRAINT `uk_setting_value` UNIQUE (`value`);

    ALTER TABLE `user_notification` ADD PRIMARY KEY (user_id, type);

    ALTER TABLE `track_mood_vote` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `artist_mood_vote` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `track_review` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `user_activity_log` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `user_badge` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `user_follow` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `album_review` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `liked_album` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `plugin` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `badge_condition` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `review_like` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `review_report` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);

    ALTER TABLE `user_auth` MODIFY COLUMN `no` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`no`);



    -- UNIQUE

    ALTER TABLE `user` ADD UNIQUE KEY `UK_username` (`username`);

    ALTER TABLE `user_notification` ADD UNIQUE `UK_user_type` (`user_id`, `type`);

    ALTER TABLE `liked_playlist` ADD CONSTRAINT UK_user_playlist UNIQUE (user_id, playlist_id);

    ALTER TABLE `user_badge` ADD UNIQUE KEY uk_user_badge (user_id, badge_id);

    ALTER TABLE `playlist_detail` ADD CONSTRAINT UK_track_playlist UNIQUE (track_id, playlist_id);

    ALTER TABLE `user_follow` ADD CONSTRAINT UK_following_and_follower UNIQUE (follower_id, following_id);

    ALTER TABLE `track_review` ADD UNIQUE KEY `uniq_user_track` (`user_id`, `track_id`);

    ALTER TABLE `album_review` ADD UNIQUE (user_id, album_id);

    ALTER TABLE `review_like` ADD UNIQUE (review_id, user_id, review_type);

    ALTER TABLE `review_report` ADD UNIQUE (review_id, user_id, review_type);

    ALTER TABLE `artist_follow` ADD UNIQUE (user_id, artist_id);

    ALTER TABLE `artist_mood_vote` ADD UNIQUE (user_id, artist_id);

    ALTER TABLE `chart_element` ADD UNIQUE(user_id, album_id);

    ALTER TABLE `liked_album` ADD UNIQUE(user_id, album_id);

    ALTER TABLE `liked_track` ADD UNIQUE(user_id, track_id);

    ALTER TABLE `track_mood_vote` ADD UNIQUE(user_id, track_id);



    -- FK

    ALTER TABLE `notice` ADD CONSTRAINT `FK_user_TO_notice_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

    ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_qna_TO_qna_answer_1` FOREIGN KEY (`qna_id`) REFERENCES `qna` (`id`);

    ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_user_TO_qna_answer_1` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`);

    ALTER TABLE `community` ADD CONSTRAINT `FK_user_TO_community_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`);

    ALTER TABLE `qna` ADD CONSTRAINT `FK_user_TO_qna_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `liked_track` ADD CONSTRAINT `FK_user_TO_liked_track_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `liked_track` ADD CONSTRAINT `FK_track_TO_liked_track_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);

    ALTER TABLE `track` ADD CONSTRAINT `FK_album_TO_track_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE;

    ALTER TABLE `track` ADD CONSTRAINT `FK_artist_TO_track_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE;

    ALTER TABLE `liked_playlist` ADD CONSTRAINT `FK_user_TO_liked_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `liked_playlist` ADD CONSTRAINT `FK_playlist_TO_liked_playlist_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `report` ADD CONSTRAINT `FK_user_TO_report_1` FOREIGN KEY (`reporter_id`) REFERENCES `user` (`id`);

    -- ALTER TABLE `report` ADD CONSTRAINT `FK_user_TO_report_2` FOREIGN KEY (`target_id`) REFERENCES `user` (`id`); -- target_id는 다양한 타입일 수 있으니 주석 처리

    ALTER TABLE `chart_element` ADD CONSTRAINT `FK_album_TO_chart_element_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE;

    ALTER TABLE `chart_element` ADD CONSTRAINT `FK_user_TO_chart_element_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

    ALTER TABLE `comment` ADD CONSTRAINT `FK_user_TO_comment_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `playlist` ADD CONSTRAINT `FK_user_TO_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `album` ADD CONSTRAINT `FK_artist_TO_album_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE;

    ALTER TABLE `user_sanction` ADD CONSTRAINT `FK_user_TO_user_sanction_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `user_sanction` ADD CONSTRAINT `FK_user_TO_user_sanction_2` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`);

    ALTER TABLE `admin_log` ADD CONSTRAINT `FK_user_TO_admin_log_1` FOREIGN KEY (`actor_id`) REFERENCES `user` (`id`);

    ALTER TABLE `admin_log` ADD CONSTRAINT `FK_user_TO_admin_log_2` FOREIGN KEY (`target_id`) REFERENCES `user` (`id`);

    ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_user_TO_artist_follow_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_artist_TO_artist_follow_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE;

    ALTER TABLE `playlist_detail` ADD CONSTRAINT `FK_track_TO_playlist_detail_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `playlist_detail` ADD CONSTRAINT `FK_playlist_TO_playlist_detail_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `board_post` ADD CONSTRAINT `FK_community_TO_board_post_1` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`);

    ALTER TABLE `board_post` ADD CONSTRAINT `FK_user_TO_board_post_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `chart_entry` ADD CONSTRAINT `FK_track_TO_chart_entry_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);

    ALTER TABLE `user_role` ADD CONSTRAINT `FK_user_TO_user_role_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `user_role` ADD CONSTRAINT `FK_role_TO_user_role_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

    ALTER TABLE `notification` ADD CONSTRAINT `FK_user_TO_notification_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_user_TO_track_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_track_TO_track_mood_vote_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);

    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_tag_TO_track_mood_vote_1` FOREIGN KEY (`mood`) REFERENCES `tag` (`id`);

    ALTER TABLE `artist_mood_vote` ADD CONSTRAINT `FK_user_TO_artist_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `artist_mood_vote` ADD CONSTRAINT `FK_artist_TO_artist_mood_vote_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`);

    ALTER TABLE `track_review` ADD CONSTRAINT `FK_user_TO_track_review_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `track_review` ADD CONSTRAINT `FK_track_TO_track_review_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);

    ALTER TABLE `user_activity_log` ADD CONSTRAINT `FK_user_TO_user_activity_log_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `user_badge` ADD CONSTRAINT `FK_user_TO_user_badge_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `user_badge` ADD CONSTRAINT `FK_badge_TO_user_badge_1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `user_follow` ADD CONSTRAINT `FK_user_TO_user_follow_1` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `user_follow` ADD CONSTRAINT `FK_user_TO_user_follow_2` FOREIGN KEY (`following_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `album_review` ADD CONSTRAINT `FK_user_TO_album_review_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `album_review` ADD CONSTRAINT `FK_album_TO_album_review_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE;

    ALTER TABLE `liked_album` ADD CONSTRAINT `FK_user_TO_liked_album_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

    ALTER TABLE `liked_album` ADD CONSTRAINT `FK_album_TO_liked_album_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE;

    ALTER TABLE `user_auth` ADD CONSTRAINT `FK_user_TO_user_auth` FOREIGN KEY (`username`) REFERENCES `user` (`username`);

    ALTER TABLE `user` ADD CONSTRAINT `FK_use_badge_TO_user` FOREIGN KEY (`current_badge`) REFERENCES `user_badge` (`badge_id`) ON DELETE CASCADE ON UPDATE CASCADE;

    ALTER TABLE `badge_condition` ADD CONSTRAINT `FK_badge_TO_badge_condition_1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`);

    ALTER TABLE `review_like` ADD CONSTRAINT `FK_user_TO_review_like_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

    ALTER TABLE `review_report` ADD CONSTRAINT `FK_user_TO_review_report_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

    ALTER TABLE `user_notification` ADD CONSTRAINT `FK_user_TO_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;



-- 2. id 컬럼에 PK + AUTO_INCREMENT 추가 (이미 PK면 MODIFY 만)

ALTER TABLE user_badge_log

    MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT,

    ADD PRIMARY KEY (id);



-- 3. FK 제약조건 추가

ALTER TABLE user_badge_log

    ADD CONSTRAINT FK_ubl_user FOREIGN KEY (user_id)

        REFERENCES user(id) ON DELETE CASCADE ON UPDATE CASCADE,

    ADD CONSTRAINT FK_ubl_badge FOREIGN KEY (badge_id)

        REFERENCES badge(id) ON DELETE CASCADE ON UPDATE CASCADE,

    ADD CONSTRAINT FK_ubl_actor FOREIGN KEY (actor_id)

        REFERENCES user(id) ON DELETE SET NULL ON UPDATE CASCADE;



    -- 5. 외래키 제약 조건 활성화

    SET FOREIGN_KEY_CHECKS = 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-22 14:19:52

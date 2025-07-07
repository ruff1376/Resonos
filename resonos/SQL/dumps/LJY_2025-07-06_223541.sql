-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: resonos
-- ------------------------------------------------------
-- Server version	8.0.42

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
  PRIMARY KEY (`id`),
  KEY `FK_artist_TO_album_1` (`artist_id`),
  CONSTRAINT `FK_artist_TO_album_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES ('002MjQVkI2aHS733fGjj3S','Old Phone','https://i.scdn.co/image/ab67616d0000b273dfa277d55d56b246f11e3062','2025-05-01','','Gingerbread Man Records / Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('01Lc5SkGnpLjjVx4QHae8a','BLUE MOON','https://i.scdn.co/image/ab67616d0000b273830d181b4228625b58faf2b4','2017-04-14','','Starship Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('01LQ7acjTLVDDj5rhcFXhE','Fiesta improvisada','https://i.scdn.co/image/ab67616d0000b273bd39d1c9640b0fd10d06f96a','2024-02-13','','Warner Music Group - X5 Music Group','','6YVMFz59CuY7ngCxTxjpxE'),('01RsFGO7W7xaRM4T2p1Xdn','Yours','https://i.scdn.co/image/ab67616d0000b2736c971ef3296c879c94128829','2020-05-12','','SM Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('02pi98kE0nra0yBqCStzbC','+','https://i.scdn.co/image/ab67616d0000b2736567a393a964a845a89b7f70','2011-09-09','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('04hy4jb1GDD00otiwzsFUB','Echoes Of Silence (Original)','https://i.scdn.co/image/ab67616d0000b27336fb79728dbb379579cef97e','2011-12-21','','Universal Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('05c49JgPmL4Uz2ZeqRx5SP','Chromatica','https://i.scdn.co/image/ab67616d0000b2736040effba89b9b00a6f6743a','2020-05-29','','Interscope','','41MozSoPIsD1dJM0CLPjZF'),('05K5RSyTasOI8cQTFHhTLS','Better Things (Tropkillaz Remix)','https://i.scdn.co/image/ab67616d0000b273a6b1a4f70a5ecb1612b1eae7','2023-09-22','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('05V1ld4qvJUnOQopUK8uSY','Shake That (Radio Edit Version)','https://i.scdn.co/image/ab67616d0000b27340735818c3f8f04ba30e47c2','2006-01-17','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('07Rq17GzCnIdWJcyVHb57G','Love Yourself 承 \'Her\'','https://i.scdn.co/image/ab67616d0000b273829305487c8f3b96a1d955b3','2017-09-18','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('082dja5H3X7Cu669XwXF0g','Now, We Are Breaking Up (Original Television Soundtrack), Pt. 6','https://i.scdn.co/image/ab67616d0000b2736715929ff9a50cfd22e85fff','2021-11-28','','뮤직그라운드,구름위에음악사','','7c1HgFDe8ogy5NOZ1ANCJQ'),('085VlHiMLkKtDJNn42q29J','Hometown Cha-Cha-Cha (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b2739e0c7f2b27011578e792666f','2021-10-18','','Genie Music Corporation','','7c1HgFDe8ogy5NOZ1ANCJQ'),('08CWGiv27MVQhYpuTtvx83','Fearless (International Version)','https://i.scdn.co/image/ab67616d0000b273516c279fe91ae3f6a79b23da','2008-11-11','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('08ou14V2A0NWpvq7QkUWbM','\'BLACKPINK 2018 TOUR \'IN YOUR AREA\' SEOUL - Live','https://i.scdn.co/image/ab67616d0000b273df1580ff05c0fb1b0cd23e1a','2019-08-30','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('0925fmA4yXceCLF0hvzd1m','The wish','https://i.scdn.co/image/ab67616d0000b27340a54d003fb94fd527015db0','2024-12-16','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('097ZQ0Gq6L9yGLZ4dggE60','2 Cool 4 Skool','https://i.scdn.co/image/ab67616d0000b27386d28955bda73bf55ebaba3d','2013-06-12','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('09diUPC7IV8tCwr1C9ASyu','twicetagram','https://i.scdn.co/image/ab67616d0000b273247f8c542b296e9c60d429d6','2017-10-30','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('0a28QsFN8zbrWSvbSQ40PI','2step (The Remixes)','https://i.scdn.co/image/ab67616d0000b27320384043656216cb372f9739','2021-10-25','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('0A2mMxRPOdR1hKBfqcfdpL','APARTMENT','https://i.scdn.co/image/ab67616d0000b2739a4d16624132929793f2f872','2017-12-12','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('0AGlWrH25YTUZE8HYZpyNh','Beautiful (International Version)','https://i.scdn.co/image/ab67616d0000b27346be42729e0283738ede5376','2009-08-11','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('0alRcEQVCmhJnIBrvIZpDK','DIVE','https://i.scdn.co/image/ab67616d0000b2739b8cd78fd3a71544cce889f7','2024-07-17','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('0AxwDje2klNIOVKvMTtwdZ','2','https://i.scdn.co/image/ab67616d0000b273aa4c2149f4562a8d1f380f50','2024-01-29','','CUBE Entertainment','','2AfmfGFbe0A0WsTYm0SDTx'),('0B2lD0gY47LYXSxPOzxrXh','Somebody Save Me (feat. Jelly Roll)','https://i.scdn.co/image/ab67616d0000b273a5f33cd0d7e1223a0fbd865e','2024-07-10','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('0bH74T4pClqWmhltGOI8H9','A','https://i.scdn.co/image/ab67616d0000b2738e629ff126ba9fe6fa843fcf','2015-06-01','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('0BL4n7JwPd0Ml4nhpjRCFv','Sympathy is a knife featuring ariana grande','https://i.scdn.co/image/ab67616d0000b273cb260d46ad3b5cc7f91dc6ee','2024-10-10','','Atlantic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('0Bp0eaX0UqiJ1kvMNwJ5NX','Letter (Ditto X YOUNHA)','https://i.scdn.co/image/ab67616d0000b2734d2d7243ad2f45476e8aa520','2022-11-16','','TOON STUDIO','','6GwM5CHqhWXzG3l5kzRSAS'),('0chJ3ayT11InZNCO8BSoAZ','THE REMIXES','https://i.scdn.co/image/ab67616d0000b27391d6511fc736edbb65131517','2023-11-22','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('0cLXqY56lwJjG7QNG2mzu7','Wake Me Up','https://i.scdn.co/image/ab67616d0000b2737ed15a8f5dc0060a449527a7','2025-01-29','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('0Cp4RcGMELipXIAye8AxFN','START-UP (Original Television Soundtrack) Pt. 1','https://i.scdn.co/image/ab67616d0000b2738baaea835b889da3f0ca4609','2020-10-17','','(주)뮤직버디, (주)블렌딩','','1z4g3DjTBBZKhvAroFlhOM'),('0Ct52rooGyvjv6qXrBPNzm','Double Fantasy','https://i.scdn.co/image/ab67616d0000b273c7d6fe09dfe4af1580e59705','2023-04-21','','Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('0CVgxbasWKDZyGJUUh0fWX','2008 SBS Hope TV24','https://i.scdn.co/image/ab67616d0000b273970fe0e3378f9c4fced7e8e5','2008-04-18','','SBS Contents Hub Co., Ltd.','','0Sadg1vgvaPqGTOjxu0N6c'),('0Dl7e3uv3UrVDdZ6saplzH','Darl+ing','https://i.scdn.co/image/ab67616d0000b2732139a9fca45751cc0b0f53ba','2022-04-15','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('0drBJNDdHv4qK7XfPtBqee','KISS ROAD','https://i.scdn.co/image/ab67616d0000b2735dbfe6dbae519e734e97f43e','2025-05-07','','S2 ENTERTAINMENT INC.','','4TEK9tIkcoxib4GxT3O4ky'),('0E4HPJE6DPIc2OUmJ8rTP0','Butter / Permission to Dance','https://i.scdn.co/image/ab67616d0000b2732a7ffc5834a6a087a8125e1e','2021-07-09','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('0F4cbmRj5QrxoxjZt9ymj5','O!RUL8,2?','https://i.scdn.co/image/ab67616d0000b2737b7bb83437b5dae3bde4d986','2013-09-11','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('0Facfeed2mATsDICeHBIz1','REBEL HEART','https://i.scdn.co/image/ab67616d0000b273307e7e4ca1b2c02108aec9a0','2025-01-13','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('0FOOodYRlj7gzh7q7IjmNZ','SQUARE ONE','https://i.scdn.co/image/ab67616d0000b273ff4ec21d7817138cabcc19bc','2016-08-08','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('0FTNVEDFEiWyqge3WT4b1j','The Best Hit, Pt. 7 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273a7075f38b429a7cc28e1ff36','2017-07-01','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('0FWdxPnncm63s91g0PkTvv','Timeless (Remix)','https://i.scdn.co/image/ab67616d0000b273245aa43805ea59914d8f59ee','2025-05-09','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('0Gc4wldZ77F1Mx8tn2HkJO','CRAZY (Party Remixes 2)','https://i.scdn.co/image/ab67616d0000b273b945b9e43497fef235226371','2024-09-12','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('0GjZcJIlYoNHn442Tf0hNT','HOT (English ver.) (feat. JADE)','https://i.scdn.co/image/ab67616d0000b27310f1253af109738ad9ecea86','2025-04-14','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('0H1ASykMKIX8PYfqxbxBar','Killer (feat. Jack Harlow & Cordae) [Remix]','https://i.scdn.co/image/ab67616d0000b2736b62c541105dbc157b9ab7bf','2021-05-28','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('0HDHNz6LfL46dbl9pG51g4','I\'ve IVE','https://i.scdn.co/image/ab67616d0000b2734156626a16155286856ea868','2023-04-10','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('0HfgwbSH4SsXbcuGY7BMhP','True Beauty, Pt. 3 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b2730078aa44b39c760795c5f7bc','2021-01-07','','Genie Music Corporation','','7c1HgFDe8ogy5NOZ1ANCJQ'),('0HJfB2Ar2nnMLJ5L16Rlw9','Love & Sex, Happiness 6집','https://i.scdn.co/image/ab67616d0000b27373cf10fea296fc35238ffedf','2004-11-09','','㈜쇼글로브','','2dd5mrQZvg6SmahdgVKDzh'),('0hXnUVrrEXKKGUNGfqpdlA','CRAZY (David Guetta Remix)','https://i.scdn.co/image/ab67616d0000b273d54136898e1c2776b6b8ec0d','2024-09-09','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('0ieeyOsOoSmd2b906MrlRO','Djesse Vol. 4 (Deluxe)','https://i.scdn.co/image/ab67616d0000b273afd657079db8adf6624f1f7e','2024-10-09','','Decca (UMO)','','6YVMFz59CuY7ngCxTxjpxE'),('0ifM8RTX9HjtCJtY9452bW','come out and play','https://i.scdn.co/image/ab67616d0000b27348a98a5a97b2cc7963016888','2018-11-20','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('0IKX5sXulbdrCknRlFC4PR','Oh my god','https://i.scdn.co/image/ab67616d0000b273f8e40fc98b53a8ef50f5527e','2020-08-26','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('0JGOiO34nwfUdDrD612dOp','Happier Than Ever','https://i.scdn.co/image/ab67616d0000b2732a038d3bf875d23e4aeaa84e','2021-07-30','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('0jiAYLsE1PumLJncO7vUIl','K-POP (Chopped & Screwed)','https://i.scdn.co/image/ab67616d0000b273dd8912dfae6121b0e25bcaec','2023-07-18','','Cactus Jack/Epic','','1Xyo4u8uXC1ZmMpatF05PJ'),('0jXtQE6F6FYFLPx0S3Gp1D','Better Things (Sped Up + Slowed Down)','https://i.scdn.co/image/ab67616d0000b27375236d43c55ff3b5802a9215','2023-09-08','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('0k31vrIZQgqit8TjlQePM9','Relay','https://i.scdn.co/image/ab67616d0000b273c2af00cdd9dabb9f9a635e8b','2018-11-19','','LINE FRIENDS','','2AfmfGFbe0A0WsTYm0SDTx'),('0kHBlnc69hLOSyXAZn2yeX','yes, and? (remixes)','https://i.scdn.co/image/ab67616d0000b27378b1c468de3d983892c3c80c','2024-01-12','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('0ki891OZvsxIuBYHn4PPLo','Come Over (Remixes)','https://i.scdn.co/image/ab67616d0000b2731587dfab4aaad513832a451e','2025-03-31','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('0L8st2swXgp7bPyBNSsfrv','夏恋バスケット♪','https://i.scdn.co/image/ab67616d0000b2738604f82fd5135efacd4d523c','2020-07-08','','avex trax','','41MozSoPIsD1dJM0CLPjZF'),('0lfBk66tG0KsVOaj6vt3rm','SAPPY','https://i.scdn.co/image/ab67616d0000b2739a4cb4462975337f4f23f0ae','2019-01-11','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('0LgnntyagLdfW5Dz2OSYHU','WHEN I WAS OLDER (Music Inspired By The Film ROMA)','https://i.scdn.co/image/ab67616d0000b27373f85e8b4338d2aa07f59f3a','2019-01-09','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('0Ln5FMD8zPCDPCr5gJVTkb','#Cookie Jar','https://i.scdn.co/image/ab67616d0000b27362564e36af1ae2e584ba3515','2018-07-04','','AVEX ENTERTAINMENT INC.','','1z4g3DjTBBZKhvAroFlhOM'),('0LyIwn8KquuxN0egv7wq8Z','Angel Pt. 1 (feat. Jimin of BTS, JVKE & Muni Long) (FAST X Soundtrack)','https://i.scdn.co/image/ab67616d0000b27321ba737cb75af968200cf4bc','2023-05-18','','APG Inc – FF10','','3Nrfpe0tUJi4K4DXYWgMUX'),('0M4H8nupsD6QTOnb3GpCzc','Chocolate, Pt.1 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b2735807de5a92df92bc3ed40a52','2019-12-01','','JTBC 스튜디오','','7nqOGRxlXj7N2JYbgNEjYH'),('0MbXjBEw6FrGtcglqEDHpb','MONOPOLY','https://i.scdn.co/image/ab67616d0000b2737eff60e72e37142e98e986f3','2019-04-01','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('0MCxLqjxcjCpFDFWU7szeu','The Fearless Ones','https://i.scdn.co/image/ab67616d0000b27371c87a14a1850892fd0dcc7c','2019-05-15','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('0MExn54Ei7BViZPI3A8Qun','Hometown Cha-Cha-Cha, Pt. 1 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273ec714aa5e8dbf55110b2a31c','2021-09-05','','Genie Music Corporation','','7c1HgFDe8ogy5NOZ1ANCJQ'),('0MGYgCcyvUsD049HNqxiVy','DBSG 3','https://i.scdn.co/image/ab67616d0000b27387bf4a6d5e4aad44fda7d976','2016-12-15','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('0MwPArEeQJx5GMc5Sz7kRV','Dancing In The Flames','https://i.scdn.co/image/ab67616d0000b273fd5cc07a72dda206535bcf9f','2024-09-13','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('0MYodAzFX64jToQpE5jWNW','Our Beloved BoA #4 - SM STATION','https://i.scdn.co/image/ab67616d0000b2731ff5d88a4453ce83682ab209','2020-08-21','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('0NB6IIwQeRDzNFCU22LQto','Stand Up','https://i.scdn.co/image/ab67616d0000b273256b86508bfdc54899e4685e','2008-08-08','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('0nc7owpZk744Gp8wFQEgJI','Formula of Love: O+T=<3','https://i.scdn.co/image/ab67616d0000b2737e041e8cbb1a45c56b4bf4dc','2021-11-12','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('0nhyyhprFn6lcIAzTpmFDo','Lovesick Girls (JP Ver.)','https://i.scdn.co/image/ab67616d0000b273157030e2a5235c649af7284d','2021-07-13','','Universal Music LLC','','41MozSoPIsD1dJM0CLPjZF'),('0nIVVgMEZYoS62nrIfRZ35','inuman by the beach','https://i.scdn.co/image/ab67616d0000b2734ec1b83031ac72ba9f495ce9','2024-04-27','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('0Nq7k5hqml23K1VlrEnLNR','PSY SIX RULES, Pt. 1','https://i.scdn.co/image/ab67616d0000b2738cacbdd7305b0651b4c0fec4','2012-07-15','','YG Entertainment','','2dd5mrQZvg6SmahdgVKDzh'),('0obMz8EHnr3dg6NCUK4xWp','Dua Lipa (Complete Edition)','https://i.scdn.co/image/ab67616d0000b273ae395b47b186c2bc8c458e0f','2018-10-19','','Warner Records','','41MozSoPIsD1dJM0CLPjZF'),('0OkJThJls8FO1lutMzMDJ0','The Perfect Red Velvet - The 2nd Album Repackage','https://i.scdn.co/image/ab67616d0000b273b64001fa6292caefc7605550','2018-01-29','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('0p0FGxiCrl3afABenvtWbQ','Popular','https://i.scdn.co/image/ab67616d0000b273f53930e3203b69952b4c5920','2024-01-26','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('0P3oVJBFOv3TDXlYRhGL7s','Beauty Behind The Madness','https://i.scdn.co/image/ab67616d0000b2737fcead687e99583072cc217b','2015-08-28','','Universal Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('0P9J5KQksLJqjdwBlqVUP6','Life is Once','https://i.scdn.co/image/ab67616d0000b273bdf76a44dc455027cf9b6076','2023-10-26','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('0PBQ3Cp6NG8WX0G9KQVNMP','Butter (Hotter, Sweeter, Cooler)','https://i.scdn.co/image/ab67616d0000b273240447f2da1433d8f4303596','2021-06-04','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('0pEfoZpPVjHO8YmGfO7hGv','DIFFERENT (English ver.)','https://i.scdn.co/image/ab67616d0000b273c52caf9d3e4179ec1bfabf73','2025-06-13','','HYBE JAPAN / UNIVERSAL MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('0pjWgLVCGDd3mEJIOIqE0k','BASTIONS OST Part.4','https://i.scdn.co/image/ab67616d0000b273c1a99507a03ddd9c8e9a0b34','2023-06-09','','THYMOS Media','','4SpbR6yFEvexJuaBpgAU5p'),('0pX41mddl0CZXxpxkQ7347','Skool Luv Affair (Special Addition)','https://i.scdn.co/image/ab67616d0000b2737fc4a9420eb2ca3aceafa88b','2014-05-14','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('0PZ7lAru5FDFHuirTkWe9Z','folklore: the long pond studio sessions (from the Disney+ special) [deluxe edition]','https://i.scdn.co/image/ab67616d0000b273045514e3ed4e1767a7c3ece5','2020-11-25','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('0QcKKbUjtzQCzdNEnjaePa','MORE & MORE (English Ver.)','https://i.scdn.co/image/ab67616d0000b273840162a9078ef9f92bc4c76c','2020-08-21','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('0QOAUAUR20fpa2SK1J0yGy','WE PRAY (TWICE Version)','https://i.scdn.co/image/ab67616d0000b273aed0d05789f2329ea8adca6b','2025-04-17','','Atlantic Records UK','','7n2Ycct7Beij7Dj7meI4X0'),('0QVIPcQ7qDA1XP8UIF3MC3','Homicide','https://i.scdn.co/image/ab67616d0000b273e18710f2e462a6cd25218e3a','2019-05-03','','Def Jam Recordings','','7dGJo4pcD2V6oG8kP0tJRR'),('0RejlT9bmqcXGrqMaJRos0','Killshot','https://i.scdn.co/image/ab67616d0000b273ebd4158db192228a77d8c2a4','2018-09-19','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('0RhZMUvozZXn2at1sfSogT','yes, and? (Jonas Blue Remix)','https://i.scdn.co/image/ab67616d0000b273686cc5c96d9d1774a06eca9c','2024-01-12','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('0rI1BGsvXnc4IYyBqCJ6sI','ASH','https://i.scdn.co/image/ab67616d0000b273027860786e730fc0c01788c4','2019-03-22','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('0RLD2C0JmAdLckw2stMws7','We are i-dle','https://i.scdn.co/image/ab67616d0000b273a79f5306496209126c084c2b','2025-05-02','','CUBE Entertainment','','2AfmfGFbe0A0WsTYm0SDTx'),('0RoQvfw174dcjxfWjN4I5j','Just the two of us','https://i.scdn.co/image/ab67616d0000b273483eb43369f093dbcf7fd9bb','2022-03-14','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('0rvrbZvaDX5S9ZBhwOwFfH','Perfect Velvet - The 2nd Album','https://i.scdn.co/image/ab67616d0000b2736538b8e1b5c7b2a9d2211769','2017-11-17','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('0S0KGZnfBGSIssfF54WSJh','WHEN WE ALL FALL ASLEEP, WHERE DO WE GO?','https://i.scdn.co/image/ab67616d0000b27350a3147b4edd7701a876c6ce','2019-03-29','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('0S4pP8MBY9p7ngFWIZQAJv','BORN PINK','https://i.scdn.co/image/ab67616d0000b273580ac3ad7dfc81e509171120','2022-09-16','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('0sye9Q82C9Q4tTJN8b0aFq','Moth To A Flame','https://i.scdn.co/image/ab67616d0000b273b1d146bde876bf560eb1a089','2022-01-04','','Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('0U6ldwLBEMkwgfQRY4V6D2','Revival','https://i.scdn.co/image/ab67616d0000b273dee6b58d35215322626b5701','2017-12-15','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('0UewBgAMHugPdwS4Utk8SH','Bigbang 03','https://i.scdn.co/image/ab67616d0000b273ab00b0906c3fa09dc33c91fb','2006-11-22','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('0UnBZ8laFgLUq5Ty5vbikQ','POP/STARS','https://i.scdn.co/image/ab67616d0000b273d1241debb8543af8322a7d6a','2018-11-03','','Riot Games','','2AfmfGFbe0A0WsTYm0SDTx'),('0uWttVLwkFxcW1PkBAsmZd','KILL THIS LOVE (JP Ver.)','https://i.scdn.co/image/ab67616d0000b2739dd7b15113e3d73005713d03','2019-10-16','','Universal Music LLC','','41MozSoPIsD1dJM0CLPjZF'),('0vE6mttRTBXRe9rKghyr1l','The Slim Shady LP','https://i.scdn.co/image/ab67616d0000b2739bef45ee387f274ea3198c55','1999-02-23','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('0vkAczpFKCazPKaoLtnBr0','The Joker And The Queen (feat. Taylor Swift)','https://i.scdn.co/image/ab67616d0000b27389aff4625958eac8d16535c7','2022-02-11','','Atlantic Records UK','','06HL4z0CvFAxyc27GXpf02'),('0Vz32hcNoqOZIpJVI0qExN','Dawn FM (OPN Remix)','https://i.scdn.co/image/ab67616d0000b2732756fcc016298cf16ccf6020','2022-07-08','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('0W5woeQnfOZmVLSbggRRlR','Brat and it’s completely different but also still brat','https://i.scdn.co/image/ab67616d0000b273e382d885067a4a039a73c1b5','2024-10-14','','Atlantic Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('0wjfQ5rrQIRFuSPvAbZBX4','HOSPITAL PLAYLIST Season2, Pt. 8 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273b409722273463785af970a38','2021-08-13','','Genie Music Corporation, Stone Music Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('0WSfHWtgDfdddrEz76ovLC','Sayonara','https://i.scdn.co/image/ab67616d0000b273debb8f7dd07ff17ef5bb7334','2019-03-08','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('0x6h3VCb7RY7Z1RRSgXiy5','Own It (feat. Burna Boy & CHANGMO)','https://i.scdn.co/image/ab67616d0000b273d562e3bcc30b3c8416291bd2','2019-12-11','','Atlantic Records UK','','3hvinNZRzTLoREmqFiKr1b'),('0xlyof8BowaJtYPsxWYmkN','SEVENTEEN 5th Album \'HAPPY BURSTDAY\'','https://i.scdn.co/image/ab67616d0000b273950b4ffac4aaebdb6698465c','2025-05-26','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('0YaaIvxu7OH0OxUSnM9WFH','Perfect Night (Holiday Remix)','https://i.scdn.co/image/ab67616d0000b273f456ca5659f2d0169061b310','2023-11-23','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('0YaLbDxHTeZLT3CpDunKuT','IVE EMPATHY','https://i.scdn.co/image/ab67616d0000b2735b72e3407a7217f522cea696','2025-02-03','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('0yE3H783cUqgJqeXLopkfG','추리의 여왕 시즌2 (Original Television Soundtrack), Pt. 5','https://i.scdn.co/image/ab67616d0000b273ae226b2f13c2954b6332418e','2018-03-29','','Plus Media / ADA','','6GwM5CHqhWXzG3l5kzRSAS'),('0YF085Qdh4HgdhZ8zjWkpo','Die For You','https://i.scdn.co/image/ab67616d0000b2738b5a9e7c56f01bec356de9d5','2023-02-27','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('0ygvUJDV0PK3Sz3f7njaaA','WAVE','https://i.scdn.co/image/ab67616d0000b2739254f2d47aa762c033f2682e','2023-05-09','','Sony Music Labels Inc.','','6RHTUrRF63xao58xh9FXYJ'),('0Yi8StK0Si3u2bLr3Qsm2Q','x (Wembley Edition)','https://i.scdn.co/image/ab67616d0000b273b81ce469fb895a3dbd7f896d','2015-11-13','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('0YqVeLj1wZYLrVvd6dytXI','i\'M THE TREND','https://i.scdn.co/image/ab67616d0000b273d7b62d0122d6392daaab2d21','2020-07-07','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('0ze8IhE4fLLfu5lET12g5v','Butter (Megan Thee Stallion Remix)','https://i.scdn.co/image/ab67616d0000b2731b254e12b4ec7e6c565f735f','2021-08-27','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('10eNMeTimUzAKLhCOpIUlb','K-POP','https://i.scdn.co/image/ab67616d0000b273893489768de0c42b4d217b82','2023-07-21','','Cactus Jack/Epic','','1Xyo4u8uXC1ZmMpatF05PJ'),('10M8ccltzArj4gzfYQu9hn','iScreaM Vol.25 : Red Flavor Remix','https://i.scdn.co/image/ab67616d0000b273ea1ffa333e2422134d2b6a88','2023-08-31','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('10nO3EJJDMm6j6d2uK3Jah','The Slim Shady LP (Expanded Edition)','https://i.scdn.co/image/ab67616d0000b273d12909c6ebc83cb4c6bef6f4','1999-02-23','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('10SppFk45za4CHPEiiuQaD','The Idol Episode 5 Part 2 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b27338b9ba68af98c3c0855b47ee','2023-07-03','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('11F9HxvGzaMT1NkeI3kiNd','DUMDi DUMDi','https://i.scdn.co/image/ab67616d0000b273fe443ca0bc885c47ee2b2e52','2020-08-03','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('11lLYKMkFheiV7ObD7WCnx','Life\'s Too Short','https://i.scdn.co/image/ab67616d0000b273eb9bc74e6ced59a2638898b0','2022-06-24','','Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('11rh8YVvQVdbzOSqKmCCtu','Somebody','https://i.scdn.co/image/ab67616d0000b2734ecf3a76f3866a96e85a19c5','2015-02-24','','파이니스트 레코즈','','7c1HgFDe8ogy5NOZ1ANCJQ'),('11T3su3ed4dERqD2DfsfQ7','Uh-Oh','https://i.scdn.co/image/ab67616d0000b273caff2994e31fa910fdf51cfa','2019-06-26','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('11X2d5C6rFBFZZUOCJLPt9','34+35 (Remix)','https://i.scdn.co/image/ab67616d0000b27343d04ae192008a5113862faf','2021-01-15','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('12A1Byk8EpqzaHSw12nKyW','The Cruelest Summer','https://i.scdn.co/image/ab67616d0000b273905c0872bdf4e1787a6bb5da','2023-10-19','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('12INlMsFtBjyehNnawBv36','Dawn FM (Alternate World)','https://i.scdn.co/image/ab67616d0000b273ade87e5f9c3764f0a1e5df64','2022-01-07','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('12p68ehzb26xvidlV2ypur','Kitsch','https://i.scdn.co/image/ab67616d0000b273c4e7befb303f416dc0409d38','2023-03-27','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('13r6eqjYlKELFQlNvVCBz1','Djesse Vol. 4','https://i.scdn.co/image/ab67616d0000b273b1b5640ec6436246b57a32f1','2024-03-01','','Decca (UMO)','','6YVMFz59CuY7ngCxTxjpxE'),('14JahnBKUL2ou13zH2OOQP','Infinite','https://i.scdn.co/image/ab67616d0000b273f598f32df9d06fd5e1ff9568','1996-11-12','','WEB Entertainment','','7dGJo4pcD2V6oG8kP0tJRR'),('14JkAa6IiFaOh5s0nMyMU9','KPop Demon Hunters (Soundtrack from the Netflix Film)','https://i.scdn.co/image/ab67616d0000b2734dcb6c5df15cf74596ab25a4','2025-06-20','','K-Pop Demon Hunters','','7n2Ycct7Beij7Dj7meI4X0'),('151w1FgRZfnKZA9FEcg9Z3','Midnights','https://i.scdn.co/image/ab67616d0000b273bb54dde68cd23e2a268ae0f5','2022-10-21','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('15b9JCsZh7DkbA2EjBjPqc','Enjoy The Show','https://i.scdn.co/image/ab67616d0000b273c194d06cc0fd9a567e5a0b77','2025-01-29','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('15pRJdCJtDyzQaY9tGs750','SEVENTEEN 4th Album Repackage \'SECTOR 17\'','https://i.scdn.co/image/ab67616d0000b273c31e3f3a15f96cfc4c8f7b7a','2022-07-18','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('16Bf9pk3Tf4n0SBkwVmhA9','Jen','https://i.scdn.co/image/ab67616d0000b273cc6eb3b2bd8d535b61b7303f','2014-01-01','','UMLE - Latino','','2dd5mrQZvg6SmahdgVKDzh'),('16UgZxoo4YMJIJItRxi7qb','TOMBOY (R3HAB Remix)','https://i.scdn.co/image/ab67616d0000b27387790f41e6739baf2d42447d','2022-05-20','','THE UNIT LABEL','','2AfmfGFbe0A0WsTYm0SDTx'),('174t5vG5VyNW9nv1PTuE6J','CRAZY','https://i.scdn.co/image/ab67616d0000b2738c52d9de16a6d36e2c3df4cb','2024-12-11','','HYBE JAPAN / UNIVERSAL MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('17cYF29ZBcDYoRkWUzFWfQ','Moth To A Flame (Moojo Remix)','https://i.scdn.co/image/ab67616d0000b27366858daca33990b506aa62d0','2022-01-04','','Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('17LMeXUAqTmgd5GtmRHo0D','Talk','https://i.scdn.co/image/ab67616d0000b27315a1066e4aa3c16d210d3ec7','2014-02-28','','파이니스트 레코즈','','7c1HgFDe8ogy5NOZ1ANCJQ'),('181WKxuhHzTyjMcYdI7UUe','How Do I Make You Love Me? (Sebastian Ingrosso & Salvatore Ganacci Remix)','https://i.scdn.co/image/ab67616d0000b27314cf4f2a3a808b716604d115','2022-07-22','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('18DEtVsRVQ4rxqnOIAPwRB','Anti-Hero (feat. Bleachers)','https://i.scdn.co/image/ab67616d0000b27350a1e24dde78df1d0ebc68ef','2022-11-08','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('19vSttgdhH7PoAbvXBY7VT','How You Like That','https://i.scdn.co/image/ab67616d0000b27357f5bb0f7a90c35a4bcbb727','2020-06-25','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('1aAjA5rYVUh1JhVIafOmbQ','BE','https://i.scdn.co/image/ab67616d0000b273184d20129ccf5aafcc776d11','2020-11-20','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('1ADmUnR6Z8kRxwFna9ffK6','Tetris (Motion Picture Soundtrack)','https://i.scdn.co/image/ab67616d0000b2731fef5f5629bd24c624e82d54','2023-03-31','','Parlophone UK','','6YVMFz59CuY7ngCxTxjpxE'),('1aEuhb4DJJfTFp1psbgnvn','BEST DRIVING - ZYUUTEUON YOUGAKU HIT MEDLEY','https://i.scdn.co/image/ab67616d0000b27318550f9fa5d14d40299f6123','2024-11-28','','MUSIC LAB JPN','','41MozSoPIsD1dJM0CLPjZF'),('1AFVTHHm7kKoQ6Rgb25x3p','LOVE DIVE','https://i.scdn.co/image/ab67616d0000b2739016f58cc49e6473e1207093','2022-04-05','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('1agEHpWnELaZHWzcbGDCpu','Fortnight (feat. Post Malone) [BLOND:ISH Remix]','https://i.scdn.co/image/ab67616d0000b273e6b77b3eef9269d06e13fe17','2024-05-22','','TS/Republic','','06HL4z0CvFAxyc27GXpf02'),('1aHmoh8Iog2xqwVk9A77yc','PSY 7TH ALBUM','https://i.scdn.co/image/ab67616d0000b2731c0522b1f119c06409b838dc','2015-12-01','','YG Entertainment','','2dd5mrQZvg6SmahdgVKDzh'),('1bpvupIEf0ulyepyTe5KUi','Bangin Beatz Vol 6','https://i.scdn.co/image/ab67616d0000b273057f06b48abab3bead5d3ea0','2023-04-15','','UME - Global Clearing House','','1z4g3DjTBBZKhvAroFlhOM'),('1bV9UJSiCQOg5S786s2T9g','Dirty Work (Remixes)','https://i.scdn.co/image/ab67616d0000b2737564c89f5400489c156aabb7','2025-06-30','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('1BxRutqDtvMJfiovw76gxe','I WANT','https://i.scdn.co/image/ab67616d0000b2738c475998f5005d0a339b1f0d','2023-07-13','','STARSHIP ENTERTAINMENT','','6RHTUrRF63xao58xh9FXYJ'),('1c7jVl1jgfewBKjatJZJW6','Pasando las fiestas a solas','https://i.scdn.co/image/ab67616d0000b273a0e93f3bf6188ebf4dd375b9','2022-11-18','','UME - Global Clearing House','','2dd5mrQZvg6SmahdgVKDzh'),('1CBM2sCR7bp28NbQKolWj3','Big Thing (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273132a6f3512eb3891ae2e900e','2010-11-23','','㈜뮤직앤뉴','','2dd5mrQZvg6SmahdgVKDzh'),('1cr5KDS2Dc3orNNlrjcXH0','Come to My Dream','https://i.scdn.co/image/ab67616d0000b273ca8eedf4d3c33f19319fb9d2','2025-04-22','','CAM','','7c1HgFDe8ogy5NOZ1ANCJQ'),('1Cu9w3jFSFKHa1YckwnUFW','2step (feat. Chefin)','https://i.scdn.co/image/ab67616d0000b27368c6df560c0a27f39363cd1f','2022-05-16','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('1CUXs8F2dNEVkvHMgTAvuo','un2verse','https://i.scdn.co/image/ab67616d0000b27335c0bc775111faf8e1f718b6','2017-07-13','','케미컬레코드로','','3hvinNZRzTLoREmqFiKr1b'),('1dsqoLcQu75e2FH01Nea1Z','Angel Pt. 2 (Acoustic Version)','https://i.scdn.co/image/ab67616d0000b27379f6a219e637ccf7305d622d','2023-07-13','','APG Inc – FF10','','3Nrfpe0tUJi4K4DXYWgMUX'),('1eDd1PagdKGB4pwmjtxwWi','Kubu','https://i.scdn.co/image/ab67616d0000b273109f78ca178ff6693b229d5b','2019-11-29','','Content Connect Africa','','2dd5mrQZvg6SmahdgVKDzh'),('1EfybmRERwLgkDUm1IGreF','The Secret Life of My Secretary Pt. 4 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273e61f231e3f97eefc9d85379d','2019-05-14','','㈜뮤직버디','','7c1HgFDe8ogy5NOZ1ANCJQ'),('1EMYSiKKTSKLZrOC2nTStL','; [Semicolon]','https://i.scdn.co/image/ab67616d0000b273aa12f5b5b2ea88f26ab76846','2020-10-19','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('1EoDsNmgTLtmwe1BDAVxV5','Red','https://i.scdn.co/image/ab67616d0000b27396384c98ac4f3e7c2440f5b5','2012-10-22','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1eSEUUZ08muf0RLN2s0Lki','Snail mail','https://i.scdn.co/image/ab67616d0000b273949f4ad56d35a2da92a98de6','2018-12-14','','C9 ENTERTAINMENT','','6GwM5CHqhWXzG3l5kzRSAS'),('1f5xm4vrWYjq6SXgWj9Dm5','HOT (LE SSERAFIM Package)','https://i.scdn.co/image/ab67616d0000b273e721dd048f1511401d6f1ea0','2025-03-18','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('1fnJ7k0bllNfL1kVdNVW1A','Midnights (The Til Dawn Edition)','https://i.scdn.co/image/ab67616d0000b273fa747621a53c8e2cc436dee0','2023-05-26','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1FoKSB8Kc39zc9exXYtNu8','Eve, Psyche & the Bluebeard’s wife (English Ver.)','https://i.scdn.co/image/ab67616d0000b2736d58843621783cd5abff29ab','2023-07-06','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('1fZZFPgIGWwGLGdaBtfTB2','Bloom','https://i.scdn.co/image/ab67616d0000b273500f71e6ab13c72c8870f223','2022-04-06','','AVEX ENTERTAINMENT INC.','','1z4g3DjTBBZKhvAroFlhOM'),('1geA7d12ed5LXsBns7ONB4','Just Look Up (From Don’t Look Up)','https://i.scdn.co/image/ab67616d0000b2739675cabe34ef4cc14556ea35','2021-12-03','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('1GHkv48TNqI8MKWJ1FwKFC','Remember The Name (feat. Eminem & 50 Cent)','https://i.scdn.co/image/ab67616d0000b2739ebea6df6ef9d8766fc458fa','2019-07-11','','Atlantic Records UK','','7dGJo4pcD2V6oG8kP0tJRR'),('1GRocMBU2hYD29hexD5UVF','FANCY YOU','https://i.scdn.co/image/ab67616d0000b2730a19a3bc8b5350c676d64bcf','2019-04-22','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('1GtPnOiHxCnoZPCiLcKj22','I am','https://i.scdn.co/image/ab67616d0000b273f8f78670dcb7eb6f7a4405d4','2018-05-02','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('1GtpQlCKGVslJZAqNQKvNf','Thirtieth Midnight (Romance 101 X YOUNHA)','https://i.scdn.co/image/ab67616d0000b27389dcc527e35bf9fa01866284','2021-02-08','','TOON STUDIO, NEUL','','6GwM5CHqhWXzG3l5kzRSAS'),('1gUHUwFatRqQTbXQue2jh7','Wish 2025','https://i.scdn.co/image/ab67616d0000b2733512018238c1eefc8b06e538','2024-11-11','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('1gUI4keDXbeSil6rwY9qUm','Recovery (Deluxe Edition)','https://i.scdn.co/image/ab67616d0000b2731afee6fb3a4ca2f049dd69b5','2010-06-21','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('1hB3iV5P0TWzpdxreKH4sT','HEAT','https://i.scdn.co/image/ab67616d0000b27338b637c18077ddfd08f501c7','2023-10-05','','CUBE ENTERTAINMENT INC./88rising Music','','2AfmfGFbe0A0WsTYm0SDTx'),('1HfTA0xDoZ0mswFO3GB3ef','Midas Touch','https://i.scdn.co/image/ab67616d0000b27307568782625b85282541394b','2024-04-03','','S2 ENTERTAINMENT INC.','','4TEK9tIkcoxib4GxT3O4ky'),('1hlYRB6IT9ycuy06uLgcP7','LOVE, MONEY, FAME (Remixes)','https://i.scdn.co/image/ab67616d0000b2731656387deb79081776473fed','2024-10-18','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('1HwnXJfZx8N8qDfzwUbxcw','2022 Winter SMTOWN : SMCU PALACE','https://i.scdn.co/image/ab67616d0000b273f184dfda8eaeac06fff5e14e','2022-12-26','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('1i7BMtLnINM9MhxwYboUlS','LOVE, MONEY, FAME (feat. DJ Khaled) (Kenia OS Remix)','https://i.scdn.co/image/ab67616d0000b273202e00f258a960cf48cb3bda','2024-11-08','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('1Iso0NydZNFSRIJhc0tV2W','m-flo DJ MIX \"ASOBON! ENKAI\"','https://i.scdn.co/image/ab67616d0000b273e1370439f1982f002abd5736','2013-11-27','','rhythm zone','','4Kxlr1PRlDKEB0ekOCyHgX'),('1IZjO2iVplrs2Evk90Z8jH','GJD','https://i.scdn.co/image/ab67616d0000b273cfe228c467bf3fabac379d00','2020-11-13','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('1JBzeeCJ3axQMVkqWbKh0I','SEVENTEEN 10th Mini Album \'FML\'','https://i.scdn.co/image/ab67616d0000b27380e31ba0c05187e6310ef264','2023-04-24','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('1jEFohZ79xLBF0UxwBdi2V','2009 BIGBANG LIVE CONCERT : BIG SHOW','https://i.scdn.co/image/ab67616d0000b273077b5ae68a75c3e371d69399','2009-04-22','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('1jnye80qSbosbaE7jMP4T0','BIGBANG10 THE CONCERT 0.TO.10 IN SEOUL','https://i.scdn.co/image/ab67616d0000b2738043ee2ff932efccb78d7b40','2017-02-08','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('1JzhfhXn0szpP7Bl2lfTCz','Bad Decisions (with BTS & Snoop Dogg) [Acoustic]','https://i.scdn.co/image/ab67616d0000b2730068960fd03836ea2b747d1b','2022-08-04','','Friends Keep Secrets/Interscope Records','','3Nrfpe0tUJi4K4DXYWgMUX'),('1K9Kpjfdj7Y3MHxuq3M6TK','yes, and? (Felix Jaehn Remix)','https://i.scdn.co/image/ab67616d0000b27346e17cda3c6c13af4bf867fd','2024-01-12','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('1kIk9eo4zjt72NDKn4yPt1','lofi love','https://i.scdn.co/image/ab67616d0000b273a0f2d0576cc60cd4d6378180','2021-07-23','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('1kTlYbs28MXw7hwO0NLYif','Encore (Deluxe Version)','https://i.scdn.co/image/ab67616d0000b273726d48d93d02e1271774f023','2004-11-12','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('1KVKqWeRuXsJDLTW0VuD29','Red (Deluxe Edition)','https://i.scdn.co/image/ab67616d0000b273254c8a09649551438b20f4c0','2012-10-22','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1kVwof28hkDuBxiyCsMNNJ','#TWICE5','https://i.scdn.co/image/ab67616d0000b273d4cbac56cea001cbc17526a6','2025-05-14','','WARNER MUSIC JAPAN INC.','','7n2Ycct7Beij7Dj7meI4X0'),('1kY0kHkLtxqZb0tBqPsIx4','we can\'t be friends (wait for your love)','https://i.scdn.co/image/ab67616d0000b273c5bce200a907e3b21bf20587','2024-03-08','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('1l1WiN1LdJ1eW18CDsMoCo','STRATEGY','https://i.scdn.co/image/ab67616d0000b273ea8fd7aa3b8e8e469f538dc4','2024-12-06','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('1ldyIW90eel4OGhWov8ybM','You Never Walk Alone','https://i.scdn.co/image/ab67616d0000b273e23a7fd165b24c517a66a69f','2017-02-13','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('1lhLoalMsYHp1PTyE1EUZe','Dark & Wild','https://i.scdn.co/image/ab67616d0000b273d76f33d343c35e23e03228c8','2014-08-20','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('1m0adylcFMIeWB94XMaBmi','I GOT YOU','https://i.scdn.co/image/ab67616d0000b273244f65591fa89a2be5972c79','2024-02-02','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('1m2DQC8Oj4uKEJnefEZvTT','Someday','https://i.scdn.co/image/ab67616d0000b27321caf23baca3677705ccbb9b','2008-08-28','','Beyond Music','','6GwM5CHqhWXzG3l5kzRSAS'),('1mgpQrzYhl1tnjGpJSd5A0','I trust','https://i.scdn.co/image/ab67616d0000b273570ea35a902893a619276c29','2020-04-06','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('1MHlOpXB48S9GqnDqnEb69','Psy From The Psycho World','https://i.scdn.co/image/ab67616d0000b2733c526dac1150543009d1db27','2005-10-10','','야마존뮤직','','2dd5mrQZvg6SmahdgVKDzh'),('1MHuZZrGT36cXLxAQ5cLP3','Taylor Swift Karaoke: reputation','https://i.scdn.co/image/ab67616d0000b27305fd6906725e3f12544c2d04','2018-03-09','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1Mo4aZ8pdj6L1jx8zSwJnt','THE TORTURED POETS DEPARTMENT','https://i.scdn.co/image/ab67616d0000b2735076e4160d018e378f488c33','2024-04-18','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1MPAXuTVL2Ej5x0JHiSPq8','reputation Stadium Tour Surprise Song Playlist','https://i.scdn.co/image/ab67616d0000b27363d77f99117b28af9f656918','2017-11-09','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1n4Qyjro1E8gbqKlaZxhyM','Supersonic','https://i.scdn.co/image/ab67616d0000b2739d307da738011aa08940675b','2012-07-03','','CJ E&M','','6GwM5CHqhWXzG3l5kzRSAS'),('1NAmidJlEaVgA3MpcPFYGq','Lover','https://i.scdn.co/image/ab67616d0000b273e787cffec20aa2a396a61647','2019-08-23','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1Ng1HTTrOnKRq9rgRrzMZS','Dresscode (Prod. imase)','https://i.scdn.co/image/ab67616d0000b273149002d6448a0f2fab8393eb','2023-11-20','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('1nknpyvWrIrXH9f8lkO2dQ','The Great','https://i.scdn.co/image/ab67616d0000b2736d227207ab6fe0ade59edb2b','2008-02-27','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('1nScVw87kRJiT2bg2Kswhp','MAP OF THE SOUL : 7 ~ THE JOURNEY ~','https://i.scdn.co/image/ab67616d0000b273da9c76ed020a7894443a3f97','2020-07-14','','Universal Music LLC','','3Nrfpe0tUJi4K4DXYWgMUX'),('1o59UpKw81iHR0HPiSkJR0','1989 (Taylor\'s Version) [Deluxe]','https://i.scdn.co/image/ab67616d0000b273dc2bacae1dca83d26e2b1949','2023-10-27','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1OARrXe5sB0gyy3MhQ8h92','Live At SoFi Stadium','https://i.scdn.co/image/ab67616d0000b273308f9319a3d6f6737f43b3fc','2023-03-03','','Universal Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('1oFrpM19ooBjXWgzVqRueZ','Lonely Lovers','https://i.scdn.co/image/ab67616d0000b273f1ea78ef94c7c6d40577bd3f','2022-09-22','','D-Block Europe','','6eUKZXaKkcviH0Ku9w2n3V'),('1ois1tUq8ewlCUo5sLoUjG','담배','https://i.scdn.co/image/ab67616d0000b27375cc718da9eb0b39bd9cbfb3','2016-04-22','','Genie Music Corporation;Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('1oJztb2MfwieRwHZ1t4NrN','Dirty Work','https://i.scdn.co/image/ab67616d0000b273bf35cc79c5b22b1c19065272','2025-06-27','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('1oniugll0x2gZ3l7o4z9iG','Beautiful Christmas','https://i.scdn.co/image/ab67616d0000b273d3f431dc2bee60eac129a8ba','2022-12-14','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('1PeTPycNpQ5RCGMpfM63dG','READY TO BE','https://i.scdn.co/image/ab67616d0000b273ae875306a5ed9e375328e0dc','2023-03-10','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('1pzvBxYgT6OVwJLtHkrdQK','folklore (deluxe version)','https://i.scdn.co/image/ab67616d0000b273c288028c2592f400dd0b9233','2020-08-18','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1Q9cks7ruxKgspE9EFroNR','Sara Sara','https://i.scdn.co/image/ab67616d0000b273a1b5414e7aafe321995f4ff0','2023-08-15','','HYBE LABELS JAPAN','','7nqOGRxlXj7N2JYbgNEjYH'),('1R9fympoRsZJGpgNvMcJr2','Walkerworld 2.0','https://i.scdn.co/image/ab67616d0000b2736e1d2ec64cdf8aea2aa8bf22','2025-01-10','','Kreatell Music','','2AfmfGFbe0A0WsTYm0SDTx'),('1rE0Gy69MFUh4GuXafWd0f','SEVENTEEN 11th Mini Album \'SEVENTEENTH HEAVEN\'','https://i.scdn.co/image/ab67616d0000b273d07a54abba4f5060c2486e3c','2023-10-23','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('1rfORa9iYmocEsnnZGMVC4','Just Lose It','https://i.scdn.co/image/ab67616d0000b273b6ef2ebd34efb08cb76f6eec','2004-01-01','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('1rJJfVkacZCaEZu4CQdUSI','Malapit na ang pasko, sana ako pa rin','https://i.scdn.co/image/ab67616d0000b2736d50f59afb143383bbc9e817','2024-09-01','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('1S2uDdzV00UPr5kZ7pm6eu','고백하기 좋은 날','https://i.scdn.co/image/ab67616d0000b2731ef1c402549cb68e18af5a68','2007-03-15','','Beyond Music','','6GwM5CHqhWXzG3l5kzRSAS'),('1S3h8ZluVBP3P3RvNbEZsH','Hotel del Luna (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273664b6fcd5a70e4dc6dd01d01','2019-08-31','','Beyond Music','','1z4g3DjTBBZKhvAroFlhOM'),('1SHLOv0DDdRecK60z86Lth','Better Things','https://i.scdn.co/image/ab67616d0000b273c2bcf77ad1fe40f6c7b88609','2023-08-18','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('1SN5xrofTIKJhnd5QNprAh','2step (feat. Denise Chaila)','https://i.scdn.co/image/ab67616d0000b27310041984d373969f02553ffb','2022-05-25','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('1sysmn95tSsSfmXxr9RwhD','PARTY','https://i.scdn.co/image/ab67616d0000b2733e4489cb5ce370e7b397d201','2015-07-07','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('1SzinCWYnLCaqnsvk0V3ev','Choices','https://i.scdn.co/image/ab67616d0000b2739231872c2eb2b4afcca4e33d','2023-01-08','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('1Uan6YJ5YxCfcH9sLgRBMB','Fall Vibes 2021','https://i.scdn.co/image/ab67616d0000b273800579a7673810a5dd978275','2021-09-06','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('1upLfaShcnjVjey0FdY7aO','x (10th Anniversary Edition)','https://i.scdn.co/image/ab67616d0000b273eeef5eff0ccede9a1c9c30b4','2024-06-21','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('1V0NhpGFvzmRxrpHMQtHrU','Angel Pt. 2 (feat. Jimin of BTS, Charlie Puth & Muni Long) (Sped Up) [FAST X Soundtrack]','https://i.scdn.co/image/ab67616d0000b273deaa79daadaf2236d1ac1003','2023-06-28','','APG Inc – FF10','','3Nrfpe0tUJi4K4DXYWgMUX'),('1v8OP8prEC0luhaal9pnNp','Kids Pop','https://i.scdn.co/image/ab67616d0000b273609e753409c11285dfa7647a','2019-12-13','','Rhino','','41MozSoPIsD1dJM0CLPjZF'),('1vhNGBTFoaSTLbHjPGFIlF','Wings','https://i.scdn.co/image/ab67616d0000b2738bd5d941f9ced8e7f9c60dd4','2016-10-10','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('1vuZRBjsQH7B8x6wLFe9nz','MAP OF THE SOUL : PERSONA','https://i.scdn.co/image/ab67616d0000b27346d3e73ccbfde4ee771b7e76','2019-04-12','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('1WbQyGStJ0mCsk3BYocx3G','The Station Agent','https://i.scdn.co/image/ab67616d0000b27374a5428974562b768fc10b70','2006-10-24','','Camobear Records','','2dd5mrQZvg6SmahdgVKDzh'),('1weCtwUO67iYwytGnHZGfR','Just as We Were','https://i.scdn.co/image/ab67616d0000b273badaffd95d6a0b679d5b4134','2024-06-18','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('1WMHx2pByCuT41GF5NHU3O','I DO','https://i.scdn.co/image/ab67616d0000b2739aa637f3bf3921826d14018c','2023-07-13','','CUBE ENTERTAINMENT INC./88rising Music','','2AfmfGFbe0A0WsTYm0SDTx'),('1WyHAY8OWdfCFWTF0Ufwjj','Mr. Mr. - The 4th Mini Album','https://i.scdn.co/image/ab67616d0000b27341e9e282e569b2279c2171de','2014-02-24','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('1WZxSwKyl6AhAimpOhcQk1','D.O.P.E.','https://i.scdn.co/image/ab67616d0000b273278c0f79db8dfdf8d6255b34','2018-04-13','','D.O Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('1XAFe5PYd46p6GA4Ckc4Hb','THE STORY BEGINS','https://i.scdn.co/image/ab67616d0000b2730508313c0d53aee1cdb276e2','2015-10-20','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('1Xbgg8jYNMEiF6eQc4OBak','김형석 With Friends','https://i.scdn.co/image/ab67616d0000b2735496310e93607aa38fca338e','2006-04-13','','더늠이엔티','','2dd5mrQZvg6SmahdgVKDzh'),('1XMYvsHRt52sMi6wittWqI','ELEVEN','https://i.scdn.co/image/ab67616d0000b273da343b21617aac0c57e332bb','2021-12-01','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('1xn54DMo2qIqBuMqHtUsFd','x (Deluxe Edition)','https://i.scdn.co/image/ab67616d0000b27313b3e37318a0c247b550bccd','2014-06-21','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('1XrV5Ca9RBIkxOc8Acq5oQ','BOY','https://i.scdn.co/image/ab67616d0000b273cc0ad45f02a0bfe1f9a9d6dd','2018-09-04','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('1Y1jmGlB01hyovgdy3wMqq','Fire! (feat. YUQI ((G)I-DLE), JVKE)','https://i.scdn.co/image/ab67616d0000b273ebe2594b98400881a9de61c4','2023-12-14','','Kreatell Music','','2AfmfGFbe0A0WsTYm0SDTx'),('1y8b4LYFLsl9dOON8hA5iQ','Power Up (Japanese Version)','https://i.scdn.co/image/ab67616d0000b273c9dae9b7fd90e153b611842a','2019-04-24','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('1YCj4PZi08G20y2ekGKY0C','EASY','https://i.scdn.co/image/ab67616d0000b273110f5426b8c149e80804912a','2024-02-19','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('1ycoesYxIFymXWebfmz828','Live From Clear Channel Stripped 2008','https://i.scdn.co/image/ab67616d0000b273c031e8322b3e8684536ed6d0','2008-06-28','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1yGbNOtRIgdIiGHOEBaZWf','1989 (Deluxe)','https://i.scdn.co/image/ab67616d0000b27352b2a3824413eefe9e33817a','2014-01-01','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('1YPWxMpQEC8kcOuefgXbhj','Guitar Songs','https://i.scdn.co/image/ab67616d0000b2737a4781629469bb83356cd318','2022-07-21','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('1Z0XtKcevvITZ5ydimkYcx','bitches broken hearts','https://i.scdn.co/image/ab67616d0000b273408b5dbd24ad9f44bb1af72f','2018-03-30','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('1ZrWlhMUoyMKsoQ1tvRR2t','Sapphire','https://i.scdn.co/image/ab67616d0000b2736fbb60d6a7e03ccb940a518e','2025-06-05','','Gingerbread Man Records / Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('20GxuSxICpXyRYkoqRjthR','224','https://i.scdn.co/image/ab67616d0000b273ed8f6ba97a5f0bda2b9d9306','2025-06-09','','S2 ENTERTAINMENT INC.','','4TEK9tIkcoxib4GxT3O4ky'),('20wq0dFrgEhhulGXqnb4A6','Anti-Hero (ILLENIUM Remix)','https://i.scdn.co/image/ab67616d0000b273eb7289d463cd524a93b722c9','2022-11-18','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('20XfhxRHpVhsBlrfByTgDK','PSY 2집','https://i.scdn.co/image/ab67616d0000b273272f6ed25533feaa5c9d7890','2005-10-10','','야마존뮤직','','2dd5mrQZvg6SmahdgVKDzh'),('21mnRCzvXqfiY0uRePOEav','WE MAKE YOU','https://i.scdn.co/image/ab67616d0000b2735a11736fddaacee3e7729c95','2018-05-30','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('22ryIcPpUrblmpK3nxBOtX','BAND','https://i.scdn.co/image/ab67616d0000b273674c883dd862de92cdaae074','2019-06-08','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('23QXJaU2bvmzMLocoDWmRa','Taken Chances','https://i.scdn.co/image/ab67616d0000b273bcbeede4ac45f4763d548b90','2018-10-02','','Rocketboyz','','4Kxlr1PRlDKEB0ekOCyHgX'),('23uCYiDGcfNkrKbGAfMTLx','Call on me (feat. Ed Sheeran)','https://i.scdn.co/image/ab67616d0000b273e450659d3b3a3184e7445f75','2022-10-07','','Tôt Ou Tard','','6eUKZXaKkcviH0Ku9w2n3V'),('23yd1cYlPgl643vE8bb0WD','MORE','https://i.scdn.co/image/ab67616d0000b273f5aba3392389512e824d7b2a','2020-10-28','','Riot Games','','2AfmfGFbe0A0WsTYm0SDTx'),('24lMM7McdJmSBgbFhKGugA','The King and I (feat. CeeLo Green) [From the Original Motion Picture Soundtrack ELVIS]','https://i.scdn.co/image/ab67616d0000b273de335339b8c7223760c3add0','2022-06-16','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('24Uj6VdVytaReqt1KJWxfc','24H','https://i.scdn.co/image/ab67616d0000b2735e0415248f47b27441faa0ac','2020-08-24','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('25FGyvj0UnD6YYWLq0s9nl','Bellyache','https://i.scdn.co/image/ab67616d0000b2734adbeb26299adca766cec2c5','2017-02-24','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('25zSh5FAL8kUh8z7ivwBH6','Venom (Music From The Motion Picture)','https://i.scdn.co/image/ab67616d0000b2731b95097dd6e47dfb02b315c8','2018-09-21','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('26adxLsliyYcCfVTF6xA75','WINE','https://i.scdn.co/image/ab67616d0000b2732c0252c4e4a988f024e4d262','2017-04-27','','Million Market,Inc','','3hvinNZRzTLoREmqFiKr1b'),('26BVW2fB6RYz2TpyJNSMwC','Jewelry (Prod. imase)','https://i.scdn.co/image/ab67616d0000b2730662228b7c80d75484d3b17b','2023-07-25','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('26IdRjba8f8DNa7c0FwfQb','ALL OUT','https://i.scdn.co/image/ab67616d0000b273f2bf9685109a09bdc176fb43','2020-11-06','','Riot Games','','7n2Ycct7Beij7Dj7meI4X0'),('26iFbCpQBTif2lNyAM7tEo','Oh My! (Chinese ver.)','https://i.scdn.co/image/ab67616d0000b273a7006bf03659d70e9402eea9','2018-08-28','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('26u9H3Dak9gqu7UjHfz1Kk','We Made You (International Version)','https://i.scdn.co/image/ab67616d0000b27306f6186ccf893ca5d50de256','2009-04-07','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('27cBQ5FDqv0xLgiJ7qNpZr','Ice Cream Cake - The 1st Mini Album','https://i.scdn.co/image/ab67616d0000b2733beb8877c3a0cde5be9a139c','2015-03-17','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('27MinVecOC86J4TmHk6S03','Perfect World','https://i.scdn.co/image/ab67616d0000b27363d4ede0680577b00efb03da','2021-07-28','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('288v8m1tfdFxQWyQYlW0ve','Bored','https://i.scdn.co/image/ab67616d0000b273c766a35e710c66f842f47a49','2021-10-05','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('28MLKcX9YRhPg6QYIMlhzP','Best Friends <3','https://i.scdn.co/image/ab67616d0000b2739a144b2a0722764e1297e89f','2024-08-23','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('28Orm6S3LezppbfYdgA3aI','TROLLS World Tour (Original Motion Picture Soundtrack)','https://i.scdn.co/image/ab67616d0000b273efa58e65fc9003282883ac51','2020-03-13','','RCA Records Label','','1z4g3DjTBBZKhvAroFlhOM'),('29dyjY5NipwZnTJcemohb1','BigBang Is V.I.P','https://i.scdn.co/image/ab67616d0000b273fdc981395ea990ca523480d6','2006-09-28','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('2A7zvwzdytLmGjAjh6oDwI','KPOP Rhythm, Flow & Tone Vol. 3','https://i.scdn.co/image/ab67616d0000b273468adb1988aab6d74aa0b2ed','2018-10-27','','Blue Pie Records USA','','2dd5mrQZvg6SmahdgVKDzh'),('2AyexmwyUy1nZfBadyewL7','ilomilo (Live From The Film - Billie Eilish: The World’s A Little Blurry)','https://i.scdn.co/image/ab67616d0000b27398a3d331aad09aede2a9dcad','2021-02-22','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('2aYIs6VLwMLzONDdVtNOe6','Last One Standing (feat. Polo G, Mozzy & Eminem) [From Venom: Let There Be Carnage]','https://i.scdn.co/image/ab67616d0000b273eec04d194051bbdb926922b0','2021-10-05','','Shady Records/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('2b4JQKXl0gwf3bnAfhZwLA','Run Devil Run - The 2nd Album Repackage','https://i.scdn.co/image/ab67616d0000b273286903a9b4f8bce214f1dffa','2010-03-22','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('2BJzRehqZMKrajV0uRHzeU','School Rapper3 Final','https://i.scdn.co/image/ab67616d0000b273950489f09455bc8ac05fd6c8','2019-04-13','','Genie Music Corporation','','3hvinNZRzTLoREmqFiKr1b'),('2BNimvLLlD89e4Sb7ZVX6I','SEVENTEEN 4th Mini Album ‘Al1’','https://i.scdn.co/image/ab67616d0000b273005799610338a5b57d865926','2017-05-22','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('2bXp5bEM5sgZdIznTesQZb','Wake Up (Standard Edition)','https://i.scdn.co/image/ab67616d0000b2731bfda04c5a3714b6225e4ddc','2014-12-24','','PONY CANYON INC.','','3Nrfpe0tUJi4K4DXYWgMUX'),('2cBuoAocFtOZU31Tk6UmTt','I feel','https://i.scdn.co/image/ab67616d0000b27357de3da10da259d0a19a81b4','2023-05-15','','CUBE Entertainment','','2AfmfGFbe0A0WsTYm0SDTx'),('2CIOGAByaHyjQ1EO55JSzC','= (Tour Edition)','https://i.scdn.co/image/ab67616d0000b273737c1bef4d45db62ac6dd2f1','2022-05-27','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('2cWBwpqMsDJC1ZUwz813lo','The Eminem Show','https://i.scdn.co/image/ab67616d0000b2736ca5c90113b30c3c43ffb8f4','2002-05-26','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('2cXtPWMSKgf55ERnDrzZQb','DREAM','https://i.scdn.co/image/ab67616d0000b2735fd71030aee6507ffa659b25','2022-11-08','','HYBE LABELS JAPAN','','7nqOGRxlXj7N2JYbgNEjYH'),('2cyomPgx2iBZXnBKO8Fmxi','SUMMER FESTA','https://i.scdn.co/image/ab67616d0000b27338879c9f174639b75ee0a6a7','2024-06-28','','STARSHIP ENTERTAINMENT','','6RHTUrRF63xao58xh9FXYJ'),('2CzbrboOLzeRoaaH1N5K0N','Next Level','https://i.scdn.co/image/ab67616d0000b2737a393b04e8ced571618223e8','2021-05-17','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('2DDpMnfauLuwySOIahqydf','That I Want','https://i.scdn.co/image/ab67616d0000b2734aa22f545126287f73647ced','2014-12-03','','파이니스트 레코즈','','7c1HgFDe8ogy5NOZ1ANCJQ'),('2DQ6hHlAGj6DiT0Y068bnK','The Marshall Mathers LP (25th Anniversary)','https://i.scdn.co/image/ab67616d0000b2736bf50bce76d3437f1b0e1589','2025-05-23','','Eminem Catalog PS','','7dGJo4pcD2V6oG8kP0tJRR'),('2DTATWEmzMCckJka5QZiJC','Summer Nights','https://i.scdn.co/image/ab67616d0000b2737273f7429b224f9df3304108','2018-07-09','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('2dVrXV8hgovfKK7nPZkYFi','I NEVER DIE','https://i.scdn.co/image/ab67616d0000b2736a890b3addcdd0ba685099cc','2022-03-14','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('2eIjByPSAvov7cdnzpohZB','BIGBANG JAPAN DOME TOUR 2017 -LAST DANCE- : THE FINAL','https://i.scdn.co/image/ab67616d0000b273baa2444671de8ec216082838','2018-08-17','','YGEX','','4Kxlr1PRlDKEB0ekOCyHgX'),('2Exrc2wOTBawEZrac9X4Yz','07 WINTER SMTOWN','https://i.scdn.co/image/ab67616d0000b273733b848b489b8459a49c2b8c','2007-12-07','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('2F2182udLz3A8XOl7lb7Bs','Eclipse en Aries','https://i.scdn.co/image/ab67616d0000b273320d9a575cc77d1951d880e6','2024-04-27','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('2faf1Ybp0M3FniNBhjD9VH','EMPIRE REMIXES','https://i.scdn.co/image/ab67616d0000b273379cc346524faaf090023c61','2019-11-15','','Unicorn Pop','','2AfmfGFbe0A0WsTYm0SDTx'),('2fenSS68JI1h4Fo296JfGr','folklore','https://i.scdn.co/image/ab67616d0000b27395f754318336a07e85ec59bc','2020-07-24','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('2FgijdlNnEdH4KJMK8Nae7','Photographer','https://i.scdn.co/image/ab67616d0000b2735427b83a375dedbf17776de4','2015-03-24','','파이니스트 레코즈','','7c1HgFDe8ogy5NOZ1ANCJQ'),('2Fna4Tb7fme5aHsNMJtVtp','SQUARE TWO','https://i.scdn.co/image/ab67616d0000b27318a4a215052e9f396864bd73','2016-11-01','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('2FnZovXqijouIhIA6jg3uT','No place to hide','https://i.scdn.co/image/ab67616d0000b273979eb5a8ab7a45ae2212d78f','2021-11-07','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('2fpQB21ER6ETvnfADPdaHl','BIGBANG Special Edition','https://i.scdn.co/image/ab67616d0000b2739c5b430d50a981f5c9bbf6d2','2011-04-08','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('2fYhqwDWXjbpjaIJPEfKFw','thank u, next','https://i.scdn.co/image/ab67616d0000b27356ac7b86e090f307e218e9c8','2019-02-08','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('2fyOpT5c9kxR8zbDh6UtXh','Save Your Tears (Remix)','https://i.scdn.co/image/ab67616d0000b273c6af5ffa661a365b77df6ef6','2021-04-23','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('2gNPnKP1PDkB5SZz3IMKuX','THE ALBUM','https://i.scdn.co/image/ab67616d0000b2731895052324f123becdd0d53d','2020-10-02','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('2gP2LMVcIFgVczSJqn340t','Fearless (Platinum Edition)','https://i.scdn.co/image/ab67616d0000b27373b565ab9d713e8d5586aac2','2008-11-11','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('2H5nzViLpbX8JzY1cQMVza','Angel Pt. 1 (feat. Jimin of BTS, JVKE & Muni Long) (FAST X Soundtrack)','https://i.scdn.co/image/ab67616d0000b273be4afaf12bdbcfd17d95f22b','2023-05-18','','APG Inc – FF10','','3Nrfpe0tUJi4K4DXYWgMUX'),('2hBJR1SQ4cGDjGTCY6eV8m','NANGMAN','https://i.scdn.co/image/ab67616d0000b273f7f424835917fbc40ca79456','2022-06-09','','H1GHR MUSIC RECORDS','','3hvinNZRzTLoREmqFiKr1b'),('2hEMlZ7Aip6kqJX51u3vgq','화양연화 Pt.1','https://i.scdn.co/image/ab67616d0000b273bb3a9b4499210e3786c2683f','2015-04-29','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('2hGIulY9CjIWsQ8Rqed6fZ','혜성','https://i.scdn.co/image/ab67616d0000b27392dc1c9cc21892c8cb0b829a','2007-10-23','','(주)케미컬레코드','','6GwM5CHqhWXzG3l5kzRSAS'),('2HgoMNl1FxKwSFSqGMZvGO','UNFORGIVEN','https://i.scdn.co/image/ab67616d0000b27318570abedb423aa2c46d61ab','2023-08-23','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('2hyDesSAYNefikDJXlqhPE','5','https://i.scdn.co/image/ab67616d0000b2732fec3ad10ab2f3a637e7a127','2014-06-20','','Gingerbread Man Records','','6eUKZXaKkcviH0Ku9w2n3V'),('2I8zuxlL9KuFAGRsSq9mTT','EMPIRE','https://i.scdn.co/image/ab67616d0000b273e19edfc213998b27c511bd1e','2019-10-18','','Unicorn Pop','','2AfmfGFbe0A0WsTYm0SDTx'),('2I9wpUTuzMT8aS6iVpM2EQ','Bellyache (Marian Hill Remix)','https://i.scdn.co/image/ab67616d0000b273b16b427371c5fdd76f1b0ee1','2017-05-05','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('2igar5ui3UzhSPl6DsO1O2','glow forever','https://i.scdn.co/image/ab67616d0000b2739d3f5cb55aab7c68e12113eb','2018-09-07','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('2ij1gxDXIbE3k8LkzgcFX1','Celebrate','https://i.scdn.co/image/ab67616d0000b273cb46851a80f10af1aef7f14f','2022-07-27','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('2jae5Jx8Yh1WjP1K4wTFUa','Film out','https://i.scdn.co/image/ab67616d0000b27334938530af5d2d98acf174fc','2021-04-01','','Universal Music LLC','','3Nrfpe0tUJi4K4DXYWgMUX'),('2JBcpvNYviZ9VYva3jRPsd','Dynamite (Holiday Remix)','https://i.scdn.co/image/ab67616d0000b273c491d6dc21006984d308aed6','2020-12-11','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('2jEFKhESvCLGpFP8KwpV2T','Christmas Tree Farm','https://i.scdn.co/image/ab67616d0000b27354388d58a45d272d88b9e382','2021-11-22','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('2jFN9fhZOqOLIwMQswMwZz','TIK TOKER - DANCE POPS BEST','https://i.scdn.co/image/ab67616d0000b2730eb2e58a1bd68bfbecd2800a','2024-12-13','','MUSIC LAB JPN','','41MozSoPIsD1dJM0CLPjZF'),('2jK7H4A5Y2xJaoOyzBedaS','iScreaM Vol.18 : Girls Remixes','https://i.scdn.co/image/ab67616d0000b2730d1cda2195c32c0b6d36ed0f','2022-10-21','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('2Jrp37x38qZqtyrIrfxN4H','SEVENTEEN BEST ALBUM \'17 IS RIGHT HERE\'','https://i.scdn.co/image/ab67616d0000b2736c498180e56f57e7d7bcdb86','2024-04-29','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('2jTAGPtLTI71MyRhTITbyi','Rain Song','https://i.scdn.co/image/ab67616d0000b273c26c00f8ce7f5703bf7e27b0','2022-06-30','','C9 Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('2KAy3MoOI7qjOyZESHUNil','Martian Xmas 2004','https://i.scdn.co/image/ab67616d0000b27343c9d6d6d8bcd0e6578d48fe','2007-01-09','','Legendary Entertainment','','2dd5mrQZvg6SmahdgVKDzh'),('2km2gV8HN1lk1e1GEDl7SN','Bad Decisions (with BTS & Snoop Dogg)','https://i.scdn.co/image/ab67616d0000b2738c47a33a55c6d23cc9d2cf3f','2022-08-05','','Friends Keep Secrets/Interscope Records','','3Nrfpe0tUJi4K4DXYWgMUX'),('2kzPJWrTjVKEYWWhowXLnz','Happier Than Ever (Edit)','https://i.scdn.co/image/ab67616d0000b27331aa3ebe23f59778bff800c9','2021-07-28','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('2LeAF5OEfrQBNGz2sokRIN','MOONLIGHT SUNRISE (The Remixes)','https://i.scdn.co/image/ab67616d0000b2734bd760dfda6f2e151bd3bdb4','2023-01-24','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('2lEEMlajrNy5pDR4qNAeL2','Melodías para un día lluvioso','https://i.scdn.co/image/ab67616d0000b2736e5a80eac95b7ba40a681265','2023-06-09','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('2LxgNEltTac4zQAsiNmn1K','2008 SUMMNER Festival - 낙원','https://i.scdn.co/image/ab67616d0000b2738b527f30745243e7afe5eaab','2008-08-13','','오감엔터테인먼트','','2dd5mrQZvg6SmahdgVKDzh'),('2mr6tc72GnDU2RJoLCQ1qX','Campaign Speech','https://i.scdn.co/image/ab67616d0000b273160f0062ae108225459d94c8','2016-10-19','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('2MxQfPUf94pKYZ2AzhOxYX','YES or YES','https://i.scdn.co/image/ab67616d0000b2737ec56cd0f32a2eb8c3bd8e8c','2018-11-05','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('2N63pqJIn1Ro8yIbwV54Gh','Wonderful Days','https://i.scdn.co/image/ab67616d0000b273db4a84ee5cf89e45002e2d20','2024-01-30','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('2Ng7FzZoNzpj4z8VRDHyb5','SEVENTEEN 6th Mini Album \'YOU MADE MY DAWN\'','https://i.scdn.co/image/ab67616d0000b273428011fc6beff5e3637b2adf','2019-01-21','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('2nLEiP268mSFZHW5dajM4R','‘The ReVe Festival’ Day 1','https://i.scdn.co/image/ab67616d0000b27370a04b3e66d6a4a38237dc7f','2019-06-19','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('2nLOHgzXzwFEpl62zAgCEC','Dawn FM','https://i.scdn.co/image/ab67616d0000b2734ab2520c2c77a1d66b9ee21d','2022-01-06','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('2O0QmR1oXCc70QLwYDn03z','TWO','https://i.scdn.co/image/ab67616d0000b273f34ca6f3b84bb6a141645086','2025-06-15','','CAM','','7c1HgFDe8ogy5NOZ1ANCJQ'),('2O1NYIBQCUobrL97A2Unk8','All Too Well (10 Minute Version) (The Short Film)','https://i.scdn.co/image/ab67616d0000b2738e16c6e20dbed531a9006d58','2022-06-11','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('2o35lokKrBVG73xWFDEVsX','Welcome To MY World (feat. nævis)','https://i.scdn.co/image/ab67616d0000b273220771be23654c95cf787349','2023-05-02','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('2oCAY48bhZvQte0l7apmYC','Still Life','https://i.scdn.co/image/ab67616d0000b273eb136d1be54b1ef8273c0699','2022-04-05','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('2oCdz6yL3LoOu5fpJzEO0j','This Time Around (feat. (G)I-DLE)','https://i.scdn.co/image/ab67616d0000b2730a873d3d3501229989f4985b','2024-03-15','','BMG Rights Management (US) LLC','','2AfmfGFbe0A0WsTYm0SDTx'),('2ODvWsOgouMbaA5xf0RkJe','Starboy','https://i.scdn.co/image/ab67616d0000b2734718e2b124f79258be7bc452','2016-11-25','','Universal Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('2OicPkzxga0ybQIdl3kvaa','13 Reasons Why (A Netflix Original Series Soundtrack)','https://i.scdn.co/image/ab67616d0000b2738e0cf26ddc14f90080a62aac','2017-03-30','','UMGRI Interscope','','6qqNVTkY8uBg9cP3Jd7DAH'),('2OqSK4OKrorvnUzYunU2lX','twilight zone','https://i.scdn.co/image/ab67616d0000b273b4c11653d2266c812c2c372d','2025-06-20','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('2Ov7bn3HyDgvAxtYPLosUR','Die Trying','https://i.scdn.co/image/ab67616d0000b27311c27127b91e1e4266152362','2024-04-04','','Netflix Music','','6YVMFz59CuY7ngCxTxjpxE'),('2p8kwtp4kEetYWm3rkuHhm','British R&B','https://i.scdn.co/image/ab67616d0000b273d790d4f4a1ac4b667fa00118','2022-08-19','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('2P8trIADhHx8fJAdC7ud40','Better Things (Dance Remix)','https://i.scdn.co/image/ab67616d0000b273912ace777590a8b0bf419ecc','2023-10-27','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('2PIReru2w5i4JXOzeZnamd','SEVENTEEN 9th Mini Album \'Attacca\'','https://i.scdn.co/image/ab67616d0000b2735ac2a400576ac7f35aa7428b','2021-10-22','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('2pUO0HmIBlq5lHf2LNH4vz','DIAMOND','https://i.scdn.co/image/ab67616d0000b273df34da1059f108dc73d988f8','2022-11-10','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('2pzsLCXw4eZgLm7oZ0qH6T','R&B Workout','https://i.scdn.co/image/ab67616d0000b2737a53cc81a5d0f351582fbee9','2021-12-31','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('2qEugS42uGnquWJnufwjyg','Hoot - The 3rd Mini Album','https://i.scdn.co/image/ab67616d0000b2738836e229149c876eb60c7885','2010-10-27','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('2qgl7dAgslqL1w2l2wQhMA','The Velvet - The 2nd Mini Album','https://i.scdn.co/image/ab67616d0000b27381fb7e4e392f0a99b3947eb6','2016-03-17','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('2qJd6dBsXw6hZrZp8L8n2P','Realest (with Eminem)','https://i.scdn.co/image/ab67616d0000b273028304d574a1cccf70a7196a','2023-08-04','','FFP Records, Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('2QVMdof1Ou4jlfZ6dXsthA','Op.1','https://i.scdn.co/image/ab67616d0000b273e8d4f1da2a6dd26a6424e5df','2025-05-07','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('2R8RsIMCdiNxkQVD96kDDW','Last Dance (Prod. GroovyRoom)','https://i.scdn.co/image/ab67616d0000b27334651aefa1df132b6169ab66','2021-04-29','','Klap Entertainment','','2AfmfGFbe0A0WsTYm0SDTx'),('2RDD8P05XICfiKEgFoKiNf','Bad Decisions (with BTS & Snoop Dogg) [Instrumental]','https://i.scdn.co/image/ab67616d0000b273ea1d87e91622139feace98f2','2022-08-03','','Friends Keep Secrets/Interscope Records','','3Nrfpe0tUJi4K4DXYWgMUX'),('2rTc5TdRP7hr7gE4h4lUR1','Pokémon 2023 (Original TV Series Soundtrack, Korea)','https://i.scdn.co/image/ab67616d0000b2739652d22bb039c408990dcc7b','2023-08-23','','㈜포켓몬코리아','','6YVMFz59CuY7ngCxTxjpxE'),('2rwRvLdjGzjSYl9AS3UbvH','Girls - The 2nd Mini Album','https://i.scdn.co/image/ab67616d0000b273ea957604eae136d0681ceaff','2022-07-08','','Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('2sBB17RXTamvj7Ncps15AK','lovely (with Khalid)','https://i.scdn.co/image/ab67616d0000b2738a3f0a3ca7929dea23cd274c','2018-04-19','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('2SfolP7nZFrWM6n5f1R2nU','화양연화 Young Forever','https://i.scdn.co/image/ab67616d0000b2738158cfca68b90f35eb59059e','2016-05-02','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('2SPrl8C8pgSM5gXbAiyJHY','MADE','https://i.scdn.co/image/ab67616d0000b273fd0d9a33127c1d3f58ba3504','2016-12-13','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('2SrJI9UCeYzVXYripQVnbi','Happy Ending','https://i.scdn.co/image/ab67616d0000b273a8ea7247e4dbd251757826d1','2019-05-29','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('2TKXGpbrsOCMjcyR1o2Yj1','\'The Boys\' Maxi Single','https://i.scdn.co/image/ab67616d0000b2737c2ad39ea5632b36a7709883','2011-12-21','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('2tVPLB5F9IsgPn4mvLQ7RJ','God of Light Music','https://i.scdn.co/image/ab67616d0000b2737994bb03ec228dde677a37b3','2023-12-25','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('2tx3OgTQe02ygUiWPEevFi','ひとりじゃない','https://i.scdn.co/image/ab67616d0000b273e6aea87b278a6a5d6ba2a9ac','2021-04-15','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('2U1BPwhkzHt05OFugiSB3g','Girls\' Generation','https://i.scdn.co/image/ab67616d0000b2731111b7562b4b46870d27f98b','2007-11-01','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('2UF3SkoMBUZZf5n6sCBUft','PEOPLE','https://i.scdn.co/image/ab67616d0000b273d92868ef7be482079273b352','2020-04-02','','AOMG','','7c1HgFDe8ogy5NOZ1ANCJQ'),('2uMTmPEFafKfKeobvdx5EE','My Everything (Tenth Anniversary Edition)','https://i.scdn.co/image/ab67616d0000b2730fdf1dcbc3e34ed740e12710','2024-08-22','','Universal Records','','66CXWjxzNUsdJxJ2JdwvnR'),('2VqW1LfpB2tbCBi57ITDo0','Pop Collabs','https://i.scdn.co/image/ab67616d0000b273d2ea793366563b216a943975','2022-04-01','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('2VSBGJ8bUuNgmOYXHIQagM','Yours Truly (Tenth Anniversary Edition)','https://i.scdn.co/image/ab67616d0000b273db6ed492fdc27def8f979263','2023-08-25','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('2VVf6P029Bw2sRXV721xui','Eve, Psyche & the Bluebeard’s wife (feat. Demi Lovato)','https://i.scdn.co/image/ab67616d0000b27344ad575bbe0bd1dafbbbb6ca','2023-08-04','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('2W5VVBPNkGAduaArE4sX29','Celestial','https://i.scdn.co/image/ab67616d0000b273c18194a4022ec44507f7b248','2022-09-29','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('2W66jOC3qqVZvLn9foXXbg','Remember','https://i.scdn.co/image/ab67616d0000b273a1fbc93f1f424d133e22cce8','2008-11-05','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('2WFFcvzM0CgLaSq4MSkyZk','- (Deluxe)','https://i.scdn.co/image/ab67616d0000b273a0aea3805ed6a87aa394c796','2023-05-05','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('2WgFks0UOZGD9dtoDox8CC','All Night','https://i.scdn.co/image/ab67616d0000b2739f3dcc7773b57cea7cd7062a','2024-01-19','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('2WpQ6MSsPpTR5T4i7Zpllv','Bus Stop','https://i.scdn.co/image/ab67616d0000b273d4316870fe82bb2a1d16ce01','2013-09-24','','파이니스트 레코즈','','7c1HgFDe8ogy5NOZ1ANCJQ'),('2Wsmvpr9BowD8a09FSfj97','Ass Like That','https://i.scdn.co/image/ab67616d0000b27376a961f15c943dae0b9bb7cf','2005-06-07','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('2x3DiOAtWaoM8loMm1SjBC','Ceezzy Vol. 5 Pausado Num Canto','https://i.scdn.co/image/ab67616d0000b2734b531ce8814f955251682d04','2015-04-08','','GTM','','2dd5mrQZvg6SmahdgVKDzh'),('2xdJzg2ig5qzKFxZOR3CLa','REMAKE & MIX No. 18','https://i.scdn.co/image/ab67616d0000b2732b5ae5165affdcabe28335be','2005-07-22','','MTM Holdings','','2dd5mrQZvg6SmahdgVKDzh'),('2XGEyGU76kj55OdHWynX0S','Trilogy','https://i.scdn.co/image/ab67616d0000b273158c84a1b6f8b935dc7fa9a9','2012-11-13','','Universal Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('2xgi7tCocjnULdraqmheR1','No Time To Die (Original Motion Picture Soundtrack)','https://i.scdn.co/image/ab67616d0000b2736783e68449c6a325f122bc8f','2021-10-01','','Decca (UMO) (Classics)','','6qqNVTkY8uBg9cP3Jd7DAH'),('2xIMZ79GJpZ9Gnti04TiBR','I\'m Not Afraid Anymore','https://i.scdn.co/image/ab67616d0000b2731bdf9aafc68145356002d7f4','2021-10-11','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('2xnqikpcvH2vBYc89VnwwL','Another One Of Me (feat. 21 Savage)','https://i.scdn.co/image/ab67616d0000b273ade39d626a4c337679cf8959','2023-09-15','','Love Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('2Xoteh7uEpea4TohMxjtaq','evermore','https://i.scdn.co/image/ab67616d0000b27333b8541201f1ef38941024be','2020-12-11','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('2xqTa2dCR54yYHEcttiXyD','eternal sunshine deluxe: brighter days ahead (a cappella version)','https://i.scdn.co/image/ab67616d0000b27396094d0c80f0f321da705f88','2025-03-27','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('2yFLu758P5VjG5ZyyHGSrp','A Beautiful Game','https://i.scdn.co/image/ab67616d0000b2735b53eeee082f1e0217acd979','2023-05-04','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('2ZhAZPjsWtCJ6ZDgtl6E63','싸집','https://i.scdn.co/image/ab67616d0000b2731c39964ecb5b15fb7be5b78b','2006-07-24','','MTM Holdings','','2dd5mrQZvg6SmahdgVKDzh'),('31GTeiqu8AUN76bXsnoCq9','BIPOLAR','https://i.scdn.co/image/ab67616d0000b273e62a5159272a6c5616e08289','2020-06-03','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('31hcgCSu4mlA82syOFItur','The Death of Slim Shady (Coup De Grâce): Expanded Mourner’s Edition','https://i.scdn.co/image/ab67616d0000b273333c01a0f55915549caf5623','2024-09-13','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('32iAEBstCjauDhyKpGjTuq','=','https://i.scdn.co/image/ab67616d0000b273ef24c3fdbf856340d55cfeb2','2021-10-25','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('32n91KG3YeLMLJ9e64EfXy','RescuE','https://i.scdn.co/image/ab67616d0000b273d87083079a0cbd66390f4a92','2017-12-27','','C9 ENTERTAINMENT','','6GwM5CHqhWXzG3l5kzRSAS'),('32qkDK7K0Cbzuk6T15eIW1','brb having a bratty halloween party','https://i.scdn.co/image/ab67616d0000b2738307cbbeb2209c74d9725b67','2024-09-24','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('32wEpn8x4sLmt2XGpAFeqs','Find son Three Thousand-Ri','https://i.scdn.co/image/ab67616d0000b2734a50b549e7289d6372a38faa','2007-11-22','','코스틴기획','','0Sadg1vgvaPqGTOjxu0N6c'),('34Iqs74ZJd6PDIeF7hVZi7','ONE SPARK','https://i.scdn.co/image/ab67616d0000b2739dc1faa735a844e7f82d1a9e','2024-02-26','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('35dut3ICqF3NEDkjxfzJJ1','Starboy (Deluxe)','https://i.scdn.co/image/ab67616d0000b2738ad8f5243d6534e03b656c8b','2023-03-14','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('35ln10OEkSWMIuAMXrEPCq','The Feels','https://i.scdn.co/image/ab67616d0000b273bf2483ff121c05fab74bb816','2022-02-04','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('35rJF2VqOuL68utiBI43qD','M','https://i.scdn.co/image/ab67616d0000b2732fd7435aad00c33bbf7dd646','2015-05-01','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('36cJnr7GCuGbuw0YQpjmTY','iScreaM Vol.10 : Next Level Remixes','https://i.scdn.co/image/ab67616d0000b2738bcda1592f94261aaa7c9fe0','2021-09-14','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('37HwcDtLqY2WXN7NArODvI','Azizam','https://i.scdn.co/image/ab67616d0000b273d29a003b6e8d4c1c47bd4da4','2025-04-04','','Gingerbread Man Records / Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('38EuSpoG8AAKgFDkWQZCxx','HOSPITAL PLAYLIST Season2, Pt. 4 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b2735556f8c8f2af06f2cf407ea4','2021-07-09','','Genie Music Corporation, Stone Music Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('38UOWpmcU1eoazWO856i3A','Lonely Nights','https://i.scdn.co/image/ab67616d0000b273f5912188aa13f07d1bca4b3f','2021-08-11','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('395Tpq1Ak19oGniHdQjOSk','Smoke (Remix)','https://i.scdn.co/image/ab67616d0000b2738bc18703825b6448dc06338c','2023-11-02','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('39McjovZ3M6n5SFtNmWTdp','My Universe','https://i.scdn.co/image/ab67616d0000b273f60a9b7e2abafc38da31f575','2021-09-24','','Parlophone UK','','3Nrfpe0tUJi4K4DXYWgMUX'),('3AafSrFIbJPH6BJHiJm1Cd','What Was I Made For? [From The Motion Picture \"Barbie\"]','https://i.scdn.co/image/ab67616d0000b273ed317ec13d3de9e01fb99c9e','2023-07-13','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('3AICoyb5EH2OBmQJnaPDIt','the boy is mine (Remix)','https://i.scdn.co/image/ab67616d0000b273318479c9f214577c1e7077f6','2024-06-21','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('3aTuW4BtsyyyyQa9LKqj8n','Curtain Call 2','https://i.scdn.co/image/ab67616d0000b273145454b151d01ca3305bbd60','2022-08-05','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('3C5xR3pz05iwG0GJpkbIws','Late Night Summer Vibes','https://i.scdn.co/image/ab67616d0000b273dbfd203e8dee4ab34c0ee6b8','2021-08-19','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('3CcgnUkTrUaPTt4Ms1MkoP','FOREVER 1 - The 7th Album','https://i.scdn.co/image/ab67616d0000b273aea29200523b1ee4d5b2c035','2022-08-05','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('3CExk4WgPxe0lOwoOhuMWj','Forever (약속)','https://i.scdn.co/image/ab67616d0000b2737fdc50db3e3b281109f5a831','2021-02-05','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('3ctTWbdrxcHcjwbTKurGTI','Feel Special','https://i.scdn.co/image/ab67616d0000b273b473ceea0d97c5be6d80caf8','2019-09-23','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('3Da8D0E5LyBG7K93PTNjfG','2012 BIGBANG Live Concert: Alive Tour in Seoul','https://i.scdn.co/image/ab67616d0000b273e70d34add915a51f73a9bd57','2013-01-10','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('3dn2in6doTc6zfA0G2UFDZ','2021 Winter SMTOWN : SMCU EXPRESS','https://i.scdn.co/image/ab67616d0000b27326b7dce0a74da7f7f6c7f193','2021-12-27','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('3DXz6ItR9DzIw9S0h3Cxfc','‘The ReVe Festival’ Day 2','https://i.scdn.co/image/ab67616d0000b2733a7804057d817ff9f68ca85c','2019-08-20','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('3eDBRfDPqQVzHLmpCdwJ6J','내 남편과 결혼해줘 OST Part 3','https://i.scdn.co/image/ab67616d0000b27321746610ceddf46b809656e0','2024-01-15','','(주)블렌딩','','7c1HgFDe8ogy5NOZ1ANCJQ'),('3euz4vS7ezKGnNSwgyvKcd','Positions','https://i.scdn.co/image/ab67616d0000b2735ef878a782c987d38d82b605','2020-10-30','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('3EwXdMiTQsuUWRLAUYpbco','Our D-Day OST Part 3','https://i.scdn.co/image/ab67616d0000b27367e5f7226e2989592efe7866','2023-02-05','','RAVEX','','7c1HgFDe8ogy5NOZ1ANCJQ'),('3f8XSIlawxdk1oGTXUbIuX','LOVE DIVE -Japanese version-','https://i.scdn.co/image/ab67616d0000b2739d3b5d695233802eafb6e012','2023-01-16','','Sony Music Labels Inc.','','6RHTUrRF63xao58xh9FXYJ'),('3FLaKp4Xk3Y6LoxznYQVfR','So Fresh, So Cool','https://i.scdn.co/image/ab67616d0000b273f26dde054c5eb5b06ac6227f','2009-04-03','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('3fqYnHqWRVePkZzPQpxclM','Power of Love','https://i.scdn.co/image/ab67616d0000b273d9e02a15b799bc91b4a5af72','2021-11-29','','HYBE LABELS JAPAN','','7nqOGRxlXj7N2JYbgNEjYH'),('3GATj9YiABtlzaoCk7sjdu','House of Girls, Episode 4','https://i.scdn.co/image/ab67616d0000b2731738a92cc3a0e57435a008f7','2025-06-14','','Contents Brick','','3hvinNZRzTLoREmqFiKr1b'),('3gHhPm8z8tid1kvpniUKuK','Armageddon - The 1st Album','https://i.scdn.co/image/ab67616d0000b2730fc598038040859794c600e2','2024-05-27','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('3HcgqKuPvj9ZpqLCny0GWg','Under the Tree (from “That Christmas”)','https://i.scdn.co/image/ab67616d0000b2738c5e02d9f4bfa29203cd3310','2024-11-26','','Gingerbread Man Records','','6eUKZXaKkcviH0Ku9w2n3V'),('3HgoCO9wWuPcNhz8Ip4C46','‘The ReVe Festival 2022 - Feel My Rhythm’','https://i.scdn.co/image/ab67616d0000b2738c4a282e84a53c1c8acf129a','2022-03-21','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('3hhDpPtCFuQbppwYgsVhMO','Kiss Land','https://i.scdn.co/image/ab67616d0000b273e4860d5331509e2c9ee4de10','2013-09-10','','CP Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('3HNnxK7NgLXbDoxRZxNWiR','Kamikaze','https://i.scdn.co/image/ab67616d0000b273e4073def0c03a91e3fceaf73','2018-08-31','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('3hPyxRi49jls3gU6Si8JdF','Angel Pt. 1 (feat. Jimin of BTS, JVKE & Muni Long) [Trailer Version]','https://i.scdn.co/image/ab67616d0000b273445afb6341d2685b959251cc','2023-05-17','','APG Inc – FF10','','3Nrfpe0tUJi4K4DXYWgMUX'),('3iFLXiQVinX1CZpTPL2ZBW','Between You And Me (Nth Romance X Car, the garden)','https://i.scdn.co/image/ab67616d0000b2731f51d305e6a589253cf636f2','2022-01-02','','TOON STUDIO, MATCHERS','','7c1HgFDe8ogy5NOZ1ANCJQ'),('3In1CblWZswwun5MhOa10y','This Love (Taylor’s Version)','https://i.scdn.co/image/ab67616d0000b273b7fe6e9265a84c3b6eb66d34','2022-05-06','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('3in5Gg4EZAMEfllRSrtcCC','The Hate U Give (Original Motion Picture Soundtrack)','https://i.scdn.co/image/ab67616d0000b2730bffddcd4c83baab8303c44d','2018-10-12','','Def Jam Recordings','','6qqNVTkY8uBg9cP3Jd7DAH'),('3iTETURuyuUJByvQOLoydV','BIGBANG Vol.1','https://i.scdn.co/image/ab67616d0000b273e03d007376ec65656c348205','2006-12-22','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('3jeQDa9OFZ6GndLindHx3k','Take Two','https://i.scdn.co/image/ab67616d0000b2738a701e76e8845928f6cd81c8','2023-06-09','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('3jRseYXGmX8RQ6ZTQ6tvsy','Eyes Closed (Lost Frequencies Remix)','https://i.scdn.co/image/ab67616d0000b2733df3d026518de7ab5d42f655','2023-03-23','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('3JUrJP460nFIqwjxM19slT','Wicked: The Soundtrack','https://i.scdn.co/image/ab67616d0000b27341ded89391c5350f6b8f991c','2024-11-22','','Universal Studios and Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('3kfmYL1ek1ke0M5aBBVKeD','Kura Kura','https://i.scdn.co/image/ab67616d0000b273aab0f8786a745698bafbc64d','2021-05-12','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('3kjHLu1pL7tdY88GFwEkl6','The Death of Slim Shady (Coup De Grâce)','https://i.scdn.co/image/ab67616d0000b2731633c43b5695735f7de36487','2024-07-12','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('3KJrNl6UCBBXF7f4Fu14fG','Ice Cream (with Selena Gomez)','https://i.scdn.co/image/ab67616d0000b2737af53cc2d4a7068b49c165bc','2020-08-28','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('3kWh17DuM0cn8YYrXXv25w','PAGE TWO','https://i.scdn.co/image/ab67616d0000b273a5c5db8b77ac94225e55924c','2016-04-25','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('3kzLpdORWuaybxArlvEjRt','Only The Best Compilation: Greatest Hits Songs, Vol. 3','https://i.scdn.co/image/ab67616d0000b27397a122b5bfbf756c2943e7e0','2013-05-30','','OTB Music Publishing','','2dd5mrQZvg6SmahdgVKDzh'),('3l1V6pEtFQLpbfAyfrSWhW','BLACKPINK 2021 \'THE SHOW\' LIVE','https://i.scdn.co/image/ab67616d0000b273273773a63f11a55524203ad9','2021-06-01','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('3L2iweH45rVdTBPldbY6dp','eternal sunshine (slightly deluxe and also live)','https://i.scdn.co/image/ab67616d0000b2730497121c2a34a6a1cb885e97','2024-10-01','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('3LhruYOSl2NPClKMGRpA2W','舞い落ちる花びら (Fallin\' Flower)','https://i.scdn.co/image/ab67616d0000b27342baa6c8b41530de616d64ff','2020-03-31','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('3lS1y25WAhcqJDATJK70Mq','Midnights (3am Edition)','https://i.scdn.co/image/ab67616d0000b273e0b60c608586d88252b8fbc0','2022-10-22','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('3lyRrGhXCCMbt4jVO9Wur2','HOT','https://i.scdn.co/image/ab67616d0000b27386efcf81bf1382daa2d2afe6','2025-03-14','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('3MKFECzfHMcHquRVhk5haD','6 To 9 (feat. Loco)','https://i.scdn.co/image/ab67616d0000b273563cdb14c30fcc0da5ced67f','2014-08-11','','파이니스트 레코즈','','7c1HgFDe8ogy5NOZ1ANCJQ'),('3MKvhQoFSrR2PrxXXBHe9B','Music To Be Murdered By - Side B (Deluxe Edition)','https://i.scdn.co/image/ab67616d0000b273b84b0516d901f95461bb5165','2020-12-18','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('3N2kQMt5yVXyGAVUDxzqup','Rebirth - SM STATION','https://i.scdn.co/image/ab67616d0000b27331e0373e4903af2be9cadc4a','2017-08-18','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('3nfvdW6RJSRkIGcqy1wJ8K','BigBang First Single','https://i.scdn.co/image/ab67616d0000b273922ac9c17ab6d950087f5ce5','2006-08-29','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('3Nu8JF8Jxcn4hVm5wrL7SB','Eve, Psyche & the Bluebeard’s wife (feat. UPSAHL)','https://i.scdn.co/image/ab67616d0000b273c6923643604062f71f9b03b0','2023-07-14','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('3OaW4df1SA62k0arNpn6bK','Whiplash - The 5th Mini Album','https://i.scdn.co/image/ab67616d0000b273e467a8e8d7b0aa92d354aa75','2024-10-21','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('3OevODyllQCrhudfLLnV3y','Dawn Of Chromatica','https://i.scdn.co/image/ab67616d0000b273335b00966a9839d4dde60256','2021-09-03','','Interscope','','41MozSoPIsD1dJM0CLPjZF'),('3oIFxDIo2fwuk4lwCmFZCx','No.6 Collaborations Project','https://i.scdn.co/image/ab67616d0000b27373304ce0653c7758dd94b259','2019-07-12','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('3OTb2OdIb20jHUhttAQPul','ONE','https://i.scdn.co/image/ab67616d0000b273e7e762a1f46ae45feb62ac66','2018-06-17','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('3oWWeH4gpNsJG0KyGaBoEd','My Universe (SUGA\'s Remix)','https://i.scdn.co/image/ab67616d0000b27326319baecaca27532b413001','2021-09-26','','Parlophone UK','','3Nrfpe0tUJi4K4DXYWgMUX'),('3OxfaVgvTxUTy7276t7SPU','Hurry Up Tomorrow','https://i.scdn.co/image/ab67616d0000b273982320da137d0de34410df61','2025-01-31','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('3oxhQpF3Twbkl18oQYfnh5','my future','https://i.scdn.co/image/ab67616d0000b273954fe13f7c5f4b2f18d066b8','2020-07-30','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('3P2UkOkqWp8ucd1EOnVAH7','Creepin\' (Remix)','https://i.scdn.co/image/ab67616d0000b273bd7aa72e76037ccd81e21a13','2023-03-17','','Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('3p68B7ZhETVmNbOov8JcF5','Sticky','https://i.scdn.co/image/ab67616d0000b2734cd7f69b85766b3d3035c27c','2024-07-01','','S2 ENTERTAINMENT INC.','','4TEK9tIkcoxib4GxT3O4ky'),('3PgXw2IxijRfY0BdcSWESV','NDA','https://i.scdn.co/image/ab67616d0000b273336e3b85492032aa32012f3b','2021-07-27','','UMG Recordings, Inc.','','6qqNVTkY8uBg9cP3Jd7DAH'),('3pkb4MByYl7ahbQT8CIwdZ','Wife','https://i.scdn.co/image/ab67616d0000b273f59b3f04997d1b9c245c8c4e','2024-01-22','','CUBE Entertainment','','2AfmfGFbe0A0WsTYm0SDTx'),('3pY7uXFrbq96BhWXcomLIi','YOUNHA Studio Live Album \'MINDSET\'','https://i.scdn.co/image/ab67616d0000b2731ae4cbc0d829f221c2504b73','2023-05-10','','C9 Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('3q6lN3kfsDgGaQUC7kVASH','Heng:garæ','https://i.scdn.co/image/ab67616d0000b2736f29a60db7b4479599fae56d','2020-06-22','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('3QbPtoOWiJqZurXXxJwaOD','Loose Change','https://i.scdn.co/image/ab67616d0000b273bc17a9c21d5a81d341945ed2','2011-12-09','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('3QgRwEK2D0vKaRICHPiKxR','베토벤 바이러스 Original Television Soundtrack','https://i.scdn.co/image/ab67616d0000b27350e4c659ba00a45908734172','2008-09-17','','CJ E&M MUSIC','','0Sadg1vgvaPqGTOjxu0N6c'),('3qMsDKPO0oPejlyDBPWLGh','사랑하는 사람들을 위한 지침서','https://i.scdn.co/image/ab67616d0000b27364b39c51bc9157382e12613a','2019-06-12','','Kakao Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('3qw2vm3uqKT3EIg95wbg83','Kill This Love','https://i.scdn.co/image/ab67616d0000b2732d602ab2d4acff0c2cf57683','2019-04-05','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('3RC82AQOnHoI50fQM9JNwW','Yellow OST Part.3','https://i.scdn.co/image/ab67616d0000b273a4d4a274581f1a1a26aa07d8','2017-10-22','','스페이스오디티','','7c1HgFDe8ogy5NOZ1ANCJQ'),('3rErf2wnj8X7QTfy12f5Jv','LATATA','https://i.scdn.co/image/ab67616d0000b2739c46ec6e75f5ca619c12d88b','2019-07-31','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('3rQE6GuZuvLF82h0o3Xqqd','Guess featuring Billie Eilish','https://i.scdn.co/image/ab67616d0000b2732e2f9a4fd4d92f32c2d54bd9','2024-08-01','','Atlantic Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('3rVtm00UfbuzWOewdm4iYM','‘The ReVe Festival’ Finale','https://i.scdn.co/image/ab67616d0000b273df5022bdf1ac4bf52135c4be','2019-12-23','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('3SxYD7K6tDOvcPGljYEtYt','Either Way','https://i.scdn.co/image/ab67616d0000b273104c0b477667708d41559de0','2023-09-25','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('3syEYrKIsgxaZMB5t1dVG7','Black Mamba','https://i.scdn.co/image/ab67616d0000b2736f248f7695eb544a3a1955c5','2020-11-17','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('3sYlurbYenuPBS7EGTiTZh','Skool Luv Affair','https://i.scdn.co/image/ab67616d0000b273da4d50ff045b2a463f56035a','2014-02-12','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('3T3STfBHgL2LRv4CGlJTAN','ELEVEN -Japanese version-','https://i.scdn.co/image/ab67616d0000b2732491a35e8c5f8a746f45a8b9','2022-10-19','','Sony Music Labels Inc.','','6RHTUrRF63xao58xh9FXYJ'),('3T4tUhGYeRNVUGevb0wThu','÷ (Deluxe)','https://i.scdn.co/image/ab67616d0000b273ba5db46f4b838ef6027e6f96','2017-03-03','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('3T6Xy6iJPpYmawK2LmJWFF','Expectations','https://i.scdn.co/image/ab67616d0000b2738d8f32a0fd54739b3d3f2c60','2023-03-09','','WM Korea','','2AfmfGFbe0A0WsTYm0SDTx'),('3TDdlYSrE5WuOTiuyr9tTl','2step (feat. Ultimo)','https://i.scdn.co/image/ab67616d0000b273e99d204567288c1806e5c127','2022-05-06','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('3tJHP2ISSna60CqxuEcjZ0','Doughnut','https://i.scdn.co/image/ab67616d0000b2733b8576ed9897859f8c32ac6a','2021-12-15','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('3tx8gQqWbGwqIGZHqDNrGe','Sweetener','https://i.scdn.co/image/ab67616d0000b273c3af0c2355c24ed7023cd394','2018-08-17','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('3u0ggfmK0vjuHMNdUbtaa9','ANTIFRAGILE','https://i.scdn.co/image/ab67616d0000b273a991995542d50a691b9ae5be','2022-10-17','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('3U2CtLGvuiukljwO8rPoVk','A-TEEN2 Part.2','https://i.scdn.co/image/ab67616d0000b2739eb8050029529478d2a4fdcd','2019-05-19','','PLAYLIST','','7nqOGRxlXj7N2JYbgNEjYH'),('3u7AUa79VCbxgikKvwlLyJ','Our love is great','https://i.scdn.co/image/ab67616d0000b27317ac1b81f7ed7da5d1ad98db','2019-03-18','','JYP Entertainment','','7c1HgFDe8ogy5NOZ1ANCJQ'),('3uhihQCm9aSvdJmDXcVrvi','I GOT A BOY - The 4th Album','https://i.scdn.co/image/ab67616d0000b273fd1f3849aaaf15112389a725','2013-01-01','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('3UIdh1xeV6hqlfhmimFkWx','Met Him Last Night','https://i.scdn.co/image/ab67616d0000b273fdd68060403900821036c33a','2021-04-01','','Island Records','','66CXWjxzNUsdJxJ2JdwvnR'),('3ukWjsUrP70en9dcpt01Hs','Better Things (RAYE Remix)','https://i.scdn.co/image/ab67616d0000b27375da471a6fd8923ccf9be980','2023-09-29','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('3UriCAbU5UjggYgpOQYCQI','Jason\'s Song (Gave It Away)','https://i.scdn.co/image/ab67616d0000b273722bd42dc7c1f6331b00d46b','2016-09-16','','Universal Records','','66CXWjxzNUsdJxJ2JdwvnR'),('3UwbHk4cUH09EsOf8TAnQ6','Giving you all you want and more','https://i.scdn.co/image/ab67616d0000b27314dcfb7581bf14f6ce8e6d67','2021-10-05','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('3UzhvBylOQjsNC3R7esiK4','START-UP (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273143660f59dde0d9e6ad1cfa0','2020-12-12','','㈜뮤직버디, ㈜블렌딩','','1z4g3DjTBBZKhvAroFlhOM'),('3v9xUVrRjLfLrID0iRXoxp','2013 BIGBANG Alive Galaxy Tour - The Final In Seoul','https://i.scdn.co/image/ab67616d0000b27358d867cb098bdbd2f25818f9','2013-05-30','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('3vrJCbPyK0Aq6YOsICnKJG','Airport 4','https://i.scdn.co/image/ab67616d0000b27323e66993382e202fa8503217','2010-07-13','','Legendary Entertainment','','2dd5mrQZvg6SmahdgVKDzh'),('3vyyDkvYWC36DwgZCYd3Wu','Savage - The 1st Mini Album','https://i.scdn.co/image/ab67616d0000b273d8cc2281fcd4519ca020926b','2021-10-05','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('3vzHwFgmttBWdGG9hCpUiS','I burn','https://i.scdn.co/image/ab67616d0000b27358f90d690435c8de69ed81ac','2021-01-11','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('3W04W2HfQ5kVeByxfjbu2C','Club Future Nostalgia (DJ Mix)','https://i.scdn.co/image/ab67616d0000b27357fe88ee748288269959a018','2020-08-28','','Warner Records','','41MozSoPIsD1dJM0CLPjZF'),('3WbP8oq7Ei50sg6E2KgCty','Like Flowers in Sand, Pt. 1 (Original Soundtrack)','https://i.scdn.co/image/ab67616d0000b273d6f18ffcaa38ca6dbf175795','2023-11-08','','ASTORY. Co., Ltd','','7c1HgFDe8ogy5NOZ1ANCJQ'),('3wd91jE2MWmMsHjAP4TA7v','2step (feat. Budjerah)','https://i.scdn.co/image/ab67616d0000b273a0faae7441418599c90c341c','2022-05-11','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('3wDWcowIrrWgpRmo2ZvFup','Left and Right (feat. Jung Kook of BTS) [Instrumental]','https://i.scdn.co/image/ab67616d0000b2736ff6df71608d9ea82f5956c3','2022-06-23','','Atlantic Records','','3Nrfpe0tUJi4K4DXYWgMUX'),('3WNGsnTetig4bJbw2BMbK7','I Can Do It With a Broken Heart (Dombresky Remix)','https://i.scdn.co/image/ab67616d0000b273f7dd2c5a8045a39fcecbfe8e','2024-09-13','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('3Wpp4J8YoEXeGiBrkxdhk1','Gettin Money Moment','https://i.scdn.co/image/ab67616d0000b2732e3c5a9b0aa8715c8146bc40','2017-05-24','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('3wRAY8jCfQC7BtnbazwFSr','DNSG','https://i.scdn.co/image/ab67616d0000b2731f40ba7ac0b09b635c229b2f','2018-06-11','','Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('3wXGFboFgcK9ezbPuSrKk9','Seventeen 3rd Mini Album ’Going Seventeen’','https://i.scdn.co/image/ab67616d0000b273365a466edde82104003d7113','2016-12-05','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('3x6YEnkVjRRtH6muk6Vzmj','COUNTIN MY GUAP','https://i.scdn.co/image/ab67616d0000b27378c26017d8d6a0d1af16ae9e','2020-05-22','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('3yVqF1TOg60hk9ehgMj3na','I Can Do It With a Broken Heart','https://i.scdn.co/image/ab67616d0000b273a8373ce028b3bd524eb0704a','2024-07-16','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('3ZFBYkLjwawtHEvtXjqwAJ','Together','https://i.scdn.co/image/ab67616d0000b273b24b2e6c8c68c53b5a3b214e','2017-03-10','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('3zKXeD35Qw9HV3FvNs3oAn','HAONOAH','https://i.scdn.co/image/ab67616d0000b27302ef7ad4a60055fd4a8ea7ef','2024-03-29','','ADA Korea','','3hvinNZRzTLoREmqFiKr1b'),('3znNdjJYbYwU54zlvXbs0n','YOUNHA 20th Anniversary Digital Single \'Waiting\'','https://i.scdn.co/image/ab67616d0000b273ec85dccff70fcb9ab018c884','2023-12-22','','C9 Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('3zNOCJUMp0IOEREqInMhug','UNDERGROUND ROCKSTAR','https://i.scdn.co/image/ab67616d0000b273be57345b0d4552352d4d0f90','2021-11-11','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('3ZRA0BXTwO2ydgjXblwrEb','\'Solo Leveling:ARISE\' (Original Soundtrack)','https://i.scdn.co/image/ab67616d0000b2731146e020bc79de11ca502e59','2025-07-03','','Genie Music Corporation, Stone Music Entertainment','','2AfmfGFbe0A0WsTYm0SDTx'),('3zVB99XMdbP9HTVNg0GJwV','boyfriend','https://i.scdn.co/image/ab67616d0000b2732ca010dcf3863a07611d8b4f','2019-08-02','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('42hbqXgvZ1dI3gQ1ZDnHA5','Rain On Me (Purple Disco Machine Remix)','https://i.scdn.co/image/ab67616d0000b273b1e85091fafe0597d4f129ca','2020-07-17','','Interscope Records','','66CXWjxzNUsdJxJ2JdwvnR'),('43wFM1HquliY3iwKWzPN4y','Love Yourself 結 \'Answer\'','https://i.scdn.co/image/ab67616d0000b2733825e6d4d02e4b4c0cec7e1d','2018-08-24','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('442zUwKHCTO47XPF7cUSqY','Youth','https://i.scdn.co/image/ab67616d0000b273fb393e601ffd242273e04ea7','2016-09-07','','PONY CANYON INC.','','3Nrfpe0tUJi4K4DXYWgMUX'),('44OSkEmvHwdTFhPBCewIks','Ocean Eyes (The Remixes)','https://i.scdn.co/image/ab67616d0000b2732dc817144c8081281f77508d','2017-01-13','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('46NPb9fH3T2zU2hsy1N0g3','HOSPITAL PLAYLIST Season2 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273bd9971815d8f7bbff5ae4850','2021-09-24','','Genie Music Corporation, Stone Music Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('46q4DrAttifm5PnrAtYqp2','iScreaM Vol.12 : Bad Boy Remixes','https://i.scdn.co/image/ab67616d0000b27315375c39fa5a417709ca99bc','2021-11-01','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('46uFocwb9yPpQyi7f431Sf','ALIVE','https://i.scdn.co/image/ab67616d0000b27344d7b1b50ba739fa8c0b6308','2024-08-28','','Sony Music Labels Inc.','','6RHTUrRF63xao58xh9FXYJ'),('479xGDGrqMXN8YLmJMEoTG','I made','https://i.scdn.co/image/ab67616d0000b273e0673f1aa086b283c865817e','2019-02-26','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('47BiFcV59TQi2s9SkBo2pb','Recovery','https://i.scdn.co/image/ab67616d0000b273c08d5fa5c0f1a834acef5100','2010-06-18','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('4a8uxN5j5ZSWuioZ9cHqWk','Best Friends (Remix)','https://i.scdn.co/image/ab67616d0000b2735c1ecd80ec5f25b556052431','2022-08-05','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('4bWGRs1SqNwFXaRDXRAANN','Hold On Tight','https://i.scdn.co/image/ab67616d0000b273fe31201bbc019b1636066dc3','2023-03-30','','Parlophone UK','','6YVMFz59CuY7ngCxTxjpxE'),('4cCVfhdZyqipuaZ89KmMvi','I Don\'t Know Why (I Just Do)','https://i.scdn.co/image/ab67616d0000b2734844e381742b58ac71080ab4','2025-03-26','','Decca (UMO)','','66CXWjxzNUsdJxJ2JdwvnR'),('4cmHvSMDrSRe2sLodew8sV','Butter (Holiday Remix)','https://i.scdn.co/image/ab67616d0000b273c0ff7c2c2de098875ec82997','2021-12-03','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('4COjb7HTb62VqweU8iaJed','HWAA (Dimitri Vegas & Like Mike Remix)','https://i.scdn.co/image/ab67616d0000b2739a882859a570b819979d50e7','2021-02-05','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('4CoKhy1Ew4kb4kgonvnMXy','You Never Know (JP Ver.)','https://i.scdn.co/image/ab67616d0000b27329b0e2247c443a608d894a2d','2021-08-03','','Universal Music LLC','','41MozSoPIsD1dJM0CLPjZF'),('4Cr6vlJh83a5Eby9DZRPwD','The Adventures of Moon Man & Slim Shady (with Eminem)','https://i.scdn.co/image/ab67616d0000b27355dfd42001dbc79e5552c82c','2020-07-10','','Republic Records','','7dGJo4pcD2V6oG8kP0tJRR'),('4DpP8QohtCF4gcBWSGCodN','Angel\'s Most Played Tracks','https://i.scdn.co/image/ab67616d0000b2734967966e05e720d0e6093fb2','2021-08-24','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('4DXE5rt8VQUZHmKIG57AYu','iScreaM Vol.19 : FOREVER 1 Remixes','https://i.scdn.co/image/ab67616d0000b2730ad092f22ab2f068dfcecb87','2022-11-17','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('4e841RxorIoZIufX8v7p7E','Oh! - The Second Album','https://i.scdn.co/image/ab67616d0000b2739b57e9b31c831fb2137c38e2','2010-01-28','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('4E8puNI8tw7cXz6YJkwMew','Lo Vas A Olvidar (with ROSALÍA)','https://i.scdn.co/image/ab67616d0000b273c64ed7bab63186d7fca3012f','2021-01-21','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('4eAPqbxuqZuwBnYSBrE0Rb','Azizam (feat. Googoosh) [Persian Version]','https://i.scdn.co/image/ab67616d0000b2733528e79c19f77b3ba7c2c495','2025-04-03','','Gingerbread Man Records / Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('4EcCAEuFDxUXAaYJwosbw9','Zpátky do školy','https://i.scdn.co/image/ab67616d0000b273d308af095072e767f32e9b40','2024-09-07','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('4efZAcyaIaPMIeBQheHKOy','Catch Me If You Can','https://i.scdn.co/image/ab67616d0000b27359a2a72ecab2e8b551eafe36','2015-04-10','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('4eguh1dJUXRh0IMiLKRwab','Lose Yourself','https://i.scdn.co/image/ab67616d0000b27315175a3af8eb08dbc8c77a31','2024-10-15','','S2 ENTERTAINMENT INC.','','4TEK9tIkcoxib4GxT3O4ky'),('4eKdn0skJCidO2wqIJyCgB','Lion Heart - The 5th Album','https://i.scdn.co/image/ab67616d0000b2737ce0130c09547c733984ba0e','2015-08-19','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('4EPIlAjXbTNQTracKmYnI6','K-FLIP+','https://i.scdn.co/image/ab67616d0000b27373353f72d6760d107a955847','2025-03-17','','KC, AT AREA','','3hvinNZRzTLoREmqFiKr1b'),('4FPGx2h8DlLSYYaBVd3AxX','PAY DAY with KozyPop','https://i.scdn.co/image/ab67616d0000b27314f894f040789dfdde7f226a','2020-02-27','','WM Korea','','3hvinNZRzTLoREmqFiKr1b'),('4gG7E1oREuA5rNKvyj7zXE','COLLABS VOL. 1 (INT’L VER.)','https://i.scdn.co/image/ab67616d0000b273b00225f207bd7817fa68bfdf','2020-11-06','','Unicorn Pop','','2AfmfGFbe0A0WsTYm0SDTx'),('4hDok0OAJd57SGIT8xuWJH','Fearless (Taylor\'s Version)','https://i.scdn.co/image/ab67616d0000b273a48964b5d9a3d6968ae3e0de','2021-04-09','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('4hkDgVKWStOUopF7JERIW8','Top Motivation','https://i.scdn.co/image/ab67616d0000b27358f9aad6bf6fcf19aee2874e','2024-03-12','','Warner Music Group - X5 Music Group','','6YVMFz59CuY7ngCxTxjpxE'),('4I1cAiu9Gko1xwJPZ4lViH','MAP OF THE SOUL : 7','https://i.scdn.co/image/ab67616d0000b273a305c82beadd829638dd8c36','2020-02-21','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('4i3rAwPw7Ln2YrKDusaWyT','everything i wanted','https://i.scdn.co/image/ab67616d0000b273f2248cf6dad1d6c062587249','2019-11-13','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('4IqfdL14SOkeFN2c5ASmGh','Smart (Remixes)','https://i.scdn.co/image/ab67616d0000b273249dc66f0cb95bed7dacc39e','2024-03-22','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('4iyJ8i3eKbez8JXDbsHIdZ','Bored','https://i.scdn.co/image/ab67616d0000b273e0f2af91be409aad81bba98c','2017-03-30','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('4J3umaQxh7W2eKIx0p2ErW','Chloraseptic (feat. 2 Chainz & Phresher) [Remix]','https://i.scdn.co/image/ab67616d0000b2738d18edc843a8ee5bd1ff75d9','2018-01-08','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('4JUtnlZKdLr01xEIymhm0G','Live at the Bedford','https://i.scdn.co/image/ab67616d0000b2734dc715d4872af21780dc2b1e','2011-12-09','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('4jWeWjp3f1M2oTysj27ZKs','로펌 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b2730f40fa5b4e4bef53856c38ee','2001-06-29','','Pan Entertainment Co., Ltd.','','2dd5mrQZvg6SmahdgVKDzh'),('4Jzx0XAORPKQ3v7EaL8Ful','Dreams Come True - SM STATION','https://i.scdn.co/image/ab67616d0000b2735b1ee39743c40b88a80b4ccf','2021-12-20','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('4kKOPtbEP6LqT1vxrEjw47','화양연화 Pt.2','https://i.scdn.co/image/ab67616d0000b273c7c9b40a7e841a674b2b24b2','2015-11-30','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('4lBrDelXR6Sn0k54a7UWMz','Take My Breath','https://i.scdn.co/image/ab67616d0000b273e6c40bd47002f3faffb31ebe','2021-08-05','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('4LcW19D6W1nHpvcJV5s2QI','My Universe (David Guetta Remix)','https://i.scdn.co/image/ab67616d0000b2731d7b0c0179b1cbb8f29ce785','2021-10-13','','Parlophone UK','','3Nrfpe0tUJi4K4DXYWgMUX'),('4lfFgz2rD1irxf7dZhNJht','SEVENTEEN 4th Album \'Face the Sun\'','https://i.scdn.co/image/ab67616d0000b273decd839dd4fef3faf64c5fd5','2022-05-27','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('4LyiYe4wZ6XwzUne79hidF','Left and Right (Feat. Jung Kook of BTS)','https://i.scdn.co/image/ab67616d0000b2731c069c836dc6cd5b34c310fe','2022-06-24','','Atlantic Records','','3Nrfpe0tUJi4K4DXYWgMUX'),('4Mc7WwYH41hgUWeKX25Sot','FEARLESS','https://i.scdn.co/image/ab67616d0000b2739030184114911536d5f77555','2022-05-02','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('4MHZnwMTrnhgoSJKe1KSqP','Dirty Dancing (Dem Jointz Remix)','https://i.scdn.co/image/ab67616d0000b273903d2a67b68319065904e5f5','2023-09-01','','Interscope','','7nqOGRxlXj7N2JYbgNEjYH'),('4MNb9ii6LzgcCT8PrvdClb','After LIKE','https://i.scdn.co/image/ab67616d0000b2731abe22e6883e5a8b3f4726e2','2022-08-22','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('4mukVCwbBFAZb1sHpRuMwO','ひとつ空の下','https://i.scdn.co/image/ab67616d0000b27359438e5a79d4812b30680b2f','2010-09-22','','NBCUniversal Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('4Nav3JE8TIOFiuY5x95MIh','Regret of the Times (2024 aespa Remake Version) - SM STATION','https://i.scdn.co/image/ab67616d0000b273c74be23f27696b57c67f5489','2024-01-15','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('4nGujzCa6JLhMx7rHXE4J9','Whiplash (English Version)','https://i.scdn.co/image/ab67616d0000b27335fc1c7098811dcabfb279ec','2025-03-27','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('4NIqCxqP9o8Tp6tGLBqd8O','Love Yourself 轉 \'Tear\'','https://i.scdn.co/image/ab67616d0000b2738fbcf6544ff02a8959a81781','2018-05-18','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('4NOk4uKmUx75jMeFvmvWtJ','CRAZY [Japanese ver. (Party Remixes)]','https://i.scdn.co/image/ab67616d0000b2733d0b18ac49e977c11c355117','2024-12-18','','HYBE JAPAN / UNIVERSAL MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('4NoNvM260Uc6b5OX9KTrxl','Girl Squad','https://i.scdn.co/image/ab67616d0000b27380639016bc22515a150da80e','2022-01-21','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('4NR2Ebi3Xa2EG6GknC7vcO','Walking In The Rain','https://i.scdn.co/image/ab67616d0000b273eee4ff67acc8eeca638b83b5','2020-08-04','','Genie Music Corporation, Stone Music Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('4nUpG68I8d3K1UFl6BlQTO','New Stuff - Pop','https://i.scdn.co/image/ab67616d0000b273f7ea0ac874a2fa2257892b21','2024-03-01','','Warner Music Group - X5 Music Group','','6YVMFz59CuY7ngCxTxjpxE'),('4OBxgiZLUF7lOVV6GGQ6qi','Angel Anniversary Edition (feat. Muni Long, JVKE, NLE Choppa)','https://i.scdn.co/image/ab67616d0000b27332107dc4737279267c8e00f5','2024-05-15','','APG Inc – FF10','','3Nrfpe0tUJi4K4DXYWgMUX'),('4odWFnjGSf2eYUqBea9f7q','DARE ME','https://i.scdn.co/image/ab67616d0000b273af7e6ed19d5d63940595e909','2025-04-21','','Sony Music Labels Inc.','','6RHTUrRF63xao58xh9FXYJ'),('4OeQ9nilS4Sy3efzt0hVFi','Be Natural - The 2nd Single','https://i.scdn.co/image/ab67616d0000b27372ee4e2e933836a66e5869b6','2014-10-13','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('4OIA4iFFUPeDVODUJ98tmm','THE GIRLS (BLACKPINK THE GAME OST)','https://i.scdn.co/image/ab67616d0000b2735e213a69bc261b67b1abf5cf','2023-08-25','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('4oiTiTASNGvlF33hJi5eOp','Traveller, No.401','https://i.scdn.co/image/ab67616d0000b27345303bb04eb5c66ef65034b2','2020-11-18','','CLEF COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('4otkd9As6YaxxEkIjXPiZ6','Music To Be Murdered By','https://i.scdn.co/image/ab67616d0000b2732f44aec83b20e40f3baef73c','2020-01-17','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('4Oz7K9DRwwGMN49i4NbVDT','UNFORGIVEN','https://i.scdn.co/image/ab67616d0000b273d71fd77b89d08bc1bda219c7','2023-05-01','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('4pAR7V7lLhemD9UZ7nJeUU','Global Viral','https://i.scdn.co/image/ab67616d0000b273a3efec8ccbc7463a85e054ca','2023-02-21','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('4Pl0T6jHMRaGMamkg14mVZ','Will -Korean version-','https://i.scdn.co/image/ab67616d0000b273002d9f3ed572ca5a1d3ce9ab','2024-10-15','','Sony Music Labels Inc.','','6RHTUrRF63xao58xh9FXYJ'),('4PRvd9TvkVDwMnaYu6qHUl','KPOP - JPOP Made In Korea Vol. 2','https://i.scdn.co/image/ab67616d0000b273963922de0bdd94abffad54d7','2018-10-27','','Blue Pie Records USA','','4Kxlr1PRlDKEB0ekOCyHgX'),('4q3wUuIReEjGSYzmSsxtl6','The Idol Episode 5 Part 1 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b27337a61e7106ce1b3628e4af8d','2023-06-30','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('4qpzzLtl5ksEnhryRUrNQC','Hot Issue','https://i.scdn.co/image/ab67616d0000b273a53603b939bd213df9d6d886','2007-11-22','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('4qZBW3f2Q8y0k1A84d4iAO','My Dear Melancholy,','https://i.scdn.co/image/ab67616d0000b2731f6a2a40bb692936879db730','2018-03-30','','Universal Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('4RpgjxgSxcRwGNuWnImneN','13 Reasons Why (Season 2)','https://i.scdn.co/image/ab67616d0000b273acc995be2b5bdc62d622ccd3','2018-05-18','','UMGRI Interscope','','6qqNVTkY8uBg9cP3Jd7DAH'),('4RR6CRr8GCSn3KWPUnnmjm','The Real Vol.1 (First Live Concert)','https://i.scdn.co/image/ab67616d0000b273c632cc45fa2a27dd0330f7cc','2007-02-08','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('4s5vClNrHbNQ4ePFKM8Zru','Queendom < FINAL Comeback >','https://i.scdn.co/image/ab67616d0000b273619150a04e1ed1741268c505','2019-10-25','','Genie Music Corporation','','2AfmfGFbe0A0WsTYm0SDTx'),('4s61dUzMQSfrey5pXPoNpf','First Album','https://i.scdn.co/image/ab67616d0000b2733f2266b6430ef765791edecc','2007-02-01','','더늠이엔티','','2dd5mrQZvg6SmahdgVKDzh'),('4snDidl0spOeD55YeH3HGh','Eve, Psyche & the Bluebeard’s wife (Rina Sawayama Remix)','https://i.scdn.co/image/ab67616d0000b2735521676c671a23c8f18cb594','2023-07-28','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('4soeaXzvqJurX5Flkh6ZD1','Perfect Night (Remix)','https://i.scdn.co/image/ab67616d0000b273c8a3d178713ec818a28586a5','2023-10-30','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('4T1fv3gIYifquPf9dRhJei','Always','https://i.scdn.co/image/ab67616d0000b2734efa3bb95411ca959771dfb0','2007-08-16','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('4t62n365iuvkvkANFiOG3m','Cosmic','https://i.scdn.co/image/ab67616d0000b273a54b93bff4827437f56b7896','2024-06-24','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('4T8wBxIvoSRVfoFZzuwOXR','One of the Girls','https://i.scdn.co/image/ab67616d0000b273fab8b9788d94224614c49185','2023-12-08','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('4TMlkDHtOb8ZlrGiy57xvH','Yet To Come (Hyundai Ver.)','https://i.scdn.co/image/ab67616d0000b273b231a9d6e2b3e00757786b58','2022-09-23','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('4TqgXMSSTwP3RCo3MMSR6t','Rain On Me (with Ariana Grande)','https://i.scdn.co/image/ab67616d0000b273c8583f0bd97d3042d4971acf','2020-05-22','','Interscope Records','','66CXWjxzNUsdJxJ2JdwvnR'),('4tsRYh3Fat8iwTL0RkLX6X','Special Edition \'Still Alive\'','https://i.scdn.co/image/ab67616d0000b273ca89c0a235ff941484d02039','2012-06-03','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('4uI4ZBpgii7V7BwMDSZD9F','2014 YG FAMILY CONCERT IN SEOUL LIVE','https://i.scdn.co/image/ab67616d0000b27320bdfce0104a73a22866d859','2014-11-28','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('4uXdvX6Kma8gK1k88Ndvsb','2step (feat. Quevedo)','https://i.scdn.co/image/ab67616d0000b273d75defc971b839bedc245493','2022-05-23','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('4Vf5l1TvPROSWTSzIj9v6i','Top 30 US','https://i.scdn.co/image/ab67616d0000b273ac2372b9d344a5d3fc9167cc','2018-04-27','','UMG Recordings, Inc.','','6qqNVTkY8uBg9cP3Jd7DAH'),('4vGkZl9P0sKxupLdJE7ndS','The Boys - The 3rd Album','https://i.scdn.co/image/ab67616d0000b27361d7b9988c77826dfb1db1b3','2011-10-19','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('4vLGHlTnlIIxMSfefCY0cU','SYNK : PARALLEL LINE - Special Digital Single','https://i.scdn.co/image/ab67616d0000b273253096eda3b7826c11c7fab8','2024-10-09','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('4VLR1cDqRIeS86GYSJvlmZ','HANN (Alone)','https://i.scdn.co/image/ab67616d0000b273ace0e90dab0e51a4aec4f50a','2018-08-14','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('4VPoZSOEnpfUu36fILrqA1','Lollipop Pt.2','https://i.scdn.co/image/ab67616d0000b273c6a16977c7718842c6c2d0c2','2010-02-19','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('4vsBt7vutpoO2ebjuTinkn','Azizam (Acoustic)','https://i.scdn.co/image/ab67616d0000b2737cc956bfc84f689701365627','2025-05-23','','Gingerbread Man Records / Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('4wb2ucdEfkt2J0dKFrFVFn','BETWEEN 1&2','https://i.scdn.co/image/ab67616d0000b273294dcbd59f951eb8a7eadaf5','2022-08-26','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('4WGtR1PHnlVHwlU8mj11jE','All Night','https://i.scdn.co/image/ab67616d0000b273a4d85ea8c9ed50d36847e962','2024-01-19','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('4wq7ZtNGc6PcHAxhmHjztt','돈 벌 시간 2','https://i.scdn.co/image/ab67616d0000b2736ef14073bf27b6bb5626aeeb','2016-07-21','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('4wvtBBEkkjPHfyWXPkwmF6','C','https://i.scdn.co/image/ab67616d0000b273956e5ad1d9ae34dd548aaa62','2019-10-23','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('4WzpK0mIeVP4igTpG5pdeg','BABY BABY - Girls\' Generation Repackage','https://i.scdn.co/image/ab67616d0000b2734e92f4ffbecee20e20c4a9a3','2008-03-13','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('4xcIr0rkoIBPmoSPamCorO','R.E.M','https://i.scdn.co/image/ab67616d0000b273b9ed5e63a1dc66a4bd6ae177','2024-10-04','','S2 ENTERTAINMENT INC.','','4TEK9tIkcoxib4GxT3O4ky'),('4XE9M8giGvwLFebTgpCwSc','Rap God','https://i.scdn.co/image/ab67616d0000b273643e6ecebab400d52574e4b2','2013-01-01','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('4xfupa1EtOtNuKYtoBMy7i','FEARLESS','https://i.scdn.co/image/ab67616d0000b2736efdb2dbc22f89af9abd30f1','2023-01-25','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('4xggkS8rdsJL3dgji8zW6W','SEVENTEEN 12th Mini Album \'SPILL THE FEELS\'','https://i.scdn.co/image/ab67616d0000b273cb657e50a77865fe66d700bf','2024-10-14','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('4xKjjV0sVc9PiJ1sPU9RiN','Santa, Can’t You Hear Me (Live)','https://i.scdn.co/image/ab67616d0000b2735516f0c8980dd64d131a5664','2022-12-14','','Atlantic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('4xOOB79WcZuOoVwK06No1s','HAPPEN','https://i.scdn.co/image/ab67616d0000b273168258bceeef84be1d0c9301','2021-05-20','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('4y3pLcRLyhwZmrTtODJzGJ','my forgotten favourites','https://i.scdn.co/image/ab67616d0000b273d8333416eda952d2854a4bb4','2024-09-04','','Warner Music UK Ltd','','6eUKZXaKkcviH0Ku9w2n3V'),('4YBKpZhJQXxO7RNjA4V4lY','Chill Kill - The 3rd Album','https://i.scdn.co/image/ab67616d0000b273d907428ecc02da4077c208d4','2023-11-13','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('4YCeHlXgJTKlzuwHmvZZo8','L’AMOUR DE MA VIE [OVER NOW EXTENDED EDIT]','https://i.scdn.co/image/ab67616d0000b273b4f4348caa31224b51b95dfe','2024-05-21','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('4yP0hdKOZPNshxUOjY0cZj','After Hours','https://i.scdn.co/image/ab67616d0000b2738863bc11d2aa12b54f5aeb36','2020-03-20','','Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('4YqPQJO3WKF9FnpT3jQ58c','2011 SMTOWN Winter \'The Warmest Gift\'','https://i.scdn.co/image/ab67616d0000b2736a6b86296542432980c9976e','2011-12-13','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('4YroJ4NELkaJ34JjEZ6RyJ','Gee - The First Mini Album','https://i.scdn.co/image/ab67616d0000b273aa7646e7aa8a4e001cb8a805','2009-01-05','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('4YV1qBdn6O6thyg18kBo0N','Hurricane','https://i.scdn.co/image/ab67616d0000b27331a80d2686b8a10d7925efb6','2021-08-27','','Getting Out Our Dreams II, LLC / Def Jam Recordings','','1Xyo4u8uXC1ZmMpatF05PJ'),('4ZCXsCHvaZ9r5skMrC4B9h','STABLE MINDSET','https://i.scdn.co/image/ab67616d0000b273dff066d81bf9710afdc49ad2','2019-07-02','','C9 ENTERTAINMENT','','6GwM5CHqhWXzG3l5kzRSAS'),('4zxJbvZKMXz6N1XHdupyTk','Fiesta de disfraces vol. II','https://i.scdn.co/image/ab67616d0000b2739567479c423d94651caa5e34','2022-10-21','','UME - Global Clearing House','','2dd5mrQZvg6SmahdgVKDzh'),('50BrkBakrLWufmTLjCVBwn','SEVENTEEN 1ST ALBUM [FIRST ‘LOVE&LETTER’]','https://i.scdn.co/image/ab67616d0000b273deeee778a591e7032c1bdc80','2016-04-25','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('50J3V4fzOMMqjhGtLfPb1u','SAPPY','https://i.scdn.co/image/ab67616d0000b273e1c5e65095845fc690b7e2de','2019-05-30','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('50TaFniZBXGztHHvNEHeFR','MOONLIGHT SUNRISE','https://i.scdn.co/image/ab67616d0000b2736da71681374da65bc1f6517e','2023-01-20','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('5153aG4BHrvldWiOmbQYLF','2step (feat. Ellinoora)','https://i.scdn.co/image/ab67616d0000b2738cd423bef06a5105bd6d416a','2022-05-04','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('51joMRy1FNUYWiPLiKUobo','With YOU-th','https://i.scdn.co/image/ab67616d0000b273526b8264b2c0f0cc195b1a94','2024-02-23','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('51YSCADWKunGFVXVecxcDe','Taxidriver2 OST Part.2','https://i.scdn.co/image/ab67616d0000b2733d43ccb2dad7dc8775d9ed6c','2023-02-25','','SBS Contents Hub Co., Ltd.','','7c1HgFDe8ogy5NOZ1ANCJQ'),('538vEfAgLJ6g2I8ubuOlap','CRAZY','https://i.scdn.co/image/ab67616d0000b273485623bc41b6760fc1bca2f4','2024-08-30','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('55N0UTP5992idhnEYOKYd9','iScreaM Vol.26 : Spicy Remix','https://i.scdn.co/image/ab67616d0000b27324936098cb2874153291a3f9','2023-09-15','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('55Pg6r2oJfQaVm3yzhgZsG','Would U - SM STATION','https://i.scdn.co/image/ab67616d0000b27303f0ae1be05283665ac60f7f','2017-03-31','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('56w7UaxCFwsRr5VVk0agy0','TWICEcoaster: LANE1','https://i.scdn.co/image/ab67616d0000b273cad9a403b68491de8fefca75','2016-10-24','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('57FHPyAprjWD6mXaY5gE1f','2step (feat. 1.Cuz)','https://i.scdn.co/image/ab67616d0000b27388c6e57797288ab013a721e3','2022-05-09','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('58OR7UoaJkJzqeQGClHzh1','‘The ReVe Festival 2022 - Birthday’','https://i.scdn.co/image/ab67616d0000b273d2ef237da7f94762997c2083','2022-11-28','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('58PdWiXJyumZtjGpqkpmcP','31','https://i.scdn.co/image/ab67616d0000b2735227304dd0c23f2f6edd7dfe','2020-07-21','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5A2hjk2MoqkDqGYsAfUiAz','names in lights at stadium heights','https://i.scdn.co/image/ab67616d0000b27324f269aefee395addb6cff1c','2024-08-21','','Warner Music UK Ltd','','6eUKZXaKkcviH0Ku9w2n3V'),('5a8Z7oECLc3gIMYt4Xxt0e','Heart Shaker (GALACTIKA * Holiday Remix)','https://i.scdn.co/image/ab67616d0000b2733da690afa4f73b3e82883579','2023-11-07','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('5aaoQnRC7NGXbuXJlABfFC','투깝스 OST Part.7','https://i.scdn.co/image/ab67616d0000b2731a1c2520656252b1dc6e5562','2018-01-15','','㈜블렌딩, ㈜싱크팝','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5AEDGbliTTfjOB8TSm1sxt','Speak Now (Taylor\'s Version)','https://i.scdn.co/image/ab67616d0000b2730b04da4f224b51ff86e0a481','2023-07-07','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5aHdNainJWMc3n2AqfiOg5','SEVENTEEN 2ND ALBUM \'TEEN, AGE\' (2)','https://i.scdn.co/image/ab67616d0000b27346a157795d939b7a6868d207','2017-11-06','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('5AtBwO35tOSWvxS4nFWHAi','PSY 8th 4X2=8','https://i.scdn.co/image/ab67616d0000b273e76e23b5d422364e5c37063a','2017-05-10','','YG Entertainment','','2dd5mrQZvg6SmahdgVKDzh'),('5aX2plzPm0m6zk4ZFuqbuI','The Idol Episode 3 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b273c2f472bdfc7ad0883c933ab4','2023-06-19','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('5BbxtJLsjDXAIpuRk5DlVo','Waiting Room (from \'THE FAN TOP3\')','https://i.scdn.co/image/ab67616d0000b27360cf3f1929e2dc7d12bfbe7e','2019-02-02','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5Bg49LEfyoZzKpQsEwRCtI','Rookie - The 4th Mini Album','https://i.scdn.co/image/ab67616d0000b273a38af5bbda76202e9d9eb8fd','2017-02-01','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('5bKmRG1QsggSXoHxYUnPIY','Pink Venom','https://i.scdn.co/image/ab67616d0000b273d8c2bf84c41ec28dc6fb8926','2022-08-19','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('5bLE2kmkZWlzAYeb6To6LA','Autumn Variations (Fan Living Room Sessions)','https://i.scdn.co/image/ab67616d0000b273b89a4c6fd745bd3751938201','2023-10-02','','Gingerbread Man Records','','6eUKZXaKkcviH0Ku9w2n3V'),('5Bwg2XxrjTlrNy6BC7KQZf','Carolina (From The Motion Picture “Where The Crawdads Sing”)','https://i.scdn.co/image/ab67616d0000b2732c683c1b9fa1b711499408f7','2022-06-24','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5bx7i3cuSfXBPF7Li8kUR7','The Idol Episode 2 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b273221ffa4ab2c5e4511563fb57','2023-06-12','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('5C0x5d0FrpXJWVcHPYC2zJ','Jackasoul','https://i.scdn.co/image/ab67616d0000b27345151841231fa5dcdc13358b','2013-09-30','','파이니스트 레코즈','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5Cs0PWgVylmYPiuoN6qLda','Her Private Life (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b2731d8e925df66cb6d8c425ebfc','2019-05-30','','Genie Music Corporation','','2AfmfGFbe0A0WsTYm0SDTx'),('5Csjy4XeA7KnizkhIvI7y2','eternal sunshine (slightly deluxe)','https://i.scdn.co/image/ab67616d0000b273bd3de668e4784d791c4ab695','2024-03-11','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('5Cuvubu7p7KgZVXelmxgjK','투유 프로젝트 - 슈가맨 Pt.13','https://i.scdn.co/image/ab67616d0000b27399245de8bd696b9495af5d1c','2016-01-13','','JTBC','','1z4g3DjTBBZKhvAroFlhOM'),('5DnCYcTvhM8RNxSNeJBfFu','Monsoon Love Vol 15','https://i.scdn.co/image/ab67616d0000b273973f140d53d869c149c105e0','2023-07-04','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('5dwzsNcntYNMFan9LvRxJM','I SWAY','https://i.scdn.co/image/ab67616d0000b2736e9204c1f01d903400265d67','2024-07-08','','CUBE Entertainment','','2AfmfGFbe0A0WsTYm0SDTx'),('5DZ9A2AgtgmezypepyYGeJ','Somewhere Over The Rainbow (Live From Manchester)','https://i.scdn.co/image/ab67616d0000b2733d80ef1d72fee7c12edc4e77','2017-06-06','','Republic Ariana Grande','','66CXWjxzNUsdJxJ2JdwvnR'),('5EAPu3s0n6yilqscZUtQPQ','Relay : Remixes','https://i.scdn.co/image/ab67616d0000b273cfb24dbdc95667e04f850d6e','2019-02-09','','LINE FRIENDS','','2AfmfGFbe0A0WsTYm0SDTx'),('5Efud8Wmo7vBQjSJI1WcJ7','Hong Gil Dong OST','https://i.scdn.co/image/ab67616d0000b273df0687edfc532a78ab858512','2008-01-23','','msmedia','','0Sadg1vgvaPqGTOjxu0N6c'),('5eN6KiloNKtNCmteFBXgqg','STAGE FIGHTER(STF) Original, Vol. 1','https://i.scdn.co/image/ab67616d0000b273dc93caa63f0b2af4b34aea46','2024-09-23','','Genie Music Corporation','','4TEK9tIkcoxib4GxT3O4ky'),('5EUgcfO5OWxnniHR3QYFcK','The Marshall Mathers LP2 (Expanded Edition)','https://i.scdn.co/image/ab67616d0000b273c926cc5c75394291893ee86b','2023-11-03','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('5ExDI42RCtISkQXAgv8dtZ','Permission to Dance','https://i.scdn.co/image/ab67616d0000b273a7e481899b7e0396f93d10b8','2021-07-23','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('5EYKrEDnKhhcNxGedaRQeK','eternal sunshine','https://i.scdn.co/image/ab67616d0000b2738b58d20f1b77295730db15b4','2024-03-08','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('5eyZZoQEFQWRHkV2xgAeBw','Taylor Swift (Deluxe Edition)','https://i.scdn.co/image/ab67616d0000b273c909d4e47de2ab0636f46d64','2006-10-24','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5f4rbgZJhYp4hgswKri00b','Christmas Tree Farm (Old Timey Version)','https://i.scdn.co/image/ab67616d0000b2738538f5677d3ffe87257ac6c2','2021-11-22','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5f8PEOUNnkB5cj2W5fVgXy','우리의 밤을 외워요','https://i.scdn.co/image/ab67616d0000b273c908457d1d04f4a574e3d214','2019-06-18','','Kakao Entertainment','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5f9zyi5u2hzHMh9RAtssnl','Gimme Love','https://i.scdn.co/image/ab67616d0000b273b738db4dccf4bacf30a74456','2016-11-18','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5FAPIZrpcxQLLte8PlUvxS','How You Like That (JP Ver.)','https://i.scdn.co/image/ab67616d0000b2734685829353fb0a3bf3e61f32','2021-07-27','','Universal Music LLC','','41MozSoPIsD1dJM0CLPjZF'),('5FcOvF4YukVnIkqxNcqopa','2step (Star.One Remix)','https://i.scdn.co/image/ab67616d0000b2733afdbd36f33a74551aec0db1','2022-05-12','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('5fViZF1K5YS5ELyBCYpVno','HOT (English ver.)','https://i.scdn.co/image/ab67616d0000b2737439e1a5b8ff259d5acae738','2025-03-17','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('5fy0X0JmZRZnVa2UEicIOl','1989','https://i.scdn.co/image/ab67616d0000b273b7e976d2b35c767f9012cb72','2014-01-01','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5G58VVE9ub1KE01Mvbd8XM','Therefore I Am','https://i.scdn.co/image/ab67616d0000b2737a152619a7b55bc621d07901','2020-11-12','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('5gAOt24yKsdtpKRj7S0IDH','Show Me the Money 777 Episode 4','https://i.scdn.co/image/ab67616d0000b273ba6e94d74d778c35d4cf5f20','2018-10-27','','Genie Music Corporation','','3hvinNZRzTLoREmqFiKr1b'),('5gAwSBomEDrhkVHrNpks8W','CRY FOR ME','https://i.scdn.co/image/ab67616d0000b273a801a363639ce993f89cd0de','2020-12-18','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('5GsSoccwm4oOWG2l50yM8B','WAVE','https://i.scdn.co/image/ab67616d0000b2734b2628b8a9cdb1fc37a687f6','2023-05-31','','Sony Music Labels Inc.','','6RHTUrRF63xao58xh9FXYJ'),('5gtzH1xaYI0w2KWITZaZUH','2step (feat. Leto)','https://i.scdn.co/image/ab67616d0000b273d56d4c810aab7c1124085b6d','2022-05-13','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('5h060Rb0cfAGuny0L51zqV','Lavender Haze (Felix Jaehn Remix)','https://i.scdn.co/image/ab67616d0000b27390212229c9230e320fe0ecd3','2023-02-10','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5H0rjI1TW8F2tORPYMJXHJ','The Marshall Mathers LP','https://i.scdn.co/image/ab67616d0000b27376ac6f4b5e6cda3c7f888ec0','2001-08-20','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('5H7ixXZfsNMGbIE5OBSpcb','THE TORTURED POETS DEPARTMENT: THE ANTHOLOGY','https://i.scdn.co/image/ab67616d0000b2738ecc33f195df6aa257c39eaa','2024-04-19','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5HlxNTQpJb7buoWIRS4M7T','An Ode','https://i.scdn.co/image/ab67616d0000b273595174aef621c2b6434ab343','2019-09-16','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('5hr8FCRbxJYqhFVFP0I1wU','Will','https://i.scdn.co/image/ab67616d0000b2739e5616ad413dbdeec519a0f4','2024-04-12','','Sony Music Labels Inc.','','6RHTUrRF63xao58xh9FXYJ'),('5HRsijCKONie2fJof0brIA','HWAA','https://i.scdn.co/image/ab67616d0000b273c665ee5922d25b5eba2df8bf','2021-01-27','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('5hTCo7WkqzVbUrcjbulmaX','Gunz N Smoke (feat. 50 Cent & Eminem)','https://i.scdn.co/image/ab67616d0000b273ef5927934a3393c6c12e9ec8','2024-12-12','','Death Row/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('5I5Bz7STXgcn5X2NYrDl2I','Jingle Bell Rock (Sped Up Version)','https://i.scdn.co/image/ab67616d0000b27316a6e2ee47a08165186acd2c','2023-12-14','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('5IIk4i6IkmsnF8UtRBMAeI','HIT','https://i.scdn.co/image/ab67616d0000b273c780123f175b5f152132218c','2019-08-05','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('5IkpPd87TzsNJm20l8JwSC','Nowhere Fast (Extended Version)','https://i.scdn.co/image/ab67616d0000b27354a0afd06cc1d61d7d03308c','2018-03-17','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('5iq9BytomHl2yBtORjUlzP','hotline (edit)','https://i.scdn.co/image/ab67616d0000b273c820a9669147be3addd7f221','2023-05-09','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('5iRyPj6D6MBfwLGzkGf4jz','SET ME FREE (Remixes)','https://i.scdn.co/image/ab67616d0000b2735ce11fa80cce355ffbb7894f','2023-03-17','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('5IYMYmX28qpI6OEnQhdazX','Fortnight (Acoustic Version)','https://i.scdn.co/image/ab67616d0000b273aecb5c6308cf8ce94199aea8','2024-07-09','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5jcarWURPZMLOwsdhIcDFo','IVE SWITCH','https://i.scdn.co/image/ab67616d0000b2738bcb1a80720292aaffb35989','2024-04-29','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('5Jd8G9DMwnwK7YVlFTvdnc','Drive (From F1® The Movie)','https://i.scdn.co/image/ab67616d0000b273a54b771b4e4bd658d3b3de11','2025-06-20','','Atlantic Records','','6eUKZXaKkcviH0Ku9w2n3V'),('5jdhMhfZ5gdaQnLsrFgcw4','EASY (English ver.)','https://i.scdn.co/image/ab67616d0000b273c629ad220477b75a258a8b2d','2024-02-23','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('5jhiu4dCBOM47mOhdvkgR0','UNFORGIVEN (feat. Nile Rodgers, Ado) -Japanese ver.-','https://i.scdn.co/image/ab67616d0000b273ebf1ce39393c49cef64f505f','2023-08-08','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('5k34rAvlw3WV7Kh6dAZnxG','KISS OF LIFE','https://i.scdn.co/image/ab67616d0000b2732ff7c76b0790cd3ad63cfc0c','2023-07-05','','S2 ENTERTAINMENT INC.','','4TEK9tIkcoxib4GxT3O4ky'),('5KBKAFdujYonKW9VnAVyBv','โคตรวิ่ง โคตรซิ่ง โคตรแซ้ด','https://i.scdn.co/image/ab67616d0000b2737838e78d11f426c6178c656f','2024-05-30','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('5kCysI0w6hkS54S2d0Jo7l','MOONLIGHT SUNRISE (Jonas Blue Remix)','https://i.scdn.co/image/ab67616d0000b27393db5fcb43bf7c2a04365ef1','2023-11-17','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('5kDohAcW2lWTidVekIJQZp','VALORANT Sounds Vol. 1','https://i.scdn.co/image/ab67616d0000b2735eb2199eddeefec51dd17a0a','2024-08-28','','Riot Games','','4TEK9tIkcoxib4GxT3O4ky'),('5KmE64fWLRoBHSvMcISctT','2016 BIGBANG WORLD TOUR [MADE] FINAL IN SEOUL LIVE','https://i.scdn.co/image/ab67616d0000b273016c825603d2a38f0e0353f8','2016-05-27','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('5KoRUnY8iciOIKS0IPYLwA','m-flo inside -WORKS BEST V-','https://i.scdn.co/image/ab67616d0000b273c3857e4c76354ecde1ef2919','2013-03-27','','rhythm zone','','4Kxlr1PRlDKEB0ekOCyHgX'),('5LXOgcszGvUkYzYL4v6wYg','Autumn Variations','https://i.scdn.co/image/ab67616d0000b273f6549a3f99e338b94d7ddc08','2023-09-29','','Gingerbread Man Records','','6eUKZXaKkcviH0Ku9w2n3V'),('5LyzI39gkePgpHz38bEQIr','Lavender Haze (Remixes)','https://i.scdn.co/image/ab67616d0000b273f7c84273e5c8ecb7594b4357','2023-03-03','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5m9lO9SriYMPpXTrVIU8P5','MyBoi (TroyBoi Remix)','https://i.scdn.co/image/ab67616d0000b273b01e0794e65a909958897fa2','2018-03-09','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('5MH95tw9aZo7ayqkfsRzMu','Epik High Is Here 上 (Part 1)','https://i.scdn.co/image/ab67616d0000b273dc050088a57887d11bd375ab','2021-01-18','','OURS Co.','','3hvinNZRzTLoREmqFiKr1b'),('5mjH6kL3zysY2X8VZVb9BU','Fuel (feat. WESTSIDE BOOGIE & GRIP) [Shady Edition]','https://i.scdn.co/image/ab67616d0000b273b357de09587026db1c24bb4d','2024-09-11','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('5mJIWTdZRIVSil8Aui640j','Gray (feat. BrotherSu)','https://i.scdn.co/image/ab67616d0000b273c41a09da8ec7a2065ce0cf99','2014-06-25','','파이니스트 레코즈','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5MQM8Jw1FvT21Dny8cOXjF','Holiday Night - The 6th Album','https://i.scdn.co/image/ab67616d0000b273ee58f0e04b175603c1f56668','2017-08-04','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('5mqmE56gLXHSS4IH2nSGsw','TWICEcoaster : LANE 2','https://i.scdn.co/image/ab67616d0000b273cdc88be48fb8e53efe3f2f43','2017-02-20','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('5mUdh6YWnUvf0MfklEk1oi','Stuck with U','https://i.scdn.co/image/ab67616d0000b2732babb9dbd8f5146112f1bf86','2020-05-08','','Ariana Grande & Justin Bieber \"Stuck With U\"- Charity','','66CXWjxzNUsdJxJ2JdwvnR'),('5MuQTjOeSApez8vNGb94Ur','나무','https://i.scdn.co/image/ab67616d0000b27364eea0085a043b52217179cb','2019-04-16','','Kakao Entertainment','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5NLGl8gMGqosUDYNxZIg86','Hottest Hits Ever 3','https://i.scdn.co/image/ab67616d0000b27320c8eba212bd2e4305304af8','2013-01-01','','Universal Music Philippines Inc.','','2dd5mrQZvg6SmahdgVKDzh'),('5NMtxQJy4wq3mpo3ERVnLs','Drama - The 4th Mini Album','https://i.scdn.co/image/ab67616d0000b273c54e39f2ae0dd10731f93c08','2023-11-10','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('5nOfPCLpHGpayGrUNHAPLt','Lace It (with Eminem & benny blanco)','https://i.scdn.co/image/ab67616d0000b273e05fe4b697132433e6419d08','2023-12-16','','Grade A Productions/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('5O0zUvdnJr0RbWzLFneN2i','Popular (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b2734c8f092adc59b4bf4212389d','2023-06-02','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('5OMoXElYTElvoKzM0CMV1a','I CAN\'T STOP ME (English Ver.)','https://i.scdn.co/image/ab67616d0000b2732aa302aa1b35201bc5794fb7','2020-11-30','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('5P2uqhsUdWHQ8sEdsX9xZE','I love','https://i.scdn.co/image/ab67616d0000b273568f9eafaf4580222d2aa22a','2022-10-17','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('5P3m24aXWEmpq8LoYVzofm','All Night Long (She is My Type♡ X Car, the garden)','https://i.scdn.co/image/ab67616d0000b273d6b3133308e802a537137d56','2020-09-03','','TOON STUDIO, NEUL','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5pEyhM1dfcAGCcXgxXILUw','Harmony','https://i.scdn.co/image/ab67616d0000b273d124243f84703b502af0e82a','2023-09-12','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5PLs75rpnPJJ7glQxY7E1i','Azizam (D.O.D Remix)','https://i.scdn.co/image/ab67616d0000b273c7bbab26d61a694b6343a30d','2025-05-16','','Gingerbread Man Records / Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('5q3jthpn2h59P7pe2gmAl7','You\'re Losing Me (From The Vault)','https://i.scdn.co/image/ab67616d0000b2734fe1868aa6838eb595f3673a','2023-11-29','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5Qae32LmUnMlJRqZv2BWvY','ALWAYS YOURS','https://i.scdn.co/image/ab67616d0000b273b21afd1bae8bc9633b97db97','2023-08-22','','HYBE LABELS JAPAN','','7nqOGRxlXj7N2JYbgNEjYH'),('5qFec1Z5GtW5wbUsaCRsWg','2011 Girls\' Generation Tour','https://i.scdn.co/image/ab67616d0000b273db0c30d57f2ea2d680b30160','2013-11-04','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('5QpD7kgp5dpkNFuG6ez2yI','SEVENTEEN SPECIAL ALBUM \'DIRECTOR\'S CUT’','https://i.scdn.co/image/ab67616d0000b273c7bb27d0e4ab6f8cdf61c087','2018-02-05','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('5rI92smOlSS5d1Hq05BY7M','ALIVE','https://i.scdn.co/image/ab67616d0000b273dd2c0e8a5d4b0c1e227e4c7b','2012-02-29','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('5RNKudvhTz6IX57BupmjeD','Santa, Can’t You Hear Me','https://i.scdn.co/image/ab67616d0000b273d33d459f99f410c7a64ddaf2','2021-10-14','','Atlantic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('5RylhkCb6kzwJDokcvQZeE','Hot Mess','https://i.scdn.co/image/ab67616d0000b27386ed11a147dbe7eaa9ca31dd','2024-07-03','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('5RywVUX8IUEPcj3VO6Bq3y','Can I Love?','https://i.scdn.co/image/ab67616d0000b2736fa852f8683fc5ff2785e3da','2019-02-18','','STONESHIP / ADA','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5sEbNBMGwEidPQM52Vz1Zo','Voice (Original Television Soundtrack), Pt. 3','https://i.scdn.co/image/ab67616d0000b273ef9380d6e7e1ca100c35125c','2017-03-05','','Genie Music Corporation','','3hvinNZRzTLoREmqFiKr1b'),('5SeTJqBm4ySWXaeiRu3lQh','E','https://i.scdn.co/image/ab67616d0000b273d603cd05caa363442eb90dab','2015-08-05','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('5SNPs8Oz8Nmhv0MA6YnJpE','F64','https://i.scdn.co/image/ab67616d0000b273cee4f53892ab0f574b81b68f','2023-01-19','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('5STl99J7pIPr4qIJ72COq0','Hotel del Luna (Original Television Soundtrack) Pt. 8','https://i.scdn.co/image/ab67616d0000b27351d4a2f7e6188ddc597a92af','2019-08-10','','Beyond Music','','1z4g3DjTBBZKhvAroFlhOM'),('5suBD7aDfNiIkbUvYaHtfR','Alchemy of Souls, Pt. 1 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273a5b3932c6497daf873029eb3','2022-06-26','','Genie Music Corporation','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5sXSHscDjBez8VF20cSyad','No Time To Die','https://i.scdn.co/image/ab67616d0000b273f7b7174bef6f3fbfda3a0bb7','2020-02-13','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('5tla8V4hgYKbJq42SKlSJl','MORE & MORE','https://i.scdn.co/image/ab67616d0000b2730e55cdb6e5effea4255e5eed','2020-06-01','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('5tVF9innz1XK3xj72Phi7e','BETTING','https://i.scdn.co/image/ab67616d0000b2738c76ab7a6728045085cd85ab','2023-01-17','','WM Japan','','7nqOGRxlXj7N2JYbgNEjYH'),('5UACk85y1hNRSUtY0ss8pb','k bye for now (swt live)','https://i.scdn.co/image/ab67616d0000b273d0f561d8bb164349dccbfde4','2019-12-23','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('5uCFinoHAfvh3RM5UuBhZ6','SUPERPOWER','https://i.scdn.co/image/ab67616d0000b27327fd6daa963e20296ab62a1b','2024-07-23','','Riot Games','','4TEK9tIkcoxib4GxT3O4ky'),('5ucqRkwqBGucSKivEVKVTg','Like Fire','https://i.scdn.co/image/ab67616d0000b273cb83ed304f2106f9b300b5dc','2020-11-10','','Galm','','6GwM5CHqhWXzG3l5kzRSAS'),('5ulYXl8kDywda5dOOFkZpX','Gospel (with Eminem)','https://i.scdn.co/image/ab67616d0000b2738a0fca8848835d3b4bf75796','2022-02-04','','Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('5UtlJbQjBPqwvfhbdnUmwq','고백하기 좋은 날 (Special Edition)','https://i.scdn.co/image/ab67616d0000b273e4eb6bcc2432d62573d10f00','2007-06-26','','Beyond Music','','6GwM5CHqhWXzG3l5kzRSAS'),('5uwmamGSJ3ayFsFflf8Wp5','kiss me under the light of a thousand stars','https://i.scdn.co/image/ab67616d0000b27387b85225d24eda2d6d77d330','2024-09-18','','Warner Music UK Ltd','','6eUKZXaKkcviH0Ku9w2n3V'),('5v4WHupyMlHFLuZ0lmyv5c','Angel Anniversary Edition (feat. Muni Long, JVKE, NLE Choppa)','https://i.scdn.co/image/ab67616d0000b2735cae2e3d2932cd9283cc53ff','2024-05-13','','APG Inc – FF10','','3Nrfpe0tUJi4K4DXYWgMUX'),('5vFMpCfTy6V4Fy9Nu95t0Z','Kids Party','https://i.scdn.co/image/ab67616d0000b273038d9b6e8596c1b1bcb79db8','2019-12-13','','Rhino','','41MozSoPIsD1dJM0CLPjZF'),('5vgkX6abffhom2ejVI11yq','Die For It (ft. Nas)','https://i.scdn.co/image/ab67616d0000b2736c1f7876d7322a196d9880ca','2021-08-26','','XO | Roc Nation Records, LLC','','1Xyo4u8uXC1ZmMpatF05PJ'),('5vgWXUueeEU2labRz6TlNv','Anti-Hero (Acoustic Version)','https://i.scdn.co/image/ab67616d0000b2730fc559ebbed8b0b100ad206c','2022-11-25','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('5VhdYECXgIDMRCXMFsNblJ','K-POP ScreaM 1','https://i.scdn.co/image/ab67616d0000b273fa21ad6c733150e88af5924a','2024-12-11','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('5VmjGHq779chFVL7dgLbyo','SEVENTEEN 5th Mini Album \'YOU MAKE MY DAY\'','https://i.scdn.co/image/ab67616d0000b2737c8b796098da718dfbbcd49a','2018-07-16','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('5wUOHd5fawoTLM6Qi65WOr','Fantastic Duo 2 Part.4','https://i.scdn.co/image/ab67616d0000b273a2dfa0d93952f10779d19f13','2017-06-04','','(주)SBS ContentsHub','','2dd5mrQZvg6SmahdgVKDzh'),('5WyEkWi7ZPMrVSbU1Cabba','2NE1 1st Mini Album','https://i.scdn.co/image/ab67616d0000b2733f8606c9858cf75ec30dc20e','2009-07-08','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('5x3ZoZjexntAoipx0KaDnf','When I\'m Gone','https://i.scdn.co/image/ab67616d0000b273c3e575617a5604fc4c34d93b','2005-12-06','','Aftermath/Shady','','7dGJo4pcD2V6oG8kP0tJRR'),('5X7x18kW3mVIvnuNeedM6b','Dangerous Woman','https://i.scdn.co/image/ab67616d0000b2732e651648db439a9b5995e065','2016-05-20','','Universal Records','','66CXWjxzNUsdJxJ2JdwvnR'),('5xD1PSd5c5APDM0SdkkqnH','+-=÷× (Tour Collection)','https://i.scdn.co/image/ab67616d0000b27332b9c18c7c4e4f0a20608918','2024-09-27','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('5XRJoC2QtsNbAubsCrBBbG','COPYCAT (Sofi Tukker Remix)','https://i.scdn.co/image/ab67616d0000b2738fbc40da547bc157e8956cea','2018-01-12','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('5ybpUmlJnbqeo3KAv05MLI','True Beauty (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273fc8e177a73e8c13c8460c433','2021-02-05','','Genie Music Corporation','','7c1HgFDe8ogy5NOZ1ANCJQ'),('5YCwwhPQwNhsKU7CULV2WC','2014 BIGBANG +α IN SEOUL','https://i.scdn.co/image/ab67616d0000b2731e7420b38dd8ababbf162b0f','2014-03-28','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('5yrQ3iAPahUOZUk1g47OIz','FEARLESS (Japanese ver.)','https://i.scdn.co/image/ab67616d0000b2734297930d262198d876768224','2022-12-15','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('5ZewPP4nTMtJTn4krePB2d','+-=÷× (Tour Collection: Live)','https://i.scdn.co/image/ab67616d0000b2732a18a1cd29940db94799c62d','2024-12-27','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('5zWa1ZEUBctbKqvwXbFawo','Summer Magic - Summer Mini Album','https://i.scdn.co/image/ab67616d0000b2736017bca98dea58ceddea77c1','2018-08-06','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('607R3veMPfNTZ4VzMEVy3d','CRUSH','https://i.scdn.co/image/ab67616d0000b273c3a330eb913aaec37dd8d567','2024-08-07','','Sony Music Labels Inc.','','6RHTUrRF63xao58xh9FXYJ'),('60z8h4jCOyt36F3Arn8RGD','24H','https://i.scdn.co/image/ab67616d0000b27377994c4a14b2aa6167a6d0fa','2020-09-08','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('61dUL51qxsxQJMdai6HiUH','yes, and? (The Blessed Madonna’s Godsquad Mix)','https://i.scdn.co/image/ab67616d0000b2735813b17a0ce0a0da2171302d','2024-01-12','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('61ZCeqzP8onzBEP7dR0P5t','ZOOM ZOOM','https://i.scdn.co/image/ab67616d0000b2735b38b036c66d46f02371ec3c','2023-10-06','','WARNER MUSIC JAPAN INC.','','6YVMFz59CuY7ngCxTxjpxE'),('62kX5esOPtWPjfCbT7tQwb','A-TEEN Part.3','https://i.scdn.co/image/ab67616d0000b273fa55f560b1b17771aab66a10','2018-08-13','','PLAYLIST','','7nqOGRxlXj7N2JYbgNEjYH'),('62OlfZyTDTwngT4QlTxiAo','A Hand For Mrs. Claus','https://i.scdn.co/image/ab67616d0000b27365947a7758ad0eb53beb8ab5','2019-10-18','','Idina Menzel/Silent Records 2.0','','66CXWjxzNUsdJxJ2JdwvnR'),('63mur6I6yCG9cOxOst3i7c','YOUNHA 6th Album Repackage \'END THEORY : Final Edition\'','https://i.scdn.co/image/ab67616d0000b2732918f236448bf544586e388a','2022-03-30','','C9 Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('63oE2Ew3Mud2Md9TXBjeKw','_WORLD','https://i.scdn.co/image/ab67616d0000b273e35910c10246838dff3ead7c','2022-08-26','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('64LU4c1nfjz1t4VnGhagcg','1989 (Taylor\'s Version)','https://i.scdn.co/image/ab67616d0000b273904445d70d04eb24d6bb79ac','2023-10-26','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('64RwgplkeOHLK04rkdf9Fq','Street Man Fighter Original Vol.1','https://i.scdn.co/image/ab67616d0000b27387483b27a0faaa03cbc0b293','2022-03-04','','Genie Music Corporation','','3hvinNZRzTLoREmqFiKr1b'),('65iXBHLsOnNVC5C6nVbLYf','Tobey (feat. Big Sean and BabyTron)','https://i.scdn.co/image/ab67616d0000b273133d7c014b5bec0d7eea09b7','2024-07-02','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('65X8oNWJyq6abR094X1hlD','we can\'t be friends (wait for your love) [acoustic (live from jungle city studios)]','https://i.scdn.co/image/ab67616d0000b2731aa109856c4781fd6c9cd111','2024-09-08','','Ariana Grande LP6','','66CXWjxzNUsdJxJ2JdwvnR'),('66HIHPYA5HkWpwk4gjVSsB','SIGNAL','https://i.scdn.co/image/ab67616d0000b273a058c0002ba258f187bbbacf','2017-05-15','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('66J1OXSaS3hBZASOV3el8t','FACE YOURSELF','https://i.scdn.co/image/ab67616d0000b2737df155730d4d753560ec28a5','2018-04-04','','Universal Music LLC','','3Nrfpe0tUJi4K4DXYWgMUX'),('684W6NpKllEexqQlGqetCi','thank u, next','https://i.scdn.co/image/ab67616d0000b273ffa275ba245edba4c1c720af','2018-11-03','','Universal Records','','66CXWjxzNUsdJxJ2JdwvnR'),('698RZEC6WYFtoQR1cABe4x','Yossism (Music from Telemonster)','https://i.scdn.co/image/ab67616d0000b273ad2002e31133c0d5c9dfb0f0','2016-05-02','','MBC (문화방송)','','1z4g3DjTBBZKhvAroFlhOM'),('69a7YNzhApHfLFwHvPkCso','세가지 소원 Wish Tree - WINTER GARDEN','https://i.scdn.co/image/ab67616d0000b2733e2194d332ceeb0ab6018b21','2015-12-18','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('69xF8jTd0c4Zoo7DT3Rwrn','MY WORLD - The 3rd Mini Album','https://i.scdn.co/image/ab67616d0000b27304878afb19613a94d37b29ce','2023-05-08','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('6al2VdKbb6FIz9d7lU7WRB','Proof','https://i.scdn.co/image/ab67616d0000b27317db30ce3f081d6818a8ad49','2022-06-10','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('6AORtDjduMM3bupSWzbTSG','evermore (deluxe version)','https://i.scdn.co/image/ab67616d0000b27390fd9741e1838115cd90b3b6','2021-01-07','','TS/Republic','','06HL4z0CvFAxyc27GXpf02'),('6AqgVBjPPgjd4OwLHaHcGE','Home Run','https://i.scdn.co/image/ab67616d0000b273fcefd4e0068c48fb43490c2a','2003-05-03','','(주)웰메이드엔터테인먼트','','2dd5mrQZvg6SmahdgVKDzh'),('6Ar2o9KCqcyYF9J0aQP3au','Speak Now','https://i.scdn.co/image/ab67616d0000b273d0eae3c1661a96570f0ca7bd','2010-10-25','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('6b08mw1Ggz7UyVYas1iRgj','Tonight','https://i.scdn.co/image/ab67616d0000b2733058758c444837fa2fbbe382','2011-02-24','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('6b8E5Y8RyNEVlBRqm6NDqH','I GOT YOU (Voyage ver.)','https://i.scdn.co/image/ab67616d0000b273311b44c5a1cadfc5d78fbb10','2024-02-06','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('6bZk9oecizspP2MeHIhKYL','CRAZY (feat. PinkPantheress)','https://i.scdn.co/image/ab67616d0000b2734ec5f1c1206663498a55e67a','2024-09-04','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('6BzqstW5jIRkziNNNwhqgS','Don\'t Touch My Phone','https://i.scdn.co/image/ab67616d0000b273ae59878d35e5917b407836a4','2019-10-04','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('6cBUK5AI8KxyAgqgKvCmkZ','대물 Pt. 3 Original Television Soundtrack','https://i.scdn.co/image/ab67616d0000b2738e9c8480be8a4b4c88138de6','2010-10-18','','㈜뮤직앤뉴','','2dd5mrQZvg6SmahdgVKDzh'),('6cbwstHlsAIIWurIIXXBPd','eternal sunshine deluxe: brighter days ahead','https://i.scdn.co/image/ab67616d0000b2735ab3c842fde848df7a4ee6d9','2025-03-28','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('6czdbbMtGbAkZ6ud2OMTcg','Yours Truly','https://i.scdn.co/image/ab67616d0000b273ea28881e9e363244a4a2347b','2013-01-01','','Universal Records','','66CXWjxzNUsdJxJ2JdwvnR'),('6d8IUfMwq7HGCnR2efXjdm','Message In A Bottle (Fat Max G Remix) (Taylor’s Version)','https://i.scdn.co/image/ab67616d0000b273e53252ce47982a3d555a6b3b','2022-01-21','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('6DEjYFkNZh67HP7R9PSZvv','reputation','https://i.scdn.co/image/ab67616d0000b273da5d5aeeabacacc1263c0f4b','2017-11-10','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('6dhAJ4oigNFSv4paZnZHmW','Eyes Closed (Piano Version)','https://i.scdn.co/image/ab67616d0000b2735d8aeaadd021444c5c05e737','2023-03-23','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('6dKiUptfDj1t5YIR9btSVt','盖世英雄 第1期 (Live)','https://i.scdn.co/image/ab67616d0000b27399d86447d7008914ecc990a8','2016-06-19','','梦响强音','','2dd5mrQZvg6SmahdgVKDzh'),('6DmXKM13nNgIIby2FdK0f8','Take My Breath','https://i.scdn.co/image/ab67616d0000b2733c041e53cb5c38b6de03e758','2021-08-06','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('6DN7GcZF1HywzrkGN6Eeqk','The Marshall Mathers LP2 (Deluxe)','https://i.scdn.co/image/ab67616d0000b273c6338d684995af10c2bf0533','2013-11-05','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('6DpIyaMgt5p9HlGd1c0LDM','No.5 Collaborations Project','https://i.scdn.co/image/ab67616d0000b2733c33fbe943babf9510e3715c','2011-09-09','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('6E3IPXh38G7UHLqVdfIY5h','The Idol Episode 1 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b2736d20a763ad0e31c924c5e176','2023-06-09','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('6eIAW6j9VKE11wW7ufsWVD','ยิมก็เข้า เหงาได้ไง','https://i.scdn.co/image/ab67616d0000b273e0bb3b85b334afd037f3a9e7','2024-06-27','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('6eKdbTio5viiwJ5FE5J8wU','Lavender Haze (Acoustic Version)','https://i.scdn.co/image/ab67616d0000b273f233c37dddd971caf61515cf','2023-03-31','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('6EmLwnyjJRVgNOmOUpVhzz','Into the New World','https://i.scdn.co/image/ab67616d0000b273c1424c81a4a89cf51587aa18','2007-08-02','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('6ep57xzNzxOuSCIw4iEfIv','BIGBANG10 THE CONCERT 0.TO.10 FINAL IN SEOUL','https://i.scdn.co/image/ab67616d0000b273cdeac10253b85cda391ad9b6','2017-05-25','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('6eQpKhYCtvD0TwXQVHsgC2','&burn (with Vince Staples)','https://i.scdn.co/image/ab67616d0000b273f3425d012117543bf914c451','2017-12-15','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('6EVYTRG1drKdO8OnIQBeEj','My Everything (Deluxe)','https://i.scdn.co/image/ab67616d0000b273deec12a28d1e336c5052e9aa','2014-08-22','','Universal Records','','66CXWjxzNUsdJxJ2JdwvnR'),('6eWjlIIzUgYLsyMzPMQoSH','Sunset Vibes','https://i.scdn.co/image/ab67616d0000b27396585325ff31651e1509f4bf','2021-10-08','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('6Exo0MYoL3XammoTDeihFy','Die For You (Remix)','https://i.scdn.co/image/ab67616d0000b2738de12a274f6e1df6634f57ec','2023-02-24','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('6Ez4Ul37Uzz9yGcorzhGMV','2step (feat. Armaan Malik)','https://i.scdn.co/image/ab67616d0000b27353cbce96c0a3fb3fceea2fe6','2022-05-23','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('6EzbFdrwvWpnpUjzrR57aU','The Eminem Show (Expanded Edition)','https://i.scdn.co/image/ab67616d0000b273a18291a1854b9b6371ff9663','2022-05-26','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('6F4ObGnJwwV5W4uLFHnNoT','From The D 2 The LBC (with Snoop Dogg)','https://i.scdn.co/image/ab67616d0000b2730b1ee9a3fa131e4f59998657','2022-06-24','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('6F87lH0I09qlrzvCCKc7lz','Thursday (Original)','https://i.scdn.co/image/ab67616d0000b273e01c2631218e2de27765b7d5','2011-08-18','','Universal Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('6fgSKdHloRioPrZ9oJC7FH','One Right Now','https://i.scdn.co/image/ab67616d0000b2734158fe41143182ec16ead070','2021-11-05','','Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('6FK2NjcZxGIGmFjKfOkrNi','7 rings (Remix)','https://i.scdn.co/image/ab67616d0000b2731ff0d73c806cee99181eb06e','2019-02-01','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('6fwBXtZ3uEFn5qU24zoK8W','Off The Record','https://i.scdn.co/image/ab67616d0000b27308250d12e34f6c41a251c8ab','2023-10-06','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('6fyR4wBPwLHKcRtxgd4sGh','Speak Now World Tour Live','https://i.scdn.co/image/ab67616d0000b273be4ec62353ee75fa11f6d6f7','2010-10-25','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('6fyUUW7ISpjbxCxaBHl1UN','Life Goes On (feat. Luke Combs)','https://i.scdn.co/image/ab67616d0000b273dd0c0090129ad5fb99d361c8','2023-05-03','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('6GnWToxHfF7hobSYdi5V8u','Dreamers [Music from the FIFA World Cup Qatar 2022 Official Soundtrack]','https://i.scdn.co/image/ab67616d0000b273cfe3ffeee2f4ec0291f9d969','2022-11-20','','Katara Studios | 2101 Records under exclusive license to UnitedMasters LLC','','3Nrfpe0tUJi4K4DXYWgMUX'),('6GvYONX7JKhU1OVX7BREO7','Sailing (0805) - SM STATION','https://i.scdn.co/image/ab67616d0000b2737c3118c0b496f78586f3c724','2016-08-05','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('6gzKQD8JoD775o5EQXATn5','I\'VE MINE','https://i.scdn.co/image/ab67616d0000b2733bbc6a71db1759c3b0053135','2023-10-13','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('6h4ZRW8ptciCijS4IeWYMo','Supernova Love','https://i.scdn.co/image/ab67616d0000b273a9e2a741cb80ebb155b9929f','2024-11-08','','E2W GROUP (KDM Records)','','6RHTUrRF63xao58xh9FXYJ'),('6hG3ULFi0ihwxjEudeUt9L','Shohikigen','https://i.scdn.co/image/ab67616d0000b27323cf07a9c0df1cd37c12a969','2024-11-27','','HYBE JAPAN / UNIVERSAL MUSIC','','7nqOGRxlXj7N2JYbgNEjYH'),('6HmUGM55FYKtA0jm3lgyFW','We Go (English Version)','https://i.scdn.co/image/ab67616d0000b273418e2c9e674ca6704e182387','2024-09-20','','Pokémon','','6YVMFz59CuY7ngCxTxjpxE'),('6hNLdNMUCMn3SHDmiqgkZB','Strategy 2.0','https://i.scdn.co/image/ab67616d0000b273c60c979a7454bbf3ebfdb162','2024-12-18','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('6HqiFsktBxto6ushwmDOUj','RE:WORKS','https://i.scdn.co/image/ab67616d0000b273764f05a8507a4012afbca027','2024-10-07','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('6HXlnhMr40FP2qBTnKXRbA','Relapse [Deluxe]','https://i.scdn.co/image/ab67616d0000b273f135bf1dee323e1aef89ffbf','2009-05-15','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('6i0Sg2bKKa42FMqeku3Njw','Hello','https://i.scdn.co/image/ab67616d0000b273324286e2ada936f4bcaf6c60','2017-12-11','','C9 ENTERTAINMENT','','6GwM5CHqhWXzG3l5kzRSAS'),('6I0ZEVomYGoOk218KaAlJk','Angel Pt. 2 (feat. Jimin of BTS, Charlie Puth and Muni Long / FAST X Soundtrack)','https://i.scdn.co/image/ab67616d0000b2733af4efcbc640cf0cb0888d63','2023-06-15','','APG Inc – FF10','','3Nrfpe0tUJi4K4DXYWgMUX'),('6I3a9Dp8ZrsVWhbQja7xBz','Side To Side (Remixes)','https://i.scdn.co/image/ab67616d0000b27384151e4881d2a5f8a9b10985','2017-02-03','','Universal Records','','66CXWjxzNUsdJxJ2JdwvnR'),('6iec7EBzWxy6r6khfwnpaw','PURE RAGE (Remix)','https://i.scdn.co/image/ab67616d0000b27368fedf4ee271935ab41a929e','2024-04-14','','Genie Music Corporation;Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('6iVS1t7wQUHItUnCxH7epG','My Universe','https://i.scdn.co/image/ab67616d0000b273fb7fdc6524b1224cc04985f5','2021-09-27','','Parlophone UK','','3Nrfpe0tUJi4K4DXYWgMUX'),('6J6nVNUrHZHYf2uh29iEZI','What is Love?','https://i.scdn.co/image/ab67616d0000b2734ddb095ce368de91b088f1ce','2018-04-09','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('6jA9fU91iednBgWrmAqZJW','Homesick','https://i.scdn.co/image/ab67616d0000b273cad92cf1d535bc6a0754decd','2024-05-16','','ADA Korea','','3hvinNZRzTLoREmqFiKr1b'),('6jYrnuvdOVxQjl0J2QBWRm','Psyfive','https://i.scdn.co/image/ab67616d0000b273faffca53c15ad4982d462d33','2010-10-20','','YG Entertainment','','2dd5mrQZvg6SmahdgVKDzh'),('6kAsgfuulBOuyYLytWX7e2','CRAZY (Party Remixes 1)','https://i.scdn.co/image/ab67616d0000b273d49db78bd7ea1f7229865baa','2024-09-02','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('6kJUNcmxtUyPBx00dNBidi','LATATA (English Ver.)','https://i.scdn.co/image/ab67616d0000b273dcaf1ebfc193c385f86c3929','2020-05-15','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('6kZ42qRrzov54LcAk4onW9','Red (Taylor\'s Version)','https://i.scdn.co/image/ab67616d0000b273318443aab3531a0558e79a4d','2021-11-12','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('6LM7oiElbxhLJJRL6K7AB5','Cosmic','https://i.scdn.co/image/ab67616d0000b2734bbd264a9b9d7788a849f781','2024-08-01','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('6lMlX68jJrx67hiCqdiDvW','bad guy (with Justin Bieber)','https://i.scdn.co/image/ab67616d0000b273a69b8b111a5fb8cb1c97e8eb','2019-07-11','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('6LuY3APmuxui8BM2oibkrZ','Out Of Time (Remix Bundle)','https://i.scdn.co/image/ab67616d0000b273c34dffa3ee633fa3915c6806','2022-04-22','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('6MMkaYzyM0aLZmDBce3nL6','행복(Happiness)','https://i.scdn.co/image/ab67616d0000b273ccd9a8fe25e9ae6039ac6ce6','2014-08-01','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('6mNdtZhr5zcz2SLzyPxweY','yes, and?','https://i.scdn.co/image/ab67616d0000b27350d52e177103f2e0c40a2e94','2024-01-18','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('6MNlcai3skKLKv5syzFwC3','Russian Roulette - The 3rd Mini Album','https://i.scdn.co/image/ab67616d0000b2733f30a062dafcdbc1a8fad842','2016-09-07','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('6Msc3BwzKZ5f5FXmKuUSu6','Perfect Night','https://i.scdn.co/image/ab67616d0000b2735e352f6eccf8cb96d0b247cc','2023-10-27','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('6N25MmXrrGmBV8ZlUW8cTv','Groundwork','https://i.scdn.co/image/ab67616d0000b27339d1f861712ec0e9412a7e0b','2022-08-26','','Dice Recordings Music Ltd','','6eUKZXaKkcviH0Ku9w2n3V'),('6naCRqrE036Uojfz7Jk64c','Spotify Singles - Holiday','https://i.scdn.co/image/ab67616d0000b273fba40b89e93e611e246c97f3','2022-11-16','','STARSHIP Entertainment','','6RHTUrRF63xao58xh9FXYJ'),('6oeww5DTxCKE4h5sSkoRjI','Super (Workout Remix)','https://i.scdn.co/image/ab67616d0000b27346c347ba038cd60562c3dd8d','2024-02-16','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('6OXg149IkmbgW7zfzbwgS2','The Red Summer - Summer Mini Album','https://i.scdn.co/image/ab67616d0000b2738164cd1a2e03b7ca2db9ff5e','2017-07-09','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('6Pe5LGQgU3mmvuRjFMsACV','Queendom - The 6th Mini Album','https://i.scdn.co/image/ab67616d0000b273830de2e836036f181df598d0','2021-08-16','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('6Pik9EkIv4E4SRxUR2VKiz','Beyond Evil (Original Television Soundtrack) Pt. 3','https://i.scdn.co/image/ab67616d0000b2737ab7446336a4a7af0a8248f1','2021-03-13','','MUSIC&NEW','','7c1HgFDe8ogy5NOZ1ANCJQ'),('6PoE8iSjGgr9bMIGPdJcVX','Pop Icons','https://i.scdn.co/image/ab67616d0000b273281c5e4934de1eb84768a40d','2022-02-11','','Warner Music Group - X5 Music Group','','41MozSoPIsD1dJM0CLPjZF'),('6q9YOWpWu7QA3MeHbpIoLC','Closely Far Away','https://i.scdn.co/image/ab67616d0000b2735715142fe7cecb7729304426','2021-08-26','','니즈뮤직','','7c1HgFDe8ogy5NOZ1ANCJQ'),('6QfFpCdG9XXQQ9pPJQtxz7','the boy is mine','https://i.scdn.co/image/ab67616d0000b2730f41d138987a79efce0f884c','2024-07-19','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('6S6JQWzUrJVcJLK4fi74Fw','Speak Now (Deluxe Package)','https://i.scdn.co/image/ab67616d0000b273e1bc852a04501952c765d5cd','2010-01-01','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('6Slya5Y7lRGY9G5DhSLqo3','Absence','https://i.scdn.co/image/ab67616d0000b273572c3481841c6f020cfa80cc','2021-01-28','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('6TvXkVvQAoztPhy1zFomdu','YOUNHA 7th Album Repackage ‘GROWTH THEORY : Final Edition’','https://i.scdn.co/image/ab67616d0000b2736d61d621ad5c74c2653bb546','2024-11-14','','C9 Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('6uSzRAcTm7VIF9kXmEW1YK','TOTO','https://i.scdn.co/image/ab67616d0000b2732b060a0821fca8bec78f7647','2024-03-29','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('6uWbkjA7Osh3VNnnGeyfl6','iScreaM Vol.33 : Supernova / Armageddon Remixes','https://i.scdn.co/image/ab67616d0000b2738ea1c16ce57f0a2b171bebfd','2024-09-20','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('6VfBBrRc9CiWisIAoBeTqs','Open Hearts','https://i.scdn.co/image/ab67616d0000b2739d70654ee9ed03bbc86facf1','2025-01-29','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('6vFZol8S54OKgwhe3CQhMx','Eyes wide open','https://i.scdn.co/image/ab67616d0000b27396ff749ff299005ddac4cf4c','2020-10-26','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('6vJRxj9GnmwXT7mKJqE61n','Starry Eyes (MIKE DEAN Remix)','https://i.scdn.co/image/ab67616d0000b273b85976e1b1bd2d00ff551a01','2022-07-01','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('6VuZIPDz8dyFaHlH7HhIWr','songs I wrote that almost didn\'t make it','https://i.scdn.co/image/ab67616d0000b273e9a0f1f6d2e9d51754ad3cdb','2024-08-07','','Warner Music UK Ltd','','6eUKZXaKkcviH0Ku9w2n3V'),('6wlo2cGnBTzluPkeMDiOy0','Drama (Sped Up Version)','https://i.scdn.co/image/ab67616d0000b273c9a86dfd2da4ce51cfdd4652','2023-12-15','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('6wP16i20tF48BtJhPUFrjF','VIOLINIST','https://i.scdn.co/image/ab67616d0000b27342f77ead5ea888c6e011200c','2018-11-16','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('6wRev1uYL0JsMsWqktJuVi','Kiss Land (Deluxe)','https://i.scdn.co/image/ab67616d0000b273b06645ac5eaf2249c4f5fac7','2013-09-10','','Universal Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('6XF6MZOJ4SrfopEmYc0y0g','The Hottest Hits Ever 5','https://i.scdn.co/image/ab67616d0000b273fdac2ed7f4ebb8bd6b8d5fd4','2014-01-01','','Universal Music Philippines Inc.','','2dd5mrQZvg6SmahdgVKDzh'),('6Xuu2z00jxRPZei4IJ9neK','Houdini','https://i.scdn.co/image/ab67616d0000b273810603c94c9246379604cf1a','2024-05-31','','Shady/Aftermath/Interscope Records','','7dGJo4pcD2V6oG8kP0tJRR'),('6xzTGXUxiDgdIH9TZiHKz8','Her Private Life, Pt. 1 (Original Television Soundtrack)','https://i.scdn.co/image/ab67616d0000b273e5408dddae3d7013b168f5c0','2019-04-11','','Genie Music Corporation','','2AfmfGFbe0A0WsTYm0SDTx'),('6y6lP1WRfqEhv8RLy4ufZB','Sour Candy (with BLACKPINK)','https://i.scdn.co/image/ab67616d0000b273348a8b432f3e8e02f342056e','2020-05-28','','Interscope Records','','41MozSoPIsD1dJM0CLPjZF'),('6yawSZpyFEU0wPKhXcEIHI','We are','https://i.scdn.co/image/ab67616d0000b273528f2c7966222380e8533486','2025-05-19','','CUBE Entertainment','','2AfmfGFbe0A0WsTYm0SDTx'),('6yDtQxvq1XRC7Y5qtS03Xx','Born to be XX','https://i.scdn.co/image/ab67616d0000b27396d36aec71bf25f59df5cc96','2023-11-08','','S2 ENTERTAINMENT INC.','','4TEK9tIkcoxib4GxT3O4ky'),('6yetqbA9vli7RLoUWYZLsq','SQUARE UP','https://i.scdn.co/image/ab67616d0000b27314d1e0d0aba77339c007ed92','2018-06-15','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('6YfBr5xHzi9cp0C1CD9kQi','Dance Again','https://i.scdn.co/image/ab67616d0000b2736ff3540d5f6399b45983c708','2023-12-12','','WARNER MUSIC JAPAN INC.','','7n2Ycct7Beij7Dj7meI4X0'),('6YL9J0E6PGtYzkhyMxnmXd','The Red - The 1st Album','https://i.scdn.co/image/ab67616d0000b27371a70331062453ece06f8b79','2015-09-09','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('6yr53YySD8G0GRwveBg835','Show Me the Money 777 Episode 1','https://i.scdn.co/image/ab67616d0000b273e8c1eddbb6ea854ee9607863','2018-10-06','','Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('6YsKzkuaCcKLEPGN69hnU1','Til My Fingers Bleed (with DINO, Duckwrth & Telle)','https://i.scdn.co/image/ab67616d0000b273b714552b16efdb04fa24f0e5','2025-06-30','','EWC Music','','7nqOGRxlXj7N2JYbgNEjYH'),('6ZVAJLO3XU1zwG4wKfh4fN','The year of \"YES\"','https://i.scdn.co/image/ab67616d0000b27396989f8ac935cb3511760705','2018-12-12','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('70d4XoTl0TJ3CNSLqWdUxs','Perfect Night (for FEARNOT)','https://i.scdn.co/image/ab67616d0000b2731c6e4f383b888a0510b3ee79','2024-08-09','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('72thNb01TdCCtiEiJnrN5w','Maserati & Porsche','https://i.scdn.co/image/ab67616d0000b273c59ff694c9206d272360e90c','2018-12-21','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('72XnzDKWVpoXAJGjxxLbAw','Song Book','https://i.scdn.co/image/ab67616d0000b273677560af250a776cebc12d71','2008-12-05','','오감엔터테인먼트','','0Sadg1vgvaPqGTOjxu0N6c'),('742eAldb4AJKLoPgJhGRE7','After Hours (Deluxe)','https://i.scdn.co/image/ab67616d0000b273ef017e899c0547766997d874','2020-03-20','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('74TRp3O8BRdGxc0XO0UzoY','Six Feet Under','https://i.scdn.co/image/ab67616d0000b273fae80fc6c7f60e75cfc519c7','2016-11-17','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('74vajFwEwXJ61OW1DKSPEa','Positions (Deluxe)','https://i.scdn.co/image/ab67616d0000b2739508fb7ca2eedc0d98b9139f','2021-02-19','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('75dYF3lceMhO7v151kAvKL','LOVE, MONEY, FAME (feat. DJ Khaled) (Timbaland Remix)','https://i.scdn.co/image/ab67616d0000b27315d0be7ffa76b80dc63aead6','2024-11-01','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('75ii7SGF9jbD1ireJ0CeNI','Queendom < Box of Pandora > Pt. 1','https://i.scdn.co/image/ab67616d0000b273a9e412451691682611af56f1','2019-10-18','','Genie Music Corporation','','2AfmfGFbe0A0WsTYm0SDTx'),('75LBd3Qv8p2DqqGk3oykdx','FLOWER ROAD','https://i.scdn.co/image/ab67616d0000b2733e04b4993e7417526bdffbc5','2018-03-13','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('75OnTvYZ4pqKD5ezgFOpGO','【雅-miyavizm-主義】','https://i.scdn.co/image/ab67616d0000b2739df3772d9d4e3b429e6ef158','2005-06-01','','Universal Music LLC','','2dd5mrQZvg6SmahdgVKDzh'),('75rFaEWO9nufjSlTcg3wPS','EASY (Remixes)','https://i.scdn.co/image/ab67616d0000b273361ccf8d7188a3c5101b98e9','2024-02-28','','SOURCE MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('77bHcmGg6pCJdL6ioleW1u','Merry & Happy (Repackage)','https://i.scdn.co/image/ab67616d0000b273bb1f3e5c431395124c41bfa7','2017-12-11','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('78FVWchgwlqhNehxTfhUpa','Hare Hare','https://i.scdn.co/image/ab67616d0000b273700684b63d15c3eb91942799','2023-05-31','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('78Ua5HGeR7v22PKfBuvIvH','KPOP Rhythm, Flow & Tone Vol. 1','https://i.scdn.co/image/ab67616d0000b273e50281ac6e7ae2dbec877cde','2018-10-27','','Blue Pie Records USA','','2dd5mrQZvg6SmahdgVKDzh'),('79VvXTQNeLr8KmvcdxN0Pc','SEVENTEEN 8th Mini Album \'Your Choice\'','https://i.scdn.co/image/ab67616d0000b273c1a20972c9a083d5cece9ce5','2021-06-18','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('7a81w6Jk4mMnDC6NL36zao','Abracadabra [THE SEASONS: Red Carpet with Lee Hyo Ri]','https://i.scdn.co/image/ab67616d0000b273e9ed75d4510092498134c002','2024-03-08','','Genie Music Corporation, Stone Music Entertainment','','2AfmfGFbe0A0WsTYm0SDTx'),('7AeJIhR7oTd7l6A1hZNbmS','도깨비불 (Illusion)','https://i.scdn.co/image/ab67616d0000b27366c78ec4b271cc582fef3618','2022-06-01','','Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('7aJuG4TFXa2hmE4z1yxc3n','HIT ME HARD AND SOFT','https://i.scdn.co/image/ab67616d0000b27371d62ea7ea8a5be92d3c1f62','2024-05-17','','Darkroom/Interscope Records','','6qqNVTkY8uBg9cP3Jd7DAH'),('7alG2cEJUQs9KgOTSAP57p','Romantic Winter (EP)','https://i.scdn.co/image/ab67616d0000b273233b7f0debae44c65b6851f4','2009-12-17','','Music Farm','','2dd5mrQZvg6SmahdgVKDzh'),('7B2dOs6eNhgmIWsP3zHKpm','YOUNHA 7th Album \'GROWTH THEORY\'','https://i.scdn.co/image/ab67616d0000b273543dadc1df6cdd9bf47263d1','2024-09-01','','C9 Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('7bZyOScp6ykCOABNLaAVvq','Women\'s version of muscle training BGM -Latest Western music-','https://i.scdn.co/image/ab67616d0000b2731727267163404bd50d4aa779','2024-11-29','','MUSIC LAB JPN','','41MozSoPIsD1dJM0CLPjZF'),('7C8nskYbHG7N0LDrNVvt7x','THE BADDEST','https://i.scdn.co/image/ab67616d0000b2737158ec602fe6e8165cae6091','2020-08-27','','Riot Games','','2AfmfGFbe0A0WsTYm0SDTx'),('7cE0lgNHmBxutHd5g4D3q8','yes, and?','https://i.scdn.co/image/ab67616d0000b273e39fbe1ce1bcd27800bcac10','2024-02-16','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('7cEeYqp2ltesGDkU2niTtL','Psy 3','https://i.scdn.co/image/ab67616d0000b27367b36f7a497b66b3a8380f03','2002-09-25','','야마존뮤직','','2dd5mrQZvg6SmahdgVKDzh'),('7Chuv69qWaXuK5eCmZ8gCi','Six Feet Under (The Remixes)','https://i.scdn.co/image/ab67616d0000b2737b9881aa297e336c0d4d5cef','2017-02-03','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('7dg5iqyFYqRQH7vtAG9VNf','Close To Me (Red Velvet Remix)','https://i.scdn.co/image/ab67616d0000b273e689157967d6f852fc59a746','2019-04-05','','Polydor Records','','1z4g3DjTBBZKhvAroFlhOM'),('7dSaBwUid0hjWdJ5QzIKyu','Jingle Bell Rock','https://i.scdn.co/image/ab67616d0000b2731ca13e5d59a3a25e68fd7764','2023-11-24','','SM Entertainment / Warner Records','','6YVMFz59CuY7ngCxTxjpxE'),('7dXtKHYGXhQZCE2mEg0l93','Genie - The Second Mini Album','https://i.scdn.co/image/ab67616d0000b2739603a9b0bba1eb222c4a6379','2009-06-25','','SM Entertainment','','0Sadg1vgvaPqGTOjxu0N6c'),('7dZYetDaYLHSJii2hrg9my','Mockingbird','https://i.scdn.co/image/ab67616d0000b2731303ee5b2e9a7a294efa35da','2005-04-25','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('7eMHMiz2uvtDDMbvKRJxlP','My Universe (Galantis Remix)','https://i.scdn.co/image/ab67616d0000b2735242045c3d60bcdd7563382f','2021-10-11','','Parlophone UK','','3Nrfpe0tUJi4K4DXYWgMUX'),('7EsVt6j6nJ6U9JRbJD8OlM','DIFFERENT','https://i.scdn.co/image/ab67616d0000b273716895e129f4158bfc893495','2025-06-24','','HYBE JAPAN / UNIVERSAL MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('7F4vy4gN3t6J4Yuavqkhm1','My friend Haechi','https://i.scdn.co/image/ab67616d0000b273c2efaa6b90987f0dc5eb3358','2010-08-09','','SBS Contents Hub Co., Ltd.','','0Sadg1vgvaPqGTOjxu0N6c'),('7FkLRRkLR7eQibcJNij5yZ','M O T O W N','https://i.scdn.co/image/ab67616d0000b273147c96dafdf328c05847e099','2016-03-18','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('7fRrTyKvE4Skh93v97gtcU','dont smile at me','https://i.scdn.co/image/ab67616d0000b273a9f6c04ba168640b48aa5795','2017-12-22','','Darkroom','','6qqNVTkY8uBg9cP3Jd7DAH'),('7gCphTtWHVCXYWfAQShFTQ','Someone you loved','https://i.scdn.co/image/ab67616d0000b273d26d830323b93f02df1ef180','2021-08-13','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('7GGV2EX8kvyOrb31e3qJSB','MAESTRO (Orchestra Remix)','https://i.scdn.co/image/ab67616d0000b2736b75cf4720b7f832369d945e','2024-05-03','','PLEDIS Entertainment','','7nqOGRxlXj7N2JYbgNEjYH'),('7GHiMUbLhh67dWSN1xGUcP','Dancing In The Flames (Live from São Paulo)','https://i.scdn.co/image/ab67616d0000b273fad79f4bab30cd048821e186','2024-09-13','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('7GSCElvTHw10xFfIHdibF1','Pretty Savage (JP Ver.)','https://i.scdn.co/image/ab67616d0000b2736b3f72663aefd9c39dd0dca4','2021-08-03','','Universal Music LLC','','41MozSoPIsD1dJM0CLPjZF'),('7h2OEj0ifXb3UdgvTmCqfY','Relapse','https://i.scdn.co/image/ab67616d0000b27363d5aec8186b37f4404b1d1d','2009-05-15','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('7hbSWdxliNs551GXtflIZB','PSY 9th','https://i.scdn.co/image/ab67616d0000b273763208e225ccbbda004d2176','2022-04-29','','P NATION','','2dd5mrQZvg6SmahdgVKDzh'),('7HOSltauVyXHaVfUDi519q','Live Up To Your Name, Dr. Heo (Original Television Soundtrack), Pt. 5','https://i.scdn.co/image/ab67616d0000b273e8f54bd9ef8ce3a24caac3ce','2017-09-24','','Genie Music Corporation','','7c1HgFDe8ogy5NOZ1ANCJQ'),('7HsVGoN5gwBUKHAj3Cy6Mi','LITTLE BY LITTLE','https://i.scdn.co/image/ab67616d0000b2731154386618823ea8a4c3eca3','2016-05-09','','파이니스트 레코즈','','7c1HgFDe8ogy5NOZ1ANCJQ'),('7hV6jCNOCQP17ZKFywnf3h','Grown Ass Kid','https://i.scdn.co/image/ab67616d0000b2732d286fd4e6a739a5e0a15bbb','2022-07-27','','KOZ Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('7iBQu0rheWrxa2ULvHmJNk','Good Day 2025 (Telepathy + By the Moonlight Window)','https://i.scdn.co/image/ab67616d0000b27372c6dacbc5d13fe29cc2a23c','2025-04-24','','Sony Music Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('7IjtsGMc2cVfMojvM39Vke','Besten Hits 2020','https://i.scdn.co/image/ab67616d0000b273f2c61f9e77447bf6969e96bb','2020-10-08','','UME - Global Clearing House','','41MozSoPIsD1dJM0CLPjZF'),('7ikmjsvRzDRzxHN0KXSQdv','As If It\'s Your Last','https://i.scdn.co/image/ab67616d0000b273ac93d8b1bd84fa6b5291ba21','2017-06-22','','YG Entertainment','','41MozSoPIsD1dJM0CLPjZF'),('7irmI5g3OLC1gUXlxysOWt','Anti-Hero (Remixes)','https://i.scdn.co/image/ab67616d0000b2739954fa9f0ba8534c3897b59d','2022-11-11','','Taylor Swift','','06HL4z0CvFAxyc27GXpf02'),('7ItNskxl1pUXIHobJRkNj6','Hits Virais','https://i.scdn.co/image/ab67616d0000b273a8cbe79bd6bff804d56d104e','2020-09-25','','UME - Global Clearing House','','41MozSoPIsD1dJM0CLPjZF'),('7j15eBY8Ay1bSjB2GgBVxm','Ta-Ta For Now (The Last 10 Years X Car, the garden)','https://i.scdn.co/image/ab67616d0000b27375e7ccb37c732075687b39da','2024-05-29','','TOON STUDIO','','7c1HgFDe8ogy5NOZ1ANCJQ'),('7J4ASJD3IvdANlrPkmeVP0','BLACKPINK 2019-2020 WORLD TOUR IN YOUR AREA -TOKYO DOME- (Live)','https://i.scdn.co/image/ab67616d0000b27323c5b62995e1610ef9f7c137','2020-05-14','','Universal Music LLC','','41MozSoPIsD1dJM0CLPjZF'),('7jwMcRjCdGwYZadiHeu9vO','Swoosh Flow (Remix)','https://i.scdn.co/image/ab67616d0000b273bd4a8c952a8204d2a74b28a0','2020-08-03','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('7k9LE0MqQFCmDKE1upWF3D','Star Signs','https://i.scdn.co/image/ab67616d0000b2738d80edffa860cb0134bbf688','2024-11-13','','HYBE JAPAN / UNIVERSAL MUSIC','','4SpbR6yFEvexJuaBpgAU5p'),('7KnpAprx7DBlh6WWTsm3Jp','Taste of Love','https://i.scdn.co/image/ab67616d0000b2731efd922f648471a2dfe59e5d','2021-06-11','','JYP Entertainment','','7n2Ycct7Beij7Dj7meI4X0'),('7KYpVsgw7yqbfmGBp9gYiR','MEGAN: ACT II','https://i.scdn.co/image/ab67616d0000b2734e3330398bd99c2fc3b21ffe','2024-10-25','','Hot Girl Productions','','7n2Ycct7Beij7Dj7meI4X0'),('7Ls2OqCIyHG87kdU5qhspV','더 팬 2ROUND Part.1','https://i.scdn.co/image/ab67616d0000b273f3ad4f897dd9ad079e133702','2018-12-15','','Kakao Entertainment','','7c1HgFDe8ogy5NOZ1ANCJQ'),('7LsTjhsTKJA0Rfwwx1ppXs','It Was A… (Masked Christmas)','https://i.scdn.co/image/ab67616d0000b273a3ddc603dcab9bb83161a763','2021-12-07','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('7LvbY0nXDKaLh67P2AXV0B','2step (feat. reezy)','https://i.scdn.co/image/ab67616d0000b2732a06580788f98e1950b09160','2022-05-18','','Atlantic Records UK','','6eUKZXaKkcviH0Ku9w2n3V'),('7LwmZZ8UeExJ4YfS0xtE3Q','Nxde (Steve Aoki Remix)','https://i.scdn.co/image/ab67616d0000b27347263d33238cf0483f27f818','2022-12-16','','CUBE ENTERTAINMENT','','2AfmfGFbe0A0WsTYm0SDTx'),('7lz1c3m9EuF29Du1jSL93y','The Tale Of Nokdu (Original Television Soundtrack), Pt. 2','https://i.scdn.co/image/ab67616d0000b2737a4cb8790acc5ff9b3ed7142','2019-10-08','','모스트콘텐츠','','6GwM5CHqhWXzG3l5kzRSAS'),('7mEr8CMSfMdgol0iYFImRp','FILA Limited Edition with BIGBANG','https://i.scdn.co/image/ab67616d0000b273633a850b72b3d07a7a8c422e','2008-12-30','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX'),('7mnavCnzTvMaIojWSpjGA7','You Raise Me Up (from \'THE FAN 3ROUND Pt.1\')','https://i.scdn.co/image/ab67616d0000b2733b32e8a4dc49b6b5d18a22be','2018-12-19','','DOOROODOOROO ARTIST COMPANY','','7c1HgFDe8ogy5NOZ1ANCJQ'),('7mP7AFehQDonPKEQiXvpvB','Love&Letter repackage album','https://i.scdn.co/image/ab67616d0000b273eb366517758754ca13a4adf5','2016-07-04','','PLEDIS ENTERTAINMENT','','7nqOGRxlXj7N2JYbgNEjYH'),('7mpWlMAMdCErqVquIUHsiN','Supernova','https://i.scdn.co/image/ab67616d0000b273115d1e2cfde4e387f0a13ce2','2024-05-13','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('7MTpKyUYyNH7yiOYCZU5Op','逆燃 Warrior (JOSHUA, 文俊辉, 徐明浩, MINGYU, VERNON from SEVENTEEN)','https://i.scdn.co/image/ab67616d0000b2736460690bc4f4a71ab0479da0','2021-07-30','','NSMG','','7nqOGRxlXj7N2JYbgNEjYH'),('7mtRex3XcxOcJJ9niODj7Q','Love Yourself','https://i.scdn.co/image/ab67616d0000b273607dd5850c9dc98f4e6aa6d3','2023-06-16','','UME - Global Clearing House','','6qqNVTkY8uBg9cP3Jd7DAH'),('7mzdXVXYiXgZEuj3zMspDs','17 (feat. Joshua and DK of SEVENTEEN)','https://i.scdn.co/image/ab67616d0000b273ccea782613ea39e2903fe8a8','2020-09-17','','Atlantic Records','','7nqOGRxlXj7N2JYbgNEjYH'),('7MZzYkbHL9Tk3O6WeD4Z0Z','Relapse: Refill','https://i.scdn.co/image/ab67616d0000b273506c4cc93e5a6234164125e1','2009-05-15','','Aftermath','','7dGJo4pcD2V6oG8kP0tJRR'),('7nzPuFSw98m1si3pqARggs','YOUNHA 6th Album \'END THEORY\'','https://i.scdn.co/image/ab67616d0000b2739917b7a6f06d0d2df5a4bc50','2021-11-16','','C9 Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('7p4wFXK0EElkclYbmhY45N','Lazy Love','https://i.scdn.co/image/ab67616d0000b273af1f94040e9e8d448030cd96','2018-05-14','','KQ Entertainment','','6GwM5CHqhWXzG3l5kzRSAS'),('7qa8B5WKxdG7ITbyduBkN1','Songstealer - Sixth Sense','https://i.scdn.co/image/ab67616d0000b273121f44ef1d9c881a30b949fa','2024-05-25','','Genie Music Corporation, Stone Music Entertainment','','4TEK9tIkcoxib4GxT3O4ky'),('7rNIvLwIpB2mwOzk20iqIl','RBB - The 5th Mini Album','https://i.scdn.co/image/ab67616d0000b2732270d3bd1d13133edf0be836','2018-11-30','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('7saicsozAZSsKEVQh4WAig','eternal sunshine deluxe: brighter days ahead (instrumental version)','https://i.scdn.co/image/ab67616d0000b2736c9d796f3d1a060de02a3077','2025-03-27','','Republic Records','','66CXWjxzNUsdJxJ2JdwvnR'),('7tbmvcs2vAe7mijL8Pfven','2025 SMTOWN : THE CULTURE, THE FUTURE','https://i.scdn.co/image/ab67616d0000b2731de0ae8daba390a3cd627c55','2025-02-14','','SM Entertainment','','6YVMFz59CuY7ngCxTxjpxE'),('7tOUgcKglzk78d8hOIMWyr','UNHEALTHY (Deluxe)','https://i.scdn.co/image/ab67616d0000b273c251fe563280736ad5bface9','2023-07-28','','Atlantic Records UK','','2AfmfGFbe0A0WsTYm0SDTx'),('7tY3mqjeJaMr6RFJYnjI2s','UNSTABLE MINDSET','https://i.scdn.co/image/ab67616d0000b2734b89d54636763c641bce87e5','2020-01-06','','C9 ENTERTAINMENT','','6GwM5CHqhWXzG3l5kzRSAS'),('7tzVd1fwkxsorytCBjEJkU','The Idol Episode 4 (Music from the HBO Original Series)','https://i.scdn.co/image/ab67616d0000b273b0dd6a5cd1dec96c4119c262','2023-06-23','','XO / Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('7uaI73cqw8YC2ViewZAai5','The Planet','https://i.scdn.co/image/ab67616d0000b273fa552453b3762dc1dba6729f','2023-05-12','','BIGHIT MUSIC','','3Nrfpe0tUJi4K4DXYWgMUX'),('7uCTBsGC6JHlwmmrOCIUBw','iScreaM Vol.11 : Queendom Remix','https://i.scdn.co/image/ab67616d0000b273084833739074e548da317e37','2021-10-15','','SM Entertainment','','1z4g3DjTBBZKhvAroFlhOM'),('7vAZjssOcIuksA5DxN5sM1','Rain On Me (Ralphi Rosario Remix)','https://i.scdn.co/image/ab67616d0000b273efaa0894111ccf3e719f33ca','2020-07-17','','Interscope Records','','66CXWjxzNUsdJxJ2JdwvnR'),('7vyywKqNuOsQ0UveBQPhRn','ZOOM','https://i.scdn.co/image/ab67616d0000b273a0ef670d676b46701460baca','2024-10-30','','Bullmoose Records','','3hvinNZRzTLoREmqFiKr1b'),('7ybEq8ZLOtsH2VwdIrjNri','Boyhood','https://i.scdn.co/image/ab67616d0000b273e0891e322bc2773b1e4389c2','2019-11-29','','Genie Music Corporation, Stone Music Entertainment','','3hvinNZRzTLoREmqFiKr1b'),('7zCODUHkfuRxsUjtuzNqbd','House Of Balloons (Original)','https://i.scdn.co/image/ab67616d0000b273274b406a7e18acebcf743079','2011-03-21','','Universal Republic Records','','1Xyo4u8uXC1ZmMpatF05PJ'),('7zMnk5J530VJtHU93Dw03x','D','https://i.scdn.co/image/ab67616d0000b2732625c07fd25fa9e4c9b0a1a5','2015-07-01','','YG Entertainment','','4Kxlr1PRlDKEB0ekOCyHgX');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;

--
-- Table structure for table `album_mood_vote`
--

DROP TABLE IF EXISTS `album_mood_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_mood_vote` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `album_id` varchar(200) NOT NULL,
  `mood` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_album_mood_vote_1` (`user_id`),
  KEY `FK_album_TO_album_mood_vote_1` (`album_id`),
  KEY `FK_tag_TO_album_mood_vote_1` (`mood`),
  CONSTRAINT `FK_album_TO_album_mood_vote_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
  CONSTRAINT `FK_tag_TO_album_mood_vote_1` FOREIGN KEY (`mood`) REFERENCES `tag` (`id`),
  CONSTRAINT `FK_user_TO_album_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_mood_vote`
--

/*!40000 ALTER TABLE `album_mood_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `album_mood_vote` ENABLE KEYS */;

--
-- Table structure for table `album_review`
--

DROP TABLE IF EXISTS `album_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rating` float NOT NULL,
  `content` text NOT NULL,
  `blinded` tinyint(1) NOT NULL,
  `likes` int NOT NULL DEFAULT '0',
  `dislikes` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `critic` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  `album_id` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_album_review_1` (`user_id`),
  KEY `FK_album_TO_album_review_1` (`album_id`),
  CONSTRAINT `FK_album_TO_album_review_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
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
INSERT INTO `artist` VALUES ('06HL4z0CvFAxyc27GXpf02','Taylor Swift','https://i.scdn.co/image/ab6761610000e5ebe672b5f553298dcdccb0e676',''),('0Sadg1vgvaPqGTOjxu0N6c','Girls\' Generation','https://i.scdn.co/image/ab6761610000e5eb385df356841aaec34a0914aa','k-pop'),('1Xyo4u8uXC1ZmMpatF05PJ','The Weeknd','https://i.scdn.co/image/ab6761610000e5eb9e528993a2820267b97f6aae',''),('1z4g3DjTBBZKhvAroFlhOM','Red Velvet','https://i.scdn.co/image/ab6761610000e5eb02a562ea6b1dc718394010ac','k-pop'),('2AfmfGFbe0A0WsTYm0SDTx','i-dle','https://i.scdn.co/image/ab6761610000e5eb732a090e736faef27779d24e','k-pop'),('2dd5mrQZvg6SmahdgVKDzh','PSY','https://i.scdn.co/image/ab6761610000e5eb24b5185226d5b7c6aa91db5a','k-pop'),('3hvinNZRzTLoREmqFiKr1b','CHANGMO','https://i.scdn.co/image/ab6761610000e5eb53b0804552178db3b27d8a6b','k-rap'),('3Nrfpe0tUJi4K4DXYWgMUX','BTS','https://i.scdn.co/image/ab6761610000e5ebd642648235ebf3460d2d1f6a','k-pop'),('41MozSoPIsD1dJM0CLPjZF','BLACKPINK','https://i.scdn.co/image/ab6761610000e5eb667b1c37aac06716daa5fe92','k-pop'),('4Kxlr1PRlDKEB0ekOCyHgX','BIGBANG','https://i.scdn.co/image/ab6761610000e5eb597a4257d0022e2ac837fa7d','k-pop'),('4SpbR6yFEvexJuaBpgAU5p','LE SSERAFIM','https://i.scdn.co/image/ab6761610000e5eb593f35db6f6837e1047a5e33','k-pop'),('4TEK9tIkcoxib4GxT3O4ky','KISS OF LIFE','https://i.scdn.co/image/ab6761610000e5eb5227c0582a86838a0942d9f3','k-pop'),('66CXWjxzNUsdJxJ2JdwvnR','Ariana Grande','https://i.scdn.co/image/ab6761610000e5eb6725802588d7dc1aba076ca5','pop'),('6eUKZXaKkcviH0Ku9w2n3V','Ed Sheeran','https://i.scdn.co/image/ab6761610000e5eb399444ed4eace08b549d1161','soft pop'),('6GwM5CHqhWXzG3l5kzRSAS','Younha','https://i.scdn.co/image/ab6761610000e5ebf5e315e40a6d4ffd36c10d94','k-ballad'),('6qqNVTkY8uBg9cP3Jd7DAH','Billie Eilish','https://i.scdn.co/image/ab6761610000e5eb4a21b4760d2ecb7b0dcdc8da',''),('6RHTUrRF63xao58xh9FXYJ','IVE','https://i.scdn.co/image/ab6761610000e5eb538dad5b42d963e338726c26','k-pop'),('6YVMFz59CuY7ngCxTxjpxE','aespa','https://i.scdn.co/image/ab6761610000e5eb927f1260251e32135287e032','k-pop'),('7c1HgFDe8ogy5NOZ1ANCJQ','Car, the garden','https://i.scdn.co/image/ab6761610000e5eb60207000aebdb42a66f6880e','k-ballad'),('7dGJo4pcD2V6oG8kP0tJRR','Eminem','https://i.scdn.co/image/ab6761610000e5eba00b11c129b27a88fc72f36b','rap, hip hop'),('7n2Ycct7Beij7Dj7meI4X0','TWICE','https://i.scdn.co/image/ab6761610000e5ebfcef64d7657da13955bbdb7f','k-pop'),('7nqOGRxlXj7N2JYbgNEjYH','SEVENTEEN','https://i.scdn.co/image/ab6761610000e5eb8da3a229445fd3cd896cdd5c','k-pop');
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
  `artist_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_artist_follow_1` (`user_id`),
  KEY `FK_artist_TO_artist_follow_1` (`artist_id`),
  CONSTRAINT `FK_artist_TO_artist_follow_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`),
  CONSTRAINT `FK_user_TO_artist_follow_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_follow`
--

/*!40000 ALTER TABLE `artist_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `artist_follow` ENABLE KEYS */;

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
  PRIMARY KEY (`id`),
  KEY `FK_album_TO_chart_element_1` (`album_id`),
  CONSTRAINT `FK_album_TO_chart_element_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`)
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
  KEY `FK_user_TO_liked_album_1` (`user_id`),
  KEY `FK_album_TO_liked_album_1` (`album_id`),
  CONSTRAINT `FK_album_TO_liked_album_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
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
  KEY `FK_user_TO_liked_playlist_1` (`user_id`),
  KEY `FK_playlist_TO_liked_playlist_1` (`playlist_id`),
  CONSTRAINT `FK_playlist_TO_liked_playlist_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`),
  CONSTRAINT `FK_user_TO_liked_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liked_playlist`
--

/*!40000 ALTER TABLE `liked_playlist` DISABLE KEYS */;
INSERT INTO `liked_playlist` VALUES (1,'2025-07-04 18:51:11',2,1),(2,'2025-07-06 18:51:11',2,2),(3,'2025-07-03 18:51:11',2,4);
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
  KEY `FK_user_TO_liked_track_1` (`user_id`),
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
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
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
  `type` enum('comment','mention','like','follow','reply','badge','qna','announcement','system') NOT NULL,
  `message` text NOT NULL,
  `content` text,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `target_id` bigint NOT NULL,
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
INSERT INTO `persistent_logins` VALUES ('user1004','EpkX6gybXnamcOTUCk4vow==','jvi0qOVk0CG/GkMypDoYvw==','2025-07-06 13:34:09');
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
  `thumbnail_url` varchar(200) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `track_id` varchar(200) DEFAULT NULL,
  `like_count` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_playlist_1` (`user_id`),
  CONSTRAINT `FK_user_TO_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
INSERT INTO `playlist` VALUES (1,1,'user1004 의 플레이리스트','안녕하세요','abc',1,'2025-07-06 09:51:11',NULL,0),(2,1,'user1004 의 플레이리스트','안녕하세요2','abc',1,'2025-07-06 09:52:12',NULL,0),(3,1,'user1004 의 플레이리스트','안녕하세요3','abc',1,'2025-07-06 09:52:18',NULL,0),(4,1,'user1004 의 플레이리스트','안녕하세요4','abc',1,'2025-07-06 12:46:17',NULL,0);
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
  `Field` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_track_TO_playlist_detail_1` (`track_id`),
  KEY `FK_playlist_TO_playlist_detail_1` (`playlist_id`),
  CONSTRAINT `FK_playlist_TO_playlist_detail_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`),
  CONSTRAINT `FK_track_TO_playlist_detail_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`)
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
  `reason` text NOT NULL,
  `status` varchar(10) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reporter_id` bigint NOT NULL,
  `target_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_report_1` (`reporter_id`),
  KEY `FK_user_TO_report_2` (`target_id`),
  CONSTRAINT `FK_user_TO_report_1` FOREIGN KEY (`reporter_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_user_TO_report_2` FOREIGN KEY (`target_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;

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
  `value` varchar(100) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
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
  `title` varchar(100) NOT NULL,
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
  CONSTRAINT `FK_album_TO_track_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
  CONSTRAINT `FK_artist_TO_track_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track`
--

/*!40000 ALTER TABLE `track` DISABLE KEYS */;
INSERT INTO `track` VALUES ('00aqkszH1FdUiJJWvX6iEl','Wicked Games',325,'','None','','7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',75,5),('00Blm7zeNqgYLPtW6zg8cj','One Right Now (with The Weeknd)',193,'','None','','6fgSKdHloRioPrZ9oJC7FH','1Xyo4u8uXC1ZmMpatF05PJ',71,1),('00NAQYOP4AmWR549nnYJZu','Secrets',265,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',68,6),('010ZkIVv6Ay5vqqHVCCiKB','Fill The Void (with Lily Rose Depp, Ramsey)',185,'','None','','7tzVd1fwkxsorytCBjEJkU','1Xyo4u8uXC1ZmMpatF05PJ',75,3),('02w1rM6spvEcbFxd63xCl2','Less Than Zero',211,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',58,15),('02YlAvsmptN8LisZqrWBIb','Take My Breath - Live',235,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,7),('03H6iCycyxfB2mZzIOEeKJ','Crew Love - Live',113,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,11),('03j354P848KtNU2FVSwkDG','Real Life',223,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',61,1),('09mBPwUMt1TXNtneqvmZZ5','Ordinary Life',221,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',48,14),('09mEdoA6zrmBPgTEN5qXmN','Call Out My Name',228,'','None','','4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',87,1),('0awWj9Wzj375IL5etqa1Dk','Die For You',260,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',52,17),('0bcZ7xN9IcjSNxLerzR2yl','I Can\'t Wait To Get There',188,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',73,12),('0DvtQkuaV0VrSHgb5pwRke','Phantom Regret by Jim',179,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',42,16),('0ei3uNcwJOiUocuks1vWcb','Pretty',375,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',57,9),('0FIDCNYYjNvPVimz5icugS','Timeless (feat Playboi Carti)',256,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',95,13),('0FolPJnYMo71Z7qasTuoJT','Given Up On Me',354,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',73,11),('0GROiXm03OrMC5ltXLhGIu','The Party & The After Party',459,'','None','','7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',80,6),('0HHKGXT6NQ83tUbVI31O1H','Wake Me Up (feat. Justice) - Single Version',210,'','None','','0cLXqY56lwJjG7QNG2mzu7','1Xyo4u8uXC1ZmMpatF05PJ',50,1),('0HhSydjvwLiBjnVQCG5SjK','Heartless',198,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',61,7),('0Hs5enNuaAXmJssAybWbOw','XO / The Host',444,'','None','','04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',60,4),('0ifooM33X1iBxVYyOkSbXW','A Lonely Night',220,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',66,12),('0ijIG2j6oRSMDk5Zp91xXt','Less Than Zero - Live',244,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',46,29),('0JGoOLSl8A80mSPBL7ya9U','The Fall',345,'','None','','04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',53,7),('0K3w6WNawZlv6Izmsrye8o','Give Me Mercy',216,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',69,17),('0kHlKWunEQ5zoQmKHNJT6P','K-POP - Chopped & Screwed',273,'','None','','0jiAYLsE1PumLJncO7vUIl','1Xyo4u8uXC1ZmMpatF05PJ',30,2),('0khQeEwEv6GndVypzpGOG5','Here We Go… Again (feat. Tyler, the Creator)',209,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',47,8),('0kXHpsg9SmpRqsQ4wQvQsK','Till Dawn (Here Comes The Sun)',319,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',58,10),('0l1p13Fbujayv894H0hfpS','Thursday',320,'','None','','6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',57,3),('0lUWGCpXozLqApCdup94Tu','Die For You',260,'','None','','0YF085Qdh4HgdhZ8zjWkpo','1Xyo4u8uXC1ZmMpatF05PJ',40,2),('0mL82sxCRjrs3br407IdJh','Is There Someone Else?',199,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',84,10),('0naqCl6Bckx9qO6gtyoXLm','Wicked Games - Live',143,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,25),('0Nwar8rweBUyfyuoyjjUvk','Privilege',170,'','None','','4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',66,6),('0NWqNXBJTpXbkI5rPWNy3p','All I Know',321,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',64,16),('0OajXvsbkfhx5CTn4gsAdB','The Lure (Main Theme) (with Mike Dean)',277,'','None','','6E3IPXh38G7UHLqVdfIY5h','1Xyo4u8uXC1ZmMpatF05PJ',49,1),('0QE33jkiMTzCI8momkDmQY','Sacrifice (Remix) (feat. Swedish House Mafia)',238,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',47,20),('0sf62tS5AFYKV32QtcykFa','Moth To A Flame (with The Weeknd) - Extended Mix',298,'','None','','0sye9Q82C9Q4tTJN8b0aFq','1Xyo4u8uXC1ZmMpatF05PJ',36,4),('0sTBOp1hdayTjw6UOyPyi6','Open Hearts',234,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',79,7),('0UGdO687azruy9tFlCxO6F','Montreal',250,'','None','','04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',62,2),('0VjIjW4GlUZAMYd2vXMi3b','Blinding Lights',200,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',92,9),('0vuiKizDyUXdIge9npkEKn','Double Fantasy (with Future) - Radio Edit',235,'','None','','0Ct52rooGyvjv6qXrBPNzm','1Xyo4u8uXC1ZmMpatF05PJ',51,2),('0WdJTI3UVvUMbLwPk5ObKI','D.D.',274,'','None','','04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',58,1),('0WrIAsGJOei2FGeakvpTDU','Heartless - Live',124,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,13),('0wzPHTgOtFIDhk2rD3Au4x','Angel',377,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',64,14),('0xa4hvXeYHRRNhA7wBfUar','Sacrifice',188,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',58,5),('0yi180gAOIJhcRo7wY4Htl','I Feel It Coming (feat. Daft Punk)',269,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',55,18),('0ymDgXNt5qdPZmeSpAf3P0','Dawn FM - OPN Remix',184,'','None','','0Vz32hcNoqOZIpJVI0qExN','1Xyo4u8uXC1ZmMpatF05PJ',34,1),('10OyIs6KCOmDO19J5wWFPx','Call Out My Name - Live',242,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',53,26),('14OYmvxPRx8lABHthDN4AX','Get It B4',262,'','None','','5aX2plzPm0m6zk4ZFuqbuI','1Xyo4u8uXC1ZmMpatF05PJ',43,3),('14p9UeyB3zxuo62wRjk5iR','Wanderlust',305,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',45,11),('15k2nBQJ0teDmPZHrOXL2N','Ordinary Life',221,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',64,14),('167wD7BlzcLxsX8PlSujCa','Dancing In The Flames - Acapella',203,'','None','','0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',35,5),('16FRIbCsgA60AiJpTh2wYX','Creepin\' - Instrumental',221,'','None','','3P2UkOkqWp8ucd1EOnVAH7','1Xyo4u8uXC1ZmMpatF05PJ',29,3),('1bAvtmTl0F9loyz9AwPwp7','Losers',281,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',61,2),('1CatlSR0Kh0hsvGF2Z8l3s','Family (with Suzanna Son)',183,'','None','','5bx7i3cuSfXBPF7Li8kUR7','1Xyo4u8uXC1ZmMpatF05PJ',53,1),('1cKHdTo9u0ZymJdPGSh6nq','I Was Never There',241,'','None','','4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',86,4),('1DQGIcihPgi4kDCdx1fEn0','How Do I Make You Love Me? - Sebastian Ingrosso & Salvatore Ganacci Remix',217,'','None','','181WKxuhHzTyjMcYdI7UUe','1Xyo4u8uXC1ZmMpatF05PJ',42,1),('1E5Xu8dur0fAjSP1VpVhAZ','Best Friends',163,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',65,9),('1G73gINM14qd8cE3Lf8V1z','Dancing In The Flames - Live from São Paulo',312,'','None','','0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',38,3),('1gZADNt16Oh23jWyMYRk4p','Prisoner',274,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',68,13),('1h345CZmt3uU9bym4GETWd','Dancing In The Flames - Instrumental',221,'','None','','0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',36,4),('1Hp7vdJwQ4ozmAJzPAJpfX','Snowchild',247,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',48,5),('1JVDTuD60L2oSz9D6TlQiq','D.D.',274,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',52,1),('1Jz0fAhw41suiAVekjAoLi','Dawn FM - OPN Remix',183,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',43,18),('1L8ObNUDCh7k6GwDIbfx9Q','Popular (with Playboi Carti & Madonna)',215,'','None','','0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',60,1),('1mhVXWduD8ReDwusfaHNwU','Tell Your Friends',334,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',69,3),('1nH2PkJL1XoUq8oE6tBZoU','Sacrifice',188,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',73,5),('1NhjYYcYTRywc0di98xHxf','Here We Go… Again (feat. Tyler, the Creator)',209,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',64,8),('1NlK2NtpuUazpziLhnJwEV','Phantom Regret by Jim',179,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',55,16),('1occCbgg7oAWF7lMCEAk2T','I Was Never There - Live',137,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',48,24),('1oCyEPXnvytOWS5S9mBE8N','Alone Again',250,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',51,1),('1oGdVdYjeQvojGKDddxLQQ','True Colors',206,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',64,7),('1RlcvK95g0XfRpDvFbGLUO','K-POP',185,'','None','','0jiAYLsE1PumLJncO7vUIl','1Xyo4u8uXC1ZmMpatF05PJ',41,1),('1S9DHKpS73KFVN7nnIql3f','Moth To A Flame (with The Weeknd)',234,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',56,17),('1sOW4PuG5X3Ie3EXUhAopJ','Escape From LA',355,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',68,6),('1tcWDBYQbJZVixZzsBWB0P','Die For You - Instrumental',259,'','None','','0YF085Qdh4HgdhZ8zjWkpo','1Xyo4u8uXC1ZmMpatF05PJ',37,3),('1Tr5FhvxC4IlRXYJHCXJdZ','Creepin\'',221,'','None','','3P2UkOkqWp8ucd1EOnVAH7','1Xyo4u8uXC1ZmMpatF05PJ',52,2),('1um00PH48BzDbULgyQyRUA','Is There Someone Else? - Live',237,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',48,23),('2022B8GxEstpvibwgbJ15s','Starry Eyes',148,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',48,11),('22VdIZQfgXJea34mQxlt81','Can\'t Feel My Face',213,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',85,7),('23FnV9ThaK01oNWc3E87yh','Take My Breath - Extended Version',351,'','None','','4lBrDelXR6Sn0k54a7UWMz','1Xyo4u8uXC1ZmMpatF05PJ',42,3),('23iLEDPEJpcfYOw1tVhd2o','A Tale By Quincy',96,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',44,6),('25C86uEjQ0fjj3bvsxIusO','Out of Time',214,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',54,7),('25KybV9BOUlvcnv7nN3Pyo','In The Night',235,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',75,10),('27BgDmciSjoxTG0almHTpZ','Love To Lay',223,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',62,11),('28vy7I63Gtqw90rvgxw8sU','Die For You - Sped Up',223,'','None','','0YF085Qdh4HgdhZ8zjWkpo','1Xyo4u8uXC1ZmMpatF05PJ',45,4),('29lXN1aoaL6HE72BOvknyr','Dancing In The Flames',220,'','None','','0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',58,1),('2BcnxwxBuar5wjCaLqm5N3','Until I Bleed Out',190,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',64,14),('2BTkcHMf8j5pqa5UIMFGcy','Until I Bleed Out',192,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',49,14),('2cA9RA2kuwsR7OBQ2LIEIe','Montreal',250,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',52,2),('2Ch7LmS7r2Gy2kc64wv3Bz','Die For You',260,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',83,17),('2D4dV2KXDTszzJ3p3cFqhA','Less Than Zero',211,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',76,15),('2DsrtZoRxeHdCSGRlQVQtj','Attention',197,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',46,13),('2evYKtXNAdn60ANNEdjH7V','Alone Again - Live',167,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,2),('2fTe41iso7GyCLuRu3UmJh','Popular (Slowed) (with Playboi Carti & Madonna)',258,'','None','','0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',48,3),('2Ghp894n1laIf2w98VeAOJ','How Do I Make You Love Me?',214,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',69,3),('2gyHr9WqZeMtzJOpWGuGo6','Reflections Laughing (feat. Travis Scott, Florence + The Machine)',291,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',76,9),('2h3ZotklPN6aD7OuHz7bFZ','Gasoline - Live',195,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,3),('2K9Ovn1o2bTGqbsABGC6m3','Too Late',239,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',68,2),('2kvzSGkSaU9z3uywQIrhAg','K-POP - Instrumental',185,'','None','','0jiAYLsE1PumLJncO7vUIl','1Xyo4u8uXC1ZmMpatF05PJ',36,3),('2laEnnWXQmXSXaoD3ak5Ve','Same Old Song',312,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',50,6),('2p8IUWQDrpjuFltbdgLOag','After Hours',361,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',84,13),('2pGp7wk76ZfbxYG5MRwfcs','Save Your Tears',215,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',57,11),('2PipF4mcI9d6cqq5AAp7GU','Save Your Tears (Remix) (with Ariana Grande) - Bonus Track',191,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',51,18),('2QRvliBEcGIEgTrjVfxmXo','True Colors',206,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',47,7),('2r7BPog74oaTG5shNYiUnV','House Of Balloons / Glass Table Girls',407,'','None','','7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',81,3),('2rlEZYWZFE84YTbrwypBr0','Reminder (feat. A$AP Rocky & Young Thug) - Remix',221,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',54,21),('2SLwbpExuoBDZBpjfefCtV','Out of Time',214,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',79,7),('2urqWNGpjl07PLAafoa5nT','How Do I Make You Love Me? - Sebastian Ingrosso & Salvatore Ganacci Remix',217,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',49,19),('2v0AG62ZHtD3I4YmTb3WYM','Niagara Falls',277,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',76,14),('2vgUijXOTRMnWXDtvgMp2b','Take My Breath',339,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',73,4),('2wRVEpcB2lgsyWbejp8vMt','Next',361,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',49,8),('2WxcXtp6kuC7biYBxBbeeG','Double Fantasy (with Future)',268,'','None','','5bx7i3cuSfXBPF7Li8kUR7','1Xyo4u8uXC1ZmMpatF05PJ',50,3),('2yBz1hupoOBncorzuKcJ2z','Loft Music',363,'','None','','7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',63,8),('2ye9iWj5V4g6k6HFeTTAKa','High For This',249,'','None','','7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',70,1),('2YI8oiiImLkZvVgP33xrjD','Kiss Land - Live',110,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',46,16),('2yYDijitHN6psA2tH0ndXs','The Birds Pt. 2',350,'','None','','6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',62,6),('32HKm4gUeUqQ8SQ28uGYUo','After Hours',361,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',62,13),('34nSJrquH2c8LNbfnRffMF','Dancing In The Flames - Acoustic',208,'','None','','0MwPArEeQJx5GMc5Sz7kRV','1Xyo4u8uXC1ZmMpatF05PJ',52,2),('36K5mnqwfxGS0rvxz7FPyq','Secrets',265,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',49,6),('36LdTnEWBDLDDA3hEsSLvi','High For This',249,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',56,1),('36YCdzT57us0LhDmCYtrNE','Rockin’',232,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',66,5),('37F0uwRSrdzkBiuj0D5UHI','Reminder',218,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',85,4),('37zcCimcUGurQoLEAuN8nR','Is There Someone Else?',199,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',55,10),('37zSTGaP8bfBDGpJnUmSDl','Same Old Song',312,'','None','','04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',56,6),('3AWDeHLc88XogCaCnZQLVI','Cry For Me',224,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',87,2),('3bWm8ejTzkMhPSdBnpxLvl','One Of The Girls - Slowed',305,'','None','','4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',57,3),('3CktmDvZGj21m3pNFj5Lr3','Stargirl Interlude (feat. Lana Del Rey)',111,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',55,8),('3D7izPzeEcz7lBhcCZJccl','Belong To The World',307,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',54,5),('3DBumrwaikaisVDQdcM7jU','Life Of The Party',296,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',54,2),('3DCc4HPrVukBeaDGe3Cosk','Starboy (feat. Daft Punk) - Kygo Remix',244,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',56,20),('3dhjNA0jGA8vHBQ1VdD6vV','I Feel It Coming',269,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',80,18),('3dQEShIMs5TW8H3eUh11r7','Twenty Eight',258,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',63,10),('3FvDYk5IC5Um84kK5FbJGR','Adaptation',283,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',48,3),('3gj1hwjku4JaoamjJVqIIl','Dawn FM',96,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',44,1),('3H3qBumaYj67PT3aMEBvAP','As You Are',340,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',68,11),('3iPmwJh56xbDF7Xduimf0d','Nothing Without You',198,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',45,15),('3JvdrCezbM6DQOjNiBiX5q','Die For It (ft. Nas)',199,'','None','','5vgkX6abffhom2ejVI11yq','1Xyo4u8uXC1ZmMpatF05PJ',46,1),('3kdEGx81MR9ftxRbF3Zf84','Often - Live',148,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',50,10),('3kgqHVqfiabABjaFi9Tnhn','Live For',222,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',55,6),('3kOtREqmcGaEA2KhqffFnw','How Do I Make You Love Me?',214,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',58,3),('3KyKxJ4P3pVCgaZwaq2rUC','Gasoline',212,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',71,2),('3lcEVP5beEkAFiFIG5D0QF','The Town',307,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',50,2),('3mHO1J6kfiArjBo1zhLFGP','Coming Down',295,'','None','','7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',81,7),('3mynPhglTz2Ggh8SxA34kR','Rockin’',232,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',48,5),('3nUHfbfj1cpnn8ZjS4tNDW','Take My Breath - Single Version',220,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',43,24),('3orEOtd8CPL8GFlpRpKuoE','Faith',283,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',71,8),('3QWENKFYGEgp3itgTnrgq9','Initiation',260,'','None','','04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',54,5),('3r5lHFACTti0w2REN5tcrn','Sidewalks (feat. Kendrick Lamar)',231,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',49,9),('3RSmW13mK3HbkeuHSA4o4E','I Feel It Coming - Live',234,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',46,21),('3TBFOYhRrY2lL4lcmtvIrU','My Sweet Lord',192,'','None','','10SppFk45za4CHPEiiuQaD','1Xyo4u8uXC1ZmMpatF05PJ',48,2),('3TVnaEVbUBFmWYk9IOIwRo','Don’t Break My Heart',205,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',47,13),('3Tz5B0wTyLdz4jE8LgYA3J','The Morning - Live',199,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',45,27),('3V8wDzLWWl1O1Hdldf3TsF','Take My Breath - Instrumental',220,'','None','','4lBrDelXR6Sn0k54a7UWMz','1Xyo4u8uXC1ZmMpatF05PJ',37,2),('3V937b8IsyJ0ZvVHxreiMs','Faith',283,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',59,8),('3vAdBZvbr3bFBiSLT4iVap','Another One Of Me (feat. 21 Savage)',220,'','None','','2xnqikpcvH2vBYc89VnwwL','1Xyo4u8uXC1ZmMpatF05PJ',51,1),('3vJcz8exedHCjQ9ed95NqU','Every Angel is Terrifying',167,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',55,12),('3weHnt82LuCTMa2AnZFM78','Echoes Of Silence',239,'','None','','04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',55,9),('3WKYPmiPpJas9j5Aari5iK','Love In The Sky',267,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',56,4),('3WlbeuhfRSqU7ylK2Ui5U7','Snowchild',247,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',66,5),('3WOWPWXE4h0rDIwGZ06yo1','Echoes Of Silence',239,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',48,9),('3WXyY2PxX88kpBtB0GH61w','Take My Breath',339,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',59,4),('3Xz0rSC29WbaobyJQfeYsp','All I Know (feat. Future)',321,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',47,16),('3YcDJOpqGjXj6AYhneCXGX','Moth To A Flame (with The Weeknd, feat. Tourist) - Tourist Remix',293,'','None','','0sye9Q82C9Q4tTJN8b0aFq','1Xyo4u8uXC1ZmMpatF05PJ',42,3),('3YZmW6AUHsbN7KhOTd944i','Best Friends - Remix',175,'','None','','4a8uxN5j5ZSWuioZ9cHqWk','1Xyo4u8uXC1ZmMpatF05PJ',51,1),('3ZhnXFSunfOPWSqfLLQA9W','Pretty',375,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',46,9),('40MXr7BMh3ShPf2b9giSRt','Moth To A Flame (with The Weeknd, Moojo) - Moojo Remix',436,'','None','','17cYF29ZBcDYoRkWUzFWfQ','1Xyo4u8uXC1ZmMpatF05PJ',57,1),('40U8d12pC5UHqmHwXjHjjl','Repeat After Me (Interlude)',195,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',65,12),('431r2Qg4I2qFIKdSFCJN4s','Low Life - Live',107,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,14),('44I7sqKYCAa7bQdVywkShO','Hurricane',238,'','None','','4YV1qBdn6O6thyg18kBo0N','1Xyo4u8uXC1ZmMpatF05PJ',63,1),('44Vzd5QhPFN0ydfw9Hwou2','Moth To A Flame (with The Weeknd, Chris Lake) - Chris Lake Remix',278,'','None','','0sye9Q82C9Q4tTJN8b0aFq','1Xyo4u8uXC1ZmMpatF05PJ',31,2),('45ypYpAdgoneWcBT0Wba3p','Hurricane - Live',127,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',48,8),('47vfGRaXEGzcM2vI7JC2OO','Can\'t Feel My Face - Live',183,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',46,6),('4BGZF4oLbTL0pWm7C18pbv','Scared To Live',191,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',66,4),('4bPsiRqWPFPgLiPQR7jNo4','A Lesser Man',298,'','None','','5aX2plzPm0m6zk4ZFuqbuI','1Xyo4u8uXC1ZmMpatF05PJ',56,1),('4cm7Ap6IWH6m8JyB9IXT3x','Best Friends',163,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',48,9),('4coENUbKuiuFb0C38uqFTi','Lonely Star',349,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',53,1),('4dXnS1YXBkn4oAIxRLPJcK','Rolling Stone',230,'','None','','6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',57,8),('4EDijkJdHBZZ0GwJ12iTAj','Stargirl Interlude',111,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',77,8),('4eQO9RHTjYT1O9DTuZLj9v','Blinding Lights',200,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',51,9),('4ER9305DBAmJqj2P96TfBr','Live For',222,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',45,6),('4F7A0DXBrmUAkp32uenhZt','Party Monster',249,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',80,2),('4frLb7nWtsz2ymBE6k2GRP','Earned It (Fifty Shades Of Grey)',277,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',76,9),('4FuSnjXKARcUOwiPnEnh1p','The Knowing',342,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',53,9),('4h90qkbnW1Qq6pBhoPvwko','Sidewalks',231,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',75,9),('4jBfUB4kQJCWOrjGLQqhO0','The Morning',314,'','None','','7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',78,4),('4JNdwEfqwFRiAeEISC8RU8','Die For You (with Ariana Grande) - Remix',232,'','None','','0YF085Qdh4HgdhZ8zjWkpo','1Xyo4u8uXC1ZmMpatF05PJ',71,1),('4k47x4UkxG215nFLMFna8A','False Alarm',220,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',49,3),('4LKx0dlvzsmntdhMCTtV97','Too Late',239,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',50,2),('4Mnnd0fBRucoxGhtG7MccI','The Birds Pt. 2',350,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',59,6),('4Msr8L0gHGDsLSBlk7pSPU','Opening Night',96,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',71,8),('4mU5iXHeLgbR94siF7p1sY','Six Feet Under',237,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',69,10),('4oeaIftdpT3JuZLcCkKmVE','False Alarm',220,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',67,3),('4oGnKXq6cIXoE7gfEbh5Ax','Die For You - Live',193,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,22),('4oN4odRiXgTMnaAjz7kinV','One Of The Girls - A Cappella',249,'','None','','4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',52,5),('4pHQ9RYFhn3W0ha5KEuMnj','Adaptation',283,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',57,3),('4PhsKqMdgMEUSstTDAmMpg','Often',249,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',83,4),('4ppTAJUbNXELZcoUaL90wo','Try Me',221,'','None','','4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',73,2),('4q75XguyPrsduy70hcBVFu','Coming Down',295,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',58,7),('4QYEtbfsqusrXN5A49LG53','Six Feet Under',237,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',49,10),('4Rrj1QxDqsj28gv9SiHQRA','Out of Time - KAYTRANADA Remix',275,'','None','','6LuY3APmuxui8BM2oibkrZ','1Xyo4u8uXC1ZmMpatF05PJ',45,1),('4sWQbsLLH2NEbO79DSZCL9','Big Sleep (feat. Giorgio Moroder)',225,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',68,16),('4TA5KWeqdDmgdVPHE7Yj3B','Final Lullaby - Bonus Track',185,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',53,17),('4TDPlp7OSOjuDU3l7PCM04','Hurry Up Tomorrow',291,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',70,22),('4VMRsbfZzd3SfQtaJ1Wpwi','Double Fantasy (with Future)',268,'','None','','0Ct52rooGyvjv6qXrBPNzm','1Xyo4u8uXC1ZmMpatF05PJ',73,1),('4vz3UReBbxyPuVqgIjTCeA','Rolling Stone',230,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',51,8),('4w1dIZxwO83XpKo5wgLhkk','Belong To The World',307,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',46,5),('4W4fNrZYkobj539TOWsLO2','Die For You (with Ariana Grande) - Remix',232,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',79,19),('4WfGDkm99oLJSAtELYZYEd','One Of The Girls - Sped Up',215,'','None','','4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',65,2),('4WZZeEjRqC4tV8rFljQzEo','Heaven Or Las Vegas',353,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',48,9),('4Yw8TyBm9J8cpy2guHUYog','What You Need',206,'','None','','7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',75,2),('4zHa39io9pjsiAE6LwM2NH','Reminder',218,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',53,4),('4ZYGm4xWPhsZVijqtpWn4C','Starboy - Live',245,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',49,12),('51a6oFNsFpB2zew1tdzT6I','Escape From LA',355,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',50,6),('52RgkUwQNKjh3iHhxV3rfZ','Save Your Tears - Live',178,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',46,28),('53qYItjefG5SUf62428dIw','The Zone',418,'','None','','6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',65,4),('54wv48DETGI2gSJkqTCSyJ','Timeless - Instrumental',256,'','None','','0FWdxPnncm63s91g0PkTvv','1Xyo4u8uXC1ZmMpatF05PJ',53,3),('54XqJ3fP3GxmUejMsKwCaK','One Of The Girls',244,'','None','','4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',64,1),('5673WA8EEUSPx1ir26lhGW','Wake Me Up (feat. Justice)',308,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',76,1),('57olj5GnAUyVo6touOTgWl','Devil\'s Paradise',338,'','None','','5bx7i3cuSfXBPF7Li8kUR7','1Xyo4u8uXC1ZmMpatF05PJ',43,2),('57qiTKh8bVX0VtfUNTQqhw','Nothing Without You',198,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',61,15),('58yC1Q6XKjmHeWkEWh9O6B','Outside',259,'','None','','04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',55,3),('5ck9P3yEwc8w2Z1oE0CRlz','Popular (A Cappella) (with Playboi Carti & Madonna)',215,'','None','','0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',38,5),('5d6lYplVOV4xJ37EVCpHqB','House Of Balloons / Glass Table Girls',407,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',59,3),('5dMVtDN1RDNTOL92oDncwd','Repeat After Me (Interlude)',195,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',49,12),('5e5h9GeNY6janbVi34tn9e','Gone',486,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',52,7),('5Ee4IyhPaOVRMc15fUOeG9','Creepin\' (feat. 21 Savage) - Remix',232,'','None','','3P2UkOkqWp8ucd1EOnVAH7','1Xyo4u8uXC1ZmMpatF05PJ',53,1),('5ejT19NfiINj4cFmjRHwAC','Love To Lay',223,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',47,11),('5FUn6vN4PDHXxqnb5LQhJQ','Kiss Land',455,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',58,8),('5GM4EsVHaxGjzgQ81S2J61','Hardest To Love',211,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',50,3),('5HFQB9ENLGBHTci7xPmLk6','A Lonely Night',220,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',48,12),('5HUQPQ9E1a4er4UhB8C7Rc','Dollhouse (with Lily Rose Depp)',239,'','None','','10SppFk45za4CHPEiiuQaD','1Xyo4u8uXC1ZmMpatF05PJ',67,1),('5idmfDT06TjCQ1SPDsa5qh','Kiss Land',455,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',66,8),('5JaqApg5415jtjdyjY3wa9','Valerie',286,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',59,10),('5JpSjNcjuP8L9QrYmv3xcn','Lonely Star',349,'','None','','6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',59,1),('5JQ5Acrgv1VrO9UtMUN052','Heaven Or Las Vegas',353,'','None','','6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',52,9),('5L3ecxQnQ9qTBmnLQiwf0C','K-POP',185,'','None','','10eNMeTimUzAKLhCOpIUlb','1Xyo4u8uXC1ZmMpatF05PJ',73,1),('5LffvExhQQFcfwqkGNpFpM','Jealous Guy',209,'','None','','7tzVd1fwkxsorytCBjEJkU','1Xyo4u8uXC1ZmMpatF05PJ',57,2),('5M1n6xeBtHTgg50ztjGgRw','Enjoy The Show (feat. Future) - Single Version',224,'','None','','15b9JCsZh7DkbA2EjBjPqc','1Xyo4u8uXC1ZmMpatF05PJ',45,1),('5mEE5p155rwEwxk83wcRIZ','K-POP - Sped Up',145,'','None','','0jiAYLsE1PumLJncO7vUIl','1Xyo4u8uXC1ZmMpatF05PJ',30,4),('5oAOK7xCJD8hzp9PuxjULL','Tears In The Rain',444,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',59,10),('5OGxg1400HmCYVRHuccZWw','Blinding Lights - Live',253,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,30),('5OmX5lXxZ5sQgPuSHDn293','Wanderlust',306,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',50,7),('5ONnknPrFf58QVxCBRcofB','Starry Eyes - MIKE DEAN Remix',198,'','None','','6vJRxj9GnmwXT7mKJqE61n','1Xyo4u8uXC1ZmMpatF05PJ',41,1),('5PTfZsGlsDDPH8i3PdQnXJ','Call Out My Name - A Cappella',224,'','None','','4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',57,7),('5QO79kh1waicV47BqGRL3g','Save Your Tears',215,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',88,11),('5RgSyslysUK17GhRli5ksZ','Outside',259,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',49,3),('5RlqhZfTao31aQUO2QjpkG','Faith - Live',185,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,18),('5rzI6Jnlhx8DgVgsOLorfW','Baptized In Fear',232,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',78,6),('5SF1kcOiOmtZFUIQNGC4TC','The Birds Pt. 1',214,'','None','','6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',60,5),('5SGEPm9ge10bD4j3ec9UHV','Missed You - Bonus Track',144,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',60,16),('5T0ZsRG7hVgXeffepN8Kmk','Starry Eyes - MIKE DEAN Remix',198,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',44,23),('5vjgyZm1Zhtg4RptN4evNQ','Love In The Sky',267,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',47,4),('5wyFsVGDdrOZM0nf2D4p8f','Out of Time - KAYTRANADA Remix / Radio Edit',155,'','None','','6LuY3APmuxui8BM2oibkrZ','1Xyo4u8uXC1ZmMpatF05PJ',37,2),('5XbA7TAqsD0fj0dGBrbb0D','I Heard You’re Married (feat. Lil Wayne)',263,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',63,14),('5ZDKPFRZC6QlJpf8bCIXTs','The Abyss (feat. Lana Del Rey)',282,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',79,19),('5ZicFGBDAi9J2YCVesboUp','Professional',368,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',58,1),('637oNhilCI9UlkWkUW4Grt','Enjoy The Show (feat. Future)',301,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',73,10),('64JIAZ0bS7WoARYfWQGCoz','I Can\'t Fucking Sing',12,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',23,3),('6a4GH1gljLL7VvmO9u5O92','Don’t Break My Heart',205,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',63,13),('6b5P51m8xx2XA6U7sdNZ5E','Alone Again',250,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',68,1),('6bnF93Rx87YqUBLSgjiMU8','Heartless',198,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',81,7),('6C6fHTuFUxVtJpBOOaMvJr','Shameless',253,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',67,8),('6cViXqp01e3FrAaseuiSAV','False Idols (with Lil Baby, Suzanna Son)',262,'','None','','4q3wUuIReEjGSYzmSsxtl6','1Xyo4u8uXC1ZmMpatF05PJ',66,2),('6eJbjaoLRlfwrfWpeS6alF','Life Of The Party',296,'','None','','6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',58,2),('6fSvz9yrQY407xmr7cdjuA','Party Monster',249,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',53,2),('6HrLsSVEk6C1X2EKmOEBxA','The Zone',418,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',55,4),('6hU8kY1Pot3gvEHb9CVj3F','Scared To Live',191,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',48,4),('6i5fDaCzwxRrZtuvvcqoIf','Drive',188,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',70,18),('6I5gj0D4OEScl48BPFR0J1','Best Friends - Remix',175,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',42,22),('6j6F1Y7axFvgjuiRsEQCWO','Moth To A Flame (with The Weeknd)',234,'','None','','0sye9Q82C9Q4tTJN8b0aFq','1Xyo4u8uXC1ZmMpatF05PJ',49,1),('6J7PIkhtHwmFjPLq0SyuPj','Dark Times',260,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',63,12),('6jDGDtQPC46pFqxph3qdbD','Until We\'re Skin & Bones',22,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',27,5),('6knNhL3mIaackJvtjmUrfN','Party Monster - Live',189,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',48,17),('6krYS8KtmNAYyb5uTZiYW4','Dawn FM',96,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',58,1),('6kWxIqQDsKFYCJGbU4AjCX','Hardest To Love',211,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',68,3),('6LRLy3SmtsPJaopCiavbme','Popular (Instrumental) (with Playboi Carti & Madonna)',215,'','None','','0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',38,4),('6M3PsepEj5gyJoIi7Xvr7u','Take My Breath - Single Version',220,'','None','','4lBrDelXR6Sn0k54a7UWMz','1Xyo4u8uXC1ZmMpatF05PJ',58,1),('6n6GfXu4i22rdsmRKe2eIn','Without a Warning',297,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',71,21),('6N8W7Dbcsg9tRDxn0wjFkR','The Hills - Live',185,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',49,9),('6OGogr19zPTM4BALXuMQpF','Take My Breath - Single Version',220,'','None','','6DmXKM13nNgIIby2FdK0f8','1Xyo4u8uXC1ZmMpatF05PJ',65,1),('6ojrylBvc8SkXGjr02FjRX','The Birds Pt. 1',214,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',55,5),('6oYRgLK4B38yYy9TeTpMjn','Out of Time - Instrumental',214,'','None','','6LuY3APmuxui8BM2oibkrZ','1Xyo4u8uXC1ZmMpatF05PJ',40,4),('6P8Rrx5cnxee40GPieLvhc','Like A God',226,'','None','','4q3wUuIReEjGSYzmSsxtl6','1Xyo4u8uXC1ZmMpatF05PJ',50,1),('6pDVjCUA3B1vg9waKutAsv','Attention',197,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',64,13),('6pG3yiKNsX03ZFTFWdOasv','Next',361,'','None','','04hy4jb1GDD00otiwzsFUB','1Xyo4u8uXC1ZmMpatF05PJ',58,8),('6QdnKD1zwEgyOWtkrdzlOF','Hurt You',230,'','None','','4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',74,5),('6QZePG40wT3i7bIRlmauTm','Take Me Back',227,'','None','','5aX2plzPm0m6zk4ZFuqbuI','1Xyo4u8uXC1ZmMpatF05PJ',55,2),('6tB01QHgH9YuVA8TomAzni','Or Nah - Live',101,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,15),('6tjsbysvZh8Pq8DZA5ldrn','The Knowing',342,'','None','','7zCODUHkfuRxsUjtuzNqbd','1Xyo4u8uXC1ZmMpatF05PJ',61,9),('6TZFNPSXXXBakzy5oUDQhc','Out of Time',214,'','None','','6LuY3APmuxui8BM2oibkrZ','1Xyo4u8uXC1ZmMpatF05PJ',41,3),('6Uj2XaahtYXK2WeD7GGwBY','Gasoline',212,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',50,2),('6utQlfLooYsUkq5xUg3vxt','Nothing Compares - Bonus Track',222,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',63,15),('6V9TlCdwLeQes4FX5zxz3f','Wanderlust',306,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',57,7),('6WzRpISELf3YglGAh7TXcG','Popular (with Playboi Carti & Madonna) - From The Idol Vol. 1 (Music from the HBO Original Series)',215,'','None','','5O0zUvdnJr0RbWzLFneN2i','1Xyo4u8uXC1ZmMpatF05PJ',85,1),('6XZ8C5etRn0kiS1wwuW0SO','Out of Time - Live',200,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,20),('6yuRNAxPh712eIib8UPI6U','Out of Time - KAYTRANADA Remix',275,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',40,21),('6zKlGJXteHq8KRKaLnUfCs','What You Need',206,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',55,2),('6zzdyvVWjGrQBraSvuqJPY','Starry Eyes',148,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',65,11),('717s9KFmHhyy5t3xkStS56','Red Terror',231,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',69,20),('71wzVT1X4S2LTvsnyrWyPt','The Fall',345,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',48,7),('72fcuveJcHQ61u25WHQhjw','Open Hearts - Single Version',211,'','None','','6VfBBrRc9CiWisIAoBeTqs','1Xyo4u8uXC1ZmMpatF05PJ',66,1),('72SxWvaYsDgix2N3sjCjT1','How Do I Make You Love Me? - Live',209,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',47,5),('73H5bn2SKYkMHBPvWGZDcu','Outro - Live',199,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',40,31),('759ndr57jb0URg4j9YSWml','A Tale By Quincy',96,'','None','','2nLOHgzXzwFEpl62zAgCEC','1Xyo4u8uXC1ZmMpatF05PJ',56,6),('76yLBykniz0SSNv0jj17M2','Starboy (feat. Daft Punk)',230,'','None','','35dut3ICqF3NEDkjxfzJJ1','1Xyo4u8uXC1ZmMpatF05PJ',58,1),('78aURwMzynDMan7DfSWwsI','Loft Music',363,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',53,8),('7bGF2hNOP6SROacsxo1fCk','Wicked Games',325,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',58,5),('7bvkyTwVkylUGJvz1UMjFk','The Party & The After Party',459,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',59,6),('7CyPwkp0oE8Ro9Dd5CUDjW','One Of The Girls (with JENNIE, Lily Rose Depp)',244,'','None','','7tzVd1fwkxsorytCBjEJkU','1Xyo4u8uXC1ZmMpatF05PJ',94,1),('7DKS0rX27cCEPsK0R6tFWS','Wasted Times',220,'','None','','4qZBW3f2Q8y0k1A84d4iAO','1Xyo4u8uXC1ZmMpatF05PJ',70,3),('7dnixpDdQlIOX1L7O0pdFM','World Class Sinner / I’m A Freak',199,'','None','','6E3IPXh38G7UHLqVdfIY5h','1Xyo4u8uXC1ZmMpatF05PJ',63,2),('7DY756WOLyOz2Xnhw4EFiC','São Paulo (feat. Anitta)',301,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',88,4),('7e7aslhXJZj4d0trBrensY','Timeless (feat. Playboi Carti)',256,'','None','','0FWdxPnncm63s91g0PkTvv','1Xyo4u8uXC1ZmMpatF05PJ',56,2),('7fBv7CLKzipRk6EC6TWHOB','The Hills',242,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',89,5),('7FeSiBUEyqxlKvjGbfwKku','Tears In The Rain',444,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',51,10),('7gCFW1KSX4gDgAhro23URU','In Your Eyes',237,'','None','','742eAldb4AJKLoPgJhGRE7','1Xyo4u8uXC1ZmMpatF05PJ',51,10),('7gSjRw3wKuTeDdM0lwp9rv','Professional',368,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',48,1),('7H3cuCPaX9WHZXQ0Q9RlxH','Popular (Sped Up) (with Playboi Carti & Madonna)',187,'','None','','0p0FGxiCrl3afABenvtWbQ','1Xyo4u8uXC1ZmMpatF05PJ',51,2),('7HK0ZDEsW0lGKKIVYvni2z','After Hours - Live',267,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',51,19),('7HLn9FW7A3XPb5JVYN1090','Dancing In The Flames - Live from São Paulo',312,'','None','','7GHiMUbLhh67dWSN1xGUcP','1Xyo4u8uXC1ZmMpatF05PJ',47,1),('7HX1VOiPj1oMlgZ3OQ92B6','Intro - Live',95,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',44,1),('7jGr8wzgwOVLuktY66qM5f','The Town',307,'','None','','3hhDpPtCFuQbppwYgsVhMO','1Xyo4u8uXC1ZmMpatF05PJ',58,2),('7Kd39JsnLyJLEXNeWUi3T9','Thursday',320,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',51,3),('7kJyHFVVZMv1wQYRU9de9d','Timeless (feat. Playboi Carti & Doechii) - Remix',228,'','None','','0FWdxPnncm63s91g0PkTvv','1Xyo4u8uXC1ZmMpatF05PJ',78,1),('7liZGwyLYFBSobxHLazRAt','XO / The Host',444,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',52,4),('7MwYXhh2dTqc7fiwkwPZo1','Crocodile Tears',182,'','None','','10SppFk45za4CHPEiiuQaD','1Xyo4u8uXC1ZmMpatF05PJ',43,3),('7MXVkk9YMctZqd1Srtv4MB','Starboy',230,'','None','','2ODvWsOgouMbaA5xf0RkJe','1Xyo4u8uXC1ZmMpatF05PJ',92,1),('7oDd86yk8itslrA9HRP2ki','Die For You - Remix',232,'','None','','6Exo0MYoL3XammoTDeihFy','1Xyo4u8uXC1ZmMpatF05PJ',77,1),('7p2wRa4m9KVXEXUlkJLhUi','I Heard You\'re Married (feat. Lil Wayne)',263,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',46,14),('7q9Sr5kCkha0L49GAQctHl','Every Angel is Terrifying',167,'','None','','12INlMsFtBjyehNnawBv36','1Xyo4u8uXC1ZmMpatF05PJ',43,12),('7qdfBIElGNUtPijoxJ1mMl','Initiation',260,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',48,5),('7rVmzyFA7f4rNGl9onF21E','Take Me Back To LA',253,'','None','','3OxfaVgvTxUTy7276t7SPU','1Xyo4u8uXC1ZmMpatF05PJ',73,15),('7skxtd9x0d05fjz4D7w3t2','Sacrifice - Live',263,'','None','','1OARrXe5sB0gyy3MhQ8h92','1Xyo4u8uXC1ZmMpatF05PJ',48,4),('7szuecWAPwGoV1e5vGu8tl','In Your Eyes',237,'','None','','4yP0hdKOZPNshxUOjY0cZj','1Xyo4u8uXC1ZmMpatF05PJ',79,10),('7uJH0YdSZL6psjxI6Xy08b','Acquainted',348,'','None','','0P3oVJBFOv3TDXlYRhGL7s','1Xyo4u8uXC1ZmMpatF05PJ',76,6),('7wPTyxE1PNemZuyuOOaQ8q','The Morning',314,'','None','','2XGEyGU76kj55OdHWynX0S','1Xyo4u8uXC1ZmMpatF05PJ',66,4),('7xcqbjV2NfxlnJzqdRuO7E','Odd Look',252,'','None','','6wRev1uYL0JsMsWqktJuVi','1Xyo4u8uXC1ZmMpatF05PJ',58,12),('7xgYvziLsxNd0UznaEw8Oi','Gone',486,'','None','','6F87lH0I09qlrzvCCKc7lz','1Xyo4u8uXC1ZmMpatF05PJ',54,7),('7zNS5065xzKyhOBMOj7pCr','One Of The Girls - Instrumental',244,'','None','','4T8wBxIvoSRVfoFZzuwOXR','1Xyo4u8uXC1ZmMpatF05PJ',55,4);
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
  KEY `FK_user_TO_track_mood_vote_1` (`user_id`),
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
  `rating` float NOT NULL,
  `content` text NOT NULL,
  `blinded` tinyint(1) NOT NULL,
  `likes` int NOT NULL DEFAULT '0',
  `dislikes` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `critic` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  `track_id` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_track_review_1` (`user_id`),
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
  `profile_image` varchar(200) DEFAULT NULL,
  `bio` text,
  `is_pro` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `provider` varchar(200) DEFAULT NULL,
  `provider_id` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1004','tjsans9069@gmail.com','$2a$10$2oiifaEmNpAQDKELfL0pYewrpB47qAHbCEkoLhLeGPIt.bd.HYuge','이준',NULL,NULL,0,1,NULL,NULL,'2025-07-04 12:13:09','2025-07-04 12:13:09'),(2,'user1005','user1005@gmail.com','$2a$10$vP/pdjMUvI6l.f71nFxYC.5F.SPEshQHg8DClIfBSFlcjR/5LPgoW','삼준',NULL,NULL,0,1,NULL,NULL,'2025-07-06 13:03:09','2025-07-06 13:03:09');
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
  CONSTRAINT `FK_user_TO_user_activity_log_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
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
  KEY `FKFKFK` (`username`),
  CONSTRAINT `FKFKFK` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_auth`
--

/*!40000 ALTER TABLE `user_auth` DISABLE KEYS */;
INSERT INTO `user_auth` VALUES (1,'user1004','ROLE_USER'),(2,'user1005','ROLE_USER');
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
  `user_id` bigint DEFAULT NULL,
  `badge_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_user_badge_1` (`user_id`),
  KEY `FK_badge_TO_user_badge_1` (`badge_id`),
  CONSTRAINT `FK_badge_TO_user_badge_1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`),
  CONSTRAINT `FK_user_TO_user_badge_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_badge`
--

/*!40000 ALTER TABLE `user_badge` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_badge` ENABLE KEYS */;

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
  KEY `FK_user_TO_user_follow_1` (`follower_id`),
  KEY `FK_user_TO_user_follow_2` (`following_id`),
  CONSTRAINT `FK_user_TO_user_follow_1` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_user_TO_user_follow_2` FOREIGN KEY (`following_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_follow`
--

/*!40000 ALTER TABLE `user_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_follow` ENABLE KEYS */;

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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nickname` varchar(100) NOT NULL,
  `profile_image` varchar(200) DEFAULT NULL,
  `bio` text,
  `is_pro` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `provider` varchar(200) DEFAULT NULL,
  `provider_id` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

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
    -- 외래 키 제약 조건 일시 비활성화
    SET FOREIGN_KEY_CHECKS = 0;

    -- 기존 테이블 모두 삭제 (순서 중요: 외래 키 제약 조건이 있는 경우 역순으로 삭제)
    -- 안전하게 삭제하기 위해 IF EXISTS를 사용합니다.
    DROP TABLE IF EXISTS
        liked_album, album_review, user_follow, user_badge,
        track_review, notification, chart_entry,
        board_post, playlist_detail, artist_follow, album,
        playlist, comment, chart_element, album_mood_vote, report,
        liked_playlist, liked_track, qna_answer, qna, community,
        track_mood_vote, user_sanction, admin_log, user_role,
        notice, setting, badge, policy, external_api_config, plugin,
        track, artist, user, role, tag, user_activity_log, user_auth; -- user_activity_log도 추가합니다.

    -- 테이블 생성
    -- 모든 CREATE TABLE 문에서 PRIMARY KEY 정의는 제거합니다.
    -- (아래 ALTER TABLE에서 일괄적으로 PRIMARY KEY를 추가할 것이기 때문입니다.)
    CREATE TABLE IF NOT EXISTS `notice` (
        `id` BIGINT NOT NULL,
        `title` VARCHAR(200) NOT NULL,
        `content` TEXT NOT NULL,
        `created_at` DATETIME NOT NULL,
        `updated_at` DATETIME NULL,
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
        `status` BOOLEAN NOT NULL DEFAULT false,
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
        `title` VARCHAR(100) NOT NULL,
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
	`id`	BIGINT	NOT NULL,
	`username`	VARCHAR(100) NOT NULL UNIQUE,
	`email`	VARCHAR(100)	NOT NULL,
	`password`	VARCHAR(100)	NOT NULL,
	`nickname`	VARCHAR(100)	NOT NULL,
	`profile_image`	VARCHAR(200)	NULL,
	`bio`	TEXT	NULL,
	`is_pro`	BOOLEAN	NOT NULL DEFAULT FALSE,
	`enabled`	BOOLEAN	NOT NULL DEFAULT TRUE,
	`provider`	VARCHAR(200)	NULL,
	`provider_id`	VARCHAR(200)	NULL,
	`created_at`	TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`updated_at`	TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP
                                            ON UPDATE CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS `user_auth` (
    no bigint NOT NULL AUTO_INCREMENT
    , username varchar(100) NOT NULL
    , auth varchar(100) NOT NULL
    , PRIMARY KEY(no)
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
        `id` BIGINT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `user_id` BIGINT NOT NULL,
        `playlist_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `report` (
        `id` BIGINT NOT NULL,
        `target_type` ENUM('boardPost', 'comment', 'review', 'playlist', 'album', 'track', 'user', 'artist', 'qna') NOT NULL,
        `reason` TEXT NOT NULL,
        `status` VARCHAR(10) NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `reporter_id` BIGINT NOT NULL,
        `target_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `album_mood_vote` (
        `id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL,
        `album_id` VARCHAR(200) NOT NULL,
        `mood` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `chart_element` (
        `id` BIGINT NOT NULL,
        `lyric` INT NOT NULL,
        `sound` INT NOT NULL,
        `melody` INT NOT NULL,
        `storytelling` INT NOT NULL,
        `cohesiveness` INT NOT NULL,
        `creativity` INT NOT NULL,
        `album_id` VARCHAR(200) NOT NULL
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
        `thumbnail_url` VARCHAR(200) NULL,
        `is_public` BOOLEAN NOT NULL,
        `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `track_id` VARCHAR(200) NULL
    );

    CREATE TABLE IF NOT EXISTS `album` (
        `id` VARCHAR(200) NOT NULL,
        `title` VARCHAR(100) NOT NULL,
        `cover_image` VARCHAR(200) NULL,
        `release_date` DATE NOT NULL,
        `genre` VARCHAR(64) NULL,
        `label` VARCHAR(100) NULL,
        `description` TEXT NULL,
        `artist_id` VARCHAR(200) NOT NULL
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
        `id` VARCHAR(200) NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `user_id` BIGINT NOT NULL,
        `artist_id` VARCHAR(100) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `playlist_detail` (
        `id` BIGINT NOT NULL,
        `track_id` VARCHAR(200) NOT NULL,
        `playlist_id` BIGINT NOT NULL,
        `order_no` INT NOT NULL,
        `Field` VARCHAR(255) NULL
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
        `type` ENUM('comment', 'mention', 'like','follow','reply','badge','qna','announcement','system') NOT NULL,
        `message` TEXT NOT NULL,
        `content` TEXT NULL,
        `is_read` BOOLEAN NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `target_id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `setting` (
        `id` BIGINT NOT NULL,
        `value` VARCHAR(100) NULL,
        `updated_at` DATETIME NULL
    );

    CREATE TABLE IF NOT EXISTS `track_mood_vote` (
        `id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL,
        `track_id` VARCHAR(200) NOT NULL,
        `mood` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `track_review` (
        `id` BIGINT NOT NULL,
        `rating` FLOAT NOT NULL,
        `content` TEXT NOT NULL,
        `blinded` BOOLEAN NOT NULL,
        `likes` INT NOT NULL DEFAULT 0,
        `dislikes` INT NOT NULL DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `critic` BOOLEAN NOT NULL,
        `user_id` BIGINT NOT NULL,
        `track_id` VARCHAR (200) NOT NULL
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
        `user_id` BIGINT NULL,
        `badge_id` BIGINT NULL
    );

    CREATE TABLE IF NOT EXISTS `user_follow` (
        `id` BIGINT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `follower_id` BIGINT NOT NULL,
        `following_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `album_review` (
        `id` BIGINT NOT NULL,
        `rating` FLOAT NOT NULL,
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

    -- PRIMARY KEY 추가
    -- 이 부분은 그대로 두시면 됩니다.
    ALTER TABLE `notice` ADD CONSTRAINT `PK_NOTICE` PRIMARY KEY (`id`);
    ALTER TABLE `qna_answer` ADD CONSTRAINT `PK_QNA_ANSWER` PRIMARY KEY (`id`);
    ALTER TABLE `role` ADD CONSTRAINT `PK_ROLE` PRIMARY KEY (`id`);
    ALTER TABLE `community` ADD CONSTRAINT `PK_COMMUNITY` PRIMARY KEY (`id`);
    ALTER TABLE `qna` ADD CONSTRAINT `PK_QNA` PRIMARY KEY (`id`);
    ALTER TABLE `liked_track` ADD CONSTRAINT `PK_LIKED_TRACK` PRIMARY KEY (`id`);
    ALTER TABLE `artist` ADD CONSTRAINT `PK_ARTIST` PRIMARY KEY (`id`);
    ALTER TABLE `tag` ADD CONSTRAINT `PK_TAG` PRIMARY KEY (`id`);
    ALTER TABLE `track` ADD CONSTRAINT `PK_TRACK` PRIMARY KEY (`id`);
    ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (`id`);
    ALTER TABLE `external_api_config` ADD CONSTRAINT `PK_EXTERNAL_API_CONFIG` PRIMARY KEY (`id`);
    ALTER TABLE `liked_playlist` ADD CONSTRAINT `PK_LIKED_PLAYLIST` PRIMARY KEY (`id`);
    ALTER TABLE `report` ADD CONSTRAINT `PK_REPORT` PRIMARY KEY (`id`);
    ALTER TABLE `album_mood_vote` ADD CONSTRAINT `PK_ALBUM_MOOD_VOTE` PRIMARY KEY (`id`);
    ALTER TABLE `chart_element` ADD CONSTRAINT `PK_CHART_ELEMENT` PRIMARY KEY (`id`);
    ALTER TABLE `comment` ADD CONSTRAINT `PK_COMMENT` PRIMARY KEY (`id`);
    ALTER TABLE `playlist` ADD CONSTRAINT `PK_PLAYLIST` PRIMARY KEY (`id`);
    ALTER TABLE `album` ADD CONSTRAINT `PK_ALBUM` PRIMARY KEY (`id`);
    ALTER TABLE `user_sanction` ADD CONSTRAINT `PK_USER_SANCTION` PRIMARY KEY (`id`);
    ALTER TABLE `admin_log` ADD CONSTRAINT `PK_ADMIN_LOG` PRIMARY KEY (`id`);
    ALTER TABLE `artist_follow` ADD CONSTRAINT `PK_ARTIST_FOLLOW` PRIMARY KEY (`id`);
    ALTER TABLE `playlist_detail` ADD CONSTRAINT `PK_PLAYLIST_DETAIL` PRIMARY KEY (`id`);
    ALTER TABLE `policy` ADD CONSTRAINT `PK_POLICY` PRIMARY KEY (`id`);
    ALTER TABLE `board_post` ADD CONSTRAINT `PK_BOARD_POST` PRIMARY KEY (`id`);
    ALTER TABLE `chart_entry` ADD CONSTRAINT `PK_CHART_ENTRY` PRIMARY KEY (`id`);
    ALTER TABLE `user_role` ADD CONSTRAINT `PK_USER_ROLE` PRIMARY KEY (`id`);
    ALTER TABLE `badge` ADD CONSTRAINT `PK_BADGE` PRIMARY KEY (`id`);
    ALTER TABLE `notification` ADD CONSTRAINT `PK_NOTIFICATION` PRIMARY KEY (`id`);
    ALTER TABLE `setting` ADD CONSTRAINT `PK_SETTING` PRIMARY KEY (`id`);
    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `PK_TRACK_MOOD_VOTE` PRIMARY KEY (`id`);
    ALTER TABLE `track_review` ADD CONSTRAINT `PK_TRACK_REVIEW` PRIMARY KEY (`id`);
    ALTER TABLE `user_activity_log` ADD CONSTRAINT `PK_USER_ACTIVITY_LOG` PRIMARY KEY (`id`);
    ALTER TABLE `user_badge` ADD CONSTRAINT `PK_USER_BADGE` PRIMARY KEY (`id`);
    ALTER TABLE `user_follow` ADD CONSTRAINT `PK_USER_FOLLOW` PRIMARY KEY (`id`);
    ALTER TABLE `album_review` ADD CONSTRAINT `PK_ALBUM_REVIEW` PRIMARY KEY (`id`);
    ALTER TABLE `liked_album` ADD CONSTRAINT `PK_LIKED_ALBUM` PRIMARY KEY (`id`);
    ALTER TABLE `plugin` ADD CONSTRAINT `PK_PLUGIN` PRIMARY KEY (`id`);

    -- AUTO_INCREMENT 설정
    ALTER TABLE qna_answer MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE community MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE qna MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE liked_track MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE tag MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE user MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE external_api_config MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE liked_playlist MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE report MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE album_mood_vote MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE track_mood_vote MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE comment MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE playlist MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE artist_follow MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE playlist_detail MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE policy MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE board_post MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE chart_entry MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE badge MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE notification MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE setting MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE track_review MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE user_badge MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE user_follow MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE album_review MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE liked_album MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE plugin MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE chart_element MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE user_sanction MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE role MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE user_role MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE admin_log MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE user_activity_log MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
    ALTER TABLE notice MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;


    -- FOREIGN KEY 추가
    ALTER TABLE `notice` ADD CONSTRAINT `FK_user_TO_notice_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);
    ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_qna_TO_qna_answer_1` FOREIGN KEY (`qna_id`) REFERENCES `qna` (`id`);
    ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_user_TO_qna_answer_1` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`);
    ALTER TABLE `community` ADD CONSTRAINT `FK_user_TO_community_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`);
    ALTER TABLE `qna` ADD CONSTRAINT `FK_user_TO_qna_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `liked_track` ADD CONSTRAINT `FK_user_TO_liked_track_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `liked_track` ADD CONSTRAINT `FK_track_TO_liked_track_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);
    ALTER TABLE `track` ADD CONSTRAINT `FK_album_TO_track_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`);
    ALTER TABLE `track` ADD CONSTRAINT `FK_artist_TO_track_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`);
    ALTER TABLE `liked_playlist` ADD CONSTRAINT `FK_user_TO_liked_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `liked_playlist` ADD CONSTRAINT `FK_playlist_TO_liked_playlist_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`);
    ALTER TABLE `report` ADD CONSTRAINT `FK_user_TO_report_1` FOREIGN KEY (`reporter_id`) REFERENCES `user` (`id`);
    ALTER TABLE `report` ADD CONSTRAINT `FK_user_TO_report_2` FOREIGN KEY (`target_id`) REFERENCES `user` (`id`);
    ALTER TABLE `album_mood_vote` ADD CONSTRAINT `FK_user_TO_album_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `album_mood_vote` ADD CONSTRAINT `FK_album_TO_album_mood_vote_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`);
    ALTER TABLE `album_mood_vote` ADD CONSTRAINT `FK_tag_TO_album_mood_vote_1` FOREIGN KEY (`mood`) REFERENCES `tag` (`id`);
    ALTER TABLE `chart_element` ADD CONSTRAINT `FK_album_TO_chart_element_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`);
    ALTER TABLE `comment` ADD CONSTRAINT `FK_user_TO_comment_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `playlist` ADD CONSTRAINT `FK_user_TO_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `album` ADD CONSTRAINT `FK_artist_TO_album_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`);
    ALTER TABLE `user_sanction` ADD CONSTRAINT `FK_user_TO_user_sanction_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `user_sanction` ADD CONSTRAINT `FK_user_TO_user_sanction_2` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`);
    ALTER TABLE `admin_log` ADD CONSTRAINT `FK_user_TO_admin_log_1` FOREIGN KEY (`actor_id`) REFERENCES `user` (`id`);
    ALTER TABLE `admin_log` ADD CONSTRAINT `FK_user_TO_admin_log_2` FOREIGN KEY (`target_id`) REFERENCES `user` (`id`);
    ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_user_TO_artist_follow_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_artist_TO_artist_follow_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`);
    ALTER TABLE `playlist_detail` ADD CONSTRAINT `FK_track_TO_playlist_detail_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);
    ALTER TABLE `playlist_detail` ADD CONSTRAINT `FK_playlist_TO_playlist_detail_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`);
    ALTER TABLE `board_post` ADD CONSTRAINT `FK_community_TO_board_post_1` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`);
    ALTER TABLE `board_post` ADD CONSTRAINT `FK_user_TO_board_post_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `chart_entry` ADD CONSTRAINT `FK_track_TO_chart_entry_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);
    ALTER TABLE `user_role` ADD CONSTRAINT `FK_user_TO_user_role_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `user_role` ADD CONSTRAINT `FK_role_TO_user_role_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
    ALTER TABLE `notification` ADD CONSTRAINT `FK_user_TO_notification_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_user_TO_track_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_track_TO_track_mood_vote_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);
    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_tag_TO_track_mood_vote_1` FOREIGN KEY (`mood`) REFERENCES `tag` (`id`);
    ALTER TABLE `track_review` ADD CONSTRAINT `FK_user_TO_track_review_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `track_review` ADD CONSTRAINT `FK_track_TO_track_review_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);
    ALTER TABLE `user_activity_log` ADD CONSTRAINT `FK_user_TO_user_activity_log_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `user_badge` ADD CONSTRAINT `FK_user_TO_user_badge_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `user_badge` ADD CONSTRAINT `FK_badge_TO_user_badge_1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`);
    ALTER TABLE `user_follow` ADD CONSTRAINT `FK_user_TO_user_follow_1` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`);
    ALTER TABLE `user_follow` ADD CONSTRAINT `FK_user_TO_user_follow_2` FOREIGN KEY (`following_id`) REFERENCES `user` (`id`);
    ALTER TABLE `album_review` ADD CONSTRAINT `FK_user_TO_album_review_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `album_review` ADD CONSTRAINT `FK_album_TO_album_review_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`);
    ALTER TABLE `liked_album` ADD CONSTRAINT `FK_user_TO_liked_album_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `liked_album` ADD CONSTRAINT `FK_album_TO_liked_album_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`);
    ALTER TABLE `user_auth` ADD CONSTRAINT `FKFKFK` FOREIGN KEY (`username`) REFERENCES `user` (`username`);

    -- 외래 키 제약 조건 다시 활성화
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

-- Dump completed on 2025-07-06 22:36:03

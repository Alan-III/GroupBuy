CREATE DATABASE  IF NOT EXISTS `group_buy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `group_buy`;
-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: group_buy
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business` (
  `businessID` int(11) NOT NULL AUTO_INCREMENT,
  `businessName` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `supervisorFirstname` varchar(45) NOT NULL DEFAULT 'null',
  `supervisorLastname` varchar(45) NOT NULL,
  `AFM` varchar(45) DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `IBAN` varchar(45) DEFAULT NULL,
  `pathProfile` varchar(45) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`businessID`),
  UNIQUE KEY `businessID_UNIQUE` (`businessID`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `AFM_UNIQUE` (`AFM`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` VALUES (1,'c','eyx66209@zbock.com','c','c',NULL,0.00,NULL,NULL,1,'9f1f55de-e93b-4cdf-b');
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `businessphoto`
--

DROP TABLE IF EXISTS `businessphoto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessphoto` (
  `photoid` int(11) NOT NULL,
  `businessID` int(11) NOT NULL,
  `path` varchar(45) NOT NULL,
  PRIMARY KEY (`photoid`),
  KEY `srtfhsr_idx` (`businessID`),
  CONSTRAINT `srtfhsr` FOREIGN KEY (`businessID`) REFERENCES `business` (`businessID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `businessphoto`
--

LOCK TABLES `businessphoto` WRITE;
/*!40000 ALTER TABLE `businessphoto` DISABLE KEYS */;
/*!40000 ALTER TABLE `businessphoto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `businessproducts`
--

DROP TABLE IF EXISTS `businessproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `businessproducts` (
  `businessID` int(11) NOT NULL,
  `productCode` varchar(45) NOT NULL,
  `proID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`proID`),
  UNIQUE KEY `proID_UNIQUE` (`proID`),
  KEY `awesidgfasjkgfkasj_idx` (`businessID`),
  KEY `asdkfjbsdjklf_idx` (`productCode`),
  CONSTRAINT `awesidgfasjkgfkasj` FOREIGN KEY (`businessID`) REFERENCES `business` (`businessID`),
  CONSTRAINT `oihbjkbjl` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `businessproducts`
--

LOCK TABLES `businessproducts` WRITE;
/*!40000 ALTER TABLE `businessproducts` DISABLE KEYS */;
INSERT INTO `businessproducts` VALUES (1,'885909950652',15),(1,'55',21),(1,'2',22),(1,'333',23),(1,'11',24);
/*!40000 ALTER TABLE `businessproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `genCategory` varchar(45) NOT NULL,
  `category` varchar(45) DEFAULT NULL,
  `subCategory` varchar(45) DEFAULT NULL,
  `path` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `categoryID_UNIQUE` (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Technology',NULL,NULL,'assets/databaseImages/categories/Technology.jpg'),(2,'Technology','Mobile',NULL,'assets/databaseImages/categories/Mobile.jpg'),(3,'Technology','Mobile','Mobile Phones','assets/databaseImages/categories/MobilePhones.jpg'),(4,'Technology','Computers','Laptops','assets/databaseImages/categories/Laptops.jpg'),(5,'House',NULL,NULL,'assets/databaseImages/categories/House.jpg'),(6,'Fashion',NULL,NULL,'assets/databaseImages/categories/Fashion.jpg'),(7,'Technology','Computers',NULL,'assets/databaseImages/categories/Computers.jpg');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catergoryfilters`
--

DROP TABLE IF EXISTS `catergoryfilters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catergoryfilters` (
  `filtersID` int(11) NOT NULL AUTO_INCREMENT,
  `categoryID` int(11) NOT NULL,
  PRIMARY KEY (`filtersID`,`categoryID`),
  KEY `gfwef_idx` (`categoryID`),
  CONSTRAINT `gfwef` FOREIGN KEY (`categoryID`) REFERENCES `categories` (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catergoryfilters`
--

LOCK TABLES `catergoryfilters` WRITE;
/*!40000 ALTER TABLE `catergoryfilters` DISABLE KEYS */;
INSERT INTO `catergoryfilters` VALUES (2,2),(2,3),(2,4),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3),(11,3);
/*!40000 ALTER TABLE `catergoryfilters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupontokens`
--

DROP TABLE IF EXISTS `coupontokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupontokens` (
  `token` varchar(45) NOT NULL,
  `offerID` int(11) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `ASASD_idx` (`offerID`),
  CONSTRAINT `wkj` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupontokens`
--

LOCK TABLES `coupontokens` WRITE;
/*!40000 ALTER TABLE `coupontokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupontokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `group_buy`.`coupontokens_AFTER_UPDATE`
AFTER UPDATE ON `group_buy`.`coupontokens`
FOR EACH ROW
BEGIN
declare price DECIMAL(10,2);
declare group_size int;

SELECT  groupSize into @group_size from offers where offerID=new.offerID;

if ((SELECT count(email) from coupontokens where offerID=new.offerID)=@group_size AND NEW.DATE=NULL ) THEN
UPDATE OFFERS SET active=0 where offerID=NEW.offerID;
END IF;

IF (new.date is not null) then 

select couponPrice INTO @price FROM offers where offerID=old.offerID;

UPDATE users SET couponAmount = couponAmount - @price, balance=balance+price where email=old.email;
update business set balance=balance + @price;
insert into payments (businessEmail,userEmail,details,date,amount) values ((select email from offers where offerID=new.offerID),new.email,new.token,new.date,@price);

end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `group_buy`.`coupontokens_BEFORE_DELETE`
BEFORE DELETE ON `group_buy`.`coupontokens`
FOR EACH ROW
BEGIN
/*ΟΤΑΝ ΔΙΑΓΡΑΦΕΤΑΙ ΤΟ ΚΟΥΠΟΝΙ ΠΡΕΠΕΙ ΝΑ ΕΠΙΣΤΡΑΦΟΥΝ ΤΑ ΧΡΗΜΑΤΑ ΣΤΟΥΣ USER*/

declare price DECIMAL(10,2);

select couponPrice INTO @price FROM offers where offerID=old.offerID;

UPDATE users SET couponAmount = couponAmount - price, balance=balance+price where email=old.email;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dailyresults`
--

DROP TABLE IF EXISTS `dailyresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dailyresults` (
  `dailyID` int(11) NOT NULL AUTO_INCREMENT,
  `productCode` varchar(45) DEFAULT NULL,
  `offerID` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `IP` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`dailyID`),
  UNIQUE KEY `dailyID_UNIQUE` (`dailyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dailyresults`
--

LOCK TABLES `dailyresults` WRITE;
/*!40000 ALTER TABLE `dailyresults` DISABLE KEYS */;
/*!40000 ALTER TABLE `dailyresults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filtersdetails`
--

DROP TABLE IF EXISTS `filtersdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filtersdetails` (
  `filtersID` int(11) NOT NULL AUTO_INCREMENT,
  `filterName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`filtersID`),
  KEY `ertwert_idx` (`filtersID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filtersdetails`
--

LOCK TABLES `filtersdetails` WRITE;
/*!40000 ALTER TABLE `filtersdetails` DISABLE KEYS */;
INSERT INTO `filtersdetails` VALUES (2,'Manufacturer'),(3,'Availability'),(4,'RAM'),(5,'Features'),(6,'Storage Capacity'),(7,'Year of Release'),(8,'Screen Size'),(9,'Battery'),(10,'OS'),(11,'CPU');
/*!40000 ALTER TABLE `filtersdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `email` varchar(45) NOT NULL,
  `password` varchar(145) NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES ('b@b.b','ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb',NULL),('bly02756@zslsz.com','ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb',NULL),('eyx66209@zbock.com','2e7d2c03a9507ae265ecf5b5356885a53393a2029d241394997265a1a25aefc6',NULL);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthlyresults`
--

DROP TABLE IF EXISTS `monthlyresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monthlyresults` (
  `monthlyID` int(11) NOT NULL AUTO_INCREMENT,
  `productCode` varchar(45) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`monthlyID`),
  UNIQUE KEY `monthlyID_UNIQUE` (`monthlyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthlyresults`
--

LOCK TABLES `monthlyresults` WRITE;
/*!40000 ALTER TABLE `monthlyresults` DISABLE KEYS */;
/*!40000 ALTER TABLE `monthlyresults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mywish`
--

DROP TABLE IF EXISTS `mywish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mywish` (
  `productCode` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`productCode`,`email`),
  KEY `fghdfgb_idx` (`productCode`),
  KEY `alkdsbfn_idx` (`email`),
  CONSTRAINT `alkdsbfn` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
  CONSTRAINT `jhcgvhj` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mywish`
--

LOCK TABLES `mywish` WRITE;
/*!40000 ALTER TABLE `mywish` DISABLE KEYS */;
INSERT INTO `mywish` VALUES ('2','bly02756@zslsz.com'),('885909950652','b@b.b');
/*!40000 ALTER TABLE `mywish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `productCode` varchar(45) NOT NULL,
  `seen` tinyint(4) NOT NULL,
  `offerID` int(11) NOT NULL,
  PRIMARY KEY (`productCode`,`offerID`),
  KEY `asfasf_idx` (`offerID`),
  KEY `SDFHGH_idx` (`productCode`),
  CONSTRAINT `SDFHGH` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`),
  CONSTRAINT `asfasf` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offerdetails`
--

DROP TABLE IF EXISTS `offerdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offerdetails` (
  `offerID` int(11) NOT NULL,
  `productCode` varchar(45) NOT NULL,
  PRIMARY KEY (`offerID`,`productCode`),
  KEY `FASDFAS_idx` (`offerID`),
  KEY `aSEKNDLF_idx` (`productCode`),
  CONSTRAINT `FASDFAS` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`),
  CONSTRAINT `aSEKNDLF` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offerdetails`
--

LOCK TABLES `offerdetails` WRITE;
/*!40000 ALTER TABLE `offerdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `offerdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offerphoto`
--

DROP TABLE IF EXISTS `offerphoto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offerphoto` (
  `offerID` int(11) NOT NULL,
  `path` varchar(45) NOT NULL,
  KEY `sdafa_idx` (`offerID`),
  CONSTRAINT `sdafa` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offerphoto`
--

LOCK TABLES `offerphoto` WRITE;
/*!40000 ALTER TABLE `offerphoto` DISABLE KEYS */;
/*!40000 ALTER TABLE `offerphoto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offers` (
  `offerID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `finalPrice` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `couponPrice` decimal(10,2) NOT NULL,
  `offerExpire` datetime NOT NULL,
  `couponExpire` int(11) NOT NULL,
  `details` varchar(45) NOT NULL,
  `groupSize` int(11) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`offerID`),
  UNIQUE KEY `offerID_UNIQUE` (`offerID`),
  KEY `ajksbdfh_idx` (`email`),
  CONSTRAINT `ajksbdfh` FOREIGN KEY (`email`) REFERENCES `business` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `group_buy`.`offers_AFTER_UPDATE`
AFTER UPDATE ON `group_buy`.`offers`
FOR EACH ROW
BEGIN
declare current_size int;
declare dif int;

IF new.active=0 THEN
        update coupontokens set date = current_date() where offerID= new.offerID; 
END IF;

/*ΕΚΤΕΛΕΣΗ ΤΩΝ ΣΥΝΑΛΛΑΓΩΝ ΜΟΛΙΣ ΚΑΙ ΑΠΟΡΗΨΗ ΤΩΝ ΤΕΛΕΥΤΑΙΩΝ ΟΤΑΝ Η ΕΠΙΧΕΙΡΗΣΗ ΑΛΛAΞΕΙ ΤΟ ΜΕΓΕΘΟΣ ΤΗΣ ΟΜΑΔΑΣ ΚΑΙ ΑΥΤΟ ΕΙΝΑΙ ΜΙΚΡΟΤΕΡΟ ΤΩΝ ΣΥΜΜΕΤΟΧΩΝ
ΕΚΕΙ ΕΠΙΣΤΡΕΦΟΝΤΑΙ ΤΑ ΧΡΗΜΑΤΑ ΣΤΟΥΣ ΠΕΛΑΤΕΣ
*/
select (new.groupSize-old.groupSize) INTO dif;

IF (dif<0 AND new.active=0) then
select count(email) into current_size from coupontokens where offerID=new.offerID;
DELETE FROM coupontokens where offerID=old.offerID ORDER BY DATE DESC limit dif;
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `group_buy`.`offers_BEFORE_DELETE`
BEFORE DELETE ON `group_buy`.`offers`
FOR EACH ROW
BEGIN

/*ΔΙΑΓΡΑΦΗ ΕΠΙΘΙΜΙΩΝ ΜΕΤΑ ΤΗΝ ΔΙΑΓΡΑΦΗ ΤΗΣ ΠΡΟΣΦΟΡΑΣ*/
Delete from mywish where offerID=old.offerID;
DELETE FROM notifications where offerID=old.offerID;

/*ΔΙΑΓΡΑΦΗ ΤΩΝ OFFERDETAILS ΚΑΙ OFFERPHOTOS*/

DELETE FROM offerdetails where offerID=old.offerID;
delete from offerphoto where offerID=OLD.offerID;

/* Διαγραφή των προσφορών που αναζητήθηκαν */
delete from monthlyResults where offerID=OLD.offerID;
delete from weeklyResults where offerID=OLD.offerID;
delete from dailyResults where offerID=OLD.offerID;
delete from resultdetails where offerID=OLD.offerID;

/*ΠΡΙΝ ΔΙΑΓΡΑΦΕΙ Η ΠΡΟΣΦΟΡΑ ΕΠΙΣΤΡΕΦΟΝΤΑΙ ΤΑ ΤΟΚΕΝΣ KAI TA XRHMATA TOYΣ*/

DELETE FROM coupontokens where offerID=old.offerID ORDER BY DATE asc; ###ΜΕΣΑ ΣΕ ΑΥΤΗΝ ΤΗΝ ΑΝΑΖΗΤΗΣΗ ΜΕΤΑΦΕΡΟΝΤΑΙ ΚΑΙ ΤΑ ΧΡΗΜΑΤΑ



END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `paymentID` int(11) NOT NULL AUTO_INCREMENT,
  `businessEmail` varchar(45) DEFAULT NULL,
  `userEmail` varchar(45) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `level` varchar(45) DEFAULT NULL,
  `details` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `InOut` varchar(10) NOT NULL DEFAULT 'in',
  PRIMARY KEY (`paymentID`),
  UNIQUE KEY `paymentID_UNIQUE` (`paymentID`),
  KEY `QWEWE_idx` (`businessEmail`),
  KEY `SDKFG_idx` (`userEmail`),
  CONSTRAINT `dfgsdfg` FOREIGN KEY (`userEmail`) REFERENCES `users` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sdf` FOREIGN KEY (`businessEmail`) REFERENCES `business` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `group_buy`.`payments_AFTER_INSERT`
AFTER INSERT ON `group_buy`.`payments`
FOR EACH ROW
BEGIN
    /* ΚΑΘΕ ΦΟΡΑ ΠΟΥ Η ΕΤΑΙΡΙΑ ΠΛΗΡΩΝΕΙ ΤΗΝ ΣΥΝΔΡΟΜΗ ΤΗΣ ΠΡΟΣ ΤΗΝ ΣΕΛΙΔΑ, ΕΠΙΛΕΓΕΙ ΚΑΙ ΑΛΛΑΖΕΙ ΤΟ LEVEL ΤΗΣ */
    IF (NEW.level IS NOT NULL) THEN
        UPDATE subscriptions SET level = NEW.level WHERE email = NEW.business.email;
        UPDATE business SET balance = balance - NEW.amount;
        UPDATE admin SET balance = balance + NEW.amount;
    END IF;

    /* ΜΕΤΑ ΤΗΝ ΕΚΤΕΛΕΣΗ ΤΗΣ ΠΛΗΡΩΜΗΣ, ΜΕΤΑΒΑΛΩ ΚΑΙ ΤΟ ΣΥΝΟΛΙΚΟ ΥΠΟΛΟΙΠΟ ΤΗΣ ΕΠΙΧΕΙΡΗΣΗ */
    IF (NEW.businessEmail IS NULL) THEN
        IF (NEW.InOut = 'in') THEN
            UPDATE user SET balance = balance + NEW.amount;
        ELSEIF (NEW.InOut = 'out') THEN
            UPDATE user SET balance = balance - NEW.amount;
        END IF;
    END IF;

    /* ΜΕΤΑ ΤΗΝ ΕΚΤΕΛΕΣΗ ΤΗΣ ΠΛΗΡΩΜΗΣ, ΜΕΤΑΒΑΛΩ ΚΑΙ ΤΟ ΣΥΝΟΛΙΚΟ ΥΠΟΛΟΙΠΟ ΤΟΥ ΧΡΗΣΤΗ */
    IF (NEW.userEmail IS NULL) THEN
        IF (NEW.InOut = 'in') THEN
            UPDATE business SET balance = balance + NEW.amount;
        ELSEIF (NEW.InOut = 'out') THEN
            UPDATE business SET balance = balance - NEW.amount;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `productfilters`
--

DROP TABLE IF EXISTS `productfilters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productfilters` (
  `filtersID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `filtervalue` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`filtersID`,`productID`),
  KEY `proid` (`productID`),
  CONSTRAINT `filid` FOREIGN KEY (`filtersID`) REFERENCES `filtersdetails` (`filtersID`),
  CONSTRAINT `proid` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productfilters`
--

LOCK TABLES `productfilters` WRITE;
/*!40000 ALTER TABLE `productfilters` DISABLE KEYS */;
INSERT INTO `productfilters` VALUES (2,1,'Apple'),(2,19,'Apple'),(2,20,'samsung'),(2,21,'Lg'),(3,19,'5'),(3,20,'now'),(3,21,'now'),(4,19,'3'),(4,20,'8GB'),(4,21,'4GB'),(5,19,'1'),(5,20,'Smart'),(5,21,'3D'),(6,1,'16GB'),(6,19,'0'),(6,21,'64GB'),(7,19,'9'),(7,21,'2021'),(8,19,'Apple'),(8,21,'7 inches'),(9,19,'6'),(9,21,'10000aph'),(10,19,'4'),(10,20,'Android'),(10,21,'Android'),(11,19,'i7'),(11,20,'i7'),(11,21,'i3');
/*!40000 ALTER TABLE `productfilters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productphoto`
--

DROP TABLE IF EXISTS `productphoto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productphoto` (
  `photoID` int(11) NOT NULL AUTO_INCREMENT,
  `productID` int(11) NOT NULL,
  `path` varchar(65) DEFAULT NULL,
  PRIMARY KEY (`photoID`),
  KEY `photoproid_idx` (`productID`),
  CONSTRAINT `photoproid` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productphoto`
--

LOCK TABLES `productphoto` WRITE;
/*!40000 ALTER TABLE `productphoto` DISABLE KEYS */;
INSERT INTO `productphoto` VALUES (1,1,'assets/databaseImages/products/885909950652/imgname.jpg'),(9,7,'assets/databaseImages/products/21435/Dark Fantasy1.png'),(10,7,'assets/databaseImages/products/21435/Dark Fantasy2.png'),(11,7,'assets/databaseImages/products/21435/Dark Fantasy3.png'),(12,7,'assets/databaseImages/products/21435/Dark Fantasy4.png'),(20,12,'assets/databaseImages/products/55/brokenmoon.png'),(21,13,'assets/databaseImages/products/222/fantasy2.png'),(22,14,'assets/databaseImages/products/333/minotaur.png'),(26,19,'assets/databaseImages/products/2/minotaur.png'),(27,20,'assets/databaseImages/products/11/minotaur.png'),(28,21,'assets/databaseImages/products/34693857/lg5000.jpg'),(29,21,'assets/databaseImages/products/34693857/MovieMimic.png');
/*!40000 ALTER TABLE `productphoto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `productID` int(11) NOT NULL AUTO_INCREMENT,
  `productCode` varchar(45) NOT NULL,
  `productName` varchar(45) NOT NULL,
  `details` varchar(5001) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `belong` int(11) DEFAULT 0,
  PRIMARY KEY (`productID`),
  UNIQUE KEY `productCode_UNIQUE` (`productCode`),
  KEY `dfdsaf_idx` (`belong`),
  CONSTRAINT `dfdsaf` FOREIGN KEY (`belong`) REFERENCES `categories` (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'885909950652','iPhone 6','iPhone 6 is perfect in every way. Large yet dramatically thin. Powerful but remarkably power efficient. With a smooth metal surface that seamlessly meets the Retina HD display. Its one continuous form where hardware and software function in perfect unison.Developing an iPhone with a larger more advanced display meant pushing the edge of design. From the seamless transition of glass and metal to the streamlined profile every detail was carefully considered to enhance your experience. So while its display is larger iPhone 6 feels just right.It s one thing to make a bigger display. It s something else entirely to make a bigger multitouch display with brilliant colors and higher contrast at even wider viewing angles. But that s exactly about the Retina HD display.Built on 64-bit desktop-class architecture the A8 chip delivers more power even while driving a larger display. The M8 motion coprocessor efficiently gathers data from advanced sensors and a barometer. And with increased battery life iPhone 6 lets you do more for longer than ever.More people take more photos with iPhone than with any other camera. And now the iSight camera has a sensor with Focus Pixels and amazing video features like 1080p HD at 60 fps slo-mo at 240 fps and time-lapse video mode. So you ll have more reasons to capture more moments on video too.iPhone 6 has faster LTE download speeds and it supports more LTE bands than any other smartphone so you can roam in more places. And when connected to Wi-Fi you ll get up to 3x faster speeds.The breakthrough Touch ID technology lets you securely access your iPhone with the perfect password: your fingerprint. This device has been certified by our industry leading software and is 100% fully functional. This device will show some signs of use such as scratches scuffs & nicks on the housing and screen. Wall block and USB cable included. Sim card and earbuds are NOT included.',500.00,3),(7,'21435','tst2','adadadadadad',111.00,2),(12,'55','ww','ww',55.00,4),(13,'222','sss','sssssss',222.00,5),(14,'333','eee','eeeeeee',333.00,3),(19,'2','s','2',2.00,3),(20,'11','ox','11',11.00,3),(21,'34693857','Lg 5000 Tablet','Ena gamato 3D Tablet me skylakia',750.00,3);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchdetails`
--

DROP TABLE IF EXISTS `searchdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchdetails` (
  `searchID` int(11) NOT NULL,
  `productCode` varchar(45) DEFAULT NULL,
  `offerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`searchID`),
  KEY `zdfgsd_idx` (`searchID`),
  KEY `ZFDGDSF_idx` (`productCode`),
  KEY `DFS_idx` (`offerID`),
  CONSTRAINT `ASD` FOREIGN KEY (`searchID`) REFERENCES `searches` (`searchID`),
  CONSTRAINT `DFS` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`),
  CONSTRAINT `ZFDGDSF` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchdetails`
--

LOCK TABLES `searchdetails` WRITE;
/*!40000 ALTER TABLE `searchdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `searchdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searches`
--

DROP TABLE IF EXISTS `searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searches` (
  `searchID` int(11) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `keyWord` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  `IP` varchar(20) NOT NULL,
  PRIMARY KEY (`searchID`),
  KEY `adsgsd_idx` (`email`),
  CONSTRAINT `adsgsd` FOREIGN KEY (`email`) REFERENCES `users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searches`
--

LOCK TABLES `searches` WRITE;
/*!40000 ALTER TABLE `searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `searches` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `group_buy`.`searches_AFTER_INSERT`
AFTER INSERT ON `group_buy`.`searches`
FOR EACH ROW
BEGIN
if (new.email <> null)  then #ΣΥΣΧΕΤΗΣΗ IP & EMAIL ΜΕΤΑ ΤΗΝ ΠΡΩΤΗ ΕΓΓΡΑΦΗ ΑΝΑΖΗΤΗΣΗΣ ΓΙΑ ΤΟΝ ΧΡΗΣΤΗ ΠΟΥ ΕΙΝΑΙ ΣΥΝΔΕΔΕΜΕΝΟΣ
 update searches set email=new.email where ip=new.ip; 
 update dailyResults set email=ne.emai where ip=new.ip;
 end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store` (
  `storeID` int(11) NOT NULL,
  `email` varchar(45) NOT NULL,
  `town` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `addressNum` varchar(45) NOT NULL,
  `phoneNum` varchar(45) NOT NULL,
  PRIMARY KEY (`storeID`),
  UNIQUE KEY `storeID_UNIQUE` (`storeID`),
  KEY `msdbfn_idx` (`email`),
  CONSTRAINT `msdbfn` FOREIGN KEY (`email`) REFERENCES `business` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptions` (
  `level` int(11) NOT NULL,
  `status` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  UNIQUE KEY `email_UNIQUE` (`email`),
  CONSTRAINT `sdfgsd` FOREIGN KEY (`email`) REFERENCES `payments` (`businessEmail`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phoneNum` varchar(45) DEFAULT 'null',
  `userName` varchar(45) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `bankAccount` varchar(45) DEFAULT NULL,
  `balance` decimal(10,0) DEFAULT 0,
  `couponAmount` decimal(10,0) DEFAULT 0,
  `doB` date DEFAULT NULL,
  `town` varchar(45) DEFAULT NULL,
  `verificationCode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (7,'a','a','bly02756@zslsz.com','null','a',1,NULL,0,0,NULL,NULL,'8f4189b0-8d6c-4636-b'),(8,'b','b','b@b.b','b','b',1,'b',1,0,NULL,NULL,'bbbbb');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weeklyresults`
--

DROP TABLE IF EXISTS `weeklyresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weeklyresults` (
  `weeklyID` int(11) NOT NULL AUTO_INCREMENT,
  `offerID` int(11) DEFAULT NULL,
  `productCode` varchar(45) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`weeklyID`),
  UNIQUE KEY `weeklyID_UNIQUE` (`weeklyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weeklyresults`
--

LOCK TABLES `weeklyresults` WRITE;
/*!40000 ALTER TABLE `weeklyresults` DISABLE KEYS */;
/*!40000 ALTER TABLE `weeklyresults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'group_buy'
--

--
-- Dumping routines for database 'group_buy'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `searchInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `searchInsert`(
    IN emailA VARCHAR(45),
    IN ipA VARCHAR(45),
    IN categoryIDA INT,
    IN dateA DATE,
    IN keywordA VARCHAR(45),
    IN productCodeA VARCHAR(45),
    IN offerIDA INT
)
BEGIN
    ## Εισαγωγή δεδομένων στον πίνακα search
    INSERT INTO search (email, ip, categoryID, date, keyword)
    VALUES (emailA, ipA, categoryIDA, dateA, keywordA);
    
    ## Εισαγωγή δεδομένων στον πίνακα searchDetails
    INSERT INTO search_details (productCode, offerID)
    VALUES (productCodeA, offerIDA);
    
##ΚΑΤΑΣΚΕΥΗ ΤΗΣ ΒΑΣΗΣ ΤΟΥ RECOMMENDER SYSTEM

  ## Έλεγχος αν υπάρχει καταχώρηση με το ίδιο email και categoryID στον πίνακα "recommendodds"
    IF EXISTS (SELECT * FROM recommendodds WHERE email = emailA AND categoryID = categoryIDA) THEN
        ## Ενημέρωση της υπάρχουσας καταχώρησης
        UPDATE recommendodds
        SET sum = sum + 1
        WHERE email = emailA AND categoryID = categoryIDA;
    ELSE
		## Εισαγωγή νέας καταχώρησης
        INSERT INTO recommendodds (email, insertDate, categoryID, sum)
        VALUES (emailA, dateA, categoryIDA, 1);
    END IF;

    ## Έλεγχος αν υπάρχει καταχώρηση με το ίδιο email και categoryID στον πίνακα "recommend"
    IF EXISTS (SELECT * FROM recommend WHERE email = emailA AND categoryID = categoryIDA) THEN
        ## Ενημέρωση της υπάρχουσας καταχώρησης
        UPDATE recommend
        SET sum = sum + 1
        WHERE email = emailA AND categoryID = categoryIDA;
    ELSE
        ## Εισαγωγή νέας καταχώρησης
        INSERT INTO recommend (email, categoryID, sum)
        VALUES (emailA, categoryIDA, 1);
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ToggleBusinessProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ToggleBusinessProduct`(IN pCode VARCHAR(45), IN bID INT)
BEGIN
    DECLARE rowCount INT;

    -- Check if a record exists with the given product code and business ID
    SELECT COUNT(*) INTO rowCount FROM businessproducts WHERE productCode = pCode AND businessID = bID;

    IF rowCount = 0 THEN
        -- Insert a new row if no record exists
        INSERT INTO businessproducts (businessID, productCode) VALUES (bID, pCode);
    ELSE
        -- Delete the existing row if a record exists
        DELETE FROM businessproducts WHERE productCode = pCode AND businessID = bID;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ToggleProductWishForUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ToggleProductWishForUser`(IN pCode VARCHAR(45), IN uemail VARCHAR(45))
BEGIN
    DECLARE rowCount INT;

    -- Check if a record exists with the given product code and email ID
    SELECT COUNT(*) INTO rowCount FROM mywish WHERE productCode = pCode AND email = uemail;

    IF rowCount = 0 THEN
        -- Insert a new row if no record exists
        INSERT INTO mywish (email, productCode) VALUES (uemail, pCode);
    ELSE
        -- Delete the existing row if a record exists
        DELETE FROM mywish WHERE productCode = pCode AND email = uemail;
    END IF;
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

-- Dump completed on 2023-06-16 11:25:22

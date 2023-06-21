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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'mygroupbuy8@gmail.com',100.00);
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
  `businessName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `supervisorFirstname` varchar(100) NOT NULL DEFAULT 'null',
  `supervisorLastname` varchar(100) NOT NULL,
  `AFM` varchar(100) DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `IBAN` varchar(100) DEFAULT NULL,
  `pathProfile` varchar(45) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`businessID`),
  UNIQUE KEY `businessID_UNIQUE` (`businessID`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `AFM_UNIQUE` (`AFM`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` VALUES (1,'c','eyx66209@zbock.com','c','c',NULL,0.00,NULL,NULL,1,'9f1f55de-e93b-4cdf-b'),(2,'d','d@d.d','d','d','124567@123.s',0.00,'123@123.s',NULL,1,'7c2f6d88-26f0-4cb7-b'),(4,'c','j+cw8LB9GSUJyBelu/A4mjTmV/nuu4FgX09g5vEJnIg=','ygzkkX7c9J/jOcfD+IPp5A==','ygzkkX7c9J/jOcfD+IPp5A==','ygzkkX7c9J/jOcfD+IPp5A==',0.00,'ygzkkX7c9J/jOcfD+IPp5A==',NULL,1,'7c1317a4-f50d-44d0-8');
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
  PRIMARY KEY (`productCode`,`businessID`),
  KEY `awesidgfasjkgfkasj_idx` (`businessID`),
  KEY `asdkfjbsdjklf_idx` (`productCode`),
  CONSTRAINT `awesidgfasjkgfkasj` FOREIGN KEY (`businessID`) REFERENCES `business` (`businessID`),
  CONSTRAINT `oihbjkbjl` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `businessproducts`
--

LOCK TABLES `businessproducts` WRITE;
/*!40000 ALTER TABLE `businessproducts` DISABLE KEYS */;
INSERT INTO `businessproducts` VALUES (1,'2'),(1,'222'),(1,'34693857'),(1,'55'),(1,'885909950652'),(1,'P002'),(1,'P003'),(1,'P005');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Technology',NULL,NULL,'assets/databaseImages/categories/Technology.jpg'),(2,'Technology','Electronics',NULL,'assets/databaseImages/categories/Mobile.jpg'),(3,'Technology','Electronics','Smartphones','assets/databaseImages/categories/MobilePhones.jpg'),(4,'Technology','Electronics','Laptops','assets/databaseImages/categories/Laptops.jpg'),(5,'House',NULL,NULL,'assets/databaseImages/categories/House.jpg'),(6,'Fashion',NULL,NULL,'assets/databaseImages/categories/Fashion.jpg'),(7,'Technology','Electronics',NULL,'assets/databaseImages/categories/Computers.jpg'),(8,'Technology','Electronics','Cameras','assets/databaseImages/categories/Cameras.png'),(9,'Technology','Electronics','Desktops','assets/databaseImages/categories/Desktops.png'),(10,'Technology','Electronics','E-Readers','assets/databaseImages/categories/E-Readers.png'),(11,'Technology','Electronics','Gaming','assets/databaseImages/categories/Gaming.jpg'),(12,'Technology','Electronics','Headphones','assets/databaseImages/categories/Headphones.png'),(13,'Technology','Electronics','Monitors','assets/databaseImages/categories/Monitors.jpg'),(14,'House','Appliances','Smart Home','assets/databaseImages/categories/SmartHome.jpg'),(15,'Technology','Electronics','Speakers','assets/databaseImages/categories/Speakers.png'),(16,'Technology','Electronics','Tablets','assets/databaseImages/categories/Tablets.jpg'),(17,'Technology','Electronics','Televisions','assets/databaseImages/categories/Televisions.png'),(18,'House','Appliances','Vacuum Cleaners','assets/databaseImages/categories/VacuumCleaners.png'),(19,'Technology','Electronics','Wearables','assets/databaseImages/categories/Wearables.png'),(20,'House','Appliances',NULL,'assets/databaseImages/categories/Appliances.png');
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
  `token` int(11) NOT NULL AUTO_INCREMENT,
  `offerID` int(11) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `ASASD_idx` (`offerID`),
  CONSTRAINT `wkj` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupontokens`
--

LOCK TABLES `coupontokens` WRITE;
/*!40000 ALTER TABLE `coupontokens` DISABLE KEYS */;
INSERT INTO `coupontokens` VALUES (5,3,'asd','0000-00-00 00:00:00'),(6,3,'asdsx','0000-00-00 00:00:00'),(7,3,'asxas','0000-00-00 00:00:00'),(8,3,'asxasx','0000-00-00 00:00:00');
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
INSERT INTO `login` VALUES ('b@b.b','ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb',NULL),('bly02756@zslsz.com','ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb',NULL),('d@d.d','18ac3e7343f016890c510e93f935261169d9e3f565436429830faf0934f4f8e4',NULL),('Dvby8urgJf3dNzDGGk2PJ5RqU7MziG+JG5ymMjILmkM=','ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb',NULL),('eyx66209@zbock.com','2e7d2c03a9507ae265ecf5b5356885a53393a2029d241394997265a1a25aefc6',NULL),('j+cw8LB9GSUJyBelu/A4mjTmV/nuu4FgX09g5vEJnIg=','2e7d2c03a9507ae265ecf5b5356885a53393a2029d241394997265a1a25aefc6',NULL),('mygroupbuy8@gmail.com','6r00pBuy$phy',NULL),('povemo6290@aaorsi.com','043a718774c572bd8a25adbeb1bfcd5c0256ae11cecf9f9c3f925d0e52beaf89',NULL);
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
  `email` varchar(100) NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `fghdfgb_idx` (`productCode`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mywish`
--

LOCK TABLES `mywish` WRITE;
/*!40000 ALTER TABLE `mywish` DISABLE KEYS */;
INSERT INTO `mywish` VALUES ('2','bly02756@zslsz.com',1),('21435','bly02756@zslsz.com',2),('21435','povemo6290@aaorsi.com',3),('222','bly02756@zslsz.com',4),('333','bly02756@zslsz.com',5),('333','povemo6290@aaorsi.com',6),('34693857','povemo6290@aaorsi.com',7),('55','bly02756@zslsz.com',8),('55','povemo6290@aaorsi.com',9),('885909950652','b@b.b',10),('885909950652','bly02756@zslsz.com',11),('885909950652','povemo6290@aaorsi.com',12),('P008','bly02756@zslsz.com',13);
/*!40000 ALTER TABLE `mywish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `notificationID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `details` varchar(45) DEFAULT NULL,
  `productCode` varchar(45) DEFAULT NULL,
  `offerID` int(11) DEFAULT NULL,
  `notificationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`notificationID`),
  KEY `SDFHGH_idx` (`productCode`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'testnotify','dddddd','2',NULL,'2023-06-16 08:59:00'),(2,'testoffnotify','asdasdasd','2',1,'2023-06-06 00:00:00'),(3,'asd','asd','2',1,'2023-06-06 00:00:00'),(4,'New Offer','offerdetails','55',3,'2023-06-17 00:00:00'),(5,'New Offer','offerdetails','333',3,'2023-06-17 00:00:00'),(6,'New Offer','offerdetails','2',3,'2023-06-17 00:00:00'),(7,'New Offer','offerdetails','34693857',3,'2023-06-17 00:00:00'),(8,'New User joined Offer',NULL,NULL,3,'2023-06-20 00:00:00'),(9,'New User joined Offer',NULL,NULL,2,'2023-06-21 08:00:00'),(10,'New User joined Offer',NULL,NULL,3,'2023-06-21 08:59:00'),(11,'New User joined Offer',NULL,NULL,3,'2023-06-21 09:00:40');
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
INSERT INTO `offerdetails` VALUES (1,'222'),(1,'55'),(2,'222'),(2,'55'),(3,'2'),(3,'333'),(3,'34693857'),(3,'55');
/*!40000 ALTER TABLE `offerdetails` ENABLE KEYS */;
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
  `details` varchar(45) NOT NULL,
  `groupSize` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 1,
  `path` varchar(400) NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`offerID`),
  UNIQUE KEY `offerID_UNIQUE` (`offerID`),
  KEY `offerbusinessmail_idx` (`email`),
  CONSTRAINT `offerbusinessmail` FOREIGN KEY (`email`) REFERENCES `business` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES (1,'Moon and Castle',1000.00,20.00,10.00,'2023-07-17 00:00:00','2 products offer',20,'eyx66209@zbock.com',1,'assets/databaseImages/offers/c/5388487/Screenshot_6.png',NULL),(2,'Moon and Castle',1000.00,20.00,10.00,'2023-07-17 00:00:00','2 products offer',20,'eyx66209@zbock.com',1,'assets/databaseImages/offers/c/9273604/Screenshot_6.png',NULL),(3,'notifyOffer',555.00,5.00,55.00,'2023-06-23 00:00:00','offerdetails',5,'eyx66209@zbock.com',1,'assets/databaseImages/offers/c/5536108/received_720008266262552.jpg',NULL),(5,'test',3.00,3.00,3.00,'0000-00-00 00:00:00','asd',5,'d@d.d',1,'asd',NULL);
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
  `accountEmail` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `details` varchar(200) DEFAULT NULL,
  `date` datetime NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `offerId` int(11) DEFAULT NULL,
  `paypalPaymentId` varchar(255) DEFAULT NULL,
  `paypalSaleId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`paymentID`),
  UNIQUE KEY `paymentID_UNIQUE` (`paymentID`),
  KEY `dfgsdfg_idx` (`accountEmail`),
  CONSTRAINT `paymentEmail` FOREIGN KEY (`accountEmail`) REFERENCES `login` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (4,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 12:01:13','Payout','pending',NULL,NULL,NULL),(5,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 12:06:42','Payout','pending',NULL,NULL,NULL),(6,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 12:08:45','Payout','pending',NULL,NULL,NULL),(7,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 12:11:20','Payout','pending',NULL,NULL,NULL),(8,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 12:22:31','Payout','completed',NULL,NULL,NULL),(9,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 12:35:40','Payout','completed',0,NULL,NULL),(10,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 20:16:05','Payout','pending',0,NULL,NULL),(11,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 21:03:33','Payout','completed',0,NULL,NULL),(12,'bly02756@zslsz.com',10.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 21:09:07','Payout','pending',2,NULL,NULL),(13,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 21:09:57','Payout','completed',3,NULL,NULL),(14,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 23:21:59','Payout','pending',3,NULL,NULL),(15,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-20 23:52:27','Payout','completed',3,NULL,NULL),(16,'bly02756@zslsz.com',10.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-21 00:21:02','Payout','completed',2,NULL,NULL),(17,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-21 08:53:49','Payout','completed',3,NULL,NULL),(18,'bly02756@zslsz.com',55.00,'details about transaction. eg Fee for offer x.OR full price for offer x etc','2023-06-21 09:00:27','Payout','completed',3,NULL,NULL);
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
    /*IF (NEW.level IS NOT NULL) THEN
        UPDATE subscriptions SET level = NEW.level WHERE email = NEW.business.email;
        UPDATE business SET balance = balance - NEW.amount;
        UPDATE admin SET balance = balance + NEW.amount;
    END IF;

    /* ΜΕΤΑ ΤΗΝ ΕΚΤΕΛΕΣΗ ΤΗΣ ΠΛΗΡΩΜΗΣ, ΜΕΤΑΒΑΛΩ ΚΑΙ ΤΟ ΣΥΝΟΛΙΚΟ ΥΠΟΛΟΙΠΟ ΤΗΣ ΕΠΙΧΕΙΡΗΣΗ */
    /*IF (NEW.businessEmail IS NULL) THEN
        IF (NEW.InOut = 'in') THEN
            UPDATE user SET balance = balance + NEW.amount;
        ELSEIF (NEW.InOut = 'out') THEN
            UPDATE user SET balance = balance - NEW.amount;
        END IF;
    END IF;

    /* ΜΕΤΑ ΤΗΝ ΕΚΤΕΛΕΣΗ ΤΗΣ ΠΛΗΡΩΜΗΣ, ΜΕΤΑΒΑΛΩ ΚΑΙ ΤΟ ΣΥΝΟΛΙΚΟ ΥΠΟΛΟΙΠΟ ΤΟΥ ΧΡΗΣΤΗ */
    /*IF (NEW.userEmail IS NULL) THEN
        IF (NEW.InOut = 'in') THEN
            UPDATE business SET balance = balance + NEW.amount;
        ELSEIF (NEW.InOut = 'out') THEN
            UPDATE business SET balance = balance - NEW.amount;
        END IF;
    END IF; */
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
  CONSTRAINT `filid` FOREIGN KEY (`filtersID`) REFERENCES `filtersdetails` (`filtersID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `proid` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productfilters`
--

LOCK TABLES `productfilters` WRITE;
/*!40000 ALTER TABLE `productfilters` DISABLE KEYS */;
INSERT INTO `productfilters` VALUES (2,1,'Apple'),(2,19,'Apple'),(2,21,'Lg'),(2,22,'Apple'),(2,24,'Samsung'),(2,25,'Sony'),(2,26,'LG'),(2,27,'Google'),(2,28,'Microsoft'),(2,29,'HP'),(2,30,'Dell'),(2,31,'Lenovo'),(2,32,'Asus'),(2,33,'Acer'),(2,34,'Toshiba'),(2,35,'Canon'),(2,36,'Nikon'),(2,37,'Sony'),(2,38,'Bose'),(2,39,'Beats'),(2,40,'JBL'),(2,41,'LG'),(2,42,'Samsung'),(2,43,'Apple'),(2,44,'Google'),(2,45,'Microsoft'),(2,46,'HP'),(2,47,'Dell'),(2,48,'Lenovo'),(2,49,'Asus'),(2,50,'Acer'),(2,51,'Toshiba'),(2,52,'Canon'),(3,19,'5'),(3,21,'now'),(3,42,'4GB'),(3,43,'8GB'),(3,44,'8GB'),(3,45,'Water-resistant, Built-in microphone'),(3,46,'8GB'),(3,47,'4GB'),(4,19,'3'),(4,21,'4GB'),(4,42,'Face ID, A14 Bionic chip'),(5,19,'1'),(5,21,'3D'),(5,22,'45-megapixel sensor, 8K video recording'),(5,24,'5K video, HyperSmooth 3.0 stabilization'),(5,25,'45.7-megapixel sensor, 4K video recording'),(5,26,'24.2-megapixel sensor, 4K video recording'),(5,27,'8GB'),(5,28,'Built-in light, Weeks-long battery life'),(5,29,'8K graphics support, DualSense controller'),(5,31,'4K gaming, Ray tracing'),(5,32,'Active noise cancellation, Voice assistant su'),(5,33,'Adaptive Sound Control, Ambient Sound mode'),(5,34,'Digital noise cancellation, Quick Attention m'),(5,35,'Adaptive Sound Control, Ambient Sound mode'),(5,36,'16GB'),(5,37,'16GB'),(5,38,'16GB'),(5,39,'IPS panel, HDR10 support'),(5,40,'Voice control, Smart home integration'),(5,41,'Voice control, Multi-room audio'),(5,43,'Triple camera setup, 5G support'),(5,44,'Dual rear cameras, Night Sight'),(5,48,'Quantum Dot technology, HDR10+ support'),(5,49,'Self-lit pixels, Dolby Vision IQ'),(5,50,'LCD screen, Intelligent suction'),(5,51,'Heart rate monitor, Built-in GPS'),(5,52,'Built-in GPS, Heart rate monitor'),(6,1,'16GB'),(6,19,'0'),(6,21,'64GB'),(6,27,'512GB SSD'),(6,29,'825GB SSD'),(6,36,'512GB SSD'),(6,37,'512GB SSD'),(6,38,'512GB SSD'),(6,42,'64GB'),(6,43,'128GB'),(6,44,'128GB'),(6,46,'256GB SSD'),(6,47,'64GB'),(7,19,'9'),(7,21,'2021'),(7,22,'2020'),(7,24,'2020'),(7,25,'2017'),(7,26,'2018'),(7,27,'2020'),(7,28,'2018'),(7,29,'2020'),(7,30,'2017'),(7,36,'2020'),(7,37,'2020'),(7,38,'2021'),(7,39,'2021'),(7,42,'2020'),(7,43,'2021'),(7,44,'2022'),(7,46,'2019'),(7,47,'2020'),(7,48,'2021'),(7,49,'2021'),(8,19,'Apple'),(8,21,'7 inches'),(8,27,'27 inches'),(8,28,'6 inches'),(8,36,'13.3 inches'),(8,37,'13.4 inches'),(8,38,'13.3 inches'),(8,42,'6.1 inches'),(8,43,'6.2 inches'),(8,44,'6.4 inches'),(8,46,'12.3 inches'),(8,47,'10.9 inches'),(8,48,'55 inches'),(8,49,'65 inches'),(9,19,'6'),(9,21,'10000aph'),(9,22,'LP-E6NH rechargeable lithium-ion battery'),(9,24,'Rechargeable 1720mAh lithium-ion battery'),(9,25,'EN-EL15a rechargeable lithium-ion battery'),(9,26,'NP-FZ100 rechargeable lithium-ion battery'),(9,36,'Built-in 58.2-watt-hour lithium-polymer batte'),(9,37,'4-cell 52Whr battery'),(9,38,'4-cell, 67Wh Li-ion polymer battery'),(9,42,'Non-removable Li-Ion 2815 mAh battery'),(9,43,'Non-removable Li-Ion 4000 mAh battery'),(9,44,'Non-removable Li-Po 4680 mAh battery'),(9,46,'Up to 10.5 hours of typical device usage'),(9,47,'Built-in 28.6-watt-hour rechargeable lithium-'),(10,19,'4'),(10,21,'Android'),(10,27,'macOS'),(10,36,'macOS'),(10,37,'Windows'),(10,38,'Windows'),(10,42,'iOS'),(10,43,'Android'),(10,44,'Android'),(10,46,'Windows'),(10,47,'iPadOS'),(11,19,'i7'),(11,21,'i3'),(11,22,'DIGIC X Image Processor'),(11,27,'8-core 10th Gen Intel Core i7'),(11,29,'Custom AMD Zen 2'),(11,31,'Custom AMD Zen 2'),(11,36,'Quad-core Intel Core i5'),(11,37,'Quad-core 10th Gen Intel Core i7'),(11,38,'Quad-core 11th Gen Intel Core i7'),(11,42,'Hexa-core'),(11,43,'Octa-core'),(11,44,'Octa-core'),(11,46,'Quad-core 10th Gen Intel Core i5'),(11,47,'Hexa-core Apple A14 Bionic');
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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productphoto`
--

LOCK TABLES `productphoto` WRITE;
/*!40000 ALTER TABLE `productphoto` DISABLE KEYS */;
INSERT INTO `productphoto` VALUES (1,1,'assets/databaseImages/products/885909950652/imgname.jpg'),(9,7,'assets/databaseImages/products/21435/Dark Fantasy1.png'),(10,7,'assets/databaseImages/products/21435/Dark Fantasy2.png'),(11,7,'assets/databaseImages/products/21435/Dark Fantasy3.png'),(12,7,'assets/databaseImages/products/21435/Dark Fantasy4.png'),(20,12,'assets/databaseImages/products/55/brokenmoon.png'),(21,13,'assets/databaseImages/products/222/fantasy2.png'),(22,14,'assets/databaseImages/products/333/minotaur.png'),(26,19,'assets/databaseImages/products/2/minotaur.png'),(28,21,'assets/databaseImages/products/34693857/lg5000.jpg'),(29,21,'assets/databaseImages/products/34693857/MovieMimic.png'),(30,22,'assets/databaseImages/products/P001/r5.jpeg'),(31,22,'assets/databaseImages/products/P001/rr.jpg'),(32,24,'assets/databaseImages/products/P002/218153-b.jpg'),(33,24,'assets/databaseImages/products/P002/gopro-hero9-black.webp'),(34,25,'assets/databaseImages/products/P003/81WtQ64-SOL.jpg'),(35,25,'assets/databaseImages/products/P003/download.jpg'),(36,26,'assets/databaseImages/products/P004/download.jpg'),(37,26,'assets/databaseImages/products/P004/xlarge.jpg'),(38,27,'assets/databaseImages/products/P005/a.jpg'),(39,28,'assets/databaseImages/products/P006/asd.jpeg'),(40,28,'assets/databaseImages/products/P006/blue.jpeg'),(41,29,'assets/databaseImages/products/P007/ps.jpeg'),(42,29,'assets/databaseImages/products/P007/pss.jpg'),(43,30,'assets/databaseImages/products/P008/download.jpg'),(45,31,'assets/databaseImages/products/P009/xbx.jpeg'),(46,32,'assets/databaseImages/products/P010/b.jpeg'),(47,32,'assets/databaseImages/products/P010/s.jpeg'),(49,33,'assets/databaseImages/products/P011/w.jpg'),(50,34,'assets/databaseImages/products/P012/b.jpg'),(51,35,'assets/databaseImages/products/P013/w.jpg'),(52,36,'assets/databaseImages/products/P014/appl.jpg'),(53,36,'assets/databaseImages/products/P014/mb.jpg'),(54,37,'assets/databaseImages/products/P015/download.jpg'),(55,38,'assets/databaseImages/products/P016/16.jpg'),(56,39,'assets/databaseImages/products/P017/17.jpg'),(58,40,'assets/databaseImages/products/P018/18.jpeg'),(59,40,'assets/databaseImages/products/P018/18.jpg'),(60,41,'assets/databaseImages/products/P019/19.jpg'),(61,41,'assets/databaseImages/products/P019/19j.jpg'),(62,42,'assets/databaseImages/products/P020/20.jpg'),(63,43,'assets/databaseImages/products/P021/21.jpeg'),(64,44,'assets/databaseImages/products/P022/22.jpeg'),(65,45,'assets/databaseImages/products/P023/23.jpg'),(66,46,'assets/databaseImages/products/P024/24.jpg'),(67,47,'assets/databaseImages/products/P025/25.jpg'),(68,48,'assets/databaseImages/products/P026/26.jpeg'),(69,49,'assets/databaseImages/products/P027/27.jpg'),(70,50,'assets/databaseImages/products/P028/28.jpg'),(71,51,'assets/databaseImages/products/P029/29.jpg'),(72,52,'assets/databaseImages/products/P030/30.jpg');
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
  `active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`productID`),
  UNIQUE KEY `productCode_UNIQUE` (`productCode`),
  KEY `dfdsaf_idx` (`belong`),
  CONSTRAINT `dfdsaf` FOREIGN KEY (`belong`) REFERENCES `categories` (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'885909950652','iPhone 6','iPhone 6 is perfect in every way. Large yet dramatically thin. Powerful but remarkably power efficient. With a smooth metal surface that seamlessly meets the Retina HD display. Its one continuous form where hardware and software function in perfect unison.Developing an iPhone with a larger more advanced display meant pushing the edge of design. From the seamless transition of glass and metal to the streamlined profile every detail was carefully considered to enhance your experience. So while its display is larger iPhone 6 feels just right.It s one thing to make a bigger display. It s something else entirely to make a bigger multitouch display with brilliant colors and higher contrast at even wider viewing angles. But that s exactly about the Retina HD display.Built on 64-bit desktop-class architecture the A8 chip delivers more power even while driving a larger display. The M8 motion coprocessor efficiently gathers data from advanced sensors and a barometer. And with increased battery life iPhone 6 lets you do more for longer than ever.More people take more photos with iPhone than with any other camera. And now the iSight camera has a sensor with Focus Pixels and amazing video features like 1080p HD at 60 fps slo-mo at 240 fps and time-lapse video mode. So you ll have more reasons to capture more moments on video too.iPhone 6 has faster LTE download speeds and it supports more LTE bands than any other smartphone so you can roam in more places. And when connected to Wi-Fi you ll get up to 3x faster speeds.The breakthrough Touch ID technology lets you securely access your iPhone with the perfect password: your fingerprint. This device has been certified by our industry leading software and is 100% fully functional. This device will show some signs of use such as scratches scuffs & nicks on the housing and screen. Wall block and USB cable included. Sim card and earbuds are NOT included.',500.00,3,1),(7,'21435','tst2','adadadadadad',111.00,2,1),(12,'55','ww','ww',55.00,4,1),(13,'222','sss','sssssss',222.00,5,1),(14,'333','eee','eeeeeee',333.00,3,1),(19,'2','s','2',2.00,3,1),(21,'34693857','Lg 5000 Tablet','Ena gamato 3D Tablet me skylakia',750.00,3,1),(22,'P001','Canon EOS R5','A professional-grade mirrorless camera with outstanding image quality.',3899.99,8,1),(24,'P002','GoPro Hero 9 Black','A high-performance action camera for capturing adventures.',449.99,8,1),(25,'P003','Nikon D850 DSLR Camera','A professional-grade DSLR camera with high-resolution capabilities.',2999.99,8,1),(26,'P004','Sony A7 III Mirrorless Camera','A versatile mirrorless camera with impressive image quality and performance.',1999.99,8,1),(27,'P005','Apple iMac (2020)','A sleek all-in-one desktop computer with a stunning Retina display.',1799.99,9,1),(28,'P006','Amazon Kindle Paperwhite','A waterproof e-reader with a high-resolution display for comfortable reading.',129.99,10,1),(29,'P007','Sony PlayStation 5','The next-generation gaming console with impressive graphics and performance.',499.99,11,1),(30,'P008','Nintendo Switch','A hybrid gaming console for gaming on-the-go or at home.',299.99,11,1),(31,'P009','Microsoft Xbox Series X','The latest Xbox gaming console with next-gen graphics and performance.',499.99,11,1),(32,'P010','Bose QuietComfort 35 II Headphones','Wireless noise-canceling headphones for immersive audio experience.',299.99,12,1),(33,'P011','Sony WH-1000XM4 Wireless Headphones','Premium wireless headphones with industry-leading noise cancellation.',349.99,12,1),(34,'P012','Sony WH-1000XM3 Wireless Headphones','High-quality wireless headphones with noise-canceling technology.',279.99,12,1),(35,'P013','Sony WH-1000XM4 Wireless Headphones','Premium wireless headphones with industry-leading noise cancellation.',349.99,12,1),(36,'P014','Apple MacBook Pro','A high-performance laptop for professionals and creatives.',1499.99,4,1),(37,'P015','Dell XPS 13','A premium ultrabook with a stunning display and sleek design.',1199.99,4,1),(38,'P016','HP Spectre x360','A premium convertible laptop with a sleek design and excellent performance.',1399.99,4,1),(39,'P017','LG 27-inch 4K Monitor','A high-resolution monitor for crisp visuals and precise color reproduction.',399.99,13,1),(40,'P018','Amazon Echo Dot (4th Gen)','A compact smart speaker with Alexa voice assistant.',49.99,14,1),(41,'P019','Sonos One (Gen 2) Smart Speaker','A compact smart speaker with premium sound quality.',199.99,14,1),(42,'P020','iPhone 12','The latest iPhone model with advanced features.',999.99,3,1),(43,'P021','Samsung Galaxy S21','A powerful Android smartphone with a stunning display.',899.99,3,1),(44,'P022','Google Pixel 6','The latest Google Pixel smartphone with advanced camera features.',699.99,3,1),(45,'P023','Bose SoundLink Revolve+ Bluetooth Speaker','A portable Bluetooth speaker with 360-degree sound and long battery life.',299.99,15,1),(46,'P024','Microsoft Surface Pro 7','A versatile tablet and laptop hybrid with powerful performance.',899.99,16,1),(47,'P025','Apple iPad Air (4th Gen)','A powerful and versatile tablet for productivity and entertainment.',599.99,16,1),(48,'P026','Samsung 55-inch QLED TV','An ultra-high-definition QLED TV with vibrant colors and immersive viewing experience.',1499.99,17,1),(49,'P027','LG 65-inch OLED TV','An OLED TV with stunning picture quality and deep blacks.',2499.99,17,1),(50,'P028','Dyson V11 Absolute Vacuum Cleaner','A powerful cordless vacuum cleaner with advanced filtration system.',699.99,18,1),(51,'P029','Fitbit Versa 3 Smartwatch','A versatile smartwatch with fitness tracking capabilities.',229.99,19,1),(52,'P030','Samsung Galaxy Watch 4','A feature-packed smartwatch with fitness tracking and health monitoring.',249.99,19,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `readnotifications`
--

DROP TABLE IF EXISTS `readnotifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `readnotifications` (
  `email` varchar(100) NOT NULL,
  `notificationID` int(11) NOT NULL,
  PRIMARY KEY (`email`,`notificationID`),
  KEY `notifID_idx` (`notificationID`),
  CONSTRAINT `notifID` FOREIGN KEY (`notificationID`) REFERENCES `notifications` (`notificationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `umailnotif` FOREIGN KEY (`email`) REFERENCES `login` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `readnotifications`
--

LOCK TABLES `readnotifications` WRITE;
/*!40000 ALTER TABLE `readnotifications` DISABLE KEYS */;
INSERT INTO `readnotifications` VALUES ('bly02756@zslsz.com',1),('bly02756@zslsz.com',2),('bly02756@zslsz.com',5),('bly02756@zslsz.com',6),('eyx66209@zbock.com',4),('eyx66209@zbock.com',5),('eyx66209@zbock.com',7),('eyx66209@zbock.com',8),('eyx66209@zbock.com',9),('povemo6290@aaorsi.com',5),('povemo6290@aaorsi.com',7);
/*!40000 ALTER TABLE `readnotifications` ENABLE KEYS */;
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
  `email` varchar(100) NOT NULL,
  `keyWord` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  `IP` varchar(20) NOT NULL,
  PRIMARY KEY (`searchID`)
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
  `email` varchar(100) NOT NULL,
  `town` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `addressNum` varchar(45) NOT NULL,
  `phoneNum` varchar(45) NOT NULL,
  PRIMARY KEY (`storeID`),
  UNIQUE KEY `storeID_UNIQUE` (`storeID`),
  KEY `storebusinessmail_idx` (`email`),
  CONSTRAINT `storebusinessmail` FOREIGN KEY (`email`) REFERENCES `business` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
  `email` varchar(100) NOT NULL
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
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phoneNum` varchar(45) DEFAULT 'null',
  `userName` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `bankAccount` varchar(100) DEFAULT NULL,
  `balance` decimal(10,0) DEFAULT 0,
  `couponAmount` decimal(10,0) DEFAULT 0,
  `doB` date DEFAULT NULL,
  `town` varchar(45) DEFAULT NULL,
  `verificationCode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (7,'a','a','bly02756@zslsz.com','null','a',1,NULL,123,NULL,NULL,NULL,'8f4189b0-8d6c-4636-b'),(8,'b','b','b@b.b','b','b',1,'b',1,0,NULL,NULL,'bbbbb'),(9,'s','s','povemo6290@aaorsi.com','null','s',1,NULL,NULL,NULL,NULL,NULL,'0a4f980f-b09f-4efb-a'),(12,'MsFuBcrnJ2EPtKSoXeo4gw==','MsFuBcrnJ2EPtKSoXeo4gw==','Dvby8urgJf3dNzDGGk2PJ5RqU7MziG+JG5ymMjILmkM=','null','MsFuBcrnJ2EPtKSoXeo4gw==',1,NULL,0,0,NULL,NULL,'963f269e-9388-47b9-b');
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

-- Dump completed on 2023-06-21 22:28:55

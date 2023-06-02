-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: group_buy
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `userBalance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `businessBalance` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business` (
  `businessID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `supervisorFirstname` varchar(45) NOT NULL DEFAULT 'null',
  `supervisorLastname` varchar(45) DEFAULT NULL,
  `AFM` varchar(45) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `IBAN` varchar(45) NOT NULL,
  `pathProfile` varchar(45) DEFAULT NULL,
  `delete` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`businessID`),
  UNIQUE KEY `businessID_UNIQUE` (`businessID`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `AFM_UNIQUE` (`AFM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `businessphoto`
--

DROP TABLE IF EXISTS `businessphoto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `businessphoto` (
  `photoid` int NOT NULL,
  `businessID` int NOT NULL,
  `path` varchar(45) NOT NULL,
  PRIMARY KEY (`photoid`),
  KEY `srtfhsr_idx` (`businessID`),
  CONSTRAINT `srtfhsr` FOREIGN KEY (`businessID`) REFERENCES `business` (`businessID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `businessproducts` (
  `businessID` int NOT NULL,
  `productCode` varchar(45) NOT NULL,
  KEY `awesidgfasjkgfkasj_idx` (`businessID`),
  KEY `asdkfjbsdjklf_idx` (`productCode`),
  CONSTRAINT `awesidgfasjkgfkasj` FOREIGN KEY (`businessID`) REFERENCES `business` (`businessID`),
  CONSTRAINT `oihbjkbjl` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `businessproducts`
--

LOCK TABLES `businessproducts` WRITE;
/*!40000 ALTER TABLE `businessproducts` DISABLE KEYS */;
/*!40000 ALTER TABLE `businessproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `categoryID` int NOT NULL AUTO_INCREMENT,
  `genCategory` varchar(45) NOT NULL,
  `category` varchar(45) DEFAULT NULL,
  `subCategory` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `categoryID_UNIQUE` (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (9,'Τεχνολογία',NULL,NULL),(10,'Σπίτι-Κήπος',NULL,NULL),(11,'Μόδα',NULL,NULL),(12,'Hobby',NULL,NULL),(13,'Υγεία',NULL,NULL),(14,'Ομορφιά',NULL,NULL),(15,'Παιδικά-Βρεφικά',NULL,NULL),(16,'Αυτοκίνητο',NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupontokens`
--

DROP TABLE IF EXISTS `coupontokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupontokens` (
  `token` varchar(45) NOT NULL,
  `offerID` int NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `date` date DEFAULT NULL,
  KEY `ASASD_idx` (`offerID`),
  CONSTRAINT `wkj` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `coupontokens_AFTER_UPDATE` AFTER UPDATE ON `coupontokens` FOR EACH ROW BEGIN
		DECLARE price DECIMAL(10,2);
		DECLARE o_email VARCHAR(45);
        DECLARE offer_id int;
        
    /* ΜΕΤΑΦΟΡΑ ΧΡΗΜΑΤΩΝ ΜΕ ΤΟ ΚΛΕΙΣΙΜΟ ΤΗΣ ΟΜΑΔΑΣ
    όταν προστήθεται ημερομηνία στον πίνακα σημαίνει ότι έχει εκτελεστεί ο trigger στο πίνακα  προσφορών εκτελειται και η μεταφορά των χρημάτων από τον user στην επιχείρηση)*/   

    IF date=new.date THEN /*(όταν προστήθεται ημερομηνία στον πίνακα σημαίνει ότι έχει εκτελεστεί ο trigger στο πίνακα offers)   */
    
		SELECT couponPrice INTO price FROM offers WHERE offerID = (SELECT offerID FROM coupontokens WHERE date = NEW.date);
		SELECT email INTO o_email FROM offers WHERE date = NEW.date;
    
		UPDATE business SET balance = balance - price WHERE email = (SELECT b.email FROM business b
        INNER JOIN offers o ON o.businessID = b.businessID
        INNER JOIN coupontokens c ON c.offerID = o.offerID
        WHERE c.email = o_email);
		
        UPDATE users SET couponAmount = couponAmount - price where email=o_email;

END IF;
/* ΚΛΕΙΣΙΜΟ ΤΗΣ ΟΜΑΔΑΣ ΟΤΑΝ ΣΥΜΠΛΗΡΩΝΕΤΑΙ ΚΑΙ ΤΟΤΕΛΕΥΤΑΙΟ ΚΟΥΠΟΝΙ
    όταν προστήθεται ΚΑΙ ΤΟ ΤΕΛΕΥΤΑΙΟ email στον πίνακα coupontokens σημαίνει ότι h ομάδα έχει συμπληρωθεί άρα η ομάδα πρέπει να γίνει deactivate εκτεέιται και η μεταφορά των χρημάτων από τον user στην επιχείρηση)
    */   
IF email=new.email then
	SELECT offerID INTO offer_id FROM offers WHERE email = NEW.email;
    
	if ((select count(email) from coupontoken where offerID=offer_id)=(select groupSize from offers where offerID=offer_id)) then
	update offers set active=0 where offerID=offer_id;
    End if;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `coupontokens_BEFORE_DELETE` BEFORE DELETE ON `coupontokens` FOR EACH ROW BEGIN
/*ΟΤΑΝ ΔΙΑΓΡΑΦΕΤΑΙ ΤΟ ΚΟΥΠΟΝΙ ΠΡΕΠΕΙ ΝΑ ΕΠΙΣΤΡΑΦΟΥΝ ΤΑ ΧΡΗΜΑΤΑ ΣΤΟΥΣ USER*/
declare price DECIMAL(10,2);
select couponPrice INTO price FROM offers where offerID=old.offerID;
DELETE FROM coupontokens where offerID=old.offerID ORDER BY DATE DESC;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `filters`
--

DROP TABLE IF EXISTS `filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filters` (
  `filtersID` int NOT NULL AUTO_INCREMENT,
  `categoryID` int NOT NULL,
  `filtersName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`filtersID`),
  KEY `gfwef_idx` (`categoryID`),
  CONSTRAINT `gfwef` FOREIGN KEY (`categoryID`) REFERENCES `categories` (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filters`
--

LOCK TABLES `filters` WRITE;
/*!40000 ALTER TABLE `filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filtersdetails`
--

DROP TABLE IF EXISTS `filtersdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filtersdetails` (
  `filtersID` int NOT NULL,
  `value` varchar(45) DEFAULT NULL,
  KEY `ertwert_idx` (`filtersID`),
  CONSTRAINT `ertwert` FOREIGN KEY (`filtersID`) REFERENCES `filters` (`filtersID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filtersdetails`
--

LOCK TABLES `filtersdetails` WRITE;
/*!40000 ALTER TABLE `filtersdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `filtersdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  CONSTRAINT `asfkgahskd` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
  CONSTRAINT `cxasdas` FOREIGN KEY (`email`) REFERENCES `business` (`email`),
  CONSTRAINT `ojhkvb` FOREIGN KEY (`email`) REFERENCES `admin` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mywish`
--

DROP TABLE IF EXISTS `mywish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mywish` (
  `productCode` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `offerID` int DEFAULT NULL,
  KEY `fghdfgb_idx` (`productCode`),
  KEY `alkdsbfn_idx` (`email`),
  KEY `ERF_idx` (`offerID`),
  CONSTRAINT `alkdsbfn` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
  CONSTRAINT `ERF` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`),
  CONSTRAINT `jhcgvhj` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mywish`
--

LOCK TABLES `mywish` WRITE;
/*!40000 ALTER TABLE `mywish` DISABLE KEYS */;
/*!40000 ALTER TABLE `mywish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `productCode` varchar(45) NOT NULL,
  `seen` tinyint NOT NULL,
  `offerID` int NOT NULL,
  KEY `asfasf_idx` (`offerID`),
  KEY `SDFHGH_idx` (`productCode`),
  CONSTRAINT `asfasf` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`),
  CONSTRAINT `SDFHGH` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offerdetails` (
  `offerID` int NOT NULL,
  `productCode` varchar(45) NOT NULL,
  KEY `FASDFAS_idx` (`offerID`),
  KEY `aSEKNDLF_idx` (`productCode`),
  CONSTRAINT `aSEKNDLF` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`),
  CONSTRAINT `FASDFAS` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offerphoto` (
  `offerID` int NOT NULL,
  `path` varchar(45) NOT NULL,
  KEY `sdafa_idx` (`offerID`),
  CONSTRAINT `sdafa` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `offerID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `finalPrice` decimal(10,2) NOT NULL,
  `descount` decimal(10,2) NOT NULL,
  `couponPrice` decimal(10,2) NOT NULL,
  `offerExpire` datetime NOT NULL,
  `couponExpire` int NOT NULL,
  `details` varchar(45) NOT NULL,
  `groupSize` int NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`offerID`),
  UNIQUE KEY `offerID_UNIQUE` (`offerID`),
  KEY `ajksbdfh_idx` (`email`),
  CONSTRAINT `ajksbdfh` FOREIGN KEY (`email`) REFERENCES `business` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `offers_BEFORE_UPDATE` BEFORE UPDATE ON `offers` FOR EACH ROW BEGIN
/* ΟΤΑΝ Η ΕΤΑΙΡΙΑ ΚΛΕΙΣΕΙ ΤΗΝ ΟΜΑΔΑ ΠΡΟΚΕΙΜΕΝΟΥ ΝΑ ΕΚΤΕΛΕΣΕΙ ΤΙΣ ΣΥΝΑΛΛΑΓΕΣ */
IF new.active=0 THEN
        update offer set groupsize = (select count(*) from coupontokens 
        where offerID=(select offerID from offers where active=new.active)) 
        where active=new.active;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `offers_AFTER_UPDATE` AFTER UPDATE ON `offers` FOR EACH ROW BEGIN
declare current_size int;
declare dif int;

IF new.active=0 THEN
        update coupontokens set date = current_date() where offerID= (select offerID from offers where active=new.active); 
END IF;

/*ΕΚΤΕΛΕΣΗ ΤΩΝ ΣΥΝΑΛΛΑΓΩΝ ΜΟΛΙΣ ΚΑΙ ΑΠΟΡΗΨΗ ΤΩΝ ΤΕΛΕΥΤΑΙΩΝ ΟΤΑΝ Η ΕΠΙΧΕΙΡΗΣΗ ΑΛΛΑΞΗ ΤΟ ΜΕΓΕΘΟΣ ΤΗΣ ΟΜΑΔΑΣ ΚΑΙ ΑΥΤΟ ΕΙΝΑΙ ΜΙΚΡΟΤΕΡΟ ΤΩΝ ΣΥΜΜΕΤΟΧΩΝ
ΕΚΕΙ ΕΠΙΣΤΡΕΦΟΝΤΑΙ ΤΑ ΧΡΗΜΑΤΑ ΣΤΟΥΣ ΠΕΛΑΤΕΣ
*/

select (new.groupSize-old.groupSize) INTO dif;
IF dif<0 then
select count(email) into current_size from coupontokens where offerID=(SELECT offerID from offers where groupSize=new.groupSize);
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `offers_BEFORE_DELETE` BEFORE DELETE ON `offers` FOR EACH ROW BEGIN
/*ΟΤΑΝ ΔΙΑΓΡΑΦΕΤΑΙ Η ΠΡΟΣΦΟΡΑ*/
DELETE FROM coupontokens where offerID=old.offerID ORDER BY DATE DESC;
UPDATE users SET couponAmount = couponAmount - price, balance=balance+price where email=old.email;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `offers_AFTER_DELETE` AFTER DELETE ON `offers` FOR EACH ROW BEGIN
/*ΔΙΑΓΡΑΦΗ ΕΠΙΘΙΜΙΩΝ ΜΕΤΑ ΤΗΝ ΔΙΑΓΡΑΦΗ ΤΗΣ ΠΡΟΣΦΟΡΑΣ*/
Delete from mywish where offerID=old.offerID;
DELETE FROM notifications where offerID=old.offerID;

/*ΔΙΑΓΡΑΦΗ ΤΩΝ OFFERDETAILS ΚΑΙ OFFERPHOTOS*/

DELETE FROM offerdetails where offerID=old.offerID;
delete from offerphoto where offerID=OLD.offerID;

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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `paymentID` int NOT NULL AUTO_INCREMENT,
  `businessID` int DEFAULT NULL,
  `userID` int DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `level` varchar(45) DEFAULT NULL,
  `details` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `paymentscol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`paymentID`),
  UNIQUE KEY `paymentID_UNIQUE` (`paymentID`),
  KEY `QWEWE_idx` (`businessID`),
  KEY `SDKFG_idx` (`userID`),
  CONSTRAINT `QWEWE` FOREIGN KEY (`businessID`) REFERENCES `business` (`businessID`),
  CONSTRAINT `SDKFG` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payments_AFTER_INSERT` AFTER INSERT ON `payments` FOR EACH ROW BEGIN
/* ΚΑΘΕ ΦΟΡΑ ΠΟΥ Η ΕΤΑΙΡΙΑ ΠΛΗΡΩΝΕΙ ΤΗΝ ΣΥΝΔΡΟΜΗ ΤΗΣ ΠΡΟΣ ΤΗΝ ΣΕΛΙΔΑ , ΕΠΙΛΕΓΕΙ ΚΑΙ ΑΛΛΑΖΕΙ ΤΟ LEVEL ΤΗΣ */
if (new.level<>NULL) then 
update subscriptions set level=new.level where businessID=new.businessID;
END IF;

/* ΜΕΤΑ ΤΗΝ ΕΚΤΕΛΕΣΗ ΤΗΣ ΠΛΗΡΩΜΗΣ, ΜΕΤΑΒΑΛΩ ΚΑΙ ΤΟ ΣΥΝΟΛΙΚΟ ΥΠΟΛΟΙΠΟ ΤΗΣ ΕΠΙΧΕΙΡΗΣΗ */
if (new.businessID<>NULL) THEN
UPDATE business set Balance=businessBalance+new.amount;
end if;
/* ΜΕΤΑ ΤΗΝ ΕΚΤΕΛΕΣΗ ΤΗΣ ΠΛΗΡΩΜΗΣ, ΜΕΤΑΒΑΛΩ ΚΑΙ ΤΟ ΣΥΝΟΛΙΚΟ ΥΠΟΛΟΙΠΟ ΤΟΥ ΧΡΗΣΤΗ */
if (new.userID<>NULL) THEN
UPDATE admin set balance=businessBalance+new.amount;
end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `productphoto`
--

DROP TABLE IF EXISTS `productphoto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productphoto` (
  `productCode` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  KEY `laweb_idx` (`productCode`),
  CONSTRAINT `laweb` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productphoto`
--

LOCK TABLES `productphoto` WRITE;
/*!40000 ALTER TABLE `productphoto` DISABLE KEYS */;
/*!40000 ALTER TABLE `productphoto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productID` int NOT NULL,
  `productCode` varchar(45) NOT NULL,
  `productName` varchar(45) NOT NULL,
  `details` varchar(45) NOT NULL,
  `belong` int DEFAULT '0',
  PRIMARY KEY (`productID`),
  UNIQUE KEY `productCode_UNIQUE` (`productCode`),
  KEY `dfdsaf_idx` (`belong`),
  CONSTRAINT `dfdsaf` FOREIGN KEY (`belong`) REFERENCES `categories` (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `products_AFTER_DELETE` AFTER DELETE ON `products` FOR EACH ROW BEGIN
/*ΔΙΑΓΡΑΑΦΗ ΤΩΝ ΕΠΙΘΥΜΙΩΝ ΠΟΥ ΕΧΟΥΝ ΑΥΤΟΝ ΤΟΝ ΚΨΔΙΚΟ ΠΡΟΙΟΝΤΟΣ*/
DELETE FROM mywish where productCode=old.productCode;
delete from notifications where productCode=old.productCode;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `storeID` int NOT NULL,
  `email` varchar(45) NOT NULL,
  `town` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `addressNum` varchar(45) NOT NULL,
  `phoneNum` varchar(45) NOT NULL,
  PRIMARY KEY (`storeID`),
  UNIQUE KEY `storeID_UNIQUE` (`storeID`),
  KEY `msdbfn_idx` (`email`),
  CONSTRAINT `msdbfn` FOREIGN KEY (`email`) REFERENCES `business` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategories` (
  `categoryName` varchar(45) NOT NULL,
  KEY `fgasd_idx` (`categoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `businessID` int NOT NULL,
  `level` int NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`businessID`),
  CONSTRAINT `asdfsg` FOREIGN KEY (`businessID`) REFERENCES `business` (`businessID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phoneNum` varchar(45) NOT NULL DEFAULT 'null',
  `userName` varchar(45) NOT NULL,
  `delete` int NOT NULL DEFAULT '0',
  `bankAccount` varchar(45) DEFAULT NULL,
  `balance` decimal(10,0) NOT NULL DEFAULT '0',
  `couponAmount` decimal(10,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'group_buy'
--

--
-- Dumping routines for database 'group_buy'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-01 22:13:12

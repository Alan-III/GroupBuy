CREATE DATABASE  IF NOT EXISTS `group_buy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `group_buy`;
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
  `supervisor` varchar(45) NOT NULL,
  `AFM` varchar(45) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `bankAccount` varchar(45) NOT NULL,
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
  `categoryID` int NOT NULL,
  `categoryName` varchar(45) NOT NULL,
  `generalCategory` varchar(45) NOT NULL,
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `categoryID_UNIQUE` (`categoryID`),
  UNIQUE KEY `generalCategory_UNIQUE` (`generalCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupontokens`
--

DROP TABLE IF EXISTS `coupontokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupontokens` (
  `offerID` int NOT NULL,
  `token` varchar(45) NOT NULL,
  PRIMARY KEY (`offerID`),
  CONSTRAINT `aerfqefqewfq` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupontokens`
--

LOCK TABLES `coupontokens` WRITE;
/*!40000 ALTER TABLE `coupontokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupontokens` ENABLE KEYS */;
UNLOCK TABLES;

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
  KEY `AFAWER_idx` (`categoryID`),
  CONSTRAINT `AFAWER` FOREIGN KEY (`categoryID`) REFERENCES `categories` (`categoryID`)
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
-- Table structure for table `mycoupons`
--

DROP TABLE IF EXISTS `mycoupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mycoupons` (
  `userID` int NOT NULL,
  `coupon_code` varchar(45) DEFAULT NULL,
  `offerID` int NOT NULL,
  PRIMARY KEY (`userID`),
  KEY `asrgdaeg_idx` (`offerID`),
  CONSTRAINT `ASDGASDG` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`),
  CONSTRAINT `asrgdaeg` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mycoupons`
--

LOCK TABLES `mycoupons` WRITE;
/*!40000 ALTER TABLE `mycoupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `mycoupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mywish`
--

DROP TABLE IF EXISTS `mywish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mywish` (
  `userID` int NOT NULL,
  `productCode` varchar(45) NOT NULL,
  PRIMARY KEY (`userID`,`productCode`),
  KEY `fghdfgb_idx` (`productCode`),
  CONSTRAINT `jhcgvhj` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`),
  CONSTRAINT `sdjkbfjgbksld` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
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
  PRIMARY KEY (`productCode`),
  KEY `asfasf_idx` (`offerID`),
  CONSTRAINT `asedfgqwefg` FOREIGN KEY (`productCode`) REFERENCES `mywish` (`productCode`),
  CONSTRAINT `asfasf` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
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
  `productID` int NOT NULL,
  KEY `FASDFAS_idx` (`offerID`),
  KEY `SADFASFDA_idx` (`productID`),
  CONSTRAINT `FASDFAS` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`),
  CONSTRAINT `SADFASFDA` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
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
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `offerID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `finalPrice` decimal(10,2) NOT NULL,
  `descount%` decimal(10,2) NOT NULL,
  `couponPrice` decimal(10,2) NOT NULL,
  `offerExpire` datetime NOT NULL,
  `couponExpire` int NOT NULL,
  `businessID` int NOT NULL,
  `details` varchar(45) NOT NULL,
  `groupSize` int NOT NULL,
  PRIMARY KEY (`offerID`),
  UNIQUE KEY `offerID_UNIQUE` (`offerID`),
  KEY `asefasf_idx` (`businessID`),
  CONSTRAINT `asefasf` FOREIGN KEY (`businessID`) REFERENCES `business` (`businessID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `userID` int NOT NULL,
  `offerID` int NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`userID`),
  KEY `sADFAFWF_idx` (`offerID`),
  CONSTRAINT `asdbsajdfk` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`),
  CONSTRAINT `sADFAFWF` FOREIGN KEY (`offerID`) REFERENCES `offers` (`offerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
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
  `belong` int NOT NULL,
  PRIMARY KEY (`productID`),
  UNIQUE KEY `productCode_UNIQUE` (`productCode`),
  KEY `kjbjbl_idx` (`belong`),
  CONSTRAINT `kjbjbl` FOREIGN KEY (`belong`) REFERENCES `categories` (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `storeID` int NOT NULL,
  `adress` varchar(45) NOT NULL,
  `phoneNum` varchar(45) NOT NULL,
  `businessID` int NOT NULL,
  PRIMARY KEY (`storeID`),
  UNIQUE KEY `storeID_UNIQUE` (`storeID`),
  KEY `HGJHV_idx` (`businessID`),
  CONSTRAINT `HGJHV` FOREIGN KEY (`businessID`) REFERENCES `business` (`businessID`)
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
  `phoneNum` varchar(45) NOT NULL,
  `balance` decimal(10,0) NOT NULL DEFAULT '0',
  `userName` varchar(45) NOT NULL,
  `bankAccount` varchar(45) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `userName_UNIQUE` (`userName`),
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-17  9:46:41

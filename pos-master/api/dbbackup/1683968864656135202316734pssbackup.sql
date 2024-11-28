-- MySQL dump 10.13  Distrib 5.7.36, for Win64 (x86_64)
--
-- Host: localhost    Database: db_construction
-- ------------------------------------------------------
-- Server version	5.7.36

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
-- Temporary table structure for view `getallproducts`
--

DROP TABLE IF EXISTS `getallproducts`;
/*!50001 DROP VIEW IF EXISTS `getallproducts`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `getallproducts` AS SELECT 
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `product_code`,
 1 AS `categoryName`,
 1 AS `brandName`,
 1 AS `unit`,
 1 AS `unit_price`,
 1 AS `price`,
 1 AS `qty`,
 1 AS `reorder_number`,
 1 AS `product_image`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tblbrands`
--

DROP TABLE IF EXISTS `tblbrands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblbrands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brandName` varchar(200) NOT NULL,
  `desc` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblbrands`
--

LOCK TABLES `tblbrands` WRITE;
/*!40000 ALTER TABLE `tblbrands` DISABLE KEYS */;
INSERT INTO `tblbrands` VALUES (15,'K Cement',''),(19,'V Steel','');
/*!40000 ALTER TABLE `tblbrands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcategories`
--

DROP TABLE IF EXISTS `tblcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(250) NOT NULL,
  `desc` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcategories`
--

LOCK TABLES `tblcategories` WRITE;
/*!40000 ALTER TABLE `tblcategories` DISABLE KEYS */;
INSERT INTO `tblcategories` VALUES (1,' ស៊ីម៉ងត៍',''),(2,'ក្ដាបន្ទះពេជ្រ សរ',''),(7,'វីស',''),(8,'បំពងទីមជ័រ',''),(10,'ដែកគោល',''),(12,'ក្រដាស់',''),(13,'Mike ','Bran');
/*!40000 ALTER TABLE `tblcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcurrency`
--

DROP TABLE IF EXISTS `tblcurrency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcurrency` (
  `cur_id` int(11) NOT NULL AUTO_INCREMENT,
  `cur_kh` float NOT NULL,
  `cur_dollar` float NOT NULL,
  PRIMARY KEY (`cur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcurrency`
--

LOCK TABLES `tblcurrency` WRITE;
/*!40000 ALTER TABLE `tblcurrency` DISABLE KEYS */;
INSERT INTO `tblcurrency` VALUES (1,4150,1);
/*!40000 ALTER TABLE `tblcurrency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcustomers`
--

DROP TABLE IF EXISTS `tblcustomers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcustomers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerName` varchar(100) NOT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcustomers`
--

LOCK TABLES `tblcustomers` WRITE;
/*!40000 ALTER TABLE `tblcustomers` DISABLE KEYS */;
INSERT INTO `tblcustomers` VALUES (1,'General\r\n','','',''),(60,'mony','0976789500','',''),(61,'Tony','0976789','',''),(62,'apple','0976789501','','');
/*!40000 ALTER TABLE `tblcustomers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblinvoice`
--

DROP TABLE IF EXISTS `tblinvoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblinvoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(250) DEFAULT NULL,
  `payment_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `money_change` float NOT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblinvoice`
--

LOCK TABLES `tblinvoice` WRITE;
/*!40000 ALTER TABLE `tblinvoice` DISABLE KEYS */;
INSERT INTO `tblinvoice` VALUES (1,'PSS20235901',2,90,0),(2,'PSS20235902',2,40,0),(3,'PSS20235903',2,5,0),(4,'PSS20235904',2,20,0),(5,'PSS20235905',2,22,0),(6,'PSS202351006',2,62,0),(7,'PSS202351007',2,62,0),(8,'PSS202351008',2,12,0),(9,'PSS202351009',2,12,0),(10,'PSS2023510010',2,20,0),(11,'PSS2023510011',2,20,0),(12,'PSS2023510012',2,10,0),(13,'PSS2023510013',1,10,0),(14,'PSS2023510014',2,20,0),(15,'PSS2023510015',2,62,0),(16,'PSS2023510016',2,20,0),(17,'PSS2023510017',2,12,0),(18,'PSS2023510018',2,20,0),(19,'PSS2023510019',1,124124,0),(20,'PSS2023510020',1,372434,0),(21,'PSS2023510021',2,124212,0),(22,'PSS2023510022',2,124192,0),(23,'PSS2023511023',2,62,0),(24,'PSS2023511024',2,12,0),(25,'PSS2023511025',2,12,0),(26,'PSS2023511026',2,120,0),(27,'PSS2023511027',2,12,0),(28,'PSS2023511028',1,707,0),(29,'PSS2023511029',2,12,0),(30,'PSS2023511030',1,20,0),(31,'PSS2023511031',2,120,0),(32,'PSS2023511032',2,124692,0),(33,'PSS2023511033',1,240,0),(34,'PSS2023513034',2,248863,0);
/*!40000 ALTER TABLE `tblinvoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpayments`
--

DROP TABLE IF EXISTS `tblpayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpayments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpayments`
--

LOCK TABLES `tblpayments` WRITE;
/*!40000 ALTER TABLE `tblpayments` DISABLE KEYS */;
INSERT INTO `tblpayments` VALUES (1,'Cash'),(2,'ABA');
/*!40000 ALTER TABLE `tblpayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproducts`
--

DROP TABLE IF EXISTS `tblproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblproducts` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT '0',
  `sub_id` int(11) DEFAULT '0',
  `unit_id` int(11) NOT NULL DEFAULT '0',
  `product_code` varchar(100) DEFAULT NULL,
  `product_name` varchar(200) DEFAULT NULL,
  `qty` int(11) DEFAULT '0',
  `unit_price` float DEFAULT '0',
  `price` float DEFAULT '0',
  `exp_date` date DEFAULT NULL,
  `product_image` varchar(250) DEFAULT NULL,
  `desc` varchar(250) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `reorder_number` int(11) DEFAULT '0',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproducts`
--

LOCK TABLES `tblproducts` WRITE;
/*!40000 ALTER TABLE `tblproducts` DISABLE KEYS */;
INSERT INTO `tblproducts` VALUES (1,1,0,1,14,'000123','K Cement',214,4.75,5,'2023-05-10','images/168373211957820230422103437_[fpdl.jpg','',2,10),(15,10,6,0,15,'942859','Capper',89,11,12,'2023-05-10','images/168373210792720230417122646_[fpdl.jpg','',1,10),(16,1,6,0,14,'0923984','Book',73,9,20,'2023-05-10','images/1683732095360520320.jpg','',1,100),(17,1,6,0,14,'897382','Car',153,10,20,'2023-05-10','images/default.png','',1,100),(18,1,6,0,11,'093759','Door',4,10,10,'2023-05-10','images/1683732074380520320.jpg','',1,10),(19,2,6,0,14,'82375','Flag',252,10,20,'2023-05-10','images/1683732331323520320.jpg','',2,10),(21,2,15,0,11,'78877','K Cemen',3,112,124124,'2023-05-10','images/default.png','',1,0),(22,1,0,0,14,'12345','KSDA',2,10,11,'2023-05-10','images/default.png','',1,1),(23,1,15,0,14,'12324','ACement',95,10,15,'2023-05-10','images/default.png','',1,10),(24,13,0,0,16,'123456','ទឹកដោះគោ',84,100,120,'2023-05-11','images\\1683813463769mile.jpg','Bran',1,10);
/*!40000 ALTER TABLE `tblproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproductunits`
--

DROP TABLE IF EXISTS `tblproductunits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblproductunits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproductunits`
--

LOCK TABLES `tblproductunits` WRITE;
/*!40000 ALTER TABLE `tblproductunits` DISABLE KEYS */;
INSERT INTO `tblproductunits` VALUES (8,'m'),(11,'mm'),(14,'ton'),(15,'pakage'),(16,'កេះ');
/*!40000 ALTER TABLE `tblproductunits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblroles`
--

DROP TABLE IF EXISTS `tblroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblroles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblroles`
--

LOCK TABLES `tblroles` WRITE;
/*!40000 ALTER TABLE `tblroles` DISABLE KEYS */;
INSERT INTO `tblroles` VALUES (1,'Admin'),(2,'user');
/*!40000 ALTER TABLE `tblroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsaledetails`
--

DROP TABLE IF EXISTS `tblsaledetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsaledetails` (
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty_sales` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsaledetails`
--

LOCK TABLES `tblsaledetails` WRITE;
/*!40000 ALTER TABLE `tblsaledetails` DISABLE KEYS */;
INSERT INTO `tblsaledetails` VALUES (1,1,1),(1,15,1),(1,16,1),(1,17,1),(1,18,1),(1,19,1),(2,1,1),(2,15,1),(2,16,1),(3,1,1),(4,1,1),(4,15,1),(5,1,2),(5,15,1),(6,15,1),(6,16,1),(6,17,1),(6,18,1),(7,15,1),(7,16,1),(7,17,1),(7,18,1),(8,15,1),(9,15,1),(10,17,1),(11,17,1),(12,18,1),(13,18,1),(14,16,1),(15,15,1),(15,16,1),(15,17,1),(15,18,1),(16,17,1),(17,15,1),(18,16,1),(19,21,1),(20,15,1),(20,16,1),(20,17,1),(20,18,1),(20,21,3),(21,15,1),(21,16,1),(21,17,1),(21,18,1),(21,21,1),(21,22,1),(21,23,1),(22,15,1),(22,16,1),(22,18,1),(22,21,1),(22,22,1),(22,23,1),(23,15,1),(23,17,1),(23,16,1),(23,18,1),(24,15,1),(25,15,1),(26,24,1),(27,15,1),(28,17,2),(28,18,2),(28,24,5),(28,15,1),(28,16,1),(28,23,1),(29,15,1),(30,16,1),(31,24,1),(32,15,1),(32,16,1),(32,17,1),(32,18,1),(32,21,1),(32,22,1),(32,23,1),(32,24,4),(33,24,2),(34,24,3),(34,15,4),(34,16,4),(34,17,2),(34,18,2),(34,21,2),(34,22,2),(34,23,3);
/*!40000 ALTER TABLE `tblsaledetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_qty` AFTER INSERT ON `tblSaleDetails` FOR EACH ROW UPDATE tblProducts SET qty = qty-new.qty_sales WHERE product_id = new.product_id */;;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_sale` AFTER UPDATE ON `tblSaleDetails` FOR EACH ROW BEGIN
    UPDATE tblProducts SET tblProducts.qty = (tblProducts.qty+OLD.qty_sales)-NEW.qty_sales;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_sale` AFTER DELETE ON `tblSaleDetails` FOR EACH ROW BEGIN
   UPDATE tblProducts SET tblProducts.qty = tblProducts.qty + OLD.qty_sales;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tblsales`
--

DROP TABLE IF EXISTS `tblsales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsales` (
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) NOT NULL,
  `sale_date` date NOT NULL,
  `desc` varchar(250) NOT NULL,
  PRIMARY KEY (`sale_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsales`
--

LOCK TABLES `tblsales` WRITE;
/*!40000 ALTER TABLE `tblsales` DISABLE KEYS */;
INSERT INTO `tblsales` VALUES (1,17,1,1,'2023-05-09',''),(2,17,1,2,'2023-05-09',''),(3,17,1,3,'2023-05-09',''),(4,27,1,4,'2023-05-09',''),(5,27,1,5,'2023-05-09',''),(6,17,60,6,'2023-05-10',''),(7,17,1,7,'2023-05-10',''),(8,17,1,8,'2023-05-10',''),(9,17,1,9,'2023-05-10',''),(10,17,1,10,'2023-05-10',''),(11,17,1,11,'2023-05-10',''),(12,17,1,12,'2023-05-10',''),(13,17,1,13,'2023-05-10',''),(14,17,1,14,'2023-05-10',''),(15,17,1,15,'2023-05-10',''),(16,17,1,16,'2023-05-10',''),(17,17,1,17,'2023-05-10',''),(18,17,1,18,'2023-05-10',''),(19,17,1,19,'2023-05-10',''),(20,27,1,20,'2023-05-10',''),(21,17,1,21,'2023-05-10',''),(22,17,1,22,'2023-05-10',''),(23,17,1,23,'2023-05-11','i love you'),(24,28,1,24,'2023-05-11','Bran'),(25,28,1,25,'2023-05-11','apple'),(26,28,1,26,'2023-05-11','A'),(27,28,1,27,'2023-05-11',''),(28,28,1,28,'2023-05-11','Bran'),(29,28,1,29,'2023-05-11','Apple'),(30,28,1,30,'2023-05-11',''),(31,28,1,31,'2023-05-11','See'),(32,28,1,32,'2023-05-11','អរគុណ'),(33,28,1,33,'2023-05-11','apple'),(34,28,1,34,'2023-05-13','Bran');
/*!40000 ALTER TABLE `tblsales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblstatus`
--

DROP TABLE IF EXISTS `tblstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblstatus`
--

LOCK TABLES `tblstatus` WRITE;
/*!40000 ALTER TABLE `tblstatus` DISABLE KEYS */;
INSERT INTO `tblstatus` VALUES (1,'Enable'),(2,'Disable');
/*!40000 ALTER TABLE `tblstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsupplies`
--

DROP TABLE IF EXISTS `tblsupplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsupplies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supName` varchar(250) NOT NULL,
  `companyName` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `phone` varchar(250) NOT NULL,
  `address` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsupplies`
--

LOCK TABLES `tblsupplies` WRITE;
/*!40000 ALTER TABLE `tblsupplies` DISABLE KEYS */;
INSERT INTO `tblsupplies` VALUES (2,'mony','','','0933224',''),(3,'mony','','','09332243','');
/*!40000 ALTER TABLE `tblsupplies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblusers`
--

DROP TABLE IF EXISTS `tblusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblusers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phone_number` varchar(100) DEFAULT NULL,
  `token` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblusers`
--

LOCK TABLES `tblusers` WRITE;
/*!40000 ALTER TABLE `tblusers` DISABLE KEYS */;
INSERT INTO `tblusers` VALUES (17,1,1,'mony','$2b$10$CkGDTvhDg/qQ0SpOmPLJVetk7XHDLBjvXoHynt973Ph7nDqQnrQSe','rysarakmony6101@gmail.com','',NULL),(26,1,1,'chea','$2b$10$orn/fFbKdBwEDcuh7FtxmuLK106zcK1/IilQyRCocAsAuKRGtsQOS','chea@gmail.com','',NULL),(27,2,1,'dara','$2b$10$gvt6DNt3NHiVhMNfSvNAA.8hfgi.RaSLUs3G2VTu1Vc5qhApFcBrO','chea9999@gmail.com','',NULL),(28,1,1,'Phanith','$2b$10$pe1/Y0UWjNJ09NxeV9VJYeXiQcOH5nFRhksnhsXUpcJmzxPvyx1b2','hoeurnphanith@gmail.com','012345678','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOjI4LCJ1c2VybmFtZSI6IlBoYW5pdGgiLCJlbWFpbCI6ImhvZXVybnBoYW5pdGhAZ21haWwuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNjgzOTYzMTQxLCJleHAiOjE2ODQwNDk1NDF9.nhobVLz1yIL2wDMcJMQm_pkm72udoP97xGoOy82fjSc');
/*!40000 ALTER TABLE `tblusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_chartdayreports`
--

DROP TABLE IF EXISTS `v_chartdayreports`;
/*!50001 DROP VIEW IF EXISTS `v_chartdayreports`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_chartdayreports` AS SELECT 
 1 AS `totalAmount`,
 1 AS `Day`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_productreports`
--

DROP TABLE IF EXISTS `v_productreports`;
/*!50001 DROP VIEW IF EXISTS `v_productreports`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_productreports` AS SELECT 
 1 AS `product_id`,
 1 AS `product_code`,
 1 AS `product_name`,
 1 AS `qty`,
 1 AS `unit`,
 1 AS `cost`,
 1 AS `revenue`,
 1 AS `profit`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_todaysale`
--

DROP TABLE IF EXISTS `v_todaysale`;
/*!50001 DROP VIEW IF EXISTS `v_todaysale`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_todaysale` AS SELECT 
 1 AS `product_code`,
 1 AS `product_name`,
 1 AS `qty`,
 1 AS `cost`,
 1 AS `revenue`,
 1 AS `profit`,
 1 AS `sale_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `getallproducts`
--

/*!50001 DROP VIEW IF EXISTS `getallproducts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getallproducts` AS select `tblproducts`.`product_id` AS `product_id`,`tblproducts`.`product_name` AS `product_name`,`tblproducts`.`product_code` AS `product_code`,`tblcategories`.`categoryName` AS `categoryName`,`tblbrands`.`brandName` AS `brandName`,`tblproductunits`.`unit` AS `unit`,`tblproducts`.`unit_price` AS `unit_price`,`tblproducts`.`price` AS `price`,`tblproducts`.`qty` AS `qty`,`tblproducts`.`reorder_number` AS `reorder_number`,`tblproducts`.`product_image` AS `product_image` from (((`tblproducts` left join `tblcategories` on((`tblproducts`.`category_id` = `tblcategories`.`id`))) left join `tblbrands` on((`tblproducts`.`brand_id` = `tblbrands`.`id`))) left join `tblproductunits` on((`tblproducts`.`unit_id` = `tblproductunits`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_chartdayreports`
--

/*!50001 DROP VIEW IF EXISTS `v_chartdayreports`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_chartdayreports` AS select sum(`tblinvoice`.`amount`) AS `totalAmount`,date_format(`tblsales`.`sale_date`,'%a') AS `Day` from (`tblsales` join `tblinvoice` on((`tblinvoice`.`invoice_id` = `tblsales`.`invoice_id`))) group by date_format(`tblsales`.`sale_date`,'%a') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_productreports`
--

/*!50001 DROP VIEW IF EXISTS `v_productreports`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_productreports` AS select `tblproducts`.`product_id` AS `product_id`,`tblproducts`.`product_code` AS `product_code`,`tblproducts`.`product_name` AS `product_name`,sum(`tblsaledetails`.`qty_sales`) AS `qty`,`tblproductunits`.`unit` AS `unit`,(sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`unit_price`) AS `cost`,(sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`price`) AS `revenue`,((sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`price`) - (sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`unit_price`)) AS `profit` from ((`tblsaledetails` left join `tblproducts` on((`tblsaledetails`.`product_id` = `tblproducts`.`product_id`))) join `tblproductunits` on((`tblproducts`.`unit_id` = `tblproductunits`.`id`))) group by `tblsaledetails`.`product_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_todaysale`
--

/*!50001 DROP VIEW IF EXISTS `v_todaysale`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_todaysale` AS select `tblproducts`.`product_code` AS `product_code`,`tblproducts`.`product_name` AS `product_name`,concat(sum(`tblsaledetails`.`qty_sales`),' ( ',`tblproductunits`.`unit`,' ) ') AS `qty`,(sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`unit_price`) AS `cost`,(sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`price`) AS `revenue`,((sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`price`) - (sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`unit_price`)) AS `profit`,curdate() AS `sale_date` from (((`tblsales` join `tblsaledetails` on((`tblsaledetails`.`sale_id` = `tblsales`.`sale_id`))) join `tblproducts` on((`tblsaledetails`.`product_id` = `tblproducts`.`product_id`))) left join `tblproductunits` on((`tblproducts`.`unit_id` = `tblproductunits`.`id`))) where (`tblsales`.`sale_date` = curdate()) group by `tblproducts`.`product_code` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-13 16:07:34

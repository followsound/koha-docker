-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: koha_knihovna
-- ------------------------------------------------------
-- Server version	5.5.40-0+wheezy1

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
-- Table structure for table `accountlines`
--

DROP TABLE IF EXISTS `accountlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountlines` (
  `accountlines_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `accountno` smallint(6) NOT NULL DEFAULT '0',
  `itemnumber` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `amount` decimal(28,6) DEFAULT NULL,
  `description` mediumtext,
  `dispute` mediumtext,
  `accounttype` varchar(5) DEFAULT NULL,
  `amountoutstanding` decimal(28,6) DEFAULT NULL,
  `lastincrement` decimal(28,6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notify_id` int(11) NOT NULL DEFAULT '0',
  `notify_level` int(2) NOT NULL DEFAULT '0',
  `note` text,
  `manager_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`accountlines_id`),
  KEY `acctsborridx` (`borrowernumber`),
  KEY `timeidx` (`timestamp`),
  KEY `itemnumber` (`itemnumber`),
  CONSTRAINT `accountlines_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `accountlines_ibfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountlines`
--

LOCK TABLES `accountlines` WRITE;
/*!40000 ALTER TABLE `accountlines` DISABLE KEYS */;
/*!40000 ALTER TABLE `accountlines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accountoffsets`
--

DROP TABLE IF EXISTS `accountoffsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountoffsets` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `accountno` smallint(6) NOT NULL DEFAULT '0',
  `offsetaccount` smallint(6) NOT NULL DEFAULT '0',
  `offsetamount` decimal(28,6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `accountoffsets_ibfk_1` (`borrowernumber`),
  CONSTRAINT `accountoffsets_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountoffsets`
--

LOCK TABLES `accountoffsets` WRITE;
/*!40000 ALTER TABLE `accountoffsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `accountoffsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `action_logs`
--

DROP TABLE IF EXISTS `action_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_logs` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user` int(11) NOT NULL DEFAULT '0',
  `module` text,
  `action` text,
  `object` int(11) DEFAULT NULL,
  `info` text,
  PRIMARY KEY (`action_id`),
  KEY `timestamp_idx` (`timestamp`),
  KEY `user_idx` (`user`),
  KEY `module_idx` (`module`(255)),
  KEY `action_idx` (`action`(255)),
  KEY `object_idx` (`object`),
  KEY `info_idx` (`info`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_logs`
--

LOCK TABLES `action_logs` WRITE;
/*!40000 ALTER TABLE `action_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `action_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert` (
  `alertid` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `type` varchar(10) NOT NULL DEFAULT '',
  `externalid` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`alertid`),
  KEY `borrowernumber` (`borrowernumber`),
  KEY `type` (`type`,`externalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbasket`
--

DROP TABLE IF EXISTS `aqbasket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbasket` (
  `basketno` int(11) NOT NULL AUTO_INCREMENT,
  `basketname` varchar(50) DEFAULT NULL,
  `note` mediumtext,
  `booksellernote` mediumtext,
  `contractnumber` int(11) DEFAULT NULL,
  `creationdate` date DEFAULT NULL,
  `closedate` date DEFAULT NULL,
  `booksellerid` int(11) NOT NULL DEFAULT '1',
  `authorisedby` varchar(10) DEFAULT NULL,
  `booksellerinvoicenumber` mediumtext,
  `basketgroupid` int(11) DEFAULT NULL,
  `deliveryplace` varchar(10) DEFAULT NULL,
  `billingplace` varchar(10) DEFAULT NULL,
  `branch` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`basketno`),
  KEY `booksellerid` (`booksellerid`),
  KEY `basketgroupid` (`basketgroupid`),
  KEY `contractnumber` (`contractnumber`),
  KEY `aqbasket_ibfk_4` (`branch`),
  CONSTRAINT `aqbasket_ibfk_1` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `aqbasket_ibfk_2` FOREIGN KEY (`contractnumber`) REFERENCES `aqcontract` (`contractnumber`),
  CONSTRAINT `aqbasket_ibfk_3` FOREIGN KEY (`basketgroupid`) REFERENCES `aqbasketgroups` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `aqbasket_ibfk_4` FOREIGN KEY (`branch`) REFERENCES `branches` (`branchcode`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbasket`
--

LOCK TABLES `aqbasket` WRITE;
/*!40000 ALTER TABLE `aqbasket` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbasket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbasketgroups`
--

DROP TABLE IF EXISTS `aqbasketgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbasketgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `closed` tinyint(1) DEFAULT NULL,
  `booksellerid` int(11) NOT NULL,
  `deliveryplace` varchar(10) DEFAULT NULL,
  `freedeliveryplace` text,
  `deliverycomment` varchar(255) DEFAULT NULL,
  `billingplace` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booksellerid` (`booksellerid`),
  CONSTRAINT `aqbasketgroups_ibfk_1` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbasketgroups`
--

LOCK TABLES `aqbasketgroups` WRITE;
/*!40000 ALTER TABLE `aqbasketgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbasketgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbasketusers`
--

DROP TABLE IF EXISTS `aqbasketusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbasketusers` (
  `basketno` int(11) NOT NULL,
  `borrowernumber` int(11) NOT NULL,
  PRIMARY KEY (`basketno`,`borrowernumber`),
  KEY `aqbasketusers_ibfk_2` (`borrowernumber`),
  CONSTRAINT `aqbasketusers_ibfk_1` FOREIGN KEY (`basketno`) REFERENCES `aqbasket` (`basketno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbasketusers_ibfk_2` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbasketusers`
--

LOCK TABLES `aqbasketusers` WRITE;
/*!40000 ALTER TABLE `aqbasketusers` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbasketusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbooksellers`
--

DROP TABLE IF EXISTS `aqbooksellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbooksellers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  `address1` mediumtext,
  `address2` mediumtext,
  `address3` mediumtext,
  `address4` mediumtext,
  `phone` varchar(30) DEFAULT NULL,
  `accountnumber` mediumtext,
  `othersupplier` mediumtext,
  `currency` varchar(3) NOT NULL DEFAULT '',
  `booksellerfax` mediumtext,
  `notes` mediumtext,
  `bookselleremail` mediumtext,
  `booksellerurl` mediumtext,
  `contact` varchar(100) DEFAULT NULL,
  `postal` mediumtext,
  `url` varchar(255) DEFAULT NULL,
  `contpos` varchar(100) DEFAULT NULL,
  `contphone` varchar(100) DEFAULT NULL,
  `contfax` varchar(100) DEFAULT NULL,
  `contaltphone` varchar(100) DEFAULT NULL,
  `contemail` varchar(100) DEFAULT NULL,
  `contnotes` mediumtext,
  `active` tinyint(4) DEFAULT NULL,
  `listprice` varchar(10) DEFAULT NULL,
  `invoiceprice` varchar(10) DEFAULT NULL,
  `gstreg` tinyint(4) DEFAULT NULL,
  `listincgst` tinyint(4) DEFAULT NULL,
  `invoiceincgst` tinyint(4) DEFAULT NULL,
  `gstrate` decimal(6,4) DEFAULT NULL,
  `discount` float(6,4) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `deliverytime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listprice` (`listprice`),
  KEY `invoiceprice` (`invoiceprice`),
  CONSTRAINT `aqbooksellers_ibfk_1` FOREIGN KEY (`listprice`) REFERENCES `currency` (`currency`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbooksellers_ibfk_2` FOREIGN KEY (`invoiceprice`) REFERENCES `currency` (`currency`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbooksellers`
--

LOCK TABLES `aqbooksellers` WRITE;
/*!40000 ALTER TABLE `aqbooksellers` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbooksellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbudgetborrowers`
--

DROP TABLE IF EXISTS `aqbudgetborrowers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbudgetborrowers` (
  `budget_id` int(11) NOT NULL,
  `borrowernumber` int(11) NOT NULL,
  PRIMARY KEY (`budget_id`,`borrowernumber`),
  KEY `aqbudgetborrowers_ibfk_2` (`borrowernumber`),
  CONSTRAINT `aqbudgetborrowers_ibfk_1` FOREIGN KEY (`budget_id`) REFERENCES `aqbudgets` (`budget_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbudgetborrowers_ibfk_2` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbudgetborrowers`
--

LOCK TABLES `aqbudgetborrowers` WRITE;
/*!40000 ALTER TABLE `aqbudgetborrowers` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbudgetborrowers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbudgetperiods`
--

DROP TABLE IF EXISTS `aqbudgetperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbudgetperiods` (
  `budget_period_id` int(11) NOT NULL AUTO_INCREMENT,
  `budget_period_startdate` date NOT NULL,
  `budget_period_enddate` date NOT NULL,
  `budget_period_active` tinyint(1) DEFAULT '0',
  `budget_period_description` mediumtext,
  `budget_period_total` decimal(28,6) DEFAULT NULL,
  `budget_period_locked` tinyint(1) DEFAULT NULL,
  `sort1_authcat` varchar(10) DEFAULT NULL,
  `sort2_authcat` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`budget_period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbudgetperiods`
--

LOCK TABLES `aqbudgetperiods` WRITE;
/*!40000 ALTER TABLE `aqbudgetperiods` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbudgetperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbudgets`
--

DROP TABLE IF EXISTS `aqbudgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbudgets` (
  `budget_id` int(11) NOT NULL AUTO_INCREMENT,
  `budget_parent_id` int(11) DEFAULT NULL,
  `budget_code` varchar(30) DEFAULT NULL,
  `budget_name` varchar(80) DEFAULT NULL,
  `budget_branchcode` varchar(10) DEFAULT NULL,
  `budget_amount` decimal(28,6) DEFAULT '0.000000',
  `budget_encumb` decimal(28,6) DEFAULT '0.000000',
  `budget_expend` decimal(28,6) DEFAULT '0.000000',
  `budget_notes` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `budget_period_id` int(11) DEFAULT NULL,
  `sort1_authcat` varchar(80) DEFAULT NULL,
  `sort2_authcat` varchar(80) DEFAULT NULL,
  `budget_owner_id` int(11) DEFAULT NULL,
  `budget_permission` int(1) DEFAULT '0',
  PRIMARY KEY (`budget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbudgets`
--

LOCK TABLES `aqbudgets` WRITE;
/*!40000 ALTER TABLE `aqbudgets` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbudgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbudgets_planning`
--

DROP TABLE IF EXISTS `aqbudgets_planning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbudgets_planning` (
  `plan_id` int(11) NOT NULL AUTO_INCREMENT,
  `budget_id` int(11) NOT NULL,
  `budget_period_id` int(11) NOT NULL,
  `estimated_amount` decimal(28,6) DEFAULT NULL,
  `authcat` varchar(30) NOT NULL,
  `authvalue` varchar(30) NOT NULL,
  `display` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`plan_id`),
  KEY `aqbudgets_planning_ifbk_1` (`budget_id`),
  CONSTRAINT `aqbudgets_planning_ifbk_1` FOREIGN KEY (`budget_id`) REFERENCES `aqbudgets` (`budget_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbudgets_planning`
--

LOCK TABLES `aqbudgets_planning` WRITE;
/*!40000 ALTER TABLE `aqbudgets_planning` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbudgets_planning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqcontract`
--

DROP TABLE IF EXISTS `aqcontract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqcontract` (
  `contractnumber` int(11) NOT NULL AUTO_INCREMENT,
  `contractstartdate` date DEFAULT NULL,
  `contractenddate` date DEFAULT NULL,
  `contractname` varchar(50) DEFAULT NULL,
  `contractdescription` mediumtext,
  `booksellerid` int(11) NOT NULL,
  PRIMARY KEY (`contractnumber`),
  KEY `booksellerid_fk1` (`booksellerid`),
  CONSTRAINT `booksellerid_fk1` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqcontract`
--

LOCK TABLES `aqcontract` WRITE;
/*!40000 ALTER TABLE `aqcontract` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqcontract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqinvoices`
--

DROP TABLE IF EXISTS `aqinvoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqinvoices` (
  `invoiceid` int(11) NOT NULL AUTO_INCREMENT,
  `invoicenumber` mediumtext NOT NULL,
  `booksellerid` int(11) NOT NULL,
  `shipmentdate` date DEFAULT NULL,
  `billingdate` date DEFAULT NULL,
  `closedate` date DEFAULT NULL,
  `shipmentcost` decimal(28,6) DEFAULT NULL,
  `shipmentcost_budgetid` int(11) DEFAULT NULL,
  PRIMARY KEY (`invoiceid`),
  KEY `aqinvoices_fk_aqbooksellerid` (`booksellerid`),
  KEY `aqinvoices_fk_shipmentcost_budgetid` (`shipmentcost_budgetid`),
  CONSTRAINT `aqinvoices_fk_aqbooksellerid` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqinvoices_fk_shipmentcost_budgetid` FOREIGN KEY (`shipmentcost_budgetid`) REFERENCES `aqbudgets` (`budget_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqinvoices`
--

LOCK TABLES `aqinvoices` WRITE;
/*!40000 ALTER TABLE `aqinvoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqinvoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqorders`
--

DROP TABLE IF EXISTS `aqorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqorders` (
  `ordernumber` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) DEFAULT NULL,
  `entrydate` date DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `listprice` decimal(28,6) DEFAULT NULL,
  `totalamount` decimal(28,6) DEFAULT NULL,
  `datereceived` date DEFAULT NULL,
  `invoiceid` int(11) DEFAULT NULL,
  `freight` decimal(28,6) DEFAULT NULL,
  `unitprice` decimal(28,6) DEFAULT NULL,
  `quantityreceived` smallint(6) NOT NULL DEFAULT '0',
  `cancelledby` varchar(10) DEFAULT NULL,
  `datecancellationprinted` date DEFAULT NULL,
  `order_internalnote` mediumtext,
  `order_vendornote` mediumtext,
  `supplierreference` mediumtext,
  `purchaseordernumber` mediumtext,
  `basketno` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rrp` decimal(13,2) DEFAULT NULL,
  `ecost` decimal(13,2) DEFAULT NULL,
  `gstrate` decimal(6,4) DEFAULT NULL,
  `discount` float(6,4) DEFAULT NULL,
  `budget_id` int(11) NOT NULL,
  `budgetgroup_id` int(11) NOT NULL,
  `budgetdate` date DEFAULT NULL,
  `sort1` varchar(80) DEFAULT NULL,
  `sort2` varchar(80) DEFAULT NULL,
  `sort1_authcat` varchar(10) DEFAULT NULL,
  `sort2_authcat` varchar(10) DEFAULT NULL,
  `uncertainprice` tinyint(1) DEFAULT NULL,
  `claims_count` int(11) DEFAULT '0',
  `claimed_date` date DEFAULT NULL,
  `subscriptionid` int(11) DEFAULT NULL,
  `parent_ordernumber` int(11) DEFAULT NULL,
  `orderstatus` varchar(16) DEFAULT 'new',
  PRIMARY KEY (`ordernumber`),
  KEY `basketno` (`basketno`),
  KEY `biblionumber` (`biblionumber`),
  KEY `budget_id` (`budget_id`),
  KEY `aqorders_ibfk_3` (`invoiceid`),
  KEY `aqorders_subscriptionid` (`subscriptionid`),
  CONSTRAINT `aqorders_ibfk_1` FOREIGN KEY (`basketno`) REFERENCES `aqbasket` (`basketno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqorders_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `aqorders_ibfk_3` FOREIGN KEY (`invoiceid`) REFERENCES `aqinvoices` (`invoiceid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `aqorders_subscriptionid` FOREIGN KEY (`subscriptionid`) REFERENCES `subscription` (`subscriptionid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqorders`
--

LOCK TABLES `aqorders` WRITE;
/*!40000 ALTER TABLE `aqorders` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqorders_items`
--

DROP TABLE IF EXISTS `aqorders_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqorders_items` (
  `ordernumber` int(11) NOT NULL,
  `itemnumber` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`itemnumber`),
  KEY `ordernumber` (`ordernumber`),
  CONSTRAINT `aqorders_items_ibfk_1` FOREIGN KEY (`ordernumber`) REFERENCES `aqorders` (`ordernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqorders_items`
--

LOCK TABLES `aqorders_items` WRITE;
/*!40000 ALTER TABLE `aqorders_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqorders_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqorders_transfers`
--

DROP TABLE IF EXISTS `aqorders_transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqorders_transfers` (
  `ordernumber_from` int(11) DEFAULT NULL,
  `ordernumber_to` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `ordernumber_from` (`ordernumber_from`),
  UNIQUE KEY `ordernumber_to` (`ordernumber_to`),
  CONSTRAINT `aqorders_transfers_ordernumber_from` FOREIGN KEY (`ordernumber_from`) REFERENCES `aqorders` (`ordernumber`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `aqorders_transfers_ordernumber_to` FOREIGN KEY (`ordernumber_to`) REFERENCES `aqorders` (`ordernumber`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqorders_transfers`
--

LOCK TABLES `aqorders_transfers` WRITE;
/*!40000 ALTER TABLE `aqorders_transfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqorders_transfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_header`
--

DROP TABLE IF EXISTS `auth_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_header` (
  `authid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `datecreated` date DEFAULT NULL,
  `datemodified` date DEFAULT NULL,
  `origincode` varchar(20) DEFAULT NULL,
  `authtrees` mediumtext,
  `marc` blob,
  `linkid` bigint(20) DEFAULT NULL,
  `marcxml` longtext NOT NULL,
  PRIMARY KEY (`authid`),
  KEY `origincode` (`origincode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_header`
--

LOCK TABLES `auth_header` WRITE;
/*!40000 ALTER TABLE `auth_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_subfield_structure`
--

DROP TABLE IF EXISTS `auth_subfield_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_subfield_structure` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `tagsubfield` varchar(1) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint(4) NOT NULL DEFAULT '0',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `tab` tinyint(1) DEFAULT NULL,
  `authorised_value` varchar(10) DEFAULT NULL,
  `value_builder` varchar(80) DEFAULT NULL,
  `seealso` varchar(255) DEFAULT NULL,
  `isurl` tinyint(1) DEFAULT NULL,
  `hidden` tinyint(3) NOT NULL DEFAULT '0',
  `linkid` tinyint(1) NOT NULL DEFAULT '0',
  `kohafield` varchar(45) DEFAULT '',
  `frameworkcode` varchar(10) NOT NULL DEFAULT '',
  `defaultvalue` text,
  PRIMARY KEY (`authtypecode`,`tagfield`,`tagsubfield`),
  KEY `tab` (`authtypecode`,`tab`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_subfield_structure`
--

LOCK TABLES `auth_subfield_structure` WRITE;
/*!40000 ALTER TABLE `auth_subfield_structure` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_subfield_structure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_tag_structure`
--

DROP TABLE IF EXISTS `auth_tag_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_tag_structure` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint(4) NOT NULL DEFAULT '0',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `authorised_value` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`authtypecode`,`tagfield`),
  CONSTRAINT `auth_tag_structure_ibfk_1` FOREIGN KEY (`authtypecode`) REFERENCES `auth_types` (`authtypecode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_tag_structure`
--

LOCK TABLES `auth_tag_structure` WRITE;
/*!40000 ALTER TABLE `auth_tag_structure` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_tag_structure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_types`
--

DROP TABLE IF EXISTS `auth_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_types` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `authtypetext` varchar(255) NOT NULL DEFAULT '',
  `auth_tag_to_report` varchar(3) NOT NULL DEFAULT '',
  `summary` mediumtext NOT NULL,
  PRIMARY KEY (`authtypecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_types`
--

LOCK TABLES `auth_types` WRITE;
/*!40000 ALTER TABLE `auth_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorised_values`
--

DROP TABLE IF EXISTS `authorised_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorised_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(16) NOT NULL DEFAULT '',
  `authorised_value` varchar(80) NOT NULL DEFAULT '',
  `lib` varchar(200) DEFAULT NULL,
  `lib_opac` varchar(200) DEFAULT NULL,
  `imageurl` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`category`),
  KEY `lib` (`lib`),
  KEY `auth_value_idx` (`authorised_value`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorised_values`
--

LOCK TABLES `authorised_values` WRITE;
/*!40000 ALTER TABLE `authorised_values` DISABLE KEYS */;
INSERT INTO `authorised_values` VALUES (1,'YES_NO','0','No','No',NULL),(2,'YES_NO','1','Yes','Yes',NULL);
/*!40000 ALTER TABLE `authorised_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorised_values_branches`
--

DROP TABLE IF EXISTS `authorised_values_branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorised_values_branches` (
  `av_id` int(11) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  KEY `av_id` (`av_id`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `authorised_values_branches_ibfk_1` FOREIGN KEY (`av_id`) REFERENCES `authorised_values` (`id`) ON DELETE CASCADE,
  CONSTRAINT `authorised_values_branches_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorised_values_branches`
--

LOCK TABLES `authorised_values_branches` WRITE;
/*!40000 ALTER TABLE `authorised_values_branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `authorised_values_branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblio`
--

DROP TABLE IF EXISTS `biblio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblio` (
  `biblionumber` int(11) NOT NULL AUTO_INCREMENT,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `author` mediumtext,
  `title` mediumtext,
  `unititle` mediumtext,
  `notes` mediumtext,
  `serial` tinyint(1) DEFAULT NULL,
  `seriestitle` mediumtext,
  `copyrightdate` smallint(6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datecreated` date NOT NULL,
  `abstract` mediumtext,
  PRIMARY KEY (`biblionumber`),
  KEY `blbnoidx` (`biblionumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblio`
--

LOCK TABLES `biblio` WRITE;
/*!40000 ALTER TABLE `biblio` DISABLE KEYS */;
/*!40000 ALTER TABLE `biblio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblio_framework`
--

DROP TABLE IF EXISTS `biblio_framework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblio_framework` (
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `frameworktext` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`frameworkcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblio_framework`
--

LOCK TABLES `biblio_framework` WRITE;
/*!40000 ALTER TABLE `biblio_framework` DISABLE KEYS */;
/*!40000 ALTER TABLE `biblio_framework` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblioimages`
--

DROP TABLE IF EXISTS `biblioimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblioimages` (
  `imagenumber` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) NOT NULL,
  `mimetype` varchar(15) NOT NULL,
  `imagefile` mediumblob NOT NULL,
  `thumbnail` mediumblob NOT NULL,
  PRIMARY KEY (`imagenumber`),
  KEY `bibliocoverimage_fk1` (`biblionumber`),
  CONSTRAINT `bibliocoverimage_fk1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblioimages`
--

LOCK TABLES `biblioimages` WRITE;
/*!40000 ALTER TABLE `biblioimages` DISABLE KEYS */;
/*!40000 ALTER TABLE `biblioimages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblioitems`
--

DROP TABLE IF EXISTS `biblioitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblioitems` (
  `biblioitemnumber` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `volume` mediumtext,
  `number` mediumtext,
  `itemtype` varchar(10) DEFAULT NULL,
  `isbn` mediumtext,
  `issn` mediumtext,
  `ean` varchar(13) DEFAULT NULL,
  `publicationyear` text,
  `publishercode` varchar(255) DEFAULT NULL,
  `volumedate` date DEFAULT NULL,
  `volumedesc` text,
  `collectiontitle` mediumtext,
  `collectionissn` text,
  `collectionvolume` mediumtext,
  `editionstatement` text,
  `editionresponsibility` text,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `illus` varchar(255) DEFAULT NULL,
  `pages` varchar(255) DEFAULT NULL,
  `notes` mediumtext,
  `size` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `lccn` varchar(25) DEFAULT NULL,
  `marc` longblob,
  `url` text,
  `cn_source` varchar(10) DEFAULT NULL,
  `cn_class` varchar(30) DEFAULT NULL,
  `cn_item` varchar(10) DEFAULT NULL,
  `cn_suffix` varchar(10) DEFAULT NULL,
  `cn_sort` varchar(30) DEFAULT NULL,
  `agerestriction` varchar(255) DEFAULT NULL,
  `totalissues` int(10) DEFAULT NULL,
  `marcxml` longtext NOT NULL,
  PRIMARY KEY (`biblioitemnumber`),
  KEY `bibinoidx` (`biblioitemnumber`),
  KEY `bibnoidx` (`biblionumber`),
  KEY `itemtype_idx` (`itemtype`),
  KEY `isbn` (`isbn`(255)),
  KEY `issn` (`issn`(255)),
  KEY `publishercode` (`publishercode`),
  CONSTRAINT `biblioitems_ibfk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblioitems`
--

LOCK TABLES `biblioitems` WRITE;
/*!40000 ALTER TABLE `biblioitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `biblioitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_attribute_types`
--

DROP TABLE IF EXISTS `borrower_attribute_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_attribute_types` (
  `code` varchar(10) NOT NULL,
  `description` varchar(255) NOT NULL,
  `repeatable` tinyint(1) NOT NULL DEFAULT '0',
  `unique_id` tinyint(1) NOT NULL DEFAULT '0',
  `opac_display` tinyint(1) NOT NULL DEFAULT '0',
  `password_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `staff_searchable` tinyint(1) NOT NULL DEFAULT '0',
  `authorised_value_category` varchar(10) DEFAULT NULL,
  `display_checkout` tinyint(1) NOT NULL DEFAULT '0',
  `category_code` varchar(10) DEFAULT NULL,
  `class` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`code`),
  KEY `auth_val_cat_idx` (`authorised_value_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_attribute_types`
--

LOCK TABLES `borrower_attribute_types` WRITE;
/*!40000 ALTER TABLE `borrower_attribute_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_attribute_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_attribute_types_branches`
--

DROP TABLE IF EXISTS `borrower_attribute_types_branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_attribute_types_branches` (
  `bat_code` varchar(10) DEFAULT NULL,
  `b_branchcode` varchar(10) DEFAULT NULL,
  KEY `bat_code` (`bat_code`),
  KEY `b_branchcode` (`b_branchcode`),
  CONSTRAINT `borrower_attribute_types_branches_ibfk_1` FOREIGN KEY (`bat_code`) REFERENCES `borrower_attribute_types` (`code`) ON DELETE CASCADE,
  CONSTRAINT `borrower_attribute_types_branches_ibfk_2` FOREIGN KEY (`b_branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_attribute_types_branches`
--

LOCK TABLES `borrower_attribute_types_branches` WRITE;
/*!40000 ALTER TABLE `borrower_attribute_types_branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_attribute_types_branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_attributes`
--

DROP TABLE IF EXISTS `borrower_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_attributes` (
  `borrowernumber` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `attribute` varchar(255) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  KEY `borrowernumber` (`borrowernumber`),
  KEY `code_attribute` (`code`,`attribute`),
  CONSTRAINT `borrower_attributes_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_attributes_ibfk_2` FOREIGN KEY (`code`) REFERENCES `borrower_attribute_types` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_attributes`
--

LOCK TABLES `borrower_attributes` WRITE;
/*!40000 ALTER TABLE `borrower_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_debarments`
--

DROP TABLE IF EXISTS `borrower_debarments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_debarments` (
  `borrower_debarment_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `expiration` date DEFAULT NULL,
  `type` enum('SUSPENSION','OVERDUES','MANUAL') NOT NULL DEFAULT 'MANUAL',
  `comment` text,
  `manager_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`borrower_debarment_id`),
  KEY `borrowernumber` (`borrowernumber`),
  CONSTRAINT `borrower_debarments_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_debarments`
--

LOCK TABLES `borrower_debarments` WRITE;
/*!40000 ALTER TABLE `borrower_debarments` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_debarments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_files`
--

DROP TABLE IF EXISTS `borrower_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_files` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_description` varchar(255) DEFAULT NULL,
  `file_content` longblob NOT NULL,
  `date_uploaded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`file_id`),
  KEY `borrowernumber` (`borrowernumber`),
  CONSTRAINT `borrower_files_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_files`
--

LOCK TABLES `borrower_files` WRITE;
/*!40000 ALTER TABLE `borrower_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_message_preferences`
--

DROP TABLE IF EXISTS `borrower_message_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_message_preferences` (
  `borrower_message_preference_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) DEFAULT NULL,
  `categorycode` varchar(10) DEFAULT NULL,
  `message_attribute_id` int(11) DEFAULT '0',
  `days_in_advance` int(11) DEFAULT '0',
  `wants_digest` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`borrower_message_preference_id`),
  KEY `borrowernumber` (`borrowernumber`),
  KEY `categorycode` (`categorycode`),
  KEY `message_attribute_id` (`message_attribute_id`),
  CONSTRAINT `borrower_message_preferences_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_preferences_ibfk_2` FOREIGN KEY (`message_attribute_id`) REFERENCES `message_attributes` (`message_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_preferences_ibfk_3` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_message_preferences`
--

LOCK TABLES `borrower_message_preferences` WRITE;
/*!40000 ALTER TABLE `borrower_message_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_message_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_message_transport_preferences`
--

DROP TABLE IF EXISTS `borrower_message_transport_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_message_transport_preferences` (
  `borrower_message_preference_id` int(11) NOT NULL DEFAULT '0',
  `message_transport_type` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`borrower_message_preference_id`,`message_transport_type`),
  KEY `message_transport_type` (`message_transport_type`),
  CONSTRAINT `borrower_message_transport_preferences_ibfk_1` FOREIGN KEY (`borrower_message_preference_id`) REFERENCES `borrower_message_preferences` (`borrower_message_preference_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_transport_preferences_ibfk_2` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_message_transport_preferences`
--

LOCK TABLES `borrower_message_transport_preferences` WRITE;
/*!40000 ALTER TABLE `borrower_message_transport_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_message_transport_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_modifications`
--

DROP TABLE IF EXISTS `borrower_modifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_modifications` (
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `verification_token` varchar(255) NOT NULL DEFAULT '',
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `cardnumber` varchar(16) DEFAULT NULL,
  `surname` mediumtext,
  `firstname` text,
  `title` mediumtext,
  `othernames` mediumtext,
  `initials` text,
  `streetnumber` varchar(10) DEFAULT NULL,
  `streettype` varchar(50) DEFAULT NULL,
  `address` mediumtext,
  `address2` text,
  `city` mediumtext,
  `state` text,
  `zipcode` varchar(25) DEFAULT NULL,
  `country` text,
  `email` mediumtext,
  `phone` text,
  `mobile` varchar(50) DEFAULT NULL,
  `fax` mediumtext,
  `emailpro` text,
  `phonepro` text,
  `B_streetnumber` varchar(10) DEFAULT NULL,
  `B_streettype` varchar(50) DEFAULT NULL,
  `B_address` varchar(100) DEFAULT NULL,
  `B_address2` text,
  `B_city` mediumtext,
  `B_state` text,
  `B_zipcode` varchar(25) DEFAULT NULL,
  `B_country` text,
  `B_email` text,
  `B_phone` mediumtext,
  `dateofbirth` date DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `categorycode` varchar(10) DEFAULT NULL,
  `dateenrolled` date DEFAULT NULL,
  `dateexpiry` date DEFAULT NULL,
  `gonenoaddress` tinyint(1) DEFAULT NULL,
  `lost` tinyint(1) DEFAULT NULL,
  `debarred` date DEFAULT NULL,
  `debarredcomment` varchar(255) DEFAULT NULL,
  `contactname` mediumtext,
  `contactfirstname` text,
  `contacttitle` text,
  `guarantorid` int(11) DEFAULT NULL,
  `borrowernotes` mediumtext,
  `relationship` varchar(100) DEFAULT NULL,
  `ethnicity` varchar(50) DEFAULT NULL,
  `ethnotes` varchar(255) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `flags` int(11) DEFAULT NULL,
  `userid` varchar(75) DEFAULT NULL,
  `opacnote` mediumtext,
  `contactnote` varchar(255) DEFAULT NULL,
  `sort1` varchar(80) DEFAULT NULL,
  `sort2` varchar(80) DEFAULT NULL,
  `altcontactfirstname` varchar(255) DEFAULT NULL,
  `altcontactsurname` varchar(255) DEFAULT NULL,
  `altcontactaddress1` varchar(255) DEFAULT NULL,
  `altcontactaddress2` varchar(255) DEFAULT NULL,
  `altcontactaddress3` varchar(255) DEFAULT NULL,
  `altcontactstate` text,
  `altcontactzipcode` varchar(50) DEFAULT NULL,
  `altcontactcountry` text,
  `altcontactphone` varchar(50) DEFAULT NULL,
  `smsalertnumber` varchar(50) DEFAULT NULL,
  `privacy` int(11) DEFAULT NULL,
  PRIMARY KEY (`verification_token`,`borrowernumber`),
  KEY `verification_token` (`verification_token`),
  KEY `borrowernumber` (`borrowernumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_modifications`
--

LOCK TABLES `borrower_modifications` WRITE;
/*!40000 ALTER TABLE `borrower_modifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_modifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrowers`
--

DROP TABLE IF EXISTS `borrowers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrowers` (
  `borrowernumber` int(11) NOT NULL AUTO_INCREMENT,
  `cardnumber` varchar(16) DEFAULT NULL,
  `surname` mediumtext NOT NULL,
  `firstname` text,
  `title` mediumtext,
  `othernames` mediumtext,
  `initials` text,
  `streetnumber` varchar(10) DEFAULT NULL,
  `streettype` varchar(50) DEFAULT NULL,
  `address` mediumtext NOT NULL,
  `address2` text,
  `city` mediumtext NOT NULL,
  `state` text,
  `zipcode` varchar(25) DEFAULT NULL,
  `country` text,
  `email` mediumtext,
  `phone` text,
  `mobile` varchar(50) DEFAULT NULL,
  `fax` mediumtext,
  `emailpro` text,
  `phonepro` text,
  `B_streetnumber` varchar(10) DEFAULT NULL,
  `B_streettype` varchar(50) DEFAULT NULL,
  `B_address` varchar(100) DEFAULT NULL,
  `B_address2` text,
  `B_city` mediumtext,
  `B_state` text,
  `B_zipcode` varchar(25) DEFAULT NULL,
  `B_country` text,
  `B_email` text,
  `B_phone` mediumtext,
  `dateofbirth` date DEFAULT NULL,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `dateenrolled` date DEFAULT NULL,
  `dateexpiry` date DEFAULT NULL,
  `gonenoaddress` tinyint(1) DEFAULT NULL,
  `lost` tinyint(1) DEFAULT NULL,
  `debarred` date DEFAULT NULL,
  `debarredcomment` varchar(255) DEFAULT NULL,
  `contactname` mediumtext,
  `contactfirstname` text,
  `contacttitle` text,
  `guarantorid` int(11) DEFAULT NULL,
  `borrowernotes` mediumtext,
  `relationship` varchar(100) DEFAULT NULL,
  `ethnicity` varchar(50) DEFAULT NULL,
  `ethnotes` varchar(255) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `flags` int(11) DEFAULT NULL,
  `userid` varchar(75) DEFAULT NULL,
  `opacnote` mediumtext,
  `contactnote` varchar(255) DEFAULT NULL,
  `sort1` varchar(80) DEFAULT NULL,
  `sort2` varchar(80) DEFAULT NULL,
  `altcontactfirstname` varchar(255) DEFAULT NULL,
  `altcontactsurname` varchar(255) DEFAULT NULL,
  `altcontactaddress1` varchar(255) DEFAULT NULL,
  `altcontactaddress2` varchar(255) DEFAULT NULL,
  `altcontactaddress3` varchar(255) DEFAULT NULL,
  `altcontactstate` text,
  `altcontactzipcode` varchar(50) DEFAULT NULL,
  `altcontactcountry` text,
  `altcontactphone` varchar(50) DEFAULT NULL,
  `smsalertnumber` varchar(50) DEFAULT NULL,
  `privacy` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`borrowernumber`),
  UNIQUE KEY `cardnumber` (`cardnumber`),
  KEY `categorycode` (`categorycode`),
  KEY `branchcode` (`branchcode`),
  KEY `userid` (`userid`),
  KEY `guarantorid` (`guarantorid`),
  KEY `surname_idx` (`surname`(255)),
  KEY `firstname_idx` (`firstname`(255)),
  KEY `othernames_idx` (`othernames`(255)),
  CONSTRAINT `borrowers_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`),
  CONSTRAINT `borrowers_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrowers`
--

LOCK TABLES `borrowers` WRITE;
/*!40000 ALTER TABLE `borrowers` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrowers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_borrower_circ_rules`
--

DROP TABLE IF EXISTS `branch_borrower_circ_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch_borrower_circ_rules` (
  `branchcode` varchar(10) NOT NULL,
  `categorycode` varchar(10) NOT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  PRIMARY KEY (`categorycode`,`branchcode`),
  KEY `branch_borrower_circ_rules_ibfk_2` (`branchcode`),
  CONSTRAINT `branch_borrower_circ_rules_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branch_borrower_circ_rules_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch_borrower_circ_rules`
--

LOCK TABLES `branch_borrower_circ_rules` WRITE;
/*!40000 ALTER TABLE `branch_borrower_circ_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch_borrower_circ_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_item_rules`
--

DROP TABLE IF EXISTS `branch_item_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch_item_rules` (
  `branchcode` varchar(10) NOT NULL,
  `itemtype` varchar(10) NOT NULL,
  `holdallowed` tinyint(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`itemtype`,`branchcode`),
  KEY `branch_item_rules_ibfk_2` (`branchcode`),
  CONSTRAINT `branch_item_rules_ibfk_1` FOREIGN KEY (`itemtype`) REFERENCES `itemtypes` (`itemtype`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branch_item_rules_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch_item_rules`
--

LOCK TABLES `branch_item_rules` WRITE;
/*!40000 ALTER TABLE `branch_item_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch_item_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_transfer_limits`
--

DROP TABLE IF EXISTS `branch_transfer_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch_transfer_limits` (
  `limitId` int(8) NOT NULL AUTO_INCREMENT,
  `toBranch` varchar(10) NOT NULL,
  `fromBranch` varchar(10) NOT NULL,
  `itemtype` varchar(10) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`limitId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch_transfer_limits`
--

LOCK TABLES `branch_transfer_limits` WRITE;
/*!40000 ALTER TABLE `branch_transfer_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch_transfer_limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branchcategories`
--

DROP TABLE IF EXISTS `branchcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branchcategories` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `categoryname` varchar(32) DEFAULT NULL,
  `codedescription` mediumtext,
  `categorytype` varchar(16) DEFAULT NULL,
  `show_in_pulldown` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`categorycode`),
  KEY `show_in_pulldown` (`show_in_pulldown`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branchcategories`
--

LOCK TABLES `branchcategories` WRITE;
/*!40000 ALTER TABLE `branchcategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `branchcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branches` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `branchname` mediumtext NOT NULL,
  `branchaddress1` mediumtext,
  `branchaddress2` mediumtext,
  `branchaddress3` mediumtext,
  `branchzip` varchar(25) DEFAULT NULL,
  `branchcity` mediumtext,
  `branchstate` mediumtext,
  `branchcountry` text,
  `branchphone` mediumtext,
  `branchfax` mediumtext,
  `branchemail` mediumtext,
  `branchurl` mediumtext,
  `issuing` tinyint(4) DEFAULT NULL,
  `branchip` varchar(15) DEFAULT NULL,
  `branchprinter` varchar(100) DEFAULT NULL,
  `branchnotes` mediumtext,
  `opac_info` text,
  PRIMARY KEY (`branchcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branchrelations`
--

DROP TABLE IF EXISTS `branchrelations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branchrelations` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`branchcode`,`categorycode`),
  KEY `branchcode` (`branchcode`),
  KEY `categorycode` (`categorycode`),
  CONSTRAINT `branchrelations_ibfk_1` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchrelations_ibfk_2` FOREIGN KEY (`categorycode`) REFERENCES `branchcategories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branchrelations`
--

LOCK TABLES `branchrelations` WRITE;
/*!40000 ALTER TABLE `branchrelations` DISABLE KEYS */;
/*!40000 ALTER TABLE `branchrelations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branchtransfers`
--

DROP TABLE IF EXISTS `branchtransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branchtransfers` (
  `itemnumber` int(11) NOT NULL DEFAULT '0',
  `datesent` datetime DEFAULT NULL,
  `frombranch` varchar(10) NOT NULL DEFAULT '',
  `datearrived` datetime DEFAULT NULL,
  `tobranch` varchar(10) NOT NULL DEFAULT '',
  `comments` mediumtext,
  KEY `frombranch` (`frombranch`),
  KEY `tobranch` (`tobranch`),
  KEY `itemnumber` (`itemnumber`),
  CONSTRAINT `branchtransfers_ibfk_1` FOREIGN KEY (`frombranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchtransfers_ibfk_2` FOREIGN KEY (`tobranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchtransfers_ibfk_3` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branchtransfers`
--

LOCK TABLES `branchtransfers` WRITE;
/*!40000 ALTER TABLE `branchtransfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `branchtransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `browser`
--

DROP TABLE IF EXISTS `browser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `browser` (
  `level` int(11) NOT NULL,
  `classification` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `number` bigint(20) NOT NULL,
  `endnode` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `browser`
--

LOCK TABLES `browser` WRITE;
/*!40000 ALTER TABLE `browser` DISABLE KEYS */;
/*!40000 ALTER TABLE `browser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `enrolmentperiod` smallint(6) DEFAULT NULL,
  `enrolmentperioddate` date DEFAULT NULL,
  `upperagelimit` smallint(6) DEFAULT NULL,
  `dateofbirthrequired` tinyint(1) DEFAULT NULL,
  `finetype` varchar(30) DEFAULT NULL,
  `bulk` tinyint(1) DEFAULT NULL,
  `enrolmentfee` decimal(28,6) DEFAULT NULL,
  `overduenoticerequired` tinyint(1) DEFAULT NULL,
  `issuelimit` smallint(6) DEFAULT NULL,
  `reservefee` decimal(28,6) DEFAULT NULL,
  `hidelostitems` tinyint(1) NOT NULL DEFAULT '0',
  `category_type` varchar(1) NOT NULL DEFAULT 'A',
  `BlockExpiredPatronOpacActions` tinyint(1) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`categorycode`),
  UNIQUE KEY `categorycode` (`categorycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_branches`
--

DROP TABLE IF EXISTS `categories_branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_branches` (
  `categorycode` varchar(10) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  KEY `categorycode` (`categorycode`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `categories_branches_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE,
  CONSTRAINT `categories_branches_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_branches`
--

LOCK TABLES `categories_branches` WRITE;
/*!40000 ALTER TABLE `categories_branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `cityid` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(100) NOT NULL DEFAULT '',
  `city_state` varchar(100) DEFAULT NULL,
  `city_country` varchar(100) DEFAULT NULL,
  `city_zipcode` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_sort_rules`
--

DROP TABLE IF EXISTS `class_sort_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_sort_rules` (
  `class_sort_rule` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `sort_routine` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`class_sort_rule`),
  UNIQUE KEY `class_sort_rule_idx` (`class_sort_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_sort_rules`
--

LOCK TABLES `class_sort_rules` WRITE;
/*!40000 ALTER TABLE `class_sort_rules` DISABLE KEYS */;
INSERT INTO `class_sort_rules` VALUES ('dewey','Default filing rules for DDC','Dewey'),('generic','Generic call number filing rules','Generic'),('lcc','Default filing rules for LCC','LCC');
/*!40000 ALTER TABLE `class_sort_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_sources`
--

DROP TABLE IF EXISTS `class_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_sources` (
  `cn_source` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `used` tinyint(4) NOT NULL DEFAULT '0',
  `class_sort_rule` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`cn_source`),
  UNIQUE KEY `cn_source_idx` (`cn_source`),
  KEY `used_idx` (`used`),
  KEY `class_source_ibfk_1` (`class_sort_rule`),
  CONSTRAINT `class_source_ibfk_1` FOREIGN KEY (`class_sort_rule`) REFERENCES `class_sort_rules` (`class_sort_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_sources`
--

LOCK TABLES `class_sources` WRITE;
/*!40000 ALTER TABLE `class_sources` DISABLE KEYS */;
INSERT INTO `class_sources` VALUES ('anscr','ANSCR (Sound Recordings)',0,'generic'),('ddc','Dewey Decimal Classification',1,'dewey'),('lcc','Library of Congress Classification',1,'lcc'),('sudocs','SuDoc Classification (U.S. GPO)',0,'generic'),('udc','Universal Decimal Classification',0,'generic'),('z','Other/Generic Classification Scheme',0,'generic');
/*!40000 ALTER TABLE `class_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections` (
  `colId` int(11) NOT NULL AUTO_INCREMENT,
  `colTitle` varchar(100) NOT NULL DEFAULT '',
  `colDesc` text NOT NULL,
  `colBranchcode` varchar(4) DEFAULT NULL COMMENT 'branchcode for branch where item should be held.',
  PRIMARY KEY (`colId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collections_tracking`
--

DROP TABLE IF EXISTS `collections_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections_tracking` (
  `collections_tracking_id` int(11) NOT NULL AUTO_INCREMENT,
  `colId` int(11) NOT NULL DEFAULT '0' COMMENT 'collections.colId',
  `itemnumber` int(11) NOT NULL DEFAULT '0' COMMENT 'items.itemnumber',
  PRIMARY KEY (`collections_tracking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections_tracking`
--

LOCK TABLES `collections_tracking` WRITE;
/*!40000 ALTER TABLE `collections_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `collections_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_instructors`
--

DROP TABLE IF EXISTS `course_instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_instructors` (
  `course_id` int(11) NOT NULL,
  `borrowernumber` int(11) NOT NULL,
  PRIMARY KEY (`course_id`,`borrowernumber`),
  KEY `borrowernumber` (`borrowernumber`),
  CONSTRAINT `course_instructors_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_instructors_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_instructors`
--

LOCK TABLES `course_instructors` WRITE;
/*!40000 ALTER TABLE `course_instructors` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_items`
--

DROP TABLE IF EXISTS `course_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_items` (
  `ci_id` int(11) NOT NULL AUTO_INCREMENT,
  `itemnumber` int(11) NOT NULL,
  `itype` varchar(10) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  `holdingbranch` varchar(10) DEFAULT NULL,
  `location` varchar(80) DEFAULT NULL,
  `enabled` enum('yes','no') NOT NULL DEFAULT 'no',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ci_id`),
  UNIQUE KEY `itemnumber` (`itemnumber`),
  KEY `holdingbranch` (`holdingbranch`),
  CONSTRAINT `course_items_ibfk_1` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_items_ibfk_2` FOREIGN KEY (`holdingbranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_items`
--

LOCK TABLES `course_items` WRITE;
/*!40000 ALTER TABLE `course_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_reserves`
--

DROP TABLE IF EXISTS `course_reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_reserves` (
  `cr_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `ci_id` int(11) NOT NULL,
  `staff_note` mediumtext,
  `public_note` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cr_id`),
  UNIQUE KEY `pseudo_key` (`course_id`,`ci_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `course_reserves_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_reserves`
--

LOCK TABLES `course_reserves` WRITE;
/*!40000 ALTER TABLE `course_reserves` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_reserves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `department` varchar(80) DEFAULT NULL,
  `course_number` varchar(255) DEFAULT NULL,
  `section` varchar(255) DEFAULT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `term` varchar(80) DEFAULT NULL,
  `staff_note` mediumtext,
  `public_note` mediumtext,
  `students_count` varchar(20) DEFAULT NULL,
  `enabled` enum('yes','no') NOT NULL DEFAULT 'yes',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creator_batches`
--

DROP TABLE IF EXISTS `creator_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creator_batches` (
  `label_id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` int(10) NOT NULL DEFAULT '1',
  `item_number` int(11) DEFAULT NULL,
  `borrower_number` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `branch_code` varchar(10) NOT NULL DEFAULT 'NB',
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`label_id`),
  KEY `branch_fk_constraint` (`branch_code`),
  KEY `item_fk_constraint` (`item_number`),
  KEY `borrower_fk_constraint` (`borrower_number`),
  CONSTRAINT `creator_batches_ibfk_1` FOREIGN KEY (`borrower_number`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `creator_batches_ibfk_2` FOREIGN KEY (`branch_code`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE,
  CONSTRAINT `creator_batches_ibfk_3` FOREIGN KEY (`item_number`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creator_batches`
--

LOCK TABLES `creator_batches` WRITE;
/*!40000 ALTER TABLE `creator_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `creator_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creator_images`
--

DROP TABLE IF EXISTS `creator_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creator_images` (
  `image_id` int(4) NOT NULL AUTO_INCREMENT,
  `imagefile` mediumblob,
  `image_name` char(20) NOT NULL DEFAULT 'DEFAULT',
  PRIMARY KEY (`image_id`),
  UNIQUE KEY `image_name_index` (`image_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creator_images`
--

LOCK TABLES `creator_images` WRITE;
/*!40000 ALTER TABLE `creator_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `creator_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creator_layouts`
--

DROP TABLE IF EXISTS `creator_layouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creator_layouts` (
  `layout_id` int(4) NOT NULL AUTO_INCREMENT,
  `barcode_type` char(100) NOT NULL DEFAULT 'CODE39',
  `start_label` int(2) NOT NULL DEFAULT '1',
  `printing_type` char(32) NOT NULL DEFAULT 'BAR',
  `layout_name` char(20) NOT NULL DEFAULT 'DEFAULT',
  `guidebox` int(1) DEFAULT '0',
  `font` char(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'TR',
  `font_size` int(4) NOT NULL DEFAULT '10',
  `units` char(20) NOT NULL DEFAULT 'POINT',
  `callnum_split` int(1) DEFAULT '0',
  `text_justify` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'L',
  `format_string` varchar(210) NOT NULL DEFAULT 'barcode',
  `layout_xml` text NOT NULL,
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`layout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creator_layouts`
--

LOCK TABLES `creator_layouts` WRITE;
/*!40000 ALTER TABLE `creator_layouts` DISABLE KEYS */;
/*!40000 ALTER TABLE `creator_layouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creator_templates`
--

DROP TABLE IF EXISTS `creator_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creator_templates` (
  `template_id` int(4) NOT NULL AUTO_INCREMENT,
  `profile_id` int(4) DEFAULT NULL,
  `template_code` char(100) NOT NULL DEFAULT 'DEFAULT TEMPLATE',
  `template_desc` char(100) NOT NULL DEFAULT 'Default description',
  `page_width` float NOT NULL DEFAULT '0',
  `page_height` float NOT NULL DEFAULT '0',
  `label_width` float NOT NULL DEFAULT '0',
  `label_height` float NOT NULL DEFAULT '0',
  `top_text_margin` float NOT NULL DEFAULT '0',
  `left_text_margin` float NOT NULL DEFAULT '0',
  `top_margin` float NOT NULL DEFAULT '0',
  `left_margin` float NOT NULL DEFAULT '0',
  `cols` int(2) NOT NULL DEFAULT '0',
  `rows` int(2) NOT NULL DEFAULT '0',
  `col_gap` float NOT NULL DEFAULT '0',
  `row_gap` float NOT NULL DEFAULT '0',
  `units` char(20) NOT NULL DEFAULT 'POINT',
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`template_id`),
  KEY `template_profile_fk_constraint` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creator_templates`
--

LOCK TABLES `creator_templates` WRITE;
/*!40000 ALTER TABLE `creator_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `creator_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `currency` varchar(10) NOT NULL DEFAULT '',
  `symbol` varchar(5) DEFAULT NULL,
  `isocode` varchar(5) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rate` float(15,5) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_borrower_circ_rules`
--

DROP TABLE IF EXISTS `default_borrower_circ_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_borrower_circ_rules` (
  `categorycode` varchar(10) NOT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  PRIMARY KEY (`categorycode`),
  CONSTRAINT `borrower_borrower_circ_rules_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_borrower_circ_rules`
--

LOCK TABLES `default_borrower_circ_rules` WRITE;
/*!40000 ALTER TABLE `default_borrower_circ_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_borrower_circ_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_branch_circ_rules`
--

DROP TABLE IF EXISTS `default_branch_circ_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_branch_circ_rules` (
  `branchcode` varchar(10) NOT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  `holdallowed` tinyint(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`branchcode`),
  CONSTRAINT `default_branch_circ_rules_ibfk_1` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_branch_circ_rules`
--

LOCK TABLES `default_branch_circ_rules` WRITE;
/*!40000 ALTER TABLE `default_branch_circ_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_branch_circ_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_branch_item_rules`
--

DROP TABLE IF EXISTS `default_branch_item_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_branch_item_rules` (
  `itemtype` varchar(10) NOT NULL,
  `holdallowed` tinyint(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`itemtype`),
  CONSTRAINT `default_branch_item_rules_ibfk_1` FOREIGN KEY (`itemtype`) REFERENCES `itemtypes` (`itemtype`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_branch_item_rules`
--

LOCK TABLES `default_branch_item_rules` WRITE;
/*!40000 ALTER TABLE `default_branch_item_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_branch_item_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_circ_rules`
--

DROP TABLE IF EXISTS `default_circ_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_circ_rules` (
  `singleton` enum('singleton') NOT NULL DEFAULT 'singleton',
  `maxissueqty` int(4) DEFAULT NULL,
  `holdallowed` int(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`singleton`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_circ_rules`
--

LOCK TABLES `default_circ_rules` WRITE;
/*!40000 ALTER TABLE `default_circ_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_circ_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deletedbiblio`
--

DROP TABLE IF EXISTS `deletedbiblio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deletedbiblio` (
  `biblionumber` int(11) NOT NULL AUTO_INCREMENT,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `author` mediumtext,
  `title` mediumtext,
  `unititle` mediumtext,
  `notes` mediumtext,
  `serial` tinyint(1) DEFAULT NULL,
  `seriestitle` mediumtext,
  `copyrightdate` smallint(6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datecreated` date NOT NULL,
  `abstract` mediumtext,
  PRIMARY KEY (`biblionumber`),
  KEY `blbnoidx` (`biblionumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deletedbiblio`
--

LOCK TABLES `deletedbiblio` WRITE;
/*!40000 ALTER TABLE `deletedbiblio` DISABLE KEYS */;
/*!40000 ALTER TABLE `deletedbiblio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deletedbiblioitems`
--

DROP TABLE IF EXISTS `deletedbiblioitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deletedbiblioitems` (
  `biblioitemnumber` int(11) NOT NULL DEFAULT '0',
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `volume` mediumtext,
  `number` mediumtext,
  `itemtype` varchar(10) DEFAULT NULL,
  `isbn` mediumtext,
  `issn` mediumtext,
  `ean` varchar(13) DEFAULT NULL,
  `publicationyear` text,
  `publishercode` varchar(255) DEFAULT NULL,
  `volumedate` date DEFAULT NULL,
  `volumedesc` text,
  `collectiontitle` mediumtext,
  `collectionissn` text,
  `collectionvolume` mediumtext,
  `editionstatement` text,
  `editionresponsibility` text,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `illus` varchar(255) DEFAULT NULL,
  `pages` varchar(255) DEFAULT NULL,
  `notes` mediumtext,
  `size` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `lccn` varchar(25) DEFAULT NULL,
  `marc` longblob,
  `url` text,
  `cn_source` varchar(10) DEFAULT NULL,
  `cn_class` varchar(30) DEFAULT NULL,
  `cn_item` varchar(10) DEFAULT NULL,
  `cn_suffix` varchar(10) DEFAULT NULL,
  `cn_sort` varchar(30) DEFAULT NULL,
  `agerestriction` varchar(255) DEFAULT NULL,
  `totalissues` int(10) DEFAULT NULL,
  `marcxml` longtext NOT NULL,
  PRIMARY KEY (`biblioitemnumber`),
  KEY `bibinoidx` (`biblioitemnumber`),
  KEY `bibnoidx` (`biblionumber`),
  KEY `itemtype_idx` (`itemtype`),
  KEY `isbn` (`isbn`(255)),
  KEY `publishercode` (`publishercode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deletedbiblioitems`
--

LOCK TABLES `deletedbiblioitems` WRITE;
/*!40000 ALTER TABLE `deletedbiblioitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `deletedbiblioitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deletedborrowers`
--

DROP TABLE IF EXISTS `deletedborrowers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deletedborrowers` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `cardnumber` varchar(16) DEFAULT NULL,
  `surname` mediumtext NOT NULL,
  `firstname` text,
  `title` mediumtext,
  `othernames` mediumtext,
  `initials` text,
  `streetnumber` varchar(10) DEFAULT NULL,
  `streettype` varchar(50) DEFAULT NULL,
  `address` mediumtext NOT NULL,
  `address2` text,
  `city` mediumtext NOT NULL,
  `state` text,
  `zipcode` varchar(25) DEFAULT NULL,
  `country` text,
  `email` mediumtext,
  `phone` text,
  `mobile` varchar(50) DEFAULT NULL,
  `fax` mediumtext,
  `emailpro` text,
  `phonepro` text,
  `B_streetnumber` varchar(10) DEFAULT NULL,
  `B_streettype` varchar(50) DEFAULT NULL,
  `B_address` varchar(100) DEFAULT NULL,
  `B_address2` text,
  `B_city` mediumtext,
  `B_state` text,
  `B_zipcode` varchar(25) DEFAULT NULL,
  `B_country` text,
  `B_email` text,
  `B_phone` mediumtext,
  `dateofbirth` date DEFAULT NULL,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `dateenrolled` date DEFAULT NULL,
  `dateexpiry` date DEFAULT NULL,
  `gonenoaddress` tinyint(1) DEFAULT NULL,
  `lost` tinyint(1) DEFAULT NULL,
  `debarred` date DEFAULT NULL,
  `debarredcomment` varchar(255) DEFAULT NULL,
  `contactname` mediumtext,
  `contactfirstname` text,
  `contacttitle` text,
  `guarantorid` int(11) DEFAULT NULL,
  `borrowernotes` mediumtext,
  `relationship` varchar(100) DEFAULT NULL,
  `ethnicity` varchar(50) DEFAULT NULL,
  `ethnotes` varchar(255) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `flags` int(11) DEFAULT NULL,
  `userid` varchar(30) DEFAULT NULL,
  `opacnote` mediumtext,
  `contactnote` varchar(255) DEFAULT NULL,
  `sort1` varchar(80) DEFAULT NULL,
  `sort2` varchar(80) DEFAULT NULL,
  `altcontactfirstname` varchar(255) DEFAULT NULL,
  `altcontactsurname` varchar(255) DEFAULT NULL,
  `altcontactaddress1` varchar(255) DEFAULT NULL,
  `altcontactaddress2` varchar(255) DEFAULT NULL,
  `altcontactaddress3` varchar(255) DEFAULT NULL,
  `altcontactstate` text,
  `altcontactzipcode` varchar(50) DEFAULT NULL,
  `altcontactcountry` text,
  `altcontactphone` varchar(50) DEFAULT NULL,
  `smsalertnumber` varchar(50) DEFAULT NULL,
  `privacy` int(11) NOT NULL DEFAULT '1',
  KEY `borrowernumber` (`borrowernumber`),
  KEY `cardnumber` (`cardnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deletedborrowers`
--

LOCK TABLES `deletedborrowers` WRITE;
/*!40000 ALTER TABLE `deletedborrowers` DISABLE KEYS */;
/*!40000 ALTER TABLE `deletedborrowers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleteditems`
--

DROP TABLE IF EXISTS `deleteditems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleteditems` (
  `itemnumber` int(11) NOT NULL DEFAULT '0',
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `biblioitemnumber` int(11) NOT NULL DEFAULT '0',
  `barcode` varchar(20) DEFAULT NULL,
  `dateaccessioned` date DEFAULT NULL,
  `booksellerid` mediumtext,
  `homebranch` varchar(10) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `replacementprice` decimal(8,2) DEFAULT NULL,
  `replacementpricedate` date DEFAULT NULL,
  `datelastborrowed` date DEFAULT NULL,
  `datelastseen` date DEFAULT NULL,
  `stack` tinyint(1) DEFAULT NULL,
  `notforloan` tinyint(1) NOT NULL DEFAULT '0',
  `damaged` tinyint(1) NOT NULL DEFAULT '0',
  `itemlost` tinyint(1) NOT NULL DEFAULT '0',
  `itemlost_on` datetime DEFAULT NULL,
  `withdrawn` tinyint(1) NOT NULL DEFAULT '0',
  `withdrawn_on` datetime DEFAULT NULL,
  `itemcallnumber` varchar(255) DEFAULT NULL,
  `coded_location_qualifier` varchar(10) DEFAULT NULL,
  `issues` smallint(6) DEFAULT NULL,
  `renewals` smallint(6) DEFAULT NULL,
  `reserves` smallint(6) DEFAULT NULL,
  `restricted` tinyint(1) DEFAULT NULL,
  `itemnotes` mediumtext,
  `holdingbranch` varchar(10) DEFAULT NULL,
  `paidfor` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location` varchar(80) DEFAULT NULL,
  `permanent_location` varchar(80) DEFAULT NULL,
  `onloan` date DEFAULT NULL,
  `cn_source` varchar(10) DEFAULT NULL,
  `cn_sort` varchar(30) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  `materials` text,
  `uri` varchar(255) DEFAULT NULL,
  `itype` varchar(10) DEFAULT NULL,
  `more_subfields_xml` longtext,
  `enumchron` text,
  `copynumber` varchar(32) DEFAULT NULL,
  `stocknumber` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`itemnumber`),
  KEY `delitembarcodeidx` (`barcode`),
  KEY `delitemstocknumberidx` (`stocknumber`),
  KEY `delitembinoidx` (`biblioitemnumber`),
  KEY `delitembibnoidx` (`biblionumber`),
  KEY `delhomebranch` (`homebranch`),
  KEY `delholdingbranch` (`holdingbranch`),
  KEY `itype_idx` (`itype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleteditems`
--

LOCK TABLES `deleteditems` WRITE;
/*!40000 ALTER TABLE `deleteditems` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleteditems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ethnicity`
--

DROP TABLE IF EXISTS `ethnicity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ethnicity` (
  `code` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ethnicity`
--

LOCK TABLES `ethnicity` WRITE;
/*!40000 ALTER TABLE `ethnicity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ethnicity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `export_format`
--

DROP TABLE IF EXISTS `export_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `export_format` (
  `export_format_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile` varchar(255) NOT NULL,
  `description` mediumtext NOT NULL,
  `content` mediumtext NOT NULL,
  `csv_separator` varchar(2) NOT NULL,
  `field_separator` varchar(2) NOT NULL,
  `subfield_separator` varchar(2) NOT NULL,
  `encoding` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT 'marc',
  PRIMARY KEY (`export_format_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Used for CSV export';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `export_format`
--

LOCK TABLES `export_format` WRITE;
/*!40000 ALTER TABLE `export_format` DISABLE KEYS */;
/*!40000 ALTER TABLE `export_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldmapping`
--

DROP TABLE IF EXISTS `fieldmapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldmapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(255) NOT NULL,
  `frameworkcode` char(4) NOT NULL DEFAULT '',
  `fieldcode` char(3) NOT NULL,
  `subfieldcode` char(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldmapping`
--

LOCK TABLES `fieldmapping` WRITE;
/*!40000 ALTER TABLE `fieldmapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `fieldmapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hold_fill_targets`
--

DROP TABLE IF EXISTS `hold_fill_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hold_fill_targets` (
  `borrowernumber` int(11) NOT NULL,
  `biblionumber` int(11) NOT NULL,
  `itemnumber` int(11) NOT NULL,
  `source_branchcode` varchar(10) DEFAULT NULL,
  `item_level_request` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemnumber`),
  KEY `bib_branch` (`biblionumber`,`source_branchcode`),
  KEY `hold_fill_targets_ibfk_1` (`borrowernumber`),
  KEY `hold_fill_targets_ibfk_4` (`source_branchcode`),
  CONSTRAINT `hold_fill_targets_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hold_fill_targets_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hold_fill_targets_ibfk_3` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hold_fill_targets_ibfk_4` FOREIGN KEY (`source_branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hold_fill_targets`
--

LOCK TABLES `hold_fill_targets` WRITE;
/*!40000 ALTER TABLE `hold_fill_targets` DISABLE KEYS */;
/*!40000 ALTER TABLE `hold_fill_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_auths`
--

DROP TABLE IF EXISTS `import_auths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_auths` (
  `import_record_id` int(11) NOT NULL,
  `matched_authid` int(11) DEFAULT NULL,
  `control_number` varchar(25) DEFAULT NULL,
  `authorized_heading` varchar(128) DEFAULT NULL,
  `original_source` varchar(25) DEFAULT NULL,
  KEY `import_auths_ibfk_1` (`import_record_id`),
  KEY `matched_authid` (`matched_authid`),
  CONSTRAINT `import_auths_ibfk_1` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_auths`
--

LOCK TABLES `import_auths` WRITE;
/*!40000 ALTER TABLE `import_auths` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_auths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_batches`
--

DROP TABLE IF EXISTS `import_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_batches` (
  `import_batch_id` int(11) NOT NULL AUTO_INCREMENT,
  `matcher_id` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `num_records` int(11) NOT NULL DEFAULT '0',
  `num_items` int(11) NOT NULL DEFAULT '0',
  `upload_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `overlay_action` enum('replace','create_new','use_template','ignore') NOT NULL DEFAULT 'create_new',
  `nomatch_action` enum('create_new','ignore') NOT NULL DEFAULT 'create_new',
  `item_action` enum('always_add','add_only_for_matches','add_only_for_new','ignore','replace') NOT NULL DEFAULT 'always_add',
  `import_status` enum('staging','staged','importing','imported','reverting','reverted','cleaned') NOT NULL DEFAULT 'staging',
  `batch_type` enum('batch','z3950','webservice') NOT NULL DEFAULT 'batch',
  `record_type` enum('biblio','auth','holdings') NOT NULL DEFAULT 'biblio',
  `file_name` varchar(100) DEFAULT NULL,
  `comments` mediumtext,
  PRIMARY KEY (`import_batch_id`),
  KEY `branchcode` (`branchcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_batches`
--

LOCK TABLES `import_batches` WRITE;
/*!40000 ALTER TABLE `import_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_biblios`
--

DROP TABLE IF EXISTS `import_biblios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_biblios` (
  `import_record_id` int(11) NOT NULL,
  `matched_biblionumber` int(11) DEFAULT NULL,
  `control_number` varchar(25) DEFAULT NULL,
  `original_source` varchar(25) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `author` varchar(80) DEFAULT NULL,
  `isbn` varchar(30) DEFAULT NULL,
  `issn` varchar(9) DEFAULT NULL,
  `has_items` tinyint(1) NOT NULL DEFAULT '0',
  KEY `import_biblios_ibfk_1` (`import_record_id`),
  KEY `matched_biblionumber` (`matched_biblionumber`),
  KEY `title` (`title`),
  KEY `isbn` (`isbn`),
  CONSTRAINT `import_biblios_ibfk_1` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_biblios`
--

LOCK TABLES `import_biblios` WRITE;
/*!40000 ALTER TABLE `import_biblios` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_biblios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_items`
--

DROP TABLE IF EXISTS `import_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_items` (
  `import_items_id` int(11) NOT NULL AUTO_INCREMENT,
  `import_record_id` int(11) NOT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `status` enum('error','staged','imported','reverted','ignored') NOT NULL DEFAULT 'staged',
  `marcxml` longtext NOT NULL,
  `import_error` mediumtext,
  PRIMARY KEY (`import_items_id`),
  KEY `import_items_ibfk_1` (`import_record_id`),
  KEY `itemnumber` (`itemnumber`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `import_items_ibfk_1` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_items`
--

LOCK TABLES `import_items` WRITE;
/*!40000 ALTER TABLE `import_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_record_matches`
--

DROP TABLE IF EXISTS `import_record_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_record_matches` (
  `import_record_id` int(11) NOT NULL,
  `candidate_match_id` int(11) NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  KEY `record_score` (`import_record_id`,`score`),
  CONSTRAINT `import_record_matches_ibfk_1` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_record_matches`
--

LOCK TABLES `import_record_matches` WRITE;
/*!40000 ALTER TABLE `import_record_matches` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_record_matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_records`
--

DROP TABLE IF EXISTS `import_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_records` (
  `import_record_id` int(11) NOT NULL AUTO_INCREMENT,
  `import_batch_id` int(11) NOT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `record_sequence` int(11) NOT NULL DEFAULT '0',
  `upload_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `import_date` date DEFAULT NULL,
  `marc` longblob NOT NULL,
  `marcxml` longtext NOT NULL,
  `marcxml_old` longtext NOT NULL,
  `record_type` enum('biblio','auth','holdings') NOT NULL DEFAULT 'biblio',
  `overlay_status` enum('no_match','auto_match','manual_match','match_applied') NOT NULL DEFAULT 'no_match',
  `status` enum('error','staged','imported','reverted','items_reverted','ignored') NOT NULL DEFAULT 'staged',
  `import_error` mediumtext,
  `encoding` varchar(40) NOT NULL DEFAULT '',
  `z3950random` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`import_record_id`),
  KEY `branchcode` (`branchcode`),
  KEY `batch_sequence` (`import_batch_id`,`record_sequence`),
  KEY `batch_id_record_type` (`import_batch_id`,`record_type`),
  CONSTRAINT `import_records_ifbk_1` FOREIGN KEY (`import_batch_id`) REFERENCES `import_batches` (`import_batch_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_records`
--

LOCK TABLES `import_records` WRITE;
/*!40000 ALTER TABLE `import_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issues` (
  `borrowernumber` int(11) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `date_due` datetime DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `issuingbranch` varchar(18) DEFAULT NULL,
  `returndate` datetime DEFAULT NULL,
  `lastreneweddate` datetime DEFAULT NULL,
  `return` varchar(4) DEFAULT NULL,
  `renewals` tinyint(4) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `issuedate` datetime DEFAULT NULL,
  KEY `issuesborridx` (`borrowernumber`),
  KEY `itemnumber_idx` (`itemnumber`),
  KEY `branchcode_idx` (`branchcode`),
  KEY `issuingbranch_idx` (`issuingbranch`),
  KEY `bordate` (`borrowernumber`,`timestamp`),
  CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON UPDATE CASCADE,
  CONSTRAINT `issues_ibfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuingrules`
--

DROP TABLE IF EXISTS `issuingrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issuingrules` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `itemtype` varchar(10) NOT NULL DEFAULT '',
  `restrictedtype` tinyint(1) DEFAULT NULL,
  `rentaldiscount` decimal(28,6) DEFAULT NULL,
  `reservecharge` decimal(28,6) DEFAULT NULL,
  `fine` decimal(28,6) DEFAULT NULL,
  `finedays` int(11) DEFAULT NULL,
  `firstremind` int(11) DEFAULT NULL,
  `chargeperiod` int(11) DEFAULT NULL,
  `accountsent` int(11) DEFAULT NULL,
  `chargename` varchar(100) DEFAULT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  `issuelength` int(4) DEFAULT NULL,
  `lengthunit` varchar(10) DEFAULT 'days',
  `hardduedate` date DEFAULT NULL,
  `hardduedatecompare` tinyint(4) NOT NULL DEFAULT '0',
  `renewalsallowed` smallint(6) NOT NULL DEFAULT '0',
  `renewalperiod` int(4) DEFAULT NULL,
  `norenewalbefore` int(4) DEFAULT NULL,
  `reservesallowed` smallint(6) NOT NULL DEFAULT '0',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `overduefinescap` decimal(28,6) DEFAULT NULL,
  PRIMARY KEY (`branchcode`,`categorycode`,`itemtype`),
  KEY `categorycode` (`categorycode`),
  KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuingrules`
--

LOCK TABLES `issuingrules` WRITE;
/*!40000 ALTER TABLE `issuingrules` DISABLE KEYS */;
/*!40000 ALTER TABLE `issuingrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_circulation_alert_preferences`
--

DROP TABLE IF EXISTS `item_circulation_alert_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_circulation_alert_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branchcode` varchar(10) NOT NULL,
  `categorycode` varchar(10) NOT NULL,
  `item_type` varchar(10) NOT NULL,
  `notification` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branchcode` (`branchcode`,`categorycode`,`item_type`,`notification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_circulation_alert_preferences`
--

LOCK TABLES `item_circulation_alert_preferences` WRITE;
/*!40000 ALTER TABLE `item_circulation_alert_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_circulation_alert_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `itemnumber` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `biblioitemnumber` int(11) NOT NULL DEFAULT '0',
  `barcode` varchar(20) DEFAULT NULL,
  `dateaccessioned` date DEFAULT NULL,
  `booksellerid` mediumtext,
  `homebranch` varchar(10) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `replacementprice` decimal(8,2) DEFAULT NULL,
  `replacementpricedate` date DEFAULT NULL,
  `datelastborrowed` date DEFAULT NULL,
  `datelastseen` date DEFAULT NULL,
  `stack` tinyint(1) DEFAULT NULL,
  `notforloan` tinyint(1) NOT NULL DEFAULT '0',
  `damaged` tinyint(1) NOT NULL DEFAULT '0',
  `itemlost` tinyint(1) NOT NULL DEFAULT '0',
  `itemlost_on` datetime DEFAULT NULL,
  `withdrawn` tinyint(1) NOT NULL DEFAULT '0',
  `withdrawn_on` datetime DEFAULT NULL,
  `itemcallnumber` varchar(255) DEFAULT NULL,
  `coded_location_qualifier` varchar(10) DEFAULT NULL,
  `issues` smallint(6) DEFAULT NULL,
  `renewals` smallint(6) DEFAULT NULL,
  `reserves` smallint(6) DEFAULT NULL,
  `restricted` tinyint(1) DEFAULT NULL,
  `itemnotes` mediumtext,
  `holdingbranch` varchar(10) DEFAULT NULL,
  `paidfor` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location` varchar(80) DEFAULT NULL,
  `permanent_location` varchar(80) DEFAULT NULL,
  `onloan` date DEFAULT NULL,
  `cn_source` varchar(10) DEFAULT NULL,
  `cn_sort` varchar(30) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  `materials` text,
  `uri` varchar(255) DEFAULT NULL,
  `itype` varchar(10) DEFAULT NULL,
  `more_subfields_xml` longtext,
  `enumchron` text,
  `copynumber` varchar(32) DEFAULT NULL,
  `stocknumber` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`itemnumber`),
  UNIQUE KEY `itembarcodeidx` (`barcode`),
  KEY `itemstocknumberidx` (`stocknumber`),
  KEY `itembinoidx` (`biblioitemnumber`),
  KEY `itembibnoidx` (`biblionumber`),
  KEY `homebranch` (`homebranch`),
  KEY `holdingbranch` (`holdingbranch`),
  KEY `itemcallnumber` (`itemcallnumber`),
  KEY `items_location` (`location`),
  KEY `items_ccode` (`ccode`),
  KEY `itype_idx` (`itype`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`biblioitemnumber`) REFERENCES `biblioitems` (`biblioitemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `items_ibfk_2` FOREIGN KEY (`homebranch`) REFERENCES `branches` (`branchcode`) ON UPDATE CASCADE,
  CONSTRAINT `items_ibfk_3` FOREIGN KEY (`holdingbranch`) REFERENCES `branches` (`branchcode`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemtypes`
--

DROP TABLE IF EXISTS `itemtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtypes` (
  `itemtype` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `rentalcharge` double(16,4) DEFAULT NULL,
  `notforloan` smallint(6) DEFAULT NULL,
  `imageurl` varchar(200) DEFAULT NULL,
  `summary` text,
  `checkinmsg` varchar(255) DEFAULT NULL,
  `checkinmsgtype` char(16) NOT NULL DEFAULT 'message',
  `sip_media_type` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`itemtype`),
  UNIQUE KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemtypes`
--

LOCK TABLES `itemtypes` WRITE;
/*!40000 ALTER TABLE `itemtypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_descriptions`
--

DROP TABLE IF EXISTS `language_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_descriptions` (
  `subtag` varchar(25) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `lang` varchar(25) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`),
  KEY `subtag_type_lang` (`subtag`,`type`,`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_descriptions`
--

LOCK TABLES `language_descriptions` WRITE;
/*!40000 ALTER TABLE `language_descriptions` DISABLE KEYS */;
INSERT INTO `language_descriptions` VALUES ('opac','i','en','OPAC',1),('opac','i','fr','OPAC',2),('opac','i','de','OPAC',3),('intranet','i','en','Staff Client',4),('intranet','i','fr','????',5),('intranet','i','de','Dienstoberfläche',6),('prog','t','en','Prog',7),('prog','t','fr','Prog',8),('prog','t','de','Prog',9),('ar','language','ar','&#1575;&#1604;&#1593;&#1585;&#1576;&#1610;&#1577;',10),('ar','language','en','Arabic',11),('ar','language','fr','Arabe',12),('ar','language','de','Arabisch',13),('hy','language','hy','Հայերեն',14),('hy','language','en','Armenian',15),('hy','language','fr','Armenian',16),('hy','language','de','Armenisch',17),('bg','language','bg','&#1041;&#1098;&#1083;&#1075;&#1072;&#1088;&#1089;&#1082;&#1080;',18),('bg','language','en','Bulgarian',19),('bg','language','fr','Bulgare',20),('bg','language','de','Bulgarisch',21),('zh','language','zh','&#20013;&#25991;',22),('zh','language','en','Chinese',23),('zh','language','fr','Chinois',24),('zh','language','de','Chinesisch',25),('cs','language','cs','&#x010D;e&#353;tina',26),('cs','language','en','Czech',27),('cs','language','fr','Tchèque',28),('cs','language','de','Tschechisch',29),('da','language','da','Dansk',30),('da','language','en','Danish',31),('da','language','fr','Danois',32),('da','language','de','Dänisch',33),('nl','language','nl','Nederlands',34),('nl','language','en','Dutch',35),('nl','language','fr','Néerlandais',36),('nl','language','de','Niederländisch',37),('en','language','en','English',38),('en','language','fr','Anglais',39),('en','language','de','Englisch',40),('fi','language','fi','suomi',41),('fi','language','en','Finnish',42),('fi','language','de','Finnisch',43),('fr','language','en','French',44),('fr','language','fr','Fran&ccedil;ais',45),('fr','language','de','Französisch',46),('lo','language','lo','&#3742;&#3762;&#3754;&#3762;&#3749;&#3762;&#3751;',47),('lo','language','en','Lao',48),('lo','language','fr','Laotien',49),('lo','language','de','Laotisch',50),('de','language','de','Deutsch',51),('de','language','en','German',52),('de','language','fr','Allemand',53),('el','language','el','&#949;&#955;&#955;&#951;&#957;&#953;&#954;&#940;',54),('el','language','en','Greek, Modern [1453- ]',55),('el','language','fr','Grec Moderne (Après 1453)',56),('el','language','de','Griechisch (Moern [1453- ]',57),('he','language','he','&#1506;&#1489;&#1512;&#1497;&#1514;',58),('he','language','en','Hebrew',59),('he','language','fr','Hébreu',60),('he','language','de','Hebräisch',61),('hi','language','hi','&#2361;&#2367;&#2344;&#2381;&#2342;&#2368;',62),('hi','language','en','Hindi',63),('hi','language','fr','Hindi',64),('hi','language','de','Hindi',65),('hu','language','hu','Magyar',66),('hu','language','en','Hungarian',67),('hu','language','fr','Hongrois',68),('hu','language','de','Ungarisch',69),('id','language','id','Bahasa Indonesia',70),('id','language','en','Indonesian',71),('id','language','fr','Indonésien',72),('id','language','de','Indonesisch',73),('it','language','it','Italiano',74),('it','language','en','Italian',75),('it','language','fr','Italien',76),('it','language','de','Italienisch',77),('ja','language','ja','&#26085;&#26412;&#35486;',78),('ja','language','en','Japanese',79),('ja','language','fr','Japonais',80),('ja','language','de','Japanisch',81),('ko','language','ko','&#54620;&#44397;&#50612;',82),('ko','language','en','Korean',83),('ko','language','fr','Coréen',84),('ko','language','de','Koreanisch',85),('la','language','la','Latina',86),('la','language','en','Latin',87),('la','language','fr','Latin',88),('la','language','de','Latein',89),('gl','language','gl','Galego',90),('gl','language','en','Galician',91),('gl','language','fr','Galicien',92),('gl','language','de','Galicisch',93),('nb','language','nb','Norsk bokm&#229;l',94),('nb','language','en','Norwegian bokm&#229;l',95),('nb','language','fr','Norvégien bokm&#229;l',96),('nb','language','de','Norwegisch bokm&#229;l',97),('nn','language','nb','Norsk nynorsk',98),('nn','language','nn','Norsk nynorsk',99),('nn','language','en','Norwegian nynorsk',100),('nn','language','fr','Norvégien nynorsk',101),('nn','language','de','Norwegisch nynorsk',102),('fa','language','fa','&#1601;&#1575;&#1585;&#1587;&#1609;',103),('fa','language','en','Persian',104),('fa','language','fr','Persan',105),('fa','language','de','Persisch',106),('pl','language','pl','Polski',107),('pl','language','en','Polish',108),('pl','language','fr','Polonais',109),('pl','language','de','Polnisch',110),('pt','language','pt','Portugu&ecirc;s',111),('pt','language','en','Portuguese',112),('pt','language','fr','Portugais',113),('pt','language','de','Portugiesisch',114),('ro','language','ro','Rom&acirc;n&#259;',115),('ro','language','en','Romanian',116),('ro','language','fr','Roumain',117),('ro','language','de','Rumänisch',118),('ru','language','ru','&#1056;&#1091;&#1089;&#1089;&#1082;&#1080;&#1081;',119),('ru','language','en','Russian',120),('ru','language','fr','Russe',121),('ru','language','de','Russisch',122),('sr','language','sr','&#1089;&#1088;&#1087;&#1089;&#1082;&#1080;',123),('sr','language','en','Serbian',124),('sr','language','fr','Serbe',125),('sr','language','de','Serbisch',126),('es','language','es','Espa&ntilde;ol',127),('es','language','en','Spanish',128),('es','language','fr','Espagnol',129),('es','language','de','Spanisch',130),('ca','language','es','Catalán',131),('ca','language','en','Catalan',132),('ca','language','fr','Catalan',133),('ca','language','ca','Català',134),('ca','language','de','Katalanisch',135),('sv','language','sv','Svenska',136),('sv','language','en','Swedish',137),('sv','language','fr','Suédois',138),('sv','language','de','Schwedisch',139),('tet','language','tet','tetun',140),('tet','language','en','Tetum',141),('tet','language','fr','Tétoum',142),('tet','language','de','Tetum',143),('th','language','th','&#3616;&#3634;&#3625;&#3634;&#3652;&#3607;&#3618;',144),('th','language','en','Thai',145),('th','language','fr','Thaï',146),('th','language','de','Thailändisch',147),('tr','language','tr','T&uuml;rk&ccedil;e',148),('tr','language','en','Turkish',149),('tr','language','fr','Turc',150),('tr','language','de','Türkisch',151),('uk','language','uk','&#1059;&#1082;&#1088;&#1072;&#1111;&#1085;&#1089;&#1100;&#1082;&#1072;',152),('uk','language','en','Ukranian',153),('uk','language','fr','Ukrainien',154),('uk','language','de','Ukrainisch',155),('ur','language','en','Urdu',156),('ur','language','ur','&#1575;&#1585;&#1583;&#1608;',157),('ur','language','fr','Ourdou',158),('ur','language','de','Urdu',159),('Arab','script','Arab','&#1575;&#1604;&#1593;&#1585;&#1576;&#1610;&#1577;',160),('Arab','script','en','Arabic',161),('Arab','script','fr','Arabic',162),('Arab','script','de','Arabisch',163),('Cyrl','script','Cyrl','????',164),('Cyrl','script','en','Cyrillic',165),('Cyrl','script','fr','Cyrillic',166),('Cyrl','script','de','Kyrillisch',167),('Grek','script','Grek','????',168),('Grek','script','en','Greek',169),('Grek','script','fr','Greek',170),('Grek','script','de','Griechisch',171),('Hans','script','Hans','Han (Simplified variant)',172),('Hans','script','en','Han (Simplified variant)',173),('Hans','script','fr','Han (Simplified variant)',174),('Hans','script','de','Han (Vereinfachte Variante)',175),('Hant','script','Hant','Han (Traditional variant)',176),('Hant','script','en','Han (Traditional variant)',177),('Hant','script','de','Han (Traditionelle Variante)',178),('Hebr','script','Hebr','Hebrew',179),('Hebr','script','en','Hebrew',180),('Hebr','script','de','Hebräisch',181),('Laoo','script','lo','Lao',182),('Laoo','script','en','Lao',183),('Laoo','script','de','Laotisch',184),('CA','region','en','Canada',185),('DK','region','dk','Danmark',186),('FR','region','fr','France',187),('FR','region','en','France',188),('NZ','region','en','New Zealand',189),('GB','region','en','United Kingdom',190),('US','region','en','United States',191);
/*!40000 ALTER TABLE `language_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_rfc4646_to_iso639`
--

DROP TABLE IF EXISTS `language_rfc4646_to_iso639`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_rfc4646_to_iso639` (
  `rfc4646_subtag` varchar(25) DEFAULT NULL,
  `iso639_2_code` varchar(25) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `rfc4646_subtag` (`rfc4646_subtag`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_rfc4646_to_iso639`
--

LOCK TABLES `language_rfc4646_to_iso639` WRITE;
/*!40000 ALTER TABLE `language_rfc4646_to_iso639` DISABLE KEYS */;
INSERT INTO `language_rfc4646_to_iso639` VALUES ('ar','ara',1),('hy','arm',2),('bg','bul',3),('zh','chi',4),('cs','cze',5),('da','dan',6),('nl','dut',7),('en','eng',8),('fi','fin',9),('fr','fre',10),('lo','lao',11),('de','ger',12),('el','gre',13),('he','heb',14),('hi','hin',15),('hu','hun',16),('id','ind',17),('it','ita',18),('ja','jpn',19),('ko','kor',20),('la','lat',21),('gl','glg',22),('nb','nor',23),('nb','nob',24),('nn','nno',25),('fa','per',26),('pl','pol',27),('pt','por',28),('ro','rum',29),('ru','rus',30),('sr','srp',31),('es','spa',32),('ca','cat',33),('sv','swe',34),('tet','tet',35),('th','tha',36),('tr','tur',37),('uk','ukr',38),('ur','urd',39);
/*!40000 ALTER TABLE `language_rfc4646_to_iso639` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_script_bidi`
--

DROP TABLE IF EXISTS `language_script_bidi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_script_bidi` (
  `rfc4646_subtag` varchar(25) DEFAULT NULL,
  `bidi` varchar(3) DEFAULT NULL,
  KEY `rfc4646_subtag` (`rfc4646_subtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_script_bidi`
--

LOCK TABLES `language_script_bidi` WRITE;
/*!40000 ALTER TABLE `language_script_bidi` DISABLE KEYS */;
INSERT INTO `language_script_bidi` VALUES ('Arab','rtl'),('Hebr','rtl');
/*!40000 ALTER TABLE `language_script_bidi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_script_mapping`
--

DROP TABLE IF EXISTS `language_script_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_script_mapping` (
  `language_subtag` varchar(25) DEFAULT NULL,
  `script_subtag` varchar(25) DEFAULT NULL,
  KEY `language_subtag` (`language_subtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_script_mapping`
--

LOCK TABLES `language_script_mapping` WRITE;
/*!40000 ALTER TABLE `language_script_mapping` DISABLE KEYS */;
INSERT INTO `language_script_mapping` VALUES ('ar','Arab'),('he','Hebr');
/*!40000 ALTER TABLE `language_script_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_subtag_registry`
--

DROP TABLE IF EXISTS `language_subtag_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_subtag_registry` (
  `subtag` varchar(25) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `description` varchar(25) DEFAULT NULL,
  `added` date DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `subtag` (`subtag`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_subtag_registry`
--

LOCK TABLES `language_subtag_registry` WRITE;
/*!40000 ALTER TABLE `language_subtag_registry` DISABLE KEYS */;
INSERT INTO `language_subtag_registry` VALUES ('opac','i','OPAC','2005-10-16',1),('intranet','i','Staff Client','2005-10-16',2),('prog','t','Prog','2005-10-16',3),('ar','language','Arabic','2005-10-16',4),('hy','language','Armenian','2005-10-16',5),('bg','language','Bulgarian','2005-10-16',6),('zh','language','Chinese','2005-10-16',7),('cs','language','Czech','2005-10-16',8),('da','language','Danish','2005-10-16',9),('nl','language','Dutch','2005-10-16',10),('en','language','English','2005-10-16',11),('fi','language','Finnish','2005-10-16',12),('fr','language','French','2005-10-16',13),('lo','language','Lao','2005-10-16',14),('de','language','German','2005-10-16',15),('el','language','Greek, Modern [1453- ]','2005-10-16',16),('he','language','Hebrew','2005-10-16',17),('hi','language','Hindi','2005-10-16',18),('hu','language','Hungarian','2005-10-16',19),('id','language','Indonesian','2005-10-16',20),('it','language','Italian','2005-10-16',21),('ja','language','Japanese','2005-10-16',22),('ko','language','Korean','2005-10-16',23),('la','language','Latin','2005-10-16',24),('gl','language','Galician','2005-10-16',25),('nb','language','Norwegian bokm&#229;l','2005-10-16',26),('nn','language','Norwegian nynorsk','2011-02-14',27),('fa','language','Persian','2005-10-16',28),('pl','language','Polish','2005-10-16',29),('pt','language','Portuguese','2005-10-16',30),('ro','language','Romanian','2005-10-16',31),('ru','language','Russian','2005-10-16',32),('sr','language','Serbian','2005-10-16',33),('es','language','Spanish','2005-10-16',34),('ca','language','Catalan','2013-01-12',35),('sv','language','Swedish','2005-10-16',36),('tet','language','Tetum','2005-10-16',37),('th','language','Thai','2005-10-16',38),('tr','language','Turkish','2005-10-16',39),('uk','language','Ukranian','2005-10-16',40),('ur','language','Urdu','2005-10-16',41),('Arab','script','Arabic','2005-10-16',42),('Cyrl','script','Cyrillic','2005-10-16',43),('Grek','script','Greek','2005-10-16',44),('Hans','script','Han (Simplified variant)','2005-10-16',45),('Hant','script','Han (Traditional variant)','2005-10-16',46),('Hebr','script','Hebrew','2005-10-16',47),('Laoo','script','Lao','2005-10-16',48),('CA','region','Canada','2005-10-16',49),('DK','region','Denmark','2005-10-16',50),('FR','region','France','2005-10-16',51),('NZ','region','New Zealand','2005-10-16',52),('GB','region','United Kingdom','2005-10-16',53),('US','region','United States','2005-10-16',54);
/*!40000 ALTER TABLE `language_subtag_registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `letter`
--

DROP TABLE IF EXISTS `letter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `letter` (
  `module` varchar(20) NOT NULL DEFAULT '',
  `code` varchar(20) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `is_html` tinyint(1) DEFAULT '0',
  `title` varchar(200) NOT NULL DEFAULT '',
  `content` text,
  `message_transport_type` varchar(20) NOT NULL DEFAULT 'email',
  PRIMARY KEY (`module`,`code`,`branchcode`,`message_transport_type`),
  KEY `message_transport_type_fk` (`message_transport_type`),
  CONSTRAINT `message_transport_type_fk` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `letter`
--

LOCK TABLES `letter` WRITE;
/*!40000 ALTER TABLE `letter` DISABLE KEYS */;
INSERT INTO `letter` VALUES ('circulation','CHECKIN','','Item Check-in (Digest)',0,'Check-ins','The following items have been checked in:\r\n----\r\n<<biblio.title>>\r\n----\r\nThank you.','email'),('circulation','CHECKOUT','','Item Check-out (Digest)',0,'Checkouts','The following items have been checked out:\r\n----\r\n<<biblio.title>>\r\n----\r\nThank you for visiting <<branches.branchname>>.','email'),('circulation','DUE','','Item Due Reminder',0,'Item Due Reminder','Dear <<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nThe following item is now due:\r\n\r\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)','email'),('circulation','DUEDGST','','Item Due Reminder (Digest)',0,'Item Due Reminder','You have <<count>> items due','email'),('circulation','ISSUEQSLIP','','Issue Quick Slip',1,'Issue Quick Slip','<h3><<branches.branchname>></h3>\nChecked out to <<borrowers.title>> <<borrowers.firstname>> <<borrowers.initials>> <<borrowers.surname>> <br />\n(<<borrowers.cardnumber>>) <br />\n\n<<today>><br />\n\n<h4>Checked Out Today</h4>\n<checkedout>\n<p>\n<<biblio.title>> <br />\nBarcode: <<items.barcode>><br />\nDate due: <<issues.date_due>><br />\n</p>\n</checkedout>','email'),('circulation','ISSUESLIP','','Issue Slip',1,'Issue Slip','<h3><<branches.branchname>></h3>\nChecked out to <<borrowers.title>> <<borrowers.firstname>> <<borrowers.initials>> <<borrowers.surname>> <br />\n(<<borrowers.cardnumber>>) <br />\n\n<<today>><br />\n\n<h4>Checked Out</h4>\n<checkedout>\n<p>\n<<biblio.title>> <br />\nBarcode: <<items.barcode>><br />\nDate due: <<issues.date_due>><br />\n</p>\n</checkedout>\n\n<h4>Overdues</h4>\n<overdue>\n<p>\n<<biblio.title>> <br />\nBarcode: <<items.barcode>><br />\nDate due: <<issues.date_due>><br />\n</p>\n</overdue>\n\n<hr>\n\n<h4 style=\"text-align: center; font-style:italic;\">News</h4>\n<news>\n<div class=\"newsitem\">\n<h5 style=\"margin-bottom: 1px; margin-top: 1px\"><b><<opac_news.title>></b></h5>\n<p style=\"margin-bottom: 1px; margin-top: 1px\"><<opac_news.new>></p>\n<p class=\"newsfooter\" style=\"font-size: 8pt; font-style:italic; margin-bottom: 1px; margin-top: 1px\">Posted on <<opac_news.timestamp>></p>\n<hr />\n</div>\n</news>','email'),('circulation','ODUE','','Overdue Notice',0,'Item Overdue','Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nAccording to our current records, you have items that are overdue.Your library does not charge late fines, but please return or renew them at the branch below as soon as possible.\n\n<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>> <<branches.branchaddress3>>\nPhone: <<branches.branchphone>>\nFax: <<branches.branchfax>>\nEmail: <<branches.branchemail>>\n\nIf you have registered a password with the library, and you have a renewal available, you may renew online. If an item becomes more than 30 days overdue, you will be unable to use your library card until the item is returned.\n\nThe following item(s) is/are currently overdue:\n\n<item>\"<<biblio.title>>\" by <<biblio.author>>, <<items.itemcallnumber>>, Barcode: <<items.barcode>> Fine: <<items.fine>></item>\n\nThank-you for your prompt attention to this matter.\n\n<<branches.branchname>> Staff\n','email'),('circulation','PREDUE','','Advance Notice of Item Due',0,'Advance Notice of Item Due','Dear <<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nThe following item will be due soon:\r\n\r\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)','email'),('circulation','PREDUEDGST','','Advance Notice of Item Due (Digest)',0,'Advance Notice of Item Due','You have <<count>> items due soon','email'),('circulation','RENEWAL','','Item Renewals',0,'Item Renewals','The following items have been renewed:\r\n----\r\n<<biblio.title>>\r\n----\r\nThank you for visiting <<branches.branchname>>.','email'),('circulation','RESERVESLIP','','Reserve Slip',1,'Reserve Slip','<h5>Date: <<today>></h5>\n\n<h3> Transfer to/Hold in <<branches.branchname>></h3>\n\n<h3><<borrowers.surname>>, <<borrowers.firstname>></h3>\n\n<ul>\n    <li><<borrowers.cardnumber>></li>\n    <li><<borrowers.phone>></li>\n    <li> <<borrowers.address>><br />\n         <<borrowers.address2>><br />\n         <<borrowers.city >>  <<borrowers.zipcode>>\n    </li>\n    <li><<borrowers.email>></li>\n</ul>\n<br />\n<h3>ITEM ON HOLD</h3>\n<h4><<biblio.title>></h4>\n<h5><<biblio.author>></h5>\n<ul>\n   <li><<items.barcode>></li>\n   <li><<items.itemcallnumber>></li>\n   <li><<reserves.waitingdate>></li>\n</ul>\n<p>Notes:\n<pre><<reserves.reservenotes>></pre>\n</p>\n','email'),('circulation','TRANSFERSLIP','','Transfer Slip',1,'Transfer Slip','<h5>Date: <<today>></h5>\n\n<h3>Transfer to <<branches.branchname>></h3>\n\n<h3>ITEM</h3>\n<h4><<biblio.title>></h4>\n<h5><<biblio.author>></h5>\n<ul>\n   <li><<items.barcode>></li>\n   <li><<items.itemcallnumber>></li>\n</ul>','email'),('claimacquisition','ACQCLAIM','','Acquisition Claim',0,'Item Not Received','<<aqbooksellers.name>>\r\n<<aqbooksellers.address1>>\r\n<<aqbooksellers.address2>>\r\n<<aqbooksellers.address3>>\r\n<<aqbooksellers.address4>>\r\n<<aqbooksellers.phone>>\r\n\r\n<order>Ordernumber <<aqorders.ordernumber>> (<<biblio.title>>) (<<aqorders.quantity>> ordered) ($<<aqorders.listprice>> each) has not been received.</order>','email'),('members','ACCTDETAILS','','Account Details Template - DEFAULT',0,'Your new Koha account details.','Hello <<borrowers.title>> <<borrowers.firstname>> <<borrowers.surname>>.\r\n\r\nYour new Koha account details are:\r\n\r\nUser:  <<borrowers.userid>>\r\nPassword: <<borrowers.password>>\r\n\r\nIf you have any problems or questions regarding your account, please contact your Koha Administrator.\r\n\r\nThank you,\r\nKoha Administrator\r\nkohaadmin@yoursite.org','email'),('members','OPAC_REG_VERIFY','','Opac Self-Registration Verification Email',1,'Verify Your Account','Hello!\n\nYour library account has been created. Please verify your email address by clicking this link to complete the signup process:\n\nhttp://<<OPACBaseURL>>/cgi-bin/koha/opac-registration-verify.pl?token=<<borrower_modifications.verification_token>>\n\nIf you did not initiate this request, you may safely ignore this one-time message. The request will expire shortly.','email'),('members','SHARE_ACCEPT','','Notification about an accepted share',0,'Share on list <<listname>> accepted','Dear patron,\n\nWe want to inform you that <<borrowers.firstname>> <<borrowers.surname>> accepted your invitation to share your list <<listname>> in our library catalog.\n\nThank you.\n\nYour library.','email'),('members','SHARE_INVITE','','Invitation for sharing a list',0,'Share list <<listname>>','Dear patron,\n\nOne of our patrons, <<borrowers.firstname>> <<borrowers.surname>>, invites you to share a list <<listname>> in our library catalog.\n\nTo access this shared list, please click on the following URL or copy-and-paste it into your browser address bar.\n\n<<shareurl>>\n\nIn case you are not a patron in our library or do not want to accept this invitation, please ignore this mail. Note also that this invitation expires within two weeks.\n\nThank you.\n\nYour library.','email'),('reserves','HOLD','','Hold Available for Pickup',0,'Hold Available for Pickup at <<branches.branchname>>','Dear <<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nYou have a hold available for pickup as of <<reserves.waitingdate>>:\r\n\r\nTitle: <<biblio.title>>\r\nAuthor: <<biblio.author>>\r\nCopy: <<items.copynumber>>\r\nLocation: <<branches.branchname>>\r\n<<branches.branchaddress1>>\r\n<<branches.branchaddress2>>\r\n<<branches.branchaddress3>>\r\n<<branches.branchcity>> <<branches.branchzip>>','email'),('reserves','HOLD','','Hold Available for Pickup',0,'Hold Available for Pickup (print notice)','<<branches.branchname>>\r\n<<branches.branchaddress1>>\r\n<<branches.branchaddress2>>\r\n\r\n\r\nChange Service Requested\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n<<borrowers.firstname>> <<borrowers.surname>>\r\n<<borrowers.address>>\r\n<<borrowers.city>> <<borrowers.zipcode>>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n<<borrowers.firstname>> <<borrowers.surname>> <<borrowers.cardnumber>>\r\n\r\nYou have a hold available for pickup as of <<reserves.waitingdate>>:\r\n\r\nTitle: <<biblio.title>>\r\nAuthor: <<biblio.author>>\r\nCopy: <<items.copynumber>>\r\n','print'),('reserves','HOLDPLACED','','Hold Placed on Item',0,'Hold Placed on Item','A hold has been placed on the following item : <<biblio.title>> (<<biblio.biblionumber>>) by the user <<borrowers.firstname>> <<borrowers.surname>> (<<borrowers.cardnumber>>).','email'),('serial','RLIST','','Routing List',0,'Serial is now available','<<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nThe following issue is now available:\r\n\r\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)\r\n\r\nPlease pick it up at your convenience.','email'),('suggestions','ACCEPTED','','Suggestion accepted',0,'Purchase suggestion accepted','Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nYou have suggested that the library acquire <<suggestions.title>> by <<suggestions.author>>.\n\nThe library has reviewed your suggestion today. The item will be ordered as soon as possible. You will be notified by mail when the order is completed, and again when the item arrives at the library.\n\nIf you have any questions, please email us at <<branches.branchemail>>.\n\nThank you,\n\n<<branches.branchname>>','email'),('suggestions','AVAILABLE','','Suggestion available',0,'Suggested purchase available','Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nYou have suggested that the library acquire <<suggestions.title>> by <<suggestions.author>>.\n\nWe are pleased to inform you that the item you requested is now part of the collection.\n\nIf you have any questions, please email us at <<branches.branchemail>>.\n\nThank you,\n\n<<branches.branchname>>','email'),('suggestions','ORDERED','','Suggestion ordered',0,'Suggested item ordered','Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nYou have suggested that the library acquire <<suggestions.title>> by <<suggestions.author>>.\n\nWe are pleased to inform you that the item you requested has now been ordered. It should arrive soon, at which time it will be processed for addition into the collection.\n\nYou will be notified again when the book is available.\n\nIf you have any questions, please email us at <<branches.branchemail>>\n\nThank you,\n\n<<branches.branchname>>','email'),('suggestions','REJECTED','','Suggestion rejected',0,'Purchase suggestion declined','Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nYou have suggested that the library acquire <<suggestions.title>> by <<suggestions.author>>.\n\nThe library has reviewed your request today, and has decided not to accept the suggestion at this time.\n\nThe reason given is: <<suggestions.reason>>\n\nIf you have any questions, please email us at <<branches.branchemail>>.\n\nThank you,\n\n<<branches.branchname>>','email');
/*!40000 ALTER TABLE `letter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linktracker`
--

DROP TABLE IF EXISTS `linktracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `linktracker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `borrowernumber` int(11) DEFAULT NULL,
  `url` text,
  `timeclicked` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bibidx` (`biblionumber`),
  KEY `itemidx` (`itemnumber`),
  KEY `borridx` (`borrowernumber`),
  KEY `dateidx` (`timeclicked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linktracker`
--

LOCK TABLES `linktracker` WRITE;
/*!40000 ALTER TABLE `linktracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `linktracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marc_matchers`
--

DROP TABLE IF EXISTS `marc_matchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marc_matchers` (
  `matcher_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `record_type` varchar(10) NOT NULL DEFAULT 'biblio',
  `threshold` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`matcher_id`),
  KEY `code` (`code`),
  KEY `record_type` (`record_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marc_matchers`
--

LOCK TABLES `marc_matchers` WRITE;
/*!40000 ALTER TABLE `marc_matchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `marc_matchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marc_modification_template_actions`
--

DROP TABLE IF EXISTS `marc_modification_template_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marc_modification_template_actions` (
  `mmta_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) NOT NULL,
  `ordering` int(3) NOT NULL,
  `action` enum('delete_field','update_field','move_field','copy_field') NOT NULL,
  `field_number` smallint(6) NOT NULL DEFAULT '0',
  `from_field` varchar(3) NOT NULL,
  `from_subfield` varchar(1) DEFAULT NULL,
  `field_value` varchar(100) DEFAULT NULL,
  `to_field` varchar(3) DEFAULT NULL,
  `to_subfield` varchar(1) DEFAULT NULL,
  `to_regex_search` text,
  `to_regex_replace` text,
  `to_regex_modifiers` varchar(8) DEFAULT '',
  `conditional` enum('if','unless') DEFAULT NULL,
  `conditional_field` varchar(3) DEFAULT NULL,
  `conditional_subfield` varchar(1) DEFAULT NULL,
  `conditional_comparison` enum('exists','not_exists','equals','not_equals') DEFAULT NULL,
  `conditional_value` text,
  `conditional_regex` tinyint(1) NOT NULL DEFAULT '0',
  `description` text,
  PRIMARY KEY (`mmta_id`),
  KEY `mmta_ibfk_1` (`template_id`),
  CONSTRAINT `mmta_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `marc_modification_templates` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marc_modification_template_actions`
--

LOCK TABLES `marc_modification_template_actions` WRITE;
/*!40000 ALTER TABLE `marc_modification_template_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `marc_modification_template_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marc_modification_templates`
--

DROP TABLE IF EXISTS `marc_modification_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marc_modification_templates` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marc_modification_templates`
--

LOCK TABLES `marc_modification_templates` WRITE;
/*!40000 ALTER TABLE `marc_modification_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `marc_modification_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marc_subfield_structure`
--

DROP TABLE IF EXISTS `marc_subfield_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marc_subfield_structure` (
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `tagsubfield` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint(4) NOT NULL DEFAULT '0',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `kohafield` varchar(40) DEFAULT NULL,
  `tab` tinyint(1) DEFAULT NULL,
  `authorised_value` varchar(20) DEFAULT NULL,
  `authtypecode` varchar(20) DEFAULT NULL,
  `value_builder` varchar(80) DEFAULT NULL,
  `isurl` tinyint(1) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `seealso` varchar(1100) DEFAULT NULL,
  `link` varchar(80) DEFAULT NULL,
  `defaultvalue` text,
  `maxlength` int(4) NOT NULL DEFAULT '9999',
  PRIMARY KEY (`frameworkcode`,`tagfield`,`tagsubfield`),
  KEY `kohafield_2` (`kohafield`),
  KEY `tab` (`frameworkcode`,`tab`),
  KEY `kohafield` (`frameworkcode`,`kohafield`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marc_subfield_structure`
--

LOCK TABLES `marc_subfield_structure` WRITE;
/*!40000 ALTER TABLE `marc_subfield_structure` DISABLE KEYS */;
/*!40000 ALTER TABLE `marc_subfield_structure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marc_tag_structure`
--

DROP TABLE IF EXISTS `marc_tag_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marc_tag_structure` (
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint(4) NOT NULL DEFAULT '0',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `authorised_value` varchar(10) DEFAULT NULL,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`frameworkcode`,`tagfield`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marc_tag_structure`
--

LOCK TABLES `marc_tag_structure` WRITE;
/*!40000 ALTER TABLE `marc_tag_structure` DISABLE KEYS */;
/*!40000 ALTER TABLE `marc_tag_structure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchchecks`
--

DROP TABLE IF EXISTS `matchchecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchchecks` (
  `matcher_id` int(11) NOT NULL,
  `matchcheck_id` int(11) NOT NULL AUTO_INCREMENT,
  `source_matchpoint_id` int(11) NOT NULL,
  `target_matchpoint_id` int(11) NOT NULL,
  PRIMARY KEY (`matchcheck_id`),
  KEY `matcher_matchchecks_ifbk_1` (`matcher_id`),
  KEY `matcher_matchchecks_ifbk_2` (`source_matchpoint_id`),
  KEY `matcher_matchchecks_ifbk_3` (`target_matchpoint_id`),
  CONSTRAINT `matcher_matchchecks_ifbk_1` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matcher_matchchecks_ifbk_2` FOREIGN KEY (`source_matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matcher_matchchecks_ifbk_3` FOREIGN KEY (`target_matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchchecks`
--

LOCK TABLES `matchchecks` WRITE;
/*!40000 ALTER TABLE `matchchecks` DISABLE KEYS */;
/*!40000 ALTER TABLE `matchchecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matcher_matchpoints`
--

DROP TABLE IF EXISTS `matcher_matchpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matcher_matchpoints` (
  `matcher_id` int(11) NOT NULL,
  `matchpoint_id` int(11) NOT NULL,
  KEY `matcher_matchpoints_ifbk_1` (`matcher_id`),
  KEY `matcher_matchpoints_ifbk_2` (`matchpoint_id`),
  CONSTRAINT `matcher_matchpoints_ifbk_1` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matcher_matchpoints_ifbk_2` FOREIGN KEY (`matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matcher_matchpoints`
--

LOCK TABLES `matcher_matchpoints` WRITE;
/*!40000 ALTER TABLE `matcher_matchpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `matcher_matchpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchpoint_component_norms`
--

DROP TABLE IF EXISTS `matchpoint_component_norms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchpoint_component_norms` (
  `matchpoint_component_id` int(11) NOT NULL,
  `sequence` int(11) NOT NULL DEFAULT '0',
  `norm_routine` varchar(50) NOT NULL DEFAULT '',
  KEY `matchpoint_component_norms` (`matchpoint_component_id`,`sequence`),
  CONSTRAINT `matchpoint_component_norms_ifbk_1` FOREIGN KEY (`matchpoint_component_id`) REFERENCES `matchpoint_components` (`matchpoint_component_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchpoint_component_norms`
--

LOCK TABLES `matchpoint_component_norms` WRITE;
/*!40000 ALTER TABLE `matchpoint_component_norms` DISABLE KEYS */;
/*!40000 ALTER TABLE `matchpoint_component_norms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchpoint_components`
--

DROP TABLE IF EXISTS `matchpoint_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchpoint_components` (
  `matchpoint_id` int(11) NOT NULL,
  `matchpoint_component_id` int(11) NOT NULL AUTO_INCREMENT,
  `sequence` int(11) NOT NULL DEFAULT '0',
  `tag` varchar(3) NOT NULL DEFAULT '',
  `subfields` varchar(40) NOT NULL DEFAULT '',
  `offset` int(4) NOT NULL DEFAULT '0',
  `length` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`matchpoint_component_id`),
  KEY `by_sequence` (`matchpoint_id`,`sequence`),
  CONSTRAINT `matchpoint_components_ifbk_1` FOREIGN KEY (`matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchpoint_components`
--

LOCK TABLES `matchpoint_components` WRITE;
/*!40000 ALTER TABLE `matchpoint_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `matchpoint_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchpoints`
--

DROP TABLE IF EXISTS `matchpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchpoints` (
  `matcher_id` int(11) NOT NULL,
  `matchpoint_id` int(11) NOT NULL AUTO_INCREMENT,
  `search_index` varchar(30) NOT NULL DEFAULT '',
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`matchpoint_id`),
  KEY `matchpoints_ifbk_1` (`matcher_id`),
  CONSTRAINT `matchpoints_ifbk_1` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchpoints`
--

LOCK TABLES `matchpoints` WRITE;
/*!40000 ALTER TABLE `matchpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `matchpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_attributes`
--

DROP TABLE IF EXISTS `message_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_attributes` (
  `message_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_name` varchar(40) NOT NULL DEFAULT '',
  `takes_days` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_attribute_id`),
  UNIQUE KEY `message_name` (`message_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_attributes`
--

LOCK TABLES `message_attributes` WRITE;
/*!40000 ALTER TABLE `message_attributes` DISABLE KEYS */;
INSERT INTO `message_attributes` VALUES (1,'Item_Due',0),(2,'Advance_Notice',1),(4,'Hold_Filled',0),(5,'Item_Check_in',0),(6,'Item_Checkout',0);
/*!40000 ALTER TABLE `message_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_queue`
--

DROP TABLE IF EXISTS `message_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_queue` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) DEFAULT NULL,
  `subject` text,
  `content` text,
  `metadata` text,
  `letter_code` varchar(64) DEFAULT NULL,
  `message_transport_type` varchar(20) NOT NULL,
  `status` enum('sent','pending','failed','deleted') NOT NULL DEFAULT 'pending',
  `time_queued` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `to_address` mediumtext,
  `from_address` mediumtext,
  `content_type` text,
  KEY `message_id` (`message_id`),
  KEY `borrowernumber` (`borrowernumber`),
  KEY `message_transport_type` (`message_transport_type`),
  CONSTRAINT `messageq_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messageq_ibfk_2` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_queue`
--

LOCK TABLES `message_queue` WRITE;
/*!40000 ALTER TABLE `message_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_transport_types`
--

DROP TABLE IF EXISTS `message_transport_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_transport_types` (
  `message_transport_type` varchar(20) NOT NULL,
  PRIMARY KEY (`message_transport_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_transport_types`
--

LOCK TABLES `message_transport_types` WRITE;
/*!40000 ALTER TABLE `message_transport_types` DISABLE KEYS */;
INSERT INTO `message_transport_types` VALUES ('email'),('feed'),('phone'),('print'),('sms');
/*!40000 ALTER TABLE `message_transport_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_transports`
--

DROP TABLE IF EXISTS `message_transports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_transports` (
  `message_attribute_id` int(11) NOT NULL,
  `message_transport_type` varchar(20) NOT NULL,
  `is_digest` tinyint(1) NOT NULL DEFAULT '0',
  `letter_module` varchar(20) NOT NULL DEFAULT '',
  `letter_code` varchar(20) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`message_attribute_id`,`message_transport_type`,`is_digest`),
  KEY `message_transport_type` (`message_transport_type`),
  KEY `letter_module` (`letter_module`,`letter_code`),
  KEY `message_transports_ibfk_3` (`letter_module`,`letter_code`,`branchcode`),
  CONSTRAINT `message_transports_ibfk_1` FOREIGN KEY (`message_attribute_id`) REFERENCES `message_attributes` (`message_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `message_transports_ibfk_2` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `message_transports_ibfk_3` FOREIGN KEY (`letter_module`, `letter_code`, `branchcode`) REFERENCES `letter` (`module`, `code`, `branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_transports`
--

LOCK TABLES `message_transports` WRITE;
/*!40000 ALTER TABLE `message_transports` DISABLE KEYS */;
INSERT INTO `message_transports` VALUES (5,'email',0,'circulation','CHECKIN',''),(5,'sms',0,'circulation','CHECKIN',''),(6,'email',0,'circulation','CHECKOUT',''),(6,'sms',0,'circulation','CHECKOUT',''),(1,'email',0,'circulation','DUE',''),(1,'sms',0,'circulation','DUE',''),(1,'email',1,'circulation','DUEDGST',''),(1,'sms',1,'circulation','DUEDGST',''),(2,'email',0,'circulation','PREDUE',''),(2,'sms',0,'circulation','PREDUE',''),(2,'email',1,'circulation','PREDUEDGST',''),(2,'sms',1,'circulation','PREDUEDGST',''),(4,'email',0,'reserves','HOLD',''),(4,'sms',0,'reserves','HOLD','');
/*!40000 ALTER TABLE `message_transports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `message_type` varchar(1) NOT NULL,
  `message` text NOT NULL,
  `message_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `need_merge_authorities`
--

DROP TABLE IF EXISTS `need_merge_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `need_merge_authorities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authid` bigint(20) NOT NULL,
  `done` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `need_merge_authorities`
--

LOCK TABLES `need_merge_authorities` WRITE;
/*!40000 ALTER TABLE `need_merge_authorities` DISABLE KEYS */;
/*!40000 ALTER TABLE `need_merge_authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifys`
--

DROP TABLE IF EXISTS `notifys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifys` (
  `notify_id` int(11) NOT NULL DEFAULT '0',
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `itemnumber` int(11) NOT NULL DEFAULT '0',
  `notify_date` date DEFAULT NULL,
  `notify_send_date` date DEFAULT NULL,
  `notify_level` int(1) NOT NULL DEFAULT '0',
  `method` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifys`
--

LOCK TABLES `notifys` WRITE;
/*!40000 ALTER TABLE `notifys` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_sets`
--

DROP TABLE IF EXISTS `oai_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oai_sets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spec` varchar(80) NOT NULL,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `spec` (`spec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_sets`
--

LOCK TABLES `oai_sets` WRITE;
/*!40000 ALTER TABLE `oai_sets` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_sets_biblios`
--

DROP TABLE IF EXISTS `oai_sets_biblios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oai_sets_biblios` (
  `biblionumber` int(11) NOT NULL,
  `set_id` int(11) NOT NULL,
  PRIMARY KEY (`biblionumber`,`set_id`),
  KEY `oai_sets_biblios_ibfk_2` (`set_id`),
  CONSTRAINT `oai_sets_biblios_ibfk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `oai_sets_biblios_ibfk_2` FOREIGN KEY (`set_id`) REFERENCES `oai_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_sets_biblios`
--

LOCK TABLES `oai_sets_biblios` WRITE;
/*!40000 ALTER TABLE `oai_sets_biblios` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_sets_biblios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_sets_descriptions`
--

DROP TABLE IF EXISTS `oai_sets_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oai_sets_descriptions` (
  `set_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  KEY `oai_sets_descriptions_ibfk_1` (`set_id`),
  CONSTRAINT `oai_sets_descriptions_ibfk_1` FOREIGN KEY (`set_id`) REFERENCES `oai_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_sets_descriptions`
--

LOCK TABLES `oai_sets_descriptions` WRITE;
/*!40000 ALTER TABLE `oai_sets_descriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_sets_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_sets_mappings`
--

DROP TABLE IF EXISTS `oai_sets_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oai_sets_mappings` (
  `set_id` int(11) NOT NULL,
  `marcfield` char(3) NOT NULL,
  `marcsubfield` char(1) NOT NULL,
  `operator` varchar(8) NOT NULL DEFAULT 'equal',
  `marcvalue` varchar(80) NOT NULL,
  KEY `oai_sets_mappings_ibfk_1` (`set_id`),
  CONSTRAINT `oai_sets_mappings_ibfk_1` FOREIGN KEY (`set_id`) REFERENCES `oai_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_sets_mappings`
--

LOCK TABLES `oai_sets_mappings` WRITE;
/*!40000 ALTER TABLE `oai_sets_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_sets_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `old_issues`
--

DROP TABLE IF EXISTS `old_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_issues` (
  `borrowernumber` int(11) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `date_due` datetime DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `issuingbranch` varchar(18) DEFAULT NULL,
  `returndate` datetime DEFAULT NULL,
  `lastreneweddate` datetime DEFAULT NULL,
  `return` varchar(4) DEFAULT NULL,
  `renewals` tinyint(4) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `issuedate` datetime DEFAULT NULL,
  KEY `old_issuesborridx` (`borrowernumber`),
  KEY `old_issuesitemidx` (`itemnumber`),
  KEY `branchcode_idx` (`branchcode`),
  KEY `issuingbranch_idx` (`issuingbranch`),
  KEY `old_bordate` (`borrowernumber`,`timestamp`),
  CONSTRAINT `old_issues_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `old_issues_ibfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `old_issues`
--

LOCK TABLES `old_issues` WRITE;
/*!40000 ALTER TABLE `old_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `old_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `old_reserves`
--

DROP TABLE IF EXISTS `old_reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_reserves` (
  `reserve_id` int(11) NOT NULL,
  `borrowernumber` int(11) DEFAULT NULL,
  `reservedate` date DEFAULT NULL,
  `biblionumber` int(11) DEFAULT NULL,
  `constrainttype` varchar(1) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `notificationdate` date DEFAULT NULL,
  `reminderdate` date DEFAULT NULL,
  `cancellationdate` date DEFAULT NULL,
  `reservenotes` mediumtext,
  `priority` smallint(6) DEFAULT NULL,
  `found` varchar(1) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `itemnumber` int(11) DEFAULT NULL,
  `waitingdate` date DEFAULT NULL,
  `expirationdate` date DEFAULT NULL,
  `lowestPriority` tinyint(1) NOT NULL,
  `suspend` tinyint(1) NOT NULL DEFAULT '0',
  `suspend_until` datetime DEFAULT NULL,
  PRIMARY KEY (`reserve_id`),
  KEY `old_reserves_borrowernumber` (`borrowernumber`),
  KEY `old_reserves_biblionumber` (`biblionumber`),
  KEY `old_reserves_itemnumber` (`itemnumber`),
  KEY `old_reserves_branchcode` (`branchcode`),
  CONSTRAINT `old_reserves_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `old_reserves_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `old_reserves_ibfk_3` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `old_reserves`
--

LOCK TABLES `old_reserves` WRITE;
/*!40000 ALTER TABLE `old_reserves` DISABLE KEYS */;
/*!40000 ALTER TABLE `old_reserves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opac_news`
--

DROP TABLE IF EXISTS `opac_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opac_news` (
  `idnew` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `branchcode` varchar(10) DEFAULT NULL,
  `title` varchar(250) NOT NULL DEFAULT '',
  `new` text NOT NULL,
  `lang` varchar(25) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expirationdate` date DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`idnew`),
  KEY `opac_news_branchcode_ibfk` (`branchcode`),
  CONSTRAINT `opac_news_branchcode_ibfk` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opac_news`
--

LOCK TABLES `opac_news` WRITE;
/*!40000 ALTER TABLE `opac_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `opac_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `overduerules`
--

DROP TABLE IF EXISTS `overduerules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `overduerules` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `delay1` int(4) DEFAULT NULL,
  `letter1` varchar(20) DEFAULT NULL,
  `debarred1` varchar(1) DEFAULT '0',
  `delay2` int(4) DEFAULT NULL,
  `debarred2` varchar(1) DEFAULT '0',
  `letter2` varchar(20) DEFAULT NULL,
  `delay3` int(4) DEFAULT NULL,
  `letter3` varchar(20) DEFAULT NULL,
  `debarred3` int(1) DEFAULT '0',
  PRIMARY KEY (`branchcode`,`categorycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `overduerules`
--

LOCK TABLES `overduerules` WRITE;
/*!40000 ALTER TABLE `overduerules` DISABLE KEYS */;
/*!40000 ALTER TABLE `overduerules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `overduerules_transport_types`
--

DROP TABLE IF EXISTS `overduerules_transport_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `overduerules_transport_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `letternumber` int(1) NOT NULL DEFAULT '1',
  `message_transport_type` varchar(20) NOT NULL DEFAULT 'email',
  PRIMARY KEY (`id`),
  KEY `overduerules_fk` (`branchcode`,`categorycode`),
  KEY `mtt_fk` (`message_transport_type`),
  CONSTRAINT `mtt_fk` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `overduerules_fk` FOREIGN KEY (`branchcode`, `categorycode`) REFERENCES `overduerules` (`branchcode`, `categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `overduerules_transport_types`
--

LOCK TABLES `overduerules_transport_types` WRITE;
/*!40000 ALTER TABLE `overduerules_transport_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `overduerules_transport_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patron_list_patrons`
--

DROP TABLE IF EXISTS `patron_list_patrons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patron_list_patrons` (
  `patron_list_patron_id` int(11) NOT NULL AUTO_INCREMENT,
  `patron_list_id` int(11) NOT NULL,
  `borrowernumber` int(11) NOT NULL,
  PRIMARY KEY (`patron_list_patron_id`),
  KEY `patron_list_id` (`patron_list_id`),
  KEY `borrowernumber` (`borrowernumber`),
  CONSTRAINT `patron_list_patrons_ibfk_1` FOREIGN KEY (`patron_list_id`) REFERENCES `patron_lists` (`patron_list_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patron_list_patrons_ibfk_2` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patron_list_patrons`
--

LOCK TABLES `patron_list_patrons` WRITE;
/*!40000 ALTER TABLE `patron_list_patrons` DISABLE KEYS */;
/*!40000 ALTER TABLE `patron_list_patrons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patron_lists`
--

DROP TABLE IF EXISTS `patron_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patron_lists` (
  `patron_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `owner` int(11) NOT NULL,
  PRIMARY KEY (`patron_list_id`),
  KEY `owner` (`owner`),
  CONSTRAINT `patron_lists_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patron_lists`
--

LOCK TABLES `patron_lists` WRITE;
/*!40000 ALTER TABLE `patron_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `patron_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patroncards`
--

DROP TABLE IF EXISTS `patroncards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patroncards` (
  `cardid` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(10) NOT NULL DEFAULT '1',
  `borrowernumber` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cardid`),
  KEY `patroncards_ibfk_1` (`borrowernumber`),
  CONSTRAINT `patroncards_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patroncards`
--

LOCK TABLES `patroncards` WRITE;
/*!40000 ALTER TABLE `patroncards` DISABLE KEYS */;
/*!40000 ALTER TABLE `patroncards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patronimage`
--

DROP TABLE IF EXISTS `patronimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patronimage` (
  `borrowernumber` int(11) NOT NULL,
  `mimetype` varchar(15) NOT NULL,
  `imagefile` mediumblob NOT NULL,
  PRIMARY KEY (`borrowernumber`),
  CONSTRAINT `patronimage_fk1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patronimage`
--

LOCK TABLES `patronimage` WRITE;
/*!40000 ALTER TABLE `patronimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `patronimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_offline_operations`
--

DROP TABLE IF EXISTS `pending_offline_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pending_offline_operations` (
  `operationid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(30) NOT NULL,
  `branchcode` varchar(10) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `action` varchar(10) NOT NULL,
  `barcode` varchar(20) DEFAULT NULL,
  `cardnumber` varchar(16) DEFAULT NULL,
  `amount` decimal(28,6) DEFAULT NULL,
  PRIMARY KEY (`operationid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_offline_operations`
--

LOCK TABLES `pending_offline_operations` WRITE;
/*!40000 ALTER TABLE `pending_offline_operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `pending_offline_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `module_bit` int(11) NOT NULL DEFAULT '0',
  `code` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`module_bit`,`code`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`module_bit`) REFERENCES `userflags` (`bit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'circulate_remaining_permissions','Remaining circulation permissions'),(1,'force_checkout','Force checkout if a limitation exists'),(1,'manage_restrictions','Manage restrictions for accounts'),(1,'overdues_report','Execute overdue items report'),(1,'override_renewals','Override blocked renewals'),(3,'manage_circ_rules','manage circulation rules'),(3,'parameters_remaining_permissions','Remaining system parameters permissions'),(6,'modify_holds_priority','Modify holds priority'),(6,'place_holds','Place holds for patrons'),(9,'edit_catalogue','Edit catalog (Modify bibliographic/holdings data)'),(9,'edit_items','Edit items'),(9,'fast_cataloging','Fast cataloging'),(10,'remaining_permissions','Remaining permissions for managing fines and fees'),(10,'writeoff','Write off fines and fees'),(11,'budget_add_del','Add and delete budgets (but cant modify budgets)'),(11,'budget_manage','Manage budgets'),(11,'budget_manage_all','Manage all budgets'),(11,'budget_modify','Modify budget (can\'t create lines, but can modify existing ones)'),(11,'contracts_manage','Manage contracts'),(11,'group_manage','Manage orders & basketgroups'),(11,'order_manage','Manage orders & basket'),(11,'order_manage_all','Manage all orders and baskets, regardless of restrictions on them'),(11,'order_receive','Manage orders & basket'),(11,'period_manage','Manage periods'),(11,'planning_manage','Manage budget plannings'),(11,'vendors_manage','Manage vendors'),(13,'batch_upload_patron_images','Upload patron images in a batch or one at a time'),(13,'delete_anonymize_patrons','Delete old borrowers and anonymize circulation history (deletes borrower reading history)'),(13,'edit_calendar','Define days when the library is closed'),(13,'edit_news','Write news for the OPAC and staff interfaces'),(13,'edit_notices','Define notices'),(13,'edit_notice_status_triggers','Set notice/status triggers for overdue items'),(13,'edit_patrons','Perform batch modification of patrons'),(13,'edit_quotes','Edit quotes for quote-of-the-day feature'),(13,'export_catalog','Export bibliographic and holdings data'),(13,'import_patrons','Import patron data'),(13,'inventory','Perform inventory (stocktaking) of your catalog'),(13,'items_batchdel','Perform batch deletion of items'),(13,'items_batchmod','Perform batch modification of items'),(13,'label_creator','Create printable labels and barcodes from catalog and patron data'),(13,'manage_csv_profiles','Manage CSV export profiles'),(13,'manage_patron_lists','Add, edit and delete patron lists and their contents'),(13,'manage_staged_marc','Managed staged MARC records, including completing and reversing imports'),(13,'marc_modification_templates','Manage marc modification templates'),(13,'moderate_comments','Moderate patron comments'),(13,'moderate_tags','Moderate patron tags'),(13,'rotating_collections','Manage rotating collections'),(13,'schedule_tasks','Schedule tasks to run'),(13,'stage_marc_import','Stage MARC records into the reservoir'),(13,'upload_local_cover_images','Upload local cover images'),(13,'view_system_logs','Browse the system logs'),(15,'check_expiration','Check the expiration of a serial'),(15,'claim_serials','Claim missing serials'),(15,'create_subscription','Create a new subscription'),(15,'delete_subscription','Delete an existing subscription'),(15,'edit_subscription','Edit an existing subscription'),(15,'receive_serials','Serials receiving'),(15,'renew_subscription','Renew a subscription'),(15,'routing','Routing'),(15,'superserials','Manage subscriptions from any branch (only applies when IndependentBranches is used)'),(16,'create_reports','Create SQL reports'),(16,'execute_reports','Execute SQL reports'),(18,'add_reserves','Add course reserves'),(18,'delete_reserves','Remove course reserves'),(18,'manage_courses','Add, edit and delete courses'),(19,'configure','Configure plugins'),(19,'manage','Manage plugins ( install / uninstall )'),(19,'report','Use report plugins'),(19,'tool','Use tool plugins');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_data`
--

DROP TABLE IF EXISTS `plugin_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_data` (
  `plugin_class` varchar(255) NOT NULL,
  `plugin_key` varchar(255) NOT NULL,
  `plugin_value` text,
  PRIMARY KEY (`plugin_class`,`plugin_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin_data`
--

LOCK TABLES `plugin_data` WRITE;
/*!40000 ALTER TABLE `plugin_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printers`
--

DROP TABLE IF EXISTS `printers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printers` (
  `printername` varchar(40) NOT NULL DEFAULT '',
  `printqueue` varchar(20) DEFAULT NULL,
  `printtype` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`printername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printers`
--

LOCK TABLES `printers` WRITE;
/*!40000 ALTER TABLE `printers` DISABLE KEYS */;
/*!40000 ALTER TABLE `printers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printers_profile`
--

DROP TABLE IF EXISTS `printers_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printers_profile` (
  `profile_id` int(4) NOT NULL AUTO_INCREMENT,
  `printer_name` varchar(40) NOT NULL DEFAULT 'Default Printer',
  `template_id` int(4) NOT NULL DEFAULT '0',
  `paper_bin` varchar(20) NOT NULL DEFAULT 'Bypass',
  `offset_horz` float NOT NULL DEFAULT '0',
  `offset_vert` float NOT NULL DEFAULT '0',
  `creep_horz` float NOT NULL DEFAULT '0',
  `creep_vert` float NOT NULL DEFAULT '0',
  `units` char(20) NOT NULL DEFAULT 'POINT',
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `printername` (`printer_name`,`template_id`,`paper_bin`,`creator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printers_profile`
--

LOCK TABLES `printers_profile` WRITE;
/*!40000 ALTER TABLE `printers_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `printers_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotes`
--

DROP TABLE IF EXISTS `quotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` text,
  `text` mediumtext NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotes`
--

LOCK TABLES `quotes` WRITE;
/*!40000 ALTER TABLE `quotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `borrowernumber` int(11) NOT NULL,
  `biblionumber` int(11) NOT NULL,
  `rating_value` tinyint(1) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`borrowernumber`,`biblionumber`),
  KEY `ratings_ibfk_2` (`biblionumber`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repeatable_holidays`
--

DROP TABLE IF EXISTS `repeatable_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repeatable_holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `weekday` smallint(6) DEFAULT NULL,
  `day` smallint(6) DEFAULT NULL,
  `month` smallint(6) DEFAULT NULL,
  `title` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repeatable_holidays`
--

LOCK TABLES `repeatable_holidays` WRITE;
/*!40000 ALTER TABLE `repeatable_holidays` DISABLE KEYS */;
/*!40000 ALTER TABLE `repeatable_holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_dictionary`
--

DROP TABLE IF EXISTS `reports_dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `saved_sql` text,
  `report_area` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dictionary_area_idx` (`report_area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_dictionary`
--

LOCK TABLES `reports_dictionary` WRITE;
/*!40000 ALTER TABLE `reports_dictionary` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserveconstraints`
--

DROP TABLE IF EXISTS `reserveconstraints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserveconstraints` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `reservedate` date DEFAULT NULL,
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `biblioitemnumber` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserveconstraints`
--

LOCK TABLES `reserveconstraints` WRITE;
/*!40000 ALTER TABLE `reserveconstraints` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserveconstraints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserves`
--

DROP TABLE IF EXISTS `reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserves` (
  `reserve_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `reservedate` date DEFAULT NULL,
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `constrainttype` varchar(1) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `notificationdate` date DEFAULT NULL,
  `reminderdate` date DEFAULT NULL,
  `cancellationdate` date DEFAULT NULL,
  `reservenotes` mediumtext,
  `priority` smallint(6) DEFAULT NULL,
  `found` varchar(1) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `itemnumber` int(11) DEFAULT NULL,
  `waitingdate` date DEFAULT NULL,
  `expirationdate` date DEFAULT NULL,
  `lowestPriority` tinyint(1) NOT NULL,
  `suspend` tinyint(1) NOT NULL DEFAULT '0',
  `suspend_until` datetime DEFAULT NULL,
  PRIMARY KEY (`reserve_id`),
  KEY `priorityfoundidx` (`priority`,`found`),
  KEY `borrowernumber` (`borrowernumber`),
  KEY `biblionumber` (`biblionumber`),
  KEY `itemnumber` (`itemnumber`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `reserves_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_ibfk_3` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_ibfk_4` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserves`
--

LOCK TABLES `reserves` WRITE;
/*!40000 ALTER TABLE `reserves` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `reviewid` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) DEFAULT NULL,
  `biblionumber` int(11) DEFAULT NULL,
  `review` text,
  `approved` tinyint(4) DEFAULT NULL,
  `datereviewed` datetime DEFAULT NULL,
  PRIMARY KEY (`reviewid`),
  KEY `reviews_ibfk_1` (`borrowernumber`),
  KEY `reviews_ibfk_2` (`biblionumber`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_reports`
--

DROP TABLE IF EXISTS `saved_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) DEFAULT NULL,
  `report` longtext,
  `date_run` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_reports`
--

LOCK TABLES `saved_reports` WRITE;
/*!40000 ALTER TABLE `saved_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_sql`
--

DROP TABLE IF EXISTS `saved_sql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_sql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `savedsql` text,
  `last_run` datetime DEFAULT NULL,
  `report_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `notes` text,
  `cache_expiry` int(11) NOT NULL DEFAULT '300',
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `report_area` varchar(6) DEFAULT NULL,
  `report_group` varchar(80) DEFAULT NULL,
  `report_subgroup` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sql_area_group_idx` (`report_group`,`report_subgroup`),
  KEY `boridx` (`borrowernumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_sql`
--

LOCK TABLES `saved_sql` WRITE;
/*!40000 ALTER TABLE `saved_sql` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved_sql` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_history`
--

DROP TABLE IF EXISTS `search_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_history` (
  `userid` int(11) NOT NULL,
  `sessionid` varchar(32) NOT NULL,
  `query_desc` varchar(255) NOT NULL,
  `query_cgi` text NOT NULL,
  `type` varchar(16) NOT NULL DEFAULT 'biblio',
  `total` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `userid` (`userid`),
  KEY `sessionid` (`sessionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Opac search history results';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_history`
--

LOCK TABLES `search_history` WRITE;
/*!40000 ALTER TABLE `search_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serial`
--

DROP TABLE IF EXISTS `serial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serial` (
  `serialid` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` varchar(100) NOT NULL DEFAULT '',
  `subscriptionid` varchar(100) NOT NULL DEFAULT '',
  `serialseq` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `planneddate` date DEFAULT NULL,
  `notes` text,
  `publisheddate` date DEFAULT NULL,
  `claimdate` date DEFAULT NULL,
  `routingnotes` text,
  PRIMARY KEY (`serialid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serial`
--

LOCK TABLES `serial` WRITE;
/*!40000 ALTER TABLE `serial` DISABLE KEYS */;
/*!40000 ALTER TABLE `serial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serialitems`
--

DROP TABLE IF EXISTS `serialitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serialitems` (
  `itemnumber` int(11) NOT NULL,
  `serialid` int(11) NOT NULL,
  UNIQUE KEY `serialitemsidx` (`itemnumber`),
  KEY `serialitems_sfk_1` (`serialid`),
  CONSTRAINT `serialitems_sfk_1` FOREIGN KEY (`serialid`) REFERENCES `serial` (`serialid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `serialitems_sfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serialitems`
--

LOCK TABLES `serialitems` WRITE;
/*!40000 ALTER TABLE `serialitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `serialitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_throttle`
--

DROP TABLE IF EXISTS `services_throttle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_throttle` (
  `service_type` varchar(10) NOT NULL DEFAULT '',
  `service_count` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`service_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_throttle`
--

LOCK TABLES `services_throttle` WRITE;
/*!40000 ALTER TABLE `services_throttle` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_throttle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(32) NOT NULL,
  `a_session` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('216408f5022ed87338e21ebd9384d580','--- \n_SESSION_ATIME: \'1415363818\'\n_SESSION_CTIME: \'1415363818\'\n_SESSION_ID: 216408f5022ed87338e21ebd9384d580\n_SESSION_REMOTE_ADDR: 172.17.42.1\n');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_data`
--

DROP TABLE IF EXISTS `social_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_data` (
  `isbn` varchar(30) NOT NULL DEFAULT '',
  `num_critics` int(11) DEFAULT NULL,
  `num_critics_pro` int(11) DEFAULT NULL,
  `num_quotations` int(11) DEFAULT NULL,
  `num_videos` int(11) DEFAULT NULL,
  `score_avg` decimal(5,2) DEFAULT NULL,
  `num_scores` int(11) DEFAULT NULL,
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_data`
--

LOCK TABLES `social_data` WRITE;
/*!40000 ALTER TABLE `social_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `special_holidays`
--

DROP TABLE IF EXISTS `special_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `special_holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `day` smallint(6) NOT NULL DEFAULT '0',
  `month` smallint(6) NOT NULL DEFAULT '0',
  `year` smallint(6) NOT NULL DEFAULT '0',
  `isexception` smallint(1) NOT NULL DEFAULT '1',
  `title` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `special_holidays`
--

LOCK TABLES `special_holidays` WRITE;
/*!40000 ALTER TABLE `special_holidays` DISABLE KEYS */;
/*!40000 ALTER TABLE `special_holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics` (
  `datetime` datetime DEFAULT NULL,
  `branch` varchar(10) DEFAULT NULL,
  `proccode` varchar(4) DEFAULT NULL,
  `value` double(16,4) DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `other` mediumtext,
  `usercode` varchar(10) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `itemtype` varchar(10) DEFAULT NULL,
  `borrowernumber` int(11) DEFAULT NULL,
  `associatedborrower` int(11) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  KEY `timeidx` (`datetime`),
  KEY `branch_idx` (`branch`),
  KEY `proccode_idx` (`proccode`),
  KEY `type_idx` (`type`),
  KEY `usercode_idx` (`usercode`),
  KEY `itemnumber_idx` (`itemnumber`),
  KEY `itemtype_idx` (`itemtype`),
  KEY `borrowernumber_idx` (`borrowernumber`),
  KEY `associatedborrower_idx` (`associatedborrower`),
  KEY `ccode_idx` (`ccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics`
--

LOCK TABLES `statistics` WRITE;
/*!40000 ALTER TABLE `statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stopwords`
--

DROP TABLE IF EXISTS `stopwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stopwords` (
  `word` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stopwords`
--

LOCK TABLES `stopwords` WRITE;
/*!40000 ALTER TABLE `stopwords` DISABLE KEYS */;
INSERT INTO `stopwords` VALUES ('a'),('about'),('also'),('an'),('and'),('another'),('any'),('are'),('as'),('at'),('back'),('be'),('because'),('been'),('being'),('but'),('by'),('can'),('could'),('did'),('do'),('each'),('end'),('even'),('for'),('from'),('get'),('go'),('had'),('have'),('he'),('her'),('here'),('his'),('how'),('i'),('if'),('in'),('into'),('is'),('it'),('just'),('may'),('me'),('might'),('much'),('must'),('my'),('no'),('not'),('of'),('off'),('on'),('only'),('or'),('other'),('our'),('out'),('should'),('so'),('some'),('still'),('such'),('than'),('that'),('the'),('their'),('them'),('then'),('there'),('these'),('they'),('this'),('those'),('to'),('too'),('try'),('two'),('under'),('up'),('us'),('was'),('we'),('were'),('what'),('when'),('where'),('which'),('while'),('who'),('why'),('will'),('with'),('within'),('without'),('would'),('you'),('your');
/*!40000 ALTER TABLE `stopwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription` (
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `subscriptionid` int(11) NOT NULL AUTO_INCREMENT,
  `librarian` varchar(100) DEFAULT '',
  `startdate` date DEFAULT NULL,
  `aqbooksellerid` int(11) DEFAULT '0',
  `cost` int(11) DEFAULT '0',
  `aqbudgetid` int(11) DEFAULT '0',
  `weeklength` int(11) DEFAULT '0',
  `monthlength` int(11) DEFAULT '0',
  `numberlength` int(11) DEFAULT '0',
  `periodicity` int(11) DEFAULT NULL,
  `countissuesperunit` int(11) NOT NULL DEFAULT '1',
  `notes` mediumtext,
  `status` varchar(100) NOT NULL DEFAULT '',
  `lastvalue1` int(11) DEFAULT NULL,
  `innerloop1` int(11) DEFAULT '0',
  `lastvalue2` int(11) DEFAULT NULL,
  `innerloop2` int(11) DEFAULT '0',
  `lastvalue3` int(11) DEFAULT NULL,
  `innerloop3` int(11) DEFAULT '0',
  `firstacquidate` date DEFAULT NULL,
  `manualhistory` tinyint(1) NOT NULL DEFAULT '0',
  `irregularity` text,
  `skip_serialseq` tinyint(1) NOT NULL DEFAULT '0',
  `letter` varchar(20) DEFAULT NULL,
  `numberpattern` int(11) DEFAULT NULL,
  `locale` varchar(80) DEFAULT NULL,
  `distributedto` text,
  `internalnotes` longtext,
  `callnumber` text,
  `location` varchar(80) DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `lastbranch` varchar(10) DEFAULT NULL,
  `serialsadditems` tinyint(1) NOT NULL DEFAULT '0',
  `staffdisplaycount` varchar(10) DEFAULT NULL,
  `opacdisplaycount` varchar(10) DEFAULT NULL,
  `graceperiod` int(11) NOT NULL DEFAULT '0',
  `enddate` date DEFAULT NULL,
  `closed` int(1) NOT NULL DEFAULT '0',
  `reneweddate` date DEFAULT NULL,
  PRIMARY KEY (`subscriptionid`),
  KEY `subscription_ibfk_1` (`periodicity`),
  KEY `subscription_ibfk_2` (`numberpattern`),
  CONSTRAINT `subscription_ibfk_1` FOREIGN KEY (`periodicity`) REFERENCES `subscription_frequencies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `subscription_ibfk_2` FOREIGN KEY (`numberpattern`) REFERENCES `subscription_numberpatterns` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_frequencies`
--

DROP TABLE IF EXISTS `subscription_frequencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_frequencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `displayorder` int(11) DEFAULT NULL,
  `unit` enum('day','week','month','year') DEFAULT NULL,
  `unitsperissue` int(11) NOT NULL DEFAULT '1',
  `issuesperunit` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_frequencies`
--

LOCK TABLES `subscription_frequencies` WRITE;
/*!40000 ALTER TABLE `subscription_frequencies` DISABLE KEYS */;
INSERT INTO `subscription_frequencies` VALUES (1,'2/day',1,'day',1,2),(2,'1/day',2,'day',1,1),(3,'3/week',3,'week',1,3),(4,'1/week',4,'week',1,1),(5,'1/2 weeks',5,'week',2,1),(6,'1/3 weeks',6,'week',3,1),(7,'1/month',7,'month',1,1),(8,'1/2 months',8,'month',2,1),(9,'1/3 months',9,'month',3,1),(10,'2/year',10,'month',6,1),(11,'1/year',11,'year',1,1),(12,'1/2 year',12,'year',2,1),(13,'Irregular',13,NULL,1,1);
/*!40000 ALTER TABLE `subscription_frequencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_numberpatterns`
--

DROP TABLE IF EXISTS `subscription_numberpatterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_numberpatterns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `displayorder` int(11) DEFAULT NULL,
  `description` text NOT NULL,
  `numberingmethod` varchar(255) NOT NULL,
  `label1` varchar(255) DEFAULT NULL,
  `add1` int(11) DEFAULT NULL,
  `every1` int(11) DEFAULT NULL,
  `whenmorethan1` int(11) DEFAULT NULL,
  `setto1` int(11) DEFAULT NULL,
  `numbering1` varchar(255) DEFAULT NULL,
  `label2` varchar(255) DEFAULT NULL,
  `add2` int(11) DEFAULT NULL,
  `every2` int(11) DEFAULT NULL,
  `whenmorethan2` int(11) DEFAULT NULL,
  `setto2` int(11) DEFAULT NULL,
  `numbering2` varchar(255) DEFAULT NULL,
  `label3` varchar(255) DEFAULT NULL,
  `add3` int(11) DEFAULT NULL,
  `every3` int(11) DEFAULT NULL,
  `whenmorethan3` int(11) DEFAULT NULL,
  `setto3` int(11) DEFAULT NULL,
  `numbering3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_numberpatterns`
--

LOCK TABLES `subscription_numberpatterns` WRITE;
/*!40000 ALTER TABLE `subscription_numberpatterns` DISABLE KEYS */;
INSERT INTO `subscription_numberpatterns` VALUES (1,'Number',1,'Simple Numbering method','No. {X}','Number',1,1,99999,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Volume, Number, Issue',2,'Volume Number Issue 1','Vol. {X}, Number {Y}, Issue {Z}','Volume',1,48,99999,1,NULL,'Number',1,4,12,1,NULL,'Issue',1,1,4,1,NULL),(3,'Volume, Number',3,'Volume Number 1','Vol. {X}, No. {Y}','Volume',1,12,99999,1,NULL,'Number',1,1,12,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'Seasonal',4,'Season Year','{X} {Y}','Season',1,1,3,0,'season','Year',1,4,99999,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `subscription_numberpatterns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptionhistory`
--

DROP TABLE IF EXISTS `subscriptionhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptionhistory` (
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `subscriptionid` int(11) NOT NULL DEFAULT '0',
  `histstartdate` date DEFAULT NULL,
  `histenddate` date DEFAULT NULL,
  `missinglist` longtext NOT NULL,
  `recievedlist` longtext NOT NULL,
  `opacnote` varchar(150) NOT NULL DEFAULT '',
  `librariannote` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`subscriptionid`),
  KEY `biblionumber` (`biblionumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptionhistory`
--

LOCK TABLES `subscriptionhistory` WRITE;
/*!40000 ALTER TABLE `subscriptionhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptionhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptionroutinglist`
--

DROP TABLE IF EXISTS `subscriptionroutinglist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptionroutinglist` (
  `routingid` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `ranking` int(11) DEFAULT NULL,
  `subscriptionid` int(11) NOT NULL,
  PRIMARY KEY (`routingid`),
  UNIQUE KEY `subscriptionid` (`subscriptionid`,`borrowernumber`),
  KEY `subscriptionroutinglist_ibfk_1` (`borrowernumber`),
  CONSTRAINT `subscriptionroutinglist_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subscriptionroutinglist_ibfk_2` FOREIGN KEY (`subscriptionid`) REFERENCES `subscription` (`subscriptionid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptionroutinglist`
--

LOCK TABLES `subscriptionroutinglist` WRITE;
/*!40000 ALTER TABLE `subscriptionroutinglist` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptionroutinglist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggestions`
--

DROP TABLE IF EXISTS `suggestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suggestions` (
  `suggestionid` int(8) NOT NULL AUTO_INCREMENT,
  `suggestedby` int(11) NOT NULL DEFAULT '0',
  `suggesteddate` date NOT NULL,
  `managedby` int(11) DEFAULT NULL,
  `manageddate` date DEFAULT NULL,
  `acceptedby` int(11) DEFAULT NULL,
  `accepteddate` date DEFAULT NULL,
  `rejectedby` int(11) DEFAULT NULL,
  `rejecteddate` date DEFAULT NULL,
  `STATUS` varchar(10) NOT NULL DEFAULT '',
  `note` mediumtext,
  `author` varchar(80) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `copyrightdate` smallint(6) DEFAULT NULL,
  `publishercode` varchar(255) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `volumedesc` varchar(255) DEFAULT NULL,
  `publicationyear` smallint(6) DEFAULT '0',
  `place` varchar(255) DEFAULT NULL,
  `isbn` varchar(30) DEFAULT NULL,
  `mailoverseeing` smallint(1) DEFAULT '0',
  `biblionumber` int(11) DEFAULT NULL,
  `reason` text,
  `patronreason` text,
  `budgetid` int(11) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `collectiontitle` text,
  `itemtype` varchar(30) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `price` decimal(28,6) DEFAULT NULL,
  `total` decimal(28,6) DEFAULT NULL,
  PRIMARY KEY (`suggestionid`),
  KEY `suggestedby` (`suggestedby`),
  KEY `managedby` (`managedby`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggestions`
--

LOCK TABLES `suggestions` WRITE;
/*!40000 ALTER TABLE `suggestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `suggestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systempreferences`
--

DROP TABLE IF EXISTS `systempreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systempreferences` (
  `variable` varchar(50) NOT NULL DEFAULT '',
  `value` text,
  `options` mediumtext,
  `explanation` text,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systempreferences`
--

LOCK TABLES `systempreferences` WRITE;
/*!40000 ALTER TABLE `systempreferences` DISABLE KEYS */;
INSERT INTO `systempreferences` VALUES ('AcqCreateItem','ordering','ordering|receiving|cataloguing','Define when the item is created : when ordering, when receiving, or in cataloguing module','Choice'),('AcqItemSetSubfieldsWhenReceived','','','Upon receiving items, update their subfields if they were created when placing an order (e.g. o=5|a=\"foo bar\")','Free'),('AcquisitionDetails','1','','Hide/Show acquisition details on the biblio detail page.','YesNo'),('AcqViewBaskets','user','user|branch|all','Define which baskets a user is allowed to view: his own only, any within his branch or all','Choice'),('AcqWarnOnDuplicateInvoice','0','','Warn librarians when they try to create a duplicate invoice','YesNo'),('AddPatronLists','categorycode','categorycode|category_type','Allow user to choose what list to pick up from when adding patrons','Choice'),('advancedMARCeditor','0','','If ON, the MARC editor won\'t display field/subfield descriptions','YesNo'),('AdvancedSearchLanguages','','','ISO 639-2 codes of languages you wish to see appear as an Advanced search option.  Example: eng|fre|ita','Textarea'),('AdvancedSearchTypes','itemtypes','itemtypes|ccode','Select which set of fields comprise the Type limit in the advanced search','Choice'),('AgeRestrictionMarker','',NULL,'Markers for age restriction indication, e.g. FSK|PEGI|Age|','free'),('AgeRestrictionOverride','0',NULL,'Allow staff to check out an item with age restriction.','YesNo'),('AggressiveMatchOnISBN','0',NULL,'If enabled, attempt to match aggressively by trying all variations of the ISBNs in the imported record as a phrase in the ISBN fields of already cataloged records when matching on ISBN with the record import tool','YesNo'),('AllFinesNeedOverride','1','0','If on, staff will be asked to override every fine, even if it is below noissuescharge.','YesNo'),('AllowAllMessageDeletion','0','','Allow any Library to delete any message','YesNo'),('AllowFineOverride','0','0','If on, staff will be able to issue books to patrons with fines greater than noissuescharge.','YesNo'),('AllowHoldDateInFuture','0','','If set a date field is displayed on the Hold screen of the Staff Interface, allowing the hold date to be set in the future.','YesNo'),('AllowHoldPolicyOverride','0',NULL,'Allow staff to override hold policies when placing holds','YesNo'),('AllowHoldsOnDamagedItems','1','','Allow hold requests to be placed on damaged items','YesNo'),('AllowHoldsOnPatronsPossessions','1',NULL,'Allow holds on records that patron have items of it','YesNo'),('AllowItemsOnHoldCheckout','0','','Do not generate RESERVE_WAITING and RESERVED warning when checking out items reserved to someone else. This allows self checkouts for those items.','YesNo'),('AllowMultipleCovers','0','1','Allow multiple cover images to be attached to each bibliographic record.','YesNo'),('AllowMultipleIssuesOnABiblio','1','Allow/Don\'t allow patrons to check out multiple items from one biblio','','YesNo'),('AllowNotForLoanOverride','0','','If ON, Koha will allow the librarian to loan a not for loan item.','YesNo'),('AllowOfflineCirculation','0','','If on, enables HTML5 offline circulation functionality.','YesNo'),('AllowOnShelfHolds','0','','Allow hold requests to be placed on items that are not on loan','YesNo'),('AllowPKIAuth','None','None|Common Name|emailAddress','Use the field from a client-side SSL certificate to look a user in the Koha database','Choice'),('AllowPurchaseSuggestionBranchChoice','0','1','Allow user to choose branch when making a purchase suggestion','YesNo'),('AllowRenewalLimitOverride','0',NULL,'if ON, allows renewal limits to be overridden on the circulation screen','YesNo'),('AllowReturnToBranch','anywhere','anywhere|homebranch|holdingbranch|homeorholdingbranch','Where an item may be returned','Choice'),('AllowSelfCheckReturns','0','','If enabled, patrons may return items through the Web-based Self Checkout','YesNo'),('AllowTooManyOverride','1','','If on, allow staff to override and check out items when the patron has reached the maximum number of allowed checkouts','YesNo'),('alphabet','A B C D E F G H I J K L M N O P Q R S T U V W X Y Z',NULL,'Alphabet than can be expanded into browse links, e.g. on Home > Patrons','free'),('AlternateHoldingsField','',NULL,'The MARC field/subfield that contains alternate holdings information for bibs taht do not have items attached (e.g. 852abchi for libraries converting from MARC Magician).','free'),('AlternateHoldingsSeparator','',NULL,'The string to use to separate subfields in alternate holdings displays.','free'),('AmazonAssocTag','','','See:  http://aws.amazon.com','free'),('AmazonCoverImages','0','','Display Cover Images in Staff Client from Amazon Web Services','YesNo'),('AmazonLocale','US','US|CA|DE|FR|JP|UK','Use to set the Locale of your Amazon.com Web Services','Choice'),('AnonSuggestions','0',NULL,'Set to enable Anonymous suggestions to AnonymousPatron borrowernumber','YesNo'),('AnonymousPatron','0',NULL,'Set the identifier (borrowernumber) of the anonymous patron. Used for Suggestion and reading history privacy',''),('AuthDisplayHierarchy','0','','Display authority hierarchies','YesNo'),('AuthoritiesLog','1',NULL,'If ON, log edit/create/delete actions on authorities.','YesNo'),('authoritysep','--','10','Used to separate a list of authorities in a display. Usually --','free'),('autoBarcode','OFF','incremental|annual|hbyymmincr|EAN13|OFF','Used to autogenerate a barcode: incremental will be of the form 1, 2, 3; annual of the form 2007-0001, 2007-0002; hbyymmincr of the form HB08010001 where HB=Home Branch','Choice'),('AutoCreateAuthorities','0',NULL,'Automatically create authorities that do not exist when cataloging records.','YesNo'),('AutoEmailOpacUser','0',NULL,'Sends notification emails containing new account details to patrons - when account is created.','YesNo'),('AutoEmailPrimaryAddress','OFF','email|emailpro|B_email|cardnumber|OFF','Defines the default email address where \'Account Details\' emails are sent.','Choice'),('AutoLocation','0',NULL,'If ON, IP authentication is enabled, blocking access to the staff client from unauthorized IP addresses','YesNo'),('AutomaticItemReturn','1',NULL,'If ON, Koha will automatically set up a transfer of this item to its homebranch','YesNo'),('autoMemberNum','1','','If ON, patron number is auto-calculated','YesNo'),('AutoRemoveOverduesRestrictions','0',NULL,'Defines whether an OVERDUES debarment should be lifted automatically if all overdue items are returned by the patron.','YesNo'),('AutoResumeSuspendedHolds','1',NULL,'Allow suspended holds to be automatically resumed by a set date.','YesNo'),('AutoSelfCheckAllowed','0','','For corporate and special libraries which want web-based self-check available from any PC without the need for a manual staff login. Most libraries will want to leave this turned off. If on, requires self-check ID and password to be entered in AutoSelfCheckID and AutoSelfCheckPass sysprefs.','YesNo'),('AutoSelfCheckID','','','Staff ID with circulation rights to be used for automatic web-based self-check. Only applies if AutoSelfCheckAllowed syspref is turned on.','free'),('AutoSelfCheckPass','','','Password to be used for automatic web-based self-check. Only applies if AutoSelfCheckAllowed syspref is turned on.','free'),('Babeltheque','0','','Turn ON Babeltheque content  - See babeltheque.com to subscribe to this service','YesNo'),('Babeltheque_url_js','','','Url for Babeltheque javascript (e.g. http://www.babeltheque.com/bw_XX.js)','Free'),('Babeltheque_url_update','','','Url for Babeltheque update (E.G. http://www.babeltheque.com/.../file.csv.bz2)','Free'),('BakerTaylorBookstoreURL','','','URL template for \"My Libary Bookstore\" links, to which the \"key\" value is appended, and \"https://\" is prepended.  It should include your hostname and \"Parent Number\".  Make this variable empty to turn MLB links off.  Example: ocls.mylibrarybookstore.com/MLB/actions/searchHandler.do?nextPage=bookDetails&parentNum=10923&key=',''),('BakerTaylorEnabled','0','','Enable or disable all Baker & Taylor features.','YesNo'),('BakerTaylorPassword','','','Baker & Taylor Password for Content Cafe (external content)','Free'),('BakerTaylorUsername','','','Baker & Taylor Username for Content Cafe (external content)','Free'),('BasketConfirmations','1','always ask for confirmation.|do not ask for confirmation.','When closing or reopening a basket,','Choice'),('BiblioAddsAuthorities','0',NULL,'If ON, adding a new biblio will check for an existing authority record and create one on the fly if one doesn\'t exist','YesNo'),('BiblioDefaultView','normal','normal|marc|isbd','Choose the default detail view in the catalog; choose between normal, marc or isbd','Choice'),('BlockExpiredPatronOpacActions','1',NULL,'Set whether an expired patron can perform opac actions such as placing holds or renew books, can be overridden on a per patron-type basis','YesNo'),('BlockReturnOfWithdrawnItems','1','0','If enabled, items that are marked as withdrawn cannot be returned.','YesNo'),('BorrowerMandatoryField','surname|cardnumber',NULL,'Choose the mandatory fields for a patron\'s account','free'),('borrowerRelationship','father|mother','','Define valid relationships between a guarantor & a guarantee (separated by | or ,)','free'),('BorrowerRenewalPeriodBase','now','dateexpiry|now','Set whether the borrower renewal date should be counted from the dateexpiry or from the current date ','Choice'),('BorrowersLog','1',NULL,'If ON, log edit/create/delete actions on patron data','YesNo'),('BorrowersTitles','Mr|Mrs|Miss|Ms',NULL,'Define appropriate Titles for patrons','free'),('BorrowerUnwantedField','',NULL,'Name the fields you don\'t need to store for a patron\'s account','free'),('BranchTransferLimitsType','ccode','itemtype|ccode','When using branch transfer limits, choose whether to limit by itemtype or collection code.','Choice'),('CalculateFinesOnReturn','1','','Switch to control if overdue fines are calculated on return or not','YesNo'),('CalendarFirstDayOfWeek','Sunday','Sunday|Monday','Select the first day of week to use in the calendar.','Choice'),('canreservefromotherbranches','1','','With Independent branches on, can a user from one library place a hold on an item from another library','YesNo'),('casAuthentication','0','','Enable or disable CAS authentication','YesNo'),('casLogout','0','','Does a logout from Koha should also log the user out of CAS?','YesNo'),('casServerUrl','https://localhost:8443/cas','','URL of the cas server','Free'),('CatalogModuleRelink','0',NULL,'If OFF the linker will never replace the authids that are set in the cataloging module.','YesNo'),('CataloguingLog','1',NULL,'If ON, log edit/create/delete actions on bibliographic data. WARNING: this feature is very resource consuming.','YesNo'),('checkdigit','none','none|katipo','If ON, enable checks on patron cardnumber: none or \"Katipo\" style checks','Choice'),('CircAutocompl','1',NULL,'If ON, autocompletion is enabled for the Circulation input','YesNo'),('CircAutoPrintQuickSlip','qslip',NULL,'Choose what should happen when an empty barcode field is submitted in circulation: Display a print quick slip window, Display a print slip window or Clear the screen.','Choice'),('CircControl','ItemHomeLibrary','PickupLibrary|PatronLibrary|ItemHomeLibrary','Specify the agency that controls the circulation and fines policy','Choice'),('COinSinOPACResults','1','','If ON, use COinS in OPAC search results page.  NOTE: this can slow down search response time significantly','YesNo'),('ConfirmFutureHolds','0','','Number of days for confirming future holds','Integer'),('CurrencyFormat','US','US|FR','Determines the display format of currencies. eg: \'36000\' is displayed as \'360 000,00\'  in \'FR\' or \'360,000.00\'  in \'US\'.','Choice'),('dateformat','us','metric|us|iso','Define global date format (us mm/dd/yyyy, metric dd/mm/yyy, ISO yyyy-mm-dd)','Choice'),('DebugLevel','2','0|1|2','Define the level of debugging information sent to the browser when errors are encountered (set to 0 in production). 0=none, 1=some, 2=most','Choice'),('decreaseLoanHighHolds',NULL,'','Decreases the loan period for items with number of holds above the threshold specified in decreaseLoanHighHoldsValue','YesNo'),('decreaseLoanHighHoldsDuration',NULL,'','Specifies a number of days that a loan is reduced to when used in conjunction with decreaseLoanHighHolds','Integer'),('decreaseLoanHighHoldsValue',NULL,'','Specifies a threshold for the minimum number of holds needed to trigger a reduction in loan duration (used with decreaseLoanHighHolds)','Integer'),('DefaultClassificationSource','ddc',NULL,'Default classification scheme used by the collection. E.g., Dewey, LCC, etc.','ClassSources'),('DefaultLanguageField008','','','Fill in the default language for field 008 Range 35-37 of MARC21 records (e.g. eng, nor, ger, see <a href=\"http://www.loc.gov/marc/languages/language_code.html\">MARC Code List for Languages</a>)','Free'),('defaultSortField','relevance','relevance|popularity|call_number|pubdate|acqdate|title|author','Specify the default field used for sorting','Choice'),('defaultSortOrder','dsc','asc|dsc|az|za','Specify the default sort order','Choice'),('delimiter',';',';|tabulation|,|/|\\|#||','Define the default separator character for exporting reports','Choice'),('Display856uAsImage','OFF','OFF|Details|Results|Both','Display the URI in the 856u field as an image, the corresponding Staff Client XSLT option must be on','Choice'),('DisplayClearScreenButton','0','','If set to ON, a clear screen button will appear on the circulation page.','YesNo'),('displayFacetCount','0',NULL,NULL,'YesNo'),('DisplayIconsXSLT','1','','If ON, displays the format, audience, and material type icons in XSLT MARC21 results and detail pages.','YesNo'),('DisplayLibraryFacets','holding','home|holding|both','Defines which library facets to display.','Choice'),('DisplayMultiPlaceHold','1','','Display the ability to place multiple holds or not','YesNo'),('DisplayOPACiconsXSLT','1','','If ON, displays the format, audience, and material type icons in XSLT MARC21 results and detail pages in the OPAC.','YesNo'),('dontmerge','1',NULL,'If ON, modifying an authority record will not update all associated bibliographic records immediately, ask your system administrator to enable the merge_authorities.pl cron job','YesNo'),('EasyAnalyticalRecords','0','','If on, display in the catalogue screens tools to easily setup analytical record relationships','YesNo'),('emailLibrarianWhenHoldIsPlaced','0',NULL,'If ON, emails the librarian whenever a hold is placed','YesNo'),('EnableBorrowerFiles','0',NULL,'If enabled, allows librarians to upload and attach arbitrary files to a borrower record.','YesNo'),('EnableOpacSearchHistory','1','YesNo','Enable or disable opac search history',''),('EnableSearchHistory','0','','Enable or disable search history','YesNo'),('EnhancedMessagingPreferences','0','','If ON, allows patrons to select to receive additional messages about items due or nearly due.','YesNo'),('expandedSearchOption','0',NULL,'If ON, set advanced search to be expanded by default','YesNo'),('ExpireReservesMaxPickUpDelay','0','','Enabling this allows holds to expire automatically if they have not been picked by within the time period specified in ReservesMaxPickUpDelay','YesNo'),('ExpireReservesMaxPickUpDelayCharge','0',NULL,'If ExpireReservesMaxPickUpDelay is enabled, and this field has a non-zero value, than a borrower whose waiting hold has expired will be charged this amount.','free'),('ExtendedPatronAttributes','0',NULL,'Use extended patron IDs and attributes','YesNo'),('FacetLabelTruncationLength','20',NULL,'Specify the facet max length in OPAC','Integer'),('FilterBeforeOverdueReport','0','','Do not run overdue report until filter selected','YesNo'),('FineNotifyAtCheckin','0',NULL,'If ON notify librarians of overdue fines on the items they are checking in.','YesNo'),('finesCalendar','noFinesWhenClosed','ignoreCalendar|noFinesWhenClosed','Specify whether to use the Calendar in calculating duedates and fines','Choice'),('FinesIncludeGracePeriod','1',NULL,'If enabled, fines calculations will include the grace period.','YesNo'),('FinesLog','1',NULL,'If ON, log fines','YesNo'),('finesMode','test','off|test|production','Choose the fines mode, \'off\', \'test\' (emails admin report) or \'production\' (accrue overdue fines).  Requires accruefines cronjob.','Choice'),('FrameworksLoaded','sysprefs.sql|auth_values.sql|class_sources.sql|message_transport_types.sql|sample_frequencies.sql|sample_notices.sql|sample_notices_message_attributes.sql|sample_notices_message_transports.sql|sample_numberpatterns.sql|stopwords.sql|subtag_registry.sql|userflags.sql|userpermissions.sql',NULL,'Frameworks loaded through webinstaller','choice'),('FRBRizeEditions','0','','If ON, Koha will query one or more ISBN web services for associated ISBNs and display an Editions tab on the details pages','YesNo'),('gist','0','','Default Goods and Services tax rate NOT in %, but in numeric form (0.12 for 12%), set to 0 to disable GST','Integer'),('GoogleJackets','0',NULL,'if ON, displays jacket covers from Google Books API','YesNo'),('hidelostitems','0','','If ON, disables display of\"lost\" items in OPAC.','YesNo'),('HidePatronName','0','','If this is switched on, patron\'s cardnumber will be shown instead of their name on the holds and catalog screens','YesNo'),('hide_marc','0',NULL,'If ON, disables display of MARC fields, subfield codes & indicators (still shows data)','YesNo'),('HighlightOwnItemsOnOPAC','0','','If on, and a patron is logged into the OPAC, items from his or her home library will be emphasized and shown first in search results and item details.','YesNo'),('HighlightOwnItemsOnOPACWhich','PatronBranch','PatronBranch|OpacURLBranch','Decides which branch\'s items to emphasize. If PatronBranch, emphasize the logged in user\'s library\'s items. If OpacURLBranch, highlight the items of the Apache var BRANCHCODE defined in Koha\'s Apache configuration file.','Choice'),('HoldsToPullStartDate','2',NULL,'Set the default start date for the Holds to pull list to this many days ago','Integer'),('HomeOrHoldingBranch','holdingbranch','holdingbranch|homebranch','Used by Circulation to determine which branch of an item to check with independent branches on, and by search to determine which branch to choose for availability ','Choice'),('HomeOrHoldingBranchReturn','homebranch','holdingbranch|homebranch','Used by Circulation to determine which branch of an item to check checking-in items','Choice'),('HTML5MediaEnabled','not','not|opac|staff|both','Show a tab with a HTML5 media player for files catalogued in field 856','Choice'),('HTML5MediaExtensions','webm|ogg|ogv|oga|vtt','','Media file extensions','free'),('IDreamBooksReadometer','0','','Display Readometer from IDreamBooks.com','YesNo'),('IDreamBooksResults','0','','Display IDreamBooks.com rating in search results','YesNo'),('IDreamBooksReviews','0','','Display book review snippets from IDreamBooks.com','YesNo'),('ILS-DI','0','','Enables ILS-DI services at OPAC.','YesNo'),('ILS-DI:AuthorizedIPs','','Restricts usage of ILS-DI to some IPs','.','Free'),('ImageLimit','5','','Limit images stored in the database by the Patron Card image manager to this number.','Integer'),('IncludeSeeFromInSearches','0','','Include see-from references in searches.','YesNo'),('IndependentBranches','0',NULL,'If ON, increases security between libraries','YesNo'),('InProcessingToShelvingCart','0','','If set, when any item with a location code of PROC is \'checked in\', it\'s location code will be changed to CART.','YesNo'),('INTRAdidyoumean',NULL,NULL,'Did you mean? configuration for the Intranet. Do not change, as this is controlled by /cgi-bin/koha/admin/didyoumean.pl.','Free'),('IntranetBiblioDefaultView','normal','normal|marc|isbd|labeled_marc','Choose the default detail view in the staff interface; choose between normal, labeled_marc, marc or isbd','Choice'),('intranetbookbag','1','','If ON, enables display of Cart feature in the intranet','YesNo'),('intranetcolorstylesheet','','50','Define the color stylesheet to use in the Staff Client','free'),('IntranetFavicon','','','Enter a complete URL to an image to replace the default Koha favicon on the Staff client','free'),('IntranetmainUserblock','','70|10','Add a block of HTML that will display on the intranet home page','Textarea'),('IntranetNav','','70|10','Use HTML tabs to add navigational links to the top-hand navigational bar in the Staff Client','Textarea'),('IntranetNumbersPreferPhrase','0',NULL,'Control the use of phr operator in callnumber and standard number staff client searches','YesNo'),('intranetreadinghistory','1','','If ON, Reading History is enabled for all patrons','YesNo'),('IntranetSlipPrinterJS','','','Use this JavaScript for printing slips. Define at least function printThenClose(). For use e.g. with Firefox PlugIn jsPrintSetup, see http://jsprintsetup.mozdev.org/','Free'),('intranetstylesheet','','50','Enter a complete URL to use an alternate layout stylesheet in Intranet','free'),('IntranetUserCSS','',NULL,'Add CSS to be included in the intranet in an embedded <style> tag.','free'),('intranetuserjs','','70|10','Custom javascript for inclusion in Intranet','Textarea'),('intranet_includes','includes',NULL,'The includes directory you want for specific look of Koha (includes or includes_npl for example)','Free'),('ISBD','#100||{ 100a }{ 100b }{ 100c }{ 100d }{ 110a }{ 110b }{ 110c }{ 110d }{ 110e }{ 110f }{ 110g }{ 130a }{ 130d }{ 130f }{ 130g }{ 130h }{ 130k }{ 130l }{ 130m }{ 130n }{ 130o }{ 130p }{ 130r }{ 130s }{ 130t }|<br/><br/>\r\n#245||{ 245a }{ 245b }{245f }{ 245g }{ 245k }{ 245n }{ 245p }{ 245s }{ 245h }|\r\n#246||{ : 246i }{ 246a }{ 246b }{ 246f }{ 246g }{ 246n }{ 246p }{ 246h }|\r\n#242||{ = 242a }{ 242b }{ 242n }{ 242p }{ 242h }|\r\n#245||{ 245c }|\r\n#242||{ = 242c }|\r\n#250| - |{ 250a }{ 250b }|\r\n#254|, |{ 254a }|\r\n#255|, |{ 255a }{ 255b }{ 255c }{ 255d }{ 255e }{ 255f }{ 255g }|\r\n#256|, |{ 256a }|\r\n#257|, |{ 257a }|\r\n#258|, |{ 258a }{ 258b }|\r\n#260| - |{ 260a }{ 260b }{ 260c }|\r\n#300| - |{ 300a }{ 300b }{ 300c }{ 300d }{ 300e }{ 300f }{ 300g }|\r\n#306| - |{ 306a }|\r\n#307| - |{ 307a }{ 307b }|\r\n#310| - |{ 310a }{ 310b }|\r\n#321| - |{ 321a }{ 321b }|\r\n#340| - |{ 3403 }{ 340a }{ 340b }{ 340c }{ 340d }{ 340e }{ 340f }{ 340h }{ 340i }|\r\n#342| - |{ 342a }{ 342b }{ 342c }{ 342d }{ 342e }{ 342f }{ 342g }{ 342h }{ 342i }{ 342j }{ 342k }{ 342l }{ 342m }{ 342n }{ 342o }{ 342p }{ 342q }{ 342r }{ 342s }{ 342t }{ 342u }{ 342v }{ 342w }|\r\n#343| - |{ 343a }{ 343b }{ 343c }{ 343d }{ 343e }{ 343f }{ 343g }{ 343h }{ 343i }|\r\n#351| - |{ 3513 }{ 351a }{ 351b }{ 351c }|\r\n#352| - |{ 352a }{ 352b }{ 352c }{ 352d }{ 352e }{ 352f }{ 352g }{ 352i }{ 352q }|\r\n#362| - |{ 362a }{ 351z }|\r\n#440| - |{ 440a }{ 440n }{ 440p }{ 440v }{ 440x }|.\r\n#490| - |{ 490a }{ 490v }{ 490x }|.\r\n#800| - |{ 800a }{ 800b }{ 800c }{ 800d }{ 800e }{ 800f }{ 800g }{ 800h }{ 800j }{ 800k }{ 800l }{ 800m }{ 800n }{ 800o }{ 800p }{ 800q }{ 800r }{ 800s }{ 800t }{ 800u }{ 800v }|.\r\n#810| - |{ 810a }{ 810b }{ 810c }{ 810d }{ 810e }{ 810f }{ 810g }{ 810h }{ 810k }{ 810l }{ 810m }{ 810n }{ 810o }{ 810p }{ 810r }{ 810s }{ 810t }{ 810u }{ 810v }|.\r\n#811| - |{ 811a }{ 811c }{ 811d }{ 811e }{ 811f }{ 811g }{ 811h }{ 811k }{ 811l }{ 811n }{ 811p }{ 811q }{ 811s }{ 811t }{ 811u }{ 811v }|.\r\n#830| - |{ 830a }{ 830d }{ 830f }{ 830g }{ 830h }{ 830k }{ 830l }{ 830m }{ 830n }{ 830o }{ 830p }{ 830r }{ 830s }{ 830t }{ 830v }|.\r\n#500|<br/><br/>|{ 5003 }{ 500a }|\r\n#501|<br/><br/>|{ 501a }|\r\n#502|<br/><br/>|{ 502a }|\r\n#504|<br/><br/>|{ 504a }|\r\n#505|<br/><br/>|{ 505a }{ 505t }{ 505r }{ 505g }{ 505u }|\r\n#506|<br/><br/>|{ 5063 }{ 506a }{ 506b }{ 506c }{ 506d }{ 506u }|\r\n#507|<br/><br/>|{ 507a }{ 507b }|\r\n#508|<br/><br/>|{ 508a }{ 508a }|\r\n#510|<br/><br/>|{ 5103 }{ 510a }{ 510x }{ 510c }{ 510b }|\r\n#511|<br/><br/>|{ 511a }|\r\n#513|<br/><br/>|{ 513a }{513b }|\r\n#514|<br/><br/>|{ 514z }{ 514a }{ 514b }{ 514c }{ 514d }{ 514e }{ 514f }{ 514g }{ 514h }{ 514i }{ 514j }{ 514k }{ 514m }{ 514u }|\r\n#515|<br/><br/>|{ 515a }|\r\n#516|<br/><br/>|{ 516a }|\r\n#518|<br/><br/>|{ 5183 }{ 518a }|\r\n#520|<br/><br/>|{ 5203 }{ 520a }{ 520b }{ 520u }|\r\n#521|<br/><br/>|{ 5213 }{ 521a }{ 521b }|\r\n#522|<br/><br/>|{ 522a }|\r\n#524|<br/><br/>|{ 524a }|\r\n#525|<br/><br/>|{ 525a }|\r\n#526|<br/><br/>|{\\n510i }{\\n510a }{ 510b }{ 510c }{ 510d }{\\n510x }|\r\n#530|<br/><br/>|{\\n5063 }{\\n506a }{ 506b }{ 506c }{ 506d }{\\n506u }|\r\n#533|<br/><br/>|{\\n5333 }{\\n533a }{\\n533b }{\\n533c }{\\n533d }{\\n533e }{\\n533f }{\\n533m }{\\n533n }|\r\n#534|<br/><br/>|{\\n533p }{\\n533a }{\\n533b }{\\n533c }{\\n533d }{\\n533e }{\\n533f }{\\n533m }{\\n533n }{\\n533t }{\\n533x }{\\n533z }|\r\n#535|<br/><br/>|{\\n5353 }{\\n535a }{\\n535b }{\\n535c }{\\n535d }|\r\n#538|<br/><br/>|{\\n5383 }{\\n538a }{\\n538i }{\\n538u }|\r\n#540|<br/><br/>|{\\n5403 }{\\n540a }{ 540b }{ 540c }{ 540d }{\\n520u }|\r\n#544|<br/><br/>|{\\n5443 }{\\n544a }{\\n544b }{\\n544c }{\\n544d }{\\n544e }{\\n544n }|\r\n#545|<br/><br/>|{\\n545a }{ 545b }{\\n545u }|\r\n#546|<br/><br/>|{\\n5463 }{\\n546a }{ 546b }|\r\n#547|<br/><br/>|{\\n547a }|\r\n#550|<br/><br/>|{ 550a }|\r\n#552|<br/><br/>|{ 552z }{ 552a }{ 552b }{ 552c }{ 552d }{ 552e }{ 552f }{ 552g }{ 552h }{ 552i }{ 552j }{ 552k }{ 552l }{ 552m }{ 552n }{ 562o }{ 552p }{ 552u }|\r\n#555|<br/><br/>|{ 5553 }{ 555a }{ 555b }{ 555c }{ 555d }{ 555u }|\r\n#556|<br/><br/>|{ 556a }{ 506z }|\r\n#563|<br/><br/>|{ 5633 }{ 563a }{ 563u }|\r\n#565|<br/><br/>|{ 5653 }{ 565a }{ 565b }{ 565c }{ 565d }{ 565e }|\r\n#567|<br/><br/>|{ 567a }|\r\n#580|<br/><br/>|{ 580a }|\r\n#581|<br/><br/>|{ 5633 }{ 581a }{ 581z }|\r\n#584|<br/><br/>|{ 5843 }{ 584a }{ 584b }|\r\n#585|<br/><br/>|{ 5853 }{ 585a }|\r\n#586|<br/><br/>|{ 5863 }{ 586a }|\r\n#020|<br/><br/><label>ISBN: </label>|{ 020a }{ 020c }|\r\n#022|<br/><br/><label>ISSN: </label>|{ 022a }|\r\n#222| = |{ 222a }{ 222b }|\r\n#210| = |{ 210a }{ 210b }|\r\n#024|<br/><br/><label>Standard No.: </label>|{ 024a }{ 024c }{ 024d }{ 0242 }|\r\n#027|<br/><br/><label>Standard Tech. Report. No.: </label>|{ 027a }|\r\n#028|<br/><br/><label>Publisher. No.: </label>|{ 028a }{ 028b }|\r\n#013|<br/><br/><label>Patent No.: </label>|{ 013a }{ 013b }{ 013c }{ 013d }{ 013e }{ 013f }|\r\n#030|<br/><br/><label>CODEN: </label>|{ 030a }|\r\n#037|<br/><br/><label>Source: </label>|{ 037a }{ 037b }{ 037c }{ 037f }{ 037g }{ 037n }|\r\n#010|<br/><br/><label>LCCN: </label>|{ 010a }|\r\n#015|<br/><br/><label>Nat. Bib. No.: </label>|{ 015a }{ 0152 }|\r\n#016|<br/><br/><label>Nat. Bib. Agency Control No.: </label>|{ 016a }{ 0162 }|\r\n#600|<br/><br/><label>Subjects--Personal Names: </label>|{\\n6003 }{\\n600a}{ 600b }{ 600c }{ 600d }{ 600e }{ 600f }{ 600g }{ 600h }{--600k}{ 600l }{ 600m }{ 600n }{ 600o }{--600p}{ 600r }{ 600s }{ 600t }{ 600u }{--600x}{--600z}{--600y}{--600v}|\r\n#610|<br/><br/><label>Subjects--Corporate Names: </label>|{\\n6103 }{\\n610a}{ 610b }{ 610c }{ 610d }{ 610e }{ 610f }{ 610g }{ 610h }{--610k}{ 610l }{ 610m }{ 610n }{ 610o }{--610p}{ 610r }{ 610s }{ 610t }{ 610u }{--610x}{--610z}{--610y}{--610v}|\r\n#611|<br/><br/><label>Subjects--Meeting Names: </label>|{\\n6113 }{\\n611a}{ 611b }{ 611c }{ 611d }{ 611e }{ 611f }{ 611g }{ 611h }{--611k}{ 611l }{ 611m }{ 611n }{ 611o }{--611p}{ 611r }{ 611s }{ 611t }{ 611u }{--611x}{--611z}{--611y}{--611v}|\r\n#630|<br/><br/><label>Subjects--Uniform Titles: </label>|{\\n630a}{ 630b }{ 630c }{ 630d }{ 630e }{ 630f }{ 630g }{ 630h }{--630k }{ 630l }{ 630m }{ 630n }{ 630o }{--630p}{ 630r }{ 630s }{ 630t }{--630x}{--630z}{--630y}{--630v}|\r\n#648|<br/><br/><label>Subjects--Chronological Terms: </label>|{\\n6483 }{\\n648a }{--648x}{--648z}{--648y}{--648v}|\r\n#650|<br/><br/><label>Subjects--Topical Terms: </label>|{\\n6503 }{\\n650a}{ 650b }{ 650c }{ 650d }{ 650e }{--650x}{--650z}{--650y}{--650v}|\r\n#651|<br/><br/><label>Subjects--Geographic Terms: </label>|{\\n6513 }{\\n651a}{ 651b }{ 651c }{ 651d }{ 651e }{--651x}{--651z}{--651y}{--651v}|\r\n#653|<br/><br/><label>Subjects--Index Terms: </label>|{ 653a }|\r\n#654|<br/><br/><label>Subjects--Facted Index Terms: </label>|{\\n6543 }{\\n654a}{--654b}{--654x}{--654z}{--654y}{--654v}|\r\n#655|<br/><br/><label>Index Terms--Genre/Form: </label>|{\\n6553 }{\\n655a}{--655b}{--655x }{--655z}{--655y}{--655v}|\r\n#656|<br/><br/><label>Index Terms--Occupation: </label>|{\\n6563 }{\\n656a}{--656k}{--656x}{--656z}{--656y}{--656v}|\r\n#657|<br/><br/><label>Index Terms--Function: </label>|{\\n6573 }{\\n657a}{--657x}{--657z}{--657y}{--657v}|\r\n#658|<br/><br/><label>Index Terms--Curriculum Objective: </label>|{\\n658a}{--658b}{--658c}{--658d}{--658v}|\r\n#050|<br/><br/><label>LC Class. No.: </label>|{ 050a }{ / 050b }|\r\n#082|<br/><br/><label>Dewey Class. No.: </label>|{ 082a }{ / 082b }|\r\n#080|<br/><br/><label>Universal Decimal Class. No.: </label>|{ 080a }{ 080x }{ / 080b }|\r\n#070|<br/><br/><label>National Agricultural Library Call No.: </label>|{ 070a }{ / 070b }|\r\n#060|<br/><br/><label>National Library of Medicine Call No.: </label>|{ 060a }{ / 060b }|\r\n#074|<br/><br/><label>GPO Item No.: </label>|{ 074a }|\r\n#086|<br/><br/><label>Gov. Doc. Class. No.: </label>|{ 086a }|\r\n#088|<br/><br/><label>Report. No.: </label>|{ 088a }|','70|10','ISBD','Textarea'),('IssueLog','1',NULL,'If ON, log checkout activity','YesNo'),('IssueLostItem','alert','Defines what should be done when an attempt is made to issue an item that has been marked as lost.','alert|confirm|nothing','Choice'),('IssuingInProcess','0',NULL,'If ON, disables fines if the patron is issuing item that accumulate debt','YesNo'),('item-level_itypes','1','','If ON, enables Item-level Itemtype / Issuing Rules','YesNo'),('itemBarcodeFallbackSearch','',NULL,'If set, uses scanned item barcodes as a catalogue search if not found as barcodes','YesNo'),('itemBarcodeInputFilter','','whitespace|T-prefix|cuecat|libsuite8|EAN13','If set, allows specification of a item barcode input filter','Choice'),('itemcallnumber','082ab',NULL,'The MARC field/subfield that is used to calculate the itemcallnumber (Dewey would be 082ab or 092ab; LOC would be 050ab or 090ab) could be 852hi from an item record','free'),('KohaAdminEmailAddress','root@localhost','','Define the email address where patron modification requests are sent','free'),('LabelMARCView','standard','standard|economical','Define how a MARC record will display','Choice'),('language','en',NULL,'Set the default language in the staff client.','Languages'),('LetterLog','1',NULL,'If ON, log all notices sent','YesNo'),('LibraryName','','','Define the library name as displayed on the OPAC',''),('LibraryThingForLibrariesEnabled','0','','Enable or Disable Library Thing for Libraries Features','YesNo'),('LibraryThingForLibrariesID','','','See:http://librarything.com/forlibraries/','free'),('LibraryThingForLibrariesTabbedView','0','','Put LibraryThingForLibraries Content in Tabs.','YesNo'),('LinkerKeepStale','0',NULL,'If ON the authority linker will keep existing authority links for headings where it is unable to find a match.','YesNo'),('LinkerModule','Default','Default|FirstMatch|LastMatch','Chooses which linker module to use (see documentation).','Choice'),('LinkerOptions','','','A pipe-separated list of options for the linker.','free'),('LinkerRelink','1',NULL,'If ON the authority linker will relink headings that have previously been linked every time it runs.','YesNo'),('LocalCoverImages','0','1','Display local cover images on intranet details pages.','YesNo'),('ManInvInNoissuesCharge','1',NULL,'MANUAL_INV charges block checkouts (added to noissuescharge).','YesNo'),('MARCAuthorityControlField008','|| aca||aabn           | a|a     d',NULL,'Define the contents of MARC21 authority control field 008 position 06-39','Textarea'),('MarcFieldsToOrder','',NULL,'Set the mapping values for a new order line created from a MARC record in a staged file. In a YAML format.','textarea'),('marcflavour','MARC21','MARC21|UNIMARC|NORMARC','Define global MARC flavor (MARC21, UNIMARC or NORMARC) used for character encoding','Choice'),('MARCOrgCode','OSt','','Define MARC Organization Code for MARC21 records - http://www.loc.gov/marc/organizations/orgshome.html','free'),('MaxFine',NULL,'','Maximum fine a patron can have for all late returns at one moment. Single item caps are specified in the circulation rules matrix.','Integer'),('MaxItemsForBatch','1000',NULL,'Max number of items record to process in a batch (modification or deletion)','Integer'),('maxItemsInSearchResults','20',NULL,'Specify the maximum number of items to display for each result on a page of results','free'),('maxoutstanding','5','','maximum amount withstanding to be able make holds','Integer'),('maxRecordsForFacets','20',NULL,NULL,'Integer'),('maxreserves','50','','Define maximum number of holds a patron can place','Integer'),('minPasswordLength','3',NULL,'Specify the minimum length of a patron/staff password','free'),('NewItemsDefaultLocation','','','If set, all new items will have a location of the given Location Code ( Authorized Value type LOC )',''),('noissuescharge','5','','Define maximum amount withstanding before check outs are blocked','Integer'),('noItemTypeImages','0',NULL,'If ON, disables item-type images','YesNo'),('NoLoginInstructions','','60|10','Instructions to display on the OPAC login form when a patron is not logged in','Textarea'),('NotesBlacklist','',NULL,'List of notes fields that should not appear in the title notes/description separator of details','free'),('NoticeCSS','',NULL,'Notices CSS url.','free'),('NotifyBorrowerDeparture','30',NULL,'Define number of days before expiry where circulation is warned about patron account expiry','Integer'),('NovelistSelectEnabled','0',NULL,'Enable Novelist Select content.  Requires Novelist Profile and Password','YesNo'),('NovelistSelectPassword',NULL,NULL,'Enable Novelist user Profile','free'),('NovelistSelectProfile',NULL,NULL,'Novelist Select user Password','free'),('NovelistSelectView','tab','tab|above|below|right','Where to display Novelist Select content','Choice'),('numReturnedItemsToShow','20',NULL,'Number of returned items to show on the check-in page','Integer'),('numSearchResults','20',NULL,'Specify the maximum number of results to display on a page of results','Integer'),('numSearchRSSResults','50',NULL,'Specify the maximum number of results to display on a RSS page of results','Integer'),('OAI-PMH','0',NULL,'if ON, OAI-PMH server is enabled','YesNo'),('OAI-PMH:archiveID','KOHA-OAI-TEST',NULL,'OAI-PMH archive identification','Free'),('OAI-PMH:AutoUpdateSets','0','','Automatically update OAI sets when a bibliographic record is created or updated','YesNo'),('OAI-PMH:ConfFile','',NULL,'If empty, Koha OAI Server operates in normal mode, otherwise it operates in extended mode.','File'),('OAI-PMH:MaxCount','50',NULL,'OAI-PMH maximum number of records by answer to ListRecords and ListIdentifiers queries','Integer'),('OCLCAffiliateID','','','Use with FRBRizeEditions and XISBN. You can sign up for an AffiliateID here: http://www.worldcat.org/wcpa/do/AffiliateUserServices?method=initSelfRegister','free'),('OpacAddMastheadLibraryPulldown','0','','Adds a pulldown menu to select the library to search on the opac masthead.','YesNo'),('OPACAllowHoldDateInFuture','0','','If set, along with the AllowHoldDateInFuture system preference, OPAC users can set the date of a hold to be in the future.','YesNo'),('OpacAllowPublicListCreation','1',NULL,'If set, allows opac users to create public lists','YesNo'),('OpacAllowSharingPrivateLists','0',NULL,'If set, allows opac users to share private lists with other patrons','YesNo'),('OPACAllowUserToChooseBranch','1','1','Allow the user to choose the branch they want to pickup their hold from','YesNo'),('OPACAmazonCoverImages','0','','Display cover images on OPAC from Amazon Web Services','YesNo'),('OpacAuthorities','1',NULL,'If ON, enables the search authorities link on OPAC','YesNo'),('OPACBaseURL',NULL,NULL,'Specify the Base URL of the OPAC, e.g., opac.mylibrary.com, the http:// will be added automatically by Koha.','Free'),('opacbookbag','1','','If ON, enables display of Cart feature','YesNo'),('OpacBrowser','0',NULL,'If ON, enables subject authorities browser on OPAC (needs to set misc/cronjob/sbuild_browser_and_cloud.pl)','YesNo'),('OpacBrowseResults','1',NULL,'Disable/enable browsing and paging search results from the OPAC detail page.','YesNo'),('OpacCloud','0',NULL,'If ON, enables subject cloud on OPAC','YesNo'),('opaccolorstylesheet','','','Define an auxiliary stylesheet for OPAC use, to override specified settings from the primary opac.css stylesheet. Enter the filename (if the file is in the server\'s css directory) or a complete URL beginning with http (if the file lives on a remote server).','free'),('opaccredits','','70|10','Define HTML Credits at the bottom of the OPAC page','Textarea'),('OPACdefaultSortField','relevance','relevance|popularity|call_number|pubdate|acqdate|title|author','Specify the default field used for sorting','Choice'),('OPACdefaultSortOrder','dsc','asc|dsc|za|az','Specify the default sort order','Choice'),('OPACdidyoumean',NULL,NULL,'Did you mean? configuration for the OPAC. Do not change, as this is controlled by /cgi-bin/koha/admin/didyoumean.pl.','Free'),('OPACDisplay856uAsImage','OFF','OFF|Details|Results|Both','Display the URI in the 856u field as an image, the corresponding OPACXSLT option must be on','Choice'),('OpacExportOptions','bibtex|dc|marcxml|marc8|utf8|marcstd|mods|ris','','Define export options available on OPAC detail page.','free'),('OpacFavicon','','','Enter a complete URL to an image to replace the default Koha favicon on the OPAC','free'),('OPACFineNoRenewals','100','','Fine limit above which user cannot renew books via OPAC','Integer'),('OPACFinesTab','1','','If OFF the patron fines tab in the OPAC is disabled.','YesNo'),('OPACFRBRizeEditions','0','','If ON, the OPAC will query one or more ISBN web services for associated ISBNs and display an Editions tab on the details pages','YesNo'),('opacheader','','70|10','Add HTML to be included as a custom header in the OPAC','Textarea'),('OpacHiddenItems','','','This syspref allows to define custom rules for hiding specific items at opac. See docs/opac/OpacHiddenItems.txt for more informations.','Textarea'),('OpacHighlightedWords','1','','If Set, then queried words are higlighted in OPAC','YesNo'),('OpacHoldNotes','0','','Show hold notes on OPAC','YesNo'),('OPACItemHolds','1','','Allow OPAC users to place hold on specific items. If OFF, users can only request next available copy.','YesNo'),('OpacItemLocation','callnum','callnum|ccode|location','Show the shelving location of items in the opac','Choice'),('OPACItemsResultsDisplay','0','','If OFF : show only the status of items in result list.If ON : show full location of items (branch+location+callnumber) as in staff interface','YesNo'),('OpacKohaUrl','1',NULL,'Show \'Powered by Koha\' text on OPAC footer.',NULL),('opaclanguages','en',NULL,'Set the default language in the OPAC.','Languages'),('opaclanguagesdisplay','0','','If ON, enables display of Change Language feature on OPAC','YesNo'),('opaclayoutstylesheet','opac.css','','Enter the name of the layout CSS stylesheet to use in the OPAC','free'),('OPACLocalCoverImages','0','1','Display local cover images on OPAC search and details pages.','YesNo'),('OpacMaintenance','0','','If ON, enables maintenance warning in OPAC','YesNo'),('OpacMainUserBlock','Welcome to Koha...\r\n<hr>','70|10','A user-defined block of HTML  in the main content area of the opac main page','Textarea'),('OpacMainUserBlockMobile','',NULL,'Show the following HTML in its own column on the main page of the OPAC (mobile version):','free'),('OpacMaxItemsToDisplay','50','','Max items to display at the OPAC on a biblio detail','Integer'),('OPACMobileUserCSS','',NULL,'Include the following CSS for the mobile view on all pages in the OPAC:','free'),('OPACMySummaryHTML','','70|10','Enter the HTML that will appear in a column on the \'my summary\' and \'my reading history\' tabs when a user is logged in to the OPAC. Enter {BIBLIONUMBER}, {TITLE}, {AUTHOR}, or {ISBN} in place of their respective variables in the HTML. Leave blank to disable.','Textarea'),('OPACMySummaryNote','','','Note to display on the patron summary page. This note only appears if the patron is connected.','Free'),('OpacNav','Important links here.','70|10','Use HTML tags to add navigational links to the left-hand navigational bar in OPAC','Textarea'),('OpacNavBottom','Important links here.','70|10','Use HTML tags to add navigational links to the left-hand navigational bar in OPAC','Textarea'),('OpacNavRight','','70|10','Show the following HTML in the right hand column of the main page under the main login form','Textarea'),('OPACNoResultsFound','','70|10','Display this HTML when no results are found for a search in the OPAC','Textarea'),('OPACNumbersPreferPhrase','0',NULL,'Control the use of phr operator in callnumber and standard number OPAC searches','YesNo'),('OPACnumSearchResults','20',NULL,'Specify the maximum number of results to display on a page of results','Integer'),('OpacPasswordChange','1',NULL,'If ON, enables patron-initiated password change in OPAC (disable it when using LDAP auth)','YesNo'),('OPACPatronDetails','1','','If OFF the patron details tab in the OPAC is disabled.','YesNo'),('OPACpatronimages','0',NULL,'Enable patron images in the OPAC','YesNo'),('OpacPrivacy','0',NULL,'if ON, allows patrons to define their privacy rules (reading history)','YesNo'),('OpacPublic','1',NULL,'Turn on/off public OPAC','YesNo'),('opacreadinghistory','1','','If ON, enables display of Patron Circulation History in OPAC','YesNo'),('OpacRenewalAllowed','0',NULL,'If ON, users can renew their issues directly from their OPAC account','YesNo'),('OpacRenewalBranch','checkoutbranch','itemhomebranch|patronhomebranch|checkoutbranch|null','Choose how the branch for an OPAC renewal is recorded in statistics','Choice'),('OPACResultsSidebar','','70|10','Define HTML to be included on the search results page, underneath the facets sidebar','Textarea'),('OPACSearchForTitleIn','<li><a  href=\"http://worldcat.org/search?q={TITLE}\" target=\"_blank\">Other Libraries (WorldCat)</a></li>\n<li><a href=\"http://www.scholar.google.com/scholar?q={TITLE}\" target=\"_blank\">Other Databases (Google Scholar)</a></li>\n<li><a href=\"http://www.bookfinder.com/search/?author={AUTHOR}&amp;title={TITLE}&amp;st=xl&amp;ac=qr\" target=\"_blank\">Online Stores (Bookfinder.com)</a></li>\n<li><a href=\"http://openlibrary.org/search/?author=({AUTHOR})&title=({TITLE})\" target=\"_blank\">Open Library (openlibrary.org)</a></li>','70|10','Enter the HTML that will appear in the \'Search for this title in\' box on the detail page in the OPAC.  Enter {TITLE}, {AUTHOR}, or {ISBN} in place of their respective variables in the URL. Leave blank to disable \'More Searches\' menu.','Textarea'),('OpacSeparateHoldings','0',NULL,'Separate current branch holdings from other holdings (OPAC)','YesNo'),('OpacSeparateHoldingsBranch','homebranch','homebranch|holdingbranch','Branch used to separate holdings (OPAC)','Choice'),('opacSerialDefaultTab','subscriptions','holdings|serialcollection|subscriptions','Define the default tab for serials in OPAC.','Choice'),('OPACSerialIssueDisplayCount','3','','Number of serial issues to display per subscription in the OPAC','Integer'),('OPACShelfBrowser','1','','Enable/disable Shelf Browser on item details page. WARNING: this feature is very resource consuming on collections with large numbers of items.','YesNo'),('OPACShowBarcode','0','','Show items barcode in holding tab','YesNo'),('OPACShowCheckoutName','0','','Displays in the OPAC the name of patron who has checked out the material. WARNING: Most sites should leave this off. It is intended for corporate or special sites which need to track who has the item.','YesNo'),('OpacShowFiltersPulldownMobile','1',NULL,'Show the search filters pulldown on the mobile version of the OPAC.','YesNo'),('OPACShowHoldQueueDetails','none','none|priority|holds|holds_priority','Show holds details in OPAC','Choice'),('OpacShowLibrariesPulldownMobile','1',NULL,'Show the libraries pulldown on the mobile version of the OPAC.','YesNo'),('OpacShowRecentComments','0',NULL,'If ON a link to recent comments will appear in the OPAC masthead','YesNo'),('OPACShowUnusedAuthorities','1','','Show authorities that are not being used in the OPAC.','YesNo'),('opacsmallimage','','','Enter a complete URL to an image to replace the default Koha logo','free'),('OpacStarRatings','all','disable|all|details',NULL,'Choice'),('OpacSuggestionManagedBy','1','','Show the name of the staff member who managed a suggestion in OPAC','YesNo'),('OpacSuppression','0','','Turn ON the OPAC Suppression feature, requires further setup, ask your system administrator for details','YesNo'),('OpacSuppressionByIPRange','','','Restrict the suppression to IP adresses outside of the IP range','free'),('OpacSuppressionMessage','','Display this message on the redirect page for suppressed biblios','70|10','Textarea'),('OpacSuppressionRedirect','1','Redirect the opac detail page for suppressed records to an explanatory page (otherwise redirect to 404 error page)','','YesNo'),('opacthemes','bootstrap','','Define the current theme for the OPAC interface.','Themes'),('OpacTopissue','0',NULL,'If ON, enables the \'most popular items\' link on OPAC. Warning, this is an EXPERIMENTAL feature, turning ON may overload your server','YesNo'),('OPACURLOpenInNewWindow','0',NULL,'If ON, URLs in the OPAC open in a new window','YesNo'),('OPACUserCSS','',NULL,'Add CSS to be included in the OPAC in an embedded <style> tag.','free'),('opacuserjs','','70|10','Define custom javascript for inclusion in OPAC','Textarea'),('opacuserlogin','1',NULL,'Enable or disable display of user login features','YesNo'),('OPACViewOthersSuggestions','0',NULL,'If ON, allows all suggestions to be displayed in the OPAC','YesNo'),('OPACXSLTDetailsDisplay','default','','Enable XSL stylesheet control over details page display on OPAC','Free'),('OPACXSLTResultsDisplay','default','','Enable XSL stylesheet control over results page display on OPAC','Free'),('OpenLibraryCovers','0',NULL,'If ON Openlibrary book covers will be show','YesNo'),('OrderPdfFormat','pdfformat::layout3pages','Controls what script is used for printing (basketgroups)','','free'),('OverDriveClientKey','','Client key for OverDrive integration','30','Free'),('OverDriveClientSecret','','Client key for OverDrive integration','30','YesNo'),('OverDriveLibraryID','','Library ID for OverDrive integration','','Integer'),('OverdueNoticeBcc','','','Email address to bcc outgoing overdue notices sent by email','free'),('OverduesBlockCirc','noblock','noblock|confirmation|block','When checking out an item should overdues block checkout, generate a confirmation dialogue, or allow checkout','Choice'),('patronimages','0',NULL,'Enable patron images for the Staff Client','YesNo'),('PatronSelfRegistration','0',NULL,'If enabled, patrons will be able to register themselves via the OPAC.','YesNo'),('PatronSelfRegistrationAdditionalInstructions','','','A free text field to display additional instructions to newly self registered patrons.','free'),('PatronSelfRegistrationBorrowerMandatoryField','surname|firstname',NULL,'Choose the mandatory fields for a patron\'s account, when registering via the OPAC.','free'),('PatronSelfRegistrationBorrowerUnwantedField','',NULL,'Name the fields you don\'t want to display when registering a new patron via the OPAC.','free'),('PatronSelfRegistrationDefaultCategory','','','A patron registered via the OPAC will receive a borrower category code set in this system preference.','free'),('PatronSelfRegistrationExpireTemporaryAccountsDelay','0',NULL,'If PatronSelfRegistrationDefaultCategory is enabled, this system preference controls how long a patron can have a temporary status before the account is deleted automatically. It is an integer value representing a number of days to wait before deleting a temporary patron account. Setting it to 0 disables the deleting of temporary accounts.','Integer'),('PatronSelfRegistrationVerifyByEmail','0',NULL,'If enabled, any patron attempting to register themselves via the OPAC will be required to verify themselves via email to activate his or her account.','YesNo'),('PatronsPerPage','20','20','Number of Patrons Per Page displayed by default','Integer'),('Persona','0','','Use Mozilla Persona for login','YesNo'),('PrefillItem','0','','When a new item is added, should it be prefilled with last created item values?','YesNo'),('previousIssuesDefaultSortOrder','asc','asc|desc','Specify the sort order of Previous Issues on the circulation page','Choice'),('printcirculationslips','1','','If ON, enable printing circulation receipts','YesNo'),('PrintNoticesMaxLines','0','','If greater than 0, sets the maximum number of lines an overdue notice will print. If the number of items is greater than this number, the notice will end with a warning asking the borrower to check their online account for a full list of overdue items.','Integer'),('QueryAutoTruncate','1',NULL,'If ON, query truncation is enabled by default','YesNo'),('QueryFuzzy','1',NULL,'If ON, enables fuzzy option for searches','YesNo'),('QueryStemming','1',NULL,'If ON, enables query stemming','YesNo'),('QueryWeightFields','1',NULL,'If ON, enables field weighting','YesNo'),('QuoteOfTheDay','0',NULL,'Enable or disable display of Quote of the Day on the OPAC home page','YesNo'),('RandomizeHoldsQueueWeight','0',NULL,'if ON, the holds queue in circulation will be randomized, either based on all location codes, or by the location codes specified in StaticHoldsQueueWeight','YesNo'),('RecordLocalUseOnReturn','0',NULL,'If ON, statistically record returns of unissued items as local use, instead of return','YesNo'),('RefundLostItemFeeOnReturn','1',NULL,'If enabled, the lost item fee charged to a borrower will be refunded when the lost item is returned.','YesNo'),('RenewalPeriodBase','date_due','date_due|now','Set whether the renewal date should be counted from the date_due or from the moment the Patron asks for renewal ','Choice'),('RenewalSendNotice','0','',NULL,'YesNo'),('RenewSerialAddsSuggestion','0',NULL,'If ON, adds a new suggestion at serial subscription renewal','YesNo'),('RentalsInNoissuesCharge','1',NULL,'Rental charges block checkouts (added to noissuescharge).','YesNo'),('RequestOnOpac','1',NULL,'If ON, globally enables patron holds on OPAC','YesNo'),('ReservesControlBranch','PatronLibrary','ItemHomeLibrary|PatronLibrary','Branch checked for members reservations rights','Choice'),('ReservesMaxPickUpDelay','7','','Define the Maximum delay to pick up an item on hold','Integer'),('ReservesNeedReturns','1','','If ON, a hold placed on an item available in this library must be checked-in, otherwise, a hold on a specific item, that is in the library & available is considered available','YesNo'),('ReturnBeforeExpiry','0',NULL,'If ON, checkout will be prevented if returndate is after patron card expiry','YesNo'),('ReturnLog','1',NULL,'If ON, enables the circulation (returns) log','YesNo'),('ReturnToShelvingCart','0','','If set, when any item is \'checked in\', it\'s location code will be changed to CART.','YesNo'),('reviewson','1','','If ON, enables patron reviews of bibliographic records in the OPAC','YesNo'),('RoutingListAddReserves','1','','If ON the patrons on routing lists are automatically added to holds on the issue.','YesNo'),('RoutingListNote','To change this note edit <a href=\"/cgi-bin/koha/admin/preferences.pl?op=search&searchfield=RoutingListNote#jumped\">RoutlingListNote</a> system preference.','70|10','Define a note to be shown on all routing lists','Textarea'),('RoutingSerials','1',NULL,'If ON, serials routing is enabled','YesNo'),('SCOUserCSS','',NULL,'Add CSS to be included in the SCO module in an embedded <style> tag.','free'),('SCOUserJS','',NULL,'Define custom javascript for inclusion in the SCO module','free'),('SearchEngine','Zebra','Solr|Zebra','Search Engine','Choice'),('SearchMyLibraryFirst','0',NULL,'If ON, OPAC searches return results limited by the user\'s library by default if they are logged in','YesNo'),('SelfCheckHelpMessage','','70|10','Enter HTML to include under the basic Web-based Self Checkout instructions on the Help page','Textarea'),('SelfCheckReceiptPrompt','1','NULL','If ON, print receipt dialog pops up when self checkout is finished','YesNo'),('SelfCheckTimeout','120','','Define the number of seconds before the Web-based Self Checkout times out a patron','Integer'),('SeparateHoldings','0',NULL,'Separate current branch holdings from other holdings','YesNo'),('SeparateHoldingsBranch','homebranch','homebranch|holdingbranch','Branch used to separate holdings','Choice'),('SessionStorage','mysql','mysql|Pg|tmp','Use database or a temporary file for storing session data','Choice'),('ShelfBrowserUsesCcode','1','0','Use the item collection code when finding items for the shelf browser.','YesNo'),('ShelfBrowserUsesHomeBranch','1','1','Use the item home branch when finding items for the shelf browser.','YesNo'),('ShelfBrowserUsesLocation','1','1','Use the item location when finding items for the shelf browser.','YesNo'),('ShowPatronImageInWebBasedSelfCheck','0','','If ON, displays patron image when a patron uses web-based self-checkout','YesNo'),('ShowReviewer','full','none|full|first|surname|firstandinitial|username','Choose how a commenter\'s identity is presented alongside comments in the OPAC','Choice'),('ShowReviewerPhoto','1','','If ON, photo of reviewer will be shown beside comments in OPAC','YesNo'),('singleBranchMode','0',NULL,'Operate in Single-branch mode, hide branch selection in the OPAC','YesNo'),('SlipCSS','',NULL,'Slips CSS url.','free'),('SMSSendDriver','','','Sets which SMS::Send driver is used to send SMS messages.','free'),('SocialNetworks','0','','Enable/Disable social networks links in opac detail pages','YesNo'),('soundon','0','','Enable circulation sounds during checkin and checkout in the staff interface.  Not supported by all web browsers yet.','YesNo'),('SpecifyDueDate','1','','Define whether to display \"Specify Due Date\" form in Circulation','YesNo'),('SpecifyReturnDate','1','','Define whether to display \"Specify Return Date\" form in Circulation','YesNo'),('SpineLabelAutoPrint','0','','If this setting is turned on, a print dialog will automatically pop up for the quick spine label printer.','YesNo'),('SpineLabelFormat','<itemcallnumber><copynumber>','30|10','This preference defines the format for the quick spine label printer. Just list the fields you would like to see in the order you would like to see them, surrounded by <>, for example <itemcallnumber>.','Textarea'),('SpineLabelShowPrintOnBibDetails','0','','If turned on, a \"Print Label\" link will appear for each item on the bib details page in the staff interface.','YesNo'),('StaffAuthorisedValueImages','1',NULL,'','YesNo'),('staffClientBaseURL','',NULL,'Specify the base URL of the staff client','free'),('StaffDetailItemSelection','1',NULL,'Enable item selection in record detail page','YesNo'),('StaffSerialIssueDisplayCount','3','','Number of serial issues to display per subscription in the Staff client','Integer'),('StaticHoldsQueueWeight','0',NULL,'Specify a list of library location codes separated by commas -- the list of codes will be traversed and weighted with first values given higher weight for holds fulfillment -- alternatively, if RandomizeHoldsQueueWeight is set, the list will be randomly selective','Integer'),('SubfieldsToUseWhenPrefill','','','Define a list of subfields to use when prefilling items (separated by space)','Free'),('SubscriptionDuplicateDroppedInput','','','List of fields which must not be rewritten when a subscription is duplicated (Separated by pipe |)','Free'),('SubscriptionHistory','simplified','simplified|full','Define the display preference for serials issue history in OPAC','Choice'),('SubscriptionLog','1',NULL,'If ON, enables subscriptions log','YesNo'),('suggestion','1','','If ON, enables patron suggestions feature in OPAC','YesNo'),('SuspendHoldsIntranet','1','Allow holds to be suspended from the intranet.',NULL,'YesNo'),('SuspendHoldsOpac','1','Allow holds to be suspended from the OPAC.',NULL,'YesNo'),('SvcMaxReportRows','10',NULL,'Maximum number of rows to return via the report web service.','Integer'),('SyndeticsAuthorNotes','0','','Display Notes about the Author on OPAC from Syndetics','YesNo'),('SyndeticsAwards','0','','Display Awards on OPAC from Syndetics','YesNo'),('SyndeticsClientCode','0','','Client Code for using Syndetics Solutions content','free'),('SyndeticsCoverImages','0','','Display Cover Images from Syndetics','YesNo'),('SyndeticsCoverImageSize','MC','MC|LC','Choose the size of the Syndetics Cover Image to display on the OPAC detail page, MC is Medium, LC is Large','Choice'),('SyndeticsEditions','0','','Display Editions from Syndetics','YesNo'),('SyndeticsEnabled','0','','Turn on Syndetics Enhanced Content','YesNo'),('SyndeticsExcerpt','0','','Display Excerpts and first chapters on OPAC from Syndetics','YesNo'),('SyndeticsReviews','0','','Display Reviews on OPAC from Syndetics','YesNo'),('SyndeticsSeries','0','','Display Series information on OPAC from Syndetics','YesNo'),('SyndeticsSummary','0','','Display Summary Information from Syndetics','YesNo'),('SyndeticsTOC','0','','Display Table of Content information from Syndetics','YesNo'),('TagsEnabled','1','','Enables or disables all tagging features.  This is the main switch for tags.','YesNo'),('TagsExternalDictionary',NULL,'','Path on server to local ispell executable, used to set $Lingua::Ispell::path  This dictionary is used as a \"whitelist\" of pre-allowed tags.',''),('TagsInputOnDetail','1','','Allow users to input tags from the detail page.','YesNo'),('TagsInputOnList','0','','Allow users to input tags from the search results list.','YesNo'),('TagsModeration','0','','Require tags from patrons to be approved before becoming visible.','YesNo'),('TagsShowOnDetail','10','','Number of tags to display on detail page.  0 is off.','Integer'),('TagsShowOnList','6','','Number of tags to display on search results list.  0 is off.','Integer'),('template','prog','','Define the preferred staff interface template','Themes'),('ThingISBN','0','','Use with FRBRizeEditions. If ON, Koha will use the ThingISBN web service in the Editions tab on the detail pages.','YesNo'),('TimeFormat','24hr','12hr|24hr','Defines the global time format for visual output.','Choice'),('timeout','12000000',NULL,'Inactivity timeout for cookies authentication (in seconds)','Integer'),('todaysIssuesDefaultSortOrder','desc','asc|desc','Specify the sort order of Todays Issues on the circulation page','Choice'),('TraceCompleteSubfields','0','0','Force subject tracings to only match complete subfields.','YesNo'),('TraceSubjectSubdivisions','0','1','Create searches on all subdivisions for subject tracings.','YesNo'),('TrackClicks','0',NULL,'Track links clicked','Integer'),('TransfersMaxDaysWarning','3',NULL,'Define the days before a transfer is suspected of having a problem','Integer'),('TransferWhenCancelAllWaitingHolds','0',NULL,'Transfer items when cancelling all waiting holds','YesNo'),('UNIMARCAuthorityField100','afrey50      ba0',NULL,'Define the contents of UNIMARC authority control field 100 position 08-35','Textarea'),('UNIMARCAuthorsFacetsSeparator',', ',NULL,'UNIMARC authors facets separator','short'),('UNIMARCField100Language','fre',NULL,'UNIMARC field 100 default language','short'),('UniqueItemFields','barcode','','Space-separated list of fields that should be unique (used in acquisition module for item creation). Fields must be valid SQL column names of items table','Free'),('UpdateTotalIssuesOnCirc','0',NULL,'Whether to update the totalissues field in the biblio on each circ.','YesNo'),('uppercasesurnames','0',NULL,'If ON, surnames are converted to upper case in patron entry form','YesNo'),('URLLinkText','',NULL,'Text to display as the link anchor in the OPAC','free'),('UseAuthoritiesForTracings','1','0','Use authority record numbers for subject tracings instead of heading strings.','YesNo'),('UseBranchTransferLimits','0','','If ON, Koha will will use the rules defined in branch_transfer_limits to decide if an item transfer should be allowed.','YesNo'),('UseControlNumber','0','','If ON, record control number (w subfields) and control number (001) are used for linking of bibliographic records.','YesNo'),('UseCourseReserves','0',NULL,'Enable the course reserves feature.','YesNo'),('useDaysMode','Calendar','Calendar|Days|Datedue','Choose the method for calculating due date: select Calendar to use the holidays module, and Days to ignore the holidays module','Choice'),('UseICU','0','1','Tell Koha if ICU indexing is in use for Zebra or not.','YesNo'),('UseKohaPlugins','0','','Enable or disable the ability to use Koha Plugins.','YesNo'),('UseQueryParser','0',NULL,'If enabled, try to use QueryParser for queries.','YesNo'),('UseTransportCostMatrix','0','','Use Transport Cost Matrix when filling holds','YesNo'),('Version','3.1604000',NULL,'The Koha database version. WARNING: Do not change this value manually, it is maintained by the webinstaller',NULL),('viewISBD','1','','Allow display of ISBD view of bibiographic records','YesNo'),('viewLabeledMARC','0','','Allow display of labeled MARC view of bibiographic records','YesNo'),('viewMARC','1','','Allow display of MARC view of bibiographic records','YesNo'),('virtualshelves','1','','If ON, enables Lists management','YesNo'),('WaitingNotifyAtCheckin','0',NULL,'If ON, notify librarians of waiting holds for the patron whose items they are checking in.','YesNo'),('WebBasedSelfCheck','0',NULL,'If ON, enables the web-based self-check system','YesNo'),('WhenLostChargeReplacementFee','1',NULL,'If ON, Charge the replacement price when a patron loses an item.','YesNo'),('WhenLostForgiveFine','0',NULL,'If ON, Forgives the fines on an item when it is lost.','YesNo'),('XISBN','0','','Use with FRBRizeEditions. If ON, Koha will use the OCLC xISBN web service in the Editions tab on the detail pages. See: http://www.worldcat.org/affiliate/webservices/xisbn/app.jsp','YesNo'),('XISBNDailyLimit','999','','The xISBN Web service is free for non-commercial use when usage does not exceed 1000 requests per day','Integer'),('XSLTDetailsDisplay','default','','Enable XSL stylesheet control over details page display on intranet','Free'),('XSLTResultsDisplay','default','','Enable XSL stylesheet control over results page display on intranet','Free'),('yuipath','local','local|http://yui.yahooapis.com/2.5.1/build','Insert the path to YUI libraries, choose local if you use koha offline','Choice'),('z3950AuthorAuthFields','701,702,700',NULL,'Define the MARC biblio fields for Personal Name Authorities to fill biblio.author','free'),('z3950NormalizeAuthor','0','','If ON, Personal Name Authorities will replace authors in biblio.author','YesNo');
/*!40000 ALTER TABLE `systempreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `entry` varchar(255) NOT NULL DEFAULT '',
  `weight` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_all`
--

DROP TABLE IF EXISTS `tags_all`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags_all` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `biblionumber` int(11) NOT NULL,
  `term` varchar(255) NOT NULL,
  `language` int(4) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `tags_borrowers_fk_1` (`borrowernumber`),
  KEY `tags_biblionumber_fk_1` (`biblionumber`),
  CONSTRAINT `tags_biblionumber_fk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tags_borrowers_fk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_all`
--

LOCK TABLES `tags_all` WRITE;
/*!40000 ALTER TABLE `tags_all` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags_all` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_approval`
--

DROP TABLE IF EXISTS `tags_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags_approval` (
  `term` varchar(255) NOT NULL,
  `approved` int(1) NOT NULL DEFAULT '0',
  `date_approved` datetime DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `weight_total` int(9) NOT NULL DEFAULT '1',
  PRIMARY KEY (`term`),
  KEY `tags_approval_borrowers_fk_1` (`approved_by`),
  CONSTRAINT `tags_approval_borrowers_fk_1` FOREIGN KEY (`approved_by`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_approval`
--

LOCK TABLES `tags_approval` WRITE;
/*!40000 ALTER TABLE `tags_approval` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags_approval` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_index`
--

DROP TABLE IF EXISTS `tags_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags_index` (
  `term` varchar(255) NOT NULL,
  `biblionumber` int(11) NOT NULL,
  `weight` int(9) NOT NULL DEFAULT '1',
  PRIMARY KEY (`term`,`biblionumber`),
  KEY `tags_index_biblionumber_fk_1` (`biblionumber`),
  CONSTRAINT `tags_index_biblionumber_fk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tags_index_term_fk_1` FOREIGN KEY (`term`) REFERENCES `tags_approval` (`term`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_index`
--

LOCK TABLES `tags_index` WRITE;
/*!40000 ALTER TABLE `tags_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tmp_holdsqueue`
--

DROP TABLE IF EXISTS `tmp_holdsqueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_holdsqueue` (
  `biblionumber` int(11) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `barcode` varchar(20) DEFAULT NULL,
  `surname` mediumtext NOT NULL,
  `firstname` text,
  `phone` text,
  `borrowernumber` int(11) NOT NULL,
  `cardnumber` varchar(16) DEFAULT NULL,
  `reservedate` date DEFAULT NULL,
  `title` mediumtext,
  `itemcallnumber` varchar(255) DEFAULT NULL,
  `holdingbranch` varchar(10) DEFAULT NULL,
  `pickbranch` varchar(10) DEFAULT NULL,
  `notes` text,
  `item_level_request` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tmp_holdsqueue`
--

LOCK TABLES `tmp_holdsqueue` WRITE;
/*!40000 ALTER TABLE `tmp_holdsqueue` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_holdsqueue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_cost`
--

DROP TABLE IF EXISTS `transport_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_cost` (
  `frombranch` varchar(10) NOT NULL,
  `tobranch` varchar(10) NOT NULL,
  `cost` decimal(6,2) NOT NULL,
  `disable_transfer` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`frombranch`,`tobranch`),
  KEY `transport_cost_ibfk_2` (`tobranch`),
  CONSTRAINT `transport_cost_ibfk_1` FOREIGN KEY (`frombranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transport_cost_ibfk_2` FOREIGN KEY (`tobranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_cost`
--

LOCK TABLES `transport_cost` WRITE;
/*!40000 ALTER TABLE `transport_cost` DISABLE KEYS */;
/*!40000 ALTER TABLE `transport_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permissions`
--

DROP TABLE IF EXISTS `user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_permissions` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `module_bit` int(11) NOT NULL DEFAULT '0',
  `code` varchar(64) DEFAULT NULL,
  KEY `user_permissions_ibfk_1` (`borrowernumber`),
  KEY `user_permissions_ibfk_2` (`module_bit`,`code`),
  CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_permissions_ibfk_2` FOREIGN KEY (`module_bit`, `code`) REFERENCES `permissions` (`module_bit`, `code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permissions`
--

LOCK TABLES `user_permissions` WRITE;
/*!40000 ALTER TABLE `user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userflags`
--

DROP TABLE IF EXISTS `userflags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userflags` (
  `bit` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(30) DEFAULT NULL,
  `flagdesc` varchar(255) DEFAULT NULL,
  `defaulton` int(11) DEFAULT NULL,
  PRIMARY KEY (`bit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userflags`
--

LOCK TABLES `userflags` WRITE;
/*!40000 ALTER TABLE `userflags` DISABLE KEYS */;
INSERT INTO `userflags` VALUES (0,'superlibrarian','Access to all librarian functions',0),(1,'circulate','Check out and check in items',0),(2,'catalogue','<b>Required for staff login.</b> Staff access, allows viewing of catalogue in staff client.',0),(3,'parameters','Manage Koha system settings (Administration panel)',0),(4,'borrowers','Add or modify patrons',0),(5,'permissions','Set user permissions',0),(6,'reserveforothers','Place and modify holds for patrons',0),(7,'borrow','Borrow books',1),(9,'editcatalogue','Edit catalog (Modify bibliographic/holdings data)',0),(10,'updatecharges','Manage patrons fines and fees',0),(11,'acquisition','Acquisition and/or suggestion management',0),(12,'management','Set library management parameters (deprecated)',0),(13,'tools','Use all tools (expand for granular tools permissions)',0),(14,'editauthorities','Edit authorities',0),(15,'serials','Manage serial subscriptions',0),(16,'reports','Allow access to the reports module',0),(17,'staffaccess','Allow staff members to modify permissions for other staff members',0),(18,'coursereserves','Course reserves',0),(19,'plugins','Koha plugins',0);
/*!40000 ALTER TABLE `userflags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtualshelfcontents`
--

DROP TABLE IF EXISTS `virtualshelfcontents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualshelfcontents` (
  `shelfnumber` int(11) NOT NULL DEFAULT '0',
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) DEFAULT NULL,
  `dateadded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `borrowernumber` int(11) DEFAULT NULL,
  KEY `shelfnumber` (`shelfnumber`),
  KEY `biblionumber` (`biblionumber`),
  KEY `shelfcontents_ibfk_3` (`borrowernumber`),
  CONSTRAINT `shelfcontents_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shelfcontents_ibfk_3` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `virtualshelfcontents_ibfk_1` FOREIGN KEY (`shelfnumber`) REFERENCES `virtualshelves` (`shelfnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualshelfcontents`
--

LOCK TABLES `virtualshelfcontents` WRITE;
/*!40000 ALTER TABLE `virtualshelfcontents` DISABLE KEYS */;
/*!40000 ALTER TABLE `virtualshelfcontents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtualshelfshares`
--

DROP TABLE IF EXISTS `virtualshelfshares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualshelfshares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shelfnumber` int(11) NOT NULL,
  `borrowernumber` int(11) DEFAULT NULL,
  `invitekey` varchar(10) DEFAULT NULL,
  `sharedate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `virtualshelfshares_ibfk_1` (`shelfnumber`),
  KEY `virtualshelfshares_ibfk_2` (`borrowernumber`),
  CONSTRAINT `virtualshelfshares_ibfk_1` FOREIGN KEY (`shelfnumber`) REFERENCES `virtualshelves` (`shelfnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `virtualshelfshares_ibfk_2` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualshelfshares`
--

LOCK TABLES `virtualshelfshares` WRITE;
/*!40000 ALTER TABLE `virtualshelfshares` DISABLE KEYS */;
/*!40000 ALTER TABLE `virtualshelfshares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtualshelves`
--

DROP TABLE IF EXISTS `virtualshelves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualshelves` (
  `shelfnumber` int(11) NOT NULL AUTO_INCREMENT,
  `shelfname` varchar(255) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `category` varchar(1) DEFAULT NULL,
  `sortfield` varchar(16) DEFAULT NULL,
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `allow_add` tinyint(1) DEFAULT '0',
  `allow_delete_own` tinyint(1) DEFAULT '1',
  `allow_delete_other` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`shelfnumber`),
  KEY `virtualshelves_ibfk_1` (`owner`),
  CONSTRAINT `virtualshelves_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualshelves`
--

LOCK TABLES `virtualshelves` WRITE;
/*!40000 ALTER TABLE `virtualshelves` DISABLE KEYS */;
/*!40000 ALTER TABLE `virtualshelves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `z3950servers`
--

DROP TABLE IF EXISTS `z3950servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `z3950servers` (
  `host` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `db` varchar(255) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` mediumtext,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checked` smallint(6) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `syntax` varchar(80) DEFAULT NULL,
  `timeout` int(11) NOT NULL DEFAULT '0',
  `icon` text,
  `position` enum('primary','secondary','') NOT NULL DEFAULT 'primary',
  `type` enum('zed','opensearch') NOT NULL DEFAULT 'zed',
  `encoding` text,
  `description` text NOT NULL,
  `recordtype` varchar(45) NOT NULL DEFAULT 'biblio',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `z3950servers`
--

LOCK TABLES `z3950servers` WRITE;
/*!40000 ALTER TABLE `z3950servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `z3950servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zebraqueue`
--

DROP TABLE IF EXISTS `zebraqueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zebraqueue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `biblio_auth_number` bigint(20) unsigned NOT NULL DEFAULT '0',
  `operation` char(20) NOT NULL DEFAULT '',
  `server` char(20) NOT NULL DEFAULT '',
  `done` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `zebraqueue_lookup` (`server`,`biblio_auth_number`,`operation`,`done`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zebraqueue`
--

LOCK TABLES `zebraqueue` WRITE;
/*!40000 ALTER TABLE `zebraqueue` DISABLE KEYS */;
/*!40000 ALTER TABLE `zebraqueue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-07 12:46:05

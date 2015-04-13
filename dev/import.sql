
-- Adminer 4.2.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `accountlines`;
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


DROP TABLE IF EXISTS `accountoffsets`;
CREATE TABLE `accountoffsets` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `accountno` smallint(6) NOT NULL DEFAULT '0',
  `offsetaccount` smallint(6) NOT NULL DEFAULT '0',
  `offsetamount` decimal(28,6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `accountoffsets_ibfk_1` (`borrowernumber`),
  CONSTRAINT `accountoffsets_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `action_logs`;
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


DROP TABLE IF EXISTS `alert`;
CREATE TABLE `alert` (
  `alertid` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `type` varchar(10) NOT NULL DEFAULT '',
  `externalid` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`alertid`),
  KEY `borrowernumber` (`borrowernumber`),
  KEY `type` (`type`,`externalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `aqbasket`;
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


DROP TABLE IF EXISTS `aqbasketgroups`;
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


DROP TABLE IF EXISTS `aqbasketusers`;
CREATE TABLE `aqbasketusers` (
  `basketno` int(11) NOT NULL,
  `borrowernumber` int(11) NOT NULL,
  PRIMARY KEY (`basketno`,`borrowernumber`),
  KEY `aqbasketusers_ibfk_2` (`borrowernumber`),
  CONSTRAINT `aqbasketusers_ibfk_1` FOREIGN KEY (`basketno`) REFERENCES `aqbasket` (`basketno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbasketusers_ibfk_2` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `aqbooksellers`;
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
  `postal` mediumtext,
  `url` varchar(255) DEFAULT NULL,
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


DROP TABLE IF EXISTS `aqbudgetborrowers`;
CREATE TABLE `aqbudgetborrowers` (
  `budget_id` int(11) NOT NULL,
  `borrowernumber` int(11) NOT NULL,
  PRIMARY KEY (`budget_id`,`borrowernumber`),
  KEY `aqbudgetborrowers_ibfk_2` (`borrowernumber`),
  CONSTRAINT `aqbudgetborrowers_ibfk_1` FOREIGN KEY (`budget_id`) REFERENCES `aqbudgets` (`budget_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbudgetborrowers_ibfk_2` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `aqbudgetperiods`;
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


DROP TABLE IF EXISTS `aqbudgets`;
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


DROP TABLE IF EXISTS `aqbudgets_planning`;
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


DROP TABLE IF EXISTS `aqcontacts`;
CREATE TABLE `aqcontacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `altphone` varchar(100) DEFAULT NULL,
  `fax` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `notes` mediumtext,
  `claimacquisition` tinyint(1) NOT NULL DEFAULT '0',
  `claimissues` tinyint(1) NOT NULL DEFAULT '0',
  `acqprimary` tinyint(1) NOT NULL DEFAULT '0',
  `serialsprimary` tinyint(1) NOT NULL DEFAULT '0',
  `booksellerid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `booksellerid_aqcontacts_fk` (`booksellerid`),
  CONSTRAINT `booksellerid_aqcontacts_fk` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `aqcontract`;
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


DROP TABLE IF EXISTS `aqinvoices`;
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


DROP TABLE IF EXISTS `aqorders`;
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
  `datecancellationprinted` date DEFAULT NULL,
  `cancellationreason` text,
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


DROP TABLE IF EXISTS `aqorders_items`;
CREATE TABLE `aqorders_items` (
  `ordernumber` int(11) NOT NULL,
  `itemnumber` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`itemnumber`),
  KEY `ordernumber` (`ordernumber`),
  CONSTRAINT `aqorders_items_ibfk_1` FOREIGN KEY (`ordernumber`) REFERENCES `aqorders` (`ordernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `aqorders_transfers`;
CREATE TABLE `aqorders_transfers` (
  `ordernumber_from` int(11) DEFAULT NULL,
  `ordernumber_to` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `ordernumber_from` (`ordernumber_from`),
  UNIQUE KEY `ordernumber_to` (`ordernumber_to`),
  CONSTRAINT `aqorders_transfers_ordernumber_from` FOREIGN KEY (`ordernumber_from`) REFERENCES `aqorders` (`ordernumber`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `aqorders_transfers_ordernumber_to` FOREIGN KEY (`ordernumber_to`) REFERENCES `aqorders` (`ordernumber`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `authorised_values`;
CREATE TABLE `authorised_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(32) NOT NULL DEFAULT '',
  `authorised_value` varchar(80) NOT NULL DEFAULT '',
  `lib` varchar(200) DEFAULT NULL,
  `lib_opac` varchar(200) DEFAULT NULL,
  `imageurl` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`category`),
  KEY `lib` (`lib`),
  KEY `auth_value_idx` (`authorised_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `authorised_values_branches`;
CREATE TABLE `authorised_values_branches` (
  `av_id` int(11) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  KEY `av_id` (`av_id`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `authorised_values_branches_ibfk_1` FOREIGN KEY (`av_id`) REFERENCES `authorised_values` (`id`) ON DELETE CASCADE,
  CONSTRAINT `authorised_values_branches_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `auth_header`;
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


DROP TABLE IF EXISTS `auth_subfield_structure`;
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


DROP TABLE IF EXISTS `auth_tag_structure`;
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


DROP TABLE IF EXISTS `auth_types`;
CREATE TABLE `auth_types` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `authtypetext` varchar(255) NOT NULL DEFAULT '',
  `auth_tag_to_report` varchar(3) NOT NULL DEFAULT '',
  `summary` mediumtext NOT NULL,
  PRIMARY KEY (`authtypecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `biblio`;
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


DROP TABLE IF EXISTS `biblioimages`;
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


DROP TABLE IF EXISTS `biblioitems`;
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
  `cn_sort` varchar(255) DEFAULT NULL,
  `agerestriction` varchar(255) DEFAULT NULL,
  `totalissues` int(10) DEFAULT NULL,
  `marcxml` longtext,
  PRIMARY KEY (`biblioitemnumber`),
  KEY `bibinoidx` (`biblioitemnumber`),
  KEY `bibnoidx` (`biblionumber`),
  KEY `itemtype_idx` (`itemtype`),
  KEY `isbn` (`isbn`(255)),
  KEY `issn` (`issn`(255)),
  KEY `publishercode` (`publishercode`),
  CONSTRAINT `biblioitems_ibfk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `biblio_framework`;
CREATE TABLE `biblio_framework` (
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `frameworktext` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`frameworkcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `borrowers`;
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
  UNIQUE KEY `userid` (`userid`),
  KEY `categorycode` (`categorycode`),
  KEY `branchcode` (`branchcode`),
  KEY `guarantorid` (`guarantorid`),
  KEY `surname_idx` (`surname`(255)),
  KEY `firstname_idx` (`firstname`(255)),
  KEY `othernames_idx` (`othernames`(255)),
  CONSTRAINT `borrowers_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`),
  CONSTRAINT `borrowers_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `borrower_attributes`;
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


DROP TABLE IF EXISTS `borrower_attribute_types`;
CREATE TABLE `borrower_attribute_types` (
  `code` varchar(10) NOT NULL,
  `description` varchar(255) NOT NULL,
  `repeatable` tinyint(1) NOT NULL DEFAULT '0',
  `unique_id` tinyint(1) NOT NULL DEFAULT '0',
  `opac_display` tinyint(1) NOT NULL DEFAULT '0',
  `password_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `staff_searchable` tinyint(1) NOT NULL DEFAULT '0',
  `authorised_value_category` varchar(32) DEFAULT NULL,
  `display_checkout` tinyint(1) NOT NULL DEFAULT '0',
  `category_code` varchar(10) DEFAULT NULL,
  `class` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`code`),
  KEY `auth_val_cat_idx` (`authorised_value_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `borrower_attribute_types_branches`;
CREATE TABLE `borrower_attribute_types_branches` (
  `bat_code` varchar(10) DEFAULT NULL,
  `b_branchcode` varchar(10) DEFAULT NULL,
  KEY `bat_code` (`bat_code`),
  KEY `b_branchcode` (`b_branchcode`),
  CONSTRAINT `borrower_attribute_types_branches_ibfk_1` FOREIGN KEY (`bat_code`) REFERENCES `borrower_attribute_types` (`code`) ON DELETE CASCADE,
  CONSTRAINT `borrower_attribute_types_branches_ibfk_2` FOREIGN KEY (`b_branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `borrower_debarments`;
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


DROP TABLE IF EXISTS `borrower_files`;
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


DROP TABLE IF EXISTS `borrower_message_preferences`;
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


DROP TABLE IF EXISTS `borrower_message_transport_preferences`;
CREATE TABLE `borrower_message_transport_preferences` (
  `borrower_message_preference_id` int(11) NOT NULL DEFAULT '0',
  `message_transport_type` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`borrower_message_preference_id`,`message_transport_type`),
  KEY `message_transport_type` (`message_transport_type`),
  CONSTRAINT `borrower_message_transport_preferences_ibfk_1` FOREIGN KEY (`borrower_message_preference_id`) REFERENCES `borrower_message_preferences` (`borrower_message_preference_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_transport_preferences_ibfk_2` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `borrower_modifications`;
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


DROP TABLE IF EXISTS `borrower_sync`;
CREATE TABLE `borrower_sync` (
  `borrowersyncid` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `synctype` varchar(32) NOT NULL,
  `sync` tinyint(1) NOT NULL DEFAULT '0',
  `syncstatus` varchar(10) DEFAULT NULL,
  `lastsync` varchar(50) DEFAULT NULL,
  `hashed_pin` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`borrowersyncid`),
  KEY `borrowernumber` (`borrowernumber`),
  CONSTRAINT `borrower_sync_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `branchcategories`;
CREATE TABLE `branchcategories` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `categoryname` varchar(32) DEFAULT NULL,
  `codedescription` mediumtext,
  `categorytype` varchar(16) DEFAULT NULL,
  `show_in_pulldown` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`categorycode`),
  KEY `show_in_pulldown` (`show_in_pulldown`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `branches`;
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
  `branchreplyto` mediumtext,
  `branchreturnpath` mediumtext,
  `branchurl` mediumtext,
  `issuing` tinyint(4) DEFAULT NULL,
  `branchip` varchar(15) DEFAULT NULL,
  `branchprinter` varchar(100) DEFAULT NULL,
  `branchnotes` mediumtext,
  `opac_info` text,
  PRIMARY KEY (`branchcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `branchrelations`;
CREATE TABLE `branchrelations` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`branchcode`,`categorycode`),
  KEY `branchcode` (`branchcode`),
  KEY `categorycode` (`categorycode`),
  CONSTRAINT `branchrelations_ibfk_1` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchrelations_ibfk_2` FOREIGN KEY (`categorycode`) REFERENCES `branchcategories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `branchtransfers`;
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


DROP TABLE IF EXISTS `branch_borrower_circ_rules`;
CREATE TABLE `branch_borrower_circ_rules` (
  `branchcode` varchar(10) NOT NULL,
  `categorycode` varchar(10) NOT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  PRIMARY KEY (`categorycode`,`branchcode`),
  KEY `branch_borrower_circ_rules_ibfk_2` (`branchcode`),
  CONSTRAINT `branch_borrower_circ_rules_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branch_borrower_circ_rules_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `branch_item_rules`;
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


DROP TABLE IF EXISTS `branch_transfer_limits`;
CREATE TABLE `branch_transfer_limits` (
  `limitId` int(8) NOT NULL AUTO_INCREMENT,
  `toBranch` varchar(10) NOT NULL,
  `fromBranch` varchar(10) NOT NULL,
  `itemtype` varchar(10) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`limitId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `browser`;
CREATE TABLE `browser` (
  `level` int(11) NOT NULL,
  `classification` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `number` bigint(20) NOT NULL,
  `endnode` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `categories`;
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
  `default_privacy` enum('default','never','forever') NOT NULL DEFAULT 'default',
  PRIMARY KEY (`categorycode`),
  UNIQUE KEY `categorycode` (`categorycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `categories_branches`;
CREATE TABLE `categories_branches` (
  `categorycode` varchar(10) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  KEY `categorycode` (`categorycode`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `categories_branches_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE,
  CONSTRAINT `categories_branches_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `cityid` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(100) NOT NULL DEFAULT '',
  `city_state` varchar(100) DEFAULT NULL,
  `city_country` varchar(100) DEFAULT NULL,
  `city_zipcode` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `class_sort_rules`;
CREATE TABLE `class_sort_rules` (
  `class_sort_rule` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `sort_routine` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`class_sort_rule`),
  UNIQUE KEY `class_sort_rule_idx` (`class_sort_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `class_sources`;
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


DROP TABLE IF EXISTS `collections`;
CREATE TABLE `collections` (
  `colId` int(11) NOT NULL AUTO_INCREMENT,
  `colTitle` varchar(100) NOT NULL DEFAULT '',
  `colDesc` text NOT NULL,
  `colBranchcode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`colId`),
  KEY `collections_ibfk_1` (`colBranchcode`),
  CONSTRAINT `collections_ibfk_1` FOREIGN KEY (`colBranchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `collections_tracking`;
CREATE TABLE `collections_tracking` (
  `collections_tracking_id` int(11) NOT NULL AUTO_INCREMENT,
  `colId` int(11) NOT NULL DEFAULT '0' COMMENT 'collections.colId',
  `itemnumber` int(11) NOT NULL DEFAULT '0' COMMENT 'items.itemnumber',
  PRIMARY KEY (`collections_tracking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `columns_settings`;
CREATE TABLE `columns_settings` (
  `module` varchar(255) NOT NULL,
  `page` varchar(255) NOT NULL,
  `tablename` varchar(255) NOT NULL,
  `columnname` varchar(255) NOT NULL,
  `cannot_be_toggled` int(1) NOT NULL DEFAULT '0',
  `is_hidden` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`module`,`page`,`tablename`,`columnname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `courses`;
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


DROP TABLE IF EXISTS `course_instructors`;
CREATE TABLE `course_instructors` (
  `course_id` int(11) NOT NULL,
  `borrowernumber` int(11) NOT NULL,
  PRIMARY KEY (`course_id`,`borrowernumber`),
  KEY `borrowernumber` (`borrowernumber`),
  CONSTRAINT `course_instructors_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_instructors_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `course_items`;
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


DROP TABLE IF EXISTS `course_reserves`;
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


DROP TABLE IF EXISTS `creator_batches`;
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


DROP TABLE IF EXISTS `creator_images`;
CREATE TABLE `creator_images` (
  `image_id` int(4) NOT NULL AUTO_INCREMENT,
  `imagefile` mediumblob,
  `image_name` char(20) NOT NULL DEFAULT 'DEFAULT',
  PRIMARY KEY (`image_id`),
  UNIQUE KEY `image_name_index` (`image_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `creator_layouts`;
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


DROP TABLE IF EXISTS `creator_templates`;
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


DROP TABLE IF EXISTS `currency`;
CREATE TABLE `currency` (
  `currency` varchar(10) NOT NULL DEFAULT '',
  `symbol` varchar(5) DEFAULT NULL,
  `isocode` varchar(5) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rate` float(15,5) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `default_borrower_circ_rules`;
CREATE TABLE `default_borrower_circ_rules` (
  `categorycode` varchar(10) NOT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  PRIMARY KEY (`categorycode`),
  CONSTRAINT `borrower_borrower_circ_rules_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `default_branch_circ_rules`;
CREATE TABLE `default_branch_circ_rules` (
  `branchcode` varchar(10) NOT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  `holdallowed` tinyint(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`branchcode`),
  CONSTRAINT `default_branch_circ_rules_ibfk_1` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `default_branch_item_rules`;
CREATE TABLE `default_branch_item_rules` (
  `itemtype` varchar(10) NOT NULL,
  `holdallowed` tinyint(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`itemtype`),
  CONSTRAINT `default_branch_item_rules_ibfk_1` FOREIGN KEY (`itemtype`) REFERENCES `itemtypes` (`itemtype`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `default_circ_rules`;
CREATE TABLE `default_circ_rules` (
  `singleton` enum('singleton') NOT NULL DEFAULT 'singleton',
  `maxissueqty` int(4) DEFAULT NULL,
  `holdallowed` int(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`singleton`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `deletedbiblio`;
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


DROP TABLE IF EXISTS `deletedbiblioitems`;
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
  `cn_sort` varchar(255) DEFAULT NULL,
  `agerestriction` varchar(255) DEFAULT NULL,
  `totalissues` int(10) DEFAULT NULL,
  `marcxml` longtext,
  PRIMARY KEY (`biblioitemnumber`),
  KEY `bibinoidx` (`biblioitemnumber`),
  KEY `bibnoidx` (`biblionumber`),
  KEY `itemtype_idx` (`itemtype`),
  KEY `isbn` (`isbn`(255)),
  KEY `publishercode` (`publishercode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `deletedborrowers`;
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


DROP TABLE IF EXISTS `deleteditems`;
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
  `cn_sort` varchar(255) DEFAULT NULL,
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


DROP TABLE IF EXISTS `ethnicity`;
CREATE TABLE `ethnicity` (
  `code` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `export_format`;
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


DROP TABLE IF EXISTS `fieldmapping`;
CREATE TABLE `fieldmapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(255) NOT NULL,
  `frameworkcode` char(4) NOT NULL DEFAULT '',
  `fieldcode` char(3) NOT NULL,
  `subfieldcode` char(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `hold_fill_targets`;
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


DROP TABLE IF EXISTS `import_auths`;
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


DROP TABLE IF EXISTS `import_batches`;
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


DROP TABLE IF EXISTS `import_biblios`;
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


DROP TABLE IF EXISTS `import_items`;
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


DROP TABLE IF EXISTS `import_records`;
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


DROP TABLE IF EXISTS `import_record_matches`;
CREATE TABLE `import_record_matches` (
  `import_record_id` int(11) NOT NULL,
  `candidate_match_id` int(11) NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  KEY `record_score` (`import_record_id`,`score`),
  CONSTRAINT `import_record_matches_ibfk_1` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `issues`;
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
  `auto_renew` tinyint(1) DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `issuedate` datetime DEFAULT NULL,
  `onsite_checkout` int(1) NOT NULL DEFAULT '0',
  KEY `issuesborridx` (`borrowernumber`),
  KEY `itemnumber_idx` (`itemnumber`),
  KEY `branchcode_idx` (`branchcode`),
  KEY `issuingbranch_idx` (`issuingbranch`),
  KEY `bordate` (`borrowernumber`,`timestamp`),
  CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON UPDATE CASCADE,
  CONSTRAINT `issues_ibfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `issuingrules`;
CREATE TABLE `issuingrules` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `itemtype` varchar(10) NOT NULL DEFAULT '',
  `restrictedtype` tinyint(1) DEFAULT NULL,
  `rentaldiscount` decimal(28,6) DEFAULT NULL,
  `reservecharge` decimal(28,6) DEFAULT NULL,
  `fine` decimal(28,6) DEFAULT NULL,
  `finedays` int(11) DEFAULT NULL,
  `maxsuspensiondays` int(11) DEFAULT NULL,
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
  `auto_renew` tinyint(1) DEFAULT '0',
  `reservesallowed` smallint(6) NOT NULL DEFAULT '0',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `overduefinescap` decimal(28,6) DEFAULT NULL,
  PRIMARY KEY (`branchcode`,`categorycode`,`itemtype`),
  KEY `categorycode` (`categorycode`),
  KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `items`;
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
  `cn_sort` varchar(255) DEFAULT NULL,
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


DROP TABLE IF EXISTS `items_search_fields`;
CREATE TABLE `items_search_fields` (
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `tagfield` char(3) NOT NULL,
  `tagsubfield` char(1) DEFAULT NULL,
  `authorised_values_category` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `items_search_fields_authorised_values_category` (`authorised_values_category`),
  CONSTRAINT `items_search_fields_authorised_values_category` FOREIGN KEY (`authorised_values_category`) REFERENCES `authorised_values` (`category`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `itemtypes`;
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


DROP TABLE IF EXISTS `item_circulation_alert_preferences`;
CREATE TABLE `item_circulation_alert_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branchcode` varchar(10) NOT NULL,
  `categorycode` varchar(10) NOT NULL,
  `item_type` varchar(10) NOT NULL,
  `notification` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branchcode` (`branchcode`,`categorycode`,`item_type`,`notification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `language_descriptions`;
CREATE TABLE `language_descriptions` (
  `subtag` varchar(25) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `lang` varchar(25) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`),
  KEY `subtag_type_lang` (`subtag`,`type`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `language_descriptions` (`subtag`, `type`, `lang`, `description`, `id`) VALUES
('opac',	'i',	'en',	'OPAC',	1),
('opac',	'i',	'fr',	'OPAC',	2),
('opac',	'i',	'de',	'OPAC',	3),
('intranet',	'i',	'en',	'Staff Client',	4),
('intranet',	'i',	'fr',	'Client personnel',	5),
('intranet',	'i',	'de',	'Dienstoberfläche',	6),
('prog',	't',	'en',	'Prog',	7),
('prog',	't',	'fr',	'Prog',	8),
('prog',	't',	'de',	'Prog',	9),
('am',	'language',	'am',	'አማርኛ',	10),
('am',	'language',	'en',	'Amharic',	11),
('ar',	'language',	'ar',	'لعربية',	12),
('ar',	'language',	'en',	'Arabic',	13),
('ar',	'language',	'fr',	'Arabe',	14),
('ar',	'language',	'de',	'Arabisch',	15),
('az',	'language',	'az',	'Azərbaycan dili',	16),
('az',	'language',	'en',	'Azerbaijani',	17),
('be',	'language',	'be',	'Беларуская мова',	18),
('be',	'language',	'en',	'Byelorussian',	19),
('bn',	'language',	'bn',	'বাংলা',	20),
('bn',	'language',	'en',	'Bengali',	21),
('bg',	'language',	'bg',	'Български',	22),
('bg',	'language',	'en',	'Bulgarian',	23),
('bg',	'language',	'fr',	'Bulgare',	24),
('bg',	'language',	'de',	'Bulgarisch',	25),
('ca',	'language',	'es',	'Catalán',	26),
('ca',	'language',	'en',	'Catalan',	27),
('ca',	'language',	'fr',	'Catalan',	28),
('ca',	'language',	'ca',	'Català',	29),
('ca',	'language',	'de',	'Katalanisch',	30),
('cs',	'language',	'cs',	'Ceština',	31),
('cs',	'language',	'en',	'Czech',	32),
('cs',	'language',	'fr',	'Tchèque',	33),
('cs',	'language',	'de',	'Tschechisch',	34),
('da',	'language',	'da',	'Dansk',	35),
('da',	'language',	'en',	'Danish',	36),
('da',	'language',	'fr',	'Danois',	37),
('da',	'language',	'de',	'Dänisch',	38),
('de',	'language',	'de',	'Deutsch',	39),
('de',	'language',	'en',	'German',	40),
('de',	'language',	'fr',	'Allemand',	41),
('el',	'language',	'el',	'Eλληνικά',	42),
('el',	'language',	'en',	'Greek, Modern [1453- ]',	43),
('el',	'language',	'fr',	'Grec Moderne (Après 1453)',	44),
('el',	'language',	'de',	'Griechisch (Moern [1453- ]',	45),
('en',	'language',	'en',	'English',	46),
('en',	'language',	'fr',	'Anglais',	47),
('en',	'language',	'de',	'Englisch',	48),
('es',	'language',	'es',	'Español',	49),
('es',	'language',	'en',	'Spanish',	50),
('es',	'language',	'fr',	'Espagnol',	51),
('es',	'language',	'de',	'Spanisch',	52),
('eu',	'language',	'eu',	'Euskera',	53),
('eu',	'language',	'en',	'Basque',	54),
('fa',	'language',	'fa',	'فارسى',	55),
('fa',	'language',	'en',	'Persian',	56),
('fa',	'language',	'fr',	'Persan',	57),
('fa',	'language',	'de',	'Persisch',	58),
('fi',	'language',	'fi',	'Suomi',	59),
('fi',	'language',	'en',	'Finnish',	60),
('fi',	'language',	'de',	'Finnisch',	61),
('fo',	'language',	'fo',	'Føroyskt',	62),
('fo',	'language',	'en',	'Faroese',	63),
('fr',	'language',	'en',	'French',	64),
('fr',	'language',	'fr',	'Français',	65),
('fr',	'language',	'de',	'Französisch',	66),
('gl',	'language',	'gl',	'Galego',	67),
('gl',	'language',	'en',	'Galician',	68),
('gl',	'language',	'fr',	'Galicien',	69),
('gl',	'language',	'de',	'Galicisch',	70),
('he',	'language',	'he',	'עִבְרִית',	71),
('he',	'language',	'en',	'Hebrew',	72),
('he',	'language',	'fr',	'Hébreu',	73),
('he',	'language',	'de',	'Hebräisch',	74),
('hi',	'language',	'hi',	'हिन्दी',	75),
('hi',	'language',	'en',	'Hindi',	76),
('hi',	'language',	'fr',	'Hindi',	77),
('hi',	'language',	'de',	'Hindi',	78),
('hr',	'language',	'hr',	'Hrvatski',	79),
('hr',	'language',	'en',	'Croatian',	80),
('hr',	'language',	'fr',	'Croate',	81),
('hr',	'language',	'de',	'Kroatisch',	82),
('hu',	'language',	'hu',	'Magyar',	83),
('hu',	'language',	'en',	'Hungarian',	84),
('hu',	'language',	'fr',	'Hongrois',	85),
('hu',	'language',	'de',	'Ungarisch',	86),
('hy',	'language',	'hy',	'Հայերեն',	87),
('hy',	'language',	'en',	'Armenian',	88),
('hy',	'language',	'fr',	'Armenian',	89),
('hy',	'language',	'de',	'Armenisch',	90),
('id',	'language',	'id',	'Bahasa Indonesia',	91),
('id',	'language',	'en',	'Indonesian',	92),
('id',	'language',	'fr',	'Indonésien',	93),
('id',	'language',	'de',	'Indonesisch',	94),
('is',	'language',	'is',	'Íslenska',	95),
('is',	'language',	'en',	'Icelandic',	96),
('it',	'language',	'it',	'Italiano',	97),
('it',	'language',	'en',	'Italian',	98),
('it',	'language',	'fr',	'Italien',	99),
('it',	'language',	'de',	'Italienisch',	100),
('ja',	'language',	'ja',	'日本語',	101),
('ja',	'language',	'en',	'Japanese',	102),
('ja',	'language',	'fr',	'Japonais',	103),
('ja',	'language',	'de',	'Japanisch',	104),
('ka',	'language',	'ka',	'ಕನ್ನಡ',	105),
('ka',	'language',	'en',	'Kannada',	106),
('km',	'language',	'km',	'ភាសាខ្មែរ',	107),
('km',	'language',	'en',	'Khmer',	108),
('ko',	'language',	'ko',	'한국어',	109),
('ko',	'language',	'en',	'Korean',	110),
('ko',	'language',	'fr',	'Coréen',	111),
('ko',	'language',	'de',	'Koreanisch',	112),
('ku',	'language',	'ku',	'کوردی',	113),
('ku',	'language',	'en',	'Kurdish',	114),
('ku',	'language',	'fr',	'Kurde',	115),
('ku',	'language',	'de',	'Kurdisch',	116),
('ku',	'language',	'es',	'Kurdo',	117),
('la',	'language',	'la',	'Latina',	118),
('la',	'language',	'en',	'Latin',	119),
('la',	'language',	'fr',	'Latin',	120),
('la',	'language',	'de',	'Latein',	121),
('lo',	'language',	'lo',	'ພາສາລາວ',	122),
('lo',	'language',	'en',	'Lao',	123),
('lo',	'language',	'fr',	'Laotien',	124),
('lo',	'language',	'de',	'Laotisch',	125),
('mi',	'language',	'mi',	'Te Reo Māori',	126),
('mi',	'language',	'en',	'Maori',	127),
('mn',	'language',	'mn',	'Mонгол',	128),
('mn',	'language',	'en',	'Mongolian',	129),
('mr',	'language',	'mr',	'मराठी',	130),
('mr',	'language',	'en',	'Marathi',	131),
('ms',	'language',	'ms',	'Bahasa melayu',	132),
('ms',	'language',	'en',	'Malay',	133),
('nb',	'language',	'nb',	'Norsk bokmål',	134),
('nb',	'language',	'en',	'Norwegian bokmål',	135),
('nb',	'language',	'fr',	'Norvégien bokmål',	136),
('nb',	'language',	'de',	'Norwegisch bokmål',	137),
('ne',	'language',	'ne',	'नेपाली',	138),
('ne',	'language',	'en',	'Nepali',	139),
('nl',	'language',	'nl',	'Nederlands',	140),
('nl',	'language',	'en',	'Dutch',	141),
('nl',	'language',	'fr',	'Néerlandais',	142),
('nl',	'language',	'de',	'Niederländisch',	143),
('nn',	'language',	'nb',	'Norsk nynorsk',	144),
('nn',	'language',	'nn',	'Norsk nynorsk',	145),
('nn',	'language',	'en',	'Norwegian nynorsk',	146),
('nn',	'language',	'fr',	'Norvégien nynorsk',	147),
('nn',	'language',	'de',	'Norwegisch nynorsk',	148),
('pbr',	'language',	'pbr',	'Ekipangwa',	149),
('pbr',	'language',	'en',	'Pangwa',	150),
('pl',	'language',	'pl',	'Polski',	151),
('pl',	'language',	'en',	'Polish',	152),
('pl',	'language',	'fr',	'Polonais',	153),
('pl',	'language',	'de',	'Polnisch',	154),
('prs',	'language',	'prs',	'درى',	155),
('prs',	'language',	'en',	'Dari',	156),
('pt',	'language',	'pt',	'Português',	157),
('pt',	'language',	'en',	'Portuguese',	158),
('pt',	'language',	'fr',	'Portugais',	159),
('pt',	'language',	'de',	'Portugiesisch',	160),
('ro',	'language',	'ro',	'Român',	161),
('ro',	'language',	'en',	'Romanian',	162),
('ro',	'language',	'fr',	'Roumain',	163),
('ro',	'language',	'de',	'Rumänisch',	164),
('ru',	'language',	'ru',	'Русский',	165),
('ru',	'language',	'en',	'Russian',	166),
('ru',	'language',	'fr',	'Russe',	167),
('ru',	'language',	'de',	'Russisch',	168),
('rw',	'language',	'rw',	'Ikinyarwanda',	169),
('rw',	'language',	'en',	'Kinyarwanda',	170),
('sd',	'language',	'sd',	'سنڌي',	171),
('sd',	'language',	'en',	'Sindhi',	172),
('sk',	'language',	'sk',	'Slovenčina',	173),
('sk',	'language',	'en',	'Slovak',	174),
('sl',	'language',	'sl',	'Slovenščina',	175),
('sl',	'language',	'en',	'Slovene',	176),
('sq',	'language',	'sq',	'Shqip',	177),
('sq',	'language',	'en',	'Albanian',	178),
('sr',	'language',	'sr',	'Cрпски',	179),
('sr',	'language',	'en',	'Serbian',	180),
('sr',	'language',	'fr',	'Serbe',	181),
('sr',	'language',	'de',	'Serbisch',	182),
('sv',	'language',	'sv',	'Svenska',	183),
('sv',	'language',	'en',	'Swedish',	184),
('sv',	'language',	'fr',	'Suédois',	185),
('sv',	'language',	'de',	'Schwedisch',	186),
('sw',	'language',	'sw',	'Kiswahili',	187),
('sw',	'language',	'en',	'Swahili',	188),
('ta',	'language',	'ta',	'தமிழ்',	189),
('ta',	'language',	'en',	'Tamil',	190),
('tet',	'language',	'tet',	'Tetun',	191),
('tet',	'language',	'en',	'Tetum',	192),
('tet',	'language',	'fr',	'Tétoum',	193),
('tet',	'language',	'de',	'Tetum',	194),
('th',	'language',	'th',	'ภาษาไทย',	195),
('th',	'language',	'en',	'Thai',	196),
('th',	'language',	'fr',	'Thaï',	197),
('th',	'language',	'de',	'Thailändisch',	198),
('tl',	'language',	'tl',	'Tagalog',	199),
('tl',	'language',	'en',	'Tagalog',	200),
('tr',	'language',	'tr',	'Türkçe',	201),
('tr',	'language',	'en',	'Turkish',	202),
('tr',	'language',	'fr',	'Turc',	203),
('tr',	'language',	'de',	'Türkisch',	204),
('uk',	'language',	'uk',	'Українська',	205),
('uk',	'language',	'en',	'Ukranian',	206),
('uk',	'language',	'fr',	'Ukrainien',	207),
('uk',	'language',	'de',	'Ukrainisch',	208),
('ur',	'language',	'en',	'Urdu',	209),
('ur',	'language',	'ur',	'اردو',	210),
('ur',	'language',	'fr',	'Ourdou',	211),
('ur',	'language',	'de',	'Urdu',	212),
('vi',	'language',	'vi',	'㗂越',	213),
('vi',	'language',	'en',	'Vietnamese',	214),
('zh',	'language',	'zh',	'中文',	215),
('zh',	'language',	'en',	'Chinese',	216),
('zh',	'language',	'fr',	'Chinois',	217),
('zh',	'language',	'de',	'Chinesisch',	218),
('Arab',	'script',	'Arab',	'العربية',	219),
('Arab',	'script',	'en',	'Arabic',	220),
('Arab',	'script',	'fr',	'Arabic',	221),
('Arab',	'script',	'de',	'Arabisch',	222),
('Armn',	'script',	'Armn',	'Հայոց այբուբեն',	223),
('Armn',	'script',	'en',	'Armenian',	224),
('Cyrl',	'script',	'Cyrl',	'Кирилица',	225),
('Cyrl',	'script',	'en',	'Cyrillic',	226),
('Cyrl',	'script',	'fr',	'Cyrillic',	227),
('Cyrl',	'script',	'de',	'Kyrillisch',	228),
('Ethi',	'script',	'Ethi',	'ግዕዝ',	229),
('Ethi',	'script',	'en',	'Ethiopic',	230),
('Grek',	'script',	'Grek',	'Ελληνικό αλφάβητο',	231),
('Grek',	'script',	'en',	'Greek',	232),
('Grek',	'script',	'fr',	'Greek',	233),
('Grek',	'script',	'de',	'Griechisch',	234),
('Hans',	'script',	'Hans',	'简体字',	235),
('Hans',	'script',	'en',	'Han (Simplified variant)',	236),
('Hans',	'script',	'fr',	'Han (Simplified variant)',	237),
('Hans',	'script',	'de',	'Han (Vereinfachte Variante)',	238),
('Hant',	'script',	'Hant',	'繁體字',	239),
('Hant',	'script',	'en',	'Han (Traditional variant)',	240),
('Hant',	'script',	'de',	'Han (Traditionelle Variante)',	241),
('Hebr',	'script',	'Hebr',	'אָלֶף־בֵּית עִבְרִי',	242),
('Hebr',	'script',	'en',	'Hebrew',	243),
('Hebr',	'script',	'de',	'Hebräisch',	244),
('Jpan',	'script',	'Jpan',	'漢字',	245),
('Jpan',	'script',	'en',	'Japanese',	246),
('Knda',	'script',	'Knda',	'ಕನ್ನಡ ಲಿಪಿ',	247),
('Knda',	'script',	'en',	'Kannada',	248),
('Kore',	'script',	'Kore',	'한글',	249),
('Kore',	'script',	'en',	'Korean',	250),
('Laoo',	'script',	'Laoo',	'ອັກສອນລາວ',	251),
('Laoo',	'script',	'en',	'Lao',	252),
('Laoo',	'script',	'de',	'Laotisch',	253),
('AL',	'region',	'en',	'Albania',	254),
('AL',	'region',	'sq',	'Shqipërisë',	255),
('AZ',	'region',	'en',	'Azerbaijan',	256),
('AZ',	'region',	'az',	'Azərbaycan',	257),
('BE',	'region',	'en',	'Belgium',	258),
('BE',	'region',	'nl',	'België',	259),
('BR',	'region',	'en',	'Brazil',	260),
('BR',	'region',	'pt',	'Brasil',	261),
('BY',	'region',	'en',	'Belarus',	262),
('BY',	'region',	'be',	'Беларусь',	263),
('CA',	'region',	'en',	'Canada',	264),
('CA',	'region',	'fr',	'Canada',	265),
('CH',	'region',	'en',	'Switzerland',	266),
('CH',	'region',	'de',	'Schweiz',	267),
('CN',	'region',	'en',	'China',	268),
('CN',	'region',	'zh',	'中国',	269),
('CZ',	'region',	'en',	'Czech Republic',	270),
('CZ',	'region',	'cs',	'Česká republika',	271),
('DE',	'region',	'en',	'Germany',	272),
('DE',	'region',	'de',	'Deutschland',	273),
('DK',	'region',	'en',	'Denmark',	274),
('DK',	'region',	'dk',	'Danmark',	275),
('ES',	'region',	'en',	'Spain',	276),
('ES',	'region',	'es',	'España',	277),
('FI',	'region',	'en',	'Finland',	278),
('FI',	'region',	'fi',	'Suomi',	279),
('FO',	'region',	'en',	'Faroe Islands',	280),
('FO',	'region',	'fo',	'Føroyar',	281),
('FR',	'region',	'en',	'France',	282),
('FR',	'region',	'fr',	'France',	283),
('GB',	'region',	'en',	'United Kingdom',	284),
('GR',	'region',	'en',	'Greece',	285),
('GR',	'region',	'el',	'Ελλάδα',	286),
('HR',	'region',	'en',	'Croatia',	287),
('HR',	'region',	'hr',	'Hrvatska',	288),
('HU',	'region',	'en',	'Hungary',	289),
('HU',	'region',	'hu',	'Magyarország',	290),
('ID',	'region',	'en',	'Indonesia',	291),
('ID',	'region',	'id',	'Indonesia',	292),
('IS',	'region',	'en',	'Iceland',	293),
('IS',	'region',	'is',	'Ísland',	294),
('IT',	'region',	'en',	'Italy',	295),
('IT',	'region',	'it',	'Italia',	296),
('JP',	'region',	'en',	'Japan',	297),
('JP',	'region',	'ja',	'日本',	298),
('KE',	'region',	'en',	'Kenya',	299),
('KE',	'region',	'rw',	'Kenya',	300),
('KH',	'region',	'en',	'Cambodia',	301),
('KH',	'region',	'km',	'កម្ពុជា',	302),
('KP',	'region',	'en',	'North Korea',	303),
('KP',	'region',	'ko',	'조선민주주의인민공화국',	304),
('LK',	'region',	'en',	'Sri Lanka',	305),
('LK',	'region',	'ta',	'இலங்கை',	306),
('MY',	'region',	'en',	'Malaysia',	307),
('MY',	'region',	'ms',	'Malaysia',	308),
('NE',	'region',	'en',	'Niger',	309),
('NE',	'region',	'ne',	'Niger',	310),
('NL',	'region',	'en',	'Netherlands',	311),
('NL',	'region',	'nl',	'Nederland',	312),
('NO',	'region',	'en',	'Norway',	313),
('NO',	'region',	'ne',	'Noreg',	314),
('NO',	'region',	'nn',	'Noreg',	315),
('NZ',	'region',	'en',	'New Zealand',	316),
('PH',	'region',	'en',	'Philippines',	317),
('PH',	'region',	'tl',	'Pilipinas',	318),
('PK',	'region',	'en',	'Pakistan',	319),
('PK',	'region',	'sd',	'پاكستان',	320),
('PL',	'region',	'en',	'Poland',	321),
('PL',	'region',	'pl',	'Polska',	322),
('PT',	'region',	'en',	'Portugal',	323),
('PT',	'region',	'pt',	'Portugal',	324),
('RO',	'region',	'en',	'Romania',	325),
('RO',	'region',	'ro',	'România',	326),
('RU',	'region',	'en',	'Russia',	327),
('RU',	'region',	'ru',	'Россия',	328),
('RW',	'region',	'en',	'Rwanda',	329),
('RW',	'region',	'rw',	'Rwanda',	330),
('SE',	'region',	'en',	'Sweden',	331),
('SE',	'region',	'sv',	'Sverige',	332),
('SI',	'region',	'en',	'Slovenia',	333),
('SI',	'region',	'sl',	'Slovenija',	334),
('SK',	'region',	'en',	'Slovakia',	335),
('SK',	'region',	'sk',	'Slovensko',	336),
('TH',	'region',	'en',	'Thailand',	337),
('TH',	'region',	'th',	'ประเทศไทย',	338),
('TR',	'region',	'en',	'Turkey',	339),
('TR',	'region',	'tr',	'Türkiye',	340),
('TW',	'region',	'en',	'Taiwan',	341),
('TW',	'region',	'zh',	'台灣',	342),
('UA',	'region',	'en',	'Ukraine',	343),
('UA',	'region',	'uk',	'Україна',	344),
('US',	'region',	'en',	'United States',	345),
('VN',	'region',	'en',	'Vietnam',	346),
('VN',	'region',	'vi',	'Việt Nam',	347);

DROP TABLE IF EXISTS `language_rfc4646_to_iso639`;
CREATE TABLE `language_rfc4646_to_iso639` (
  `rfc4646_subtag` varchar(25) DEFAULT NULL,
  `iso639_2_code` varchar(25) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `rfc4646_subtag` (`rfc4646_subtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `language_rfc4646_to_iso639` (`rfc4646_subtag`, `iso639_2_code`, `id`) VALUES
('am',	'amh',	1),
('ar',	'ara',	2),
('az',	'aze',	3),
('be',	'bel',	4),
('bn',	'ben',	5),
('bg',	'bul',	6),
('ca',	'cat',	7),
('cs',	'cze',	8),
('da',	'dan',	9),
('de',	'ger',	10),
('el',	'gre',	11),
('en',	'eng',	12),
('es',	'spa',	13),
('eu',	'eus',	14),
('fa',	'per',	15),
('fi',	'fin',	16),
('fo',	'fao',	17),
('fr',	'fre',	18),
('gl',	'glg',	19),
('he',	'heb',	20),
('hi',	'hin',	21),
('hr',	'hrv',	22),
('hu',	'hun',	23),
('hy',	'arm',	24),
('id',	'ind',	25),
('is',	'ice',	26),
('it',	'ita',	27),
('ja',	'jpn',	28),
('ka',	'kan',	29),
('km',	'khm',	30),
('ko',	'kor',	31),
('ku',	'kur',	32),
('la',	'lat',	33),
('lo',	'lao',	34),
('mi',	'mri',	35),
('mn',	'mon',	36),
('mr',	'mar',	37),
('ms',	'may',	38),
('nb',	'nob',	39),
('ne',	'nep',	40),
('nl',	'dut',	41),
('nn',	'nno',	42),
('pbr',	'pbr',	43),
('pl',	'pol',	44),
('prs',	'prs',	45),
('pt',	'por',	46),
('ro',	'rum',	47),
('ru',	'rus',	48),
('rw',	'kin',	49),
('sd',	'snd',	50),
('sk',	'slk',	51),
('sl',	'slv',	52),
('sq',	'sqi',	53),
('sr',	'srp',	54),
('sv',	'swe',	55),
('sw',	'swa',	56),
('ta',	'tam',	57),
('tet',	'tet',	58),
('th',	'tha',	59),
('tl',	'tgl',	60),
('tr',	'tur',	61),
('uk',	'ukr',	62),
('ur',	'urd',	63),
('vi',	'vie',	64),
('zh',	'chi',	65);

DROP TABLE IF EXISTS `language_script_bidi`;
CREATE TABLE `language_script_bidi` (
  `rfc4646_subtag` varchar(25) DEFAULT NULL,
  `bidi` varchar(3) DEFAULT NULL,
  KEY `rfc4646_subtag` (`rfc4646_subtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `language_script_bidi` (`rfc4646_subtag`, `bidi`) VALUES
('Arab',	'rtl'),
('Hebr',	'rtl');

DROP TABLE IF EXISTS `language_script_mapping`;
CREATE TABLE `language_script_mapping` (
  `language_subtag` varchar(25) DEFAULT NULL,
  `script_subtag` varchar(25) DEFAULT NULL,
  KEY `language_subtag` (`language_subtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `language_script_mapping` (`language_subtag`, `script_subtag`) VALUES
('ar',	'Arab'),
('he',	'Hebr');

DROP TABLE IF EXISTS `language_subtag_registry`;
CREATE TABLE `language_subtag_registry` (
  `subtag` varchar(25) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `description` varchar(25) DEFAULT NULL,
  `added` date DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `subtag` (`subtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `language_subtag_registry` (`subtag`, `type`, `description`, `added`, `id`) VALUES
('opac',	'i',	'OPAC',	'2005-10-16',	1),
('intranet',	'i',	'Staff Client',	'2005-10-16',	2),
('prog',	't',	'Prog',	'2005-10-16',	3),
('am',	'language',	'Amharic',	'2014-10-29',	4),
('ar',	'language',	'Arabic',	'2005-10-16',	5),
('az',	'language',	'Azerbaijani',	'2014-10-30',	6),
('be',	'language',	'Byelorussian',	'2014-10-30',	7),
('bn',	'language',	'Bengali',	'2014-10-30',	8),
('bg',	'language',	'Bulgarian',	'2005-10-16',	9),
('ca',	'language',	'Catalan',	'2013-01-12',	10),
('cs',	'language',	'Czech',	'2005-10-16',	11),
('da',	'language',	'Danish',	'2005-10-16',	12),
('de',	'language',	'German',	'2005-10-16',	13),
('el',	'language',	'Greek, Modern [1453- ]',	'2005-10-16',	14),
('en',	'language',	'English',	'2005-10-16',	15),
('es',	'language',	'Spanish',	'2005-10-16',	16),
('eu',	'language',	'Basque',	'2014-10-30',	17),
('fa',	'language',	'Persian',	'2005-10-16',	18),
('fi',	'language',	'Finnish',	'2005-10-16',	19),
('fo',	'language',	'Faroese',	'2014-10-30',	20),
('fr',	'language',	'French',	'2005-10-16',	21),
('gl',	'language',	'Galician',	'2005-10-16',	22),
('he',	'language',	'Hebrew',	'2005-10-16',	23),
('hi',	'language',	'Hindi',	'2005-10-16',	24),
('hr',	'language',	'Croatian',	'2014-07-24',	25),
('hu',	'language',	'Hungarian',	'2005-10-16',	26),
('hy',	'language',	'Armenian',	'2005-10-16',	27),
('id',	'language',	'Indonesian',	'2005-10-16',	28),
('is',	'language',	'Icelandic',	'2014-10-30',	29),
('it',	'language',	'Italian',	'2005-10-16',	30),
('ja',	'language',	'Japanese',	'2005-10-16',	31),
('ka',	'language',	'Kannada',	'2014-10-30',	32),
('km',	'language',	'Khmer',	'2014-10-30',	33),
('ko',	'language',	'Korean',	'2005-10-16',	34),
('ku',	'language',	'Kurdish',	'2014-05-13',	35),
('la',	'language',	'Latin',	'2005-10-16',	36),
('lo',	'language',	'Lao',	'2005-10-16',	37),
('mi',	'language',	'Maori',	'2014-10-30',	38),
('mn',	'language',	'Mongolian',	'2014-10-30',	39),
('mr',	'language',	'Marathi',	'2014-10-30',	40),
('ms',	'language',	'Malay',	'2014-10-30',	41),
('nb',	'language',	'Norwegian bokmål',	'2005-10-16',	42),
('ne',	'language',	'Nepali',	'2014-10-30',	43),
('nl',	'language',	'Dutch',	'2005-10-16',	44),
('nn',	'language',	'Norwegian nynorsk',	'2011-02-14',	45),
('pbr',	'language',	'Pangwa',	'2014-10-30',	46),
('pl',	'language',	'Polish',	'2005-10-16',	47),
('prs',	'language',	'Dari',	'2014-10-30',	48),
('pt',	'language',	'Portuguese',	'2005-10-16',	49),
('ro',	'language',	'Romanian',	'2005-10-16',	50),
('ru',	'language',	'Russian',	'2005-10-16',	51),
('rw',	'language',	'Kinyarwanda',	'2014-10-30',	52),
('sd',	'language',	'Sindhi',	'2014-10-30',	53),
('sk',	'language',	'Slovak',	'2014-10-30',	54),
('sl',	'language',	'Slovene',	'2014-10-30',	55),
('sq',	'language',	'Albanian',	'2014-10-30',	56),
('sr',	'language',	'Serbian',	'2005-10-16',	57),
('sv',	'language',	'Swedish',	'2005-10-16',	58),
('sw',	'language',	'Swahili',	'2014-10-30',	59),
('ta',	'language',	'Tamil',	'2014-10-30',	60),
('tet',	'language',	'Tetum',	'2005-10-16',	61),
('th',	'language',	'Thai',	'2005-10-16',	62),
('tl',	'language',	'Tagalog',	'2014-10-30',	63),
('tr',	'language',	'Turkish',	'2005-10-16',	64),
('uk',	'language',	'Ukranian',	'2005-10-16',	65),
('ur',	'language',	'Urdu',	'2005-10-16',	66),
('vi',	'language',	'Vietnamese',	'2014-10-30',	67),
('zh',	'language',	'Chinese',	'2005-10-16',	68),
('Arab',	'script',	'Arabic',	'2005-10-16',	69),
('Armn',	'script',	'Armenian',	'2014-10-30',	70),
('Cyrl',	'script',	'Cyrillic',	'2005-10-16',	71),
('Ethi',	'script',	'Ethiopic',	'2014-10-30',	72),
('Grek',	'script',	'Greek',	'2005-10-16',	73),
('Hans',	'script',	'Han (Simplified variant)',	'2005-10-16',	74),
('Hant',	'script',	'Han (Traditional variant)',	'2005-10-16',	75),
('Hebr',	'script',	'Hebrew',	'2005-10-16',	76),
('Jpan',	'script',	'Japanese',	'2014-10-30',	77),
('Knda',	'script',	'Kannada',	'2014-10-30',	78),
('Kore',	'script',	'Korean',	'2014-10-30',	79),
('Laoo',	'script',	'Lao',	'2005-10-16',	80),
('AL',	'region',	'Albania',	'2014-10-30',	81),
('AZ',	'region',	'Azerbaijan',	'2014-10-30',	82),
('BE',	'region',	'Belgium',	'2014-10-30',	83),
('BR',	'region',	'Brazil',	'2014-10-30',	84),
('BY',	'region',	'Belarus',	'2014-10-30',	85),
('CA',	'region',	'Canada',	'2005-10-16',	86),
('CH',	'region',	'Switzerland',	'2014-10-30',	87),
('CN',	'region',	'China',	'2014-10-30',	88),
('CZ',	'region',	'Czech Republic',	'2014-10-30',	89),
('DE',	'region',	'Germany',	'2014-10-30',	90),
('DK',	'region',	'Denmark',	'2005-10-16',	91),
('ES',	'region',	'Spain',	'2014-10-30',	92),
('FI',	'region',	'Finland',	'2014-10-30',	93),
('FO',	'region',	'Faroe Islands',	'2014-10-30',	94),
('FR',	'region',	'France',	'2005-10-16',	95),
('GB',	'region',	'United Kingdom',	'2005-10-16',	96),
('GR',	'region',	'Greece',	'2014-10-30',	97),
('HR',	'region',	'Croatia',	'2014-10-30',	98),
('HU',	'region',	'Hungary',	'2014-10-30',	99),
('ID',	'region',	'Indonesia',	'2014-10-30',	100),
('IS',	'region',	'Iceland',	'2014-10-30',	101),
('IT',	'region',	'Italy',	'2014-10-30',	102),
('JP',	'region',	'Japan',	'2014-10-30',	103),
('KE',	'region',	'Kenya',	'2014-10-30',	104),
('KH',	'region',	'Cambodia',	'2014-10-30',	105),
('KP',	'region',	'North Korea',	'2014-10-30',	106),
('LK',	'region',	'Sri Lanka',	'2014-10-30',	107),
('MY',	'region',	'Malaysia',	'2014-10-30',	108),
('NE',	'region',	'Niger',	'2014-10-30',	109),
('NL',	'region',	'Netherlands',	'2014-10-30',	110),
('NO',	'region',	'Norway',	'2014-10-30',	111),
('NZ',	'region',	'New Zealand',	'2005-10-16',	112),
('PH',	'region',	'Philippines',	'2014-10-30',	113),
('PK',	'region',	'Pakistan',	'2014-10-30',	114),
('PL',	'region',	'Poland',	'2014-10-30',	115),
('PT',	'region',	'Portugal',	'2014-10-30',	116),
('RO',	'region',	'Romania',	'2014-10-30',	117),
('RU',	'region',	'Russia',	'2014-10-30',	118),
('RW',	'region',	'Rwanda',	'2014-10-30',	119),
('SE',	'region',	'Sweden',	'2014-10-30',	120),
('SI',	'region',	'Slovenia',	'2014-10-30',	121),
('SK',	'region',	'Slovakia',	'2014-10-30',	122),
('TH',	'region',	'Thailand',	'2014-10-30',	123),
('TR',	'region',	'Turkey',	'2014-10-30',	124),
('TW',	'region',	'Taiwan',	'2014-10-30',	125),
('UA',	'region',	'Ukraine',	'2014-10-30',	126),
('US',	'region',	'United States',	'2005-10-16',	127),
('VN',	'region',	'Vietnam',	'2014-10-30',	128);

DROP TABLE IF EXISTS `letter`;
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


DROP TABLE IF EXISTS `linktracker`;
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


DROP TABLE IF EXISTS `marc_matchers`;
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


DROP TABLE IF EXISTS `marc_modification_templates`;
CREATE TABLE `marc_modification_templates` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `marc_modification_template_actions`;
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


DROP TABLE IF EXISTS `marc_subfield_structure`;
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


DROP TABLE IF EXISTS `marc_tag_structure`;
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


DROP TABLE IF EXISTS `matchchecks`;
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


DROP TABLE IF EXISTS `matcher_matchpoints`;
CREATE TABLE `matcher_matchpoints` (
  `matcher_id` int(11) NOT NULL,
  `matchpoint_id` int(11) NOT NULL,
  KEY `matcher_matchpoints_ifbk_1` (`matcher_id`),
  KEY `matcher_matchpoints_ifbk_2` (`matchpoint_id`),
  CONSTRAINT `matcher_matchpoints_ifbk_1` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matcher_matchpoints_ifbk_2` FOREIGN KEY (`matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `matchpoints`;
CREATE TABLE `matchpoints` (
  `matcher_id` int(11) NOT NULL,
  `matchpoint_id` int(11) NOT NULL AUTO_INCREMENT,
  `search_index` varchar(30) NOT NULL DEFAULT '',
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`matchpoint_id`),
  KEY `matchpoints_ifbk_1` (`matcher_id`),
  CONSTRAINT `matchpoints_ifbk_1` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `matchpoint_components`;
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


DROP TABLE IF EXISTS `matchpoint_component_norms`;
CREATE TABLE `matchpoint_component_norms` (
  `matchpoint_component_id` int(11) NOT NULL,
  `sequence` int(11) NOT NULL DEFAULT '0',
  `norm_routine` varchar(50) NOT NULL DEFAULT '',
  KEY `matchpoint_component_norms` (`matchpoint_component_id`,`sequence`),
  CONSTRAINT `matchpoint_component_norms_ifbk_1` FOREIGN KEY (`matchpoint_component_id`) REFERENCES `matchpoint_components` (`matchpoint_component_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `message_type` varchar(1) NOT NULL,
  `message` text NOT NULL,
  `message_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `message_attributes`;
CREATE TABLE `message_attributes` (
  `message_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_name` varchar(40) NOT NULL DEFAULT '',
  `takes_days` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_attribute_id`),
  UNIQUE KEY `message_name` (`message_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `message_queue`;
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


DROP TABLE IF EXISTS `message_transports`;
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


DROP TABLE IF EXISTS `message_transport_types`;
CREATE TABLE `message_transport_types` (
  `message_transport_type` varchar(20) NOT NULL,
  PRIMARY KEY (`message_transport_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `misc_files`;
CREATE TABLE `misc_files` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_tag` varchar(255) NOT NULL,
  `record_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_description` varchar(255) DEFAULT NULL,
  `file_content` longblob NOT NULL,
  `date_uploaded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`file_id`),
  KEY `table_tag` (`table_tag`),
  KEY `record_id` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `need_merge_authorities`;
CREATE TABLE `need_merge_authorities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authid` bigint(20) NOT NULL,
  `done` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `notifys`;
CREATE TABLE `notifys` (
  `notify_id` int(11) NOT NULL DEFAULT '0',
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `itemnumber` int(11) NOT NULL DEFAULT '0',
  `notify_date` date DEFAULT NULL,
  `notify_send_date` date DEFAULT NULL,
  `notify_level` int(1) NOT NULL DEFAULT '0',
  `method` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `oai_sets`;
CREATE TABLE `oai_sets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spec` varchar(80) NOT NULL,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `spec` (`spec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `oai_sets_biblios`;
CREATE TABLE `oai_sets_biblios` (
  `biblionumber` int(11) NOT NULL,
  `set_id` int(11) NOT NULL,
  PRIMARY KEY (`biblionumber`,`set_id`),
  KEY `oai_sets_biblios_ibfk_2` (`set_id`),
  CONSTRAINT `oai_sets_biblios_ibfk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `oai_sets_biblios_ibfk_2` FOREIGN KEY (`set_id`) REFERENCES `oai_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `oai_sets_descriptions`;
CREATE TABLE `oai_sets_descriptions` (
  `set_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  KEY `oai_sets_descriptions_ibfk_1` (`set_id`),
  CONSTRAINT `oai_sets_descriptions_ibfk_1` FOREIGN KEY (`set_id`) REFERENCES `oai_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `oai_sets_mappings`;
CREATE TABLE `oai_sets_mappings` (
  `set_id` int(11) NOT NULL,
  `marcfield` char(3) NOT NULL,
  `marcsubfield` char(1) NOT NULL,
  `operator` varchar(8) NOT NULL DEFAULT 'equal',
  `marcvalue` varchar(80) NOT NULL,
  KEY `oai_sets_mappings_ibfk_1` (`set_id`),
  CONSTRAINT `oai_sets_mappings_ibfk_1` FOREIGN KEY (`set_id`) REFERENCES `oai_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `old_issues`;
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
  `auto_renew` tinyint(1) DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `issuedate` datetime DEFAULT NULL,
  `onsite_checkout` int(1) NOT NULL DEFAULT '0',
  KEY `old_issuesborridx` (`borrowernumber`),
  KEY `old_issuesitemidx` (`itemnumber`),
  KEY `branchcode_idx` (`branchcode`),
  KEY `issuingbranch_idx` (`issuingbranch`),
  KEY `old_bordate` (`borrowernumber`,`timestamp`),
  CONSTRAINT `old_issues_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `old_issues_ibfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `old_reserves`;
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


DROP TABLE IF EXISTS `opac_news`;
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


DROP TABLE IF EXISTS `overduerules`;
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


DROP TABLE IF EXISTS `overduerules_transport_types`;
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


DROP TABLE IF EXISTS `patroncards`;
CREATE TABLE `patroncards` (
  `cardid` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(10) NOT NULL DEFAULT '1',
  `borrowernumber` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cardid`),
  KEY `patroncards_ibfk_1` (`borrowernumber`),
  CONSTRAINT `patroncards_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `patronimage`;
CREATE TABLE `patronimage` (
  `borrowernumber` int(11) NOT NULL,
  `mimetype` varchar(15) NOT NULL,
  `imagefile` mediumblob NOT NULL,
  PRIMARY KEY (`borrowernumber`),
  CONSTRAINT `patronimage_fk1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `patron_lists`;
CREATE TABLE `patron_lists` (
  `patron_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `owner` int(11) NOT NULL,
  PRIMARY KEY (`patron_list_id`),
  KEY `owner` (`owner`),
  CONSTRAINT `patron_lists_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `patron_list_patrons`;
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


DROP TABLE IF EXISTS `pending_offline_operations`;
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


DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `module_bit` int(11) NOT NULL DEFAULT '0',
  `code` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`module_bit`,`code`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`module_bit`) REFERENCES `userflags` (`bit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `plugin_data`;
CREATE TABLE `plugin_data` (
  `plugin_class` varchar(255) NOT NULL,
  `plugin_key` varchar(255) NOT NULL,
  `plugin_value` text,
  PRIMARY KEY (`plugin_class`,`plugin_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `printers`;
CREATE TABLE `printers` (
  `printername` varchar(40) NOT NULL DEFAULT '',
  `printqueue` varchar(20) DEFAULT NULL,
  `printtype` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`printername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `printers_profile`;
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


DROP TABLE IF EXISTS `quotes`;
CREATE TABLE `quotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` text,
  `text` mediumtext NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ratings`;
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


DROP TABLE IF EXISTS `repeatable_holidays`;
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


DROP TABLE IF EXISTS `reports_dictionary`;
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


DROP TABLE IF EXISTS `reserveconstraints`;
CREATE TABLE `reserveconstraints` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `reservedate` date DEFAULT NULL,
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `biblioitemnumber` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `reserves`;
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


DROP TABLE IF EXISTS `reviews`;
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


DROP TABLE IF EXISTS `saved_reports`;
CREATE TABLE `saved_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) DEFAULT NULL,
  `report` longtext,
  `date_run` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `saved_sql`;
CREATE TABLE `saved_sql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `savedsql` text,
  `last_run` datetime DEFAULT NULL,
  `report_name` varchar(255) NOT NULL DEFAULT '',
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


DROP TABLE IF EXISTS `search_history`;
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


DROP TABLE IF EXISTS `serial`;
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
  `claims_count` int(11) DEFAULT '0',
  `routingnotes` text,
  PRIMARY KEY (`serialid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `serialitems`;
CREATE TABLE `serialitems` (
  `itemnumber` int(11) NOT NULL,
  `serialid` int(11) NOT NULL,
  UNIQUE KEY `serialitemsidx` (`itemnumber`),
  KEY `serialitems_sfk_1` (`serialid`),
  CONSTRAINT `serialitems_sfk_1` FOREIGN KEY (`serialid`) REFERENCES `serial` (`serialid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `serialitems_sfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `services_throttle`;
CREATE TABLE `services_throttle` (
  `service_type` varchar(10) NOT NULL DEFAULT '',
  `service_count` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`service_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(32) NOT NULL,
  `a_session` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sessions` (`id`, `a_session`) VALUES
('dba77519575333747c33475b00f79347',	'--- \n_SESSION_ATIME: \'1428941783\'\n_SESSION_CTIME: \'1428941783\'\n_SESSION_ID: dba77519575333747c33475b00f79347\n_SESSION_REMOTE_ADDR: 172.17.42.1\n');

DROP TABLE IF EXISTS `social_data`;
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


DROP TABLE IF EXISTS `special_holidays`;
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


DROP TABLE IF EXISTS `statistics`;
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


DROP TABLE IF EXISTS `stopwords`;
CREATE TABLE `stopwords` (
  `word` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `subscription`;
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


DROP TABLE IF EXISTS `subscriptionhistory`;
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


DROP TABLE IF EXISTS `subscriptionroutinglist`;
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


DROP TABLE IF EXISTS `subscription_frequencies`;
CREATE TABLE `subscription_frequencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `displayorder` int(11) DEFAULT NULL,
  `unit` enum('day','week','month','year') DEFAULT NULL,
  `unitsperissue` int(11) NOT NULL DEFAULT '1',
  `issuesperunit` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `subscription_numberpatterns`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `suggestions`;
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


DROP TABLE IF EXISTS `systempreferences`;
CREATE TABLE `systempreferences` (
  `variable` varchar(50) NOT NULL DEFAULT '',
  `value` text,
  `options` mediumtext,
  `explanation` text,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `systempreferences` (`variable`, `value`, `options`, `explanation`, `type`) VALUES
('AcqCreateItem',	'ordering',	'ordering|receiving|cataloguing',	'Define when the item is created : when ordering, when receiving, or in cataloguing module',	'Choice'),
('AcqEnableFiles',	'0',	NULL,	'If enabled, allows librarians to upload and attach arbitrary files to invoice records.',	'YesNo'),
('AcqItemSetSubfieldsWhenReceiptIsCancelled',	'',	'',	'Upon cancelling a receipt, update the items subfields if they were created when placing an order (e.g. o=5|a=\"bar foo\")',	'Free'),
('AcqItemSetSubfieldsWhenReceived',	'',	'',	'Upon receiving items, update their subfields if they were created when placing an order (e.g. o=5|a=\"foo bar\")',	'Free'),
('AcquisitionDetails',	'1',	'',	'Hide/Show acquisition details on the biblio detail page.',	'YesNo'),
('AcqViewBaskets',	'user',	'user|branch|all',	'Define which baskets a user is allowed to view: his own only, any within his branch or all',	'Choice'),
('AcqWarnOnDuplicateInvoice',	'0',	'',	'Warn librarians when they try to create a duplicate invoice',	'YesNo'),
('AddPatronLists',	'categorycode',	'categorycode|category_type',	'Allow user to choose what list to pick up from when adding patrons',	'Choice'),
('advancedMARCeditor',	'0',	'',	'If ON, the MARC editor won\'t display field/subfield descriptions',	'YesNo'),
('AdvancedSearchLanguages',	'',	'',	'ISO 639-2 codes of languages you wish to see appear as an Advanced search option.  Example: eng|fre|ita',	'Textarea'),
('AdvancedSearchTypes',	'itemtypes',	'itemtypes|ccode',	'Select which set of fields comprise the Type limit in the advanced search',	'Choice'),
('AgeRestrictionMarker',	'',	NULL,	'Markers for age restriction indication, e.g. FSK|PEGI|Age|',	'free'),
('AgeRestrictionOverride',	'0',	NULL,	'Allow staff to check out an item with age restriction.',	'YesNo'),
('AggressiveMatchOnISBN',	'0',	NULL,	'If enabled, attempt to match aggressively by trying all variations of the ISBNs in the imported record as a phrase in the ISBN fields of already cataloged records when matching on ISBN with the record import tool',	'YesNo'),
('AllFinesNeedOverride',	'1',	'0',	'If on, staff will be asked to override every fine, even if it is below noissuescharge.',	'YesNo'),
('AllowAllMessageDeletion',	'0',	'',	'Allow any Library to delete any message',	'YesNo'),
('AllowFineOverride',	'0',	'0',	'If on, staff will be able to issue books to patrons with fines greater than noissuescharge.',	'YesNo'),
('AllowHoldDateInFuture',	'0',	'',	'If set a date field is displayed on the Hold screen of the Staff Interface, allowing the hold date to be set in the future.',	'YesNo'),
('AllowHoldPolicyOverride',	'0',	NULL,	'Allow staff to override hold policies when placing holds',	'YesNo'),
('AllowHoldsOnDamagedItems',	'1',	'',	'Allow hold requests to be placed on damaged items',	'YesNo'),
('AllowHoldsOnPatronsPossessions',	'1',	NULL,	'Allow holds on records that patron have items of it',	'YesNo'),
('AllowItemsOnHoldCheckout',	'0',	'',	'Do not generate RESERVE_WAITING and RESERVED warning when checking out items reserved to someone else. This allows self checkouts for those items.',	'YesNo'),
('AllowMultipleCovers',	'0',	'1',	'Allow multiple cover images to be attached to each bibliographic record.',	'YesNo'),
('AllowMultipleIssuesOnABiblio',	'1',	'Allow/Don\'t allow patrons to check out multiple items from one biblio',	'',	'YesNo'),
('AllowNotForLoanOverride',	'0',	'',	'If ON, Koha will allow the librarian to loan a not for loan item.',	'YesNo'),
('AllowOfflineCirculation',	'0',	'',	'If on, enables HTML5 offline circulation functionality.',	'YesNo'),
('AllowOnShelfHolds',	'0',	'',	'Allow hold requests to be placed on items that are not on loan',	'YesNo'),
('AllowPKIAuth',	'None',	'None|Common Name|emailAddress',	'Use the field from a client-side SSL certificate to look a user in the Koha database',	'Choice'),
('AllowPurchaseSuggestionBranchChoice',	'0',	'1',	'Allow user to choose branch when making a purchase suggestion',	'YesNo'),
('AllowRenewalIfOtherItemsAvailable',	'0',	NULL,	'If enabled, allow a patron to renew an item with unfilled holds if other available items can fill that hold.',	'YesNo'),
('AllowRenewalLimitOverride',	'0',	NULL,	'if ON, allows renewal limits to be overridden on the circulation screen',	'YesNo'),
('AllowReturnToBranch',	'anywhere',	'anywhere|homebranch|holdingbranch|homeorholdingbranch',	'Where an item may be returned',	'Choice'),
('AllowSelfCheckReturns',	'0',	'',	'If enabled, patrons may return items through the Web-based Self Checkout',	'YesNo'),
('AllowTooManyOverride',	'1',	'',	'If on, allow staff to override and check out items when the patron has reached the maximum number of allowed checkouts',	'YesNo'),
('alphabet',	'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z',	NULL,	'Alphabet than can be expanded into browse links, e.g. on Home > Patrons',	'free'),
('AlternateHoldingsField',	'',	NULL,	'The MARC field/subfield that contains alternate holdings information for bibs taht do not have items attached (e.g. 852abchi for libraries converting from MARC Magician).',	'free'),
('AlternateHoldingsSeparator',	'',	NULL,	'The string to use to separate subfields in alternate holdings displays.',	'free'),
('AmazonAssocTag',	'',	'',	'See:  http://aws.amazon.com',	'free'),
('AmazonCoverImages',	'0',	'',	'Display Cover Images in Staff Client from Amazon Web Services',	'YesNo'),
('AmazonLocale',	'US',	'US|CA|DE|FR|JP|UK',	'Use to set the Locale of your Amazon.com Web Services',	'Choice'),
('AnonSuggestions',	'0',	NULL,	'Set to enable Anonymous suggestions to AnonymousPatron borrowernumber',	'YesNo'),
('AnonymousPatron',	'0',	NULL,	'Set the identifier (borrowernumber) of the anonymous patron. Used for Suggestion and reading history privacy',	''),
('AuthDisplayHierarchy',	'0',	'',	'Display authority hierarchies',	'YesNo'),
('AuthoritiesLog',	'1',	NULL,	'If ON, log edit/create/delete actions on authorities.',	'YesNo'),
('AuthoritySeparator',	'--',	'10',	'Used to separate a list of authorities in a display. Usually --',	'free'),
('autoBarcode',	'OFF',	'incremental|annual|hbyymmincr|EAN13|OFF',	'Used to autogenerate a barcode: incremental will be of the form 1, 2, 3; annual of the form 2007-0001, 2007-0002; hbyymmincr of the form HB08010001 where HB=Home Branch',	'Choice'),
('AutoCreateAuthorities',	'0',	NULL,	'Automatically create authorities that do not exist when cataloging records.',	'YesNo'),
('AutoEmailOpacUser',	'0',	NULL,	'Sends notification emails containing new account details to patrons - when account is created.',	'YesNo'),
('AutoEmailPrimaryAddress',	'OFF',	'email|emailpro|B_email|cardnumber|OFF',	'Defines the default email address where \'Account Details\' emails are sent.',	'Choice'),
('AutoLocation',	'0',	NULL,	'If ON, IP authentication is enabled, blocking access to the staff client from unauthorized IP addresses',	'YesNo'),
('AutomaticItemReturn',	'1',	NULL,	'If ON, Koha will automatically set up a transfer of this item to its homebranch',	'YesNo'),
('autoMemberNum',	'1',	'',	'If ON, patron number is auto-calculated',	'YesNo'),
('AutoRemoveOverduesRestrictions',	'0',	NULL,	'Defines whether an OVERDUES debarment should be lifted automatically if all overdue items are returned by the patron.',	'YesNo'),
('AutoResumeSuspendedHolds',	'1',	NULL,	'Allow suspended holds to be automatically resumed by a set date.',	'YesNo'),
('AutoSelfCheckAllowed',	'0',	'',	'For corporate and special libraries which want web-based self-check available from any PC without the need for a manual staff login. Most libraries will want to leave this turned off. If on, requires self-check ID and password to be entered in AutoSelfCheckID and AutoSelfCheckPass sysprefs.',	'YesNo'),
('AutoSelfCheckID',	'',	'',	'Staff ID with circulation rights to be used for automatic web-based self-check. Only applies if AutoSelfCheckAllowed syspref is turned on.',	'free'),
('AutoSelfCheckPass',	'',	'',	'Password to be used for automatic web-based self-check. Only applies if AutoSelfCheckAllowed syspref is turned on.',	'free'),
('Babeltheque',	'0',	'',	'Turn ON Babeltheque content  - See babeltheque.com to subscribe to this service',	'YesNo'),
('Babeltheque_url_js',	'',	'',	'Url for Babeltheque javascript (e.g. http://www.babeltheque.com/bw_XX.js)',	'Free'),
('Babeltheque_url_update',	'',	'',	'Url for Babeltheque update (E.G. http://www.babeltheque.com/.../file.csv.bz2)',	'Free'),
('BakerTaylorBookstoreURL',	'',	'',	'URL template for \"My Libary Bookstore\" links, to which the \"key\" value is appended, and \"https://\" is prepended.  It should include your hostname and \"Parent Number\".  Make this variable empty to turn MLB links off.  Example: ocls.mylibrarybookstore.com/MLB/actions/searchHandler.do?nextPage=bookDetails&parentNum=10923&key=',	''),
('BakerTaylorEnabled',	'0',	'',	'Enable or disable all Baker & Taylor features.',	'YesNo'),
('BakerTaylorPassword',	'',	'',	'Baker & Taylor Password for Content Cafe (external content)',	'Free'),
('BakerTaylorUsername',	'',	'',	'Baker & Taylor Username for Content Cafe (external content)',	'Free'),
('BasketConfirmations',	'1',	'always ask for confirmation.|do not ask for confirmation.',	'When closing or reopening a basket,',	'Choice'),
('BiblioAddsAuthorities',	'0',	NULL,	'If ON, adding a new biblio will check for an existing authority record and create one on the fly if one doesn\'t exist',	'YesNo'),
('BiblioDefaultView',	'normal',	'normal|marc|isbd',	'Choose the default detail view in the catalog; choose between normal, marc or isbd',	'Choice'),
('BlockExpiredPatronOpacActions',	'1',	NULL,	'Set whether an expired patron can perform opac actions such as placing holds or renew books, can be overridden on a per patron-type basis',	'YesNo'),
('BlockReturnOfWithdrawnItems',	'1',	'0',	'If enabled, items that are marked as withdrawn cannot be returned.',	'YesNo'),
('BorrowerMandatoryField',	'surname|cardnumber',	NULL,	'Choose the mandatory fields for a patron\'s account',	'free'),
('borrowerRelationship',	'father|mother',	'',	'Define valid relationships between a guarantor & a guarantee (separated by | or ,)',	'free'),
('BorrowerRenewalPeriodBase',	'now',	'dateexpiry|now',	'Set whether the borrower renewal date should be counted from the dateexpiry or from the current date ',	'Choice'),
('BorrowersLog',	'1',	NULL,	'If ON, log edit/create/delete actions on patron data',	'YesNo'),
('BorrowersTitles',	'Mr|Mrs|Miss|Ms',	NULL,	'Define appropriate Titles for patrons',	'free'),
('BorrowerUnwantedField',	'',	NULL,	'Name the fields you don\'t need to store for a patron\'s account',	'free'),
('BranchTransferLimitsType',	'ccode',	'itemtype|ccode',	'When using branch transfer limits, choose whether to limit by itemtype or collection code.',	'Choice'),
('CalculateFinesOnReturn',	'1',	'',	'Switch to control if overdue fines are calculated on return or not',	'YesNo'),
('CalendarFirstDayOfWeek',	'Sunday',	'Sunday|Monday',	'Select the first day of week to use in the calendar.',	'Choice'),
('canreservefromotherbranches',	'1',	'',	'With Independent branches on, can a user from one library place a hold on an item from another library',	'YesNo'),
('casAuthentication',	'0',	'',	'Enable or disable CAS authentication',	'YesNo'),
('casLogout',	'0',	'',	'Does a logout from Koha should also log the user out of CAS?',	'YesNo'),
('casServerUrl',	'https://localhost:8443/cas',	'',	'URL of the cas server',	'Free'),
('CatalogModuleRelink',	'0',	NULL,	'If OFF the linker will never replace the authids that are set in the cataloging module.',	'YesNo'),
('CataloguingLog',	'1',	NULL,	'If ON, log edit/create/delete actions on bibliographic data. WARNING: this feature is very resource consuming.',	'YesNo'),
('checkdigit',	'none',	'none|katipo',	'If ON, enable checks on patron cardnumber: none or \"Katipo\" style checks',	'Choice'),
('CircAutocompl',	'1',	NULL,	'If ON, autocompletion is enabled for the Circulation input',	'YesNo'),
('CircAutoPrintQuickSlip',	'qslip',	NULL,	'Choose what should happen when an empty barcode field is submitted in circulation: Display a print quick slip window, Display a print slip window or Clear the screen.',	'Choice'),
('CircControl',	'ItemHomeLibrary',	'PickupLibrary|PatronLibrary|ItemHomeLibrary',	'Specify the agency that controls the circulation and fines policy',	'Choice'),
('COinSinOPACResults',	'1',	'',	'If ON, use COinS in OPAC search results page.  NOTE: this can slow down search response time significantly',	'YesNo'),
('ConfirmFutureHolds',	'0',	'',	'Number of days for confirming future holds',	'Integer'),
('CurrencyFormat',	'US',	'US|FR',	'Determines the display format of currencies. eg: \'36000\' is displayed as \'360 000,00\'  in \'FR\' or \'360,000.00\'  in \'US\'.',	'Choice'),
('dateformat',	'us',	'metric|us|iso',	'Define global date format (us mm/dd/yyyy, metric dd/mm/yyy, ISO yyyy-mm-dd)',	'Choice'),
('DebugLevel',	'2',	'0|1|2',	'Define the level of debugging information sent to the browser when errors are encountered (set to 0 in production). 0=none, 1=some, 2=most',	'Choice'),
('decreaseLoanHighHolds',	NULL,	'',	'Decreases the loan period for items with number of holds above the threshold specified in decreaseLoanHighHoldsValue',	'YesNo'),
('decreaseLoanHighHoldsDuration',	NULL,	'',	'Specifies a number of days that a loan is reduced to when used in conjunction with decreaseLoanHighHolds',	'Integer'),
('decreaseLoanHighHoldsValue',	NULL,	'',	'Specifies a threshold for the minimum number of holds needed to trigger a reduction in loan duration (used with decreaseLoanHighHolds)',	'Integer'),
('DefaultClassificationSource',	'ddc',	NULL,	'Default classification scheme used by the collection. E.g., Dewey, LCC, etc.',	'ClassSources'),
('DefaultLanguageField008',	'',	'',	'Fill in the default language for field 008 Range 35-37 of MARC21 records (e.g. eng, nor, ger, see <a href=\"http://www.loc.gov/marc/languages/language_code.html\">MARC Code List for Languages</a>)',	'Free'),
('DefaultLongOverdueChargeValue',	NULL,	NULL,	'Charge a lost item to the borrower\'s account when the LOST value of the item changes to n.',	'integer'),
('DefaultLongOverdueDays',	NULL,	NULL,	'Set the LOST value of an item when the item has been overdue for more than n days.',	'integer'),
('DefaultLongOverdueLostValue',	NULL,	NULL,	'Set the LOST value of an item to n when the item has been overdue for more than defaultlongoverduedays days.',	'integer'),
('defaultSortField',	'relevance',	'relevance|popularity|call_number|pubdate|acqdate|title|author',	'Specify the default field used for sorting',	'Choice'),
('defaultSortOrder',	'dsc',	'asc|dsc|az|za',	'Specify the default sort order',	'Choice'),
('delimiter',	';',	';|tabulation|,|/|\\|#||',	'Define the default separator character for exporting reports',	'Choice'),
('Display856uAsImage',	'OFF',	'OFF|Details|Results|Both',	'Display the URI in the 856u field as an image, the corresponding Staff Client XSLT option must be on',	'Choice'),
('DisplayClearScreenButton',	'0',	'',	'If set to ON, a clear screen button will appear on the circulation page.',	'YesNo'),
('displayFacetCount',	'0',	NULL,	NULL,	'YesNo'),
('DisplayIconsXSLT',	'1',	'',	'If ON, displays the format, audience, and material type icons in XSLT MARC21 results and detail pages.',	'YesNo'),
('DisplayLibraryFacets',	'holding',	'home|holding|both',	'Defines which library facets to display.',	'Choice'),
('DisplayMultiPlaceHold',	'1',	'',	'Display the ability to place multiple holds or not',	'YesNo'),
('DisplayOPACiconsXSLT',	'1',	'',	'If ON, displays the format, audience, and material type icons in XSLT MARC21 results and detail pages in the OPAC.',	'YesNo'),
('dontmerge',	'1',	NULL,	'If ON, modifying an authority record will not update all associated bibliographic records immediately, ask your system administrator to enable the merge_authorities.pl cron job',	'YesNo'),
('EasyAnalyticalRecords',	'0',	'',	'If on, display in the catalogue screens tools to easily setup analytical record relationships',	'YesNo'),
('emailLibrarianWhenHoldIsPlaced',	'0',	NULL,	'If ON, emails the librarian whenever a hold is placed',	'YesNo'),
('EnableBorrowerFiles',	'0',	NULL,	'If enabled, allows librarians to upload and attach arbitrary files to a borrower record.',	'YesNo'),
('EnableOpacSearchHistory',	'1',	'YesNo',	'Enable or disable opac search history',	''),
('EnableSearchHistory',	'0',	'',	'Enable or disable search history',	'YesNo'),
('EnhancedMessagingPreferences',	'0',	'',	'If ON, allows patrons to select to receive additional messages about items due or nearly due.',	'YesNo'),
('expandedSearchOption',	'0',	NULL,	'If ON, set advanced search to be expanded by default',	'YesNo'),
('ExpireReservesMaxPickUpDelay',	'0',	'',	'Enabling this allows holds to expire automatically if they have not been picked by within the time period specified in ReservesMaxPickUpDelay',	'YesNo'),
('ExpireReservesMaxPickUpDelayCharge',	'0',	NULL,	'If ExpireReservesMaxPickUpDelay is enabled, and this field has a non-zero value, than a borrower whose waiting hold has expired will be charged this amount.',	'free'),
('ExpireReservesOnHolidays',	'1',	NULL,	'If false, reserves at a library will not be canceled on days the library is not open.',	'YesNo'),
('ExtendedPatronAttributes',	'0',	NULL,	'Use extended patron IDs and attributes',	'YesNo'),
('FacetLabelTruncationLength',	'20',	NULL,	'Specify the facet max length in OPAC',	'Integer'),
('FacetMaxCount',	'20',	NULL,	'Specify the max facet count for each category',	'Integer'),
('FilterBeforeOverdueReport',	'0',	'',	'Do not run overdue report until filter selected',	'YesNo'),
('FineNotifyAtCheckin',	'0',	NULL,	'If ON notify librarians of overdue fines on the items they are checking in.',	'YesNo'),
('finesCalendar',	'noFinesWhenClosed',	'ignoreCalendar|noFinesWhenClosed',	'Specify whether to use the Calendar in calculating duedates and fines',	'Choice'),
('FinesIncludeGracePeriod',	'1',	NULL,	'If enabled, fines calculations will include the grace period.',	'YesNo'),
('FinesLog',	'1',	NULL,	'If ON, log fines',	'YesNo'),
('finesMode',	'test',	'off|test|production',	'Choose the fines mode, \'off\', \'test\' (emails admin report) or \'production\' (accrue overdue fines).  Requires accruefines cronjob.',	'Choice'),
('FrameworksLoaded',	'sysprefs.sql|subtag_registry.sql',	NULL,	'Frameworks loaded through webinstaller',	'choice'),
('FRBRizeEditions',	'0',	'',	'If ON, Koha will query one or more ISBN web services for associated ISBNs and display an Editions tab on the details pages',	'YesNo'),
('gist',	'0',	'',	'Default Goods and Services tax rate NOT in %, but in numeric form (0.12 for 12%), set to 0 to disable GST',	'Integer'),
('GoogleIndicTransliteration',	'0',	'',	'GoogleIndicTransliteration on the OPAC.',	'YesNo'),
('GoogleJackets',	'0',	NULL,	'if ON, displays jacket covers from Google Books API',	'YesNo'),
('hidelostitems',	'0',	'',	'If ON, disables display of\"lost\" items in OPAC.',	'YesNo'),
('HidePatronName',	'0',	'',	'If this is switched on, patron\'s cardnumber will be shown instead of their name on the holds and catalog screens',	'YesNo'),
('hide_marc',	'0',	NULL,	'If ON, disables display of MARC fields, subfield codes & indicators (still shows data)',	'YesNo'),
('HighlightOwnItemsOnOPAC',	'0',	'',	'If on, and a patron is logged into the OPAC, items from his or her home library will be emphasized and shown first in search results and item details.',	'YesNo'),
('HighlightOwnItemsOnOPACWhich',	'PatronBranch',	'PatronBranch|OpacURLBranch',	'Decides which branch\'s items to emphasize. If PatronBranch, emphasize the logged in user\'s library\'s items. If OpacURLBranch, highlight the items of the Apache var BRANCHCODE defined in Koha\'s Apache configuration file.',	'Choice'),
('HoldsToPullStartDate',	'2',	NULL,	'Set the default start date for the Holds to pull list to this many days ago',	'Integer'),
('HomeOrHoldingBranch',	'holdingbranch',	'holdingbranch|homebranch',	'Used by Circulation to determine which branch of an item to check with independent branches on, and by search to determine which branch to choose for availability ',	'Choice'),
('HomeOrHoldingBranchReturn',	'homebranch',	'holdingbranch|homebranch',	'Used by Circulation to determine which branch of an item to check checking-in items',	'Choice'),
('HTML5MediaEnabled',	'not',	'not|opac|staff|both',	'Show a tab with a HTML5 media player for files catalogued in field 856',	'Choice'),
('HTML5MediaExtensions',	'webm|ogg|ogv|oga|vtt',	'',	'Media file extensions',	'free'),
('IDreamBooksReadometer',	'0',	'',	'Display Readometer from IDreamBooks.com',	'YesNo'),
('IDreamBooksResults',	'0',	'',	'Display IDreamBooks.com rating in search results',	'YesNo'),
('IDreamBooksReviews',	'0',	'',	'Display book review snippets from IDreamBooks.com',	'YesNo'),
('ILS-DI',	'0',	'',	'Enables ILS-DI services at OPAC.',	'YesNo'),
('ILS-DI:AuthorizedIPs',	'',	'Restricts usage of ILS-DI to some IPs',	'.',	'Free'),
('ImageLimit',	'5',	'',	'Limit images stored in the database by the Patron Card image manager to this number.',	'Integer'),
('IncludeSeeFromInSearches',	'0',	'',	'Include see-from references in searches.',	'YesNo'),
('IndependentBranches',	'0',	NULL,	'If ON, increases security between libraries',	'YesNo'),
('InProcessingToShelvingCart',	'0',	'',	'If set, when any item with a location code of PROC is \'checked in\', it\'s location code will be changed to CART.',	'YesNo'),
('INTRAdidyoumean',	NULL,	NULL,	'Did you mean? configuration for the Intranet. Do not change, as this is controlled by /cgi-bin/koha/admin/didyoumean.pl.',	'Free'),
('IntranetBiblioDefaultView',	'normal',	'normal|marc|isbd|labeled_marc',	'Choose the default detail view in the staff interface; choose between normal, labeled_marc, marc or isbd',	'Choice'),
('intranetbookbag',	'1',	'',	'If ON, enables display of Cart feature in the intranet',	'YesNo'),
('intranetcolorstylesheet',	'',	'50',	'Define the color stylesheet to use in the Staff Client',	'free'),
('IntranetFavicon',	'',	'',	'Enter a complete URL to an image to replace the default Koha favicon on the Staff client',	'free'),
('IntranetmainUserblock',	'',	'70|10',	'Add a block of HTML that will display on the intranet home page',	'Textarea'),
('IntranetNav',	'',	'70|10',	'Use HTML tabs to add navigational links to the top-hand navigational bar in the Staff Client',	'Textarea'),
('IntranetNumbersPreferPhrase',	'0',	NULL,	'Control the use of phr operator in callnumber and standard number staff client searches',	'YesNo'),
('intranetreadinghistory',	'1',	'',	'If ON, Reading History is enabled for all patrons',	'YesNo'),
('IntranetSlipPrinterJS',	'',	'',	'Use this JavaScript for printing slips. Define at least function printThenClose(). For use e.g. with Firefox PlugIn jsPrintSetup, see http://jsprintsetup.mozdev.org/',	'Free'),
('intranetstylesheet',	'',	'50',	'Enter a complete URL to use an alternate layout stylesheet in Intranet',	'free'),
('IntranetUserCSS',	'',	NULL,	'Add CSS to be included in the intranet in an embedded <style> tag.',	'free'),
('intranetuserjs',	'',	'70|10',	'Custom javascript for inclusion in Intranet',	'Textarea'),
('intranet_includes',	'includes',	NULL,	'The includes directory you want for specific look of Koha (includes or includes_npl for example)',	'Free'),
('ISBD',	'#100||{ 100a }{ 100b }{ 100c }{ 100d }{ 110a }{ 110b }{ 110c }{ 110d }{ 110e }{ 110f }{ 110g }{ 130a }{ 130d }{ 130f }{ 130g }{ 130h }{ 130k }{ 130l }{ 130m }{ 130n }{ 130o }{ 130p }{ 130r }{ 130s }{ 130t }|<br/><br/>\r\n#245||{ 245a }{ 245b }{245f }{ 245g }{ 245k }{ 245n }{ 245p }{ 245s }{ 245h }|\r\n#246||{ : 246i }{ 246a }{ 246b }{ 246f }{ 246g }{ 246n }{ 246p }{ 246h }|\r\n#242||{ = 242a }{ 242b }{ 242n }{ 242p }{ 242h }|\r\n#245||{ 245c }|\r\n#242||{ = 242c }|\r\n#250| - |{ 250a }{ 250b }|\r\n#254|, |{ 254a }|\r\n#255|, |{ 255a }{ 255b }{ 255c }{ 255d }{ 255e }{ 255f }{ 255g }|\r\n#256|, |{ 256a }|\r\n#257|, |{ 257a }|\r\n#258|, |{ 258a }{ 258b }|\r\n#260| - |{ 260a }{ 260b }{ 260c }|\r\n#300| - |{ 300a }{ 300b }{ 300c }{ 300d }{ 300e }{ 300f }{ 300g }|\r\n#306| - |{ 306a }|\r\n#307| - |{ 307a }{ 307b }|\r\n#310| - |{ 310a }{ 310b }|\r\n#321| - |{ 321a }{ 321b }|\r\n#340| - |{ 3403 }{ 340a }{ 340b }{ 340c }{ 340d }{ 340e }{ 340f }{ 340h }{ 340i }|\r\n#342| - |{ 342a }{ 342b }{ 342c }{ 342d }{ 342e }{ 342f }{ 342g }{ 342h }{ 342i }{ 342j }{ 342k }{ 342l }{ 342m }{ 342n }{ 342o }{ 342p }{ 342q }{ 342r }{ 342s }{ 342t }{ 342u }{ 342v }{ 342w }|\r\n#343| - |{ 343a }{ 343b }{ 343c }{ 343d }{ 343e }{ 343f }{ 343g }{ 343h }{ 343i }|\r\n#351| - |{ 3513 }{ 351a }{ 351b }{ 351c }|\r\n#352| - |{ 352a }{ 352b }{ 352c }{ 352d }{ 352e }{ 352f }{ 352g }{ 352i }{ 352q }|\r\n#362| - |{ 362a }{ 351z }|\r\n#440| - |{ 440a }{ 440n }{ 440p }{ 440v }{ 440x }|.\r\n#490| - |{ 490a }{ 490v }{ 490x }|.\r\n#800| - |{ 800a }{ 800b }{ 800c }{ 800d }{ 800e }{ 800f }{ 800g }{ 800h }{ 800j }{ 800k }{ 800l }{ 800m }{ 800n }{ 800o }{ 800p }{ 800q }{ 800r }{ 800s }{ 800t }{ 800u }{ 800v }|.\r\n#810| - |{ 810a }{ 810b }{ 810c }{ 810d }{ 810e }{ 810f }{ 810g }{ 810h }{ 810k }{ 810l }{ 810m }{ 810n }{ 810o }{ 810p }{ 810r }{ 810s }{ 810t }{ 810u }{ 810v }|.\r\n#811| - |{ 811a }{ 811c }{ 811d }{ 811e }{ 811f }{ 811g }{ 811h }{ 811k }{ 811l }{ 811n }{ 811p }{ 811q }{ 811s }{ 811t }{ 811u }{ 811v }|.\r\n#830| - |{ 830a }{ 830d }{ 830f }{ 830g }{ 830h }{ 830k }{ 830l }{ 830m }{ 830n }{ 830o }{ 830p }{ 830r }{ 830s }{ 830t }{ 830v }|.\r\n#500|<br/><br/>|{ 5003 }{ 500a }|\r\n#501|<br/><br/>|{ 501a }|\r\n#502|<br/><br/>|{ 502a }|\r\n#504|<br/><br/>|{ 504a }|\r\n#505|<br/><br/>|{ 505a }{ 505t }{ 505r }{ 505g }{ 505u }|\r\n#506|<br/><br/>|{ 5063 }{ 506a }{ 506b }{ 506c }{ 506d }{ 506u }|\r\n#507|<br/><br/>|{ 507a }{ 507b }|\r\n#508|<br/><br/>|{ 508a }{ 508a }|\r\n#510|<br/><br/>|{ 5103 }{ 510a }{ 510x }{ 510c }{ 510b }|\r\n#511|<br/><br/>|{ 511a }|\r\n#513|<br/><br/>|{ 513a }{513b }|\r\n#514|<br/><br/>|{ 514z }{ 514a }{ 514b }{ 514c }{ 514d }{ 514e }{ 514f }{ 514g }{ 514h }{ 514i }{ 514j }{ 514k }{ 514m }{ 514u }|\r\n#515|<br/><br/>|{ 515a }|\r\n#516|<br/><br/>|{ 516a }|\r\n#518|<br/><br/>|{ 5183 }{ 518a }|\r\n#520|<br/><br/>|{ 5203 }{ 520a }{ 520b }{ 520u }|\r\n#521|<br/><br/>|{ 5213 }{ 521a }{ 521b }|\r\n#522|<br/><br/>|{ 522a }|\r\n#524|<br/><br/>|{ 524a }|\r\n#525|<br/><br/>|{ 525a }|\r\n#526|<br/><br/>|{\\n510i }{\\n510a }{ 510b }{ 510c }{ 510d }{\\n510x }|\r\n#530|<br/><br/>|{\\n5063 }{\\n506a }{ 506b }{ 506c }{ 506d }{\\n506u }|\r\n#533|<br/><br/>|{\\n5333 }{\\n533a }{\\n533b }{\\n533c }{\\n533d }{\\n533e }{\\n533f }{\\n533m }{\\n533n }|\r\n#534|<br/><br/>|{\\n533p }{\\n533a }{\\n533b }{\\n533c }{\\n533d }{\\n533e }{\\n533f }{\\n533m }{\\n533n }{\\n533t }{\\n533x }{\\n533z }|\r\n#535|<br/><br/>|{\\n5353 }{\\n535a }{\\n535b }{\\n535c }{\\n535d }|\r\n#538|<br/><br/>|{\\n5383 }{\\n538a }{\\n538i }{\\n538u }|\r\n#540|<br/><br/>|{\\n5403 }{\\n540a }{ 540b }{ 540c }{ 540d }{\\n520u }|\r\n#544|<br/><br/>|{\\n5443 }{\\n544a }{\\n544b }{\\n544c }{\\n544d }{\\n544e }{\\n544n }|\r\n#545|<br/><br/>|{\\n545a }{ 545b }{\\n545u }|\r\n#546|<br/><br/>|{\\n5463 }{\\n546a }{ 546b }|\r\n#547|<br/><br/>|{\\n547a }|\r\n#550|<br/><br/>|{ 550a }|\r\n#552|<br/><br/>|{ 552z }{ 552a }{ 552b }{ 552c }{ 552d }{ 552e }{ 552f }{ 552g }{ 552h }{ 552i }{ 552j }{ 552k }{ 552l }{ 552m }{ 552n }{ 562o }{ 552p }{ 552u }|\r\n#555|<br/><br/>|{ 5553 }{ 555a }{ 555b }{ 555c }{ 555d }{ 555u }|\r\n#556|<br/><br/>|{ 556a }{ 506z }|\r\n#563|<br/><br/>|{ 5633 }{ 563a }{ 563u }|\r\n#565|<br/><br/>|{ 5653 }{ 565a }{ 565b }{ 565c }{ 565d }{ 565e }|\r\n#567|<br/><br/>|{ 567a }|\r\n#580|<br/><br/>|{ 580a }|\r\n#581|<br/><br/>|{ 5633 }{ 581a }{ 581z }|\r\n#584|<br/><br/>|{ 5843 }{ 584a }{ 584b }|\r\n#585|<br/><br/>|{ 5853 }{ 585a }|\r\n#586|<br/><br/>|{ 5863 }{ 586a }|\r\n#020|<br/><br/><label>ISBN: </label>|{ 020a }{ 020c }|\r\n#022|<br/><br/><label>ISSN: </label>|{ 022a }|\r\n#222| = |{ 222a }{ 222b }|\r\n#210| = |{ 210a }{ 210b }|\r\n#024|<br/><br/><label>Standard No.: </label>|{ 024a }{ 024c }{ 024d }{ 0242 }|\r\n#027|<br/><br/><label>Standard Tech. Report. No.: </label>|{ 027a }|\r\n#028|<br/><br/><label>Publisher. No.: </label>|{ 028a }{ 028b }|\r\n#013|<br/><br/><label>Patent No.: </label>|{ 013a }{ 013b }{ 013c }{ 013d }{ 013e }{ 013f }|\r\n#030|<br/><br/><label>CODEN: </label>|{ 030a }|\r\n#037|<br/><br/><label>Source: </label>|{ 037a }{ 037b }{ 037c }{ 037f }{ 037g }{ 037n }|\r\n#010|<br/><br/><label>LCCN: </label>|{ 010a }|\r\n#015|<br/><br/><label>Nat. Bib. No.: </label>|{ 015a }{ 0152 }|\r\n#016|<br/><br/><label>Nat. Bib. Agency Control No.: </label>|{ 016a }{ 0162 }|\r\n#600|<br/><br/><label>Subjects--Personal Names: </label>|{\\n6003 }{\\n600a}{ 600b }{ 600c }{ 600d }{ 600e }{ 600f }{ 600g }{ 600h }{--600k}{ 600l }{ 600m }{ 600n }{ 600o }{--600p}{ 600r }{ 600s }{ 600t }{ 600u }{--600x}{--600z}{--600y}{--600v}|\r\n#610|<br/><br/><label>Subjects--Corporate Names: </label>|{\\n6103 }{\\n610a}{ 610b }{ 610c }{ 610d }{ 610e }{ 610f }{ 610g }{ 610h }{--610k}{ 610l }{ 610m }{ 610n }{ 610o }{--610p}{ 610r }{ 610s }{ 610t }{ 610u }{--610x}{--610z}{--610y}{--610v}|\r\n#611|<br/><br/><label>Subjects--Meeting Names: </label>|{\\n6113 }{\\n611a}{ 611b }{ 611c }{ 611d }{ 611e }{ 611f }{ 611g }{ 611h }{--611k}{ 611l }{ 611m }{ 611n }{ 611o }{--611p}{ 611r }{ 611s }{ 611t }{ 611u }{--611x}{--611z}{--611y}{--611v}|\r\n#630|<br/><br/><label>Subjects--Uniform Titles: </label>|{\\n630a}{ 630b }{ 630c }{ 630d }{ 630e }{ 630f }{ 630g }{ 630h }{--630k }{ 630l }{ 630m }{ 630n }{ 630o }{--630p}{ 630r }{ 630s }{ 630t }{--630x}{--630z}{--630y}{--630v}|\r\n#648|<br/><br/><label>Subjects--Chronological Terms: </label>|{\\n6483 }{\\n648a }{--648x}{--648z}{--648y}{--648v}|\r\n#650|<br/><br/><label>Subjects--Topical Terms: </label>|{\\n6503 }{\\n650a}{ 650b }{ 650c }{ 650d }{ 650e }{--650x}{--650z}{--650y}{--650v}|\r\n#651|<br/><br/><label>Subjects--Geographic Terms: </label>|{\\n6513 }{\\n651a}{ 651b }{ 651c }{ 651d }{ 651e }{--651x}{--651z}{--651y}{--651v}|\r\n#653|<br/><br/><label>Subjects--Index Terms: </label>|{ 653a }|\r\n#654|<br/><br/><label>Subjects--Facted Index Terms: </label>|{\\n6543 }{\\n654a}{--654b}{--654x}{--654z}{--654y}{--654v}|\r\n#655|<br/><br/><label>Index Terms--Genre/Form: </label>|{\\n6553 }{\\n655a}{--655b}{--655x }{--655z}{--655y}{--655v}|\r\n#656|<br/><br/><label>Index Terms--Occupation: </label>|{\\n6563 }{\\n656a}{--656k}{--656x}{--656z}{--656y}{--656v}|\r\n#657|<br/><br/><label>Index Terms--Function: </label>|{\\n6573 }{\\n657a}{--657x}{--657z}{--657y}{--657v}|\r\n#658|<br/><br/><label>Index Terms--Curriculum Objective: </label>|{\\n658a}{--658b}{--658c}{--658d}{--658v}|\r\n#050|<br/><br/><label>LC Class. No.: </label>|{ 050a }{ / 050b }|\r\n#082|<br/><br/><label>Dewey Class. No.: </label>|{ 082a }{ / 082b }|\r\n#080|<br/><br/><label>Universal Decimal Class. No.: </label>|{ 080a }{ 080x }{ / 080b }|\r\n#070|<br/><br/><label>National Agricultural Library Call No.: </label>|{ 070a }{ / 070b }|\r\n#060|<br/><br/><label>National Library of Medicine Call No.: </label>|{ 060a }{ / 060b }|\r\n#074|<br/><br/><label>GPO Item No.: </label>|{ 074a }|\r\n#086|<br/><br/><label>Gov. Doc. Class. No.: </label>|{ 086a }|\r\n#088|<br/><br/><label>Report. No.: </label>|{ 088a }|',	'70|10',	'ISBD',	'Textarea'),
('IssueLog',	'1',	NULL,	'If ON, log checkout activity',	'YesNo'),
('IssueLostItem',	'alert',	'Defines what should be done when an attempt is made to issue an item that has been marked as lost.',	'alert|confirm|nothing',	'Choice'),
('IssuingInProcess',	'0',	NULL,	'If ON, disables fines if the patron is issuing item that accumulate debt',	'YesNo'),
('item-level_itypes',	'1',	'',	'If ON, enables Item-level Itemtype / Issuing Rules',	'YesNo'),
('itemBarcodeFallbackSearch',	'',	NULL,	'If set, uses scanned item barcodes as a catalogue search if not found as barcodes',	'YesNo'),
('itemBarcodeInputFilter',	'',	'whitespace|T-prefix|cuecat|libsuite8|EAN13',	'If set, allows specification of a item barcode input filter',	'Choice'),
('itemcallnumber',	'082ab',	NULL,	'The MARC field/subfield that is used to calculate the itemcallnumber (Dewey would be 082ab or 092ab; LOC would be 050ab or 090ab) could be 852hi from an item record',	'free'),
('KohaAdminEmailAddress',	'root@localhost',	'',	'Define the email address where patron modification requests are sent',	'free'),
('LabelMARCView',	'standard',	'standard|economical',	'Define how a MARC record will display',	'Choice'),
('language',	'en',	NULL,	'Set the default language in the staff client.',	'Languages'),
('LetterLog',	'1',	NULL,	'If ON, log all notices sent',	'YesNo'),
('LibraryName',	'',	'',	'Define the library name as displayed on the OPAC',	''),
('LibraryThingForLibrariesEnabled',	'0',	'',	'Enable or Disable Library Thing for Libraries Features',	'YesNo'),
('LibraryThingForLibrariesID',	'',	'',	'See:http://librarything.com/forlibraries/',	'free'),
('LibraryThingForLibrariesTabbedView',	'0',	'',	'Put LibraryThingForLibraries Content in Tabs.',	'YesNo'),
('LinkerKeepStale',	'0',	NULL,	'If ON the authority linker will keep existing authority links for headings where it is unable to find a match.',	'YesNo'),
('LinkerModule',	'Default',	'Default|FirstMatch|LastMatch',	'Chooses which linker module to use (see documentation).',	'Choice'),
('LinkerOptions',	'',	'',	'A pipe-separated list of options for the linker.',	'free'),
('LinkerRelink',	'1',	NULL,	'If ON the authority linker will relink headings that have previously been linked every time it runs.',	'YesNo'),
('LocalCoverImages',	'0',	'1',	'Display local cover images on intranet details pages.',	'YesNo'),
('LocalHoldsPriority',	'0',	NULL,	'Enables the LocalHoldsPriority feature',	'YesNo'),
('LocalHoldsPriorityItemControl',	'holdingbranch',	'holdingbranch|homebranch',	'decides if the feature operates using the item\'s home or holding library.',	'Choice'),
('LocalHoldsPriorityPatronControl',	'PickupLibrary',	'HomeLibrary|PickupLibrary',	'decides if the feature operates using the library set as the patron\'s home library, or the library set as the pickup library for the given hold.',	'Choice'),
('ManInvInNoissuesCharge',	'1',	NULL,	'MANUAL_INV charges block checkouts (added to noissuescharge).',	'YesNo'),
('MARCAuthorityControlField008',	'|| aca||aabn           | a|a     d',	NULL,	'Define the contents of MARC21 authority control field 008 position 06-39',	'Textarea'),
('MarcFieldsToOrder',	'',	NULL,	'Set the mapping values for a new order line created from a MARC record in a staged file. In a YAML format.',	'textarea'),
('marcflavour',	'MARC21',	'MARC21|UNIMARC|NORMARC',	'Define global MARC flavor (MARC21, UNIMARC or NORMARC) used for character encoding',	'Choice'),
('MARCOrgCode',	'OSt',	'',	'Define MARC Organization Code for MARC21 records - http://www.loc.gov/marc/organizations/orgshome.html',	'free'),
('MaxFine',	NULL,	'',	'Maximum fine a patron can have for all late returns at one moment. Single item caps are specified in the circulation rules matrix.',	'Integer'),
('MaxItemsForBatch',	'1000',	NULL,	'Max number of items record to process in a batch (modification or deletion)',	'Integer'),
('maxItemsInSearchResults',	'20',	NULL,	'Specify the maximum number of items to display for each result on a page of results',	'free'),
('maxoutstanding',	'5',	'',	'maximum amount withstanding to be able make holds',	'Integer'),
('maxRecordsForFacets',	'20',	NULL,	NULL,	'Integer'),
('maxreserves',	'50',	'',	'Define maximum number of holds a patron can place',	'Integer'),
('minPasswordLength',	'3',	NULL,	'Specify the minimum length of a patron/staff password',	'free'),
('NewItemsDefaultLocation',	'',	'',	'If set, all new items will have a location of the given Location Code ( Authorized Value type LOC )',	''),
('noissuescharge',	'5',	'',	'Define maximum amount withstanding before check outs are blocked',	'Integer'),
('noItemTypeImages',	'0',	NULL,	'If ON, disables item-type images',	'YesNo'),
('NoLoginInstructions',	'',	'60|10',	'Instructions to display on the OPAC login form when a patron is not logged in',	'Textarea'),
('NorwegianPatronDBEnable',	'0',	NULL,	'Enable communication with the Norwegian national patron database.',	'YesNo'),
('NorwegianPatronDBEndpoint',	'',	NULL,	'Which NL endpoint to use.',	'Free'),
('NorwegianPatronDBPassword',	'',	NULL,	'Password for communication with the Norwegian national patron database.',	'Free'),
('NorwegianPatronDBSearchNLAfterLocalHit',	'0',	NULL,	'Search NL if a search has already given one or more local hits?.',	'YesNo'),
('NorwegianPatronDBUsername',	'',	NULL,	'Username for communication with the Norwegian national patron database.',	'Free'),
('NotesBlacklist',	'',	NULL,	'List of notes fields that should not appear in the title notes/description separator of details',	'free'),
('NotHighlightedWords',	'and|or|not',	NULL,	'List of words to NOT highlight when OpacHitHighlight is enabled',	'free'),
('NoticeCSS',	'',	NULL,	'Notices CSS url.',	'free'),
('NotifyBorrowerDeparture',	'30',	NULL,	'Define number of days before expiry where circulation is warned about patron account expiry',	'Integer'),
('NovelistSelectEnabled',	'0',	NULL,	'Enable Novelist Select content.  Requires Novelist Profile and Password',	'YesNo'),
('NovelistSelectPassword',	NULL,	NULL,	'Enable Novelist user Profile',	'free'),
('NovelistSelectProfile',	NULL,	NULL,	'Novelist Select user Password',	'free'),
('NovelistSelectView',	'tab',	'tab|above|below|right',	'Where to display Novelist Select content',	'Choice'),
('numReturnedItemsToShow',	'20',	NULL,	'Number of returned items to show on the check-in page',	'Integer'),
('numSearchResults',	'20',	NULL,	'Specify the maximum number of results to display on a page of results',	'Integer'),
('numSearchRSSResults',	'50',	NULL,	'Specify the maximum number of results to display on a RSS page of results',	'Integer'),
('OAI-PMH',	'0',	NULL,	'if ON, OAI-PMH server is enabled',	'YesNo'),
('OAI-PMH:archiveID',	'KOHA-OAI-TEST',	NULL,	'OAI-PMH archive identification',	'Free'),
('OAI-PMH:AutoUpdateSets',	'0',	'',	'Automatically update OAI sets when a bibliographic record is created or updated',	'YesNo'),
('OAI-PMH:ConfFile',	'',	NULL,	'If empty, Koha OAI Server operates in normal mode, otherwise it operates in extended mode.',	'File'),
('OAI-PMH:MaxCount',	'50',	NULL,	'OAI-PMH maximum number of records by answer to ListRecords and ListIdentifiers queries',	'Integer'),
('OCLCAffiliateID',	'',	'',	'Use with FRBRizeEditions and XISBN. You can sign up for an AffiliateID here: http://www.worldcat.org/wcpa/do/AffiliateUserServices?method=initSelfRegister',	'free'),
('OnSiteCheckouts',	'0',	'',	'Enable/Disable the on-site checkouts feature',	'YesNo'),
('OnSiteCheckoutsForce',	'0',	'',	'Enable/Disable the on-site for all cases (Even if a user is debarred, etc.)',	'YesNo'),
('OPACAcquisitionDetails',	'0',	'',	'Show the acquisition details at the OPAC',	'YesNo'),
('OpacAddMastheadLibraryPulldown',	'0',	'',	'Adds a pulldown menu to select the library to search on the opac masthead.',	'YesNo'),
('OpacAdvSearchMoreOptions',	'pubdate,itemtype,language,subtype,sorting,location',	'Show search options for the expanded view (More options)',	'pubdate|itemtype|language|subtype|sorting|location',	'multiple'),
('OpacAdvSearchOptions',	'pubdate,itemtype,language,sorting,location',	'Show search options',	'pubdate|itemtype|language|subtype|sorting|location',	'multiple'),
('OPACAllowHoldDateInFuture',	'0',	'',	'If set, along with the AllowHoldDateInFuture system preference, OPAC users can set the date of a hold to be in the future.',	'YesNo'),
('OpacAllowPublicListCreation',	'1',	NULL,	'If set, allows opac users to create public lists',	'YesNo'),
('OpacAllowSharingPrivateLists',	'0',	NULL,	'If set, allows opac users to share private lists with other patrons',	'YesNo'),
('OPACAllowUserToChooseBranch',	'1',	'1',	'Allow the user to choose the branch they want to pickup their hold from',	'YesNo'),
('OPACAmazonCoverImages',	'0',	'',	'Display cover images on OPAC from Amazon Web Services',	'YesNo'),
('OpacAuthorities',	'1',	NULL,	'If ON, enables the search authorities link on OPAC',	'YesNo'),
('OPACBaseURL',	NULL,	NULL,	'Specify the Base URL of the OPAC, e.g., opac.mylibrary.com, the http:// will be added automatically by Koha.',	'Free'),
('opacbookbag',	'1',	'',	'If ON, enables display of Cart feature',	'YesNo'),
('OpacBrowser',	'0',	NULL,	'If ON, enables subject authorities browser on OPAC (needs to set misc/cronjob/sbuild_browser_and_cloud.pl)',	'YesNo'),
('OpacBrowseResults',	'1',	NULL,	'Disable/enable browsing and paging search results from the OPAC detail page.',	'YesNo'),
('OpacCloud',	'0',	NULL,	'If ON, enables subject cloud on OPAC',	'YesNo'),
('opaccolorstylesheet',	'',	'',	'Define an auxiliary stylesheet for OPAC use, to override specified settings from the primary opac.css stylesheet. Enter the filename (if the file is in the server\'s css directory) or a complete URL beginning with http (if the file lives on a remote server).',	'free'),
('opaccredits',	'',	'70|10',	'Define HTML Credits at the bottom of the OPAC page',	'Textarea'),
('OpacCustomSearch',	'',	'70|10',	'Replace the search box on the OPAC with the provided HTML',	'Textarea'),
('OPACdefaultSortField',	'relevance',	'relevance|popularity|call_number|pubdate|acqdate|title|author',	'Specify the default field used for sorting',	'Choice'),
('OPACdefaultSortOrder',	'dsc',	'asc|dsc|za|az',	'Specify the default sort order',	'Choice'),
('OPACdidyoumean',	NULL,	NULL,	'Did you mean? configuration for the OPAC. Do not change, as this is controlled by /cgi-bin/koha/admin/didyoumean.pl.',	'Free'),
('OPACDisplay856uAsImage',	'OFF',	'OFF|Details|Results|Both',	'Display the URI in the 856u field as an image, the corresponding OPACXSLT option must be on',	'Choice'),
('OpacExportOptions',	'bibtex|dc|marcxml|marc8|utf8|marcstd|mods|ris',	'',	'Define export options available on OPAC detail page.',	'free'),
('OPACFallback',	'prog',	'bootstrap|prog',	'Define the fallback theme for the OPAC interface.',	'Themes'),
('OpacFavicon',	'',	'',	'Enter a complete URL to an image to replace the default Koha favicon on the OPAC',	'free'),
('OPACFineNoRenewals',	'100',	'',	'Fine limit above which user cannot renew books via OPAC',	'Integer'),
('OPACFinesTab',	'1',	'',	'If OFF the patron fines tab in the OPAC is disabled.',	'YesNo'),
('OPACFRBRizeEditions',	'0',	'',	'If ON, the OPAC will query one or more ISBN web services for associated ISBNs and display an Editions tab on the details pages',	'YesNo'),
('opacheader',	'',	'70|10',	'Add HTML to be included as a custom header in the OPAC',	'Textarea'),
('OpacHiddenItems',	'',	'',	'This syspref allows to define custom rules for hiding specific items at opac. See docs/opac/OpacHiddenItems.txt for more informations.',	'Textarea'),
('OpacHighlightedWords',	'1',	'',	'If Set, then queried words are higlighted in OPAC',	'YesNo'),
('OpacHoldNotes',	'0',	'',	'Show hold notes on OPAC',	'YesNo'),
('OPACItemHolds',	'1',	'0|1|force',	'Allow OPAC users to place hold on specific items. If No, users can only request next available copy. If Yes, users can choose between next available and specific copy. If Force, users *must* choose a specific copy.',	'Choice'),
('OpacItemLocation',	'callnum',	'callnum|ccode|location',	'Show the shelving location of items in the opac',	'Choice'),
('OPACItemsResultsDisplay',	'0',	'',	'If OFF : show only the status of items in result list.If ON : show full location of items (branch+location+callnumber) as in staff interface',	'YesNo'),
('OpacKohaUrl',	'1',	NULL,	'Show \'Powered by Koha\' text on OPAC footer.',	NULL),
('opaclanguages',	'en',	NULL,	'Set the default language in the OPAC.',	'Languages'),
('opaclanguagesdisplay',	'0',	'',	'If ON, enables display of Change Language feature on OPAC',	'YesNo'),
('opaclayoutstylesheet',	'opac.css',	'',	'Enter the name of the layout CSS stylesheet to use in the OPAC',	'free'),
('OPACLocalCoverImages',	'0',	'1',	'Display local cover images on OPAC search and details pages.',	'YesNo'),
('OpacLocationBranchToDisplay',	'holding',	'holding|home|both',	'In the OPAC, under location show which branch for Location in the record details.',	'Choice'),
('OpacLocationBranchToDisplayShelving',	'holding',	'holding|home|both',	'In the OPAC, display the shelving location under which which column.',	'Choice'),
('OpacMaintenance',	'0',	'',	'If ON, enables maintenance warning in OPAC',	'YesNo'),
('OpacMainUserBlock',	'Welcome to Koha...\r\n<hr>',	'70|10',	'A user-defined block of HTML  in the main content area of the opac main page',	'Textarea'),
('OpacMaxItemsToDisplay',	'50',	'',	'Max items to display at the OPAC on a biblio detail',	'Integer'),
('OPACMySummaryHTML',	'',	'70|10',	'Enter the HTML that will appear in a column on the \'my summary\' and \'my reading history\' tabs when a user is logged in to the OPAC. Enter {BIBLIONUMBER}, {TITLE}, {AUTHOR}, or {ISBN} in place of their respective variables in the HTML. Leave blank to disable.',	'Textarea'),
('OPACMySummaryNote',	'',	'',	'Note to display on the patron summary page. This note only appears if the patron is connected.',	'Free'),
('OpacNav',	'Important links here.',	'70|10',	'Use HTML tags to add navigational links to the left-hand navigational bar in OPAC',	'Textarea'),
('OpacNavBottom',	'Important links here.',	'70|10',	'Use HTML tags to add navigational links to the left-hand navigational bar in OPAC',	'Textarea'),
('OpacNavRight',	'',	'70|10',	'Show the following HTML in the right hand column of the main page under the main login form',	'Textarea'),
('OPACNoResultsFound',	'',	'70|10',	'Display this HTML when no results are found for a search in the OPAC',	'Textarea'),
('OPACNumbersPreferPhrase',	'0',	NULL,	'Control the use of phr operator in callnumber and standard number OPAC searches',	'YesNo'),
('OPACnumSearchResults',	'20',	NULL,	'Specify the maximum number of results to display on a page of results',	'Integer'),
('OpacPasswordChange',	'1',	NULL,	'If ON, enables patron-initiated password change in OPAC (disable it when using LDAP auth)',	'YesNo'),
('OPACPatronDetails',	'1',	'',	'If OFF the patron details tab in the OPAC is disabled.',	'YesNo'),
('OPACpatronimages',	'0',	NULL,	'Enable patron images in the OPAC',	'YesNo'),
('OpacPrivacy',	'0',	NULL,	'if ON, allows patrons to define their privacy rules (reading history)',	'YesNo'),
('OpacPublic',	'1',	NULL,	'Turn on/off public OPAC',	'YesNo'),
('opacreadinghistory',	'1',	'',	'If ON, enables display of Patron Circulation History in OPAC',	'YesNo'),
('OpacRenewalAllowed',	'0',	NULL,	'If ON, users can renew their issues directly from their OPAC account',	'YesNo'),
('OpacRenewalBranch',	'checkoutbranch',	'itemhomebranch|patronhomebranch|checkoutbranch|null',	'Choose how the branch for an OPAC renewal is recorded in statistics',	'Choice'),
('OPACResultsSidebar',	'',	'70|10',	'Define HTML to be included on the search results page, underneath the facets sidebar',	'Textarea'),
('OPACSearchForTitleIn',	'<li><a  href=\"http://worldcat.org/search?q={TITLE}\" target=\"_blank\">Other Libraries (WorldCat)</a></li>\n<li><a href=\"http://www.scholar.google.com/scholar?q={TITLE}\" target=\"_blank\">Other Databases (Google Scholar)</a></li>\n<li><a href=\"http://www.bookfinder.com/search/?author={AUTHOR}&amp;title={TITLE}&amp;st=xl&amp;ac=qr\" target=\"_blank\">Online Stores (Bookfinder.com)</a></li>\n<li><a href=\"http://openlibrary.org/search/?author=({AUTHOR})&title=({TITLE})\" target=\"_blank\">Open Library (openlibrary.org)</a></li>',	'70|10',	'Enter the HTML that will appear in the \'Search for this title in\' box on the detail page in the OPAC.  Enter {TITLE}, {AUTHOR}, or {ISBN} in place of their respective variables in the URL. Leave blank to disable \'More Searches\' menu.',	'Textarea'),
('OpacSeparateHoldings',	'0',	NULL,	'Separate current branch holdings from other holdings (OPAC)',	'YesNo'),
('OpacSeparateHoldingsBranch',	'homebranch',	'homebranch|holdingbranch',	'Branch used to separate holdings (OPAC)',	'Choice'),
('opacSerialDefaultTab',	'subscriptions',	'holdings|serialcollection|subscriptions',	'Define the default tab for serials in OPAC.',	'Choice'),
('OPACSerialIssueDisplayCount',	'3',	'',	'Number of serial issues to display per subscription in the OPAC',	'Integer'),
('OPACShelfBrowser',	'1',	'',	'Enable/disable Shelf Browser on item details page. WARNING: this feature is very resource consuming on collections with large numbers of items.',	'YesNo'),
('OPACShowBarcode',	'0',	'',	'Show items barcode in holding tab',	'YesNo'),
('OPACShowCheckoutName',	'0',	'',	'Displays in the OPAC the name of patron who has checked out the material. WARNING: Most sites should leave this off. It is intended for corporate or special sites which need to track who has the item.',	'YesNo'),
('OPACShowHoldQueueDetails',	'none',	'none|priority|holds|holds_priority',	'Show holds details in OPAC',	'Choice'),
('OpacShowRecentComments',	'0',	NULL,	'If ON a link to recent comments will appear in the OPAC masthead',	'YesNo'),
('OPACShowUnusedAuthorities',	'1',	'',	'Show authorities that are not being used in the OPAC.',	'YesNo'),
('OpacStarRatings',	'all',	'disable|all|details',	NULL,	'Choice'),
('OpacSuggestionManagedBy',	'1',	'',	'Show the name of the staff member who managed a suggestion in OPAC',	'YesNo'),
('OpacSuppression',	'0',	'',	'Turn ON the OPAC Suppression feature, requires further setup, ask your system administrator for details',	'YesNo'),
('OpacSuppressionByIPRange',	'',	'',	'Restrict the suppression to IP adresses outside of the IP range',	'free'),
('OpacSuppressionMessage',	'',	'Display this message on the redirect page for suppressed biblios',	'70|10',	'Textarea'),
('OpacSuppressionRedirect',	'1',	'Redirect the opac detail page for suppressed records to an explanatory page (otherwise redirect to 404 error page)',	'',	'YesNo'),
('opacthemes',	'bootstrap',	'',	'Define the current theme for the OPAC interface.',	'Themes'),
('OpacTopissue',	'0',	NULL,	'If ON, enables the \'most popular items\' link on OPAC. Warning, this is an EXPERIMENTAL feature, turning ON may overload your server',	'YesNo'),
('OPACURLOpenInNewWindow',	'0',	NULL,	'If ON, URLs in the OPAC open in a new window',	'YesNo'),
('OPACUserCSS',	'',	NULL,	'Add CSS to be included in the OPAC in an embedded <style> tag.',	'free'),
('opacuserjs',	'',	'70|10',	'Define custom javascript for inclusion in OPAC',	'Textarea'),
('opacuserlogin',	'1',	NULL,	'Enable or disable display of user login features',	'YesNo'),
('OPACViewOthersSuggestions',	'0',	NULL,	'If ON, allows all suggestions to be displayed in the OPAC',	'YesNo'),
('OPACXSLTDetailsDisplay',	'default',	'',	'Enable XSL stylesheet control over details page display on OPAC',	'Free'),
('OPACXSLTResultsDisplay',	'default',	'',	'Enable XSL stylesheet control over results page display on OPAC',	'Free'),
('OpenLibraryCovers',	'0',	NULL,	'If ON Openlibrary book covers will be show',	'YesNo'),
('OrderPdfFormat',	'pdfformat::layout3pages',	'Controls what script is used for printing (basketgroups)',	'',	'free'),
('OverDriveClientKey',	'',	'Client key for OverDrive integration',	'30',	'Free'),
('OverDriveClientSecret',	'',	'Client key for OverDrive integration',	'30',	'YesNo'),
('OverDriveLibraryID',	'',	'Library ID for OverDrive integration',	'',	'Integer'),
('OverdueNoticeBcc',	'',	'',	'Email address to bcc outgoing overdue notices sent by email',	'free'),
('OverdueNoticeCalendar',	'0',	NULL,	'Take the calendar into consideration when generating overdue notices',	'YesNo'),
('OverduesBlockCirc',	'noblock',	'noblock|confirmation|block',	'When checking out an item should overdues block checkout, generate a confirmation dialogue, or allow checkout',	'Choice'),
('patronimages',	'0',	NULL,	'Enable patron images for the Staff Client',	'YesNo'),
('PatronSelfRegistration',	'0',	NULL,	'If enabled, patrons will be able to register themselves via the OPAC.',	'YesNo'),
('PatronSelfRegistrationAdditionalInstructions',	'',	'',	'A free text field to display additional instructions to newly self registered patrons.',	'free'),
('PatronSelfRegistrationBorrowerMandatoryField',	'surname|firstname',	NULL,	'Choose the mandatory fields for a patron\'s account, when registering via the OPAC.',	'free'),
('PatronSelfRegistrationBorrowerUnwantedField',	'',	NULL,	'Name the fields you don\'t want to display when registering a new patron via the OPAC.',	'free'),
('PatronSelfRegistrationDefaultCategory',	'',	'',	'A patron registered via the OPAC will receive a borrower category code set in this system preference.',	'free'),
('PatronSelfRegistrationExpireTemporaryAccountsDelay',	'0',	NULL,	'If PatronSelfRegistrationDefaultCategory is enabled, this system preference controls how long a patron can have a temporary status before the account is deleted automatically. It is an integer value representing a number of days to wait before deleting a temporary patron account. Setting it to 0 disables the deleting of temporary accounts.',	'Integer'),
('PatronSelfRegistrationVerifyByEmail',	'0',	NULL,	'If enabled, any patron attempting to register themselves via the OPAC will be required to verify themselves via email to activate his or her account.',	'YesNo'),
('PatronsPerPage',	'20',	'20',	'Number of Patrons Per Page displayed by default',	'Integer'),
('Persona',	'0',	'',	'Use Mozilla Persona for login',	'YesNo'),
('PrefillItem',	'0',	'',	'When a new item is added, should it be prefilled with last created item values?',	'YesNo'),
('previousIssuesDefaultSortOrder',	'asc',	'asc|desc',	'Specify the sort order of Previous Issues on the circulation page',	'Choice'),
('printcirculationslips',	'1',	'',	'If ON, enable printing circulation receipts',	'YesNo'),
('PrintNoticesMaxLines',	'0',	'',	'If greater than 0, sets the maximum number of lines an overdue notice will print. If the number of items is greater than this number, the notice will end with a warning asking the borrower to check their online account for a full list of overdue items.',	'Integer'),
('QueryAutoTruncate',	'1',	NULL,	'If ON, query truncation is enabled by default',	'YesNo'),
('QueryFuzzy',	'1',	NULL,	'If ON, enables fuzzy option for searches',	'YesNo'),
('QueryStemming',	'1',	NULL,	'If ON, enables query stemming',	'YesNo'),
('QueryWeightFields',	'1',	NULL,	'If ON, enables field weighting',	'YesNo'),
('QuoteOfTheDay',	'0',	NULL,	'Enable or disable display of Quote of the Day on the OPAC home page',	'YesNo'),
('RandomizeHoldsQueueWeight',	'0',	NULL,	'if ON, the holds queue in circulation will be randomized, either based on all location codes, or by the location codes specified in StaticHoldsQueueWeight',	'YesNo'),
('RecordLocalUseOnReturn',	'0',	NULL,	'If ON, statistically record returns of unissued items as local use, instead of return',	'YesNo'),
('RefundLostItemFeeOnReturn',	'1',	NULL,	'If enabled, the lost item fee charged to a borrower will be refunded when the lost item is returned.',	'YesNo'),
('RenewalPeriodBase',	'date_due',	'date_due|now',	'Set whether the renewal date should be counted from the date_due or from the moment the Patron asks for renewal ',	'Choice'),
('RenewalSendNotice',	'0',	'',	NULL,	'YesNo'),
('RenewSerialAddsSuggestion',	'0',	NULL,	'If ON, adds a new suggestion at serial subscription renewal',	'YesNo'),
('RentalFeesCheckoutConfirmation',	'0',	NULL,	'Allow user to confirm when checking out an item with rental fees.',	'YesNo'),
('RentalsInNoissuesCharge',	'1',	NULL,	'Rental charges block checkouts (added to noissuescharge).',	'YesNo'),
('RequestOnOpac',	'1',	NULL,	'If ON, globally enables patron holds on OPAC',	'YesNo'),
('ReservesControlBranch',	'PatronLibrary',	'ItemHomeLibrary|PatronLibrary',	'Branch checked for members reservations rights',	'Choice'),
('ReservesMaxPickUpDelay',	'7',	'',	'Define the Maximum delay to pick up an item on hold',	'Integer'),
('ReservesNeedReturns',	'1',	'',	'If ON, a hold placed on an item available in this library must be checked-in, otherwise, a hold on a specific item, that is in the library & available is considered available',	'YesNo'),
('ReturnBeforeExpiry',	'0',	NULL,	'If ON, checkout will be prevented if returndate is after patron card expiry',	'YesNo'),
('ReturnLog',	'1',	NULL,	'If ON, enables the circulation (returns) log',	'YesNo'),
('ReturnToShelvingCart',	'0',	'',	'If set, when any item is \'checked in\', it\'s location code will be changed to CART.',	'YesNo'),
('reviewson',	'1',	'',	'If ON, enables patron reviews of bibliographic records in the OPAC',	'YesNo'),
('RoutingListAddReserves',	'1',	'',	'If ON the patrons on routing lists are automatically added to holds on the issue.',	'YesNo'),
('RoutingListNote',	'To change this note edit <a href=\"/cgi-bin/koha/admin/preferences.pl?op=search&searchfield=RoutingListNote#jumped\">RoutingListNote</a> system preference.',	'70|10',	'Define a note to be shown on all routing lists',	'Textarea'),
('RoutingSerials',	'1',	NULL,	'If ON, serials routing is enabled',	'YesNo'),
('SCOUserCSS',	'',	NULL,	'Add CSS to be included in the SCO module in an embedded <style> tag.',	'free'),
('SCOUserJS',	'',	NULL,	'Define custom javascript for inclusion in the SCO module',	'free'),
('SearchMyLibraryFirst',	'0',	NULL,	'If ON, OPAC searches return results limited by the user\'s library by default if they are logged in',	'YesNo'),
('SelfCheckHelpMessage',	'',	'70|10',	'Enter HTML to include under the basic Web-based Self Checkout instructions on the Help page',	'Textarea'),
('SelfCheckReceiptPrompt',	'1',	'NULL',	'If ON, print receipt dialog pops up when self checkout is finished',	'YesNo'),
('SelfCheckTimeout',	'120',	'',	'Define the number of seconds before the Web-based Self Checkout times out a patron',	'Integer'),
('SeparateHoldings',	'0',	NULL,	'Separate current branch holdings from other holdings',	'YesNo'),
('SeparateHoldingsBranch',	'homebranch',	'homebranch|holdingbranch',	'Branch used to separate holdings',	'Choice'),
('SessionRestrictionByIP',	'1',	'Check for change in remote IP address for session security. Disable only when remote IP address changes frequently.',	'',	'YesNo'),
('SessionStorage',	'mysql',	'mysql|Pg|tmp',	'Use database or a temporary file for storing session data',	'Choice'),
('ShelfBrowserUsesCcode',	'1',	'0',	'Use the item collection code when finding items for the shelf browser.',	'YesNo'),
('ShelfBrowserUsesHomeBranch',	'1',	'1',	'Use the item home branch when finding items for the shelf browser.',	'YesNo'),
('ShelfBrowserUsesLocation',	'1',	'1',	'Use the item location when finding items for the shelf browser.',	'YesNo'),
('ShowPatronImageInWebBasedSelfCheck',	'0',	'',	'If ON, displays patron image when a patron uses web-based self-checkout',	'YesNo'),
('ShowReviewer',	'full',	'none|full|first|surname|firstandinitial|username',	'Choose how a commenter\'s identity is presented alongside comments in the OPAC',	'Choice'),
('ShowReviewerPhoto',	'1',	'',	'If ON, photo of reviewer will be shown beside comments in OPAC',	'YesNo'),
('singleBranchMode',	'0',	NULL,	'Operate in Single-branch mode, hide branch selection in the OPAC',	'YesNo'),
('SlipCSS',	'',	NULL,	'Slips CSS url.',	'free'),
('SMSSendDriver',	'',	'',	'Sets which SMS::Send driver is used to send SMS messages.',	'free'),
('SocialNetworks',	'0',	'',	'Enable/Disable social networks links in opac detail pages',	'YesNo'),
('soundon',	'0',	'',	'Enable circulation sounds during checkin and checkout in the staff interface.  Not supported by all web browsers yet.',	'YesNo'),
('SpecifyDueDate',	'1',	'',	'Define whether to display \"Specify Due Date\" form in Circulation',	'YesNo'),
('SpecifyReturnDate',	'1',	'',	'Define whether to display \"Specify Return Date\" form in Circulation',	'YesNo'),
('SpineLabelAutoPrint',	'0',	'',	'If this setting is turned on, a print dialog will automatically pop up for the quick spine label printer.',	'YesNo'),
('SpineLabelFormat',	'<itemcallnumber><copynumber>',	'30|10',	'This preference defines the format for the quick spine label printer. Just list the fields you would like to see in the order you would like to see them, surrounded by <>, for example <itemcallnumber>.',	'Textarea'),
('SpineLabelShowPrintOnBibDetails',	'0',	'',	'If turned on, a \"Print Label\" link will appear for each item on the bib details page in the staff interface.',	'YesNo'),
('StaffAuthorisedValueImages',	'1',	NULL,	'',	'YesNo'),
('staffClientBaseURL',	'',	NULL,	'Specify the base URL of the staff client',	'free'),
('StaffDetailItemSelection',	'1',	NULL,	'Enable item selection in record detail page',	'YesNo'),
('StaffSearchResultsDisplayBranch',	'holdingbranch',	'holdingbranch|homebranch',	'Controls the display of the home or holding branch for staff search results',	'Choice'),
('StaffSerialIssueDisplayCount',	'3',	'',	'Number of serial issues to display per subscription in the Staff client',	'Integer'),
('StaticHoldsQueueWeight',	'0',	NULL,	'Specify a list of library location codes separated by commas -- the list of codes will be traversed and weighted with first values given higher weight for holds fulfillment -- alternatively, if RandomizeHoldsQueueWeight is set, the list will be randomly selective',	'Integer'),
('StatisticsFields',	'location|itype|ccode',	NULL,	'Define Fields (from the items table) used for statistics members',	'Free'),
('SubfieldsToAllowForRestrictedBatchmod',	'',	'Define a list of subfields for which edition is authorized when items_batchmod_restricted permission is enabled, separated by spaces. Example: 995$f 995$h 995$j',	NULL,	'Free'),
('SubfieldsToAllowForRestrictedEditing',	'',	'Define a list of subfields for which edition is authorized when edit_items_restricted permission is enabled, separated by spaces. Example: 995$f 995$h 995$j',	NULL,	'Free'),
('SubfieldsToUseWhenPrefill',	'',	'',	'Define a list of subfields to use when prefilling items (separated by space)',	'Free'),
('SubscriptionDuplicateDroppedInput',	'',	'',	'List of fields which must not be rewritten when a subscription is duplicated (Separated by pipe |)',	'Free'),
('SubscriptionHistory',	'simplified',	'simplified|full',	'Define the display preference for serials issue history in OPAC',	'Choice'),
('SubscriptionLog',	'1',	NULL,	'If ON, enables subscriptions log',	'YesNo'),
('suggestion',	'1',	'',	'If ON, enables patron suggestions feature in OPAC',	'YesNo'),
('SuspendHoldsIntranet',	'1',	'Allow holds to be suspended from the intranet.',	NULL,	'YesNo'),
('SuspendHoldsOpac',	'1',	'Allow holds to be suspended from the OPAC.',	NULL,	'YesNo'),
('SvcMaxReportRows',	'10',	NULL,	'Maximum number of rows to return via the report web service.',	'Integer'),
('SyndeticsAuthorNotes',	'0',	'',	'Display Notes about the Author on OPAC from Syndetics',	'YesNo'),
('SyndeticsAwards',	'0',	'',	'Display Awards on OPAC from Syndetics',	'YesNo'),
('SyndeticsClientCode',	'0',	'',	'Client Code for using Syndetics Solutions content',	'free'),
('SyndeticsCoverImages',	'0',	'',	'Display Cover Images from Syndetics',	'YesNo'),
('SyndeticsCoverImageSize',	'MC',	'MC|LC',	'Choose the size of the Syndetics Cover Image to display on the OPAC detail page, MC is Medium, LC is Large',	'Choice'),
('SyndeticsEditions',	'0',	'',	'Display Editions from Syndetics',	'YesNo'),
('SyndeticsEnabled',	'0',	'',	'Turn on Syndetics Enhanced Content',	'YesNo'),
('SyndeticsExcerpt',	'0',	'',	'Display Excerpts and first chapters on OPAC from Syndetics',	'YesNo'),
('SyndeticsReviews',	'0',	'',	'Display Reviews on OPAC from Syndetics',	'YesNo'),
('SyndeticsSeries',	'0',	'',	'Display Series information on OPAC from Syndetics',	'YesNo'),
('SyndeticsSummary',	'0',	'',	'Display Summary Information from Syndetics',	'YesNo'),
('SyndeticsTOC',	'0',	'',	'Display Table of Content information from Syndetics',	'YesNo'),
('TagsEnabled',	'1',	'',	'Enables or disables all tagging features.  This is the main switch for tags.',	'YesNo'),
('TagsExternalDictionary',	NULL,	'',	'Path on server to local ispell executable, used to set $Lingua::Ispell::path  This dictionary is used as a \"whitelist\" of pre-allowed tags.',	''),
('TagsInputOnDetail',	'1',	'',	'Allow users to input tags from the detail page.',	'YesNo'),
('TagsInputOnList',	'0',	'',	'Allow users to input tags from the search results list.',	'YesNo'),
('TagsModeration',	'0',	'',	'Require tags from patrons to be approved before becoming visible.',	'YesNo'),
('TagsShowOnDetail',	'10',	'',	'Number of tags to display on detail page.  0 is off.',	'Integer'),
('TagsShowOnList',	'6',	'',	'Number of tags to display on search results list.  0 is off.',	'Integer'),
('template',	'prog',	'',	'Define the preferred staff interface template',	'Themes'),
('ThingISBN',	'0',	'',	'Use with FRBRizeEditions. If ON, Koha will use the ThingISBN web service in the Editions tab on the detail pages.',	'YesNo'),
('TimeFormat',	'24hr',	'12hr|24hr',	'Defines the global time format for visual output.',	'Choice'),
('timeout',	'12000000',	NULL,	'Inactivity timeout for cookies authentication (in seconds)',	'Integer'),
('todaysIssuesDefaultSortOrder',	'desc',	'asc|desc',	'Specify the sort order of Todays Issues on the circulation page',	'Choice'),
('TraceCompleteSubfields',	'0',	'0',	'Force subject tracings to only match complete subfields.',	'YesNo'),
('TraceSubjectSubdivisions',	'0',	'1',	'Create searches on all subdivisions for subject tracings.',	'YesNo'),
('TrackClicks',	'0',	NULL,	'Track links clicked',	'Integer'),
('TransfersMaxDaysWarning',	'3',	NULL,	'Define the days before a transfer is suspected of having a problem',	'Integer'),
('TransferWhenCancelAllWaitingHolds',	'0',	NULL,	'Transfer items when cancelling all waiting holds',	'YesNo'),
('UNIMARCAuthorityField100',	'afrey50      ba0',	NULL,	'Define the contents of UNIMARC authority control field 100 position 08-35',	'Textarea'),
('UNIMARCAuthorsFacetsSeparator',	', ',	NULL,	'UNIMARC authors facets separator',	'short'),
('UNIMARCField100Language',	'fre',	NULL,	'UNIMARC field 100 default language',	'short'),
('UniqueItemFields',	'barcode',	'',	'Space-separated list of fields that should be unique (used in acquisition module for item creation). Fields must be valid SQL column names of items table',	'Free'),
('UpdateNotForLoanStatusOnCheckin',	'',	'NULL',	'This is a list of value pairs. When an item is checked in, if the not for loan value on the left matches the items not for loan value it will be updated to the right-hand value. E.g. \'-1: 0\' will cause an item that was set to \'Ordered\' to now be available for loan. Each pair of values should be on a separate line.',	'Free'),
('UpdateTotalIssuesOnCirc',	'0',	NULL,	'Whether to update the totalissues field in the biblio on each circ.',	'YesNo'),
('uppercasesurnames',	'0',	NULL,	'If ON, surnames are converted to upper case in patron entry form',	'YesNo'),
('URLLinkText',	'',	NULL,	'Text to display as the link anchor in the OPAC',	'free'),
('UsageStats',	'0',	NULL,	'Share anonymous usage data on the Hea Koha community website.',	'YesNo'),
('UsageStatsCountry',	'',	NULL,	'The country where your library is located, to be shown on the Hea Koha community website',	'YesNo'),
('UsageStatsID',	'',	NULL,	'This preference is part of Koha but it should not be deleted or updated manually.',	'Free'),
('UsageStatsLastUpdateTime',	'',	NULL,	'This preference is part of Koha but it should not be deleted or updated manually.',	'Free'),
('UsageStatsLibraryName',	'',	NULL,	'The library name to be shown on Hea Koha community website',	'Free'),
('UsageStatsLibraryType',	'public',	'public|school|academic|research|private|societyAssociation|corporate|government|religiousOrg|subscription',	'The library type to be shown on the Hea Koha community website',	'Choice'),
('UsageStatsLibraryUrl',	'',	NULL,	'The library URL to be shown on Hea Koha community website',	'Free'),
('UseAuthoritiesForTracings',	'1',	'0',	'Use authority record numbers for subject tracings instead of heading strings.',	'YesNo'),
('UseBranchTransferLimits',	'0',	'',	'If ON, Koha will will use the rules defined in branch_transfer_limits to decide if an item transfer should be allowed.',	'YesNo'),
('UseControlNumber',	'0',	'',	'If ON, record control number (w subfields) and control number (001) are used for linking of bibliographic records.',	'YesNo'),
('UseCourseReserves',	'0',	NULL,	'Enable the course reserves feature.',	'YesNo'),
('useDaysMode',	'Calendar',	'Calendar|Days|Datedue',	'Choose the method for calculating due date: select Calendar to use the holidays module, and Days to ignore the holidays module',	'Choice'),
('UseICU',	'0',	'1',	'Tell Koha if ICU indexing is in use for Zebra or not.',	'YesNo'),
('UseKohaPlugins',	'0',	'',	'Enable or disable the ability to use Koha Plugins.',	'YesNo'),
('UseQueryParser',	'0',	NULL,	'If enabled, try to use QueryParser for queries.',	'YesNo'),
('UseTransportCostMatrix',	'0',	'',	'Use Transport Cost Matrix when filling holds',	'YesNo'),
('Version',	'3.1805100',	NULL,	'The Koha database version. WARNING: Do not change this value manually, it is maintained by the webinstaller',	NULL),
('viewISBD',	'1',	'',	'Allow display of ISBD view of bibiographic records',	'YesNo'),
('viewLabeledMARC',	'0',	'',	'Allow display of labeled MARC view of bibiographic records',	'YesNo'),
('viewMARC',	'1',	'',	'Allow display of MARC view of bibiographic records',	'YesNo'),
('virtualshelves',	'1',	'',	'If ON, enables Lists management',	'YesNo'),
('WaitingNotifyAtCheckin',	'0',	NULL,	'If ON, notify librarians of waiting holds for the patron whose items they are checking in.',	'YesNo'),
('WebBasedSelfCheck',	'0',	NULL,	'If ON, enables the web-based self-check system',	'YesNo'),
('WhenLostChargeReplacementFee',	'1',	NULL,	'If ON, Charge the replacement price when a patron loses an item.',	'YesNo'),
('WhenLostForgiveFine',	'0',	NULL,	'If ON, Forgives the fines on an item when it is lost.',	'YesNo'),
('XISBN',	'0',	'',	'Use with FRBRizeEditions. If ON, Koha will use the OCLC xISBN web service in the Editions tab on the detail pages. See: http://www.worldcat.org/affiliate/webservices/xisbn/app.jsp',	'YesNo'),
('XISBNDailyLimit',	'999',	'',	'The xISBN Web service is free for non-commercial use when usage does not exceed 1000 requests per day',	'Integer'),
('XSLTDetailsDisplay',	'default',	'',	'Enable XSL stylesheet control over details page display on intranet',	'Free'),
('XSLTResultsDisplay',	'default',	'',	'Enable XSL stylesheet control over results page display on intranet',	'Free'),
('z3950AuthorAuthFields',	'701,702,700',	NULL,	'Define the MARC biblio fields for Personal Name Authorities to fill biblio.author',	'free'),
('z3950NormalizeAuthor',	'0',	'',	'If ON, Personal Name Authorities will replace authors in biblio.author',	'YesNo');

DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `entry` varchar(255) NOT NULL DEFAULT '',
  `weight` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `tags_all`;
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


DROP TABLE IF EXISTS `tags_approval`;
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


DROP TABLE IF EXISTS `tags_index`;
CREATE TABLE `tags_index` (
  `term` varchar(255) NOT NULL,
  `biblionumber` int(11) NOT NULL,
  `weight` int(9) NOT NULL DEFAULT '1',
  PRIMARY KEY (`term`,`biblionumber`),
  KEY `tags_index_biblionumber_fk_1` (`biblionumber`),
  CONSTRAINT `tags_index_biblionumber_fk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tags_index_term_fk_1` FOREIGN KEY (`term`) REFERENCES `tags_approval` (`term`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `tmp_holdsqueue`;
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


DROP TABLE IF EXISTS `transport_cost`;
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


DROP TABLE IF EXISTS `userflags`;
CREATE TABLE `userflags` (
  `bit` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(30) DEFAULT NULL,
  `flagdesc` varchar(255) DEFAULT NULL,
  `defaulton` int(11) DEFAULT NULL,
  PRIMARY KEY (`bit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `user_permissions`;
CREATE TABLE `user_permissions` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `module_bit` int(11) NOT NULL DEFAULT '0',
  `code` varchar(64) DEFAULT NULL,
  KEY `user_permissions_ibfk_1` (`borrowernumber`),
  KEY `user_permissions_ibfk_2` (`module_bit`,`code`),
  CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_permissions_ibfk_2` FOREIGN KEY (`module_bit`, `code`) REFERENCES `permissions` (`module_bit`, `code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `virtualshelfcontents`;
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


DROP TABLE IF EXISTS `virtualshelfshares`;
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


DROP TABLE IF EXISTS `virtualshelves`;
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


DROP TABLE IF EXISTS `z3950servers`;
CREATE TABLE `z3950servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `db` varchar(255) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `servername` mediumtext NOT NULL,
  `checked` smallint(6) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `syntax` varchar(80) DEFAULT NULL,
  `timeout` int(11) NOT NULL DEFAULT '0',
  `servertype` enum('zed','sru') NOT NULL DEFAULT 'zed',
  `encoding` text,
  `recordtype` enum('authority','biblio') NOT NULL DEFAULT 'biblio',
  `sru_options` varchar(255) DEFAULT NULL,
  `sru_fields` mediumtext,
  `add_xslt` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `zebraqueue`;
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


-- 2015-04-13 16:16:41


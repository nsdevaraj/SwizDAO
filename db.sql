/*
SQLyog Enterprise - MySQL GUI v7.02 
MySQL - 5.1.48-community : Database - cambook
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`cambook` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `cambook`;

/*Table structure for table `connections` */

DROP TABLE IF EXISTS `connections`;

CREATE TABLE `connections` (
  `Connection_ID` int(11) NOT NULL,
  `Person_FK` int(11) DEFAULT NULL,
  `Connection_FK` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `connections` */

/*Table structure for table `file_details` */

DROP TABLE IF EXISTS `file_details`;

CREATE TABLE `file_details` (
  `File_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Filename` varchar(250) DEFAULT NULL,
  `Filepath` varchar(250) DEFAULT NULL,
  `Filedate` datetime DEFAULT NULL,
  `Person_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`File_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=264 DEFAULT CHARSET=latin1;

/*Data for the table `file_details` */

/*Table structure for table `notes` */

DROP TABLE IF EXISTS `notes`;

CREATE TABLE `notes` (
  `Note_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` blob,
  `Creation_Date` datetime DEFAULT NULL,
  `Created_person_FK` int(11) DEFAULT NULL,
  `File_FK` int(11) DEFAULT NULL,
  `Note_Type` int(11) DEFAULT NULL,
  `Person_FK` int(11) DEFAULT NULL,
  `Note_FK` int(11) DEFAULT NULL,
  `Note_Status_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`Note_ID`),
  KEY `FK6424EC1AD772D09` (`Created_person_FK`),
  KEY `FK6424EC1C41DACCA` (`File_FK`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;

/*Data for the table `notes` */

/*Table structure for table `persons` */

DROP TABLE IF EXISTS `persons`;

CREATE TABLE `persons` (
  `Person_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Person_Firstname` varchar(255) DEFAULT NULL,
  `Person_Lastname` varchar(255) DEFAULT NULL,
  `Person_Email` varchar(255) DEFAULT NULL,
  `Person_Relations` int(11) DEFAULT NULL,
  `Person_Password` varchar(20) DEFAULT NULL,
  `Tweet_id` varchar(50) DEFAULT NULL,
  `Person_Availability` int(11) DEFAULT NULL,
  `Person_Photo_FK` int(11) DEFAULT NULL,
  `Person_Mobile` varchar(20) DEFAULT NULL,
  `Person_Question` int(11) DEFAULT NULL,
  `Person_Postal_Code` varchar(50) DEFAULT NULL,
  `Person_Answer` varchar(20) DEFAULT NULL,
  `Person_City` varchar(50) DEFAULT NULL,
  `Person_Country` varchar(50) DEFAULT NULL,
  `Activated` binary(1) DEFAULT NULL,
  PRIMARY KEY (`Person_ID`),
  KEY `NewIndex1` (`Tweet_id`),
  KEY `FKD78FCFBEFB6B029F` (`Tweet_id`)
) ENGINE=MyISAM AUTO_INCREMENT=140 DEFAULT CHARSET=latin1;

/*Data for the table `persons` */

/*Table structure for table `status` */

DROP TABLE IF EXISTS `status`;

CREATE TABLE `status` (
  `status_ID` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `status_label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`status_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;

/*Data for the table `status` */

/* Procedure structure for procedure `getProjects` */

/*!50003 DROP PROCEDURE IF EXISTS  `getProjects` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getProjects`()
    READS SQL DATA
BEGIN
	select * from Projects;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `looppersons` */

/*!50003 DROP PROCEDURE IF EXISTS  `looppersons` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `looppersons`()
BEGIN
	  DECLARE done INT DEFAULT 0;
	  DECLARE register INT;
	  DECLARE cur1 CURSOR FOR select p.person_ID id from companies c,persons p where p.Company_FK= c.Company_ID and  c.Company_Category = 'PHOTOGRAVURE';
	  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	  OPEN cur1;
		  WHILE done = 0 DO
			insert into `group_persons`(`group_person_ID`,`group_FK`,`person_FK`) values ( NULL,'42',register); 
			FETCH cur1 INTO register;
		  END WHILE;
	  CLOSE cur1;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

/*
SQLyog Enterprise - MySQL GUI v7.02 
MySQL - 5.1.30-community : Database - scrum
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`scrum` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `scrum`;

/*Table structure for table `columns` */

DROP TABLE IF EXISTS `columns`;

CREATE TABLE `columns` (
  `Column_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Column_Name` varchar(255) DEFAULT NULL,
  `Column_Field` varchar(255) DEFAULT NULL,
  `Column_Width` int(11) DEFAULT NULL,
  `Column_Filter` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Column_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `columns` */

/*Table structure for table `companies` */

DROP TABLE IF EXISTS `companies`;

CREATE TABLE `companies` (
  `Company_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Company_Name` varchar(255) NOT NULL,
  `Company_Code` varchar(6) NOT NULL,
  `Company_Logo` blob,
  `Company_Category` varchar(255) DEFAULT NULL,
  `Company_Address` varchar(255) DEFAULT NULL,
  `Company_Postal_Code` varchar(50) DEFAULT NULL,
  `Company_City` varchar(50) DEFAULT NULL,
  `Company_Country` varchar(50) DEFAULT NULL,
  `Company_Phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Company_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

/*Data for the table `companies` */

insert  into `companies`(`Company_ID`,`Company_Name`,`Company_Code`,`Company_Logo`,`Company_Category`,`Company_Address`,`Company_Postal_Code`,`Company_City`,`Company_Country`,`Company_Phone`) values (1,'ADAMS STUDIO','DOM1',NULL,'ADAMS',NULL,NULL,NULL,NULL,NULL),(2,'BRENNUS','DOM2',NULL,'BRENNUS',NULL,NULL,NULL,NULL,NULL),(3,'CARREFOUR','DOM3',NULL,'CARREFOUR',NULL,NULL,NULL,NULL,NULL),(4,'DIVERS','DOM4',NULL,'DIVERS',NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `domains` */

DROP TABLE IF EXISTS `domains`;

CREATE TABLE `domains` (
  `Domain_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Domain_Name` varchar(255) CHARACTER SET latin1 NOT NULL,
  `Domain_code` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`Domain_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

/*Data for the table `domains` */

/*Table structure for table `events` */

DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `event_ID` int(11) NOT NULL AUTO_INCREMENT,
  `event_date` datetime DEFAULT NULL,
  `event_status_FK` int(11) DEFAULT NULL,
  `person_FK` int(11) DEFAULT NULL,
  `task_FK` int(11) DEFAULT NULL,
  `product_FK` int(11) DEFAULT NULL,
  `event_label` varchar(255) DEFAULT NULL,
  `story_FK` int(11) DEFAULT NULL,
  `sprint_FK` int(11) DEFAULT NULL,
  `ticket_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`event_ID`),
  KEY `FK7C6CCD39C41DACCA` (`task_FK`),
  KEY `FK7C6CCD398EAE1DEA` (`person_FK`),
  KEY `FKB307E119C41DACCA` (`task_FK`)
) ENGINE=MyISAM AUTO_INCREMENT=1466 DEFAULT CHARSET=latin1;

/*Data for the table `events` */

/*Table structure for table `files` */

DROP TABLE IF EXISTS `files`;

CREATE TABLE `files` (
  `File_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Filename` varchar(250) DEFAULT NULL,
  `Filepath` varchar(250) DEFAULT NULL,
  `Filedate` datetime DEFAULT NULL,
  `Task_FK` int(11) DEFAULT NULL,
  `Story_FK` int(11) DEFAULT NULL,
  `StoredFileName` varchar(255) DEFAULT NULL,
  `Product_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`File_ID`),
  KEY `FK2FF57CC41DACCA` (`Task_FK`)
) ENGINE=MyISAM AUTO_INCREMENT=264 DEFAULT CHARSET=latin1;

/*Data for the table `files` */

/*Table structure for table `persons` */

DROP TABLE IF EXISTS `persons`;

CREATE TABLE `persons` (
  `Person_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Person_Firstname` varchar(255) DEFAULT NULL,
  `Person_Lastname` varchar(255) DEFAULT NULL,
  `Person_Email` varchar(255) DEFAULT NULL,
  `Person_Login` varchar(20) DEFAULT NULL,
  `Person_Password` varchar(20) DEFAULT NULL,
  `Person_Position` varchar(255) DEFAULT NULL,
  `Person_Mobile` varchar(20) DEFAULT NULL,
  `Person_Address` varchar(255) DEFAULT NULL,
  `Person_Postal_Code` varchar(50) DEFAULT NULL,
  `Person_City` varchar(50) DEFAULT NULL,
  `Person_Country` varchar(50) DEFAULT NULL,
  `Person_Pict` blob,
  `Person_DateEntry` date DEFAULT NULL,
  `Activated` smallint(1) DEFAULT '1',
  `Company_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`Person_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=121 DEFAULT CHARSET=latin1;

/*Data for the table `persons` */

insert  into `persons`(`Person_ID`,`Person_Firstname`,`Person_Lastname`,`Person_Email`,`Person_Login`,`Person_Password`,`Person_Position`,`Person_Mobile`,`Person_Address`,`Person_Postal_Code`,`Person_City`,`Person_Country`,`Person_Pict`,`Person_DateEntry`,`Activated`,`Company_FK`) values (1,'Deva','raj','devaraj@wp.pl','deva','raj','RIA Architect','9840767144','chennai','605003','chennai','india',NULL,NULL,1,1),(2,'Aime','bernard','kutti.kumar@gmail.com','aime','aime','RIA Engineer','9840767145','chennai','605004','chennai','india',NULL,NULL,1,2),(3,'Alain','Alexis','kutti.kumar@gmail.com','alain','alain','Sr.Develper RIA Engineer','9840767146','chennai','605005','chennai','india',NULL,NULL,1,3),(4,'Alexandre','Alfred','kutti.kumar@gmail.com','alexan','alexan','Sr.Developer RIA Media','9840767147','chennai','605006','chennai','india',NULL,NULL,1,4),(5,'Alphonse','Amaury','kutti.kumar@gmail.com','alphon','alphon','Developer RIA','9840767148','chennai','605007','chennai','india',NULL,NULL,1,1),(6,'Antoine','Arnaud','kutti.kumar@gmail.com','antoin','antoin','Jr.Developer RIA','9840767149','chennai','605008','chennai','india',NULL,NULL,1,1),(7,'Arthur','Benjamin','kutti.kumar@gmail.com','arthur','arthur','Java Developer','9840767150','chennai','605009','chennai','india',NULL,NULL,1,1),(8,'Bruno','Christian','kutti.kumar@gmail.com','bruno','bruno','RIA Engineer','9840767151','chennai','605010','chennai','india',NULL,NULL,1,1),(9,'Bertrnard','Christophe','kutti.kumar@gmail.com','bertrn','bertrn','Sr.Developer RIA Engineer','9840767152','chennai','605011','chennai','india',NULL,NULL,1,1),(10,'Claude','Daniel','kutti.kumar@gmail.com','claude','claude','Developer RIA','9840767153','chennai','605012','chennai','india',NULL,NULL,1,1),(11,'Dominique','Didier','kutti.kumar@gmail.com','domini','domini','Java Developer','9840767154','chennai','605013','chennai','india',NULL,NULL,1,1),(12,'Emmanuel','Emile','kutti.kumar@gmail.com','emmanu','emmanu','RIA Engineer','9840767155','chennai','605014','chennai','india',NULL,NULL,1,1),(13,'Franck','Francis','kutti.kumar@gmail.com','franc','franc','Jr.Developer RIA','9840767156','chennai','605015','chennai','india',NULL,NULL,1,1),(14,'Gilbert','Gilles','kutti.kumar@gmail.com','gilber','gilber','Developer RIA','9840767157','chennai','605016','chennai','india',NULL,NULL,1,1),(15,'Henri','Hugues','kutti.kumar@gmail.com','henri','henri','Sr.Developer RIA Engineer','9840767158','chennai','605017','chennai','india',NULL,NULL,1,1),(16,'Jean','Joseph','kutti.kumar@gmail.com','jean','jean','Sr.Developer RIA Media','9840767159','chennai','605018','chennai','india',NULL,NULL,1,1),(17,'Louis','Jules','kutti.kumar@gmail.com','louis','louis','Java Developer','9840767160','chennai','605019','chennai','india',NULL,NULL,1,1),(18,'Marc','Lucas','kutti.kumar@gmail.com','marc','marc','Developer RIA','9840767161','chennai','605020','chennai','india',NULL,NULL,1,1),(19,'Marcel','Nicolas','kutti.kumar@gmail.com','marce','marce','RIA Engineer','9840767162','chennai','605021','chennai','india',NULL,NULL,1,1),(20,'Olivier','Pascal','kutti.kumar@gmail.com','olivi','olivi','Jr.Developer RIA','9840767163','chennai','605022','chennai','india',NULL,NULL,1,1);

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `Product_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Product_Code` varchar(15) DEFAULT NULL,
  `Product_Name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `Domain_FK` int(11) DEFAULT NULL,
  `Product_Status_FK` int(11) DEFAULT NULL,
  `Product_Comment` blob,
  `Product_date_start` datetime DEFAULT NULL,
  `Product_date_end` datetime DEFAULT NULL,
  `Product_taskTypes` blob,
  `Product_Roles` blob,
  PRIMARY KEY (`Product_ID`),
  KEY `FKC479187A1124A3ED` (`Product_Status_FK`)
) ENGINE=MyISAM AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

/*Data for the table `products` */

/*Table structure for table `profiles` */

DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` (
  `Profile_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Profile_label` varchar(255) DEFAULT NULL,
  `profile_code` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`Profile_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `profiles` */

insert  into `profiles`(`Profile_ID`,`Profile_label`,`profile_code`) values (1,'ADMIN','ROLE_ADM'),(2,'PRODUCTOWNER','ROLE_SPO'),(3,'SCRUMMASTER','ROLE_SSM'),(4,'TEAMMEMBER','ROLE_STM'),(5,'OPERATEUR','ROLE_OPE');

/*Table structure for table `reports` */

DROP TABLE IF EXISTS `reports`;

CREATE TABLE `reports` (
  `Report_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Report_Name` varchar(255) DEFAULT NULL,
  `BarCol_FK` int(11) DEFAULT NULL,
  `SeriesCol_FK` int(11) DEFAULT NULL,
  `BarChart_Name` varchar(255) DEFAULT NULL,
  `PieChart_Name` varchar(255) DEFAULT NULL,
  `Profile_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`Report_ID`),
  KEY `FK413E51BF180E8530` (`BarCol_FK`),
  KEY `FK413E51BFF614AC94` (`SeriesCol_FK`),
  CONSTRAINT `FK413E51BF180E8530` FOREIGN KEY (`BarCol_FK`) REFERENCES `columns` (`Column_ID`),
  CONSTRAINT `FK413E51BFF614AC94` FOREIGN KEY (`SeriesCol_FK`) REFERENCES `columns` (`Column_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `reports` */

/*Table structure for table `reports_columns` */

DROP TABLE IF EXISTS `reports_columns`;

CREATE TABLE `reports_columns` (
  `Report_Columns_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Report_FK` int(11) DEFAULT NULL,
  `Column_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`Report_Columns_ID`),
  KEY `FK2E97615DBFC34507` (`Report_FK`),
  KEY `FK2E97615D3BD9F9C7` (`Column_FK`),
  CONSTRAINT `FK2E97615D3BD9F9C7` FOREIGN KEY (`Column_FK`) REFERENCES `columns` (`Column_ID`),
  CONSTRAINT `FK2E97615DBFC34507` FOREIGN KEY (`Report_FK`) REFERENCES `reports` (`Report_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `reports_columns` */

/*Table structure for table `sprints` */

DROP TABLE IF EXISTS `sprints`;

CREATE TABLE `sprints` (
  `Sprint_ID` int(11) NOT NULL,
  `Sprint_label` varchar(255) DEFAULT NULL,
  `Sprint_Status_FK` int(11) DEFAULT NULL,
  `Version_FK` int(11) DEFAULT NULL,
  `Team_FK` int(11) DEFAULT NULL,
  `Product_FK` int(11) DEFAULT NULL,
  `s_date_creation` datetime DEFAULT NULL,
  `s_date_end` datetime DEFAULT NULL,
  `s_date_preparation` datetime DEFAULT NULL,
  `s_date_demo` datetime DEFAULT NULL,
  `preparation_Comments` blob,
  `demo_Comments` blob,
  PRIMARY KEY (`Sprint_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sprints` */

/*Table structure for table `sprintstories` */

DROP TABLE IF EXISTS `sprintstories`;

CREATE TABLE `sprintstories` (
  `sprintstory_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Sprint_FK` int(11) DEFAULT NULL,
  `Story_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`sprintstory_ID`),
  KEY `FKF638FEC253408F88` (`Sprint_FK`),
  KEY `FKF638FEC286BC9A68` (`Story_FK`)
) ENGINE=MyISAM AUTO_INCREMENT=219 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `sprintstories` */

/*Table structure for table `status` */

DROP TABLE IF EXISTS `status`;

CREATE TABLE `status` (
  `status_ID` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `status_label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`status_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `status` */

insert  into `status`(`status_ID`,`type`,`status_label`) values (1,'productStatus','Waiting'),(2,'productStatus','InProgress'),(3,'productStatus','StandBy'),(4,'productStatus','Finished'),(5,'versionStatus','Waiting'),(6,'versionStatus','InProgress'),(7,'versionStatus','Finished'),(8,'sprintStatus','Waiting'),(9,'sprintStatus','InProgress'),(10,'sprintStatus','Finished'),(11,'sprintStatus','StandBy'),(12,'storyStatus','Waiting'),(13,'storyStatus','InProgress'),(14,'storyStatus','Finished'),(15,'storyStatus','StandBy'),(16,'taskStatus','Waiting'),(17,'taskStatus','InProgress'),(18,'taskStatus','StandBy'),(19,'taskStatus','Finished'),(20,'eventStatus','DomainCreate'),(21,'eventStatus','DomainUpdate'),(22,'eventStatus','DomainDelete'),(23,'eventStatus','ProductCreate'),(24,'eventStatus','ProductUpdate'),(25,'eventStatus','ProductDelete'),(26,'eventStatus','SprintCreate'),(27,'eventStatus','SprintUpdate'),(28,'eventStatus','SprintDelete'),(29,'eventStatus','VersionCreate'),(30,'eventStatus','VersionUpdate'),(31,'eventStatus','VersionDelete'),(32,'eventStatus','ThemeCreate'),(33,'eventStatus','ThemeUpdate'),(34,'eventStatus','ThemeDelete'),(35,'eventStatus','StoryCreate'),(36,'eventStatus','StoryUpdate'),(37,'eventStatus','StoryDelete'),(38,'eventStatus','TaskCreate'),(39,'eventStatus','TaskUpdate'),(40,'eventStatus','TaskDelete'),(41,'eventStatus','TicketCreate'),(42,'eventStatus','TicketUpdate'),(43,'eventStatus','TicketDelete'),(44,'eventStatus','TeamCreate'),(45,'eventStatus','TeamUpdate'),(46,'eventStatus','TeamDelete'),(47,'eventStatus','TeamMemberCreate'),(48,'eventStatus','TeamMemberUpdate'),(49,'eventStatus','TeamMemberDelete');

/*Table structure for table `stories` */

DROP TABLE IF EXISTS `stories`;

CREATE TABLE `stories` (
  `story_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Product_FK` int(11) DEFAULT NULL,
  `As_label` int(11) DEFAULT NULL,
  `I_Want_To_label` varchar(255) DEFAULT NULL,
  `So_That_I_Can_label` varchar(255) DEFAULT NULL,
  `Story_status_FK` int(11) DEFAULT NULL,
  `version_FK` int(11) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  `Story_comments` blob,
  `StoryPoints` int(11) DEFAULT NULL,
  `Priority` int(2) DEFAULT NULL,
  `Effort` int(11) DEFAULT NULL,
  PRIMARY KEY (`story_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `stories` */

/*Table structure for table `storythemes` */

DROP TABLE IF EXISTS `storythemes`;

CREATE TABLE `storythemes` (
  `story_theme_id` int(11) NOT NULL AUTO_INCREMENT,
  `story_FK` int(11) DEFAULT NULL,
  `theme_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`story_theme_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `storythemes` */

/*Table structure for table `tasks` */

DROP TABLE IF EXISTS `tasks`;

CREATE TABLE `tasks` (
  `task_ID` int(11) NOT NULL AUTO_INCREMENT,
  `story_FK` int(11) DEFAULT NULL,
  `task_comment` blob COMMENT 'Rich text',
  `task_status_FK` int(11) DEFAULT NULL,
  `task_type` int(11) DEFAULT NULL,
  `t_date_creation` datetime DEFAULT NULL,
  `t_date_inprogress` datetime DEFAULT NULL,
  `t_date_validation` datetime DEFAULT NULL,
  `t_date_done` datetime DEFAULT NULL,
  `onair_time` int(11) DEFAULT NULL,
  `estimated_time` int(11) DEFAULT NULL,
  `done_time` int(11) DEFAULT NULL,
  `person_FK` int(11) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`task_ID`),
  KEY `NewIndex1` (`task_status_FK`),
  KEY `FK6907B8E8EAE1DEA` (`person_FK`),
  KEY `FK6907B8E53408F88` (`story_FK`),
  KEY `FK6907B8E6BB9320D` (`task_status_FK`)
) ENGINE=MyISAM AUTO_INCREMENT=233 DEFAULT CHARSET=latin1;

/*Data for the table `tasks` */

/*Table structure for table `teammembers` */

DROP TABLE IF EXISTS `teammembers`;

CREATE TABLE `teammembers` (
  `teammember_ID` int(11) NOT NULL AUTO_INCREMENT,
  `team_FK` int(11) DEFAULT NULL,
  `profile_FK` int(11) DEFAULT NULL,
  `person_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`teammember_ID`),
  KEY `FKF638FEC253408F88` (`team_FK`),
  KEY `FKF638FEC28EAE1DEA` (`person_FK`),
  KEY `FKF638FEC286BC9A68` (`profile_FK`)
) ENGINE=MyISAM AUTO_INCREMENT=214 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1;

/*Data for the table `teammembers` */

insert  into `teammembers`(`teammember_ID`,`team_FK`,`profile_FK`,`person_FK`) values (1,1,1,1),(2,1,2,1),(3,1,3,1),(4,1,4,1),(5,1,2,2),(6,1,3,3),(7,1,4,4);

/*Table structure for table `teams` */

DROP TABLE IF EXISTS `teams`;

CREATE TABLE `teams` (
  `team_ID` int(11) NOT NULL AUTO_INCREMENT,
  `team_label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`team_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1;

/*Data for the table `teams` */

insert  into `teams`(`team_ID`,`team_label`) values (1,'InitTeam');

/*Table structure for table `themes` */

DROP TABLE IF EXISTS `themes`;

CREATE TABLE `themes` (
  `theme_ID` int(11) NOT NULL,
  `theme_lbl` varchar(255) DEFAULT NULL,
  `product_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`theme_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `themes` */

/*Table structure for table `tickets` */

DROP TABLE IF EXISTS `tickets`;

CREATE TABLE `tickets` (
  `Ticket_ID` int(11) NOT NULL,
  `Person_FK` int(11) DEFAULT NULL,
  `Task_FK` int(11) DEFAULT NULL,
  `Ticket_Date` datetime DEFAULT NULL,
  `Ticket_TimeSpent` int(11) DEFAULT NULL,
  `Ticket_Comments` varchar(255) DEFAULT NULL,
  `Ticket_Technical` blob,
  PRIMARY KEY (`Ticket_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tickets` */

/*Table structure for table `versions` */

DROP TABLE IF EXISTS `versions`;

CREATE TABLE `versions` (
  `version_ID` int(11) NOT NULL,
  `version_lbl` varchar(255) DEFAULT NULL,
  `version_status_FK` int(11) DEFAULT NULL,
  `product_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`version_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `versions` */ 
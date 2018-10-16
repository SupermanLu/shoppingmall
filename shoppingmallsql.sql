/*
SQLyog Ultimate v8.32 
MySQL - 5.7.20-log : Database - shoppingmall
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shoppingmall` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `shoppingmall`;

/*Table structure for table `bbs` */

DROP TABLE IF EXISTS `bbs`;

CREATE TABLE `bbs` (
  `bbsid` varchar(50) COLLATE utf8_bin NOT NULL,
  `cid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `bbstype` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `subject` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `bbscontent` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `bbstime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`bbsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `bbs` */

insert  into `bbs`(`bbsid`,`cid`,`email`,`bbstype`,`subject`,`bbscontent`,`bbstime`,`status`) values ('3d61f333-a6ba-48c2-bd5b-925f4013333a',NULL,'123123','3','123123','123123','2018-10-12 12:18:06','0');

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `cartid` varchar(50) COLLATE utf8_bin NOT NULL,
  `cid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `pid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`cartid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `cart` */

insert  into `cart`(`cartid`,`cid`,`pid`,`num`) values ('94a59669-fa53-449b-8cb0-50395bf4f50d','40ad3e9f-8809-422a-bb94-6860f3482ee7','b375a8c3-84c6-43e1-a61f-0a8044eb6c97',1);

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `cateid` varchar(50) COLLATE utf8_bin NOT NULL,
  `catename` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `parentcateid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `issy` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `bannerurl` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  PRIMARY KEY (`cateid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `category` */

insert  into `category`(`cateid`,`catename`,`parentcateid`,`issy`,`bannerurl`,`ordernum`) values ('2c2cdeb2-f434-4ed0-92fe-58580ec01f5a','ceshi222','c3eed417-cf11-4982-8551-d3774f4976a6','0','/shoppingmall/uploads/f5a0d128-e743-47e4-ac26-b8be59083ab7.jpg',8),('c3eed417-cf11-4982-8551-d3774f4976a6','123123','','1','/shoppingmall/uploads/dda72ec5-b66c-4dbe-9b12-7990e1f2cf08.jpg',0);

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `commentid` varchar(50) COLLATE utf8_bin NOT NULL,
  `pid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `customid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `oid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `notetype` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `replytype` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `useremail` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `subject` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `comment` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `commentdate` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`commentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `comment` */

/*Table structure for table `custom` */

DROP TABLE IF EXISTS `custom`;

CREATE TABLE `custom` (
  `customid` varchar(50) COLLATE utf8_bin NOT NULL,
  `customno` int(11) NOT NULL AUTO_INCREMENT,
  `customname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `mobile` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `truename` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `bankno` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `writedate` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `score` decimal(18,2) DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`customid`),
  UNIQUE KEY `customno` (`customno`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `custom` */

insert  into `custom`(`customid`,`customno`,`customname`,`mobile`,`truename`,`bankno`,`password`,`writedate`,`score`,`status`) values ('080cafa5-a10d-4dcb-902f-8345fb0f74e0',21,'1234432',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:29','20.00','0'),('32ac110c-fc65-4549-95f5-6dcc8148680a',6,'ceshi1','15262330678','测试','1231231','7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-05 20:34:16','0.00','1'),('342da3a8-e872-4e41-ae12-e5efe3ef5b43',20,'123454',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:29','20.00','0'),('40ad3e9f-8809-422a-bb94-6860f3482ee7',7,'ceshi2','15262330678','测试','1231231','7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-05 20:34:16','12776.00','0'),('59fedfbb-5ba0-4b82-9f8b-6682da2b529d',13,'1233',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:24','20.00','0'),('642ee3bc-12f9-43f4-b180-4d43853b9a1e',15,'12334',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:25','20.00','0'),('6aa307a5-a373-48c4-a486-566c2b064ca9',10,'123',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:47:22','20.00','0'),('8097f394-6f4f-4f25-9b62-67d0701abd7e',8,'ceshi3','15262330678','测试','1231231','7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-05 20:34:16','9.68','1'),('82751a6e-8245-439d-88ad-8812ad2339d7',12,'12345',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:23','20.00','0'),('87255af7-7e51-4cfe-a124-b9815bec064e',9,'ceshi4','15262330678','测试','1231231','011c945f30ce2cbafc452f39840f025693339c42','2018-10-05 20:34:16','9.40','0'),('94743a31-3480-4e86-a892-e605197fb86c',19,'12344',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:28','20.00','0'),('bc7dc755-26b8-4192-ab7b-05268d34c40d',18,'123321',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:27','20.00','0'),('d772a050-61b2-475b-9d29-ad2ca099eb75',23,'12356',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:31','20.00','0'),('d9008250-fd61-4731-ab53-b9c09c17aa65',17,'123322',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:27','20.00','0'),('e24485be-3a81-4a7e-9b49-3630b9096fc6',22,'12344321',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:30','20.00','0'),('e87da214-2ba9-4bee-b63f-7c3d977267f0',16,'12332',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:26','20.00','0'),('f1cf4d14-0bb0-439e-b6d8-3625426bc6c7',14,'12333',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:25','20.00','0'),('fd349e45-0987-425c-b6ea-c7c5564d32cc',11,'1234',NULL,NULL,NULL,'7b21848ac9af35be0ddb2d6b9fc3851934db8420','2018-10-12 23:48:02','20.00','0');

/*Table structure for table `friendlink` */

DROP TABLE IF EXISTS `friendlink`;

CREATE TABLE `friendlink` (
  `linkid` varchar(50) COLLATE utf8_bin NOT NULL,
  `linkname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `linkurl` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  PRIMARY KEY (`linkid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `friendlink` */

insert  into `friendlink`(`linkid`,`linkname`,`linkurl`,`ordernum`) values ('4f04610e-424f-44e3-a92d-5a50137052f5','新华网','http://www.xinhuanet.com',0);

/*Table structure for table `help` */

DROP TABLE IF EXISTS `help`;

CREATE TABLE `help` (
  `helpid` varchar(50) COLLATE utf8_bin NOT NULL,
  `helpname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `helppid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `helpcontent` longtext COLLATE utf8_bin,
  PRIMARY KEY (`helpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `help` */

insert  into `help`(`helpid`,`helpname`,`helppid`,`helpcontent`) values ('c8db7e80-7c0c-468e-a7c2-470a1ee84018','232423313','eaf4db1a-3eb3-490b-a636-564a7f4a7b52','%3Cp%3E1131231%3C/p%3E'),('eaf4db1a-3eb3-490b-a636-564a7f4a7b52','测试一下','','%3Cp%3E213123%3C/p%3E');

/*Table structure for table `location` */

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `locationid` varchar(50) COLLATE utf8_bin NOT NULL,
  `locationno` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `locationname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`locationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `location` */

insert  into `location`(`locationid`,`locationno`,`locationname`) values ('f4ecf578-cfc1-45bb-a63f-874a839902d0','1221312','北京');

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `menuid` varchar(50) COLLATE utf8_bin NOT NULL,
  `menuname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `menubs` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  `parentmenuid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `menu` */

insert  into `menu`(`menuid`,`menuname`,`menubs`,`description`,`ordernum`,`parentmenuid`) values ('12263823-b634-4870-b2fa-f4e933cdca09','菜单管理','','menulist.jsp',98,'8ae0352f-ffa1-4e74-a698-047d9adec036'),('146bc3f8-15d3-4949-81f0-d415b9c831f0','订单管理','order','',70,''),('21e70710-001e-40fa-8de5-b0cca35dfc75','友情链接列表','','friendlinklist.jsp',29,'5a4130e6-bc55-4ec9-ab1b-e84b7a43e753'),('32995fde-0194-4ae2-86d4-a74bd0aa5b03','商品管理','product','',80,''),('330f76da-cf9c-40df-9616-98f2f63f9c34','会员管理','custom','',20,''),('3b176595-f88a-471d-bd21-96f61b61cd2c','商品分类管理','','categorylist.jsp',79,'32995fde-0194-4ae2-86d4-a74bd0aa5b03'),('4dbcae79-ff3d-41e0-9fe7-f80497d10adf','后台用户管理','','userslist.jsp',97,'8ae0352f-ffa1-4e74-a698-047d9adec036'),('5a4130e6-bc55-4ec9-ab1b-e84b7a43e753','友情链接管理','link','',30,''),('73473ac3-954d-46cd-8cfd-17a3eebfd698','帮助管理','','helplist.jsp',44,'fb47ef83-ef06-4dee-9f2a-e0d80d838a47'),('7d181bbe-3f9c-41f2-a6a5-a31ebcb980cd','会员积分列表','','scorelist.jsp',18,'330f76da-cf9c-40df-9616-98f2f63f9c34'),('7d8b0e93-b038-493e-9688-da5e112e9d05','积分规则','rule','',40,''),('8ae0352f-ffa1-4e74-a698-047d9adec036','系统管理','system','',99,''),('9154ad77-9bee-4db0-9ec0-ac605d4f18ce','首页轮播图','swip','',50,''),('958a84ba-49b3-4667-aa70-8be8684dff23','留言管理','','bbslist.jsp',19,'b7f9de18-0b8c-4cba-8c96-51e3f1eafd31'),('9a711cff-7711-4786-a19b-df68dc54c4c2','积分规则','','ruleedit.jsp',39,'7d8b0e93-b038-493e-9688-da5e112e9d05'),('a3749c27-d426-497f-a0bb-57d7d22dab77','会员列表','','customlist.jsp',19,'330f76da-cf9c-40df-9616-98f2f63f9c34'),('b7f9de18-0b8c-4cba-8c96-51e3f1eafd31','留言管理','bbs','',20,''),('def9a474-1621-4dce-be39-04c190decab5','用户商品评论列表','','commentlist.jsp',77,'32995fde-0194-4ae2-86d4-a74bd0aa5b03'),('e0761fcf-cbae-4c4b-ba13-237fa5b54114','轮播图列表','','swiplist.jsp',49,'9154ad77-9bee-4db0-9ec0-ac605d4f18ce'),('eb1654a7-756b-49ed-9bf9-5d7ab335c9e9','角色管理','','rolelist.jsp',96,'8ae0352f-ffa1-4e74-a698-047d9adec036'),('ece013db-f839-48a6-a2a7-8e41e242d829','商品管理','','productlist.jsp',78,'32995fde-0194-4ae2-86d4-a74bd0aa5b03'),('f130c163-55fd-4b39-89d9-a919b515747b','地区管理','','locationlist.jsp',59,'f62d76c1-5b53-46fd-bf91-627563ea867a'),('f454981a-b11d-457a-a7d5-9fd96da2de97','商品订单管理','','orderlist.jsp',69,'146bc3f8-15d3-4949-81f0-d415b9c831f0'),('f62d76c1-5b53-46fd-bf91-627563ea867a','地区管理','location','',60,''),('fb47ef83-ef06-4dee-9f2a-e0d80d838a47','帮助管理','help','',45,'');

/*Table structure for table `note` */

DROP TABLE IF EXISTS `note`;

CREATE TABLE `note` (
  `noteid` varchar(50) COLLATE utf8_bin NOT NULL,
  `title` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `content` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `istop` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`noteid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `note` */

insert  into `note`(`noteid`,`title`,`content`,`istop`) values ('50030562-50ef-43a0-99d6-2b5e075181b9','1231','213123','0'),('8e02ed3e-203b-498f-a917-03fd9a7bad5d','111111111111','1233333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333','0'),('93acfcb5-3d1a-47ef-a57b-48577f26bc5c','11111111测试','1111测试','0');

/*Table structure for table `orderlist` */

DROP TABLE IF EXISTS `orderlist`;

CREATE TABLE `orderlist` (
  `orderid` varchar(50) COLLATE utf8_bin NOT NULL,
  `orderno` int(11) NOT NULL AUTO_INCREMENT,
  `customid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `proid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `pname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `preprice` decimal(18,2) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `postage` decimal(18,2) DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `ordertime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `paytime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `receiver` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `location` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `detaillocation` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `deliverytime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `iscomment` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `isread` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`orderid`),
  UNIQUE KEY `orderno` (`orderno`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `orderlist` */

insert  into `orderlist`(`orderid`,`orderno`,`customid`,`proid`,`pname`,`preprice`,`num`,`postage`,`status`,`ordertime`,`paytime`,`receiver`,`location`,`detaillocation`,`phone`,`deliverytime`,`iscomment`,`isread`) values ('0278539b-46fd-42a5-a108-d5b175e85256',5,'40ad3e9f-8809-422a-bb94-6860f3482ee7','2aaa1c61-c0ac-4bb3-bfbe-5585fed7c1e7','ceshishangpin','1231.00',5,'0.00','0','2018-10-10 00:26:35','2018-10-10 00:26:35','','','','',NULL,NULL,NULL),('14438e76-cec9-4529-8e48-450c9d16a71a',9,'40ad3e9f-8809-422a-bb94-6860f3482ee7','2aaa1c61-c0ac-4bb3-bfbe-5585fed7c1e7','ceshishangpin','1231.00',1,'0.00','0','2018-10-11 23:12:07','2018-10-11 23:12:07','陆哥','123123','123123','12312',NULL,NULL,NULL),('19226f90-dbde-4f39-b1c1-e88e9c4e0b4b',1,'40ad3e9f-8809-422a-bb94-6860f3482ee7','2aaa1c61-c0ac-4bb3-bfbe-5585fed7c1e7','ceshishangpin','1231.00',2,'0.00','0','2018-10-09 00:14:27','2018-10-09 00:14:27','','','','',NULL,NULL,NULL),('241e30ef-2a8c-4967-b9f0-0e9182c823f8',7,'40ad3e9f-8809-422a-bb94-6860f3482ee7','2aaa1c61-c0ac-4bb3-bfbe-5585fed7c1e7','ceshishangpin','1231.00',1,'0.00','0','2018-10-10 11:00:36','2018-10-10 11:00:36','','','','',NULL,NULL,NULL),('2ee226ae-188d-4d41-9cc7-c6216ec1d615',2,'40ad3e9f-8809-422a-bb94-6860f3482ee7','2aaa1c61-c0ac-4bb3-bfbe-5585fed7c1e7','ceshishangpin','1231.00',2,'0.00','1','2018-10-09 00:17:50','2018-10-09 00:17:51','','','','',NULL,NULL,NULL),('3a9d626f-c815-4713-b61c-130f7e7a7479',4,'40ad3e9f-8809-422a-bb94-6860f3482ee7','2aaa1c61-c0ac-4bb3-bfbe-5585fed7c1e7','ceshishangpin','1231.00',3,'0.00','0','2018-10-09 14:24:13','2018-10-09 14:24:13','','','','',NULL,NULL,NULL),('7afa0417-2b20-4dd1-b635-cc0ddeb06138',6,'40ad3e9f-8809-422a-bb94-6860f3482ee7','2aaa1c61-c0ac-4bb3-bfbe-5585fed7c1e7','ceshishangpin','1231.00',1,'0.00','0','2018-10-10 10:56:08','2018-10-10 10:56:08','','','','',NULL,NULL,NULL),('7d3164af-908e-4738-9869-f8238d9353f8',3,'40ad3e9f-8809-422a-bb94-6860f3482ee7','2aaa1c61-c0ac-4bb3-bfbe-5585fed7c1e7','ceshishangpin','1231.00',2,'0.00','1','2018-10-09 00:29:00','2018-10-09 00:29:00','','','','',NULL,NULL,NULL),('b61b2b92-6093-4705-ae07-5a7d8007f5d1',8,'40ad3e9f-8809-422a-bb94-6860f3482ee7','2aaa1c61-c0ac-4bb3-bfbe-5585fed7c1e7','ceshishangpin','1231.00',1,'0.00','0','2018-10-10 11:09:56','2018-10-10 11:09:56','','','','',NULL,NULL,NULL);

/*Table structure for table `param` */

DROP TABLE IF EXISTS `param`;

CREATE TABLE `param` (
  `paramid` varchar(50) COLLATE utf8_bin NOT NULL,
  `paramname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `paramvalue` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `desc` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`paramid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `param` */

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `productid` varchar(50) COLLATE utf8_bin NOT NULL,
  `pno` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `cid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `issj` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `istj` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `isjptj` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `isrxjp` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `isrm` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `isxp` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `isqg` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `isdlsy` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `istg` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `qgstarttime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `qgendtime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `tgstarttime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `tgendtime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `originalprice` decimal(18,2) DEFAULT NULL,
  `discountedprice` decimal(18,2) DEFAULT NULL,
  `postage` decimal(18,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `logourl` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `sales` int(11) DEFAULT NULL,
  `pimgurl` longtext COLLATE utf8_bin,
  `descption` longtext COLLATE utf8_bin,
  `ordernum` int(11) DEFAULT NULL,
  `updatetime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`productid`),
  UNIQUE KEY `pno` (`pno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `product` */

insert  into `product`(`productid`,`pno`,`pname`,`cid`,`issj`,`istj`,`isjptj`,`isrxjp`,`isrm`,`isxp`,`isqg`,`isdlsy`,`istg`,`qgstarttime`,`qgendtime`,`tgstarttime`,`tgendtime`,`originalprice`,`discountedprice`,`postage`,`stock`,`logourl`,`sales`,`pimgurl`,`descption`,`ordernum`,`updatetime`) values ('b375a8c3-84c6-43e1-a61f-0a8044eb6c97',3,'12312','c3eed417-cf11-4982-8551-d3774f4976a6','1','1','1','1','1','1','1','1','1',NULL,NULL,NULL,NULL,'123123.00','213123.00','0.00',21312,'/shoppingmall/uploads/44cb0e44-afe8-4c6d-9599-8e2f863bea58.JPG',0,'/shoppingmall/uploads/53db7037-1b9d-417a-8655-084117bb1df7.jpg,/shoppingmall/uploads/a2952434-6e35-4d35-83ad-3cd67cd0e180.JPG,/shoppingmall/uploads/228cac9a-0484-4b3c-9985-e5d0815cc4e5.jpg','',NULL,'2018-10-12 17:36:57');

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `roleid` varchar(50) COLLATE utf8_bin NOT NULL,
  `rolename` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `menuid` longtext COLLATE utf8_bin,
  `status` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `role` */

insert  into `role`(`roleid`,`rolename`,`description`,`menuid`,`status`) values ('b8efacbb-7d43-4da5-9f48-9a75d8c68d30','超级管理员','超级管理员',NULL,'1'),('c1da0cc6-f6af-419e-905c-738169ca0a99','测试','测试','32995fde-0194-4ae2-86d4-a74bd0aa5b03,3b176595-f88a-471d-bd21-96f61b61cd2c,ece013db-f839-48a6-a2a7-8e41e242d829','1');

/*Table structure for table `rule` */

DROP TABLE IF EXISTS `rule`;

CREATE TABLE `rule` (
  `ruleid` varchar(50) COLLATE utf8_bin NOT NULL,
  `rulecontent` longtext COLLATE utf8_bin,
  PRIMARY KEY (`ruleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `rule` */

insert  into `rule`(`ruleid`,`rulecontent`) values ('890eede2-307f-49a2-a71b-36f94f83f632','%3Cp%3E21897893123123%3C/p%3E');

/*Table structure for table `score` */

DROP TABLE IF EXISTS `score`;

CREATE TABLE `score` (
  `scoreid` varchar(50) COLLATE utf8_bin NOT NULL,
  `customid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `oid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `score` decimal(18,2) DEFAULT NULL,
  `type` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `operatetime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`scoreid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `score` */

insert  into `score`(`scoreid`,`customid`,`oid`,`score`,`type`,`operatetime`) values ('0021a892-4ed8-40c0-b71c-145981e06dbb','59fedfbb-5ba0-4b82-9f8b-6682da2b529d',NULL,'10.00','1',NULL),('02437d91-cf56-4262-8fe1-eecfbedd671f','d9008250-fd61-4731-ab53-b9c09c17aa65',NULL,'10.00','1',NULL),('04ad2828-11ad-4048-801f-cbdf45bb1c35','59fedfbb-5ba0-4b82-9f8b-6682da2b529d',NULL,'10.00','1','2018-10-12 23:55:28'),('11f66e85-9bb0-4ef9-b6d3-e5799a583db1','e87da214-2ba9-4bee-b63f-7c3d977267f0',NULL,'10.00','1','2018-10-12 23:55:31'),('1911407f-148d-4e46-9e1c-d61a41054939','82751a6e-8245-439d-88ad-8812ad2339d7',NULL,'10.00','1',NULL),('1bbeb3a2-9fb4-4c98-8f68-b1ec363533ac','40ad3e9f-8809-422a-bb94-6860f3482ee7','241e30ef-2a8c-4967-b9f0-0e9182c823f8','1231.00','1','2018-10-10 11:02:00'),('1c1cfbf4-5936-462b-a26f-c1402ef38491','342da3a8-e872-4e41-ae12-e5efe3ef5b43',NULL,'10.00','1','2018-10-12 23:55:33'),('22361b67-556b-4539-86d5-296e32dfb1be','bc7dc755-26b8-4192-ab7b-05268d34c40d',NULL,'10.00','1','2018-10-12 23:55:32'),('34e3dff9-b290-4ab5-8b82-a705d31b5bc1','080cafa5-a10d-4dcb-902f-8345fb0f74e0',NULL,'10.00','1',NULL),('3acf5a35-278c-4956-8850-80f5830c95a2','e24485be-3a81-4a7e-9b49-3630b9096fc6',NULL,'10.00','1','2018-10-12 23:55:35'),('4624f644-ba6d-449c-987d-c5f60ec7ee7b','94743a31-3480-4e86-a892-e605197fb86c',NULL,'10.00','1','2018-10-12 23:55:33'),('4a93d7bf-3330-4295-a7ff-a2289c316a7f','642ee3bc-12f9-43f4-b180-4d43853b9a1e',NULL,'10.00','1','2018-10-12 23:55:30'),('4fe747f7-a41d-45a6-b4cc-571583cc36a6','d772a050-61b2-475b-9d29-ad2ca099eb75',NULL,'10.00','1',NULL),('5878789b-8a22-49e4-b384-39c1748f4b7d','f1cf4d14-0bb0-439e-b6d8-3625426bc6c7',NULL,'10.00','1',NULL),('69c88849-4957-4bb2-a3d7-685d51fcc091','fd349e45-0987-425c-b6ea-c7c5564d32cc',NULL,'10.00','1','2018-10-12 23:55:27'),('6fba07c7-8a85-4c02-8a33-94101705bfb4','642ee3bc-12f9-43f4-b180-4d43853b9a1e',NULL,'10.00','1',NULL),('716cf2fc-8b35-457c-a628-f2544bb6fcae','40ad3e9f-8809-422a-bb94-6860f3482ee7','b61b2b92-6093-4705-ae07-5a7d8007f5d1','1231.00','1','2018-10-10 11:09:56'),('7693c804-eb51-41e2-9907-e9ebb40ddfc6','080cafa5-a10d-4dcb-902f-8345fb0f74e0',NULL,'10.00','1','2018-10-12 23:55:34'),('7bb60910-d248-49c3-a97f-13b45ecb79f4','40ad3e9f-8809-422a-bb94-6860f3482ee7','7afa0417-2b20-4dd1-b635-cc0ddeb06138','1231.00','1','2018-10-10 10:56:09'),('7ce7c754-5cb5-44a3-aa80-27cfd5ed1f0e','bc7dc755-26b8-4192-ab7b-05268d34c40d',NULL,'10.00','1',NULL),('870d27df-2750-414e-a1e1-42a588d07fa1','6aa307a5-a373-48c4-a486-566c2b064ca9',NULL,'10.00','1','2018-10-12 23:55:23'),('9cfbae0f-9ffa-413d-983b-941683b0b9d3','342da3a8-e872-4e41-ae12-e5efe3ef5b43',NULL,'10.00','1',NULL),('b93ae7e7-512c-4c13-9f94-ccf990ff912f','d9008250-fd61-4731-ab53-b9c09c17aa65',NULL,'10.00','1','2018-10-12 23:55:31'),('ba3c4313-5f13-4803-abb9-da6daa4ee272','40ad3e9f-8809-422a-bb94-6860f3482ee7',NULL,'5.00','0',NULL),('ba960927-4250-42f1-b86d-bb00ad8ee151','40ad3e9f-8809-422a-bb94-6860f3482ee7',NULL,'10.00','0','2018-10-10 10:04:59'),('c159930c-65a0-4d26-aa04-801fb79c75c7','6aa307a5-a373-48c4-a486-566c2b064ca9',NULL,'10.00','1',NULL),('cb82d003-dca6-45e7-9700-7ecff9a088a6','f1cf4d14-0bb0-439e-b6d8-3625426bc6c7',NULL,'10.00','1','2018-10-12 23:55:29'),('cc9b0b9f-b4d5-4532-bf9b-9ba905c8a46d','40ad3e9f-8809-422a-bb94-6860f3482ee7','14438e76-cec9-4529-8e48-450c9d16a71a','1231.00','1','2018-10-11 23:12:07'),('ce285830-b375-4146-a33b-6e75ebfd638f','40ad3e9f-8809-422a-bb94-6860f3482ee7','0278539b-46fd-42a5-a108-d5b175e85256','6155.00','0',NULL),('d0b75e32-b7b5-499b-b23a-edfe6f4fee3b','e87da214-2ba9-4bee-b63f-7c3d977267f0',NULL,'10.00','1',NULL),('d732086e-fdb1-4d6f-b7b0-065764cc5f83','40ad3e9f-8809-422a-bb94-6860f3482ee7',NULL,'5.00','1',NULL),('de58337c-240f-4ddb-93f2-cd7184dcd52a','82751a6e-8245-439d-88ad-8812ad2339d7',NULL,'10.00','1','2018-10-12 23:55:28'),('ea346faf-8758-41f5-ae75-1976aaea37d2','d772a050-61b2-475b-9d29-ad2ca099eb75',NULL,'10.00','1','2018-10-12 23:55:35'),('eddc27f6-bb5c-4881-a662-20d5f7c913c3','fd349e45-0987-425c-b6ea-c7c5564d32cc',NULL,'10.00','1',NULL),('fdb989eb-6d67-45fa-af62-2ec4eb7b31c2','e24485be-3a81-4a7e-9b49-3630b9096fc6',NULL,'10.00','1',NULL),('ff5907f8-c998-4c17-82b4-6aff94c4f41b','94743a31-3480-4e86-a892-e605197fb86c',NULL,'10.00','1',NULL);

/*Table structure for table `swip` */

DROP TABLE IF EXISTS `swip`;

CREATE TABLE `swip` (
  `swipid` varchar(50) COLLATE utf8_bin NOT NULL,
  `swiplink` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `swipimgurl` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  `addtime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`swipid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `swip` */

insert  into `swip`(`swipid`,`swiplink`,`swipimgurl`,`ordernum`,`addtime`) values ('90b71d6f-ff20-441e-bf00-e6b615aa9eb0','http://www.baidu.com','/shoppingmall/uploads/1dc23351-719f-4eea-b88f-6b4e126549b7.jpg',13,'2018-10-08 21:58:56'),('e2010a77-cdb3-4cb9-b754-2c53ad6c7b88','www.sina.com','/shoppingmall/uploads/4dc0c641-7a90-4e71-9b55-e666e42c4ac1.jpg',8,'2018-10-08 21:52:26');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userid` varchar(50) COLLATE utf8_bin NOT NULL,
  `username` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `roleid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `users` */

insert  into `users`(`userid`,`username`,`roleid`,`status`,`password`,`name`) values ('3ad17fcc-9a82-4f8a-8fcb-7f107364e02b','ceshi','c1da0cc6-f6af-419e-905c-738169ca0a99','1','7b21848ac9af35be0ddb2d6b9fc3851934db8420',NULL),('45f0c5f9-cad2-49e6-887d-b38dfcbc23de','admin','b8efacbb-7d43-4da5-9f48-9a75d8c68d30','1','7b21848ac9af35be0ddb2d6b9fc3851934db8420','系统管理员');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

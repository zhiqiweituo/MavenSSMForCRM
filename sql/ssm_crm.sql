/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.24 : Database - ssm_crm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ssm_crm` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ssm_crm`;

/*Table structure for table `cus_dev_plan` */

DROP TABLE IF EXISTS `cus_dev_plan`;

CREATE TABLE `cus_dev_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sale_chance_id` int(11) DEFAULT NULL COMMENT '外键',
  `plan_date` date DEFAULT NULL COMMENT '计划日期',
  `plan_item` varchar(200) DEFAULT NULL COMMENT '计划项',
  `execute_affect` varchar(60) DEFAULT NULL COMMENT '执行效果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

/*Data for the table `cus_dev_plan` */

insert  into `cus_dev_plan`(`id`,`sale_chance_id`,`plan_date`,`plan_item`,`execute_affect`) values (11,32,'2017-06-09','好','额'),(12,32,'2017-06-01','联系客户，介绍产品','有点效果'),(13,32,'2017-06-07','请客户吃饭，洽谈','成功了'),(44,30,'2018-03-12','联系客户推荐产品','比较排斥'),(45,30,'2018-03-12','请客户吃饭','有点效果'),(46,30,'2018-03-12','中秋节送客户月饼','成功'),(48,34,'2018-03-12','约客户看展品','可以'),(49,34,'2018-03-12','看望客户的生病母亲','比较感动'),(50,35,'2018-03-12','打电话推销','没有效果'),(59,35,'2018-03-12','继续打电话','有点反感');

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `khno` varchar(30) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `area` varchar(30) DEFAULT NULL,
  `cus_manager` varchar(30) DEFAULT NULL,
  `level` varchar(30) DEFAULT NULL,
  `myd` varchar(30) DEFAULT NULL,
  `xyd` varchar(30) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `post_code` varchar(60) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `web_site` varchar(30) DEFAULT NULL,
  `yyzzzch` varchar(60) DEFAULT NULL,
  `fr` varchar(30) DEFAULT NULL,
  `zczj` varchar(30) DEFAULT NULL,
  `nyye` varchar(30) DEFAULT NULL,
  `khyh` varchar(60) DEFAULT NULL,
  `khzh` varchar(60) DEFAULT NULL,
  `dsdjh` varchar(60) DEFAULT NULL,
  `gsdjh` varchar(60) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`id`,`khno`,`name`,`area`,`cus_manager`,`level`,`myd`,`xyd`,`address`,`post_code`,`phone`,`fax`,`web_site`,`yyzzzch`,`fr`,`zczj`,`nyye`,`khyh`,`khzh`,`dsdjh`,`gsdjh`,`state`) values (33,'CUS201803120001','万鞍智能科技有限公司','山东','4','重点开发客户','50','3','山东省淄博市张店区柳泉路居然家居6楼304','255000','17180135274','0533-2160001','www.wan.com','38798712347222','王坤','500','50','招商银行','309308307111234','8887776665551234','999876543210123',0),(34,'CUS201803120002','迈乐医慧云科技','山东','3','普通客户','20','4','山东省淄博市张店区高科技创业园','255000','15200001234','0533-2161234','www.mai.com','123','张鹏','50','20','齐商银行','1233','2344','3455',0),(35,'CUS201803130001','银座家居','北京','4','合作伙伴','200','2','北京市朝阳区','123','123','123','123','123','李晨业','100','200','中国工商银行','123','123','123',0),(36,'CUS201803130002','万象汇购物广场','河北','5','战略合作伙伴','10','3','河北省石家庄市','123','123','123','123','123','袁腾飞','10','10','中国农业银行','123','123','123',0),(37,'CUS201803130003','沃尔玛购物中心','山西','4','战略合作伙伴','500','3','11','1','1','1','1','1','1','2000','500','中国银行','1','1','1',0);

/*Table structure for table `customer_contact` */

DROP TABLE IF EXISTS `customer_contact`;

CREATE TABLE `customer_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `contact_time` date DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `overview` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `customer_contact` */

insert  into `customer_contact`(`id`,`customer_id`,`contact_time`,`address`,`overview`) values (1,37,'2018-02-14','王府井','吃饭，洽谈业务'),(2,37,'2018-02-06','美食街','吃饭，签署合作协议'),(3,36,'2018-02-06','蓝海国际大饭店','晚宴跟客户讨论方案'),(4,36,'2018-03-14','齐韵洗浴中心','洽谈业务，签署文件'),(5,35,'2018-03-14','银座家居','调研家具市场经营模式'),(6,34,'2018-03-14','121','12'),(7,33,'2018-03-14','23','23');

/*Table structure for table `customer_link_man` */

DROP TABLE IF EXISTS `customer_link_man`;

CREATE TABLE `customer_link_man` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `link_name` varchar(30) DEFAULT NULL,
  `sex` varchar(30) DEFAULT NULL,
  `job` varchar(60) DEFAULT NULL,
  `office_phone` varchar(60) DEFAULT NULL,
  `cellphone` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;

/*Data for the table `customer_link_man` */

insert  into `customer_link_man`(`id`,`customer_id`,`link_name`,`sex`,`job`,`office_phone`,`cellphone`) values (101,35,'张福强','男','老板','2333','2334'),(102,36,'王宇飞','男','采购主管','900','8002'),(103,36,'王群','男','业务主管','987','789'),(105,37,'张小凡','男','业务员','11','22'),(106,37,'李金芝','女','经理','123','322123'),(109,37,'王世龙','男','老板','666','6667');

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(200) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `store` int(11) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `product` */

insert  into `product`(`id`,`product_name`,`model`,`unit`,`price`,`store`,`remark`) values (1,'战爵笔记本散热器','Z1-82450','个','89.00',220,'实用'),(2,'酷冷至尊CPU风扇','IK12-370','个','136.50',50,'高端'),(3,'红色风暴水冷CPU散热器','C90','个','310.00',20,'高端'),(4,'外星人吃鸡游戏笔记本电脑散热器','COOLCOLD','个','135.00',40,'好用'),(5,'抽风式游戏本散热器','吹雪','件','235.00',60,'实惠'),(6,'影驰铁甲战将系列固态硬盘','JMF608','个','379.00',300,'厉害了'),(7,'122','1222','1','1.00',1,'1'),(11,'23','23','23','23.00',NULL,''),(12,'445','5','45','45.00',45,'45');

/*Table structure for table `sale_chance` */

DROP TABLE IF EXISTS `sale_chance`;

CREATE TABLE `sale_chance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chance_source` varchar(200) DEFAULT NULL,
  `customer_name` varchar(200) DEFAULT NULL,
  `cgjl` int(11) DEFAULT NULL,
  `overview` varchar(100) DEFAULT NULL,
  `link_man` varchar(30) DEFAULT NULL,
  `link_phone` varchar(30) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `create_man` varchar(30) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `assign_man` varchar(30) DEFAULT NULL,
  `assign_time` datetime DEFAULT NULL,
  `current_state` int(11) DEFAULT NULL,
  `dev_result` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

/*Data for the table `sale_chance` */

insert  into `sale_chance`(`id`,`chance_source`,`customer_name`,`cgjl`,`overview`,`link_man`,`link_phone`,`description`,`create_man`,`create_time`,`assign_man`,`assign_time`,`current_state`,`dev_result`) values (1,'主动上门','万鞍智能科技',100,'有意向采购笔记本散热器','张世龙','17180135274','诚意满满，对方急需','艾伦','2018-03-07 16:23:06','4','2018-03-07 19:09:15',1,2),(21,'行业协会介绍','汇金科技',80,'部署Oracle数据库，数据备份，容灾处理','李先生','0533-3081234','公司运维跳槽，急需技术服务支持','艾伦','2018-03-07 16:26:33','4','2018-03-07 19:09:43',1,3),(22,'同行介绍','斐讯科技集团',60,'采购服务器意向','吴丹','2323223','新上大数据项目，急需大型存储设施','史密斯','2018-03-07 16:28:35','5','2018-03-07 19:10:06',1,2),(30,'端午节活动推广','天利和软件科技',80,'定制一批监控摄像头','李先栋','123','很有机会','艾伦','2018-03-07 18:44:10','5','2018-03-07 19:12:56',1,2),(31,'主动上门','赛博软件',70,'意向采购一批安卓智能手机','王小姐','999','描述','艾伦','2018-03-07 19:08:42','3','2018-03-07 19:15:16',1,3),(32,'主动上门','百利医药',40,'意向解决医药系统升级问题','王希宝','456','工作人员不懂IT，不会升级系统','艾伦','2018-03-07 19:15:24','3','2018-03-07 19:25:08',1,1),(34,'QQ消息推广','一美天成美容整形医院',75,'意向做一个企业站进行业务推广宣传','何女士','234','该医院希望借助互联网+推动业务继续拓展','史密斯','2018-03-07 19:17:36','5','2018-03-07 19:27:03',1,1),(35,'微信公众号推广','齐商银行',30,'意向采购加密卡','王先生','899','。。。','史密斯','2018-03-07 19:18:05','5','2018-03-07 19:18:21',1,1),(36,'网络推广','兆物网络科技集团',90,'采购一批硬盘','刘女士','3334','该急需解决海量数据的存储问题','史密斯','2018-03-07 19:19:17','',NULL,0,0);

/*Table structure for table `sys_data_dic` */

DROP TABLE IF EXISTS `sys_data_dic`;

CREATE TABLE `sys_data_dic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_dic_name` varchar(60) DEFAULT NULL,
  `data_dic_value` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_t_datadic` (`data_dic_value`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `sys_data_dic` */

insert  into `sys_data_dic`(`id`,`data_dic_name`,`data_dic_value`) values (1,'客户等级','普通客户'),(2,'客户等级','重点开发客户'),(3,'客户等级','大客户'),(4,'客户等级','合作伙伴'),(5,'客户等级','战略合作伙伴'),(6,'服务类型','咨询'),(7,'服务类型','建议'),(8,'服务类型','投诉'),(12,'服务类型','1'),(13,'服务类型','2'),(14,'服务类型','2333'),(16,'服务类型','23'),(17,'服务类型','4455'),(18,'客户地区','北京'),(19,'客户地区','广州'),(20,'客户地区','山东'),(21,'客户地区','江苏'),(22,'客户地区','河北'),(23,'客户地区','山西'),(24,'客户地区','内蒙古');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `true_name` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `role_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`user_name`,`password`,`true_name`,`email`,`phone`,`role_name`) values (1,'www','111','管理员','1061863828@qq.com','17180135274','系统管理员'),(2,'allen','al','艾伦','json@qq.com','123321456654','销售主管'),(3,'smith','sm','史密斯','c@qq.com','123321','客户经理'),(4,'martin','ma','马丁','java@qq.com','111222','客户经理'),(5,'ford','fo','福特','vueJS@qq.com','22233345','客户经理'),(6,'clark','cl','克拉克','nodeJS@qq.com','77788899','人事经理'),(7,'king','ki','CEO','redis@qq.com','456','系统管理员'),(9,'miller','mi','米勒','redis@qq.com','4567','销售主管'),(16,'11','1','11','123','123','销售主管');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

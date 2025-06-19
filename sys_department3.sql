/*
SQLyog Ultimate v8.71 
MySQL - 8.0.13 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `sys_department` (
	`id` int (20),
	`parentId` int (20),
	`deptName` varchar (150),
	`manager` varchar (60),
	`email` varchar (150),
	`sort` int (11),
	`status` tinyint (1),
	`createBy` varchar (192),
	`createTime` datetime ,
	`updateBy` varchar (192),
	`updateTime` datetime ,
	`phone` varchar (60)
); 
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('1','0','测盟会','张会长','ceo@cemeng.com','1','0','admin','2023-01-01 09:00:00',NULL,NULL,'13800000001');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('2','1','深圳总公司','李总','sz@cemeng.com','10','0','admin','2023-01-02 09:00:00',NULL,NULL,'13800000002');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('3','1','长沙分公司','王总','cs@cemeng.com','20','0','admin','2023-01-02 10:00:00',NULL,NULL,'13800000003');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('4','1','北京总公司','赵总','bj@cemeng.com','30','0','admin','2023-01-02 11:00:00','admin','2023-06-01 14:30:00','13800000004');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('5','1','上海总公司','钱总','sh@cemeng.com','40','0','admin','2023-01-02 12:00:00',NULL,NULL,'13800000005');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('6','1','广州总公司','孙总','gz@cemeng.com','50','0','admin','2023-01-02 13:00:00','admin','2023-06-01 14:30:00','13800000006');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('7','2','研发部','张经理','rd-sz@cemeng.com','101','0','admin','2023-01-03 09:00:00',NULL,NULL,'13800010001');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('8','2','财务部','李经理','finance-sz@cemeng.com','102','0','admin','2023-01-03 09:30:00',NULL,NULL,'13800010002');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('9','2','人力资源部','王经理','hr-sz@cemeng.com','103','0','admin','2023-01-03 10:00:00',NULL,NULL,'13800010003');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('10','2','市场部','赵经理','market-sz@cemeng.com','104','0','admin','2023-01-03 10:30:00',NULL,NULL,'13800010004');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('11','2','行政部','钱经理','admin-sz@cemeng.com','105','0','admin','2023-01-03 11:00:00',NULL,NULL,'13800010005');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('12','2','客户服务部','孙经理','service-sz@cemeng.com','106','0','admin','2023-01-03 11:30:00','admin','2023-06-01 14:30:00','13800010006');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('13','3','研发部','张经理','rd-cs@cemeng.com','201','0','admin','2023-01-04 09:00:00',NULL,NULL,'13800020001');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('14','3','财务部','李经理','finance-cs@cemeng.com','202','0','admin','2023-01-04 09:30:00',NULL,NULL,'13800020002');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('15','3','人力资源部','王经理','hr-cs@cemeng.com','203','0','admin','2023-01-04 10:00:00',NULL,NULL,'13800020003');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('16','3','市场部','赵经理','market-cs@cemeng.com','204','0','admin','2023-01-04 10:30:00',NULL,NULL,'13800020004');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('17','3','行政部','钱经理','admin-cs@cemeng.com','205','0','admin','2023-01-04 11:00:00',NULL,NULL,'13800020005');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('18','3','技术支持部','孙经理','tech-cs@cemeng.com','206','0','admin','2023-01-04 11:30:00','admin','2023-06-01 14:30:00','13800020006');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('19','4','研发部','张经理','rd-bj@cemeng.com','301','0','admin','2023-01-05 09:00:00',NULL,NULL,'13800030001');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('20','4','财务部','李经理','finance-bj@cemeng.com','302','0','admin','2023-01-05 09:30:00',NULL,NULL,'13800030002');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('21','4','人力资源部','王经理','hr-bj@cemeng.com','303','0','admin','2023-01-05 10:00:00',NULL,NULL,'13800030003');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('22','4','市场部','赵经理','market-bj@cemeng.com','304','0','admin','2023-01-05 10:30:00',NULL,NULL,'13800030004');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('23','4','行政部','钱经理','admin-bj@cemeng.com','305','0','admin','2023-01-05 11:00:00',NULL,NULL,'13800030005');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('24','4','国际业务部','孙经理','global-bj@cemeng.com','306','0','admin','2023-01-05 11:30:00','admin','2023-06-01 14:30:00','13800030006');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('25','5','研发部','张经理','rd-sh@cemeng.com','401','0','admin','2023-01-06 09:00:00',NULL,NULL,'13800040001');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('26','5','财务部','李经理','finance-sh@cemeng.com','402','0','admin','2023-01-06 09:30:00',NULL,NULL,'13800040002');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('27','5','人力资源部','王经理','hr-sh@cemeng.com','403','0','admin','2023-01-06 10:00:00',NULL,NULL,'13800040003');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('28','5','市场部','赵经理','market-sh@cemeng.com','404','0','admin','2023-01-06 10:30:00',NULL,NULL,'13800040004');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('29','5','行政部','钱经理','admin-sh@cemeng.com','405','0','admin','2023-01-06 11:00:00',NULL,NULL,'13800040005');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('30','5','创新实验室','孙经理','lab-sh@cemeng.com','406','0','admin','2023-01-06 11:30:00','admin','2023-06-01 14:30:00','13800040006');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('31','6','研发部','张经理','rd-gz@cemeng.com','501','0','admin','2023-01-07 09:00:00',NULL,NULL,'13800050001');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('32','6','财务部','李经理','finance-gz@cemeng.com','502','0','admin','2023-01-07 09:30:00',NULL,NULL,'13800050002');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('33','6','人力资源部','王经理','hr-gz@cemeng.com','503','0','admin','2023-01-07 10:00:00',NULL,NULL,'13800050003');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('34','6','市场部','赵经理','market-gz@cemeng.com','504','0','admin','2023-01-07 10:30:00',NULL,NULL,'13800050004');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('35','6','行政部','钱经理','admin-gz@cemeng.com','505','0','admin','2023-01-07 11:00:00',NULL,NULL,'13800050005');
insert into `sys_department` (`id`, `parentId`, `deptName`, `manager`, `email`, `sort`, `status`, `createBy`, `createTime`, `updateBy`, `updateTime`, `phone`) values('36','6','物流管理部','孙经理','logistics-gz@cemeng.com','506','0','admin','2023-01-07 11:30:00','admin','2023-06-01 14:30:00','13800050006');

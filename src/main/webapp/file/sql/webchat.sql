/*
Navicat MySQL Data Transfer

Source Server         : Amayadream
Source Server Version : 50713
Source Host           : localhost:3306
Source Database       : webchat

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-01-11 19:26:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT ,
  `userid` varchar(255) DEFAULT NULL COMMENT '用户名',
  `time` varchar(255) DEFAULT NULL COMMENT '操作时间',
  `type` varchar(255) DEFAULT NULL COMMENT '操作类型',
  `detail` varchar(255) DEFAULT NULL COMMENT '详情',
  `ip` varchar(255) DEFAULT NULL COMMENT 'ip',
  KEY `fk_log_userid` (`userid`),
  CONSTRAINT `fk_log_userid` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
<<<<<<< HEAD
INSERT INTO `log` VALUES (1, 'SiceNovember', '2017-01-11 19:20:43', '登陆', '用户登陆', null);
=======
INSERT INTO `log` VALUES (1, 'SinceNovember', '2017-01-11 19:20:43', '登陆', '用户登陆', null);
>>>>>>> first commit


-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userid` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `sex` int(1) DEFAULT NULL COMMENT '性别',
  `age` int(5) DEFAULT NULL COMMENT '年龄',
  `profilehead` varchar(255) DEFAULT NULL COMMENT '头像',
  `profile` varchar(255) DEFAULT NULL COMMENT '简介',
  `firsttime` varchar(255) DEFAULT NULL COMMENT '注册时间',
  `lasttime` varchar(255) DEFAULT NULL COMMENT '最后登录时间',
  `status` int(1) DEFAULT NULL COMMENT '隐私(1可查看 -1静止查看)',
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
<<<<<<< HEAD
INSERT INTO `user` VALUES ('SinceNovember', '123456', 'SiceNovember', '1', '23', 'upload/Amayadream/Amayadream.jpg', '没有', '2017-01-11 19:22:21', '2017-01-11 19:22:21', '1');
=======
INSERT INTO `user` VALUES ('SinceNovember', '123456', 'SinceNovember', '1', '23', 'upload/Amayadream/Amayadream.jpg', '没有', '2017-01-11 19:22:21', '2017-01-11 19:22:21', '1');
>>>>>>> first commit
INSERT INTO `user` VALUES ('admin', 'admin', 'admin', '1', '23', 'upload/admin/admin.jpg', 'i\'m admin', '2017-01-11 19:22:21', '2017-01-11 19:23:20', '1');

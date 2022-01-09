/*
 Navicat Premium Data Transfer

 Source Server         : MySQL-Mac
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : nginx-consul

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 09/01/2022 15:44:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add 菜单', 6, 'add_menu');
INSERT INTO `auth_permission` VALUES (22, 'Can change 菜单', 6, 'change_menu');
INSERT INTO `auth_permission` VALUES (23, 'Can delete 菜单', 6, 'delete_menu');
INSERT INTO `auth_permission` VALUES (24, 'Can view 菜单', 6, 'view_menu');
INSERT INTO `auth_permission` VALUES (25, 'Can add 权限', 7, 'add_permission');
INSERT INTO `auth_permission` VALUES (26, 'Can change 权限', 7, 'change_permission');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 权限', 7, 'delete_permission');
INSERT INTO `auth_permission` VALUES (28, 'Can view 权限', 7, 'view_permission');
INSERT INTO `auth_permission` VALUES (29, 'Can add role', 8, 'add_role');
INSERT INTO `auth_permission` VALUES (30, 'Can change role', 8, 'change_role');
INSERT INTO `auth_permission` VALUES (31, 'Can delete role', 8, 'delete_role');
INSERT INTO `auth_permission` VALUES (32, 'Can view role', 8, 'view_role');
INSERT INTO `auth_permission` VALUES (33, 'Can add 组织架构', 9, 'add_organization');
INSERT INTO `auth_permission` VALUES (34, 'Can change 组织架构', 9, 'change_organization');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 组织架构', 9, 'delete_organization');
INSERT INTO `auth_permission` VALUES (36, 'Can view 组织架构', 9, 'view_organization');
INSERT INTO `auth_permission` VALUES (37, 'Can add 用户信息', 10, 'add_userprofile');
INSERT INTO `auth_permission` VALUES (38, 'Can change 用户信息', 10, 'change_userprofile');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 用户信息', 10, 'delete_userprofile');
INSERT INTO `auth_permission` VALUES (40, 'Can view 用户信息', 10, 'view_userprofile');
INSERT INTO `auth_permission` VALUES (41, 'Can add Nginx配置', 11, 'add_nginxconf');
INSERT INTO `auth_permission` VALUES (42, 'Can change Nginx配置', 11, 'change_nginxconf');
INSERT INTO `auth_permission` VALUES (43, 'Can delete Nginx配置', 11, 'delete_nginxconf');
INSERT INTO `auth_permission` VALUES (44, 'Can view Nginx配置', 11, 'view_nginxconf');
INSERT INTO `auth_permission` VALUES (45, 'Can add Nginx管理', 12, 'add_nginxmodel');
INSERT INTO `auth_permission` VALUES (46, 'Can change Nginx管理', 12, 'change_nginxmodel');
INSERT INTO `auth_permission` VALUES (47, 'Can delete Nginx管理', 12, 'delete_nginxmodel');
INSERT INTO `auth_permission` VALUES (48, 'Can view Nginx管理', 12, 'view_nginxmodel');
INSERT INTO `auth_permission` VALUES (49, 'Can add nginx instance ops', 13, 'add_nginxinstanceops');
INSERT INTO `auth_permission` VALUES (50, 'Can change nginx instance ops', 13, 'change_nginxinstanceops');
INSERT INTO `auth_permission` VALUES (51, 'Can delete nginx instance ops', 13, 'delete_nginxinstanceops');
INSERT INTO `auth_permission` VALUES (52, 'Can view nginx instance ops', 13, 'view_nginxinstanceops');
INSERT INTO `auth_permission` VALUES (53, 'Can add nginx action', 14, 'add_nginxaction');
INSERT INTO `auth_permission` VALUES (54, 'Can change nginx action', 14, 'change_nginxaction');
INSERT INTO `auth_permission` VALUES (55, 'Can delete nginx action', 14, 'delete_nginxaction');
INSERT INTO `auth_permission` VALUES (56, 'Can view nginx action', 14, 'view_nginxaction');
COMMIT;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_user_userprofile_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `user_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `django_admin_log` VALUES (1, '2021-08-06 04:30:13.489448', '1', '信也科技', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (2, '2021-08-06 04:30:28.669756', '2', '系统运维', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (3, '2021-08-06 04:30:53.880499', '1', '老男孩', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (4, '2021-08-06 04:57:20.890413', '1', '系统管理', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (5, '2021-08-06 04:59:22.274786', '2', '用户管理', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (6, '2021-08-06 05:00:10.132567', '3', '菜单管理', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (7, '2021-08-06 05:00:59.075185', '4', '角色管理', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (8, '2021-08-06 05:01:37.959424', '5', '权限管理', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (9, '2021-08-06 05:02:21.267566', '6', '组织架构', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (10, '2021-08-06 05:03:33.116293', '7', 'Nginx管理', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (11, '2021-08-06 05:04:51.115738', '8', '集群管理', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (12, '2021-08-06 05:05:27.560047', '9', '配置管理', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (13, '2021-08-06 05:06:46.160360', '10', '操作日志', 1, '[{\"added\": {}}]', 6, 1);
INSERT INTO `django_admin_log` VALUES (14, '2021-08-06 05:11:13.134288', '1', 'Role object (1)', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (15, '2021-08-06 05:15:20.751942', '2', '普通用户', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (16, '2021-08-06 05:15:43.814669', '3', 'ops操作组', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (17, '2021-08-06 05:20:47.517853', '1', '系统管理员', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (18, '2021-08-06 05:21:54.355370', '2', '普通用户', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (19, '2021-08-06 05:23:06.725729', '3', 'ops操作组', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (20, '2021-08-06 05:25:05.689421', '43', 'F5集群', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (21, '2021-08-06 05:25:05.691852', '44', 'f5集群创建', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (22, '2021-08-06 05:25:05.694321', '45', 'f5集群列表', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (23, '2021-08-06 05:25:05.696280', '46', 'f5集群编辑', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (24, '2021-08-06 05:25:05.698041', '47', 'f5集群删除', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (25, '2021-08-06 05:25:05.699990', '48', 'LVS集群', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (26, '2021-08-06 05:25:05.702006', '49', 'lvs集群列表', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (27, '2021-08-06 05:25:05.703921', '50', 'lvs集群创建', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (28, '2021-08-06 05:25:05.705912', '51', 'lvs集群编辑', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (29, '2021-08-06 05:25:05.707945', '52', 'lvs集群删除', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (30, '2021-08-06 05:25:05.710286', '53', 'ES集群配置', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (31, '2021-08-06 05:25:05.712336', '54', 'es集群列表', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (32, '2021-08-06 05:25:05.713996', '55', 'es集群创建', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (33, '2021-08-06 05:25:05.715978', '56', 'es集群编辑', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (34, '2021-08-06 05:25:05.717902', '57', 'es集群删除', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (35, '2021-08-06 11:57:46.111319', '1', 'consul-api-running', 2, '[{\"changed\": {\"fields\": [\"template\"]}}]', 12, 1);
INSERT INTO `django_admin_log` VALUES (36, '2021-08-06 11:59:02.237608', '1', 'www.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (37, '2021-08-06 11:59:58.623951', '3', 'www.ob2api.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (38, '2021-08-06 12:00:43.194054', '2', 'www.ob1api.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (39, '2021-08-06 12:01:02.839428', '1', 'consul-api-running', 2, '[]', 12, 1);
INSERT INTO `django_admin_log` VALUES (40, '2021-08-06 12:02:33.652616', '1', 'www.obapi.com-running-running', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` VALUES (41, '2021-08-06 12:02:44.857616', '2', 'www.ob2api.com-running-running', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` VALUES (42, '2021-08-06 12:02:55.437399', '3', 'www.ob1api.com-running-running', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` VALUES (43, '2021-08-06 12:03:29.566366', '1', 'www.ob2api.com-running-running-running', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (44, '2021-08-06 12:03:48.785117', '2', 'www.ob1api.com-running-running-success', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (45, '2021-08-06 12:05:46.159002', '3', 'www.obapi.com-running-running-failed', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (46, '2021-08-07 09:01:09.117010', '2', 'dgt', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (47, '2021-08-11 12:48:12.858988', '10', 'system-manage', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (48, '2021-08-11 12:48:46.923320', '24', '组织创建', 2, '[{\"changed\": {\"fields\": [\"sign\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (49, '2021-08-11 12:49:26.742179', '24', '组织创建', 2, '[{\"changed\": {\"fields\": [\"sign\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (50, '2021-08-11 12:49:46.274696', '2', 'dgt', 2, '[{\"changed\": {\"fields\": [\"roles\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (51, '2021-08-11 12:52:32.089783', '8', 'test', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (52, '2021-08-11 12:52:40.839672', '2', 'dgt', 2, '[]', 10, 1);
INSERT INTO `django_admin_log` VALUES (53, '2021-08-11 13:29:10.903864', '8', 'test', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (54, '2021-08-11 14:12:02.675911', '10', 'system-manage', 3, '', 8, 1);
INSERT INTO `django_admin_log` VALUES (55, '2021-08-11 14:12:33.567346', '9', 'nginx管理员', 3, '', 8, 1);
INSERT INTO `django_admin_log` VALUES (56, '2021-08-11 14:12:33.579848', '8', 'test', 3, '', 8, 1);
INSERT INTO `django_admin_log` VALUES (57, '2021-08-11 14:12:33.590797', '7', '查看系统管理菜单', 3, '', 8, 1);
INSERT INTO `django_admin_log` VALUES (58, '2021-08-11 14:12:33.603488', '6', '查看Nginx', 3, '', 8, 1);
INSERT INTO `django_admin_log` VALUES (59, '2021-08-11 14:14:25.788671', '11', 'system-manage', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (60, '2021-08-11 14:14:38.504051', '2', 'dgt', 2, '[{\"changed\": {\"fields\": [\"roles\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (61, '2021-08-12 00:42:53.631617', '4', 'test', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (62, '2021-08-12 00:45:22.290566', '14', 'teset', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (63, '2021-08-12 00:45:34.150419', '4', 'test', 2, '[{\"changed\": {\"fields\": [\"roles\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (64, '2021-08-12 00:50:12.889603', '11', 'system-manage', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (65, '2021-08-12 00:56:41.223155', '11', 'system-manage', 2, '[]', 8, 1);
INSERT INTO `django_admin_log` VALUES (66, '2021-08-12 00:58:41.424933', '14', 'teset', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (67, '2021-08-12 01:04:13.461450', '14', 'teset', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (68, '2021-08-12 01:19:02.842859', '1', '系统管理员', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (69, '2021-08-12 01:25:40.865492', '14', 'teset', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (70, '2021-08-12 02:26:56.835389', '14', 'teset', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (71, '2021-08-12 02:43:23.259027', '14', 'test角色', 2, '[{\"changed\": {\"fields\": [\"name\", \"desc\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (72, '2021-08-12 07:27:50.564733', '17', 'luffy16.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (73, '2021-08-12 07:28:53.934706', '16', 'luffy15.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (74, '2021-08-12 07:30:05.562492', '13', 'luffy14.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (75, '2021-08-12 07:30:42.520059', '16', 'luffy15.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (76, '2021-08-12 07:31:34.561557', '10', 'luffy13.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (77, '2021-08-12 07:32:23.188507', '17', 'luffy16.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (78, '2021-08-12 07:32:56.147020', '13', 'luffy14.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (79, '2021-08-12 07:33:31.835006', '10', 'luffy13.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (80, '2021-08-12 07:34:31.591695', '9', 'luffy12.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (81, '2021-08-12 07:35:24.105804', '8', 'luffy11.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (82, '2021-08-12 07:37:12.494381', '7', 'luffy10.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (83, '2021-08-12 07:38:23.835470', '6', 'luffy9.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (84, '2021-08-12 07:39:21.453502', '5', 'luffy8.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (85, '2021-08-12 07:40:25.524292', '4', 'luffy7.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (86, '2021-08-12 07:41:19.598443', '2', 'luffy6.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (87, '2021-08-12 07:42:10.366384', '1', 'luffy5.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"name\", \"content\", \"comments\", \"conf_add_status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (88, '2021-08-12 07:42:52.640148', '16', 'luffy15.obapi.com-running', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` VALUES (89, '2021-08-12 07:43:11.715256', '17', 'luffy16.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (90, '2021-08-12 07:43:22.771077', '16', 'luffy15.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (91, '2021-08-12 07:43:36.728763', '13', 'luffy14.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (92, '2021-08-12 07:43:53.158735', '10', 'luffy13.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (93, '2021-08-12 07:44:09.015002', '9', 'luffy12.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\", \"conf_add_status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (94, '2021-08-12 07:44:28.502130', '8', 'luffy11.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\", \"conf_add_status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (95, '2021-08-12 07:44:45.185126', '7', 'luffy10.obapi.com-running', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` VALUES (96, '2021-08-12 07:44:55.892793', '6', 'luffy9.obapi.com-running', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` VALUES (97, '2021-08-12 07:45:02.864724', '5', 'luffy8.obapi.com-running', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` VALUES (98, '2021-08-12 07:46:34.775230', '18', 'luffy1.obapi.com-running', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (99, '2021-08-12 07:46:52.103161', '18', 'luffy1.obapi.com-running', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` VALUES (100, '2021-08-12 07:46:54.989015', '18', 'luffy1.obapi.com-running', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` VALUES (101, '2021-08-12 07:48:32.599307', '19', 'luffy2.obapi.com-running', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (102, '2021-08-12 07:50:28.274534', '20', 'luffy3.obapi.com-running', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (103, '2021-08-12 07:53:13.521468', '5', 'luffy8.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (104, '2021-08-12 07:53:51.321244', '4', 'test', 2, '[{\"changed\": {\"fields\": [\"department\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (105, '2021-08-12 07:53:52.271431', '2', 'luffy6.obapi.com-running', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` VALUES (106, '2021-08-12 07:54:08.482304', '1', 'luffy5.obapi.com-running', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` VALUES (107, '2021-08-12 07:56:12.402972', '21', 'luffy4.obapi.com-running', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (108, '2021-08-12 08:00:54.617091', '19', 'luffy2.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"type\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (109, '2021-08-12 08:01:14.664568', '17', 'luffy16.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"type\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (110, '2021-08-12 08:01:22.747135', '16', 'luffy15.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"type\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (111, '2021-08-12 08:46:24.844142', '6', 'luffy9.obapi.com-running', 2, '[{\"changed\": {\"fields\": [\"content\"]}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (112, '2021-08-12 12:34:56.787187', '65', '系统管理', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (113, '2021-08-12 12:36:26.551934', '2', '用户管理', 2, '[{\"changed\": {\"fields\": [\"sign\", \"method\", \"pid\", \"desc\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (114, '2021-08-12 12:37:22.410246', '12', '角色管理', 2, '[{\"changed\": {\"fields\": [\"sign\", \"method\", \"pid\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (115, '2021-08-12 12:38:04.087208', '17', '权限管理', 2, '[{\"changed\": {\"fields\": [\"sign\", \"method\", \"path\", \"pid\", \"desc\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (116, '2021-08-12 12:38:32.000589', '22', '组织管理', 2, '[{\"changed\": {\"fields\": [\"sign\", \"method\", \"pid\", \"desc\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (117, '2021-08-12 12:39:00.173249', '7', '菜单管理', 2, '[{\"changed\": {\"fields\": [\"sign\", \"method\", \"pid\", \"desc\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (118, '2021-08-12 12:40:08.535481', '14', 'test角色', 2, '[{\"changed\": {\"fields\": [\"permissions\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (119, '2021-08-12 12:44:43.406860', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"last_login\", \"roles\"]}}]', 10, 1);
COMMIT;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (14, 'nginx', 'nginxaction');
INSERT INTO `django_content_type` VALUES (11, 'nginx', 'nginxconf');
INSERT INTO `django_content_type` VALUES (13, 'nginx', 'nginxinstanceops');
INSERT INTO `django_content_type` VALUES (12, 'nginx', 'nginxmodel');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (6, 'user', 'menu');
INSERT INTO `django_content_type` VALUES (9, 'user', 'organization');
INSERT INTO `django_content_type` VALUES (7, 'user', 'permission');
INSERT INTO `django_content_type` VALUES (8, 'user', 'role');
INSERT INTO `django_content_type` VALUES (10, 'user', 'userprofile');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2021-08-06 03:59:55.666991');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2021-08-06 03:59:55.701718');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2021-08-06 03:59:55.745145');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2021-08-06 03:59:55.816483');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2021-08-06 03:59:55.825273');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2021-08-06 03:59:55.833230');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2021-08-06 03:59:55.841384');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2021-08-06 03:59:55.844763');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2021-08-06 03:59:55.852377');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2021-08-06 03:59:55.859999');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2021-08-06 03:59:55.868284');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2021-08-06 03:59:55.885491');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2021-08-06 03:59:55.894880');
INSERT INTO `django_migrations` VALUES (14, 'user', '0001_initial', '2021-08-06 03:59:56.056449');
INSERT INTO `django_migrations` VALUES (15, 'admin', '0001_initial', '2021-08-06 03:59:56.429130');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0002_logentry_remove_auto_add', '2021-08-06 03:59:56.466485');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0003_logentry_add_action_flag_choices', '2021-08-06 03:59:56.480577');
INSERT INTO `django_migrations` VALUES (18, 'sessions', '0001_initial', '2021-08-06 03:59:56.496331');
INSERT INTO `django_migrations` VALUES (19, 'nginx', '0001_initial', '2021-08-06 08:53:21.158868');
INSERT INTO `django_migrations` VALUES (20, 'user', '0002_remove_userprofile_image', '2021-08-07 13:18:10.370857');
INSERT INTO `django_migrations` VALUES (21, 'user', '0003_auto_20210810_1150', '2021-08-14 07:21:09.941467');
INSERT INTO `django_migrations` VALUES (22, 'user', '0004_auto_20210814_1518', '2021-08-14 07:21:09.996655');
INSERT INTO `django_migrations` VALUES (23, 'user', '0002_auto_20210814_1548', '2021-08-14 08:00:04.051682');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` VALUES ('18plfffefzuoadclceugiklo4nvxwovj', 'YTViMzMyZDBlNWYyNTFlOTYwZjMzZjM2MTUxOTI0ZDU5ZTU1NmU0Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NjA4MjFhYTM3ODBlZTI2NTFiYTlmNmE3MjgwYmRjMmNkYzMzMzVjIiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhBY3Rpb25cXHU4YmU2XFx1NjBjNVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9uZ2lueC9uZ2lueGFjdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhhY3Rpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54QWN0aW9uXFx1OGJlNlxcdTYwYzVcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDAyfSwge1wibmFtZVwiOiBcIk5naW54XFx1NjRjZFxcdTRmNWNcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU2NGNkXFx1NGY1Y1xcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU3YmExXFx1NzQwNlwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54XFx1N2JhMVxcdTc0MDZcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDR9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU5MTRkXFx1N2Y2ZVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54Y29uZi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhjb25mL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIk5naW54XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJOZ2lueFxcdTkxNGRcXHU3ZjZlXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA1fV0sIFwiZWlkXCI6IDEwMDF9LCB7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiXFx1Njc0M1xcdTk2NTBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL3Blcm1pc3Npb24vXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL3VzZXIvcGVybWlzc2lvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU2NzQzXFx1OTY1MFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwN30sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA4fSwge1wibmFtZVwiOiBcIlxcdTdlYzRcXHU3ZWM3XFx1NjdiNlxcdTY3ODRcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL29yZ2FuaXphdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9vcmdhbml6YXRpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFxcdTdlYzdcXHU2N2I2XFx1Njc4NFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwOX0sIHtcIm5hbWVcIjogXCJcXHU4OWQyXFx1ODI3MlwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL3VzZXIvcm9sZS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9yb2xlL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlVzZXJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTg5ZDJcXHU4MjcyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDEwfV0sIFwiZWlkXCI6IDEwMDZ9LCB7XCJuYW1lXCI6IFwiXFx1OGJhNFxcdThiYzFcXHU1NDhjXFx1NjM4OFxcdTY3NDNcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXNoaWVsZC1hbHRcIiwgXCJtb2RlbHNcIjogW3tcIm5hbWVcIjogXCJcXHU3ZWM0XCIsIFwiaWNvblwiOiBcImZhcyBmYS11c2Vycy1jb2dcIiwgXCJ1cmxcIjogXCIvYWRtaW4vYXV0aC9ncm91cC9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vYXV0aC9ncm91cC9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJcXHU4YmE0XFx1OGJjMVxcdTU0OGNcXHU2Mzg4XFx1Njc0M1wiLCBcImljb25cIjogXCJmYXMgZmEtc2hpZWxkLWFsdFwifSwge1wibmFtZVwiOiBcIlxcdTdlYzRcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXVzZXJzLWNvZ1wifV0sIFwiZWlkXCI6IDEwMTJ9XSwgXCJlaWRcIjogMTAxMX1dIn0=', '2021-09-02 14:32:54.702374');
INSERT INTO `django_session` VALUES ('3qatujixymzgjxn7mc7q71yy6hkfq89f', 'NWYyMzAzNTQ5OTE1MTc1OTM1MmJlZTJlNWI1NmM0NzUyNDRkYTI5Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NjA4MjFhYTM3ODBlZTI2NTFiYTlmNmE3MjgwYmRjMmNkYzMzMzVjIiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhBY3Rpb25cXHU4YmU2XFx1NjBjNVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9uZ2lueC9uZ2lueGFjdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhhY3Rpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54QWN0aW9uXFx1OGJlNlxcdTYwYzVcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDAyfSwge1wibmFtZVwiOiBcIk5naW54XFx1NjRjZFxcdTRmNWNcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU2NGNkXFx1NGY1Y1xcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU3YmExXFx1NzQwNlwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54XFx1N2JhMVxcdTc0MDZcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDR9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU5MTRkXFx1N2Y2ZVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54Y29uZi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhjb25mL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIk5naW54XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJOZ2lueFxcdTkxNGRcXHU3ZjZlXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA1fV0sIFwiZWlkXCI6IDEwMDF9LCB7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiXFx1Njc0M1xcdTk2NTBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL3Blcm1pc3Npb24vXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL3VzZXIvcGVybWlzc2lvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU2NzQzXFx1OTY1MFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwN30sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA4fSwge1wibmFtZVwiOiBcIlxcdTdlYzRcXHU3ZWM3XFx1NjdiNlxcdTY3ODRcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL29yZ2FuaXphdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9vcmdhbml6YXRpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFxcdTdlYzdcXHU2N2I2XFx1Njc4NFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwOX0sIHtcIm5hbWVcIjogXCJcXHU4M2RjXFx1NTM1NVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL3VzZXIvbWVudS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9tZW51L2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlVzZXJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTgzZGNcXHU1MzU1XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDEwfSwge1wibmFtZVwiOiBcIlxcdTg5ZDJcXHU4MjcyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci9yb2xlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi91c2VyL3JvbGUvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1ODlkMlxcdTgyNzJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMTF9XSwgXCJlaWRcIjogMTAwNn0sIHtcIm5hbWVcIjogXCJcXHU4YmE0XFx1OGJjMVxcdTU0OGNcXHU2Mzg4XFx1Njc0M1wiLCBcImljb25cIjogXCJmYXMgZmEtc2hpZWxkLWFsdFwiLCBcIm1vZGVsc1wiOiBbe1wibmFtZVwiOiBcIlxcdTdlYzRcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXVzZXJzLWNvZ1wiLCBcInVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdThiYTRcXHU4YmMxXFx1NTQ4Y1xcdTYzODhcXHU2NzQzXCIsIFwiaWNvblwiOiBcImZhcyBmYS1zaGllbGQtYWx0XCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFwiLCBcImljb25cIjogXCJmYXMgZmEtdXNlcnMtY29nXCJ9XSwgXCJlaWRcIjogMTAxM31dLCBcImVpZFwiOiAxMDEyfV0ifQ==', '2021-08-26 12:44:21.202595');
INSERT INTO `django_session` VALUES ('5103m2e1x909a1rbd2lz45ojxtovpyw3', 'NWYyMzAzNTQ5OTE1MTc1OTM1MmJlZTJlNWI1NmM0NzUyNDRkYTI5Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NjA4MjFhYTM3ODBlZTI2NTFiYTlmNmE3MjgwYmRjMmNkYzMzMzVjIiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhBY3Rpb25cXHU4YmU2XFx1NjBjNVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9uZ2lueC9uZ2lueGFjdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhhY3Rpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54QWN0aW9uXFx1OGJlNlxcdTYwYzVcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDAyfSwge1wibmFtZVwiOiBcIk5naW54XFx1NjRjZFxcdTRmNWNcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU2NGNkXFx1NGY1Y1xcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU3YmExXFx1NzQwNlwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54XFx1N2JhMVxcdTc0MDZcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDR9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU5MTRkXFx1N2Y2ZVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54Y29uZi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhjb25mL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIk5naW54XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJOZ2lueFxcdTkxNGRcXHU3ZjZlXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA1fV0sIFwiZWlkXCI6IDEwMDF9LCB7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiXFx1Njc0M1xcdTk2NTBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL3Blcm1pc3Npb24vXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL3VzZXIvcGVybWlzc2lvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU2NzQzXFx1OTY1MFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwN30sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA4fSwge1wibmFtZVwiOiBcIlxcdTdlYzRcXHU3ZWM3XFx1NjdiNlxcdTY3ODRcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL29yZ2FuaXphdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9vcmdhbml6YXRpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFxcdTdlYzdcXHU2N2I2XFx1Njc4NFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwOX0sIHtcIm5hbWVcIjogXCJcXHU4M2RjXFx1NTM1NVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL3VzZXIvbWVudS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9tZW51L2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlVzZXJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTgzZGNcXHU1MzU1XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDEwfSwge1wibmFtZVwiOiBcIlxcdTg5ZDJcXHU4MjcyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci9yb2xlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi91c2VyL3JvbGUvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1ODlkMlxcdTgyNzJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMTF9XSwgXCJlaWRcIjogMTAwNn0sIHtcIm5hbWVcIjogXCJcXHU4YmE0XFx1OGJjMVxcdTU0OGNcXHU2Mzg4XFx1Njc0M1wiLCBcImljb25cIjogXCJmYXMgZmEtc2hpZWxkLWFsdFwiLCBcIm1vZGVsc1wiOiBbe1wibmFtZVwiOiBcIlxcdTdlYzRcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXVzZXJzLWNvZ1wiLCBcInVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdThiYTRcXHU4YmMxXFx1NTQ4Y1xcdTYzODhcXHU2NzQzXCIsIFwiaWNvblwiOiBcImZhcyBmYS1zaGllbGQtYWx0XCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFwiLCBcImljb25cIjogXCJmYXMgZmEtdXNlcnMtY29nXCJ9XSwgXCJlaWRcIjogMTAxM31dLCBcImVpZFwiOiAxMDEyfV0ifQ==', '2021-08-26 07:53:35.046360');
INSERT INTO `django_session` VALUES ('60li2ytjy9vflcuy3ae6ab1f5tyycqvh', 'ZWUzYTczZDY4ZDJmNTE2ZjQwNjBkYmFjNzU5ZDIwZTg3ODk1MTA5Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NjA4MjFhYTM3ODBlZTI2NTFiYTlmNmE3MjgwYmRjMmNkYzMzMzVjIiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJtb2RlbHNcIjogW3tcIm5hbWVcIjogXCJcXHU2NzQzXFx1OTY1MFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL3VzZXIvcGVybWlzc2lvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9wZXJtaXNzaW9uL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlVzZXJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTY3NDNcXHU5NjUwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDAyfSwge1wibmFtZVwiOiBcIlxcdTc1MjhcXHU2MjM3XFx1NGZlMVxcdTYwNmZcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL3VzZXJwcm9maWxlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi91c2VyL3VzZXJwcm9maWxlL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlVzZXJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTc1MjhcXHU2MjM3XFx1NGZlMVxcdTYwNmZcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFxcdTdlYzdcXHU2N2I2XFx1Njc4NFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL3VzZXIvb3JnYW5pemF0aW9uL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi91c2VyL29yZ2FuaXphdGlvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3ZWM0XFx1N2VjN1xcdTY3YjZcXHU2Nzg0XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA0fSwge1wibmFtZVwiOiBcIlxcdTgzZGNcXHU1MzU1XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci9tZW51L1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi91c2VyL21lbnUvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1ODNkY1xcdTUzNTVcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDV9LCB7XCJuYW1lXCI6IFwiXFx1ODlkMlxcdTgyNzJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL3JvbGUvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL3VzZXIvcm9sZS9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU4OWQyXFx1ODI3MlwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwNn1dLCBcImVpZFwiOiAxMDAxfSwge1wibmFtZVwiOiBcIlxcdThiYTRcXHU4YmMxXFx1NTQ4Y1xcdTYzODhcXHU2NzQzXCIsIFwiaWNvblwiOiBcImZhcyBmYS1zaGllbGQtYWx0XCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiXFx1N2VjNFwiLCBcImljb25cIjogXCJmYXMgZmEtdXNlcnMtY29nXCIsIFwidXJsXCI6IFwiL2FkbWluL2F1dGgvZ3JvdXAvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL2F1dGgvZ3JvdXAvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1OGJhNFxcdThiYzFcXHU1NDhjXFx1NjM4OFxcdTY3NDNcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXNoaWVsZC1hbHRcIn0sIHtcIm5hbWVcIjogXCJcXHU3ZWM0XCIsIFwiaWNvblwiOiBcImZhcyBmYS11c2Vycy1jb2dcIn1dLCBcImVpZFwiOiAxMDA4fV0sIFwiZWlkXCI6IDEwMDd9XSJ9', '2021-08-20 05:23:15.588861');
INSERT INTO `django_session` VALUES ('85yny94a1s5ohk63zvrineo4o6991n9e', 'NWYyMzAzNTQ5OTE1MTc1OTM1MmJlZTJlNWI1NmM0NzUyNDRkYTI5Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NjA4MjFhYTM3ODBlZTI2NTFiYTlmNmE3MjgwYmRjMmNkYzMzMzVjIiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhBY3Rpb25cXHU4YmU2XFx1NjBjNVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9uZ2lueC9uZ2lueGFjdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhhY3Rpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54QWN0aW9uXFx1OGJlNlxcdTYwYzVcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDAyfSwge1wibmFtZVwiOiBcIk5naW54XFx1NjRjZFxcdTRmNWNcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU2NGNkXFx1NGY1Y1xcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU3YmExXFx1NzQwNlwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54XFx1N2JhMVxcdTc0MDZcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDR9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU5MTRkXFx1N2Y2ZVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54Y29uZi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhjb25mL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIk5naW54XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJOZ2lueFxcdTkxNGRcXHU3ZjZlXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA1fV0sIFwiZWlkXCI6IDEwMDF9LCB7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiXFx1Njc0M1xcdTk2NTBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL3Blcm1pc3Npb24vXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL3VzZXIvcGVybWlzc2lvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU2NzQzXFx1OTY1MFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwN30sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA4fSwge1wibmFtZVwiOiBcIlxcdTdlYzRcXHU3ZWM3XFx1NjdiNlxcdTY3ODRcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL29yZ2FuaXphdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9vcmdhbml6YXRpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFxcdTdlYzdcXHU2N2I2XFx1Njc4NFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwOX0sIHtcIm5hbWVcIjogXCJcXHU4M2RjXFx1NTM1NVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL3VzZXIvbWVudS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9tZW51L2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlVzZXJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTgzZGNcXHU1MzU1XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDEwfSwge1wibmFtZVwiOiBcIlxcdTg5ZDJcXHU4MjcyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci9yb2xlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi91c2VyL3JvbGUvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1ODlkMlxcdTgyNzJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMTF9XSwgXCJlaWRcIjogMTAwNn0sIHtcIm5hbWVcIjogXCJcXHU4YmE0XFx1OGJjMVxcdTU0OGNcXHU2Mzg4XFx1Njc0M1wiLCBcImljb25cIjogXCJmYXMgZmEtc2hpZWxkLWFsdFwiLCBcIm1vZGVsc1wiOiBbe1wibmFtZVwiOiBcIlxcdTdlYzRcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXVzZXJzLWNvZ1wiLCBcInVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdThiYTRcXHU4YmMxXFx1NTQ4Y1xcdTYzODhcXHU2NzQzXCIsIFwiaWNvblwiOiBcImZhcyBmYS1zaGllbGQtYWx0XCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFwiLCBcImljb25cIjogXCJmYXMgZmEtdXNlcnMtY29nXCJ9XSwgXCJlaWRcIjogMTAxM31dLCBcImVpZFwiOiAxMDEyfV0ifQ==', '2021-08-26 02:21:04.907226');
INSERT INTO `django_session` VALUES ('8atzhywoh5bf1rbtcrzhyq2l01sdpa1p', 'NWYyMzAzNTQ5OTE1MTc1OTM1MmJlZTJlNWI1NmM0NzUyNDRkYTI5Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NjA4MjFhYTM3ODBlZTI2NTFiYTlmNmE3MjgwYmRjMmNkYzMzMzVjIiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhBY3Rpb25cXHU4YmU2XFx1NjBjNVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9uZ2lueC9uZ2lueGFjdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhhY3Rpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54QWN0aW9uXFx1OGJlNlxcdTYwYzVcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDAyfSwge1wibmFtZVwiOiBcIk5naW54XFx1NjRjZFxcdTRmNWNcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU2NGNkXFx1NGY1Y1xcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU3YmExXFx1NzQwNlwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54XFx1N2JhMVxcdTc0MDZcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDR9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU5MTRkXFx1N2Y2ZVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54Y29uZi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhjb25mL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIk5naW54XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJOZ2lueFxcdTkxNGRcXHU3ZjZlXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA1fV0sIFwiZWlkXCI6IDEwMDF9LCB7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiXFx1Njc0M1xcdTk2NTBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL3Blcm1pc3Npb24vXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL3VzZXIvcGVybWlzc2lvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU2NzQzXFx1OTY1MFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwN30sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA4fSwge1wibmFtZVwiOiBcIlxcdTdlYzRcXHU3ZWM3XFx1NjdiNlxcdTY3ODRcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL29yZ2FuaXphdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9vcmdhbml6YXRpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFxcdTdlYzdcXHU2N2I2XFx1Njc4NFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwOX0sIHtcIm5hbWVcIjogXCJcXHU4M2RjXFx1NTM1NVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL3VzZXIvbWVudS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9tZW51L2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlVzZXJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTgzZGNcXHU1MzU1XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDEwfSwge1wibmFtZVwiOiBcIlxcdTg5ZDJcXHU4MjcyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci9yb2xlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi91c2VyL3JvbGUvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1ODlkMlxcdTgyNzJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMTF9XSwgXCJlaWRcIjogMTAwNn0sIHtcIm5hbWVcIjogXCJcXHU4YmE0XFx1OGJjMVxcdTU0OGNcXHU2Mzg4XFx1Njc0M1wiLCBcImljb25cIjogXCJmYXMgZmEtc2hpZWxkLWFsdFwiLCBcIm1vZGVsc1wiOiBbe1wibmFtZVwiOiBcIlxcdTdlYzRcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXVzZXJzLWNvZ1wiLCBcInVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdThiYTRcXHU4YmMxXFx1NTQ4Y1xcdTYzODhcXHU2NzQzXCIsIFwiaWNvblwiOiBcImZhcyBmYS1zaGllbGQtYWx0XCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFwiLCBcImljb25cIjogXCJmYXMgZmEtdXNlcnMtY29nXCJ9XSwgXCJlaWRcIjogMTAxM31dLCBcImVpZFwiOiAxMDEyfV0ifQ==', '2021-08-25 13:28:01.505679');
INSERT INTO `django_session` VALUES ('9w8pgdjzdk9v144jsyw3zumsfif5c85a', 'NWYyMzAzNTQ5OTE1MTc1OTM1MmJlZTJlNWI1NmM0NzUyNDRkYTI5Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NjA4MjFhYTM3ODBlZTI2NTFiYTlmNmE3MjgwYmRjMmNkYzMzMzVjIiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhBY3Rpb25cXHU4YmU2XFx1NjBjNVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9uZ2lueC9uZ2lueGFjdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhhY3Rpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54QWN0aW9uXFx1OGJlNlxcdTYwYzVcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDAyfSwge1wibmFtZVwiOiBcIk5naW54XFx1NjRjZFxcdTRmNWNcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU2NGNkXFx1NGY1Y1xcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU3YmExXFx1NzQwNlwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54XFx1N2JhMVxcdTc0MDZcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDR9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU5MTRkXFx1N2Y2ZVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54Y29uZi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhjb25mL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIk5naW54XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJOZ2lueFxcdTkxNGRcXHU3ZjZlXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA1fV0sIFwiZWlkXCI6IDEwMDF9LCB7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiXFx1Njc0M1xcdTk2NTBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL3Blcm1pc3Npb24vXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL3VzZXIvcGVybWlzc2lvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU2NzQzXFx1OTY1MFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwN30sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA4fSwge1wibmFtZVwiOiBcIlxcdTdlYzRcXHU3ZWM3XFx1NjdiNlxcdTY3ODRcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL29yZ2FuaXphdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9vcmdhbml6YXRpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFxcdTdlYzdcXHU2N2I2XFx1Njc4NFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwOX0sIHtcIm5hbWVcIjogXCJcXHU4M2RjXFx1NTM1NVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL3VzZXIvbWVudS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9tZW51L2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlVzZXJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTgzZGNcXHU1MzU1XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDEwfSwge1wibmFtZVwiOiBcIlxcdTg5ZDJcXHU4MjcyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci9yb2xlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi91c2VyL3JvbGUvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1ODlkMlxcdTgyNzJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMTF9XSwgXCJlaWRcIjogMTAwNn0sIHtcIm5hbWVcIjogXCJcXHU4YmE0XFx1OGJjMVxcdTU0OGNcXHU2Mzg4XFx1Njc0M1wiLCBcImljb25cIjogXCJmYXMgZmEtc2hpZWxkLWFsdFwiLCBcIm1vZGVsc1wiOiBbe1wibmFtZVwiOiBcIlxcdTdlYzRcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXVzZXJzLWNvZ1wiLCBcInVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdThiYTRcXHU4YmMxXFx1NTQ4Y1xcdTYzODhcXHU2NzQzXCIsIFwiaWNvblwiOiBcImZhcyBmYS1zaGllbGQtYWx0XCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFwiLCBcImljb25cIjogXCJmYXMgZmEtdXNlcnMtY29nXCJ9XSwgXCJlaWRcIjogMTAxM31dLCBcImVpZFwiOiAxMDEyfV0ifQ==', '2021-08-26 01:24:27.412726');
INSERT INTO `django_session` VALUES ('aftgwct6s3vvhdf3ye9359izklfnngvw', 'NWYyMzAzNTQ5OTE1MTc1OTM1MmJlZTJlNWI1NmM0NzUyNDRkYTI5Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NjA4MjFhYTM3ODBlZTI2NTFiYTlmNmE3MjgwYmRjMmNkYzMzMzVjIiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhBY3Rpb25cXHU4YmU2XFx1NjBjNVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9uZ2lueC9uZ2lueGFjdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhhY3Rpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54QWN0aW9uXFx1OGJlNlxcdTYwYzVcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDAyfSwge1wibmFtZVwiOiBcIk5naW54XFx1NjRjZFxcdTRmNWNcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhpbnN0YW5jZW9wcy9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJOZ2lueFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU2NGNkXFx1NGY1Y1xcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU3YmExXFx1NzQwNlwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL25naW54L25naW54bW9kZWwvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiTmdpbnhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIk5naW54XFx1N2JhMVxcdTc0MDZcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDR9LCB7XCJuYW1lXCI6IFwiTmdpbnhcXHU5MTRkXFx1N2Y2ZVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL25naW54L25naW54Y29uZi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vbmdpbngvbmdpbnhjb25mL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIk5naW54XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJOZ2lueFxcdTkxNGRcXHU3ZjZlXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA1fV0sIFwiZWlkXCI6IDEwMDF9LCB7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiXFx1Njc0M1xcdTk2NTBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL3Blcm1pc3Npb24vXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL3VzZXIvcGVybWlzc2lvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU2NzQzXFx1OTY1MFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwN30sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci91c2VycHJvZmlsZS9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJVc2VyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1xcdTRmZTFcXHU2MDZmXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA4fSwge1wibmFtZVwiOiBcIlxcdTdlYzRcXHU3ZWM3XFx1NjdiNlxcdTY3ODRcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi91c2VyL29yZ2FuaXphdGlvbi9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9vcmdhbml6YXRpb24vYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFxcdTdlYzdcXHU2N2I2XFx1Njc4NFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwOX0sIHtcIm5hbWVcIjogXCJcXHU4M2RjXFx1NTM1NVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL3VzZXIvbWVudS9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vdXNlci9tZW51L2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlVzZXJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTgzZGNcXHU1MzU1XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDEwfSwge1wibmFtZVwiOiBcIlxcdTg5ZDJcXHU4MjcyXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vdXNlci9yb2xlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi91c2VyL3JvbGUvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiVXNlclwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1ODlkMlxcdTgyNzJcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMTF9XSwgXCJlaWRcIjogMTAwNn0sIHtcIm5hbWVcIjogXCJcXHU4YmE0XFx1OGJjMVxcdTU0OGNcXHU2Mzg4XFx1Njc0M1wiLCBcImljb25cIjogXCJmYXMgZmEtc2hpZWxkLWFsdFwiLCBcIm1vZGVsc1wiOiBbe1wibmFtZVwiOiBcIlxcdTdlYzRcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXVzZXJzLWNvZ1wiLCBcInVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9hdXRoL2dyb3VwL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdThiYTRcXHU4YmMxXFx1NTQ4Y1xcdTYzODhcXHU2NzQzXCIsIFwiaWNvblwiOiBcImZhcyBmYS1zaGllbGQtYWx0XCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFwiLCBcImljb25cIjogXCJmYXMgZmEtdXNlcnMtY29nXCJ9XSwgXCJlaWRcIjogMTAxM31dLCBcImVpZFwiOiAxMDEyfV0ifQ==', '2021-08-27 13:46:21.871584');
COMMIT;

-- ----------------------------
-- Table structure for nginx_nginxaction
-- ----------------------------
DROP TABLE IF EXISTS `nginx_nginxaction`;
CREATE TABLE `nginx_nginxaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(64) NOT NULL,
  `msg` longtext NOT NULL,
  `operator` varchar(64) DEFAULT NULL,
  `action_status` varchar(16) NOT NULL,
  `ops_date` datetime(6) NOT NULL,
  `action_2_ops_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nginx_nginxaction_action_2_ops_id_ee3d308d_fk_nginx_ngi` (`action_2_ops_id`),
  CONSTRAINT `nginx_nginxaction_action_2_ops_id_ee3d308d_fk_nginx_ngi` FOREIGN KEY (`action_2_ops_id`) REFERENCES `nginx_nginxinstanceops` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=329 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of nginx_nginxaction
-- ----------------------------
BEGIN;
INSERT INTO `nginx_nginxaction` VALUES (1, 'sync', '执行sync', 'yan', 'running', '2021-08-06 12:03:29.546571', 2);
INSERT INTO `nginx_nginxaction` VALUES (2, 'dump_path', 'touch 文件', 'yan', 'success', '2021-08-06 12:03:48.769656', 3);
INSERT INTO `nginx_nginxaction` VALUES (3, 'es_check', 'es验证日志无访问量', NULL, 'failed', '2021-08-06 12:05:46.137231', 1);
INSERT INTO `nginx_nginxaction` VALUES (273, 'SetConf', '/tmp/luffy60.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 00:57:33.907937', 208);
INSERT INTO `nginx_nginxaction` VALUES (274, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy60.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy60.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy60.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy60.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 00:57:40.735453', 208);
INSERT INTO `nginx_nginxaction` VALUES (275, 'SetConf', '/tmp/luffy60.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 00:58:05.528643', 209);
INSERT INTO `nginx_nginxaction` VALUES (276, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy60.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy60.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy60.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy60.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 00:58:08.932775', 209);
INSERT INTO `nginx_nginxaction` VALUES (277, 'rm_conf', 'run bash /root/scripts/remove.sh luffy60.obapi.com.conf \r\n===>stdout<=== \r\n ', 'admin', 'success', '2021-08-17 00:58:30.484709', 210);
INSERT INTO `nginx_nginxaction` VALUES (278, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \".d..t...... ./\\n*deleting   luffy60.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \".d..t...... ./\", \n        \"*deleting   luffy60.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \".d..t...... ./\\n*deleting   luffy60.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \".d..t...... ./\", \n        \"*deleting   luffy60.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 00:58:33.817872', 210);
INSERT INTO `nginx_nginxaction` VALUES (279, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 06:37:07.341129', 211);
INSERT INTO `nginx_nginxaction` VALUES (280, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 06:37:18.320765', 211);
INSERT INTO `nginx_nginxaction` VALUES (281, 'reload', 'run /root/scripts/reload.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED | rc=0 >>\n\nnginx-02 | CHANGED | rc=0 >>', 'admin', 'success', '2021-08-17 06:37:50.817591', 212);
INSERT INTO `nginx_nginxaction` VALUES (282, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 06:53:11.636418', 213);
INSERT INTO `nginx_nginxaction` VALUES (283, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 06:53:16.116809', 213);
INSERT INTO `nginx_nginxaction` VALUES (284, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 08:26:49.695185', 214);
INSERT INTO `nginx_nginxaction` VALUES (285, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 08:26:53.510793', 214);
INSERT INTO `nginx_nginxaction` VALUES (286, 'reload', 'run /root/scripts/reload.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED | rc=0 >>\n\nnginx-01 | CHANGED | rc=0 >>', 'admin', 'success', '2021-08-17 08:41:12.492838', 215);
INSERT INTO `nginx_nginxaction` VALUES (287, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 08:41:26.078453', 216);
INSERT INTO `nginx_nginxaction` VALUES (288, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | FAILED | rc=1 >>\nnginx: [emerg] host not found in upstream \"luffy4_server\" in /etc/nginx/conf.d/luffy4.obapi.com.conf:28\nnginx: configuration file /etc/nginx/nginx.conf test failednon-zero return code\nnginx-01 | FAILED | rc=1 >>\nnginx: [emerg] host not found in upstream \"luffy4_server\" in /etc/nginx/conf.d/luffy4.obapi.com.conf:28\nnginx: configuration file /etc/nginx/nginx.conf test failednon-zero return code', 'admin', 'failed', '2021-08-17 08:41:30.014492', 216);
INSERT INTO `nginx_nginxaction` VALUES (289, 'reload', 'run /root/scripts/reload.sh \r\n===>stdout<=== \r\n nginx-02 | FAILED | rc=1 >>\nnginx: [emerg] host not found in upstream \"luffy4_server\" in /etc/nginx/conf.d/luffy4.obapi.com.conf:28non-zero return code\nnginx-01 | FAILED | rc=1 >>\nnginx: [emerg] host not found in upstream \"luffy4_server\" in /etc/nginx/conf.d/luffy4.obapi.com.conf:28non-zero return code', 'admin', 'failed', '2021-08-17 08:41:33.200575', 217);
INSERT INTO `nginx_nginxaction` VALUES (290, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 08:48:22.888282', 218);
INSERT INTO `nginx_nginxaction` VALUES (291, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 08:48:27.006686', 218);
INSERT INTO `nginx_nginxaction` VALUES (292, 'reload', 'run /root/scripts/reload.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED | rc=0 >>\n\nnginx-02 | CHANGED | rc=0 >>', 'admin', 'success', '2021-08-17 08:48:32.212245', 219);
INSERT INTO `nginx_nginxaction` VALUES (293, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 09:05:38.166114', 220);
INSERT INTO `nginx_nginxaction` VALUES (294, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 09:07:45.860909', 221);
INSERT INTO `nginx_nginxaction` VALUES (295, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 09:08:48.294507', 222);
INSERT INTO `nginx_nginxaction` VALUES (296, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 09:08:52.081594', 222);
INSERT INTO `nginx_nginxaction` VALUES (297, 'reload', 'run /root/scripts/reload.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED | rc=0 >>\n\nnginx-01 | CHANGED | rc=0 >>', 'admin', 'success', '2021-08-17 09:21:46.817036', 227);
INSERT INTO `nginx_nginxaction` VALUES (298, 'reload', 'run /root/scripts/reload.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED | rc=0 >>\n\nnginx-02 | CHANGED | rc=0 >>', 'admin', 'success', '2021-08-17 09:26:10.577025', 228);
INSERT INTO `nginx_nginxaction` VALUES (299, 'reload', 'run /root/scripts/reload.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED | rc=0 >>\n\nnginx-02 | CHANGED | rc=0 >>', 'admin', 'success', '2021-08-17 09:32:31.754024', 229);
INSERT INTO `nginx_nginxaction` VALUES (300, 'reload', 'run /root/scripts/reload.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED | rc=0 >>\n\nnginx-01 | CHANGED | rc=0 >>', 'admin', 'success', '2021-08-17 09:36:31.581248', 230);
INSERT INTO `nginx_nginxaction` VALUES (301, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 10:18:10.793426', 231);
INSERT INTO `nginx_nginxaction` VALUES (302, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 10:18:15.175906', 231);
INSERT INTO `nginx_nginxaction` VALUES (303, 'SetConf', '/tmp/luffy1.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-17 13:16:33.440996', 232);
INSERT INTO `nginx_nginxaction` VALUES (304, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy1.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy1.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy1.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy1.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-17 13:16:37.274800', 232);
INSERT INTO `nginx_nginxaction` VALUES (305, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-18 07:13:19.226854', 233);
INSERT INTO `nginx_nginxaction` VALUES (306, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-18 07:13:26.538965', 233);
INSERT INTO `nginx_nginxaction` VALUES (307, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-18 13:27:49.239366', 234);
INSERT INTO `nginx_nginxaction` VALUES (308, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-18 13:28:19.757666', 234);
INSERT INTO `nginx_nginxaction` VALUES (309, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-18 14:09:36.724403', 235);
INSERT INTO `nginx_nginxaction` VALUES (310, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-18 14:09:41.380696', 235);
INSERT INTO `nginx_nginxaction` VALUES (311, 'reload', 'run /root/scripts/reload.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED | rc=0 >>\n\nnginx-02 | CHANGED | rc=0 >>', 'admin', 'success', '2021-08-18 14:26:18.859863', 236);
INSERT INTO `nginx_nginxaction` VALUES (312, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-18 14:26:30.428904', 237);
INSERT INTO `nginx_nginxaction` VALUES (313, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-18 14:26:33.950758', 237);
INSERT INTO `nginx_nginxaction` VALUES (314, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 09:55:06.558558', 238);
INSERT INTO `nginx_nginxaction` VALUES (315, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f.st...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f.st...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-19 09:55:12.775732', 238);
INSERT INTO `nginx_nginxaction` VALUES (316, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 12:59:41.899156', 239);
INSERT INTO `nginx_nginxaction` VALUES (317, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-19 12:59:46.198594', 239);
INSERT INTO `nginx_nginxaction` VALUES (318, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 13:00:12.405991', 240);
INSERT INTO `nginx_nginxaction` VALUES (319, 'sync', 'run bash /root/scripts/sync-check.sh \r\n===>stdout<=== \r\n nginx-01 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-01:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED => {\n    \"changed\": true, \n    \"cmd\": \"/usr/bin/rsync --delay-updates -F --compress --delete-after --archive --rsh=/usr/bin/ssh -S none -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null --out-format=<<CHANGED>>%i %n%L /opt/consul-api/ nginx-02:/etc/nginx/conf.d\", \n    \"msg\": \"<f..t...... luffy4.obapi.com.conf\\n\", \n    \"rc\": 0, \n    \"stdout_lines\": [\n        \"<f..t...... luffy4.obapi.com.conf\"\n    ]\n}\nnginx-02 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful\nnginx-01 | CHANGED | rc=0 >>\nnginx: the configuration file /etc/nginx/nginx.conf syntax is ok\nnginx: configuration file /etc/nginx/nginx.conf test is successful', 'admin', 'success', '2021-08-19 13:00:16.070975', 240);
INSERT INTO `nginx_nginxaction` VALUES (320, 'SetConf', '/tmp/luffy4.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 13:48:01.852901', 241);
INSERT INTO `nginx_nginxaction` VALUES (321, 'SetConf', '/tmp/luffy3.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 13:59:56.579917', 242);
INSERT INTO `nginx_nginxaction` VALUES (322, 'SetConf', '/tmp/luffy3.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 14:02:14.681795', 243);
INSERT INTO `nginx_nginxaction` VALUES (323, 'SetConf', '/tmp/luffy1.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 14:06:09.880855', 244);
INSERT INTO `nginx_nginxaction` VALUES (324, 'SetConf', '/tmp/luffy1.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 14:12:32.190646', 245);
INSERT INTO `nginx_nginxaction` VALUES (325, 'SetConf', '/tmp/luffy15.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 14:29:32.893525', 246);
INSERT INTO `nginx_nginxaction` VALUES (326, 'SetConf', '/tmp/luffy14.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 14:41:34.578042', 247);
INSERT INTO `nginx_nginxaction` VALUES (327, 'SetConf', '/tmp/luffy13.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 14:44:12.849996', 248);
INSERT INTO `nginx_nginxaction` VALUES (328, 'SetConf', '/tmp/luffy15.obapi.com.conf 写入成功', 'admin', 'success', '2021-08-19 14:46:35.290179', 249);
COMMIT;

-- ----------------------------
-- Table structure for nginx_nginxconf
-- ----------------------------
DROP TABLE IF EXISTS `nginx_nginxconf`;
CREATE TABLE `nginx_nginxconf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `content` longtext,
  `comments` varchar(256) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `status` varchar(16) NOT NULL,
  `appid` varchar(32) DEFAULT NULL,
  `dep_owner` varchar(128) DEFAULT NULL,
  `ops_owner` varchar(128) DEFAULT NULL,
  `qa_owner` varchar(128) DEFAULT NULL,
  `l1_biz` varchar(128) DEFAULT NULL,
  `parent` varchar(128) DEFAULT NULL,
  `conf_add_status` tinyint(1) NOT NULL,
  `action_ops` varchar(16) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nginx_nginxconf_name_type_id_863675c5_uniq` (`name`,`type_id`),
  KEY `nginx_nginxconf_type_id_425814c2_fk_nginx_nginxmodel_id` (`type_id`),
  CONSTRAINT `nginx_nginxconf_type_id_425814c2_fk_nginx_nginxmodel_id` FOREIGN KEY (`type_id`) REFERENCES `nginx_nginxmodel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of nginx_nginxconf
-- ----------------------------
BEGIN;
INSERT INTO `nginx_nginxconf` VALUES (1, 'luffy5.obapi.com', '##luffy5.obapi.com###\r\n\r\nupstream luffy5_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy5_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy5.obapi.com.conf;\r\n    include /data/nginx/conf/luffy5.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name  luffy5.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy5_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy5.obapi.com', '2021-08-06 18:47:54.000000', '2021-08-16 13:15:59.101897', 'running', '31212213', 'yan', 'yan', 'yan', '老男孩DevOps', 'Python教学部', 1, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (2, 'luffy6.obapi.com', '##luffy6.obapi.com###\r\n\r\nupstream luffy6_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy6_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy6.obapi.com.conf;\r\n    include /data/nginx/conf/luffy6.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name  luffy6.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy6_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy6.obapi.com', '2021-08-06 19:21:50.000000', '2021-08-16 13:15:58.374170', 'running', '11233111', 'dgt', 'dgt', 'dgt', '老男孩DevOps', 'Linux教学部', 1, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (4, 'luffy7.obapi.com', '##luffy7.obapi.com###\r\n\r\nupstream luffy7_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy7_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy7.obapi.com.conf;\r\n    include /data/nginx/conf/luffy7.obapi.com.conf;\r\n    \r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name  luffy7.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy7_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy7.obapi.com', '2021-08-06 13:28:20.893714', '2021-08-12 12:23:23.663456', 'closed', '11233112', 'dgt', 'dgt', 'dgt', '老男孩DevOps', 'Python教学部', 0, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (5, 'luffy8.obapi.com', '##luffy8.obapi.com###\r\n\r\nupstream luffy8_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy8_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy8.obapi.com.conf;\r\n    include /data/nginx/conf/luffy8.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name  luffy8.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy8_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy8.obapi.com', '2021-08-06 13:42:21.357187', '2021-08-16 13:15:56.424349', 'running', '11233142', 'dgt', 'dgt', 'dgt', '老男孩DevOps', 'Python教学部', 1, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (6, 'luffy9.obapi.com', '##luffy9.obapi.com###\r\n\r\nupstream luffy9_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy9_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy9.obapi.com.conf;\r\n    include /data/nginx/conf/luffy9.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name  luffy9.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy9_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy9.obapi.com', '2021-08-07 02:13:31.847563', '2021-08-16 13:15:51.019300', 'running', '11233142', 'dgt', 'dgt', 'dgt', '老男孩', 'Linux教学部', 1, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (7, 'luffy10.obapi.com', '##luffy10.obapi.com###\r\n\r\nupstream luffy10_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy10_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy10.obapi.com.conf;\r\n    include /data/nginx/conf/luffy10.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name  luffy10.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy10_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffty10.obapi.com', '2021-08-07 02:13:48.600163', '2021-08-16 13:15:35.205900', 'running', '11233142', 'dgt', 'dgt', 'dgt', '老女孩', 'Linux教学部', 1, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (8, 'luffy11.obapi.com', '##luffy11.obapi.com###\r\n\r\nupstream luffy11_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy11_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy11.obapi.com.conf;\r\n    include /data/nginx/conf/luffy11.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name  luffy11.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy11_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy11.obapi.com', '2021-08-07 02:14:09.531107', '2021-08-12 12:35:23.428208', 'closed', '11233142', 'yan', 'yan', 'yan', '老女孩', 'Linux教学部', 0, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (9, 'luffy12.obapi.com', '##luffy12.obapi.com#######\r\n\r\nupstream luffy12_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy12_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy12.obapi.com.conf;\r\n    include /data/nginx/conf/luffy12.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name  luffy12.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy12_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy12.obapi.com', '2021-08-07 02:14:15.739481', '2021-08-16 13:15:24.058231', 'running', '11233142', 'yan', 'yan', 'yan', '老女孩', 'Linux教学部', 1, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (10, 'luffy13.obapi.com', '##luffy13.obapi.com###\r\n\r\nupstream luffy13_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy13_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy13.obapi.com.conf;\r\n    include /data/nginx/conf/luffy13.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name  luffy13.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy13_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy13.obapi.com', '2021-08-07 02:14:22.508891', '2021-08-19 14:44:13.007564', 'running', '11233145', 'yan', 'yan', 'yan', '老女孩', 'Linux教学部', 1, 'failed', 1);
INSERT INTO `nginx_nginxconf` VALUES (13, 'luffy14.obapi.com', '##luffy14.obapi.com###\r\n\r\nupstream luffy14_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy14_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy14.obapi.com;\r\n    include /data/nginx/conf/luffy14.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   luffy14.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy14_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy14.obapi.com', '2021-08-07 02:46:48.478682', '2021-08-19 14:41:34.734212', 'running', '11233125', 'yan', 'yan', 'yan', '老女孩', 'Linux教学部', 1, 'failed', 1);
INSERT INTO `nginx_nginxconf` VALUES (16, 'luffy15.obapi.com', '##luffy15.obapi.com###\r\n\r\nupstream luffy15_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy15_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy15.obapi.com.conf;\r\n    include /data/nginx/conf/luffy15.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   luffy15.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy15_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy15.obapi.com', '2021-08-07 02:51:08.745182', '2021-08-19 14:46:35.442276', 'running', '11233127', 'yan', 'yan', 'yan', '老女孩', 'Linux教学部', 1, 'failed', 1);
INSERT INTO `nginx_nginxconf` VALUES (17, 'luffy16.obapi.com', '##luffy16.obapi.com###\r\n\r\nupstream luffy16_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy16_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy16.obapi.com.conf;\r\n    include /data/nginx/conf/luffy16.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   luffy16.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy16_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy16.obapi.com', '2021-08-08 07:07:12.465558', '2021-08-16 13:14:45.585294', 'running', '11233128', 'yan', 'yan', 'yan', '老女孩', 'Linux教学部', 1, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (18, 'luffy1.obapi.com', '##luffy1.obapi.com###\r\n\r\nupstream luffy1_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy1_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy1.obapi.com.conf;\r\n    include /data/nginx/conf/luffy1.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   luffy1.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy1_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy1.obapi.com', '2021-08-12 07:46:34.763551', '2021-08-19 14:12:32.457000', 'running', '11223', 'dgt', 'dgt', 'dgt', '老男孩', 'Linux教学部', 1, 'failed', 1);
INSERT INTO `nginx_nginxconf` VALUES (19, 'luffy2.obapi.com', '##luffy2.obapi.com###\r\n\r\nupstream luffy2_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy2_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy2.obapi.com.conf;\r\n    include /data/nginx/conf/luffy2.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   luffy2.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy2_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy2.obapi.com', '2021-08-12 07:48:32.585762', '2021-08-12 13:06:00.822884', 'closed', '23532534', 'dgt', 'dgt', 'dgt', '老女孩', '大数据', 0, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (20, 'luffy3.obapi.com', '##luffy3.obapi.com###\r\n\r\nupstream luffy3_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy3_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy3.obapi.com.conf;\r\n    include /data/nginx/conf/luffy3.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob3api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   luffy3.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy3_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy3.obapi.com', '2021-08-12 07:50:28.261238', '2021-08-19 14:02:14.621796', 'running', '3423545', 'dgt', 'dgt', 'dgt', '老男孩', '国际事业', 1, 'running', 1);
INSERT INTO `nginx_nginxconf` VALUES (21, 'luffy4.obapi.com', '##luffy4.obapi.com###\r\n#####\r\nupstream luffy4_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy4_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy4.obapi.com.conf;\r\n    include /data/nginx/conf/luffy4.obapi.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   luffy4.obapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy4_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', 'luffy4.obapi.com', '2021-08-12 07:56:12.388678', '2021-08-19 13:48:01.770103', 'running', '13434324', 'dgt', 'dgt', 'dgt', '老男孩', '风险事业', 1, 'running', 1);
INSERT INTO `nginx_nginxconf` VALUES (23, 'luffy50.obapi.com', '##luffy50.obapi.com###\n##################### 同步配置操作\n\nupstream luffy50_server {  \n    server 127.0.0.1:11111 down;\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy50_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\n    upsync_dump_path /data/nginx/conf/luffy50.obapi.com.conf;\n    include /data/nginx/conf/luffy50.obapi.com.conf;\n\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\n    #check_http_expect_alive http_2xx http_3xx ;\n\n}\n\nserver {\n    listen 80;\n    server_name   luffy50.obapi.com; \n\n    server_tokens   off;\n    proxy_hide_header X-Powered-By;\n    proxy_hide_header X-AspNet-Version;\n    index default.htm index.html index.htm default.html;\n    gzip on;\n\n\n    location / {\n        proxy_pass       http://luffy50_server;\n        proxy_set_header   Host             $host;\n        proxy_set_header   X-Real-IP        $remote_addr;\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\n    }\n\n}', 'luffy50.obapi.com', '2021-08-12 13:50:29.401046', '2021-08-12 13:52:20.488949', 'closed', NULL, 'dgt', 'dgt', 'dgt', '大数据', '大数据', 0, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (24, 'luffy51.obapi.com', '##luffy51.obapi.com###\n############\nupstream luffy51_server {  \n    server 127.0.0.1:11111 down;\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy51_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\n    upsync_dump_path /data/nginx/conf/luffy51.obapi.com.conf;\n    include /data/nginx/conf/luffy51.obapi.com.conf;\n\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\n    #check_http_expect_alive http_2xx http_3xx ;\n\n}\n\nserver {\n    listen 80;\n    server_name   luffy51.obapi.com; \n\n    server_tokens   off;\n    proxy_hide_header X-Powered-By;\n    proxy_hide_header X-AspNet-Version;\n    index default.htm index.html index.htm default.html;\n    gzip on;\n\n\n    location / {\n        proxy_pass       http://luffy51_server;\n        proxy_set_header   Host             $host;\n        proxy_set_header   X-Real-IP        $remote_addr;\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\n    }\n\n}', 'luffy51.obapi.com', '2021-08-12 13:57:25.082165', '2021-08-13 08:30:15.182643', 'closed', '3423423', 'dgt', 'dgt', 'dgt', '大数据', '大数据', 0, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (25, 'luffy60.obapi.com', '##luffy60.obapi.com###\n#######################\nupstream luffy60_server {  \n    server 127.0.0.1:11111 down;\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy60_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\n    upsync_dump_path /data/nginx/conf/luffy60.obapi.com.conf;\n    include /data/nginx/conf/luffy60.obapi.com.conf;\n\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\n    #check_http_expect_alive http_2xx http_3xx ;\n\n}\n\nserver {\n    listen 80;\n    server_name   luffy60.obapi.com; \n\n    server_tokens   off;\n    proxy_hide_header X-Powered-By;\n    proxy_hide_header X-AspNet-Version;\n    index default.htm index.html index.htm default.html;\n    gzip on;\n\n\n    location / {\n        proxy_pass       http://luffy60_server;\n        proxy_set_header   Host             $host;\n        proxy_set_header   X-Real-IP        $remote_addr;\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\n    }\n\n}', 'luffy60.obapi.com', '2021-08-16 12:30:17.393050', '2021-08-17 00:58:34.461666', 'closed', '12323123', 'dgt', 'dgt', 'dgt', 'b2b', 'b2b', 1, 'success', 1);
INSERT INTO `nginx_nginxconf` VALUES (26, 'luffy61.obapi.com', '##luffy61.obapi.com###\n\nupstream luffy61_server {  \n    server 127.0.0.1:11111 down;\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy61_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\n    upsync_dump_path /data/nginx/conf/luffy61.obapi.com.conf;\n    include /data/nginx/conf/luffy60.obapi.com.conf;\n\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\n    #check_http_send \"HEAD http://www.ob1api.com/hs HTTP/1.0\\r\\n\\r\\n\";\n    #check_http_expect_alive http_2xx http_3xx ;\n\n}\n\nserver {\n    listen 80;\n    server_name   luffy61.obapi.com; \n\n    server_tokens   off;\n    proxy_hide_header X-Powered-By;\n    proxy_hide_header X-AspNet-Version;\n    index default.htm index.html index.htm default.html;\n    gzip on;\n\n\n    location / {\n        proxy_pass       http://luffy61_server;\n        proxy_set_header   Host             $host;\n        proxy_set_header   X-Real-IP        $remote_addr;\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\n    }\n\n}', 'luffy61.obapi.com', '2021-08-16 13:18:46.051454', '2021-08-16 13:20:08.872810', 'closed', '123543545', 'dgt', 'dgt', 'lqz', '老男孩', '老女孩', 1, 'success', 1);
COMMIT;

-- ----------------------------
-- Table structure for nginx_nginxinstanceops
-- ----------------------------
DROP TABLE IF EXISTS `nginx_nginxinstanceops`;
CREATE TABLE `nginx_nginxinstanceops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(16) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `ops_time` datetime(6) NOT NULL,
  `operator` varchar(64) DEFAULT NULL,
  `ops_status` varchar(32) NOT NULL,
  `ops_2_conf_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nginx_nginxinstanceo_ops_2_conf_id_e7bd3814_fk_nginx_ngi` (`ops_2_conf_id`),
  CONSTRAINT `nginx_nginxinstanceo_ops_2_conf_id_e7bd3814_fk_nginx_ngi` FOREIGN KEY (`ops_2_conf_id`) REFERENCES `nginx_nginxconf` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of nginx_nginxinstanceops
-- ----------------------------
BEGIN;
INSERT INTO `nginx_nginxinstanceops` VALUES (1, 'sync', '2021-08-06 12:02:33.644985', '2021-08-06 12:02:33.645038', 'dgt', 'success', 1);
INSERT INTO `nginx_nginxinstanceops` VALUES (2, 'reload', '2021-08-06 12:02:44.847604', '2021-08-06 12:02:44.847657', 'dgt', 'success', 1);
INSERT INTO `nginx_nginxinstanceops` VALUES (3, 'reload', '2021-08-06 12:02:55.430162', '2021-08-06 12:02:55.430197', 'yan', 'success', 1);
INSERT INTO `nginx_nginxinstanceops` VALUES (5, 'reload', '2021-08-07 08:33:36.582640', '2021-08-07 08:33:36.582688', 'dgt', 'success', 1);
INSERT INTO `nginx_nginxinstanceops` VALUES (6, 'sync', '2021-08-07 08:34:38.574742', '2021-08-07 08:34:38.574780', 'dgt', 'success', 1);
INSERT INTO `nginx_nginxinstanceops` VALUES (7, 'remove', '2021-08-07 08:35:41.636377', '2021-08-07 08:35:41.636411', 'dgt', 'success', 1);
INSERT INTO `nginx_nginxinstanceops` VALUES (8, 'remove', '2021-08-07 08:35:59.752409', '2021-08-07 08:35:59.752454', 'dgt', 'success', 1);
INSERT INTO `nginx_nginxinstanceops` VALUES (74, 'reload', '2021-08-10 14:31:14.526693', '2021-08-10 14:31:17.530474', 'Super Admin', 'success', 2);
INSERT INTO `nginx_nginxinstanceops` VALUES (75, 'reload', '2021-08-10 14:34:34.200911', '2021-08-10 14:34:46.545656', 'Super Admin', 'success', 2);
INSERT INTO `nginx_nginxinstanceops` VALUES (76, 'reload', '2021-08-10 14:34:44.314318', '2021-08-10 14:34:46.626907', 'Super Admin', 'success', 2);
INSERT INTO `nginx_nginxinstanceops` VALUES (77, 'reload', '2021-08-10 14:34:50.802786', '2021-08-10 14:34:52.306934', 'Super Admin', 'success', 2);
INSERT INTO `nginx_nginxinstanceops` VALUES (78, 'reload', '2021-08-10 14:35:08.919529', '2021-08-10 14:35:12.183374', 'Super Admin', 'success', 2);
INSERT INTO `nginx_nginxinstanceops` VALUES (79, 'reload', '2021-08-10 14:38:24.917136', '2021-08-10 14:38:31.230141', 'Super Admin', 'success', 2);
INSERT INTO `nginx_nginxinstanceops` VALUES (81, 'reload', '2021-08-10 15:25:57.969273', '2021-08-10 15:26:00.526127', 'admin', 'success', 10);
INSERT INTO `nginx_nginxinstanceops` VALUES (83, 'reload', '2021-08-11 00:38:12.600574', '2021-08-11 00:38:57.939817', 'admin', 'success', 16);
INSERT INTO `nginx_nginxinstanceops` VALUES (84, 'reload', '2021-08-11 06:55:12.750624', '2021-08-11 06:55:15.621795', 'admin', 'success', 10);
INSERT INTO `nginx_nginxinstanceops` VALUES (110, 'reload', '2021-08-11 13:01:09.005405', '2021-08-11 13:01:11.558668', 'admin', 'success', 9);
INSERT INTO `nginx_nginxinstanceops` VALUES (117, 'reload', '2021-08-11 15:08:34.041734', '2021-08-11 15:08:36.982448', 'admin', 'success', 8);
INSERT INTO `nginx_nginxinstanceops` VALUES (131, 'sync', '2021-08-12 08:47:02.786766', '2021-08-12 08:47:06.605507', 'admin', 'success', 6);
INSERT INTO `nginx_nginxinstanceops` VALUES (132, 'sync', '2021-08-12 08:56:45.526682', '2021-08-12 08:56:50.763733', 'admin', 'success', 7);
INSERT INTO `nginx_nginxinstanceops` VALUES (137, 'sync', '2021-08-12 09:15:39.426239', '2021-08-12 09:15:44.397091', 'admin', 'success', 8);
INSERT INTO `nginx_nginxinstanceops` VALUES (138, 'sync', '2021-08-12 09:17:17.154666', '2021-08-12 09:17:22.039691', 'admin', 'success', 9);
INSERT INTO `nginx_nginxinstanceops` VALUES (139, 'sync', '2021-08-12 09:21:40.004391', '2021-08-12 09:21:45.292002', 'admin', 'success', 10);
INSERT INTO `nginx_nginxinstanceops` VALUES (140, 'sync', '2021-08-12 09:23:02.276240', '2021-08-12 09:23:07.586724', 'admin', 'success', 13);
INSERT INTO `nginx_nginxinstanceops` VALUES (141, 'sync', '2021-08-12 10:16:19.297120', '2021-08-12 10:16:24.686065', 'admin', 'success', 4);
INSERT INTO `nginx_nginxinstanceops` VALUES (142, 'sync', '2021-08-12 10:18:18.107960', '2021-08-12 10:18:21.983358', 'admin', 'success', 4);
INSERT INTO `nginx_nginxinstanceops` VALUES (143, 'sync', '2021-08-12 10:19:13.953674', '2021-08-12 10:19:17.490322', 'admin', 'success', 4);
INSERT INTO `nginx_nginxinstanceops` VALUES (146, 'remove', '2021-08-12 12:23:19.281303', '2021-08-12 12:23:23.647177', 'admin', 'success', 4);
INSERT INTO `nginx_nginxinstanceops` VALUES (148, 'remove', '2021-08-12 12:35:19.325513', '2021-08-12 12:35:23.409233', 'admin', 'success', 8);
INSERT INTO `nginx_nginxinstanceops` VALUES (149, 'sync', '2021-08-12 12:49:57.480799', '2021-08-12 12:50:02.988870', 'admin', 'success', 19);
INSERT INTO `nginx_nginxinstanceops` VALUES (150, 'remove', '2021-08-12 13:05:56.493104', '2021-08-12 13:06:00.811008', 'admin', 'success', 19);
INSERT INTO `nginx_nginxinstanceops` VALUES (151, 'sync', '2021-08-12 13:14:31.842688', '2021-08-12 13:14:38.628379', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (152, 'sync', '2021-08-12 13:15:00.135892', '2021-08-12 13:15:04.191159', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (153, 'reload', '2021-08-12 13:16:06.217568', '2021-08-12 13:16:08.735130', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (154, 'sync', '2021-08-12 13:50:46.565648', '2021-08-12 13:50:52.019434', 'admin', 'success', 23);
INSERT INTO `nginx_nginxinstanceops` VALUES (155, 'remove', '2021-08-12 13:52:16.546181', '2021-08-12 13:52:20.476725', 'admin', 'success', 23);
INSERT INTO `nginx_nginxinstanceops` VALUES (156, 'sync', '2021-08-12 13:59:12.098346', '2021-08-12 13:59:18.169250', 'admin', 'success', 24);
INSERT INTO `nginx_nginxinstanceops` VALUES (157, 'reload', '2021-08-12 13:59:24.928536', '2021-08-12 13:59:27.036893', 'admin', 'success', 24);
INSERT INTO `nginx_nginxinstanceops` VALUES (158, 'sync', '2021-08-12 14:00:42.794933', '2021-08-12 14:00:46.570027', 'admin', 'success', 24);
INSERT INTO `nginx_nginxinstanceops` VALUES (159, 'reload', '2021-08-12 14:00:56.246282', '2021-08-12 14:00:58.340042', 'admin', 'success', 24);
INSERT INTO `nginx_nginxinstanceops` VALUES (160, 'sync', '2021-08-13 08:28:39.822356', '2021-08-13 08:28:47.409626', 'admin', 'success', 24);
INSERT INTO `nginx_nginxinstanceops` VALUES (161, 'reload', '2021-08-13 08:29:02.649998', '2021-08-13 08:29:04.742797', 'admin', 'success', 24);
INSERT INTO `nginx_nginxinstanceops` VALUES (162, 'remove', '2021-08-13 08:30:11.012296', '2021-08-13 08:30:15.168693', 'admin', 'success', 24);
INSERT INTO `nginx_nginxinstanceops` VALUES (188, 'sync', '2021-08-16 13:14:04.289706', '2021-08-16 13:14:10.363518', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (189, 'reload', '2021-08-16 13:14:14.998249', '2021-08-16 13:14:17.039735', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (190, 'sync', '2021-08-16 13:14:21.500983', '2021-08-16 13:14:26.487407', 'admin', 'success', 20);
INSERT INTO `nginx_nginxinstanceops` VALUES (191, 'sync', '2021-08-16 13:14:30.254728', '2021-08-16 13:14:35.674564', 'admin', 'success', 18);
INSERT INTO `nginx_nginxinstanceops` VALUES (192, 'sync', '2021-08-16 13:14:40.646441', '2021-08-16 13:14:45.570237', 'admin', 'success', 17);
INSERT INTO `nginx_nginxinstanceops` VALUES (193, 'sync', '2021-08-16 13:14:49.201375', '2021-08-16 13:14:54.040711', 'admin', 'success', 16);
INSERT INTO `nginx_nginxinstanceops` VALUES (194, 'sync', '2021-08-16 13:14:57.532169', '2021-08-16 13:15:02.386688', 'admin', 'success', 13);
INSERT INTO `nginx_nginxinstanceops` VALUES (195, 'sync', '2021-08-16 13:15:10.429616', '2021-08-16 13:15:15.300678', 'admin', 'success', 10);
INSERT INTO `nginx_nginxinstanceops` VALUES (196, 'sync', '2021-08-16 13:15:19.072218', '2021-08-16 13:15:24.045504', 'admin', 'success', 9);
INSERT INTO `nginx_nginxinstanceops` VALUES (197, 'sync', '2021-08-16 13:15:30.086104', '2021-08-16 13:15:35.189660', 'admin', 'success', 7);
INSERT INTO `nginx_nginxinstanceops` VALUES (198, 'sync', '2021-08-16 13:15:40.960327', '2021-08-16 13:15:51.007244', 'admin', 'success', 6);
INSERT INTO `nginx_nginxinstanceops` VALUES (199, 'sync', '2021-08-16 13:15:42.726857', '2021-08-16 13:15:56.414287', 'admin', 'success', 5);
INSERT INTO `nginx_nginxinstanceops` VALUES (200, 'sync', '2021-08-16 13:15:44.527413', '2021-08-16 13:15:58.357688', 'admin', 'success', 2);
INSERT INTO `nginx_nginxinstanceops` VALUES (201, 'sync', '2021-08-16 13:15:46.588964', '2021-08-16 13:15:59.090014', 'admin', 'success', 1);
INSERT INTO `nginx_nginxinstanceops` VALUES (202, 'reload', '2021-08-16 13:16:06.091680', '2021-08-16 13:16:08.022691', 'admin', 'success', 1);
INSERT INTO `nginx_nginxinstanceops` VALUES (203, 'sync', '2021-08-16 13:16:55.328192', '2021-08-16 13:16:58.728207', 'admin', 'success', 25);
INSERT INTO `nginx_nginxinstanceops` VALUES (204, 'sync', '2021-08-16 13:19:08.426249', '2021-08-16 13:19:14.086130', 'admin', 'success', 26);
INSERT INTO `nginx_nginxinstanceops` VALUES (205, 'reload', '2021-08-16 13:19:17.753930', '2021-08-16 13:19:19.682167', 'admin', 'success', 26);
INSERT INTO `nginx_nginxinstanceops` VALUES (206, 'remove', '2021-08-16 13:20:04.937265', '2021-08-16 13:20:08.862143', 'admin', 'success', 26);
INSERT INTO `nginx_nginxinstanceops` VALUES (208, 'sync', '2021-08-17 00:57:33.891128', '2021-08-17 00:57:40.748225', 'admin', 'success', 25);
INSERT INTO `nginx_nginxinstanceops` VALUES (209, 'sync', '2021-08-17 00:58:05.500860', '2021-08-17 00:58:08.944364', 'admin', 'success', 25);
INSERT INTO `nginx_nginxinstanceops` VALUES (210, 'remove', '2021-08-17 00:58:29.932751', '2021-08-17 00:58:33.829577', 'admin', 'success', 25);
INSERT INTO `nginx_nginxinstanceops` VALUES (211, 'sync', '2021-08-17 06:37:07.318158', '2021-08-17 06:37:18.336124', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (212, 'reload', '2021-08-17 06:37:48.679894', '2021-08-17 06:37:50.828871', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (213, 'sync', '2021-08-17 06:53:11.613659', '2021-08-17 06:53:16.135563', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (214, 'sync', '2021-08-17 08:26:49.673541', '2021-08-17 08:26:53.524056', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (215, 'reload', '2021-08-17 08:41:09.798751', '2021-08-17 08:41:12.503415', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (216, 'sync', '2021-08-17 08:41:26.054612', '2021-08-17 08:41:30.028234', 'admin', 'failed', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (217, 'reload', '2021-08-17 08:41:31.152594', '2021-08-17 08:41:33.211776', 'admin', 'failed', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (218, 'sync', '2021-08-17 08:48:22.865873', '2021-08-17 08:48:27.025690', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (219, 'reload', '2021-08-17 08:48:30.090296', '2021-08-17 08:48:32.228359', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (220, 'sync', '2021-08-17 09:05:38.142522', '2021-08-17 09:05:38.637722', 'admin', 'failed', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (221, 'sync', '2021-08-17 09:07:45.841288', '2021-08-17 09:07:46.305217', 'admin', 'failed', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (222, 'sync', '2021-08-17 09:08:48.276064', '2021-08-17 09:08:52.093836', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (223, 'reload', '2021-08-17 09:15:07.169317', '2021-08-17 09:15:07.405625', 'admin', 'failed', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (224, 'reload', '2021-08-17 09:15:58.123341', '2021-08-17 09:15:58.331686', 'admin', 'failed', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (225, 'reload', '2021-08-17 09:17:03.894702', '2021-08-17 09:17:04.160402', 'admin', 'failed', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (226, 'reload', '2021-08-17 09:19:54.370675', '2021-08-17 09:19:54.632969', 'admin', 'failed', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (227, 'reload', '2021-08-17 09:21:44.464518', '2021-08-17 09:21:46.830540', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (228, 'reload', '2021-08-17 09:26:08.209555', '2021-08-17 09:26:10.593490', 'admin', 'success', 20);
INSERT INTO `nginx_nginxinstanceops` VALUES (229, 'reload', '2021-08-17 09:32:29.440263', '2021-08-17 09:32:31.768151', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (230, 'reload', '2021-08-17 09:36:29.247139', '2021-08-17 09:36:31.592281', 'admin', 'success', 20);
INSERT INTO `nginx_nginxinstanceops` VALUES (231, 'sync', '2021-08-17 10:18:10.766628', '2021-08-17 10:18:15.192737', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (232, 'sync', '2021-08-17 13:16:33.420792', '2021-08-17 13:16:37.286402', 'admin', 'success', 18);
INSERT INTO `nginx_nginxinstanceops` VALUES (233, 'sync', '2021-08-18 07:13:19.196166', '2021-08-18 07:13:26.551929', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (234, 'sync', '2021-08-18 13:27:49.219906', '2021-08-18 13:28:19.772060', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (235, 'sync', '2021-08-18 14:09:36.705799', '2021-08-18 14:09:41.398077', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (236, 'reload', '2021-08-18 14:26:15.978354', '2021-08-18 14:26:18.872645', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (237, 'sync', '2021-08-18 14:26:30.411270', '2021-08-18 14:26:33.967137', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (238, 'sync', '2021-08-19 09:55:06.537064', '2021-08-19 09:55:12.792932', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (239, 'sync', '2021-08-19 12:59:41.880577', '2021-08-19 12:59:46.212253', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (240, 'sync', '2021-08-19 13:00:12.386309', '2021-08-19 13:00:16.085063', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (241, 'sync', '2021-08-19 13:48:01.812390', '2021-08-19 13:48:01.812443', 'admin', 'success', 21);
INSERT INTO `nginx_nginxinstanceops` VALUES (242, 'sync', '2021-08-19 13:59:56.553671', '2021-08-19 14:01:13.077333', 'admin', 'success', 20);
INSERT INTO `nginx_nginxinstanceops` VALUES (243, 'sync', '2021-08-19 14:02:14.657537', '2021-08-19 14:02:14.657590', 'admin', 'success', 20);
INSERT INTO `nginx_nginxinstanceops` VALUES (244, 'sync', '2021-08-19 14:06:09.841936', '2021-08-19 14:06:10.462226', 'admin', 'failed', 18);
INSERT INTO `nginx_nginxinstanceops` VALUES (245, 'sync', '2021-08-19 14:12:32.167505', '2021-08-19 14:12:32.438597', 'admin', 'failed', 18);
INSERT INTO `nginx_nginxinstanceops` VALUES (246, 'sync', '2021-08-19 14:29:32.872075', '2021-08-19 14:29:33.556464', 'admin', 'failed', 16);
INSERT INTO `nginx_nginxinstanceops` VALUES (247, 'sync', '2021-08-19 14:41:34.553100', '2021-08-19 14:41:34.719500', 'admin', 'failed', 13);
INSERT INTO `nginx_nginxinstanceops` VALUES (248, 'sync', '2021-08-19 14:44:12.817339', '2021-08-19 14:44:12.988507', 'admin', 'failed', 10);
INSERT INTO `nginx_nginxinstanceops` VALUES (249, 'sync', '2021-08-19 14:46:35.258197', '2021-08-19 14:46:35.428000', 'admin', 'failed', 16);
COMMIT;

-- ----------------------------
-- Table structure for nginx_nginxmodel
-- ----------------------------
DROP TABLE IF EXISTS `nginx_nginxmodel`;
CREATE TABLE `nginx_nginxmodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `desc` varchar(128) NOT NULL,
  `managerIp` char(39) NOT NULL,
  `confPath` varchar(512) NOT NULL,
  `rmCmd` varchar(512) DEFAULT NULL,
  `syncCmd` varchar(512) DEFAULT NULL,
  `dumpCmd` varchar(512) DEFAULT NULL,
  `reloadCmd` varchar(512) DEFAULT NULL,
  `upstream_status_url` varchar(512) DEFAULT NULL,
  `upstream_show_url` varchar(512) DEFAULT NULL,
  `consulApi` varchar(512) DEFAULT NULL,
  `template` longtext NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `region` varchar(64) NOT NULL,
  `status` varchar(16) NOT NULL,
  `nginx_type` varchar(16) NOT NULL,
  `group_ops` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nginx_nginxmodel_name_region_fa60223e_uniq` (`name`,`region`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of nginx_nginxmodel
-- ----------------------------
BEGIN;
INSERT INTO `nginx_nginxmodel` VALUES (1, 'consul-api', '内部接口', '10.0.0.80', '/opt/consul-api/', '/root/scripts/remove.sh', '/root/scripts/sync-check.sh', '~/scripts/add_dump.sh', '/root/scripts/reload.sh', 'upstream.testapi.com/status', 'upstream.testapi.com/show_status', 'http://192.168.11.252:8530/v1/kv/upstreams/', '##template.ppdapi.com###\r\n\r\nupstream luffy_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy.test.com.conf;\r\n    include /data/nginx/conf/luffy.test.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://weblog.ppdapi.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   template.testapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', '2021-08-06 18:56:32.000000', '2021-08-06 12:01:02.830373', '万国', 'running', 'consul', NULL);
INSERT INTO `nginx_nginxmodel` VALUES (2, 'api', '内部接口', '10.0.0.80', '/etc/nginx/conf.d/', '/root/scripts/remove.sh', '/root/scripts/sync-check.sh', '~/scripts/add_dump.sh', '/root/scripts/reload.sh', 'upstream.testadmin.com/status', 'upstream.testadmin.com/show_status', 'http://192.168.11.252:8530/v1/kv/upstreams/', '##template.ppdapi.com###\r\n\r\nupstream luffy_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy.test.com.conf;\r\n    include /data/nginx/conf/luffy.test.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://weblog.ppdapi.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   template.testapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', '2021-08-07 10:49:50.000000', '2021-08-07 03:46:39.777793', '宝山', 'running', 'default', NULL);
INSERT INTO `nginx_nginxmodel` VALUES (3, 'static', '内部接口', '10.0.0.80', '/etc/nginx/conf.d/', '/root/scripts/remove.sh', '/root/scripts/sync-check.sh', '~/scripts/add_dump.sh', '/root/scripts/reload.sh', 'upstream.testapi.com/status', 'upstream.testapi.com/show_status', 'http://192.168.11.252:8530/v1/kv/upstreams/', '##template.ppdapi.com###\r\n\r\nupstream luffy_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy.test.com.conf;\r\n    include /data/nginx/conf/luffy.test.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://weblog.ppdapi.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   template.testapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', '2021-08-07 03:42:50.289565', '2021-08-13 08:26:31.441163', '万国', 'running', 'default', NULL);
INSERT INTO `nginx_nginxmodel` VALUES (4, 'admin', '内部接口', '10.0.0.80', '/etc/nginx/conf.d/', '/root/scripts/remove.sh', '/root/scripts/sync-check.sh', '~/scripts/add_dump.sh', '/root/scripts/reload.sh', 'upstream.testadmin.com/status', 'upstream.testadmin.com/show_status', 'http://192.168.11.252:8530/v1/kv/upstreams/', '##template.ppdapi.com###\r\n\r\nupstream luffy_server {  \r\n    server 127.0.0.1:11111 down;\r\n    upsync 192.168.11.252:8510/v1/kv/upstreams/luffy_server upsync_timeout=6m upsync_interval=500ms upsync_type=consul strong_dependency=off;\r\n    upsync_dump_path /data/nginx/conf/luffy.test.com.conf;\r\n    include /data/nginx/conf/luffy.test.com.conf;\r\n\r\n    #check interval=3000 rise=2 fall=5 timeout=1000 type=http;\r\n    #check_http_send \"HEAD http://weblog.ppdapi.com/hs HTTP/1.0\\r\\n\\r\\n\";\r\n    #check_http_expect_alive http_2xx http_3xx ;\r\n\r\n}\r\n\r\nserver {\r\n    listen 80;\r\n    server_name   template.testapi.com; \r\n\r\n    server_tokens   off;\r\n    proxy_hide_header X-Powered-By;\r\n    proxy_hide_header X-AspNet-Version;\r\n    index default.htm index.html index.htm default.html;\r\n    gzip on;\r\n\r\n\r\n    location / {\r\n        proxy_pass       http://luffy_server;\r\n        proxy_set_header   Host             $host;\r\n        proxy_set_header   X-Real-IP        $remote_addr;\r\n        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;\r\n    }\r\n\r\n}', '2021-08-07 03:43:23.531395', '2021-08-19 13:27:51.289362', '宝山', 'running', 'default', NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_organization
-- ----------------------------
DROP TABLE IF EXISTS `user_organization`;
CREATE TABLE `user_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_user` varchar(64) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(60) NOT NULL,
  `type` varchar(20) NOT NULL,
  `pid_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_organization_pid_id_7d20d5b9_fk_user_organization_id` (`pid_id`),
  CONSTRAINT `user_organization_pid_id_7d20d5b9_fk_user_organization_id` FOREIGN KEY (`pid_id`) REFERENCES `user_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_organization
-- ----------------------------
BEGIN;
INSERT INTO `user_organization` VALUES (1, 'admin', '2021-08-06 04:30:13.487946', '2021-08-11 18:12:45.034721', '老男孩', 'company', NULL);
INSERT INTO `user_organization` VALUES (2, 'admin', '2021-08-06 04:30:28.667667', '2021-08-07 03:18:55.742544', '系统运维', 'department', 1);
INSERT INTO `user_organization` VALUES (28, 'admin', '2021-08-07 05:21:24.994996', '2021-08-10 13:06:45.047055', 'DBA', 'department', 1);
INSERT INTO `user_organization` VALUES (30, 'oldgirl', '2021-08-10 13:07:09.593691', '2021-08-17 00:40:50.721873', '老女孩', 'company', 1);
COMMIT;

-- ----------------------------
-- Table structure for user_permission
-- ----------------------------
DROP TABLE IF EXISTS `user_permission`;
CREATE TABLE `user_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_user` varchar(64) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(30) NOT NULL,
  `method` varchar(50) DEFAULT NULL,
  `pid_id` int(11) DEFAULT NULL,
  `path` varchar(200) NOT NULL,
  `sign` varchar(30) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `menu` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `user_permission_pid_id_ab01d5b4_fk_user_permission_id` (`pid_id`),
  CONSTRAINT `user_permission_pid_id_ab01d5b4_fk_user_permission_id` FOREIGN KEY (`pid_id`) REFERENCES `user_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_permission
-- ----------------------------
BEGIN;
INSERT INTO `user_permission` VALUES (1, 'admin', '1900-01-20 10:18:15.009759', '1900-01-20 10:18:15.010757', '系统管理员', '', NULL, '', 'admin', NULL, 1);
INSERT INTO `user_permission` VALUES (2, 'admin', '1900-01-20 10:18:15.013748', '2021-08-15 08:19:04.176613', '用户管理菜单', '', 65, '', 'system-users', '用户管理', 1);
INSERT INTO `user_permission` VALUES (3, 'admin', '1900-01-20 10:18:15.015743', '1900-01-20 10:18:15.015743', '用户查询', 'GET', 2, '/api/system/user/', 'system-user-get', NULL, 0);
INSERT INTO `user_permission` VALUES (4, 'admin', '1900-01-20 10:18:15.018734', '1900-01-20 10:18:15.018734', '用户创建', 'POST', 2, '/api/system/user/', 'system-user-add', NULL, 0);
INSERT INTO `user_permission` VALUES (5, 'admin', '1900-01-20 10:18:15.019732', '1900-01-20 10:18:15.019732', '用户编辑', 'PUT', 2, '/api/system/user/all/\\d+', 'system-user-edit', NULL, 0);
INSERT INTO `user_permission` VALUES (6, 'admin', '1900-01-20 10:18:15.020729', '1900-01-20 10:18:15.020729', '用户删除', 'DELETE', 2, '/api/system/user/all/\\d+', 'system-user-delete', NULL, 0);
INSERT INTO `user_permission` VALUES (12, 'admin', '1900-01-20 10:18:15.027710', '2021-08-15 08:09:37.048789', '角色管理菜单', '', 65, '', 'system-roles', '角色管理', 1);
INSERT INTO `user_permission` VALUES (13, 'admin', '1900-01-20 10:18:15.028707', '1900-01-20 10:18:15.028707', '角色查询', 'GET', 12, '/api/system/role/', 'system-role-get', NULL, 0);
INSERT INTO `user_permission` VALUES (14, 'admin', '1900-01-20 10:18:15.029705', '1900-01-20 10:18:15.029705', '角色创建', 'POST', 12, '/api/system/role/', 'system-role-add', NULL, 0);
INSERT INTO `user_permission` VALUES (15, 'admin', '1900-01-20 10:18:15.030702', '1900-01-20 10:18:15.030702', '角色编辑', 'PUT', 12, '/api/system/role/\\d+', 'system-role-edit', NULL, 0);
INSERT INTO `user_permission` VALUES (16, 'admin', '1900-01-20 10:18:15.031699', '1900-01-20 10:18:15.031699', '角色删除', 'DELETE', 12, '/api/system/role/\\d+', 'system-role-delete', NULL, 0);
INSERT INTO `user_permission` VALUES (17, 'admin', '1900-01-20 10:18:15.032697', '2021-08-15 08:09:16.079488', '权限管理菜单', '', 65, '', 'system-permissions', '权限管理', 1);
INSERT INTO `user_permission` VALUES (18, 'admin', '1900-01-20 10:18:15.033694', '1900-01-20 10:18:15.033694', '权限查询', 'GET', 17, '/api/system/permission/', 'system-permission-get', NULL, 0);
INSERT INTO `user_permission` VALUES (19, 'admin', '1900-01-20 10:18:15.034691', '1900-01-20 10:18:15.034691', '权限创建', 'POST', 17, '/api/system/permission/', 'system-permission-add', NULL, 0);
INSERT INTO `user_permission` VALUES (20, 'admin', '1900-01-20 10:18:15.035689', '1900-01-20 10:18:15.035689', '权限编辑', 'PUT', 17, '/api/system/permission/\\d+', 'system-permission-edit', NULL, 0);
INSERT INTO `user_permission` VALUES (21, 'admin', '1900-01-20 10:18:15.037683', '1900-01-20 10:18:15.037683', '权限删除', 'DELETE', 17, '/api/system/permission/\\d+', 'system-permission-delete', NULL, 0);
INSERT INTO `user_permission` VALUES (22, 'admin', '1900-01-20 10:18:15.038680', '2021-08-15 08:07:59.727096', '组织管理菜单', '', 65, '', 'system-departments', '组织管理', 1);
INSERT INTO `user_permission` VALUES (23, 'admin', '1900-01-20 10:18:15.039678', '1900-01-20 10:18:15.039678', '组织查询', 'GET', 22, '/api/system/org/', 'system-org-get', NULL, 0);
INSERT INTO `user_permission` VALUES (24, 'admin', '1900-01-20 10:18:15.040675', '2021-08-11 12:49:26.733054', '组织创建', 'POST', 22, '/api/system/org/', 'system-org-add', '', 0);
INSERT INTO `user_permission` VALUES (25, 'admin', '1900-01-20 10:18:15.041673', '1900-01-20 10:18:15.041673', '组织编辑', 'PUT', 22, '/api/system/org/\\d+', 'system-org-edit', NULL, 0);
INSERT INTO `user_permission` VALUES (26, 'admin', '1900-01-20 10:18:15.042670', '1900-01-20 10:18:15.042670', '组织删除', 'DELETE', 22, '/api/system/org/\\d+', 'system-org-delete', NULL, 0);
INSERT INTO `user_permission` VALUES (50, 'admin', '2021-08-10 15:24:45.000000', '2021-08-10 15:24:49.000000', '权限列表', 'GET', 17, '/api/system/permissionlist/', 'system-permission-list', NULL, 0);
INSERT INTO `user_permission` VALUES (65, 'admin', '2021-08-12 12:34:56.778130', '2021-08-15 08:07:21.450231', '系统管理菜单', '', NULL, '', 'system', '系统管理', 1);
INSERT INTO `user_permission` VALUES (66, 'admin', '2021-08-13 06:40:41.695814', '2021-08-15 08:07:13.875710', '系统监控菜单', '', NULL, '', 'monitor', '监控管理', 1);
INSERT INTO `user_permission` VALUES (67, 'admin', '2021-08-13 06:42:21.251675', '2021-08-15 09:29:27.218215', '服务监控', 'GET', 66, '/api/monitor/service/', 'monitor-service', '', 0);
INSERT INTO `user_permission` VALUES (76, 'admin', '2021-08-15 09:07:47.911042', '2021-08-15 09:07:47.911102', 'Nginx管理菜单', '', NULL, '', 'nginx', '', 1);
INSERT INTO `user_permission` VALUES (77, 'admin', '2021-08-15 09:15:56.179883', '2021-08-15 09:15:56.179930', 'nginx集群管理菜单', '', 76, '', 'nginx-ngmodel', '', 1);
INSERT INTO `user_permission` VALUES (78, 'admin', '2021-08-15 09:16:48.598671', '2021-08-15 09:16:56.236985', 'nginx配置管理菜单', '', 76, '', 'nginx-ngconf', '', 1);
INSERT INTO `user_permission` VALUES (79, 'admin', '2021-08-15 09:18:46.768024', '2021-08-15 09:18:46.768085', 'nginx操作日志菜单', '', 76, '', 'nginx-ngops', '', 1);
COMMIT;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_user` varchar(64) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(32) NOT NULL,
  `desc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` VALUES (1, 'admin', '2021-08-06 05:11:13.124656', '2021-08-12 01:19:02.804661', '系统管理员', '系统管理员');
INSERT INTO `user_role` VALUES (14, 'admin', '2021-08-12 00:45:22.222761', '2021-08-19 16:32:36.716929', 'test角色', '只拥有查看组织架构的权限');
INSERT INTO `user_role` VALUES (18, 'admin', '2021-08-15 08:32:48.516321', '2021-08-16 03:48:48.054760', '用户管理员', '拥有用户管理的所有权限');
INSERT INTO `user_role` VALUES (19, 'admin', '2021-08-15 08:40:06.305553', '2021-08-16 03:49:52.942437', '角色管理员', '拥有对角色管理功能的所有权限');
INSERT INTO `user_role` VALUES (21, 'admin', '2021-08-15 08:45:20.750686', '2021-08-19 16:26:54.547639', '权限管理员', '拥有对权限管理功能的所有权限');
INSERT INTO `user_role` VALUES (22, 'admin', '2021-08-15 08:46:45.755021', '2021-08-16 03:50:41.368784', '组织架构管理员', '拥有对组织架构管理功能的所有权限');
INSERT INTO `user_role` VALUES (23, 'admin', '2021-08-15 09:31:43.429183', '2021-08-15 09:31:43.429239', 'Nginx集群管理员', '拥有Nginx集群管理的所有权限');
INSERT INTO `user_role` VALUES (24, 'admin', '2021-08-15 09:32:15.687661', '2021-08-15 09:32:24.485613', 'Nginx配置管理员', '拥有Nginx配置管理的所有权限');
INSERT INTO `user_role` VALUES (25, 'admin', '2021-08-15 09:32:55.608570', '2021-08-15 09:32:55.608629', 'Nginx操作日志管理员', '拥有Nginx操作日志管理的所有权限');
INSERT INTO `user_role` VALUES (26, 'admin', '2021-08-16 03:44:26.312083', '2021-08-16 14:16:47.954086', '开发', '资深开发');
INSERT INTO `user_role` VALUES (29, 'admin', '2021-08-16 14:16:35.093234', '2021-08-16 14:16:35.093274', '基础运维', '运维');
COMMIT;

-- ----------------------------
-- Table structure for user_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `user_role_permissions`;
CREATE TABLE `user_role_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_role_permissions_role_id_permission_id_5c7fcb9e_uniq` (`role_id`,`permission_id`),
  KEY `user_role_permission_permission_id_f8e771ef_fk_user_perm` (`permission_id`),
  CONSTRAINT `user_role_permission_permission_id_f8e771ef_fk_user_perm` FOREIGN KEY (`permission_id`) REFERENCES `user_permission` (`id`),
  CONSTRAINT `user_role_permissions_role_id_b8961a0b_fk_user_role_id` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role_permissions
-- ----------------------------
BEGIN;
INSERT INTO `user_role_permissions` VALUES (1, 1, 1);
INSERT INTO `user_role_permissions` VALUES (297, 14, 2);
INSERT INTO `user_role_permissions` VALUES (309, 14, 3);
INSERT INTO `user_role_permissions` VALUES (303, 14, 12);
INSERT INTO `user_role_permissions` VALUES (310, 14, 13);
INSERT INTO `user_role_permissions` VALUES (302, 14, 17);
INSERT INTO `user_role_permissions` VALUES (307, 14, 18);
INSERT INTO `user_role_permissions` VALUES (311, 14, 23);
INSERT INTO `user_role_permissions` VALUES (306, 14, 50);
INSERT INTO `user_role_permissions` VALUES (290, 14, 65);
INSERT INTO `user_role_permissions` VALUES (200, 18, 2);
INSERT INTO `user_role_permissions` VALUES (201, 18, 3);
INSERT INTO `user_role_permissions` VALUES (274, 18, 4);
INSERT INTO `user_role_permissions` VALUES (206, 18, 5);
INSERT INTO `user_role_permissions` VALUES (276, 18, 6);
INSERT INTO `user_role_permissions` VALUES (275, 18, 13);
INSERT INTO `user_role_permissions` VALUES (277, 18, 23);
INSERT INTO `user_role_permissions` VALUES (197, 18, 65);
INSERT INTO `user_role_permissions` VALUES (198, 18, 66);
INSERT INTO `user_role_permissions` VALUES (199, 18, 67);
INSERT INTO `user_role_permissions` VALUES (217, 19, 12);
INSERT INTO `user_role_permissions` VALUES (210, 19, 13);
INSERT INTO `user_role_permissions` VALUES (211, 19, 14);
INSERT INTO `user_role_permissions` VALUES (212, 19, 15);
INSERT INTO `user_role_permissions` VALUES (213, 19, 16);
INSERT INTO `user_role_permissions` VALUES (215, 19, 50);
INSERT INTO `user_role_permissions` VALUES (207, 19, 65);
INSERT INTO `user_role_permissions` VALUES (208, 19, 66);
INSERT INTO `user_role_permissions` VALUES (209, 19, 67);
INSERT INTO `user_role_permissions` VALUES (222, 21, 17);
INSERT INTO `user_role_permissions` VALUES (227, 21, 18);
INSERT INTO `user_role_permissions` VALUES (224, 21, 19);
INSERT INTO `user_role_permissions` VALUES (225, 21, 20);
INSERT INTO `user_role_permissions` VALUES (226, 21, 21);
INSERT INTO `user_role_permissions` VALUES (308, 21, 50);
INSERT INTO `user_role_permissions` VALUES (219, 21, 65);
INSERT INTO `user_role_permissions` VALUES (220, 21, 66);
INSERT INTO `user_role_permissions` VALUES (221, 21, 67);
INSERT INTO `user_role_permissions` VALUES (233, 22, 22);
INSERT INTO `user_role_permissions` VALUES (234, 22, 23);
INSERT INTO `user_role_permissions` VALUES (235, 22, 24);
INSERT INTO `user_role_permissions` VALUES (236, 22, 25);
INSERT INTO `user_role_permissions` VALUES (237, 22, 26);
INSERT INTO `user_role_permissions` VALUES (230, 22, 65);
INSERT INTO `user_role_permissions` VALUES (231, 22, 66);
INSERT INTO `user_role_permissions` VALUES (232, 22, 67);
INSERT INTO `user_role_permissions` VALUES (239, 23, 76);
INSERT INTO `user_role_permissions` VALUES (240, 23, 77);
INSERT INTO `user_role_permissions` VALUES (241, 24, 76);
INSERT INTO `user_role_permissions` VALUES (242, 24, 78);
INSERT INTO `user_role_permissions` VALUES (243, 25, 76);
INSERT INTO `user_role_permissions` VALUES (244, 25, 79);
INSERT INTO `user_role_permissions` VALUES (245, 26, 2);
INSERT INTO `user_role_permissions` VALUES (246, 26, 3);
INSERT INTO `user_role_permissions` VALUES (247, 26, 4);
INSERT INTO `user_role_permissions` VALUES (248, 26, 5);
INSERT INTO `user_role_permissions` VALUES (249, 26, 6);
INSERT INTO `user_role_permissions` VALUES (250, 26, 12);
INSERT INTO `user_role_permissions` VALUES (251, 26, 13);
INSERT INTO `user_role_permissions` VALUES (252, 26, 14);
INSERT INTO `user_role_permissions` VALUES (253, 26, 15);
INSERT INTO `user_role_permissions` VALUES (254, 26, 16);
INSERT INTO `user_role_permissions` VALUES (255, 26, 17);
INSERT INTO `user_role_permissions` VALUES (256, 26, 18);
INSERT INTO `user_role_permissions` VALUES (257, 26, 19);
INSERT INTO `user_role_permissions` VALUES (258, 26, 20);
INSERT INTO `user_role_permissions` VALUES (259, 26, 21);
INSERT INTO `user_role_permissions` VALUES (260, 26, 22);
INSERT INTO `user_role_permissions` VALUES (261, 26, 23);
INSERT INTO `user_role_permissions` VALUES (262, 26, 24);
INSERT INTO `user_role_permissions` VALUES (263, 26, 25);
INSERT INTO `user_role_permissions` VALUES (264, 26, 26);
INSERT INTO `user_role_permissions` VALUES (265, 26, 50);
INSERT INTO `user_role_permissions` VALUES (266, 26, 65);
INSERT INTO `user_role_permissions` VALUES (267, 26, 66);
INSERT INTO `user_role_permissions` VALUES (268, 26, 67);
INSERT INTO `user_role_permissions` VALUES (269, 26, 76);
INSERT INTO `user_role_permissions` VALUES (270, 26, 77);
INSERT INTO `user_role_permissions` VALUES (271, 26, 78);
INSERT INTO `user_role_permissions` VALUES (272, 26, 79);
INSERT INTO `user_role_permissions` VALUES (279, 29, 65);
INSERT INTO `user_role_permissions` VALUES (280, 29, 66);
INSERT INTO `user_role_permissions` VALUES (281, 29, 67);
INSERT INTO `user_role_permissions` VALUES (282, 29, 76);
INSERT INTO `user_role_permissions` VALUES (283, 29, 77);
INSERT INTO `user_role_permissions` VALUES (284, 29, 78);
INSERT INTO `user_role_permissions` VALUES (285, 29, 79);
COMMIT;

-- ----------------------------
-- Table structure for user_userprofile
-- ----------------------------
DROP TABLE IF EXISTS `user_userprofile`;
CREATE TABLE `user_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `change_user` varchar(64) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(150) NOT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `position` varchar(50) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `superior_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_userprofile_department_id_d60a64b8_fk_user_organization_id` (`department_id`),
  KEY `user_userprofile_superior_id_310ebc05_fk_user_userprofile_id` (`superior_id`),
  CONSTRAINT `user_userprofile_department_id_d60a64b8_fk_user_organization_id` FOREIGN KEY (`department_id`) REFERENCES `user_organization` (`id`),
  CONSTRAINT `user_userprofile_superior_id_310ebc05_fk_user_userprofile_id` FOREIGN KEY (`superior_id`) REFERENCES `user_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_userprofile
-- ----------------------------
BEGIN;
INSERT INTO `user_userprofile` VALUES (1, 'pbkdf2_sha256$150000$lCrZG7wtkhae$yQiFH7B0AdKKUSwVb+jQbON4VNZbqWIf3xjlMWltBTA=', '2021-08-19 14:32:54.514518', 1, 'admin', '', '', 1, 1, '2021-08-06 04:02:00.000000', 'admin', '2021-08-06 04:02:47.266779', '2021-08-17 04:06:03.540654', 'admin', '11122223333', 'admin@qq.com', '管理员', 2, NULL);
INSERT INTO `user_userprofile` VALUES (2, 'pbkdf2_sha256$150000$lCrZG7wtkhae$yQiFH7B0AdKKUSwVb+jQbON4VNZbqWIf3xjlMWltBTA=', NULL, 0, 'dgt', 'dong', 'guotao', 0, 1, '2021-08-07 08:59:00.000000', 'admin', '2021-08-07 09:01:09.059518', '2021-08-19 03:42:55.323054', 'dgt', '12233334444', 'dgt@qq.com', '运维开发', 2, 1);
INSERT INTO `user_userprofile` VALUES (3, 'pbkdf2_sha256$150000$lCrZG7wtkhae$yQiFH7B0AdKKUSwVb+jQbON4VNZbqWIf3xjlMWltBTA=', NULL, 0, 'ywl', 'dong', 'guotao', 0, 1, '2021-08-07 09:14:59.143494', 'admin', '2021-08-07 09:14:59.144166', '2021-08-16 03:52:39.586343', 'ywl', '17788885556', 'ywl@qq.com', '运维开发', 2, 1);
INSERT INTO `user_userprofile` VALUES (4, 'pbkdf2_sha256$150000$lCrZG7wtkhae$yQiFH7B0AdKKUSwVb+jQbON4VNZbqWIf3xjlMWltBTA=', NULL, 0, 'test', '', '', 0, 1, '2021-08-12 00:42:00.000000', 'admin', '2021-08-12 00:42:53.592792', '2021-08-19 16:27:39.322561', 'test', '11122223333', 'test@qq.com', 'testtttt', 30, NULL);
INSERT INTO `user_userprofile` VALUES (5, '!2BfRtXxvQ2Qk5CfNPPDlab62Y2Dvxw9hiC0Kehak', NULL, 0, 'test2', 'test2', '', 0, 1, '2021-08-13 14:17:30.605429', 'admin', '2021-08-13 14:17:30.606481', '2021-08-16 14:38:01.799705', 'test2', '111111111', 'test2@qq.com', NULL, NULL, NULL);
INSERT INTO `user_userprofile` VALUES (6, '!6HjZW2RGcLKmquAX5Hl3Y1DRukm5RXaMcdNLhXs3', NULL, 0, 'test3', 'test3', '', 0, 1, '2021-08-13 14:41:33.787069', 'admin', '2021-08-13 14:41:33.791362', '2021-08-16 14:41:27.094764', 'test3', '', 'test3@qq.com', NULL, 1, NULL);
INSERT INTO `user_userprofile` VALUES (7, '!m9MWO10MO9QGb1vMyfDt896QJvVyNTG07JDnEx9O', NULL, 0, 'test4', 'test4', '', 0, 1, '2021-08-16 09:11:28.322762', 'admin', '2021-08-16 09:11:28.323345', '2021-08-16 14:41:53.079937', 'test4', '', 'test4@qq.com', NULL, 30, NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_userprofile_groups
-- ----------------------------
DROP TABLE IF EXISTS `user_userprofile_groups`;
CREATE TABLE `user_userprofile_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_userprofile_groups_userprofile_id_group_id_52847a61_uniq` (`userprofile_id`,`group_id`),
  KEY `user_userprofile_groups_group_id_98cc4038_fk_auth_group_id` (`group_id`),
  CONSTRAINT `user_userprofile_gro_userprofile_id_49724c40_fk_user_user` FOREIGN KEY (`userprofile_id`) REFERENCES `user_userprofile` (`id`),
  CONSTRAINT `user_userprofile_groups_group_id_98cc4038_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_userprofile_groups
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_userprofile_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_userprofile_roles`;
CREATE TABLE `user_userprofile_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_userprofile_roles_userprofile_id_role_id_73dc3873_uniq` (`userprofile_id`,`role_id`),
  KEY `user_userprofile_roles_role_id_875cb2d8_fk_user_role_id` (`role_id`),
  CONSTRAINT `user_userprofile_rol_userprofile_id_153ebc6a_fk_user_user` FOREIGN KEY (`userprofile_id`) REFERENCES `user_userprofile` (`id`),
  CONSTRAINT `user_userprofile_roles_role_id_875cb2d8_fk_user_role_id` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_userprofile_roles
-- ----------------------------
BEGIN;
INSERT INTO `user_userprofile_roles` VALUES (5, 1, 1);
INSERT INTO `user_userprofile_roles` VALUES (31, 2, 18);
INSERT INTO `user_userprofile_roles` VALUES (4, 3, 1);
INSERT INTO `user_userprofile_roles` VALUES (34, 4, 14);
INSERT INTO `user_userprofile_roles` VALUES (27, 5, 1);
INSERT INTO `user_userprofile_roles` VALUES (28, 7, 18);
COMMIT;

-- ----------------------------
-- Table structure for user_userprofile_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `user_userprofile_user_permissions`;
CREATE TABLE `user_userprofile_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_userprofile_user_pe_userprofile_id_permissio_2e86ceca_uniq` (`userprofile_id`,`permission_id`),
  KEY `user_userprofile_use_permission_id_7f559b23_fk_auth_perm` (`permission_id`),
  CONSTRAINT `user_userprofile_use_permission_id_7f559b23_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_userprofile_use_userprofile_id_68dc814c_fk_user_user` FOREIGN KEY (`userprofile_id`) REFERENCES `user_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_userprofile_user_permissions
-- ----------------------------
BEGIN;
INSERT INTO `user_userprofile_user_permissions` VALUES (1, 2, 3);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

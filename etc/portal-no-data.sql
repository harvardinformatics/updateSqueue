-- MySQL dump 10.16  Distrib 10.2.14-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: portal
-- ------------------------------------------------------
-- Server version	10.2.14-MariaDB

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
-- Table structure for table `account_request`
--

DROP TABLE IF EXISTS `account_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_request` (
  `request_ptr_id` int(11) NOT NULL,
  `username` varchar(40) NOT NULL,
  `pi_id` int(11) DEFAULT NULL,
  `first_name` varchar(200) DEFAULT NULL,
  `last_name` varchar(200) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `title` varchar(20) NOT NULL,
  `department` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `user_type` varchar(10) NOT NULL,
  `grants` varchar(1000) DEFAULT NULL,
  `initial_password` varchar(100) DEFAULT NULL,
  `primary_group` varchar(50) DEFAULT NULL,
  `other_groups` varchar(500) DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `require_password_reset` tinyint(1) NOT NULL,
  `campus_address` varchar(200) DEFAULT NULL,
  `notes` varchar(2000) DEFAULT NULL,
  `harvard_key` varchar(30) DEFAULT NULL,
  `description` varchar(1000),
  PRIMARY KEY (`request_ptr_id`),
  KEY `account_request_30b7651c` (`pi_id`),
  CONSTRAINT `pi_id_refs_id_47a6cb1d` FOREIGN KEY (`pi_id`) REFERENCES `rcuser` (`id`),
  CONSTRAINT `request_ptr_id_refs_id_9469abc2` FOREIGN KEY (`request_ptr_id`) REFERENCES `request` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app`
--

DROP TABLE IF EXISTS `app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `install_instructions` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1095 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_tag`
--

DROP TABLE IF EXISTS `app_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `value` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_tag_app_name_idx` (`app_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1162 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `build`
--

DROP TABLE IF EXISTS `build`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `release` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `module_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `module_title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `spec_author` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `requestor` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `publication` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `request_ref` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `compiler` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `mpi` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `build_dependencies` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `run_dependencies` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `load` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `module_path` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `app_path` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `build_date` datetime NOT NULL,
  `build_host` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `build_host_version` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `comments` longtext COLLATE utf8_unicode_ci NOT NULL,
  `build_order` int(11) NOT NULL,
  `is_latest` tinyint(1) NOT NULL,
  `extra_details` longtext COLLATE utf8_unicode_ci NOT NULL,
  `os` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `build_module_name_os_uniq` (`module_name`,`type`,`os`),
  KEY `build_app_name` (`app_name`),
  KEY `build_module_title` (`module_title`)
) ENGINE=InnoDB AUTO_INCREMENT=3035 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `build_report`
--

DROP TABLE IF EXISTS `build_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `module_title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `build_order` int(11) NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `os` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2667 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=291 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dups`
--

DROP TABLE IF EXISTS `dups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dups` (
  `display_name` varchar(200) CHARACTER SET utf8 NOT NULL,
  `cnt` bigint(21) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eric_rimm`
--

DROP TABLE IF EXISTS `eric_rimm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eric_rimm` (
  `id` int(11) NOT NULL DEFAULT 0,
  `password` varchar(128) CHARACTER SET utf8 NOT NULL,
  `last_login` datetime NOT NULL,
  `username` varchar(40) CHARACTER SET utf8 NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 NOT NULL,
  `first_name` varchar(200) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(200) CHARACTER SET utf8 NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) DEFAULT NULL,
  `date_joined` datetime NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `pgid` varchar(10) CHARACTER SET utf8 NOT NULL,
  `pgroup` varchar(200) CHARACTER SET utf8 NOT NULL,
  `pi_id` int(11) DEFAULT NULL,
  `dn` varchar(200) CHARACTER SET utf8 NOT NULL,
  `cleansers` varchar(1000) CHARACTER SET utf8 NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grant`
--

DROP TABLE IF EXISTS `grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `group` varchar(100) DEFAULT NULL,
  `request_type` varchar(100) NOT NULL,
  `processor` varchar(100) NOT NULL,
  `request_url` varchar(100) DEFAULT NULL,
  `approvers` varchar(1000) DEFAULT NULL,
  `new_account_display` tinyint(1) NOT NULL,
  `category` varchar(20) NOT NULL,
  `related_grants` varchar(100) DEFAULT NULL,
  `alacarte_display` tinyint(1) NOT NULL,
  `selected_by_default` tinyint(1) DEFAULT NULL,
  `optional_related_grants` varchar(1000),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `grant_name_1384f6569989fe53_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2701 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grantdata`
--

DROP TABLE IF EXISTS `grantdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grantdata` (
  `name` varchar(200) CHARACTER SET utf8 NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `group` varchar(200) CHARACTER SET utf8 NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_jobcount`
--

DROP TABLE IF EXISTS `group_jobcount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_jobcount` (
  `pgroup` varchar(200) CHARACTER SET utf8 NOT NULL,
  `year` int(4) DEFAULT NULL,
  `month` int(2) DEFAULT NULL,
  `jobcounts` bigint(21) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_ticket_count`
--

DROP TABLE IF EXISTS `group_ticket_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_ticket_count` (
  `pgroup` varchar(200) CHARACTER SET utf8 NOT NULL,
  `cnt` bigint(21) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_usercount`
--

DROP TABLE IF EXISTS `group_usercount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_usercount` (
  `userlogin` varchar(40) CHARACTER SET utf8 NOT NULL,
  `pgroup` varchar(200) CHARACTER SET utf8 NOT NULL,
  `year` int(4) DEFAULT NULL,
  `month` int(2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpcactus_run`
--

DROP TABLE IF EXISTS `hpcactus_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpcactus_run` (
  `run_ptr_id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `last_status_check` datetime DEFAULT NULL,
  `project_dir` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `config_file` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `hal_file` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `sequence_file` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `default_memory` bigint(20) NOT NULL,
  `bigmemory_threshold` bigint(20) NOT NULL,
  `slurm_time` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `slurm_partition` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slurm_jobname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slurm_scriptpath` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `retry_count` int(11) NOT NULL,
  `slurm_constraint` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`run_ptr_id`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `run_ptr_id_refs_id_3746e540` FOREIGN KEY (`run_ptr_id`) REFERENCES `run` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs_squeueq`
--

DROP TABLE IF EXISTS `jobs_squeueq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs_squeueq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lastupdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `jobs_squeueq` (lastupdate) values ('2019-01-01');
--
-- Table structure for table `jobs_squeueresults`
--

DROP TABLE IF EXISTS `jobs_squeueresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs_squeueresults` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `squeueq_id` int(11) NOT NULL,
  `account` varchar(100) NOT NULL,
  `gres` varchar(100) NOT NULL,
  `min_cpus` int(11) NOT NULL,
  `min_tmp_disk` varchar(10) NOT NULL,
  `end_time` varchar(20) NOT NULL,
  `features` varchar(100) NOT NULL,
  `shared` varchar(10) NOT NULL,
  `jobid` varchar(1000) NOT NULL,
  `name` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `timelimit` varchar(20) NOT NULL,
  `min_memory` varchar(10) NOT NULL,
  `req_nodes` varchar(100) NOT NULL,
  `command` varchar(255) NOT NULL,
  `qos` varchar(10) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `user` varchar(100) NOT NULL,
  `reservation` varchar(50) NOT NULL,
  `exc_nodes` varchar(100) NOT NULL,
  `nice` int(11) NOT NULL,
  `exec_host` varchar(50) NOT NULL,
  `cpus` int(11) NOT NULL,
  `nodes` int(11) NOT NULL,
  `dependency` varchar(50) NOT NULL,
  `array_job_id` int(11) NOT NULL,
  `group` varchar(50) NOT NULL,
  `array_task_id` varchar(50) NOT NULL,
  `time_left` varchar(20) NOT NULL,
  `time` varchar(20) NOT NULL,
  `node_list` varchar(2000) NOT NULL,
  `contiguous` tinyint(1) NOT NULL,
  `partition` varchar(50) NOT NULL,
  `priority` int(11) NOT NULL,
  `nodelistreason` varchar(2000) NOT NULL,
  `start_time` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `submit_time` varchar(20) NOT NULL,
  `licenses` varchar(100) NOT NULL,
  `work_dir` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_squeueresults_f945c6ae` (`squeueq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=144935226 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobtemp`
--

DROP TABLE IF EXISTS `jobtemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobtemp` (
  `id` int(11) NOT NULL DEFAULT 0,
  `squeueq_id` int(11) NOT NULL,
  `account` varchar(100) NOT NULL,
  `gres` varchar(100) NOT NULL,
  `min_cpus` int(11) NOT NULL,
  `min_tmp_disk` varchar(10) NOT NULL,
  `end_time` varchar(20) NOT NULL,
  `features` varchar(100) NOT NULL,
  `shared` varchar(10) NOT NULL,
  `jobid` varchar(1000) NOT NULL,
  `name` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `timelimit` varchar(20) NOT NULL,
  `min_memory` varchar(10) NOT NULL,
  `req_nodes` varchar(100) NOT NULL,
  `command` varchar(255) NOT NULL,
  `qos` varchar(10) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `user` varchar(100) NOT NULL,
  `reservation` varchar(50) NOT NULL,
  `exc_nodes` varchar(100) NOT NULL,
  `nice` int(11) NOT NULL,
  `exec_host` varchar(50) NOT NULL,
  `cpus` int(11) NOT NULL,
  `nodes` int(11) NOT NULL,
  `dependency` varchar(50) NOT NULL,
  `array_job_id` int(11) NOT NULL,
  `group` varchar(50) NOT NULL,
  `array_task_id` varchar(50) NOT NULL,
  `time_left` varchar(20) NOT NULL,
  `time` varchar(20) NOT NULL,
  `node_list` varchar(2000) NOT NULL,
  `contiguous` tinyint(1) NOT NULL,
  `partition` varchar(50) NOT NULL,
  `priority` int(11) NOT NULL,
  `nodelistreason` varchar(2000) NOT NULL,
  `start_time` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `submit_time` varchar(20) NOT NULL,
  `licenses` varchar(100) NOT NULL,
  `work_dir` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab2school`
--

DROP TABLE IF EXISTS `lab2school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab2school` (
  `lab` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `dept` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `company` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `maxrsid`
--

DROP TABLE IF EXISTS `maxrsid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maxrsid` (
  `request_id` int(11) NOT NULL,
  `maxrs` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newgroup`
--

DROP TABLE IF EXISTS `newgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newgroup` (
  `name` varchar(200) CHARACTER SET utf8 NOT NULL,
  `gid` varchar(10) CHARACTER SET utf8 NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newstate`
--

DROP TABLE IF EXISTS `newstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newstate` (
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `request_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newuser`
--

DROP TABLE IF EXISTS `newuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newuser` (
  `username` varchar(40) CHARACTER SET utf8 NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 NOT NULL,
  `first_name` varchar(200) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(200) CHARACTER SET utf8 NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `object_sid` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `dn` varchar(200) CHARACTER SET utf8 NOT NULL,
  `pgid` varchar(10) CHARACTER SET utf8 NOT NULL,
  `pgroup` varchar(200) CHARACTER SET utf8 NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `odymail_queue`
--

DROP TABLE IF EXISTS `odymail_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `odymail_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tostr` longtext COLLATE utf8_unicode_ci NOT NULL,
  `fromstr` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ccstr` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `bccstr` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31871 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `odymailing`
--

DROP TABLE IF EXISTS `odymailing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `odymailing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tostr` longtext COLLATE utf8_unicode_ci NOT NULL,
  `fromstr` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ccstr` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `bccstr` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `sent` datetime DEFAULT NULL,
  `odymessage_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `odymailing_9085445b` (`odymessage_id`),
  CONSTRAINT `odymessage_id_refs_id_21ec1ae0` FOREIGN KEY (`odymessage_id`) REFERENCES `odymessage` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `odymailing_recipient`
--

DROP TABLE IF EXISTS `odymailing_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `odymailing_recipient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipient_id` int(11) NOT NULL,
  `mailing_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `odymailing_recipient_3e31d986` (`recipient_id`),
  KEY `odymailing_recipient_977a2ad4` (`mailing_id`),
  CONSTRAINT `mailing_id_refs_id_8adb846e` FOREIGN KEY (`mailing_id`) REFERENCES `odymailing` (`id`),
  CONSTRAINT `recipient_id_refs_id_6062c65e` FOREIGN KEY (`recipient_id`) REFERENCES `rcuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=778 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `odymessage`
--

DROP TABLE IF EXISTS `odymessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `odymessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `office_hours_sign_in`
--

DROP TABLE IF EXISTS `office_hours_sign_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_hours_sign_in` (
  `rcuser` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pi` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `department` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `reason` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `old_request_state`
--

DROP TABLE IF EXISTS `old_request_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_request_state` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `username` varchar(40) CHARACTER SET utf8 NOT NULL,
  `request_id` int(11) NOT NULL,
  `comment` varchar(1000) CHARACTER SET utf8 DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `old_request_state_approvers`
--

DROP TABLE IF EXISTS `old_request_state_approvers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_request_state_approvers` (
  `id` int(11) NOT NULL DEFAULT 0,
  `requeststate_id` int(11) NOT NULL,
  `rcusermodel_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oldruns`
--

DROP TABLE IF EXISTS `oldruns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oldruns` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `status_code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_status_check` datetime DEFAULT NULL,
  `working_dir` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `config_file` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `hal_file` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `sequence_file` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `default_memory` bigint(20) NOT NULL,
  `bigmemory_threshold` bigint(20) NOT NULL,
  `slurm_time` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `slurm_partition` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slurm_jobname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `cmd` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `pid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result_code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `slurm_scriptpath` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `project_dir` varchar(1024) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pi_group`
--

DROP TABLE IF EXISTS `pi_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pi_group` (
  `username` varchar(40) CHARACTER SET utf8 NOT NULL,
  `display_name` varchar(200) CHARACTER SET utf8 NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pwreset_passwordreset`
--

DROP TABLE IF EXISTS `pwreset_passwordreset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pwreset_passwordreset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  `hash` varchar(65) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14123 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcgroup`
--

DROP TABLE IF EXISTS `rcgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `display_name` varchar(200) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `gid` varchar(10) NOT NULL,
  `pidn` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3290 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcgroup2discipline`
--

DROP TABLE IF EXISTS `rcgroup2discipline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcgroup2discipline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcgroupname` varchar(200) NOT NULL,
  `department` varchar(100) NOT NULL,
  `discipline` varchar(50) NOT NULL,
  `division` varchar(100) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rcgroup2discipline_rcgroupname_ca4d4e150ad4947_uniq` (`rcgroupname`,`department`,`discipline`)
) ENGINE=InnoDB AUTO_INCREMENT=943 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcgroup2group`
--

DROP TABLE IF EXISTS `rcgroup2group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcgroup2group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcgroups` varchar(1000) NOT NULL,
  `group` varchar(1000) NOT NULL,
  `transform` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcgroup_attr`
--

DROP TABLE IF EXISTS `rcgroup_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcgroup_attr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `value` varchar(1000) NOT NULL,
  `rcgroup_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rcgroup_attr_83c4b8dc` (`rcgroup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=379207 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcuser`
--

DROP TABLE IF EXISTS `rcuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `username` varchar(40) NOT NULL,
  `email` varchar(100) NOT NULL,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) DEFAULT NULL,
  `date_joined` datetime NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `pgid` varchar(10) NOT NULL,
  `pgroup` varchar(200) NOT NULL,
  `pi_id` int(11) DEFAULT NULL,
  `dn` varchar(200) NOT NULL,
  `cleansers` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `rcuser_email` (`email`),
  KEY `rcuser_d87bb286` (`pi_id`),
  CONSTRAINT `pi_id_refs_id_4d9f0696` FOREIGN KEY (`pi_id`) REFERENCES `rcuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=445222 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcuser_attr`
--

DROP TABLE IF EXISTS `rcuser_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcuser_attr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `value` varchar(1000) NOT NULL,
  `rcuser_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rcuser_attr_9c0bcdab` (`rcuser_id`),
  CONSTRAINT `fk_rcuser_id` FOREIGN KEY (`rcuser_id`) REFERENCES `rcuser` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2702251 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcuser_email`
--

DROP TABLE IF EXISTS `rcuser_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcuser_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcuser_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rcuser_email_rcuser_id_45053bf3ba889b35_uniq` (`rcuser_id`,`email`),
  KEY `rcuser_email_9c0bcdab` (`rcuser_id`),
  CONSTRAINT `fk_rcuser_rcuser_email` FOREIGN KEY (`rcuser_id`) REFERENCES `rcuser` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26391 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcuser_groups`
--

DROP TABLE IF EXISTS `rcuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcusermodel_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rcuser_groups_rcusermodel_id_3162c48a971a6a0c_uniq` (`rcusermodel_id`,`group_id`),
  KEY `rcuser_groups_8a25a336` (`rcusermodel_id`),
  KEY `rcuser_groups_5f412f9a` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=186260 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcuser_interaction`
--

DROP TABLE IF EXISTS `rcuser_interaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcuser_interaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_member_id` int(11) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `rcuser_id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `project` varchar(200) DEFAULT NULL,
  `comments` longtext DEFAULT NULL,
  `temperature` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=584 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcuser_rcgroup`
--

DROP TABLE IF EXISTS `rcuser_rcgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcuser_rcgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcuser_id` int(11) NOT NULL,
  `rcgroup_id` int(11) NOT NULL,
  `roles` varchar(500) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rcuser_rcgroup_9c0bcdab` (`rcuser_id`),
  KEY `rcuser_rcgroup_83c4b8dc` (`rcgroup_id`),
  CONSTRAINT `rcuser_id_refs_id_3affed9b` FOREIGN KEY (`rcuser_id`) REFERENCES `rcuser` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94278 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcuser_summary`
--

DROP TABLE IF EXISTS `rcuser_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcuser_summary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcuser_id` int(11) NOT NULL,
  `text` longtext NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `temperature` int(10) unsigned DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rcuser_summary_rcuser_id_7eba8dec5b22d111_uniq` (`rcuser_id`,`version`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rcuser_user_permissions`
--

DROP TABLE IF EXISTS `rcuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rcuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcusermodel_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rcuser_user_permissions_rcusermodel_id_8bafdf88504fd4f_uniq` (`rcusermodel_id`,`permission_id`),
  KEY `rcuser_user_permissions_8a25a336` (`rcusermodel_id`),
  KEY `rcuser_user_permissions_83d7f98b` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_type` varchar(100) NOT NULL,
  `current_state` varchar(100) DEFAULT NULL,
  `result` varchar(100) DEFAULT NULL,
  `processor` varchar(100) NOT NULL,
  `grant_id` int(11) DEFAULT NULL,
  `requestor_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `auto_approve` tinyint(1) NOT NULL,
  `data` varchar(2000) DEFAULT NULL,
  `pi_labgroup_dn` varchar(200),
  PRIMARY KEY (`id`),
  KEY `request_8c038ea0` (`grant_id`),
  KEY `request_c0bbec41` (`requestor_id`),
  CONSTRAINT `grant_id_refs_id_263789aa` FOREIGN KEY (`grant_id`) REFERENCES `grant` (`id`),
  CONSTRAINT `requestor_id_rcuser` FOREIGN KEY (`requestor_id`) REFERENCES `rcuser` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36460 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `request_approvers`
--

DROP TABLE IF EXISTS `request_approvers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_approvers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `rcusermodel_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `request_approvers_request_id_419aef6e615231db_uniq` (`request_id`,`rcusermodel_id`),
  KEY `request_approvers_ad319329` (`request_id`),
  KEY `request_approvers_8a25a336` (`rcusermodel_id`),
  CONSTRAINT `rcusermodel_id_refs_id_35dba4f6` FOREIGN KEY (`rcusermodel_id`) REFERENCES `rcuser` (`id`),
  CONSTRAINT `request_approver_request_id` FOREIGN KEY (`request_id`) REFERENCES `request` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48197 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `request_state`
--

DROP TABLE IF EXISTS `request_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `username` varchar(40) NOT NULL,
  `request_id` int(11) NOT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `request_state_ad319329` (`request_id`),
  CONSTRAINT `request_state_request_id` FOREIGN KEY (`request_id`) REFERENCES `request` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=190316 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `request_state_approvers`
--

DROP TABLE IF EXISTS `request_state_approvers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_state_approvers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requeststate_id` int(11) NOT NULL,
  `rcusermodel_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `request_state_approvers_requeststate_id_1dede43818c49ffb_uniq` (`requeststate_id`,`rcusermodel_id`),
  KEY `request_state_approvers_4b666856` (`requeststate_id`),
  KEY `request_state_approvers_8a25a336` (`rcusermodel_id`),
  CONSTRAINT `rcusermodel_id_refs_id_89e512ed` FOREIGN KEY (`rcusermodel_id`) REFERENCES `rcuser` (`id`),
  CONSTRAINT `requeststate_id_refs_id_f62c9888` FOREIGN KEY (`requeststate_id`) REFERENCES `request_state` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20590 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `type` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `comments` longtext NOT NULL,
  `contact_emails` varchar(1000) NOT NULL,
  `created` date NOT NULL,
  `updated` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_cb902d83` (`owner_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `run`
--

DROP TABLE IF EXISTS `run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `run` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cmd` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `working_dir` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `env` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result_code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `stdin` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `stdout` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `stderr` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `status_code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `host` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runner`
--

DROP TABLE IF EXISTS `runner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `runner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkin` datetime DEFAULT NULL,
  `host` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `pid` int(11) NOT NULL,
  `logfile` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=519 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `signup_list`
--

DROP TABLE IF EXISTS `signup_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signup_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcuser` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pi` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `department` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created` date NOT NULL,
  `reason` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=664 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `south_migrationhistory`
--

DROP TABLE IF EXISTS `south_migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_request`
--

DROP TABLE IF EXISTS `storage_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_request` (
  `request_ptr_id` int(11) NOT NULL,
  `lab_pi_id` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `storage_request_size` varchar(1000) DEFAULT NULL,
  `local_mounting` tinyint(1) NOT NULL,
  `globus_transfer` tinyint(1) NOT NULL,
  `heavy_IO` tinyint(1) NOT NULL,
  `sharing` tinyint(1) NOT NULL,
  `secure_information` tinyint(1) NOT NULL,
  `dua` tinyint(1) NOT NULL,
  `comments` varchar(2000) DEFAULT NULL,
  `project_name` varchar(40) NOT NULL,
  `university_transfer` tinyint(1) NOT NULL,
  `web_transfer` tinyint(1) NOT NULL,
  `billing_code` varchar(39) DEFAULT NULL,
  PRIMARY KEY (`request_ptr_id`),
  CONSTRAINT `storage_request_request_ptr_id_2342c6f493769839_fk_request_id` FOREIGN KEY (`request_ptr_id`) REFERENCES `request` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_perf`
--

DROP TABLE IF EXISTS `test_perf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_perf` (
  `id` int(11) NOT NULL DEFAULT 0,
  `squeueq_id` int(11) NOT NULL,
  `account` varchar(100) NOT NULL,
  `gres` varchar(100) NOT NULL,
  `min_cpus` int(11) NOT NULL,
  `min_tmp_disk` varchar(10) NOT NULL,
  `end_time` varchar(20) NOT NULL,
  `features` varchar(100) NOT NULL,
  `shared` varchar(10) NOT NULL,
  `jobid` varchar(1000) NOT NULL,
  `name` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `timelimit` varchar(20) NOT NULL,
  `min_memory` varchar(10) NOT NULL,
  `req_nodes` varchar(100) NOT NULL,
  `command` varchar(255) NOT NULL,
  `qos` varchar(10) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `user` varchar(100) NOT NULL,
  `reservation` varchar(50) NOT NULL,
  `exc_nodes` varchar(100) NOT NULL,
  `nice` int(11) NOT NULL,
  `exec_host` varchar(50) NOT NULL,
  `cpus` int(11) NOT NULL,
  `nodes` int(11) NOT NULL,
  `dependency` varchar(50) NOT NULL,
  `array_job_id` int(11) NOT NULL,
  `group` varchar(50) NOT NULL,
  `array_task_id` varchar(50) NOT NULL,
  `time_left` varchar(20) NOT NULL,
  `time` varchar(20) NOT NULL,
  `node_list` varchar(2000) NOT NULL,
  `contiguous` tinyint(1) NOT NULL,
  `partition` varchar(50) NOT NULL,
  `priority` int(11) NOT NULL,
  `nodelistreason` varchar(2000) NOT NULL,
  `start_time` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `submit_time` varchar(20) NOT NULL,
  `licenses` varchar(100) NOT NULL,
  `work_dir` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketcache`
--

DROP TABLE IF EXISTS `ticketcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketcache` (
  `ticket_id` int(11) NOT NULL DEFAULT 0,
  `ticket_created` datetime DEFAULT NULL,
  `rcuser_username` varchar(40) NOT NULL,
  `rcuser_email` varchar(100) NOT NULL,
  `owner_username` varchar(40) NOT NULL,
  `content` longblob DEFAULT NULL,
  `subject` varchar(200) CHARACTER SET utf8 DEFAULT '[no subject]'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `training_results`
--

DROP TABLE IF EXISTS `training_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `test_id` int(11) NOT NULL,
  `test_name` varchar(200) NOT NULL,
  `rc_username` varchar(40) NOT NULL,
  `rc_email` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `passed` tinyint(1) NOT NULL,
  `rawtext` longtext NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2508 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vocabulary`
--

DROP TABLE IF EXISTS `vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vocabulary` (
  `id` int(11) NOT NULL DEFAULT 0,
  `key` varchar(100) CHARACTER SET latin1 NOT NULL,
  `value` varchar(1000) CHARACTER SET latin1 NOT NULL,
  `description` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `order` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-13 10:44:29

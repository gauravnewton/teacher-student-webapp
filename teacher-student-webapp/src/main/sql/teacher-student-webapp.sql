-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 28, 2021 at 10:47 AM
-- Server version: 8.0.21
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `teacher-student-webapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `courseName` varchar(255) NOT NULL,
  `courseCategory` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `createdOn` datetime NOT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `createdBy` varchar(255) NOT NULL,
  `updatedBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `courseName`, `courseCategory`, `author`, `status`, `createdOn`, `updatedOn`, `createdBy`, `updatedBy`) VALUES
(5, 'Test', 'Test', 'Test', 'ACTIVE', '2021-09-28 16:08:56', NULL, 'SELF', NULL),
(4, 'Java Head first', 'Gaurav', 'Pearson', 'ACTIVE', '2021-09-28 16:08:42', NULL, 'SELF', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rolepermission`
--

DROP TABLE IF EXISTS `rolepermission`;
CREATE TABLE IF NOT EXISTS `rolepermission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roleId` int NOT NULL,
  `permission` tinyint(1) NOT NULL,
  `permissionCode` varchar(255) NOT NULL,
  `createdOn` datetime NOT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `createdBy` varchar(255) NOT NULL,
  `updatedBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) NOT NULL,
  `roleCode` varchar(255) NOT NULL,
  `createdOn` datetime NOT NULL,
  `createdBy` varchar(255) NOT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `updatedBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `roleName`, `roleCode`, `createdOn`, `createdBy`, `updatedOn`, `updatedBy`) VALUES
(1, 'basic student role', 'STUDENT_ROLE', '2021-09-27 16:33:25', 'ADMIN', NULL, NULL),
(2, 'basic teacher role', 'TEACHER_ROLE', '2021-09-27 16:33:25', 'ADMIN', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `studentcourseenrollments`
--

DROP TABLE IF EXISTS `studentcourseenrollments`;
CREATE TABLE IF NOT EXISTS `studentcourseenrollments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `courseId` int NOT NULL,
  `studentId` int NOT NULL,
  `enrolledOn` datetime NOT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `createdBy` varchar(255) NOT NULL,
  `updatedBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `studentcourseenrollments`
--

INSERT INTO `studentcourseenrollments` (`id`, `courseId`, `studentId`, `enrolledOn`, `updatedOn`, `createdBy`, `updatedBy`) VALUES
(6, 5, 4, '2021-09-28 16:10:20', NULL, 'SELF', NULL),
(5, 4, 4, '2021-09-28 16:09:46', NULL, 'SELF', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
CREATE TABLE IF NOT EXISTS `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `createdOn` datetime NOT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `createdBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `updatedBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `roleCode` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `firstName`, `lastName`, `email`, `password`, `phone`, `gender`, `createdOn`, `updatedOn`, `createdBy`, `updatedBy`, `roleCode`, `status`) VALUES
(4, 'Gaurav', 'kumar', 'nayno@yopmail.com', 'Test@123', '000000000', 'Male', '2021-09-28 16:05:59', '2021-09-28 16:11:20', 'SELF', 'Gaurav kumar', 'STUDENT_ROLE', 'DELETED');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
CREATE TABLE IF NOT EXISTS `teachers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `createdOn` datetime NOT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `createdBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `updatedBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `roleCode` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `firstName`, `lastname`, `email`, `password`, `phone`, `gender`, `createdOn`, `updatedOn`, `createdBy`, `updatedBy`, `roleCode`, `status`) VALUES
(3, 'Gaurav', 'kumar', 'nayno@yopmail.com', 'Test@123', '938908809', 'Male', '2021-09-28 16:06:57', NULL, 'SELF', NULL, 'TEACHER_ROLE', 'ACTIVE');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

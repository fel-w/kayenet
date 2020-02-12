-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 30, 2019 at 02:35 PM
-- Server version: 5.7.24
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kayenet`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `No` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `UserName` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`No`, `FirstName`, `LastName`, `UserName`, `Password`, `PhoneNumber`) VALUES
(1, 'Felix', 'Wangota', 'fel', '1a1dc91c907325c69271ddf0c944bc72', '0705444606');

-- --------------------------------------------------------

--
-- Table structure for table `kaw_pdts`
--

DROP TABLE IF EXISTS `kaw_pdts`;
CREATE TABLE IF NOT EXISTS `kaw_pdts` (
  `No` int(11) NOT NULL AUTO_INCREMENT,
  `BagID` varchar(20) DEFAULT NULL,
  `Name` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Image` varchar(200) NOT NULL,
  `Price` int(10) NOT NULL,
  `Quantity` int(5) NOT NULL,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kaw_pdts`
--

INSERT INTO `kaw_pdts` (`No`, `BagID`, `Name`, `Description`, `Image`, `Price`, `Quantity`) VALUES
(1, 'KAW-1', 'Gucci', 'Blue', 'Screenshot (14).png', 1200, 88);

-- --------------------------------------------------------

--
-- Table structure for table `kaw_sales`
--

DROP TABLE IF EXISTS `kaw_sales`;
CREATE TABLE IF NOT EXISTS `kaw_sales` (
  `No` int(11) NOT NULL AUTO_INCREMENT,
  `BagID` varchar(20) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Image` blob NOT NULL,
  `Price` int(10) NOT NULL,
  `Quantity` int(5) NOT NULL,
  `QuantitySold` int(11) NOT NULL,
  `DateSold` date NOT NULL,
  `TotalAmount` int(11) NOT NULL,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kaw_sales`
--

INSERT INTO `kaw_sales` (`No`, `BagID`, `Name`, `Description`, `Image`, `Price`, `Quantity`, `QuantitySold`, `DateSold`, `TotalAmount`) VALUES
(1, 'KAW-1', 'Gucci', 'black and green', 0x53637265656e73686f7420283134292e706e67, 1200, 100, 11, '2019-04-25', 13200),
(2, 'KAW-1', 'Gucci', 'black and green', 0x53637265656e73686f7420283134292e706e67, 1200, 89, 1, '2019-04-25', 1200);

-- --------------------------------------------------------

--
-- Table structure for table `men_pdts`
--

DROP TABLE IF EXISTS `men_pdts`;
CREATE TABLE IF NOT EXISTS `men_pdts` (
  `No` int(11) NOT NULL AUTO_INCREMENT,
  `BagID` varchar(20) DEFAULT NULL,
  `Name` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Image` varchar(200) NOT NULL,
  `Price` int(10) NOT NULL,
  `Quantity` int(5) NOT NULL,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `men_pdts`
--

INSERT INTO `men_pdts` (`No`, `BagID`, `Name`, `Description`, `Image`, `Price`, `Quantity`) VALUES
(1, 'MEN-1', 'Tommy', 'Black', 'simple bag.jpg', 450000, 10);

-- --------------------------------------------------------

--
-- Table structure for table `men_sales`
--

DROP TABLE IF EXISTS `men_sales`;
CREATE TABLE IF NOT EXISTS `men_sales` (
  `No` int(11) NOT NULL AUTO_INCREMENT,
  `BagID` varchar(20) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Image` blob NOT NULL,
  `Price` int(10) NOT NULL,
  `Quantity` int(5) NOT NULL,
  `QuantitySold` int(11) NOT NULL,
  `DateSold` date NOT NULL,
  `TotalAmount` int(11) NOT NULL,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `men_sales`
--

INSERT INTO `men_sales` (`No`, `BagID`, `Name`, `Description`, `Image`, `Price`, `Quantity`, `QuantitySold`, `DateSold`, `TotalAmount`) VALUES
(1, 'MEN-1', 'Tommy', 'Black', 0x73696d706c65206261672e6a7067, 450000, 30, 20, '2019-04-30', 9000000);

-- --------------------------------------------------------

--
-- Table structure for table `nak_pdts`
--

DROP TABLE IF EXISTS `nak_pdts`;
CREATE TABLE IF NOT EXISTS `nak_pdts` (
  `No` int(11) NOT NULL AUTO_INCREMENT,
  `BagID` varchar(20) DEFAULT NULL,
  `Name` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Image` varchar(200) NOT NULL,
  `Price` int(10) NOT NULL,
  `Quantity` int(5) NOT NULL,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nak_pdts`
--

INSERT INTO `nak_pdts` (`No`, `BagID`, `Name`, `Description`, `Image`, `Price`, `Quantity`) VALUES
(1, 'NAK-1', 'Klein', 'Brown', 'bag.jpg', 60000, 10);

-- --------------------------------------------------------

--
-- Table structure for table `nak_sales`
--

DROP TABLE IF EXISTS `nak_sales`;
CREATE TABLE IF NOT EXISTS `nak_sales` (
  `No` int(11) NOT NULL AUTO_INCREMENT,
  `BagID` varchar(20) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Image` blob NOT NULL,
  `Price` int(10) NOT NULL,
  `Quantity` int(5) NOT NULL,
  `QuantitySold` int(11) NOT NULL,
  `DateSold` date NOT NULL,
  `TotalAmount` int(11) NOT NULL,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nak_sales`
--

INSERT INTO `nak_sales` (`No`, `BagID`, `Name`, `Description`, `Image`, `Price`, `Quantity`, `QuantitySold`, `DateSold`, `TotalAmount`) VALUES
(1, 'NAK-1', 'kk', 'kik', 0x53637265656e73686f7420283134292e706e67, 1200, 56, 2, '2019-04-25', 2400),
(2, 'NAK-1', 'Klein', 'Brown', 0x6261672e6a7067, 60000, 20, 10, '2019-04-30', 600000);

-- --------------------------------------------------------

--
-- Table structure for table `sales_person`
--

DROP TABLE IF EXISTS `sales_person`;
CREATE TABLE IF NOT EXISTS `sales_person` (
  `No` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Address` varchar(20) NOT NULL,
  `ReferencePerson` varchar(20) NOT NULL,
  `Branch` varchar(20) NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sales_person`
--

INSERT INTO `sales_person` (`No`, `FirstName`, `LastName`, `Username`, `Password`, `Address`, `ReferencePerson`, `Branch`, `PhoneNumber`) VALUES
(26, 'Paul', 'Kamasu', 'kpaul', '1a1dc91c907325c69271ddf0c944bc72', 'Kiwatule', 'Felix', 'KAW', '0750863254'),
(27, 'Aloyzous', 'Kiyingi', 'king', '1a1dc91c907325c69271ddf0c944bc72', 'Makerere', 'Guma', 'NAK', '0759429002'),
(23, 'Felix', 'Wangota', 'wangota', '1a1dc91c907325c69271ddf0c944bc72', 'Ntinda', 'Guma', 'KAW', '0705444606'),
(24, 'Nicholas', 'Kwizera', 'nico', '1a1dc91c907325c69271ddf0c944bc72', 'Gayaza', 'Aloysious', 'MEN', '0777003455');

-- --------------------------------------------------------

--
-- Table structure for table `upload_image`
--

DROP TABLE IF EXISTS `upload_image`;
CREATE TABLE IF NOT EXISTS `upload_image` (
  `bImage` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `upload_image`
--

INSERT INTO `upload_image` (`bImage`) VALUES
('Screenshot (14).png'),
('Screenshot (63).png'),
('Screenshot (64).png');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

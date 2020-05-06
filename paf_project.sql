-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2020 at 11:57 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `paf_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointmentID` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `patientID` int(11) NOT NULL,
  `doctorID` int(11) NOT NULL,
  `paymentID` int(11) NOT NULL,
  `appointmentStatus` varchar(10) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointmentID`, `date`, `time`, `patientID`, `doctorID`, `paymentID`, `appointmentStatus`) VALUES
(33, '2020-05-12', '00:00:00', 1, 3, 1, 'cancelled'),
(34, '2020-05-14', '00:00:00', 2, 4, 1, 'confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `hospital`
--

CREATE TABLE `hospital` (
  `H_ID` int(10) NOT NULL,
  `H_name` varchar(50) NOT NULL,
  `H_contactNumber` int(10) NOT NULL,
  `H_address` varchar(50) NOT NULL,
  `H_email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hospital`
--

INSERT INTO `hospital` (`H_ID`, `H_name`, `H_contactNumber`, `H_address`, `H_email`) VALUES
(1, 'Ninewells', 145698, 'colombo', 'info@nine.com'),
(2, 'Asiri', 2657745, 'Colombo', ''),
(3, 'Nawaloka', 2657745, 'Colombo 3', 'info@nawaloka.lk'),
(4, 'Durdans', 2659986, 'Colombo', 'info@durdans.lk');

-- --------------------------------------------------------

--
-- Table structure for table `hospital_docters`
--

CREATE TABLE `hospital_docters` (
  `Doctor_ID` int(11) NOT NULL,
  `D_Name` varchar(100) NOT NULL,
  `D_Type` varchar(100) NOT NULL,
  `D_Contact_Number` int(11) NOT NULL,
  `D_Address` varchar(100) NOT NULL,
  `D_Email` varchar(50) NOT NULL,
  `Hospital_ID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hospital_docters`
--

INSERT INTO `hospital_docters` (`Doctor_ID`, `D_Name`, `D_Type`, `D_Contact_Number`, `D_Address`, `D_Email`, `Hospital_ID`) VALUES
(1, 'Kenaya', 'Child Specialist', 778908485, 'Egodauyana', 'kenaya@yahoo.com', 1),
(2, 'kamak', 'cardio', 123, 'Colombo', 'kml@cal.lk', 2),
(3, 'Harsha', 'General', 7106998, 'Homagama', 'harsha@cal.lk', 4),
(4, 'Shanika', 'Menta Health', 778908586, 'Angulana', 'shanika@jhk.com', 3);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `paymentID` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `dateAndTime` datetime NOT NULL DEFAULT current_timestamp(),
  `amount` double NOT NULL,
  `paymentStatus` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`paymentID`, `type`, `dateAndTime`, `amount`, `paymentStatus`) VALUES
(1, 'cash', '2020-04-01 12:31:15', 50, 1),
(2, 'credit', '2020-04-03 06:33:21', 250, 127);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `User_ID` int(11) NOT NULL,
  `User_Name` varchar(100) NOT NULL,
  `U_NIC` varchar(100) NOT NULL,
  `U_Age` int(11) NOT NULL,
  `U_Contact_Number` int(11) NOT NULL,
  `U_Email` varchar(100) NOT NULL,
  `U_Address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`User_ID`, `User_Name`, `U_NIC`, `U_Age`, `U_Contact_Number`, `U_Email`, `U_Address`) VALUES
(1, 'dea', '124541v', 20, 245412, 'd@gmail.com', 'colombo'),
(2, 'Ashene', '986811756', 23, 764123533, 'nat@cal.lk', 'Dehiwala'),
(3, 'Natasha', '98687756V', 22, 7698635, 'natasha@cal.lk', 'Bambalapitiya');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `userName` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointmentID`),
  ADD KEY `patientID` (`patientID`),
  ADD KEY `fk_doctor` (`doctorID`),
  ADD KEY `fk_payment` (`paymentID`);

--
-- Indexes for table `hospital`
--
ALTER TABLE `hospital`
  ADD PRIMARY KEY (`H_ID`);

--
-- Indexes for table `hospital_docters`
--
ALTER TABLE `hospital_docters`
  ADD PRIMARY KEY (`Doctor_ID`),
  ADD KEY `Hospital_ID` (`Hospital_ID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`paymentID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`User_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `hospital`
--
ALTER TABLE `hospital`
  MODIFY `H_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `hospital_docters`
--
ALTER TABLE `hospital_docters`
  MODIFY `Doctor_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `fk2` FOREIGN KEY (`patientID`) REFERENCES `user` (`User_ID`),
  ADD CONSTRAINT `fk_doctor` FOREIGN KEY (`doctorID`) REFERENCES `hospital_docters` (`Doctor_ID`),
  ADD CONSTRAINT `fk_patient` FOREIGN KEY (`patientID`) REFERENCES `user` (`User_ID`),
  ADD CONSTRAINT `fk_payment` FOREIGN KEY (`paymentID`) REFERENCES `payment` (`paymentID`);

--
-- Constraints for table `hospital_docters`
--
ALTER TABLE `hospital_docters`
  ADD CONSTRAINT `hospital_docters_ibfk_1` FOREIGN KEY (`Hospital_ID`) REFERENCES `hospital` (`H_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

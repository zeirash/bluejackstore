-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2016 at 08:20 AM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `webprog_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE IF NOT EXISTS `carts` (
  `cart_id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `product_id`, `user_id`, `comment`, `rating`) VALUES
(2, 10, 5, 'yeay', 3);

-- --------------------------------------------------------

--
-- Table structure for table `details`
--

CREATE TABLE IF NOT EXISTS `details` (
  `detail_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `details`
--

INSERT INTO `details` (`detail_id`, `cart_id`, `transaction_id`, `product_id`, `user_id`, `quantity`) VALUES
(53, 9, 39, 11, 5, 5),
(58, 14, 48, 10, 7, 1),
(59, 15, 48, 11, 7, 1),
(60, 16, 49, 16, 7, 5),
(61, 17, 50, 18, 5, 2),
(62, 18, 50, 16, 5, 2),
(63, 19, 51, 18, 12, 11),
(64, 20, 52, 18, 10, 1),
(65, 21, 52, 16, 10, 1),
(66, 22, 52, 10, 10, 1),
(67, 23, 52, 11, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `product_id` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `weight` float NOT NULL,
  `stock` int(11) NOT NULL,
  `imagePath` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `productName`, `price`, `weight`, `stock`, `imagePath`) VALUES
(10, 'headset', 5000000, 5, 6, 'Images/headset.jpg'),
(11, 'usb', 12000, 2, 13, 'Images/microUSB858_2755791b.jpg'),
(16, 'power bank', 234, 2, 11, 'Images/power-bank.jpg'),
(18, 'ban pinggang', 9000, 2, 8, 'Images/banpinggang.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE IF NOT EXISTS `transactions` (
  `transaction_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `dateApproval` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `user_id`, `status`, `dateApproval`) VALUES
(39, 5, 'Completed', '2016-11-11 14:18:00'),
(48, 7, 'Waiting for Approval', NULL),
(49, 7, 'Waiting for Approval', NULL),
(50, 5, 'Waiting for Approval', NULL),
(51, 12, 'Completed', '2016-11-11 14:18:03'),
(52, 10, 'Waiting for Approval', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `address` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `role` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `phone`, `email`, `password`, `gender`, `dob`, `address`, `image`, `role`) VALUES
(1, 'Admin', '0009999999', 'admin@admin.com', 'admin123', 'female', '2016-10-23', 'admin address', 'Images/MarioMaurer1.jpg', 1),
(5, 'customer1', '0888888', 'customer@yahoo.com', 'abc123', 'male', '1111-11-11', 'alamat customer', 'Images/businessman_PNG6557.png', 2),
(6, 'Customer 2', '085555', 'email@jaja.com', 'abc123', 'female', '1111-11-11', 'jakarta', 'Images/busineswoman.png', 2),
(7, 'john doe', '9812010', 'johndoe@gmail.com', 'john12', 'male', '2016-11-09', 'doe street', 'Images/hobostick11.jpg', 2),
(8, 'biber', '09910202', 'biber@yahoo.com', 'biber123', 'male', '2016-11-01', 'street', 'Images/Justin-Bieber-PNG-Image.png', 2),
(9, 'mofodev', '934093', 'mofodev@mofo.com', 'abc123', 'female', '1111-11-11', 'dsfdf', 'Images/nicocage.jpg', 2),
(10, 'sadf', '0888888888', 'lol@lol.com', 'abc123', 'male', '1996-12-03', 'lolol', 'Images/Nicholas_Cage.jpg', 2),
(11, 'cersei', '09090909', 'cersei@lanister.com', 'incest12', 'female', '1887-11-01', 'kings landing', 'Images/cersei-baratheon.jpg', 2),
(12, 'aeee', '09090909', 'abc@abc.com', 'abc123', 'male', '1111-11-11', 'abcabc', 'Images/jack-gyllenhaal.jpg', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`), ADD KEY `product_id` (`product_id`), ADD KEY `user_id` (`user_id`), ADD KEY `transaction_id` (`transaction_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`), ADD KEY `product_id` (`product_id`), ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `details`
--
ALTER TABLE `details`
  ADD PRIMARY KEY (`detail_id`), ADD KEY `transaction_id` (`transaction_id`), ADD KEY `product_id` (`product_id`), ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`), ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `details`
--
ALTER TABLE `details`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=68;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `carts_ibfk_3` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `details`
--
ALTER TABLE `details`
ADD CONSTRAINT `details_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `details_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

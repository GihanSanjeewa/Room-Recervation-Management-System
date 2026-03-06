-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 06, 2026 at 10:28 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel_reservation_mvc`
--

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `reservation_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `method` enum('CARD','ADVANCE','CASH') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `reference` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `paid_at` timestamp NULL DEFAULT NULL,
  `receipt_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `reservation_id`, `amount`, `method`, `status`, `reference`, `created_at`, `paid_at`, `receipt_no`) VALUES
(1, 5, '24000.00', 'CARD', 'PENDING', 'TEMP_REF', '2026-03-06 19:53:52', NULL, NULL),
(2, 5, '24000.00', 'CARD', 'PENDING', 'TEMP_REF', '2026-03-06 20:05:08', NULL, NULL),
(3, 3, '25000.00', 'CARD', 'PAID', 'REF-3', '2026-03-06 20:05:13', '2026-03-06 20:05:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `reservation_code` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `guests` int(11) NOT NULL,
  `status` enum('PENDING','RESERVED','PAID','ADVANCE_PAID','CANCELLED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_status` enum('PENDING','PAID','ADVANCE_PAID','CANCELLED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING'
) ;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `reservation_code`, `user_id`, `room_id`, `check_in`, `check_out`, `guests`, `status`, `total_amount`, `created_at`, `payment_status`) VALUES
(2, 'RSV-59BF35A2', 6, 5, '2026-02-18', '2026-02-20', 2, 'RESERVED', '50000.00', '2026-02-18 15:06:24', 'PENDING'),
(3, 'RSV-41172EF1', 6, 5, '2026-02-20', '2026-02-21', 3, 'PAID', '25000.00', '2026-02-19 05:58:10', 'PENDING'),
(4, 'RSV-E197DAC3', 4, 2, '2026-02-24', '2026-02-25', 2, 'RESERVED', '12000.00', '2026-02-19 14:53:59', 'PENDING'),
(5, 'RSV-81FC4B78', 6, 2, '2026-03-17', '2026-03-19', 2, 'RESERVED', '24000.00', '2026-03-01 03:16:07', 'PENDING'),
(6, 'RSV-76DC4749', 5, 5, '2026-03-17', '2026-03-19', 2, 'RESERVED', '50000.00', '2026-03-06 21:22:28', 'PENDING');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int(11) NOT NULL,
  `price_per_night` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('AVAILABLE','UNAVAILABLE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AVAILABLE',
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_number`, `type`, `capacity`, `price_per_night`, `status`, `description`, `created_at`) VALUES
(2, '102', 'DOUBLE', 2, '12000.00', 'AVAILABLE', 'Double room with balcony', '2026-02-18 12:30:32'),
(3, '201', 'DELUXE', 3, '18000.00', 'UNAVAILABLE', 'Deluxe family room', '2026-02-18 12:30:32'),
(4, '505', 'Standard', 5, '15000.00', 'AVAILABLE', 'best room to stay', '2026-02-18 15:21:40'),
(5, '606', 'DELUXE', 5, '25000.00', 'AVAILABLE', 'test', '2026-02-18 15:22:17');

-- --------------------------------------------------------

--
-- Table structure for table `room_images`
--

CREATE TABLE `room_images` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_cover` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_images`
--

INSERT INTO `room_images` (`id`, `room_id`, `image_url`, `is_cover`, `sort_order`, `created_at`) VALUES
(4, 3, '/uploads/rooms/3/d0ca4b5c834946ac9ad596b752d2ce5b.png', 1, 1, '2026-02-18 12:33:40'),
(15, 5, '/uploads/rooms/5/7f94f87ecb0448f995d50b28d1dab991.jpg', 1, 1, '2026-03-06 19:10:08'),
(16, 4, '/uploads/rooms/4/364994a7b1ac4503985260efe04172f9.jpg', 1, 1, '2026-03-06 19:10:29'),
(17, 2, '/uploads/rooms/2/25f40ae477cf4273a11d4f399a4c9701.jpg', 1, 1, '2026-03-06 19:10:47');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('USER','ADMIN','STAFF') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USER',
  `status` enum('ACTIVE','BLOCKED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `address`, `password_hash`, `role`, `status`, `created_at`) VALUES
(4, 'Admin', 'admin@hotel.com', '0768537941', '', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN', 'ACTIVE', '2026-02-18 12:33:15'),
(5, 'Gihan Sanjeewa', 'gihansanjeewa2.m@gmail.com', '0768537941', '', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'STAFF', 'ACTIVE', '2026-02-18 12:36:05'),
(6, 'Madu', 'gihansanjeewa.m@gmail.com', '0768594351', '', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 'USER', 'ACTIVE', '2026-02-18 15:05:52'),
(7, 'Gihan Sanjeewa', 'gihansanjeewa12.m@gmail.com', '0768537941', 'no 30 Barandana', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', 'USER', 'ACTIVE', '2026-03-06 09:55:45'),
(8, 'Gihan Sanjeewa', 'gihansanjeewassda.m@gmail.com', '0768537941', 'no.30, Barandana', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'USER', 'ACTIVE', '2026-03-06 09:56:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_payment_reservation` (`reservation_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reservation_code` (`reservation_code`),
  ADD KEY `idx_res_user_id` (`user_id`),
  ADD KEY `idx_res_room_id` (`room_id`),
  ADD KEY `idx_res_status` (`status`),
  ADD KEY `idx_res_created_at` (`created_at`),
  ADD KEY `idx_res_check_in` (`check_in`),
  ADD KEY `idx_res_check_out` (`check_out`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `room_number` (`room_number`);

--
-- Indexes for table `room_images`
--
ALTER TABLE `room_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_room_images_room_id` (`room_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `room_images`
--
ALTER TABLE `room_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payment_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `fk_res_room` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  ADD CONSTRAINT `fk_res_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `room_images`
--
ALTER TABLE `room_images`
  ADD CONSTRAINT `fk_room_images_room` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

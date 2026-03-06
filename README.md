# Room Reservation Management System

A full-stack Java web application developed to manage room reservations, guest records, room availability, payments, and administrative operations in an efficient and organized manner. The system is designed to support both customer-facing reservation activities and internal management tasks for staff and administrators.

---

## Table of Contents

- [Introduction](#introduction)
- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Key Features](#key-features)
- [User Roles](#user-roles)
- [System Modules](#system-modules)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Database](#database)
- [Installation and Setup](#installation-and-setup)
- [How to Run the Project](#how-to-run-the-project)
- [Core Functionalities](#core-functionalities)
- [Security Features](#security-features)
- [Testing](#testing)
- [Future Improvements](#future-improvements)
- [Author](#author)
- [License](#license)

---

## Introduction

The **Room Reservation Management System** is a web-based enterprise application created to digitize and simplify the reservation process in hospitality or lodging environments. It provides an integrated platform for users to search rooms, make reservations, manage bookings, and process payments, while also enabling administrators and staff to manage rooms, customers, reports, and operational data.

This project demonstrates practical implementation of layered software architecture using Java web technologies, database integration, role-based access control, and business logic separation through controller, service, DAO, filter, model, and utility layers.

---

## Project Overview

Manual reservation handling often leads to booking conflicts, poor record management, delays, and lack of visibility over room availability. This system addresses those issues by offering a centralized digital solution that supports:

- Room searching and reservation
- Booking history management
- Payment handling and receipt generation
- Administrative room and user management
- Authentication and authorization
- Reporting and operational control

The project is suitable as an academic or professional software engineering project because it applies structured system design, backend logic, database interaction, and user access management.

---

## Objectives

The main objectives of this project are:

- To automate the room reservation process
- To reduce manual errors in booking and payment tracking
- To improve accessibility to reservation data for users and admins
- To provide secure authentication and role-based authorization
- To maintain a scalable and maintainable layered architecture
- To support efficient room, reservation, and user management

---

## Key Features

### Guest / User Features
- User registration and login
- Search available rooms
- Make room reservations
- View booking history
- Cancel reservations
- Manage personal profile
- Download receipts or invoices

### Staff Features
- View and manage reservations
- Support operational booking activities
- Access reports
- Monitor payment-related activities

### Admin Features
- Manage rooms
- Manage room images
- Manage reservations
- Manage users
- View dashboard analytics
- Access reports
- Monitor system operations

---

## User Roles

The system supports multiple user roles:

### 1. Guest
A regular user who can:
- Register and log in
- Search rooms
- Make reservations
- Cancel reservations
- View booking history

### 2. Staff
Operational user who can:
- View reservations
- Manage reservation-related processes
- Access operational reports

### 3. Admin
Administrative user who can:
- Manage rooms
- Manage room images
- View all reservations
- Manage users
- Access reports and dashboard

---

## System Modules

### Authentication Module
Responsible for login, user validation, password security, and access restriction.

**Main components:**
- `AuthController.java`
- `AuthFilter.java`
- `RoleFilter.java`
- `PasswordUtil.java`

### Room Management Module
Handles room records, room details, room status, and room image management.

**Main components:**
- `AdminRoomsController.java`
- `AdminRoomImageController.java`
- `RoomDAO.java`
- `RoomImageDAO.java`

### Reservation Module
Responsible for booking creation, viewing reservations, updating reservations, and cancellation.

**Main components:**
- `ReservationController.java`
- `StaffReservationController.java`
- `AdminReservationController.java`
- `ReservationService.java`
- `ReservationDAO.java`

### Payment Module
Manages payment processing, records, and receipt generation.

**Main components:**
- `PaymentController.java`
- `PaymentDAO.java`
- `ReceiptDAO.java`
- `ReceiptTemplateUtil.java`

### Reporting Module
Provides administrative and staff reporting functionality.

**Main components:**
- `AdminReportsController.java`
- `StaffReportsController.java`
- `ReportDAO.java`

### Utility Module
Contains reusable helper logic for database access, emails, password processing, and templates.

**Main components:**
- `DBConnection.java`
- `EmailUtil.java`
- `PasswordUtil.java`
- `ReceiptTemplateUtil.java`
- `TestDB.java`

---

## Technology Stack

### Frontend
- HTML
- CSS
- JSP
- JavaScript

### Backend
- Java
- Jakarta Servlet / JSP
- Java-based MVC-style layered architecture

### Database
- MySQL

### Tools / Platform
- Eclipse IDE
- Apache Tomcat
- MySQL Workbench or phpMyAdmin
- Git and GitHub

---

## Architecture

The system follows a layered architecture for maintainability and separation of concerns.

### Layers Used

#### 1. Presentation Layer
Handles the user interface and user interaction.
- JSP pages
- CSS
- JavaScript

#### 2. Controller Layer
Processes incoming HTTP requests and coordinates responses.
- Servlet controllers

#### 3. Service Layer
Contains business logic and validation.
- `ReservationService.java`
- `AIService.java`

#### 4. Data Access Layer
Handles communication with the database.
- DAO classes

#### 5. Model Layer
Represents business entities and domain objects.
- `User`
- `Room`
- `Reservation`
- `Payment`
- `Receipt`

#### 6. Filter Layer
Protects routes and enforces role-based access.
- `AuthFilter`
- `RoleFilter`

This structure improves code organization, testing, debugging, and future scalability.

---

## Project Structure

```text
src/main/java/com/hotel
│
├── controller
│   ├── AdminController.java
│   ├── AdminDashboardController.java
│   ├── AdminReportsController.java
│   ├── AdminReservationController.java
│   ├── AdminRoomImageController.java
│   ├── AdminRoomsController.java
│   ├── AdminUsersController.java
│   ├── AuthController.java
│   ├── HelpController.java
│   ├── HomeController.java
│   ├── PaymentController.java
│   ├── ReservationController.java
│   ├── RoomController.java
│   ├── StaffController.java
│   ├── StaffReportsController.java
│   └── StaffReservationController.java
│
├── dao
│   ├── PaymentDAO.java
│   ├── ReceiptDAO.java
│   ├── ReportDAO.java
│   ├── ReservationDAO.java
│   ├── RoomDAO.java
│   ├── RoomImageDAO.java
│   └── UserDAO.java
│
├── filter
│   ├── AuthFilter.java
│   └── RoleFilter.java
│
├── model
│   ├── AuditLog.java
│   ├── MaintenanceBlock.java
│   ├── Payment.java
│   ├── Policy.java
│   ├── Receipt.java
│   ├── Reservation.java
│   ├── Room.java
│   ├── RoomImage.java
│   └── User.java
│
├── service
│   ├── AIService.java
│   └── ReservationService.java
│
└── util
    ├── DBConnection.java
    ├── EmailUtil.java
    ├── PasswordUtil.java
    ├── ReceiptTemplateUtil.java
    └── TestDB.java

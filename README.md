# ☕ Smart Ahwa Manager (Dart Console App)

## Overview
Smart Ahwa Manager is a **Dart CLI application** that helps manage a traditional coffee shop’s orders.  
It runs entirely from the command line and demonstrates **OOP** and **SOLID principles** for clean and extensible architecture.

## ✨ Features
- Add a new order with:
  - Customer name
  - Drink type (Shai, Turkish Coffee, Hibiscus Tea, etc.)
  - Extras (e.g., extra mint, raisins)
  - Special instructions
- View pending orders
- Complete orders
- View all orders
- Generate a sales report:
  - Total number of orders
  - Top-selling drinks

## 📂 Project Structure
smart_ahwa_manager/
│
├── bin/
│ └── smart_ahwa_manager.dart # Entry point (CLI)
│
├── lib/
│ ├── domain/ # Domain models (Order, Drink, Extra)
│ ├── repo/ # Repository interfaces + implementations
│ ├── services/ # Business logic (Orders + Reporting)
│ └── utils/ # CLI helpers
│
└── test/ # Unit tests

## 🚀 Getting Started

### 1. Create Project
```bash
dart create -t console-full smart_ahwa_manager
```

### 2. Run the App
```bash
dart run
```
### 3. Example Usage
```bash
> add Ahmed "Turkish Coffee" extras=extra_mint,rais note="no sugar"
Added: #001 | Ahmed → Turkish Coffee (extras: extra mint, rais) [no sugar] EGP 22 | pending

> pending
Pending orders:
  #001 | Ahmed → Turkish Coffee (extras: extra mint, rais) [no sugar] EGP 22 | pending

> complete 001
Order 001 completed.

> report
--- Sales Report ---
Total orders: 1
Top drinks:
  Turkish Coffee: 1
```
### 4. Run Tests
```bash
dart test
```

## 🛠️ Technologies & Concepts

- Dart (console app)

- Object-Oriented Programming (OOP)

- SOLID Principles

  - SRP: each service has a single responsibility (Orders, Reporting, Repo)

  - OCP: new drinks can be added without changing existing logic

  - DIP: services depend on abstractions, not concrete classes

- InMemory Repository (can later be swapped with DB/API)


## 📌 Future Enhancements

- Add database storage (SQLite, Firebase, etc.)

- Build a Flutter UI on top of the existing logic

- Multi-language support (English/Arabic)

- Add payments & financial reporting

***

👨‍💻 Developed with ❤️ using Dart.

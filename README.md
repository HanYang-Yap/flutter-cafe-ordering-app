# 🧋 TWICE Cafe – Flutter Order App

A lightweight cross-platform mobile application built with **Flutter**. The app features a TWICE-inspired theme where each signature drink pairs modern cafe ordering mechanics with thought-provoking cultural and historical narratives on gender dynamics.

---

## ✨ Features

- **Custom TWICE Theme**: Custom color palettes (`#FFFF6B9D`), themed typography, and responsive visual layout.
- **Dynamic Menu Grid**: Displays drinks with pricing, network image integration, and quick-add capabilities.
- **Detailed Narrative View**: Expanded detail page for each item linking drink themes to historical perspectives on gender equality and modern society.
- **Cart & State Management**: Custom Singleton `CartManager` tracking item count, aggregate pricing, and list state across views.
- **Seamless Navigation**: Named and dynamic route transitions between menu, detail, and cart screens.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **UI Components**: Material Design, `GridView`, `SliverGridDelegate`, `Custom Gradient Headers`
- **State Management**: Singleton Pattern (`CartManager`)

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.0.0 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code with Flutter extension
- An emulator or physical test device

### Installation & Setup
 
1. **Clone the repository:**
   ```bash
   git clone [https://github.com/YOUR_USERNAME/twice-cafe-flutter.git](https://github.com/YOUR_USERNAME/twice-cafe-flutter.git)
   cd twice-cafe-flutter
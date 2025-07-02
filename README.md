# 📱 Bingo – HandCrafts Marketplace (Flutter App)
Slogan: Handmade, Heartmade
Mission: Empowering artisans. Celebrating craftsmanship. Connecting cultures.
# 📦 Overview
Bingo is Egypt’s first digital village artisan marketplace. This Flutter app connects talented artisans with passionate buyers looking for unique, handcrafted treasures. From jewelry and home décor to personalized gifts and artisanal fashion, Bingo empowers creators and delights shoppers through a curated, community-driven mobile experience.
# 🧭 Table of Contents
- Features

   - Screenshots

   - Getting Started

   - Architecture

   - Tech Stack

   - Backend Integration

   - Roadmap

   - Contributing

   - License
# 🚀 Features 
  👩‍🎨 For Shoppers
     - Secure login via email/phone/social

     - Browse by category with smart filters

     - Wishlist, cart, and real-time order tracking

     - Multiple payment options: card, Fawry, Vodafone Cash

     - Product reviews and AI-powered recommendations

     - Bingo Coins loyalty system

     - Personalized notifications and seasonal deals
  
🛍️ For Sellers (Artisans)
      - Easy onboarding and shop setup

     - Product management (inventory, pricing, images)

     - Manage orders and respond to custom requests

     - Dashboard with sales analytics and affiliate options

     - In-app messaging with buyers

     - AI-powered product trend insights
   
  - 🛠️ Admin Support (via backend)
    - Seller/shop verification tools

    - Dispute resolution management

    - Analytics dashboards for traffic, sales, engagement

# 🛠️ Getting Started
  Prerequisites
    - Flutter (version >= 3.0.0)

    - Android Studio or Xcode (for running on emulator/device)

    - Firebase (for auth & notifications)

    - API endpoint access from the .NET backend

``` bash
git clone https://github.com/your-org/bingo-flutter.git
cd bingo-flutter
flutter pub get
flutter run
```
# 📐 Architecture
 MVVM Pattern for separation of concerns

  - Provider / Bloc cubit for state management

  - Dio / Retrofit for HTTP requests

  - Hive / SharedPreferences for local storage

# 🧱 Tech Stack
  ```bash
| Layer    | Technology                  |
| -------- | --------------------------- |
| Frontend | Flutter                     |
| Backend  | .NET Core API               |
| Auth     | Firebase + JWT OAuth2.0     |
| Database | SQL Server / PostgreSQL     |
| Payments | Fawry, Vodafone Cash, Cards |
| DevOps   | GitHub Actions / Azure      |
```
# 🔌 Backend Integration
  The Flutter app communicates with a RESTful Node js backend with endpoints for:

    - User registration/login

    - Product listings

    - Order placement and tracking

    - Payment processing

    - Custom order handling

    - Affiliate & reward system

# 📅 Roadmap
  Core shopper & seller flows

    - Multi-language support (Arabic, English)

    - Offline mode for viewing wishlist

     - In-app push notifications (Firebase)

    -  Mobile-only seasonal events UI

    - Real-time chat with buyers

# 🤝 Contributing
 We welcome contributions from the community!

    - Fork the repository

    - Create your feature branch (git checkout -b feature/YourFeature)

    - Commit your changes (git commit -m 'Add feature')

    - Push to the branch (git push origin feature/YourFeature)

    - Create a Pull Request

# 📄 License
Distributed under the MIT License. See LICENSE for more information.

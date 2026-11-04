# 🚗 AutoTire
### Tire shop inventory, sales, and finance management

AutoTire is a responsive Flutter application that helps tire shop owners manage inventory, record sales, track customer debts, and review business performance from one place.

## ✨ Features

- **Dashboard** — View today’s sales, profit, warehouse value, and outstanding debt.
- **Inventory management** — Add, edit, search, and remove products.
- **Product categories** — Manage passenger-car tires, truck tires, rims, and batteries.
- **Sales tracking** — Record sales, payment methods, quantities, and prices.
- **Automatic calculations** — Update stock and calculate sale totals and profit.
- **Debt management** — Add customer debts and record partial or full repayments.
- **Profit overview** — Compare profit by category and find top-performing products.
- **Responsive interface** — Designed for mobile, tablet, and desktop screens.
- **Profile settings** — Edit profile details, including a phone number with the `+998` code.

## 🛠️ Tech Stack

| Technology | Purpose |
| --- | --- |
| Flutter | Cross-platform UI framework |
| Dart | Programming language |
| `ChangeNotifier` / `InheritedNotifier` | Shared application state |
| `shared_preferences` | Local data persistence |
| `flutter_secure_storage` | Secure local password storage |
| `google_fonts` | Typography |
| `font_awesome_flutter` | Icons |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK and Dart
- Chrome, or an Android device/emulator
- Android Studio or Visual Studio Code (recommended)

### Installation

```bash
git clone https://github.com/jaloliddinegamberdiyevvv/auto-tire.git
cd auto-tire
flutter pub get
flutter run -d chrome
```

To run on another device:

```bash
flutter devices
flutter run -d <device-id>
```

Run tests with:

```bash
flutter test
```

## 💾 Data Storage

Business records and profile details are currently stored locally on the device. Data is not synchronized between devices or backed up to a cloud account. Keep a separate backup of important business information.

## 📂 Project Structure

```text
lib/
├── main.dart
├── main_screen.dart
├── login_screen.dart
├── user_profile.dart
├── store/
│   └── magazin_store.dart
├── pages/
│   ├── bosh_sahifa.dart
│   ├── mahsulot_sahifa.dart
│   ├── sotuvlar.dart
│   ├── qarzlar.dart
│   └── foyda_hisobi.dart
└── widgets/

assets/
```

## 👨‍💻 Developer

**Jaloliddin Egamberdiyev**

- GitHub: [@jaloliddinegamberdiyevvv](https://github.com/jaloliddinegamberdiyevvv)
- Repository: [auto-tire](https://github.com/jaloliddinegamberdiyevvv/auto-tire)

---

<p align="center">Built with Flutter for tire shop teams.</p>

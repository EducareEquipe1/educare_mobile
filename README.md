# 📱 EduCare Mobile App

EduCare Mobile is the official mobile companion to the EduCare platform — a medical record management system designed for educational institutions. Developed using **Flutter**, this app allows patients (students, professors, staff) to register, manage their medical profiles, request appointments, and receive updates from school healthcare professionals.

---

## 🚀 Features

- **Patient Registration & Login**
  - Email verification
  - Secure login and password reset

- **Appointment Management**
  - Request appointments with a reason only
  - Receive notifications for acceptance, scheduling, or refusal
  - View upcoming appointments in both list and calendar format
  - Cancel requests or confirmed appointments

- **Medical Records Access**
  - View your medical file (Dossier Médical)
  - Access consultations, prescriptions, and medical exams

- **Notifications**
  - Real-time alerts for all medical-related updates

- **Settings**
  - Update profile and logout securely

---

## 🧱 Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Node.js + Express (EduCare API)
- **Database**: MySQL
- **File Storage**: Cloudinary (for profile pictures)
- **Authentication**: JWT, email verification

---

## 📁 Project Structure

```
lib/
├── main.dart
├── screens/
│   ├── auth/
│   ├── home/
│   ├── appointments/
│   ├── medical_record/
│   └── settings/
├── models/
├── services/
├── widgets/
└── utils/
```

---

## 📲 Getting Started

### Prerequisites

- Flutter SDK installed ([Installation Guide](https://flutter.dev/docs/get-started/install))
- Android Studio or VS Code with Flutter and Dart plugins
- Dart >= 3.0

### Installation

```bash
git clone https://github.com/EducareEquipe1/educare-mobile.git
cd educare-mobile
flutter pub get
```

### Running the App

```bash
flutter run
```

> ⚠️ Make sure a device/emulator is connected before running.

---

## 🔐 Environment Configuration

Create or modify your `lib/services/config.dart` with the base URL of your EduCare backend:

```dart
const String apiUrl = "https://educare-backend-l6ue.onrender.com/";
```

Or use environment configuration packages for more advanced setups.

---

## 🧪 Testing

To run tests:

```bash
flutter test
```

---

## 👨‍💻 Contributing

1. Fork the repo
2. Create your branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Create a Pull Request

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 👩‍💻 Project Team – EduCare

- Zerguerras Khayra Sarra (Team Lead)
- Slimani Rania
- Merzouk Nabahat Imane
- Mohamed Ousaid Ahlem
- Aini Ines
- Brahmi Sarah Kaouther

---

## 🌐 Related Repositories

- [EduCare Web](https://github.com/EducareEquipe1/educare_frontend)
- [EduCare Backend](https://github.com/EducareEquipe1/educare_backend)

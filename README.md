# My Notes App

A premium, minimalist notes application built with Flutter and Firebase. My Notes offers a seamless and elegant experience for capturing your thoughts, organized with a modern aesthetic and real-time synchronization.

---

## Features

- **Secure Authentication**: Robust login and signup system powered by Firebase Auth.
- **Real-time Notes**: Create, view, and manage your notes with instant synchronization via Cloud Firestore.
- **Dynamic UI**: A reactive interface that updates instantly as you type and save.
- **Premium Design**: A clean, indigo-themed interface featuring:
  - Responsive layouts.
  - Modern typography (Google Fonts Inter).
  - Subtle micro-animations and polished button states.
- **Splash Experience**: A professional entry point branding the application.

---

## ScreenShots


<img width="200" alt="Splash Screen" src="https://github.com/user-attachments/assets/2c499d5d-cf79-4a9a-a536-8faad3173d85" />
<img width="200" alt="Login Screen" src="https://github.com/user-attachments/assets/7f087d6a-71fc-4f9b-bb53-4712165c4a9c" />
<img width="200" alt="Signup Screen" src="https://github.com/user-attachments/assets/27e4a64e-c6f6-45fd-adbc-722636081c40" />
<img width="200" alt="Notes List Screen" src="https://github.com/user-attachments/assets/084b9060-7b9a-467b-a22f-30fba09b6b38" />
<img width="200" alt="Add Note Screen" src="https://github.com/user-attachments/assets/b7be6585-b23c-4520-b07a-eaf75e8dca53" />


---

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Backend/Database**: [Firebase (Auth & Firestore)](https://firebase.google.com/)
- **Typography**: [Google Fonts](https://pub.dev/packages/google_fonts)

---

## Project Structure

The project follows a **Feature-First Architecture** for scalability and maintainability:

```text
lib/
├── core/                 # Shared logic, themes, widgets, and routing
│   ├── routes/           # App navigation configuration
│   ├── theme/            # Global colors
│   └── widgets/          # Reusable custom UI components
├── features/             # Independent feature modules
│   ├── auth/             # Login and Signup logic & UI
│   ├── notes/            # Note listing, adding, and data models
│   └── splash/           # Initial branding screen
└── firebase_options.dart # Firebase configuration
```

---

## App Download Link

[Download](https://drive.google.com/drive/folders/1geatwUmy_Q-pVJN2yT6YrdHnC_QlA382?usp=sharing)

---

## Setup & Installation

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.10.4 or higher)
- [Firebase account](https://console.firebase.google.com/)

### Installation Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/mhferdous/ct_notes_app.git
   ```

2. **Navigate to the project directory**:
   ```bash
   cd ct_notes_app
   ```

3. **Install dependencies**:
   ```bash
   flutter pub get
   ```

4. **Configure Firebase**:
   - Create a new Firebase project.
   - Run `flutterfire configure` to set up your configurations.
   - Ensure you have the `firebase_options.dart` generated.

5. **Run the application**:
   ```bash
   flutter run
   ```

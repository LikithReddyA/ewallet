# 💸 eWallet – Flutter Application

**eWallet** is a modern Flutter-based personal finance application that allows users to manage their **income**, **expenses**, and track their overall **wallet balance** efficiently. The app uses **Firebase** as the backend and supports both **Email/Password** and **Google Sign-In** for user authentication.

---

## 📱 Features

* 🔐 Firebase Authentication (Email/Password & Google Sign-In)
* 💰 Add, edit, and delete income and expense transactions
* 📊 Real-time balance updates and transaction history
* 🧭 Clean navigation using `go_router`
* 🔄 State management via `flutter_bloc`
* 🔌 Scalable architecture using the Repository pattern
* ☁️ Firebase Firestore as the backend database
* 🌙 Dark and Light theme support (optional)
* 📦 Responsive UI across different screen sizes (optional)

---

## 🔧 Tech Stack

| Layer                | Technology                 |
| -------------------- | -------------------------- |
| **Frontend**         | Flutter                    |
| **Backend**          | Firebase (Firestore, Auth) |
| **Routing**          | `go_router`                |
| **State Management** | `flutter_bloc`             |
| **Architecture**     | Repository Pattern         |

---

## 🔒 Why Are Firebase Config Files Ignored in Git?

The following files are **intentionally excluded** from version control via `.gitignore`:

```gitignore
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

### ✅ Reasons:

1. **Security**
   These files contain sensitive information like API keys, project IDs, and OAuth credentials that should not be exposed publicly.

2. **Environment Specificity**
   Different environments (development, staging, production) require different Firebase configurations.

3. **Team Collaboration**
   Prevents one developer’s environment config from overwriting another’s when switching branches or working on the same project.

4. **Best Practice**
   Firebase documentation recommends **not committing these files** to source control.

---

## 🧭 Firebase Setup Instructions

To run this project, you must **manually download** and add Firebase configuration files for both **Android** and **iOS**.

### 🛠️ Prerequisites

* A Firebase project created in the [Firebase Console](https://console.firebase.google.com/)
* Firebase apps registered for **both Android and iOS**

---

## 🤖 Android Firebase Setup

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Open your project and click the ⚙️ **Project Settings**
3. Under **Your apps**, select your **Android app** (or register one)

   * Ensure the **Package Name** matches your app (e.g., `com.example.ewallet`)
4. Download the `google-services.json` file
5. Place it in the following directory:

   ```
   android/app/google-services.json
   ```

### ⚠️ Important Notes:

* Do **not** rename or relocate the file.
* It must remain in the specified path for Firebase to function correctly.

---

## 🍏 iOS Firebase Setup

1. Open the [Firebase Console](https://console.firebase.google.com/)
2. Within the same project, select your **iOS app** (or register one)

   * Make sure the **Bundle ID** matches your Flutter iOS app (e.g., `com.example.ewallet`)
3. Download the `GoogleService-Info.plist` file
4. Place it in the following path:

   ```
   ios/Runner/GoogleService-Info.plist
   ```

### ⚠️ Important Notes:

* Open the iOS module in Xcode: `ios/Runner.xcworkspace`
* Right-click the `Runner` project in Xcode → **Add Files to "Runner"** → select `GoogleService-Info.plist`
* Ensure the file is added to **all build targets**

---

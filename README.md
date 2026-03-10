# Flutter Todo App (GetX + Firebase)

A modern **Todo Task Management Application** built with **Flutter**, using **GetX** for state management and **Firebase** for authentication and realtime data storage.

This project demonstrates a **clean architecture Flutter application** with authentication, task CRUD operations, and responsive UI.

---

## 🚀 Features

* 🔐 Firebase Email & Password Authentication
* 🟢 Google Sign-In Authentication
* 📋 Create, Edit, Delete Tasks
* ✅ Mark Tasks as Completed
* ☁️ Firebase Realtime Database Integration
* ⚡ GetX State Management
* 🎨 Clean and Responsive UI
* 🔓 Logout Confirmation Dialog

---

## 🛠 Tech Stack

* **Flutter**
* **GetX**
* **Firebase Authentication**
* **Firebase Realtime Database**
* **HTTP Package**

---

## 📂 Project Structure

```
lib
 ┣ modules
 ┃ ┣ auth
 ┃ ┃ ┣ controller
 ┃ ┃ ┣ view
 ┃ ┣ tasks
 ┃ ┃ ┣ controller
 ┃ ┃ ┣ view
 ┣ models
 ┣ services
 ┣ routes
 ┣ widgets
 ┗ main.dart
```

---

## ⚙️ Installation

### 1️⃣ Clone the repository

```
git clone https://github.com/yourusername/flutter-todo-getx-firebase.git
```

### 2️⃣ Navigate to project

```
cd flutter-todo-getx-firebase
```

### 3️⃣ Install dependencies

```
flutter pub get
```

### 4️⃣ Add Firebase configuration

Add your Firebase config files:

Android:

```
android/app/google-services.json
```

iOS:

```
ios/Runner/GoogleService-Info.plist
```

### 5️⃣ Run the app

```
flutter run
```

---

## 📸 Screenshots

(Add screenshots here)

Example:

* Login Screen
* Task List Screen
* Add Task Bottom Sheet
* Logout Dialog

---

## 🔐 Authentication

This project supports:

* Email & Password Login
* Google Sign-In

Firebase automatically maintains user session for **auto login**.

---

## 📡 Database

Tasks are stored using **Firebase Realtime Database**.

Example structure:

```
tasks
 ┣ userId
 ┃ ┣ taskId
 ┃ ┃ ┣ title
 ┃ ┃ ┣ hours
 ┃ ┃ ┗ completed
```

---

## 👨‍💻 Author

**Deepak Karnan**


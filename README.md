# Task Manager App

Task Manager App built with **Flutter** that allows users to manage their tasks efficiently. This project utilizes modern tools and practices to provide a scalable and maintainable architecture.

---

## 🚀 Features

- **Task Management:** Create, update, delete, and list tasks.
- **Authentication:** Secure token storage and management.
- **Routing:** Navigate seamlessly with `go_router`.
- **State Management:** Manage state using `flutter_bloc`.
- **Network Requests:** API integration with `retrofit` and `dio`.
- **Secure Storage:** Store sensitive data like tokens securely using `flutter_secure_storage`.
- **Custom Page Transitions:** Smooth, animated page transitions for a polished user experience.
- **Error Handling:** zoneGuarded Ready for any Crash Analytics.
 

---

## 🛠️ Technologies Used

- **Flutter Bloc:** For state management, ensuring a reactive and scalable approach.
- **Go Router:** Simplifies and streamlines routing in the app.
- **Dio & Retrofit:** To handle network requests efficiently with structured API calls.
- **Flutter Secure Storage:** For storing the authentication token securely.
- **Package-Based Architecture:** For modular and maintainable code structure.
- **Very Good Analysis:** Enforces a strict linting and code quality check.

---

## 🔗 API Used

The app communicates with [Dummy JSON API](https://dummyjson.com/) for handling tasks.
> **Note:** The `todo` ID must be sent as a **String** during requests but is returned as an **Integer**, requiring special handling in the code. This was a notable challenge during development.

---
## 💡 Challenges Faced

- **Inconsistent Data Types in Dummy JSON API:**  
  The API requires `todo` IDs as Strings during requests but returns them as Integers. To address this:
    - Handled type conversions explicitly in the repository layer.
    - Added utility methods to validate and process data.

- **Linting with Very Good Analysis:**  
  The strict linting rules enforced by `very_good_analysis` required adhering to best practices, ensuring high-quality code but adding extra development effort.

---

---
## 📦 Dependencies

Here are the key dependencies used in the project:

```yaml
dependencies:
  flutter_bloc: ^8.1.0
  go_router: ^5.2.1
  dio: ^5.1.1
  retrofit: ^4.0.1
  flutter_secure_storage: ^8.0.0

dev_dependencies:
  very_good_analysis: ^4.0.0
```
---
 ## 🛠️ Setup Instructions

Clone the repository:
```bash
git clone https://github.com/Ahmadajami/task-manger.git
cd task_manager_app
```
Install dependencies:
```bash
flutter pub get
```
Run the app:
```bash
flutter run

```

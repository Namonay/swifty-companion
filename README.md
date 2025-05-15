# 42 API Client Flutter App

A clean and responsive Flutter app to look up 42 school students by their login, fetch their profile data via the 42 API, and display detailed info such as skills and projects.

---

## Features

- Home screen with a beautiful background image and a user input field.
- Fetch profile data by login with token-based API calls.
- Display profile details including avatar, level, correction points, and location.
- Tab view for Skills and Projects, each presented in a neat, scrollable list.
- User-friendly error handling with a friendly message and return button.

---

## Screenshots

### Home Screen

![Home Screen](./assets/screenshots/home_screen.png)

### Profile Screen (Skills Tab)

![Profile Skills](./assets/screenshots/profile_skills.png)

---

## Getting Started

### Prerequisites

- Flutter SDK installed ([Installation Guide](https://flutter.dev/docs/get-started/install))
- A valid 42 API token

### Installation

1. Clone the repository:

```bash
git clone <your-repo-url>
cd your-project-folder
```

2. Install dependencies:
```bash
flutter pub get
```

3. Add your 42 API Credentials in a .env file at the root of the project as:
```bash
CLIENT-ID="YOUR CLIENT ID"
CLIENT-SECRET="YOUR CLIENT SECRET"
```
4. Run the app:
```bash
flutter run
```

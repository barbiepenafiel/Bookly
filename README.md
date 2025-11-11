# Bookly (Bookstore App)

A Flutter bookstore application with a Node.js + Express backend (Prisma + Stripe integration).

This README explains how to install, run, and test the mobile app and backend locally, and how to push this project to GitHub.

## Repository layout

- `lib/` - Flutter app source
- `backend/` - Node.js Express backend (Prisma, Stripe)
- `assets/` - app assets
- `test/` - Flutter tests

---

## Prerequisites

- Flutter SDK (>= stable)
- Dart SDK (bundled with Flutter)
- Node.js (>= 18) and npm
- Android Studio / Xcode or a device/emulator to run the Flutter app
- Git (for pushing to GitHub)


## Local setup: Backend

1. Open a terminal (PowerShell on Windows) and change into the backend folder:

```powershell
cd C:\FlutterProjects\bookstore-app\backend
```

2. Install npm dependencies:

```powershell
npm install
```

3. Generate Prisma client (required once, or after schema changes):

```powershell
npm run prisma:generate
```

4. (Optional) Run database migrations / seed data (if needed):

```powershell
npm run prisma:migrate
npm run prisma:seed
```

5. Start the backend server:

```powershell
npm start
# or for development with automatic reload (if nodemon is installed):
npm run dev
```

The server listens on port 3000 by default. You should see a log like:

```
🚀 Bookstore API Server is running!
📍 Port: 3000
🌐 URL: http://localhost:3000
```

### Test backend endpoints quickly

From PowerShell on the same machine:

```powershell
Invoke-RestMethod -Method Get -Uri http://localhost:3000/

$body = @{ amount = 1.23; currency = 'usd'; items = @() } | ConvertTo-Json
Invoke-RestMethod -Method Post -Uri http://localhost:3000/payment/create-payment-intent -Body $body -ContentType 'application/json'
```

If these return JSON responses, the backend is reachable.

---

## Local setup: Flutter app

1. Ensure Flutter is installed and `flutter doctor` is clean.

2. From the workspace root, get packages:

```powershell
cd C:\FlutterProjects\bookstore-app
flutter pub get
```

3. Platform-specific networking notes

- Android emulator: the backend running on your machine is reachable at `http://10.0.2.2:3000` (this project config uses that for Android emulators).
- iOS simulator / desktop: use `http://localhost:3000`.
- Physical device: use your machine's LAN IP (for example, `http://192.168.1.100:3000`) and ensure Windows firewall allows inbound traffic on port 3000; or use `adb reverse tcp:3000 tcp:3000` for Android devices connected via USB.

4. Run the app on an emulator or device:

```powershell
# list devices
flutter devices
# run on the default device
flutter run
```

5. In the app, go to the Cart and tap "Proceed to Checkout". If the backend is running and reachable the app will create a payment intent and present the Stripe payment sheet (or a simulated flow in development). Watch both Flutter logs and the backend console for request logs.

---

## Pushing this repo to GitHub

I cannot push to your GitHub on your behalf. Follow these steps locally to push to `https://github.com/barbiepenafiel/Bookly.git`:

1. In your project root (C:\FlutterProjects\bookstore-app):

```powershell
cd C:\FlutterProjects\bookstore-app
# initialize git if you haven't already
git init
# add files
git add .
# commit
git commit -m "Initial commit - Bookly app"
# add remote (replace if it already exists)
git remote add origin https://github.com/barbiepenafiel/Bookly.git
# push to GitHub (main branch)
git branch -M main
git push -u origin main
```

If `git push` fails due to authentication, configure your GitHub credentials (recommended: use a personal access token or SSH key). See GitHub docs for "caching your GitHub credentials in Git".

---

## Troubleshooting

- If the Flutter app times out when creating a payment intent, ensure the backend is running and reachable from the device/emulator (see Platform-specific networking notes above).
- If you see a `MODULE_NOT_FOUND: dotenv` error when starting the backend, run `npm install` inside `backend/`.
- If Prisma complains, run `npm run prisma:generate` in the `backend/` directory.

---

## Further improvements (suggestions)

- Add a configuration file for the app to set backend base URL per environment without editing source.
- Add integration tests that mock the backend to verify the client flow.
- Add CI that runs `flutter analyze` and backend lint checks on Pull Requests.

---

If you want, I can:
- Create an initial Git commit and push it if you provide a GitHubPersonalAccessToken with appropriate scopes (not recommended to paste tokens here). 
- Or guide you step-by-step over a terminal session to push and resolve auth issues.

Tell me which you prefer and I'll help next.

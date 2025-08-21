# My First Android App for Galaxy S25

A simple Android application optimized for Samsung Galaxy S25, featuring Material Design and 120Hz display support.

## Features
- ✨ Material Design UI
- 🚀 Optimized for Snapdragon 8 Elite
- 📱 120Hz display support
- 🎯 Minimum SDK 26, Target SDK 35

## Project Structure
```
MyFirstAndroidApp/
├── app/
│   ├── src/main/
│   │   ├── java/         # Java source code
│   │   ├── res/          # Resources (layouts, values, etc.)
│   │   └── AndroidManifest.xml
│   └── build.gradle
├── build.gradle
├── settings.gradle
└── gradle.properties
```

## Building the App

### Option 1: Android Studio
1. Clone this repository
2. Open in Android Studio
3. Build → Generate Signed APK

### Option 2: Command Line
```bash
./gradlew assembleDebug
```

### Option 3: GitHub Actions
Push to main branch to trigger automatic build.

## Installation
1. Enable Developer Options on Galaxy S25
2. Enable USB Debugging
3. Install via ADB:
```bash
adb install app/build/outputs/apk/debug/app-debug.apk
```

## Development Setup
- Java 17+
- Android SDK 35
- Gradle 8.0+

## Device Optimization
This app is optimized for:
- Samsung Galaxy S25
- 120Hz refresh rate
- Edge display support
- One UI 7.0

## License
MIT

## Author
Created with Claude Code on Termux
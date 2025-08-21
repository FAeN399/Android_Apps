#!/bin/bash

echo "Building Android App with Gradle..."
cd /storage/emulated/0/projects/app-create/MyFirstAndroidApp

# Initialize Gradle wrapper if not present
if [ ! -f "gradlew" ]; then
    echo "Initializing Gradle wrapper..."
    gradle wrapper --gradle-version=8.0
fi

# Build the app
echo "Building debug APK..."
if [ -f "gradlew" ]; then
    ./gradlew assembleDebug
else
    gradle assembleDebug
fi

# Check if build was successful
if [ -f "app/build/outputs/apk/debug/app-debug.apk" ]; then
    echo ""
    echo "Build successful! APK created at:"
    echo "app/build/outputs/apk/debug/app-debug.apk"
    echo ""
    echo "To install on your Galaxy S25:"
    echo "1. Enable USB debugging in Developer Options"
    echo "2. Connect via USB and run:"
    echo "   adb install app/build/outputs/apk/debug/app-debug.apk"
else
    echo "Build failed. Check the error messages above."
fi
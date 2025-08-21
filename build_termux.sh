#!/bin/bash

echo "Building Android App with Termux tools..."

PROJECT_DIR="/storage/emulated/0/projects/app-create/MyFirstAndroidApp"
APP_NAME="MyFirstAndroidApp"
PACKAGE="com.example.myapp"
BUILD_DIR="$PROJECT_DIR/build"
OUTPUT_DIR="$PROJECT_DIR/output"

# Clean previous builds
rm -rf "$BUILD_DIR" "$OUTPUT_DIR"
mkdir -p "$BUILD_DIR/res" "$BUILD_DIR/gen" "$BUILD_DIR/obj" "$BUILD_DIR/dex" "$OUTPUT_DIR"

echo "Step 1: Generating R.java..."
aapt package -f -m \
    -J "$BUILD_DIR/gen" \
    -M "$PROJECT_DIR/app/src/main/AndroidManifest.xml" \
    -S "$PROJECT_DIR/app/src/main/res" \
    -I /data/data/com.termux/files/usr/share/android-sdk/android.jar \
    --min-sdk-version 26 \
    --target-sdk-version 35

echo "Step 2: Compiling Java sources..."
ecj -d "$BUILD_DIR/obj" \
    -cp /data/data/com.termux/files/usr/share/android-sdk/android.jar \
    -sourcepath "$PROJECT_DIR/app/src/main/java:$BUILD_DIR/gen" \
    "$PROJECT_DIR/app/src/main/java/com/example/myapp/MainActivity.java" \
    "$BUILD_DIR/gen/com/example/myapp/R.java"

echo "Step 3: Converting to DEX..."
dx --dex --output="$BUILD_DIR/dex/classes.dex" "$BUILD_DIR/obj"

echo "Step 4: Creating APK..."
aapt package -f \
    -M "$PROJECT_DIR/app/src/main/AndroidManifest.xml" \
    -S "$PROJECT_DIR/app/src/main/res" \
    -I /data/data/com.termux/files/usr/share/android-sdk/android.jar \
    -F "$OUTPUT_DIR/$APP_NAME-unsigned.apk" \
    --min-sdk-version 26 \
    --target-sdk-version 35

echo "Step 5: Adding DEX to APK..."
cd "$BUILD_DIR/dex"
aapt add "$OUTPUT_DIR/$APP_NAME-unsigned.apk" classes.dex

echo "Step 6: Creating debug keystore if needed..."
if [ ! -f "$PROJECT_DIR/debug.keystore" ]; then
    keytool -genkey -v \
        -keystore "$PROJECT_DIR/debug.keystore" \
        -storepass android \
        -alias androiddebugkey \
        -keypass android \
        -keyalg RSA \
        -keysize 2048 \
        -validity 10000 \
        -dname "CN=Android Debug,O=Android,C=US"
fi

echo "Step 7: Signing APK..."
apksigner sign \
    --ks "$PROJECT_DIR/debug.keystore" \
    --ks-pass pass:android \
    --ks-key-alias androiddebugkey \
    --key-pass pass:android \
    --out "$OUTPUT_DIR/$APP_NAME-debug.apk" \
    "$OUTPUT_DIR/$APP_NAME-unsigned.apk"

echo "Step 8: Verifying APK..."
apksigner verify --verbose "$OUTPUT_DIR/$APP_NAME-debug.apk"

echo ""
echo "Build complete! APK created at:"
echo "$OUTPUT_DIR/$APP_NAME-debug.apk"
echo ""
echo "To install on your Galaxy S25:"
echo "1. Enable USB debugging in Developer Options"
echo "2. Connect via USB and run:"
echo "   adb install $OUTPUT_DIR/$APP_NAME-debug.apk"
echo ""
echo "Or transfer the APK to your phone and install manually."
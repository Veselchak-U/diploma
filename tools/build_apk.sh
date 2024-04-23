flutter build apk --dart-define-from-file=tools/build_config.json

BUILD_VER=$(grep ^"version: " pubspec.yaml | cut -b 10-)
mkdir -p build_artifacts
cp build/app/outputs/flutter-apk/app-release.apk build_artifacts/get-pet-$BUILD_VER.apk

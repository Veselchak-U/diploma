flutter build windows --dart-define-from-file=tools/build_config.json

@REM BUILD_VER=$(grep ^"version: " pubspec.yaml | cut -b 10-)
@REM mkdir -p build_artifacts
copy /b /y build\windows\x64\runner\Release\get-pet.exe build_artifacts\get-pet-$BUILD_VER.exe

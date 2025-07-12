# Injectable generation
    flutter packages pub run build_runner watch --delete-conflicting-outputs

# retrofit annoation generation 
    # dart
    dart pub run build_runner build

    # flutter	
    flutter pub run build_runner build

# define enviorment variable
    flutter run --dart-define server_url=https://mywonderfulserver.development.com
    or
    flutter run --dart-define-from-file=api-keys.json


# Clear the Pub Cache
    flutter pub cache clean

# Clean build
    flutter clean

# Rebuild
    flutter pub get
    flutter run 

# Rebuild Macos/IOs 
    go into ios folder
    delete the Podfile.lock file
    rm -rf Pods
    pod cache clean --all
    pod deintegrate
    pod setup
    pod install

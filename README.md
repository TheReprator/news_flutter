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

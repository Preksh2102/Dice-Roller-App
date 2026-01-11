🎲 Dice Roller App (Flutter)

A cross-platform dice rolling app built using Flutter, designed to replace physical dice for quiet gameplay — especially useful for games like King of Tokyo.
The app currently supports Android, with iOS planned.

✨ Features
🎯 Regular Dice Mode

Roll one or multiple standard 6-sided dice

Add dice dynamically

Reset all dice

Visual dice images instead of numbers

Silent and fast — ideal for late-night play

👑 King of Tokyo Mode

Uses 6 custom King of Tokyo dice

Dice roll system with 3 rolls per turn

Ability to:

Reroll active dice

Store selected dice

Unstore dice

Clear separation between:

Active dice

Stored dice

“End Turn” button resets the round

Fully visual dice (no sound)

🧱 Tech Stack

Flutter

Dart

Material UI

Asset-based dice images

Single codebase (Android now, iOS planned)

📱 Platform Support
Platform	Status
Android	✅ Supported
iPhone	🚧 Planned
iPad	🚧 Planned
Web	❌ Not included
📦 Installation
Android (APK)

Build the APK:

flutter build apk --release


Install on any Android device

No expiry or account required

🧩 Assets Setup

Dice images must be placed in:

assets/
 └── dice/
     ├── dice_1.png
     ├── dice_2.png
     ├── dice_3.png
     ├── dice_4.png
     ├── dice_5.png
     ├── dice_6.png
     ├── king_of_tokyo_1.png
     ├── king_of_tokyo_2.png
     ├── king_of_tokyo_3.png
     ├── king_of_tokyo_4.png
     ├── king_of_tokyo_5.png
     └── king_of_tokyo_6.png


And declared in pubspec.yaml:

flutter:
  uses-material-design: true
  assets:
    - assets/dice/


Then run:

flutter pub get

▶️ Running the App
flutter run

🎮 Why This App Exists

Physical dice are noisy

Late-night gameplay can disturb others

Phones are always available

Visual dice feel authentic

Reduces accidental rolls and table clutter

🚧 Planned Improvements

iOS (iPhone & iPad) support

Dice roll animations

Optional sound toggle

Haptic feedback

Improved UI polish

📄 License

This project is for personal and educational use.
Not affiliated with or endorsed by King of Tokyo or its publishers
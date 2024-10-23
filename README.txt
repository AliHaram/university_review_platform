# University Review Platform

This project is a University Review Platform built using Flutter and Firebase. The application allows users to post and browse anonymous reviews about universities and professors in Jordan.

## Features

- **University and Professor Reviews**: Users can leave and browse reviews for specific universities and professors.
- **Anonymity Assurance**: Reviews are anonymous to ensure honest feedback.
- **Ratings**: Includes a star rating system for universities and professors.
- **Filter and Search**: Filter professor reviews based on course code, review date, and professor name.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Flutter**: Ensure you have Flutter installed on your machine.
  - Version: `3.19.5`
- **Dart**: Ensure you have Dart installed.
  - Version: `3.3.3`
- **Firebase**: You need a Firebase project with Firestore and Authentication enabled.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Installation

1. **Clone the repo**

   ```sh
   git clone https://github.com/your-username/university_review_platform.git

2. Navigate to the project directory

cd university_review_platform

3. Install dependencies

flutter pub get


4. Set up Firebase

Add your google-services.json for Android in android/app/ directory. 

Add your GoogleService-Info.plist for iOS in ios/Runner/ directory.

Ensure the Firebase configuration file is added in your lib/firebase_options.dart file.
Run the app

lib
├── models
│   └── review.dart
├── screens
│   ├── auth.dart
│   ├── home.dart
│   ├── login_screen.dart
│   ├── professor_verification.dart
│   ├── review_form.dart
│   ├── search.dart
│   ├── signup_screen.dart
│   ├── browse_prof_reviews.dart
│   ├── browse_uni_reviews.dart
├── widgets
│   ├── custom_appbar.dart
│   ├── custom_shape_clipper.dart
│   ├── login_form.dart
│   ├── login_screen_top_image.dart
│   ├── login_signup_btn.dart
│   ├── review_form.dart
│   ├── signup_form.dart
│   ├── signup_screen_top_image.dart
│   ├── welcome_image.dart
│   ├── welcome_screen.dart
│   └── thank_you_animation.dart
├── constants.dart
├── firebase_options.dart
├── main.dart
├── professor_review.dart
├── responsive.dart
├── signup_screen.dart
├── social_icon.dart
└── university_review.dart

Usage:

Authentication: Users can sign up or log in to the platform.

Post Reviews: Users can leave reviews for universities and professors.

Browse Reviews: Users can browse and filter reviews for universities and professors.


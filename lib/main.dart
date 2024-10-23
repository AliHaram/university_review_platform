import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:university_review_platform/widgets/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home.dart';
import 'screens/browse_uni_reviews.dart';
import 'screens/browse_prof_reviews.dart';
import 'screens/professor_review_form.dart';
import 'screens/review_form.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Review Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomePage(),
        '/browse_uni_reviews': (context) => BrowseUniReviewsPage(),
        '/browse_prof_reviews': (context) => BrowseProfReviewsPage(),
        '/professor_review_form': (context) => ProfessorReviewForm(),
        '/university_review': (context) => ReviewForm(), // Ensure this points to ReviewForm
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../thank_you_animation.dart';

class ProfessorReviewForm extends StatefulWidget {
  @override
  _ProfessorReviewFormState createState() => _ProfessorReviewFormState();
}

class _ProfessorReviewFormState extends State<ProfessorReviewForm> {
  String? selectedUniversity;
  String? selectedProfessor;
  String? courseCode;
  String? grade;
  double professorRating = 0;
  final _professorReviewController = TextEditingController();

  @override
  void dispose() {
    _professorReviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (selectedUniversity != null &&
        selectedProfessor != null &&
        courseCode != null &&
        professorRating > 0 &&
        _professorReviewController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('professor_reviews').add({
          'university': selectedUniversity,
          'professor': selectedProfessor,
          'courseCode': courseCode,
          'grade': grade,
          'rating': professorRating,
          'content': _professorReviewController.text,
          'timestamp': Timestamp.now(),
        });
        _showThankYouDialog();
        _professorReviewController.clear();
        setState(() {
          selectedUniversity = null;
          selectedProfessor = null;
          courseCode = null;
          grade = null;
          professorRating = 0;
        });
      } catch (e) {
        print('Failed to submit review: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit review: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please complete all required fields')));
    }
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThankYouAnimation(),
                SizedBox(height: 20),
                Text(
                  'Thank you for your review!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _showReminderDialog(context));
  }

  void _showReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Friendly Reminder'),
          content: Text(
            'With great power comes great responsibility! Your reviews can help others make important decisions, so let\'s keep it real, constructive, and free of nonsense. No "my dog ate my homework" reviews, please. Your feedback is super valuable!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Got it!'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Write a Professor Review')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/prof_review.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Professor Review',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedUniversity,
                    hint: Text('Select University'),
                    onChanged: (value) {
                      setState(() {
                        selectedUniversity = value;
                      });
                    },
                    items: universities.map((university) {
                      return DropdownMenuItem(
                        value: university,
                        child: Text(university),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Professor Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedProfessor = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Course Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        courseCode = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Grade (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        grade = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: professorRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() {
                        professorRating = rating;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _professorReviewController,
                    decoration: InputDecoration(
                      hintText: 'Write your review',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitReview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/login_bottom.png',
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> universities = [
  'University of Jordan',
  'University of Petra',
  'Princess Sumaya University for Technology',
  'German Jordanian University',
  'Luminus',
  'Techno University',
];

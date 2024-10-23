import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import '../constants.dart';
import '../thank_you_animation.dart';
import '../thank_you_animation.dart';

class ReviewForm extends StatefulWidget {
  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  String? selectedUniversity;
  double universityRating = 0;
  final _universityReviewController = TextEditingController();

  @override
  void dispose() {
    _universityReviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (selectedUniversity != null && universityRating > 0 && _universityReviewController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('reviews').add({
          'university': selectedUniversity,
          'rating': universityRating,
          'content': _universityReviewController.text,
          'timestamp': Timestamp.now(),
        });
        _showThankYouDialog();
        _universityReviewController.clear();
        setState(() {
          selectedUniversity = null;
          universityRating = 0;
        });
      } catch (e) {
        print('Failed to submit review: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit review: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please complete all fields')));
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
      appBar: AppBar(title: Text('Write a Review')),
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
                      'assets/images/uni_review.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('University Review', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  RatingBar.builder(
                    initialRating: universityRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() {
                        universityRating = rating;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _universityReviewController,
                    decoration: InputDecoration(
                      hintText: 'Write your review',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitReview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessorReview extends StatefulWidget {
  @override
  _ProfessorReviewState createState() => _ProfessorReviewState();
}

class _ProfessorReviewState extends State<ProfessorReview> {
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _professorController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0;

  final List<String> universities = [
    'University of Jordan',
    'University of Petra',
    'Princess Sumaya University for Technology',
    'German Jordanian University',
    'Luminus',
    'Techno University',
  ];

  List<String> professors = [];
  List<String> courses = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadFormField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _universityController,
            decoration: InputDecoration(labelText: 'Select University'),
          ),
          suggestionsCallback: (pattern) {
            return universities.where((university) =>
                university.toLowerCase().contains(pattern.toLowerCase()));
          },
          itemBuilder: (context, suggestion) {
            return ListTile(title: Text(suggestion));
          },
          onSuggestionSelected: (suggestion) async {
            _universityController.text = suggestion;
            // Load professors based on university selection
            var professorsData = await FirebaseFirestore.instance
                .collection('universities')
                .doc(suggestion)
                .collection('professors')
                .get();
            setState(() {
              professors = professorsData.docs
                  .map((doc) => doc.data()['name'] as String)
                  .toList();
            });
          },
        ),
        TypeAheadFormField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _professorController,
            decoration: InputDecoration(labelText: 'Select Professor'),
          ),
          suggestionsCallback: (pattern) {
            return professors.where((professor) =>
                professor.toLowerCase().contains(pattern.toLowerCase()));
          },
          itemBuilder: (context, suggestion) {
            return ListTile(title: Text(suggestion));
          },
          onSuggestionSelected: (suggestion) async {
            _professorController.text = suggestion;
            // Load courses based on professor selection
            var coursesData = await FirebaseFirestore.instance
                .collection('universities')
                .doc(_universityController.text)
                .collection('professors')
                .doc(suggestion)
                .collection('courses')
                .get();
            setState(() {
              courses = coursesData.docs
                  .map((doc) => doc.data()['name'] as String)
                  .toList();
            });
          },
        ),
        TypeAheadFormField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _courseController,
            decoration: InputDecoration(labelText: 'Select Course'),
          ),
          suggestionsCallback: (pattern) {
            return courses.where((course) =>
                course.toLowerCase().contains(pattern.toLowerCase()));
          },
          itemBuilder: (context, suggestion) {
            return ListTile(title: Text(suggestion));
          },
          onSuggestionSelected: (suggestion) {
            _courseController.text = suggestion;
          },
        ),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
        TextField(
          controller: _reviewController,
          maxLines: 4,
          decoration: InputDecoration(labelText: 'Write your review'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_universityController.text.isNotEmpty && _professorController.text.isNotEmpty && _courseController.text.isNotEmpty && _reviewController.text.isNotEmpty) {
              await FirebaseFirestore.instance.collection('universities').doc(_universityController.text).collection('professors').doc(_professorController.text).collection('reviews').add({
                'course': _courseController.text,
                'content': _reviewController.text,
                'rating': _rating,
                'date': DateTime.now(),
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review submitted successfully')));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please complete all fields')));
            }
          },
          child: Text('Submit Review'),
        ),
      ],
    );
  }
}

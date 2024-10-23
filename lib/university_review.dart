import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UniversityReview extends StatefulWidget {
  @override
  _UniversityReviewState createState() => _UniversityReviewState();
}

class _UniversityReviewState extends State<UniversityReview> {
  final TextEditingController _universityController = TextEditingController();
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
          onSuggestionSelected: (suggestion) {
            _universityController.text = suggestion;
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
            if (_universityController.text.isNotEmpty && _reviewController.text.isNotEmpty) {
              await FirebaseFirestore.instance.collection('universities').doc(_universityController.text).collection('reviews').add({
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



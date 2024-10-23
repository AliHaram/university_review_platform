import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/review.png'),
              SizedBox(height: 20),
              Text(
                'Welcome to the University Review Platform!',
                style: TextStyle(
                  fontSize: 24.0, // Adjust the text size as needed
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Post and browse anonymous reviews about universities and professors in Jordan.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/browse_uni_reviews');
                },
                child: Text('Browse University Reviews'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/browse_prof_reviews');
                },
                child: Text('Browse Professor Reviews'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _showReviewTypeDialog(context);
                },
                child: Text('Leave a Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReviewTypeDialog(BuildContext context) {
    String? selectedReviewType;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select Review Type'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('University Review'),
                    leading: Radio<String>(
                      value: 'University',
                      groupValue: selectedReviewType,
                      onChanged: (value) {
                        setState(() {
                          selectedReviewType = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Professor Review'),
                    leading: Radio<String>(
                      value: 'Professor',
                      groupValue: selectedReviewType,
                      onChanged: (value) {
                        setState(() {
                          selectedReviewType = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedReviewType == 'University') {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/university_review');
                    } else if (selectedReviewType == 'Professor') {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/professor_review_form');
                    }
                  },
                  child: Text('Continue'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

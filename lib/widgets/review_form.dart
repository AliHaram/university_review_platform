import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants.dart';

class ReviewForm extends StatefulWidget {
  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  String? selectedUniversity;
  double universityRating = 0;
  String? selectedProfessor;
  String? selectedCourse;
  double professorRating = 0;
  final _universityReviewController = TextEditingController();
  final _professorReviewController = TextEditingController();

  final Map<String, List<String>> professorsByUniversity = {
    'University of Jordan': ['Prof. A', 'Prof. B'],
    'University of Petra': ['Prof. C', 'Prof. D'],
    'Princess Sumaya University for Technology': ['Prof. E', 'Prof. F'],
    'German Jordanian University': ['Prof. G', 'Prof. H'],
    'Luminus': ['Prof. I', 'Prof. J'],
    'Techno University': ['Prof. K', 'Prof. L'],
  };

  final Map<String, List<String>> coursesByProfessor = {
    'Prof. A': ['Course 1', 'Course 2'],
    'Prof. B': ['Course 3', 'Course 4'],
    'Prof. C': ['Course 5', 'Course 6'],
    'Prof. D': ['Course 7', 'Course 8'],
    'Prof. E': ['Course 9', 'Course 10'],
    'Prof. F': ['Course 11', 'Course 12'],
    'Prof. G': ['Course 13', 'Course 14'],
    'Prof. H': ['Course 15', 'Course 16'],
    'Prof. I': ['Course 17', 'Course 18'],
    'Prof. J': ['Course 19', 'Course 20'],
    'Prof. K': ['Course 21', 'Course 22'],
    'Prof. L': ['Course 23', 'Course 24'],
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('University Review', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedUniversity,
              hint: Text('Select University'),
              onChanged: (value) {
                setState(() {
                  selectedUniversity = value;
                  selectedProfessor = null;
                  selectedCourse = null;
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
            Text('Professor Review', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedUniversity,
              hint: Text('Select University'),
              onChanged: (value) {
                setState(() {
                  selectedUniversity = value;
                  selectedProfessor = null;
                  selectedCourse = null;
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
            if (selectedUniversity != null)
              DropdownButtonFormField<String>(
                value: selectedProfessor,
                hint: Text('Select Professor'),
                onChanged: (value) {
                  setState(() {
                    selectedProfessor = value;
                    selectedCourse = null;
                  });
                },
                items: professorsByUniversity[selectedUniversity!]!.map((professor) {
                  return DropdownMenuItem(
                    value: professor,
                    child: Text(professor),
                  );
                }).toList(),
              ),
            SizedBox(height: 10),
            if (selectedProfessor != null)
              DropdownButtonFormField<String>(
                value: selectedCourse,
                hint: Text('Select Course'),
                onChanged: (value) {
                  setState(() {
                    selectedCourse = value;
                  });
                },
                items: coursesByProfessor[selectedProfessor!]!.map((course) {
                  return DropdownMenuItem(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
              ),
            SizedBox(height: 10),
            if (selectedCourse != null)
              RatingBar.builder(
                initialRating: professorRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
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
          ],
        ),
      ),
    );
  }
}

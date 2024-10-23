import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BrowseProfReviewsPage extends StatefulWidget {
  @override
  _BrowseProfReviewsPageState createState() => _BrowseProfReviewsPageState();
}

class _BrowseProfReviewsPageState extends State<BrowseProfReviewsPage> {
  String? _selectedUniversity;
  double _averageRating = 0;

  Future<void> _calculateAverageRating() async {
    if (_selectedUniversity != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('professor_reviews')
          .where('university', isEqualTo: _selectedUniversity)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        double totalRating = 0;
        int reviewCount = querySnapshot.docs.length;
        for (var doc in querySnapshot.docs) {
          totalRating += doc['rating'];
        }
        setState(() {
          _averageRating = totalRating / reviewCount;
        });
      } else {
        setState(() {
          _averageRating = 0;
        });
      }
    }
  }

  Stream<QuerySnapshot> _getReviewsStream() {
    if (_selectedUniversity != null) {
      return FirebaseFirestore.instance
          .collection('professor_reviews')
          .where('university', isEqualTo: _selectedUniversity)
          .snapshots();
    } else {
      return Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Professor Reviews'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedUniversity,
                  hint: Text('Select University'),
                  onChanged: (value) {
                    setState(() {
                      _selectedUniversity = value;
                      _calculateAverageRating();
                    });
                  },
                  items: universities.map((university) {
                    return DropdownMenuItem(
                      value: university,
                      child: Text(university),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          if (_selectedUniversity != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Average Professor Rating for $_selectedUniversity:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  RatingBar.builder(
                    initialRating: _averageRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {},
                    ignoreGestures: true,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          if (_selectedUniversity != null)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _getReviewsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No reviews available.'));
                  }
                  var reviews = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      var review = reviews[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Professor: ${review['professor']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text('Course Code: ${review['courseCode']}', style: TextStyle(fontSize: 14)),
                                SizedBox(height: 5),
                                Text(review['content'], style: TextStyle(fontSize: 14)),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: review['rating'].toDouble(),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                                      onRatingUpdate: (rating) {},
                                      itemSize: 20,
                                      ignoreGestures: true,
                                    ),
                                    SizedBox(width: 10),
                                    if (review['grade'] != null)
                                      Text('Grade: ${review['grade']}', style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
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

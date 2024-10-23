import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String userId;
  final String universityId;
  final String professorId;
  final String content;
  final int rating;
  final DateTime date;

  Review({
    required this.id,
    required this.userId,
    required this.universityId,
    required this.professorId,
    required this.content,
    required this.rating,
    required this.date,
  });

  factory Review.fromMap(Map<String, dynamic> data, String id) {
    return Review(
      id: id,
      userId: data['userId'],
      universityId: data['universityId'],
      professorId: data['professorId'],
      content: data['content'],
      rating: data['rating'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'universityId': universityId,
      'professorId': professorId,
      'content': content,
      'rating': rating,
      'date': date,
    };
  }
}

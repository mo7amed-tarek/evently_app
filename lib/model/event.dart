// lib/model/event.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? type;
  Timestamp? date;
  double? latitude;
  double? longitude;
  List<String>? favoriteUsers;

  Event({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.type,
    this.date,
    this.latitude,
    this.longitude,
    this.favoriteUsers,
  });

  factory Event.fromFireStore(Map<String, dynamic>? json, String docId) {
    return Event(
      id: docId,
      userId: json?['userId'],
      title: json?['title'],
      description: json?['description'],
      type: json?['type'],
      date: json?['date'] as Timestamp?,
      latitude: (json?['latitude'] as num?)?.toDouble(),
      longitude: (json?['longitude'] as num?)?.toDouble(),
      favoriteUsers:
          (json?['favoriteUsers'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'type': type,
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
      'favoriteUsers': favoriteUsers,
    };
  }
}

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class PostModel {
  final String? id;
  final String postHeading;
  final String postSubHeading;
  final String postVideoUrl;
  final String postLikeCount;
  final String postCommentCount;
  final String postHoursCount;
  final String userId;
  final List<dynamic> tags;
  DateTime timestamp;

  PostModel({
    this.id,
    required this.userId,
    required this.postHeading,
    required this.tags,
    required this.postSubHeading,
    required this.postVideoUrl,
    required this.postLikeCount,
    required this.postCommentCount,
    required this.postHoursCount,
    required this.timestamp,
  });

  // Convert a Post object into a Map
  Map<String, dynamic> toMap() {
    return {
      'postHeading': postHeading,
      'postSubHeading': postSubHeading,
      'postVideoUrl': postVideoUrl,
      'tags': tags,
      'postLikeCount': postLikeCount,
      'postCommentCount': postCommentCount,
      'postHoursCount': postHoursCount,
      'timestamp': timestamp.toIso8601String(),
      'userId':userId,
    };
  }

  // Convert a Map into a Post object
  static PostModel fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: '',
      postHeading: map["postHeading"],
      postSubHeading: map["postSubHeading"],
      postVideoUrl: map["postVideoUrl"],
      tags: map["tags"],
      postLikeCount: map["postLikeCount"],
      postCommentCount: map["postCommentCount"],
      postHoursCount: map["postHoursCount"],
      timestamp: DateTime.parse(map['timestamp']),
      userId: '',
    );
  }

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return PostModel(
      postHeading: data["postHeading"],
      postSubHeading: data["postSubHeading"],
      postVideoUrl: data["postVideoUrl"],
      tags: data["tags"],
      postLikeCount: data["postLikeCount"],
      postCommentCount: data["postCommentCount"],
      postHoursCount: data["postHoursCount"],
      timestamp: DateTime.parse(data['timestamp']),
      userId: '',
    );
  }
}

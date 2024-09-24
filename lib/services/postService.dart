import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostService {
  final String apiUrl = 'http://192.168.171.52:5000/9GAG/post';

  Future<bool> createPost(PostModel post) async {
    final response = await http.post(
      Uri.parse('$apiUrl/createPosts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(post.toMap()),
    );

    if (response.statusCode == 201) {
      print('Post created successfully');
      return true;
    } else {
      throw Exception('Failed to create post');
    }
  }
  // Future<PostModel?> createPost(PostModel post) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$apiUrl/createPosts'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({
  //         'postHeading': post.postHeading,
  //         'postSubHeading': post.postSubHeading,
  //         'videoUrl': post.postVideoUrl,
  //         'postHoursCount': post.postHoursCount,
  //         'postLikesCount':post.postLikeCount,
  //         'postCommentCount':post.postCommentCount,
  //         'tags':post.tags,
  //         'currentUserId': post.userId,
  //       }),
  //     );
  //
  //     if (response.statusCode == 201) {
  //       final data = json.decode(response.body);
  //       return PostModel.fromMap(data);
  //     } else {
  //       throw Exception('Failed to create post');
  //     }
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

}

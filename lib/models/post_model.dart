import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PostModel {
  final String postHeading;
  final String postSubHeading;
  final String postVideoUrl;
  final String postLikeCount;
  final String postCommentCount;
  final String postHoursCount;
  final List<String> postBottomScrollView;

  PostModel({
    required this.postHeading,
    required this.postBottomScrollView,
    required this.postSubHeading,
    required this.postVideoUrl,
    required this.postLikeCount,
    required this.postCommentCount,
    required this.postHoursCount,
  });

}

class PostList {
  List<PostModel> posts;

  PostList({
    required this.posts,
  });

  void addPost(PostModel post) {
    posts.add(post);
  }
}

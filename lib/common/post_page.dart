import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:gagclone/models/post_model.dart';
// import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // final List<PostModel> list = [
  //   PostModel(
  //     postHeading: "Humor",
  //     postBottomScrollView: ["girl", "funny", "random", "humor", "no sound"],
  //     postSubHeading: "Oh yes...let's the kid having fun...",
  //     postVideoUrl:
  //         "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  //     postLikeCount: "10K",
  //     postCommentCount: "256",
  //     postHoursCount: "10",
  //     timestamp: DateTime.now(),
  //   ),
  //   PostModel(
  //     postHeading: "Humor",
  //     postBottomScrollView: ["girl", "humor", "no sound"],
  //     postSubHeading: "Oh yes...let's the kid having fun...",
  //     postVideoUrl:
  //         "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
  //     postLikeCount: "1.2M",
  //     postCommentCount: "700",
  //     postHoursCount: "10",
  //     timestamp: DateTime.now(),
  //   ),
  //   PostModel(
  //     postHeading: "Humor",
  //     postBottomScrollView: ["girl", "funny", "random"],
  //     postSubHeading: "Oh yes...let's the kid having fun...",
  //     postVideoUrl:
  //         "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  //     postLikeCount: "4K",
  //     postCommentCount: "1K",
  //     postHoursCount: "10",
  //     timestamp: DateTime.now(),
  //   ),
  //   PostModel(
  //     postHeading: "Humor",
  //     postBottomScrollView: [
  //       "funny",
  //     ],
  //     postSubHeading: "Oh yes...let's the kid having fun...",
  //     postVideoUrl:
  //         "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
  //     postLikeCount: "5.2",
  //     postCommentCount: "5K",
  //     postHoursCount: "10",
  //     timestamp: DateTime.now(),
  //   ),
  // ];

  Future<List<dynamic>> fetchAllUserUIDs() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<dynamic> userUIDs = querySnapshot.docs.map((doc) => doc.id).toList();
      return userUIDs;
    } catch (e) {
      print('Error fetching user UIDs: $e');
      return [];
    }
  }

  Future<List<PostModel>> fetchAllPosts() async {
    List<PostModel> allPosts = [];

    List<dynamic> userUIDs = await fetchAllUserUIDs();
    for (dynamic uid in userUIDs) {
      QuerySnapshot userPostsSnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(uid)
          .collection('posts')
          .get();

      List<PostModel> userPosts = userPostsSnapshot.docs
          .map((doc) => PostModel.fromFirestore(doc))
          .toList();
      allPosts.addAll(userPosts);
    }
    return allPosts;
  }

  bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;

  @override
  void initState() {
    // initDynamicLinks();
    super.initState();
  }

  // void initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink.listen(
  //         (PendingDynamicLinkData? dynamicLink) async {
  //       final Uri? deepLink = dynamicLink?.link;
  //
  //       if (deepLink != null) {
  //         var isPost = deepLink.pathSegments.contains('post');
  //         if (isPost) {
  //           var postId = deepLink.queryParameters['postId'];
  //           if (postId != null) {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => PostViewScreen(postId: postId),
  //               ),
  //             );
  //           }
  //         }
  //       }
  //     },
  //     onError: (dynamic e) async {
  //       print('onLinkError');
  //       print(e.message);
  //     },
  //   );
  //
  //   final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
  //   final Uri? deepLink = data?.link;
  //
  //   if (deepLink != null) {
  //     var isPost = deepLink.pathSegments.contains('post');
  //     if (isPost) {
  //       var postId = deepLink.queryParameters['postId'];
  //       if (postId != null) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => PostViewScreen(postId: postId),
  //           ),
  //         );
  //       }
  //     }
  //   }
  // }

  // Future<Uri> createDynamicLink(String postId) async {
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix: 'https://gagclone.page.link',
  //     link: Uri.parse('https://com.genixbit.gagclone/post?postId=$postId'),
  //     androidParameters: AndroidParameters(
  //       packageName: 'com.genixbit.gagclone',
  //     ),
  //     // iosParameters: IosParameters(
  //     //   bundleId: 'com.example.yourapp',
  //     // ),
  //   );
  //
  //   final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  //   return shortDynamicLink.shortUrl;
  // }

  // void sharePost(String postId) async {
  //   final Uri dynamicUrl = await createDynamicLink(postId);
  //   Share.share(dynamicUrl.toString());
  // }

  // Future<String> createDynamicLink(String postId) async {
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix: 'https://gagclone.page.link',
  //     link: Uri.parse('https://com.genixbit.gagclone/post?postId=$postId'),
  //     androidParameters: AndroidParameters(
  //       packageName: 'com.genixbit.gagclone',
  //       minimumVersion: 0,
  //     ),
  //     iosParameters: IOSParameters(
  //       bundleId: 'com.genixbit.gagclone',
  //       minimumVersion: '0',
  //     ),
  //   );
  //
  //   final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  //   return shortDynamicLink.shortUrl.toString();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: FutureBuilder<List<PostModel>>(
        future: fetchAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                PostModel post = snapshot.data![index];
                return postCard(
                  // id: post.id,
                  heading: post.postHeading,
                  subHeading: post.postSubHeading,
                  // bottomScroll: data['postBottomScrollView'],
                  videoURL: post.postVideoUrl,
                  likeCount: post.postLikeCount,
                  commentCount: post.postCommentCount,
                  postHours: post.postHoursCount,
                );
              },
            );
          }
        },
      ),
    );
    // isLoggedIn
    //     ? StreamBuilder<QuerySnapshot>(
    //         stream: FirebaseFirestore.instance
    //             .collection('posts')
    //             .doc()
    //             .collection("posts")
    //             .snapshots(),
    //         builder: (context, snapshot) {
    //           if (!snapshot.hasData) {
    //             return Center(child: CircularProgressIndicator());
    //           }
    //           List<DocumentSnapshot> docs = snapshot.data!.docs;
    //           return
    //             docs.length == 0 ?
    //             ListView.builder(
    //             // shrinkWrap: true,
    //             itemCount: list.length,
    //             itemBuilder: (context, index) {
    //               return postCard(
    //                 heading: list[index].postHeading,
    //                 subHeading: list[index].postSubHeading,
    //                 // bottomScroll: list[index].postBottomScrollView,
    //                 videoURL: list[index].postVideoUrl,
    //                 likeCount: list[index].postLikeCount,
    //                 commentCount: list[index].postCommentCount,
    //                 postHours: list[index].postHoursCount,
    //               );
    //             },
    //           ) :
    //             ListView.builder(
    //             itemCount: docs.length,
    //             itemBuilder: (context, index) {
    //               Map<String, dynamic> data =
    //                   docs[index].data() as Map<String, dynamic>;
    //               return
    //               postCard(
    //                 heading: data['postHeading'],
    //                 subHeading: data['postSubHeading'],
    //                 // bottomScroll: data['postBottomScrollView'],
    //                 videoURL: data['postVideoUrl'],
    //                 likeCount: data['postLikeCount'],
    //                 commentCount: data['postCommentCount'],
    //                 postHours: data['postHoursCount'],
    //               );
    //               //   ListTile(
    //               //   title: Text(data['postHeading']),
    //               //   subtitle: Text(data['postSubHeading']),
    //               // );
    //             },
    //           );
    //         })
    //     : ListView.builder(
    //         // shrinkWrap: true,
    //         itemCount: list.length,
    //         itemBuilder: (context, index) {
    //           return postCard(
    //             heading: list[index].postHeading,
    //             subHeading: list[index].postSubHeading,
    //             // bottomScroll: list[index].postBottomScrollView,
    //             videoURL: list[index].postVideoUrl,
    //             likeCount: list[index].postLikeCount,
    //             commentCount: list[index].postCommentCount,
    //             postHours: list[index].postHoursCount,
    //           );
    //         },
    //       ));
  }
  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(color: color, fontWeight: weight, fontSize: size);
  }
  Widget postCard({
    required heading,
    required subHeading,
    required videoURL,
    required likeCount,
    // required bottomScroll,
    required commentCount,
    required postHours,
  }) {
    return Container(
      child: Column(
        children: [
          postTitle(heading: heading, subHeading: subHeading, hours: postHours),
          SizedBox(
            height: 5,
          ),
          // isLoggedIn ?
          // Image.network(videoURL,height: 300,width: MediaQuery.sizeOf(context).width,fit: BoxFit.fill,) :
          // PostVideo(
          //   videoURL: videoURL,
          // ),
          // postBottomScrollView(
          //   list: bottomScroll,
          //   listItem: bottomScroll,
          // ),
          SizedBox(
            height: 10.0,
          ),
          postBottom(likeCount: likeCount, commentCount: commentCount),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            thickness: 7.0,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  Widget commonContainerBorder(name) {
    return Container(
      child: Text(
        name,
        style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1)),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    );
  }

  Widget postTitle(
      {required String heading,
      required String subHeading,
      required String hours}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(5.00)),
                        child: Icon(
                          Icons.ac_unit_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        heading,
                        style: commonTextStyle(
                            Colors.black, FontWeight.bold, 14.00),
                      ),
                      Text(
                        " . $hours" + "h",
                        style: commonTextStyle(
                            Colors.grey, FontWeight.bold, 12.00),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.more_vert_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subHeading,
            style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
          ),
        ],
      ),
    );
  }

  Widget postBottom({required String likeCount, required String commentCount}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/post/arrow_upper.png",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(likeCount),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "assets/post/arrow_down.png",
                    width: 20,
                    height: 20,
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/post/comment.png",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(commentCount),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              // createDynamicLink(id);
              // sharePost(id);
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/post/share.png",
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Share"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostVideo extends StatefulWidget {
  final String videoURL;
  const PostVideo({super.key, required this.videoURL});

  @override
  _PostVideoState createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoURL);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      // autoPlay: true,
      looping: true,
      allowMuting: true,
      showControls: true,
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.sizeOf(context).width,
      child: Center(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}

class postBottomScrollView extends StatefulWidget {
  final List<String> list;
  final List<String> listItem;
  const postBottomScrollView(
      {super.key, required this.list, required this.listItem});

  @override
  State<postBottomScrollView> createState() => _postBottomScrollViewState();
}

class _postBottomScrollViewState extends State<postBottomScrollView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Container(
              child: Text(
                widget.listItem[index],
                style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 1)),
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            ),
          );
        },
      ),
    );
  }

  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(
      color: color,
      fontWeight: weight,
      fontSize: size,
    );
  }
}

class PostViewScreen extends StatefulWidget {
  final String postId;

  PostViewScreen({required this.postId});

  @override
  State<PostViewScreen> createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  Future<Map<String, dynamic>> _fetchPostData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('allPost').doc(widget.postId).get();
    return snapshot.data() as Map<String, dynamic>;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Post Page'),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.3),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _fetchPostData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('Post not found'));
            }
            Map<String, dynamic> postData = snapshot.data!;
            return postCard(
              id: widget.postId,
              heading: postData['postHeading'],
              subHeading:postData['postSubHeading'],
              videoURL: postData['postVideoUrl'],
              likeCount: postData['postLikeCount'],
              commentCount: postData['postCommentCount'],
              postHours: postData['postHoursCount'],
            );
          },
        ),
      ),
    );
  }

  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(color: color, fontWeight: weight, fontSize: size);
  }
  Widget postCard({
    required id,
    required heading,
    required subHeading,
    required videoURL,
    required likeCount,
    // required bottomScroll,
    required commentCount,
    required postHours,
  }) {
    return Container(
      child: Column(
        children: [
          postTitle(heading: heading, subHeading: subHeading, hours: postHours),
          SizedBox(
            height: 5,
          ),
          // isLoggedIn ?
          // Image.network(videoURL,height: 300,width: MediaQuery.sizeOf(context).width,fit: BoxFit.fill,) :
          PostVideo(
            videoURL: videoURL,
          ),
          // postBottomScrollView(
          //   list: bottomScroll,
          //   listItem: bottomScroll,
          // ),
          SizedBox(
            height: 10.0,
          ),
          postBottom(likeCount: likeCount, commentCount: commentCount,id: id),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            thickness: 7.0,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  Widget commonContainerBorder(name) {
    return Container(
      child: Text(
        name,
        style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1)),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    );
  }

  Widget postTitle(
      {required String heading,
        required String subHeading,
        required String hours}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(5.00)),
                        child: Icon(
                          Icons.ac_unit_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        heading,
                        style: commonTextStyle(
                            Colors.black, FontWeight.bold, 14.00),
                      ),
                      Text(
                        " . $hours" + "h",
                        style: commonTextStyle(
                            Colors.grey, FontWeight.bold, 12.00),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.more_vert_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subHeading,
            style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
          ),
        ],
      ),
    );
  }

  Widget postBottom({required String likeCount, required String commentCount,required String id}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/post/arrow_upper.png",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(likeCount),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "assets/post/arrow_down.png",
                    width: 20,
                    height: 20,
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/post/comment.png",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(commentCount),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

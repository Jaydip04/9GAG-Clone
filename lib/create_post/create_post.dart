import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagclone/common/toast.dart';
import 'package:gagclone/create_post/choose_interest.dart';
import 'package:gagclone/create_post/tags.dart';
import 'package:gagclone/pages/home_page.dart';
import 'package:gagclone/profile/profile_page.dart';
// import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../models/post_model.dart';
import '../services/authService.dart';
import '../services/postService.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({
    super.key,
  });

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;
  String _tags = 'Add at least 1 tag';
  String _interest = 'Choose interest';
  String _url = 'assets/logo/apple.png';
  bool _isLoading = false;
  final AuthService _authService = AuthService();
  PostService postService = PostService();

  @override
  void initState() {
    super.initState();
    fetchUserData();
    _controller.addListener(() {
      setState(() {
        _isButtonEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  // void fetchUserData() async {
  //   String? token = await _authService.getToken();
  //   Map<String, dynamic>? userData = await _authService.getUserData(token!);
  //
  //   if (userData != null) {
  //     String userId = userData['id'];
  //     String email = userData['email'];
  //     print('User ID: $userId');
  //     print('Email: $email');
  //   } else {
  //     print('Failed to fetch user data');
  //   }
  // }
  String? userId;
  void fetchUserData() async {
    String? token = await _authService.getToken();
    Map<String, dynamic>? userData = await _authService.getUserData(token!);

    if (userData != null) {
      setState(() {
        userId = userData['_id'];
      });
      print('User ID: $userId');
    } else {
      print('Failed to fetch user data');
      // Handle the case when userData is null
    }
  }

  // Future<String> uploadImage(File imageFile) async {
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   Reference storageReference =
  //       FirebaseStorage.instance.ref().child("videos/$fileName");
  //   UploadTask uploadTask = storageReference.putFile(File(imageFile.path));
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   String downloadURL = await taskSnapshot.ref.getDownloadURL();
  //   return downloadURL;
  // }
  List<String> finalTags = [];
  void addWord(String word) {
    if (word != null && word.isNotEmpty) {
      finalTags.add(word);
    }
  }

  @override
  Widget build(BuildContext context) {
    final File requiredParameter =
        ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            color: Colors.grey,
            size: 22,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    backgroundColor: Colors.white,
                    content: Container(
                      height: 111.0,
                      width: MediaQuery.sizeOf(context).width / 1.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Are you sure?",
                                style: commonTextStyle(
                                    Colors.black, FontWeight.bold, 16.00, null),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Your post won't be saved",
                                style: commonTextStyle(
                                    Colors.black, FontWeight.w500, 14.00, null),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: commonTextStyle(Colors.indigo,
                                        FontWeight.bold, 14.00, null),
                                  )),
                              SizedBox(
                                width: 20.0,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/', (route) => false);
                                  },
                                  child: Text(
                                    "Discard",
                                    style: commonTextStyle(Colors.red,
                                        FontWeight.bold, 14.00, null),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        title: Text(
          "Create Post",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00, null),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              setState(() {
                _isLoading = true;
              });

              List<String> words = _tags.split(' ');

              if (words.length <= 5) {

                addWord(words[0].isNotEmpty ? words[0] : "");
                addWord(words[1].isNotEmpty ? words[1] : "");
                addWord(words[2].isNotEmpty ? words[2] : "");
                addWord(words[3].isNotEmpty ? words[3] : "");
                addWord(words[4].isNotEmpty ? words[4] : "");

                try {
                  String postSubHeading = _controller.text.toString();

                  final newPost = PostModel(
                    userId: userId!,
                    postHeading: _interest,
                    tags: finalTags,
                    postSubHeading: postSubHeading,
                    postVideoUrl: 'http://video.url',
                    postLikeCount: '0',
                    postCommentCount: '0',
                    postHoursCount: '1',
                    timestamp: DateTime.now(),
                  );
                  try {
                    var result =  await postService.createPost(newPost);
                    if(result != null){
                      Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (route) => false);
                      showToast(message: "Post added successfully!");
                      print('Post created');
                    }else{
                      showToast(message: "Failed to create post");
                      print('Post created');
                    }
                  } catch (error) {
                    print('Error creating post: $error');
                  }
                  // try{
                  //   final result = await postService.createPost(newPost);
                  //   if (result != null) {
                  //     showToast(message: "Post added successfully!");
                  //     print('Post created');
                  //   } else {
                  //     showToast(message: "Failed to create post");
                  //     print('Failed to create post');
                  //   }
                  // }catch(e){
                  //   print(e);
                  // }

                  // FirebaseFirestore firestore = FirebaseFirestore.instance;
                  // await firestore
                  //     .collection('posts')
                  //     .doc(FirebaseAuth.instance.currentUser!.uid)
                  //     .collection("posts")
                  //     .doc(postId)
                  //     .set(post.toMap())
                  //     .then((onValue) async {
                  //   FirebaseFirestore firestoreUser =
                  //       FirebaseFirestore.instance;
                  //   await firestoreUser
                  //       .collection('users')
                  //       .doc(FirebaseAuth.instance.currentUser!.uid)
                  //       .set({
                  //     "currentUserUid": FirebaseAuth.instance.currentUser!.uid
                  //   }).then((onValue) {
                  //     firestoreUser
                  //         .collection('allPost')
                  //         .doc(postId)
                  //         .set(post.toMap()).then((onValue) {
                  //       Navigator.pushNamedAndRemoveUntil(
                  //           context, '/', (route) => false);
                  //       showToast(message: "Post added successfully!");
                  //     });
                  //   });
                  //   print('Post added successfully!');
                  // });

                  setState(() {
                    _isLoading = false;
                  });
                } catch (e) {
                  print('Error adding post: $e');
                }
              } else {
                print('The input does not contain enough words.');
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                width: 80.00,
                height: 45.00,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Center(
                  child: Text(
                    "Post",
                    style: commonTextStyle(
                        _controller.text.isNotEmpty
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        FontWeight.bold,
                        14.00,
                        null),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.indigo,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white,
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 4.0,
                ))
              : Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                            context, '/createPost/chooseInterest');
                        if (result != null && result is Map<String, dynamic>) {
                          setState(() {
                            _interest = result['interestText'];
                            _url = result['imageUrl'];
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1.0),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      _url,
                                      width: 30.00,
                                      height: 30.00,
                                    ),
                                    SizedBox(
                                      width: 20.00,
                                    ),
                                    Text(
                                      "$_interest",
                                      style: commonTextStyle(Colors.black,
                                          FontWeight.bold, 14.00, null),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: Colors.grey,
                              size: 18.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.2), width: 1.0),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: 8,
                        maxLength: 280,
                        showCursor: true,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              280), // Max 280 characters
                        ],
                        style: commonTextStyle(Colors.black, FontWeight.bold,
                            18.00, TextDecoration.underline),
                        cursorColor: Colors.indigo,
                        controller: _controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0.0),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final tags = await Navigator.pushNamed(
                            context, '/createPost/tag') as String;
                        if (tags != null) {
                          setState(() {
                            _tags = tags;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1.0),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Tags",
                                      style: commonTextStyle(Colors.black,
                                          FontWeight.bold, 14.00, null),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      _tags != null
                                          ? _tags
                                          : "Add at least 1 tag",
                                      style: commonTextStyle(Colors.grey,
                                          FontWeight.bold, 14.00, null),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: Colors.grey,
                              size: 18.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.00,
                    ),
                    // widget.imageFile != null ? Image.file(widget.imageFile,width: MediaQuery.sizeOf(context).width,height: 400.00,fit: BoxFit.fill,):
                    PostVideo(
                      videoURL: requiredParameter.path,
                    )
                  ],
                ),
        ),
      ),
    );
  }

  TextStyle commonTextStyle(color, weight, size, decoration) {
    return TextStyle(
        color: color,
        fontWeight: weight,
        fontSize: size,
        decoration: decoration);
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
      looping: true,
      allowMuting: false,
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

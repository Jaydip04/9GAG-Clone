import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagclone/common/toast.dart';
import 'package:gagclone/profile/edit_profile_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

import '../models/post_model.dart';
import '../services/authService.dart';
import '../services/postService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  List<AssetEntity> mediaList = [];
  late TabController _tabController;
  final AuthService _authService = AuthService();
  Future<Map<String, dynamic>?>? _userData;
  PostService postService = PostService();
  late Future<List<PostModel>> fetchCurrentUserPost;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _tabController = TabController(
        length: 4,
        vsync: this,
        animationDuration: Duration(milliseconds: 2000));
    requestPermission().then((_) {
      fetchGalleryMedia().then((media) {
        setState(() {
          mediaList = media;
        });
      });
    });
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    await Future.delayed(Duration(seconds: 1));
    String? token = await _authService.getToken();
    if(token == null){
      return {};
    }else{
      String? token = await _authService.getToken();
      final userData = await _authService.getUserData(token!);
      setState(() {
        // fetchCurrentUserPost = postService.fetchCurrentUserPosts( userData!['_id']);
        fetchCurrentUserPost = postService.fetchCurrentUserPosts(userData!['_id']);
      });
      return {
        'name': userData!['username'],
        'userId':userData['_id']
      };
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();
  File? _cameraVideo;
  File? _galleryVideo;

  Future<void> _openCamera() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      print('Picked image path: ${pickedFile.path}');
      setState(() {
        _cameraVideo = File(pickedFile.path);Navigator.pushNamed(
          context,
          '/createPost',
          arguments: _cameraVideo!,
        );
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _openGallery() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('Picked image path: ${pickedFile.path}');
      setState(() {
        _galleryVideo = File(pickedFile.path);
        Navigator.pushNamed(
          context,
          '/createPost',
          arguments: _galleryVideo!,
        );
      });
    } else {
      print('No image selected.');
    }
  }

  String? imageUrl;
  // Future<void> _fetchProfileImageUrl() async {
  //   DatabaseReference ref = FirebaseDatabase.instance.ref(
  //       'Profile Photo/${FirebaseAuth.instance.currentUser!.uid}/profile_photo');
  //   DataSnapshot snapshot = await ref.get();
  //
  //   if (snapshot.exists) {
  //     setState(() {
  //       imageUrl = snapshot.value as String?;
  //     });
  //   } else {
  //     print('No image URL found');
  //   }
  // }

  Future<void> requestPermission() async {
    await Permission.photos.request();
  }

  Future<List<AssetEntity>> fetchGalleryMedia() async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      onlyAll: true,
    );

    final List<AssetEntity> media = await albums[0].getAssetListRange(
      start: 0,
      end: 100, // Fetch 100 media files
    );

    return media;
  }

  // final ImagePicker _picker = ImagePicker();
  //
  // Future<void> _openCamera() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //   if (image != null) {
  //     print('Picked image path: ${image.path}');
  //   } else {
  //     print('No image selected.');
  //   }
  // }
  //
  // Future<void> _openGallery() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     print('Picked image path: ${image.path}');
  //   } else {
  //     print('No image selected.');
  //   }
  // }

  // void _fetchToken() async {
  //   String? token = await _authService.getToken();
  //   final userData = await _authService.getUserData(token!);
  //   setState(() {
  //     _userData = userData;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text('Error loading user data',style: TextStyle(color: Colors.black,fontSize: 18.00,fontWeight: FontWeight.bold),textAlign:TextAlign.center,),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text('No user data available',style: TextStyle(color: Colors.black,fontSize: 18.00,fontWeight: FontWeight.bold),textAlign:TextAlign.center,),
            ),
          );
        } else {
          final userData = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.grey),
              leading: IconButton(
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.grey,
                  size: 22,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title:Text( userData['name'] ??
                  '9GAG',
                style: commonTextStyle(Colors.black, FontWeight.bold, 18.00),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile/editProfile');
                    },
                    child: Text(
                      "Edit profile",
                      style: commonTextStyle(Colors.indigo, FontWeight.bold, 14.00),
                    )),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          transitionAnimationController: AnimationController(
                            duration: const Duration(milliseconds: 1000),
                            vsync: Navigator.of(context),
                          ),
                          backgroundColor: Colors.white,
                          constraints: BoxConstraints.loose(Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height / 2.3)),
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            // <-- for border radius
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.link,
                                              color: Colors.grey,
                                            )),
                                        SizedBox(
                                          width: 30.0,
                                        ),
                                        Text(
                                          "Share Profile",
                                          style: commonTextStyle(
                                              Colors.black, FontWeight.bold, 14.00),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/profile/editProfile');
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10),
                                              child: Icon(Icons.edit,
                                                  color: Colors.grey)),
                                          SizedBox(
                                            width: 30.0,
                                          ),
                                          Text(
                                            "Edit profile",
                                            style: commonTextStyle(
                                                Colors.black, FontWeight.bold, 14.00),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    icon: Icon(Icons.more_vert_outlined))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: imageUrl != null
                                    ? CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(imageUrl!),
                                )
                                    : CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.grey,
                                  child: Icon(Icons.person,
                                      size: 40, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text( userData['name'] ??
                                      '9GAG',
                                    style: commonTextStyle(
                                        Colors.black, FontWeight.bold, 18.00),
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Container(
                                    child: Text(
                                      "PRO",
                                      style: commonTextStyle(
                                        Colors.white,
                                        FontWeight.bold,
                                        12.0,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5.0)),
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "0 days .",
                                    style: commonTextStyle(
                                        Colors.grey, FontWeight.bold, 14.00),
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    "1st day streak",
                                    style: commonTextStyle(
                                        Colors.grey, FontWeight.bold, 14.00),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        "My Funny Collection",
                        style:
                        commonTextStyle(Colors.black, FontWeight.bold, 14.00),
                      ),
                    ),
                    Divider(),
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      unselectedLabelColor: Colors.grey,
                      dividerColor: Colors.white,
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(text: 'Posts'),
                        Tab(text: 'Comments'),
                        Tab(text: 'Upvotes'),
                        Tab(text: 'Saved'),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      height: MediaQuery.sizeOf(context).height / 1.4,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Container(
                          //   color: Colors.white,
                          //   child: StreamBuilder<QuerySnapshot>(
                          //       stream: FirebaseFirestore.instance
                          //           .collection('posts')
                          //           .doc(FirebaseAuth.instance.currentUser!.uid)
                          //           .collection("posts")
                          //           .snapshots(),
                          //       builder: (context, snapshot) {
                          //         if (!snapshot.hasData) {
                          //           return Center(
                          //               child: CircularProgressIndicator());
                          //         }
                          //         List<DocumentSnapshot> docs = snapshot.data!.docs;
                          //         return docs.length == 0
                          //             ? Column(
                          //                 children: [
                          //                   Text(
                          //                     'No Posts',
                          //                     style: commonTextStyle(Colors.black,
                          //                         FontWeight.bold, 16.00),
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10.0,
                          //                   ),
                          //                   Text(
                          //                     "Let's make something creative for fun!",
                          //                     style: commonTextStyle(Colors.grey,
                          //                         FontWeight.bold, 14.00),
                          //                   ),
                          //                   SizedBox(
                          //                     height: 15.0,
                          //                   ),
                          //                   GestureDetector(
                          //                     onTap: () {
                          //                       showModalBottomSheet(
                          //                           transitionAnimationController:
                          //                               AnimationController(
                          //                             duration: const Duration(
                          //                                 milliseconds: 1000),
                          //                             vsync: Navigator.of(context),
                          //                           ),
                          //                           backgroundColor: Colors.white,
                          //                           constraints:
                          //                               BoxConstraints.loose(Size(
                          //                                   MediaQuery.of(context)
                          //                                       .size
                          //                                       .width,
                          //                                   MediaQuery.of(context)
                          //                                           .size
                          //                                           .height /
                          //                                       2.3)),
                          //                           context: context,
                          //                           isScrollControlled: true,
                          //                           shape: RoundedRectangleBorder(
                          //                             borderRadius:
                          //                                 BorderRadius.only(
                          //                               topLeft:
                          //                                   Radius.circular(0.0),
                          //                               topRight:
                          //                                   Radius.circular(0.0),
                          //                             ),
                          //                           ),
                          //                           builder:
                          //                               (BuildContext context) {
                          //                             return SingleChildScrollView(
                          //                               child: Column(
                          //                                 children: [
                          //                                   Container(
                          //                                     height: 100.0,
                          //                                     child: mediaList
                          //                                             .isEmpty
                          //                                         ? Center(
                          //                                             child:
                          //                                                 CircularProgressIndicator())
                          //                                         : ListView
                          //                                             .builder(
                          //                                             scrollDirection:
                          //                                                 Axis.horizontal,
                          //                                             itemCount:
                          //                                                 mediaList
                          //                                                     .length,
                          //                                             itemBuilder:
                          //                                                 (context,
                          //                                                     index) {
                          //                                               return FutureBuilder<
                          //                                                   Widget>(
                          //                                                 future: _buildMediaThumbnail(
                          //                                                     mediaList[
                          //                                                         index]),
                          //                                                 builder:
                          //                                                     (context,
                          //                                                         snapshot) {
                          //                                                   if (snapshot.connectionState ==
                          //                                                       ConnectionState.done) {
                          //                                                     return Container(
                          //                                                       margin:
                          //                                                           EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                          //                                                       child:
                          //                                                           snapshot.data,
                          //                                                     );
                          //                                                   } else {
                          //                                                     return Container(
                          //                                                       width:
                          //                                                           100.0,
                          //                                                       height:
                          //                                                           100.0,
                          //                                                       child:
                          //                                                           Center(child: CircularProgressIndicator()),
                          //                                                     );
                          //                                                   }
                          //                                                 },
                          //                                               );
                          //                                             },
                          //                                           ),
                          //                                   ),
                          //                                   SizedBox(
                          //                                     height: 20,
                          //                                   ),
                          //                                   GestureDetector(
                          //                                     onTap: _openCamera,
                          //                                     child: Container(
                          //                                       margin: EdgeInsets
                          //                                           .symmetric(
                          //                                               horizontal:
                          //                                                   10.0,
                          //                                               vertical:
                          //                                                   5.0),
                          //                                       width:
                          //                                           double.infinity,
                          //                                       child: Row(
                          //                                         children: [
                          //                                           Padding(
                          //                                               padding: const EdgeInsets
                          //                                                   .only(
                          //                                                   left:
                          //                                                       10),
                          //                                               child: Icon(
                          //                                                   Icons
                          //                                                       .camera_alt,
                          //                                                   color: Colors
                          //                                                       .grey)),
                          //                                           SizedBox(
                          //                                             width: 30.0,
                          //                                           ),
                          //                                           Text(
                          //                                             "Use Camera",
                          //                                             style:
                          //                                                 commonTextStyle(
                          //                                               Colors
                          //                                                   .black,
                          //                                               FontWeight
                          //                                                   .bold,
                          //                                               14.00,
                          //                                             ),
                          //                                           ),
                          //                                         ],
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //                                   SizedBox(
                          //                                     height: 20.0,
                          //                                   ),
                          //                                   GestureDetector(
                          //                                     onTap: _openGallery,
                          //                                     child: Container(
                          //                                       margin: EdgeInsets
                          //                                           .symmetric(
                          //                                               horizontal:
                          //                                                   10.0,
                          //                                               vertical:
                          //                                                   5.0),
                          //                                       width:
                          //                                           double.infinity,
                          //                                       child: Row(
                          //                                         children: [
                          //                                           Padding(
                          //                                               padding: const EdgeInsets
                          //                                                   .only(
                          //                                                   left:
                          //                                                       10),
                          //                                               child: Icon(
                          //                                                   Icons
                          //                                                       .image,
                          //                                                   color: Colors
                          //                                                       .grey)),
                          //                                           SizedBox(
                          //                                             width: 30.0,
                          //                                           ),
                          //                                           Text(
                          //                                             "Choose Form Gallery",
                          //                                             style:
                          //                                                 commonTextStyle(
                          //                                               Colors
                          //                                                   .black,
                          //                                               FontWeight
                          //                                                   .bold,
                          //                                               14.00,
                          //                                             ),
                          //                                           ),
                          //                                         ],
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //                                   SizedBox(
                          //                                     height: 20.0,
                          //                                   ),
                          //                                   GestureDetector(
                          //                                     onTap: () {
                          //                                       Navigator.pushNamed(context, '/createPostFormLink');
                          //                                     },
                          //                                     child: Container(
                          //                                       margin: EdgeInsets
                          //                                           .symmetric(
                          //                                               horizontal:
                          //                                                   10.0,
                          //                                               vertical:
                          //                                                   5.0),
                          //                                       width:
                          //                                           double.infinity,
                          //                                       child: Row(
                          //                                         children: [
                          //                                           Padding(
                          //                                               padding: const EdgeInsets
                          //                                                   .only(
                          //                                                   left:
                          //                                                       10),
                          //                                               child: Icon(
                          //                                                 Icons
                          //                                                     .link,
                          //                                                 color: Colors
                          //                                                     .grey,
                          //                                               )),
                          //                                           SizedBox(
                          //                                             width: 30.0,
                          //                                           ),
                          //                                           Text(
                          //                                             "Create Post Form Link",
                          //                                             style:
                          //                                                 commonTextStyle(
                          //                                               Colors
                          //                                                   .black,
                          //                                               FontWeight
                          //                                                   .bold,
                          //                                               14.00,
                          //                                             ),
                          //                                           ),
                          //                                         ],
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //                                   SizedBox(
                          //                                     height: 10.0,
                          //                                   ),
                          //                                 ],
                          //                               ),
                          //                             );
                          //                           });
                          //                     },
                          //                     child: Container(
                          //                       padding: EdgeInsets.symmetric(
                          //                           horizontal: 10.0,
                          //                           vertical: 5.0),
                          //                       width: 90.0,
                          //                       height: 40.0,
                          //                       decoration: BoxDecoration(
                          //                           color: Colors.indigo,
                          //                           borderRadius:
                          //                               BorderRadius.circular(5.0)),
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.center,
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment.center,
                          //                         children: [
                          //                           Icon(
                          //                             Icons.edit,
                          //                             color: Colors.white,
                          //                           ),
                          //                           Text(
                          //                             "Post",
                          //                             style: commonTextStyle(
                          //                                 Colors.white,
                          //                                 FontWeight.bold,
                          //                                 14.00),
                          //                           )
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   )
                          //                 ],
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.center,
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //               )
                          //             : ListView.builder(
                          //                 itemCount: docs.length,
                          //                 itemBuilder: (context, index) {
                          //                   Map<String, dynamic> data = docs[index]
                          //                       .data() as Map<String, dynamic>;
                          //                   return postCard(
                          //                     uid: data['id'],
                          //                     heading: data['postHeading'],
                          //                     subHeading: data['postSubHeading'],
                          //                     bottomScroll: data['postBottomScrollView'],
                          //                     videoURL: data['postVideoUrl'],
                          //                     likeCount: data['postLikeCount'],
                          //                     commentCount:
                          //                         data['postCommentCount'],
                          //                     postHours: data['postHoursCount'],
                          //                   );
                          //                   //   ListTile(
                          //                   //   title: Text(data['postHeading']),
                          //                   //   subtitle: Text(data['postSubHeading']),
                          //                   // );
                          //                 },
                          //               );
                          //       }),
                          // ),
                          FutureBuilder<List<PostModel>>(
                            future: fetchCurrentUserPost,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Column(
                                  children: [
                                    Text(
                                      'No Posts',
                                      style: commonTextStyle(Colors.black,
                                          FontWeight.bold, 16.00),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Let's make something creative for fun!",
                                      style: commonTextStyle(Colors.grey,
                                          FontWeight.bold, 14.00),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            transitionAnimationController:
                                            AnimationController(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              vsync: Navigator.of(context),
                                            ),
                                            backgroundColor: Colors.white,
                                            constraints:
                                            BoxConstraints.loose(Size(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    2.3)),
                                            context: context,
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.only(
                                                topLeft:
                                                Radius.circular(0.0),
                                                topRight:
                                                Radius.circular(0.0),
                                              ),
                                            ),
                                            builder:
                                                (BuildContext context) {
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 100.0,
                                                      child: mediaList
                                                          .isEmpty
                                                          ? Center(
                                                          child:
                                                          CircularProgressIndicator())
                                                          : ListView
                                                          .builder(
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                        itemCount:
                                                        mediaList
                                                            .length,
                                                        itemBuilder:
                                                            (context,
                                                            index) {
                                                          return FutureBuilder<
                                                              Widget>(
                                                            future: _buildMediaThumbnail(
                                                                mediaList[
                                                                index]),
                                                            builder:
                                                                (context,
                                                                snapshot) {
                                                              if (snapshot.connectionState ==
                                                                  ConnectionState.done) {
                                                                return Container(
                                                                  margin:
                                                                  EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                                                                  child:
                                                                  snapshot.data,
                                                                );
                                                              } else {
                                                                return Container(
                                                                  width:
                                                                  100.0,
                                                                  height:
                                                                  100.0,
                                                                  child:
                                                                  Center(child: CircularProgressIndicator()),
                                                                );
                                                              }
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    GestureDetector(
                                                      onTap: _openCamera,
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0,
                                                            vertical:
                                                            5.0),
                                                        width:
                                                        double.infinity,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left:
                                                                    10),
                                                                child: Icon(
                                                                    Icons
                                                                        .camera_alt,
                                                                    color: Colors
                                                                        .grey)),
                                                            SizedBox(
                                                              width: 30.0,
                                                            ),
                                                            Text(
                                                              "Use Camera",
                                                              style:
                                                              commonTextStyle(
                                                                Colors
                                                                    .black,
                                                                FontWeight
                                                                    .bold,
                                                                14.00,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    GestureDetector(
                                                      onTap: _openGallery,
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0,
                                                            vertical:
                                                            5.0),
                                                        width:
                                                        double.infinity,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left:
                                                                    10),
                                                                child: Icon(
                                                                    Icons
                                                                        .image,
                                                                    color: Colors
                                                                        .grey)),
                                                            SizedBox(
                                                              width: 30.0,
                                                            ),
                                                            Text(
                                                              "Choose Form Gallery",
                                                              style:
                                                              commonTextStyle(
                                                                Colors
                                                                    .black,
                                                                FontWeight
                                                                    .bold,
                                                                14.00,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(context, '/createPostFormLink');
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0,
                                                            vertical:
                                                            5.0),
                                                        width:
                                                        double.infinity,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left:
                                                                    10),
                                                                child: Icon(
                                                                  Icons
                                                                      .link,
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                            SizedBox(
                                                              width: 30.0,
                                                            ),
                                                            Text(
                                                              "Create Post Form Link",
                                                              style:
                                                              commonTextStyle(
                                                                Colors
                                                                    .black,
                                                                FontWeight
                                                                    .bold,
                                                                14.00,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 5.0),
                                        width: 90.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                            color: Colors.indigo,
                                            borderRadius:
                                            BorderRadius.circular(5.0)),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Post",
                                              style: commonTextStyle(
                                                  Colors.white,
                                                  FontWeight.bold,
                                                  14.00),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    PostModel post = snapshot.data![index];
                                    return postCard(
                                      uid: post.id,
                                      heading: post.postHeading,
                                      subHeading: post.postSubHeading,
                                      bottomScroll: post.tags,
                                      videoURL: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                                      likeCount: post.postLikeCount,
                                      commentCount:post.postCommentCount,
                                      postHours: post.postHoursCount,
                                    );
                                    //   postCard(
                                    //   // id: post.id,
                                    //   heading: post.postHeading,
                                    //   subHeading: post.postSubHeading,
                                    //   videoURL: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                                    //   bottomScroll: post.tags,
                                    //   likeCount: post.postLikeCount,
                                    //   commentCount: post.postCommentCount,
                                    //   postHours: post.postHoursCount,
                                    // );
                                  },
                                );
                              }
                            },
                          ),
                          Center(
                            child: Text("No commented posts"),
                          ),
                          Center(
                            child: Text("No upvoted posts"),
                          ),
                          Center(
                            child: Text("No saved posts"),
                          ),

                          // SavedTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Route _EditProfilePageRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const EditProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1000));
  }


  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(
      color: color,
      fontWeight: weight,
      fontSize: size,
    );
  }

  Future<Widget> _buildMediaThumbnail(AssetEntity asset) async {
    final thumbnail =
        await asset.thumbnailDataWithSize(ThumbnailSize(100, 100));
    if (asset.type == AssetType.video) {
      return Stack(
        children: [
          Image.memory(
            thumbnail!,
            fit: BoxFit.cover,
            width: 100,
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Icon(Icons.play_circle_outline, color: Colors.black),
          ),
        ],
      );
    } else {
      return Image.memory(
        thumbnail!,
        fit: BoxFit.cover,
        width: 100,
      );
    }
  }

  Widget postCard({
    required uid,
    required heading,
    required subHeading,
    required videoURL,
    required likeCount,
    required bottomScroll,
    required commentCount,
    required postHours,
  }) {
    return Container(
      child: Column(
        children: [
          postTitle(heading: heading, subHeading: subHeading, hours: postHours,id: uid),
          SizedBox(
            height: 5,
          ),
          // isLoggedIn ?
          // Image.network(videoURL,height: 300,width: MediaQuery.sizeOf(context).width,fit: BoxFit.fill,),
          // PostVideo(
          //   videoURL: videoURL,
          // ),
          postBottomScrollView(
            list: bottomScroll,
            listItem: bottomScroll,
          ),
          SizedBox(
            height: 5.0,
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

  Widget postTitle({
    required String heading,
    required String subHeading,
    required String hours,
    required id,
  }) {
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
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              transitionAnimationController:
                                  AnimationController(
                                duration: const Duration(milliseconds: 1000),
                                vsync: Navigator.of(context),
                              ),
                              backgroundColor: Colors.white,
                              constraints: BoxConstraints.loose(Size(
                                  MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height / 2.3)),
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                // <-- for border radius
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Delete Post'),
                                              content: Text('Are you sure you want to delete this post?'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () => Navigator.of(context).pop(),
                                                ),
                                                TextButton(
                                                  child: Text('Delete',style: TextStyle(color: Colors.red),),
                                                  onPressed: (){
                                                    FirebaseFirestore.instance
                                                        .collection('posts')
                                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                                        .collection("posts").doc(id).delete().then((onValue){
                                                      showToast(message: "Post Delete Successfully");
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ).then((onValue){
                                            Navigator.pop(context);
                                          });

                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                              SizedBox(
                                                width: 30.0,
                                              ),
                                              Text(
                                                "Delete Post",
                                                style: commonTextStyle(
                                                    Colors.red,
                                                    FontWeight.bold,
                                                    14.00),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Icon(Icons.close,
                                                      color: Colors.grey)),
                                              SizedBox(
                                                width: 30.0,
                                              ),
                                              Text(
                                                "Close",
                                                style: commonTextStyle(
                                                    Colors.black,
                                                    FontWeight.bold,
                                                    14.00),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 20,
                        ),
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
          Column(
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
        ],
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

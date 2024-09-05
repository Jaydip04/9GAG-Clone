import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gagclone/profile/edit_profile_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import '../create_post/create_post_form_link.dart';
import 'package:video_player/video_player.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  List<AssetEntity> mediaList = [];
  late TabController _tabController;
  bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;
  String? userName;
  String? profileName;
  @override
  void initState() {
    super.initState();
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
    listenToUserName();
    listenToProfileName();
    _fetchProfileImageUrl();
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _openCamera() async {
    final pickedFile  = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile  != null) {
      print('Picked image path: ${pickedFile.path}');
      setState(() {
        _image = File(pickedFile.path);
      });
      // Navigator.push(context, MaterialPageRoute(builder: (_) => CreatePost(imageFile: _image!,)));
    } else {
      print('No image selected.');
    }
  }

  Future<void> _openGallery() async {
    final pickedFile  = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('Picked image path: ${pickedFile.path}');
      setState(() {
        _image = File(pickedFile.path);
      });
      // Navigator.push(context, MaterialPageRoute(builder: (_) => CreatePost(imageFile: _image!,)));
    } else {
      print('No image selected.');
    }
  }

  String? imageUrl;
  Future<void> _fetchProfileImageUrl() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(
        'Profile Photo/${FirebaseAuth.instance.currentUser!.uid}/profile_photo');
    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        imageUrl = snapshot.value as String?;
      });
    } else {
      print('No image URL found');
    }
  }

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

  void listenToUserName() {
    if (isLoggedIn) {
      DatabaseReference reference = FirebaseDatabase.instance
          .ref("Profile")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("userName");
      reference.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        setState(() {
          userName = data as String?;
        });
      });
    } else {
      userName = "9GAG" as String?;
    }
  }
  void listenToProfileName() {
    if (isLoggedIn) {
      DatabaseReference reference = FirebaseDatabase.instance
          .ref("Profile")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("profileName");
      reference.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        setState(() {
          profileName = data as String?;
        });
      });
    } else {
      profileName = "9GAG" as String?;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          userName == null ? profileName.toString().toLowerCase().split(' ').reversed.join(' ') : userName.toString(),
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).push(_EditProfilePageRoute());
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => EditProfilePage()));
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
                                Navigator.of(context)
                                    .push(_EditProfilePageRoute());
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
      body: RefreshIndicator(
        onRefresh: _fetchProfileImageUrl,
        child: SingleChildScrollView(
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
                            child:  imageUrl != null
                                ? CircleAvatar(
                              radius: 35,
                              backgroundImage:
                              NetworkImage(imageUrl!),
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
                              Text(
                                profileName.toString(),
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
                    style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
                  ),
                ),
                Divider(),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                      Container(
                        color: Colors.white,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("posts")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }
                              List<DocumentSnapshot> docs = snapshot.data!.docs;
                              return docs.length == 0 ?
                              Column(
                                children: [
                                  Text(
                                    'No Posts',
                                    style: commonTextStyle(
                                        Colors.black, FontWeight.bold, 16.00),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Let's make something creative for fun!",
                                    style: commonTextStyle(
                                        Colors.grey, FontWeight.bold, 14.00),
                                  ),
                                  SizedBox(
                                    height: 15.0,
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
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(0.0),
                                            ),
                                          ),
                                          builder: (BuildContext context) {
                                            return SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 100.0,
                                                    child: mediaList.isEmpty
                                                        ? Center(
                                                        child:
                                                        CircularProgressIndicator())
                                                        : ListView.builder(
                                                      scrollDirection:
                                                      Axis.horizontal,
                                                      itemCount: mediaList.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return FutureBuilder<
                                                            Widget>(
                                                          future:
                                                          _buildMediaThumbnail(
                                                              mediaList[index]),
                                                          builder:
                                                              (context, snapshot) {
                                                            if (snapshot
                                                                .connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                              return Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    2.0,
                                                                    vertical:
                                                                    4.0),
                                                                child:
                                                                snapshot.data,
                                                              );
                                                            } else {
                                                              return Container(
                                                                width: 100.0,
                                                                height: 100.0,
                                                                child: Center(
                                                                    child:
                                                                    CircularProgressIndicator()),
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
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 5.0),
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                              padding:
                                                              const EdgeInsets.only(
                                                                  left: 10),
                                                              child: Icon(
                                                                  Icons.camera_alt,
                                                                  color: Colors.grey)),
                                                          SizedBox(
                                                            width: 30.0,
                                                          ),
                                                          Text(
                                                            "Use Camera",
                                                            style: commonTextStyle(
                                                              Colors.black,
                                                              FontWeight.bold,
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
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 5.0),
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                              padding:
                                                              const EdgeInsets.only(
                                                                  left: 10),
                                                              child: Icon(Icons.image,
                                                                  color: Colors.grey)),
                                                          SizedBox(
                                                            width: 30.0,
                                                          ),
                                                          Text(
                                                            "Choose Form Gallery",
                                                            style: commonTextStyle(
                                                              Colors.black,
                                                              FontWeight.bold,
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
                                                      Navigator.of(context).push(
                                                          _CreatePostFormLinkRoute());
                                                      // Navigator.pushReplacement(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             CreatePostFormLink()));
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 5.0),
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                              padding:
                                                              const EdgeInsets.only(
                                                                  left: 10),
                                                              child: Icon(
                                                                Icons.link,
                                                                color: Colors.grey,
                                                              )),
                                                          SizedBox(
                                                            width: 30.0,
                                                          ),
                                                          Text(
                                                            "Create Post Form Link",
                                                            style: commonTextStyle(
                                                              Colors.black,
                                                              FontWeight.bold,
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
                                          horizontal: 10.0, vertical: 5.0),
                                      width: 90.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo,
                                          borderRadius: BorderRadius.circular(5.0)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Post",
                                            style: commonTextStyle(
                                                Colors.white, FontWeight.bold, 14.00),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                              ) :
                                ListView.builder(
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data =
                                  docs[index].data() as Map<String, dynamic>;
                                  return Container(
                                    child: postCard(
                                      heading: data['postHeading'],
                                      subHeading: data['postSubHeading'],
                                      // bottomScroll: data['postBottomScrollView'],
                                      videoURL: data['postVideoUrl'],
                                      likeCount: data['postLikeCount'],
                                      commentCount: data['postCommentCount'],
                                      postHours: data['postHoursCount'],
                                    ),
                                  );
                                  //   ListTile(
                                  //   title: Text(data['postHeading']),
                                  //   subtitle: Text(data['postSubHeading']),
                                  // );
                                },
                              );
                            }),
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
      ),
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

  Route _CreatePostFormLinkRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CreatePostFormLink(),
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
          // Image.network(videoURL,height: 300,width: MediaQuery.sizeOf(context).width,fit: BoxFit.fill,),
          PostVideo(videoURL: videoURL,),
          // postBottomScrollView(
          //   list: bottomScroll,
          //   listItem: bottomScroll,
          // ),
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


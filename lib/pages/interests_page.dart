import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gagclone/common/post_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

import '../create_post/create_post_form_link.dart';
import '../tabs/ask_tab.dart';
import '../tabs/fresh_tab.dart';
import 'home_page.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({super.key});

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> with TickerProviderStateMixin{
  List<AssetEntity> mediaList = [];
  late TabController _tabController;
  List<String> scrollItem = [
    "stellar blade",
    "palworld",
    "diablo 4",
    "tears of the kingdom",
    "zelda",
    "pcmr",
    "warhammer",
    "resident evil",
    "stellar hogwarts legacy",
    "elden ring",
    "ps5",
    "xbox",
    "gts 5",
    "fifa 23",
    "genshin impact",
    "call of duty",
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this,initialIndex: 3);
    requestPermission().then((_) {
      fetchGalleryMedia().then((media) {
        setState(() {
          mediaList = media;
        });
      });
    });
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      print('Picked image path: ${image.path}');
    } else {
      print('No image selected.');
    }
  }

  Future<void> _openGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print('Picked image path: ${image.path}');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   iconTheme: IconThemeData(color: Colors.grey),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
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
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: mediaList.length,
                                itemBuilder: (context, index) {
                                  return FutureBuilder<Widget>(
                                    future:
                                        _buildMediaThumbnail(mediaList[index]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.0, vertical: 4.0),
                                          child: snapshot.data,
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
                              horizontal: 10.0, vertical: 5.0),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.camera_alt,
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
                              horizontal: 10.0, vertical: 5.0),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.image, color: Colors.grey)),
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreatePostFormLink()));
                        },
                        child: Container(
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
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: CupertinoColors.systemBlue,
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 120.00,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/profile/demo.png'), // Replace with your image path
                    fit: BoxFit.fill, // Cover the whole area
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.white,
                              constraints: BoxConstraints.loose(Size(
                                  MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height / 2.3)),
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                // <-- for border radius
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
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
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Icon(
                                                  Icons.link,
                                                  color: Colors.grey,
                                                )),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            Text(
                                              "Copy link",
                                              style: commonTextStyle(
                                                  Colors.black,
                                                  FontWeight.bold,
                                                  14.00),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  backgroundColor: Colors.white,
                                                  content: Container(
                                                    height: 108.0,
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width /
                                                        1.3,
                                                    child: Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Block Interest",
                                                                style:
                                                                    commonTextStyle(
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold,
                                                                  16.00,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 8.0,
                                                          ),
                                                          Container(
                                                            child: Center(
                                                                child: Text(
                                                              "You wll no longer see posts, comments or receive notification form the Latest News interest",
                                                              style:
                                                                  commonTextStyle(
                                                                Colors.black,
                                                                FontWeight.w500,
                                                                12.00,
                                                              ),
                                                            )),
                                                          ),
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style:
                                                                        commonTextStyle(
                                                                      Colors
                                                                          .indigo,
                                                                      FontWeight
                                                                          .bold,
                                                                      14.00,
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                width: 20.0,
                                                              ),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (_) =>
                                                                                HomePage()));
                                                                  },
                                                                  child: Text(
                                                                    "Hide",
                                                                    style:
                                                                        commonTextStyle(
                                                                      Colors
                                                                          .red,
                                                                      FontWeight
                                                                          .bold,
                                                                      14.00,
                                                                    ),
                                                                  ))
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
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
                                                  child: Icon(Icons.block,
                                                      color: Colors.grey)),
                                              SizedBox(
                                                width: 30.0,
                                              ),
                                              Text(
                                                "Block Interest",
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
                                        height: 20.0,
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Icon(Icons.feedback,
                                                    color: Colors.grey)),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            Text(
                                              "Send feedback",
                                              style: commonTextStyle(
                                                  Colors.black,
                                                  FontWeight.bold,
                                                  14.00),
                                            ),
                                          ],
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
                        icon: Icon(Icons.more_vert_outlined,color: Colors.white,))
                  ],
                ),
              ),
              Container(
                color: Colors.orangeAccent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.00),
                  child: Column(
                    children: [
                      SizedBox(height: 15.00),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.ac_unit_outlined,
                              color: Colors.orange.shade50,
                              size: 32.00,
                            ),
                          ),
                          SizedBox(
                            width: 15.00,
                          ),
                          Text(
                            "Gaming",
                            style: commonTextStyle(
                                Colors.orange.shade50, FontWeight.bold, 20.00),
                          )
                        ],
                      ),
                      SizedBox(height: 15.00,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Level up your gaming experience with news,",style: commonTextStyle(Colors.orange.shade50, FontWeight.bold, 14.00),),
                          Icon(Icons.chevron_right_outlined,color: Colors.orange.shade50,)
                        ],
                      ),
                      SizedBox(height: 15.00,),
                      postBottomScrollView(list: scrollItem, listItem: scrollItem,),
                      SizedBox(height: 15.00,),
                      Container(
                        width: double.infinity,
                        height: 40.00,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.all(Radius.circular(10.00))
                        ),
                        child: Center(child: Text("Follow",style: commonTextStyle(Colors.orangeAccent, FontWeight.bold, 14.00),)),
                      ),
                      SizedBox(height: 15.00,),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        margin: EdgeInsets.symmetric(horizontal: 60.0),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.orange.shade50,
                          labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade50),
                          unselectedLabelColor: Colors.orange.shade50,
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.orange.shade50,
                          labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          // labelPadding: EdgeInsets.symmetric(horizontal: 20.00), // Remove padding
                          // indicatorSize: TabBarIndicatorSize.label,
                          // indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(text: 'Ask'),
                            Tab(text: 'Hot'),
                            Tab(text: 'Fresh'),
                            Tab(text: 'About'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 730,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AskTab(),
                    PostPage(),
                    FreshTab(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.00,vertical: 15.00),
                      child: Text(
                        "Level up your gaming experience with news, reviews, and tips on your favorite games. From PC gaming to console gaming, discover the latest trends and updates in the world of gaming , as well as expert advice and strategies to help you become a better player.",
                        style:
                        commonTextStyle(
                          Colors.black,
                          FontWeight.bold,
                          16.00,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
}

class postBottomScrollView extends StatefulWidget {
  final List<String> list;
  final List<String> listItem;
  const postBottomScrollView({super.key,required this.list,required this.listItem});

  @override
  State<postBottomScrollView> createState() => _postBottomScrollViewState();
}

class _postBottomScrollViewState extends State<postBottomScrollView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 2.0),
            child: Container(
              child: Text(widget.listItem[index], style: commonTextStyle(Colors.orange.shade50, FontWeight.bold, 14.00),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.shade50, width: 1)),
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
      fontSize: size,);
  }
}

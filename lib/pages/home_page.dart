import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagclone/authentication/login_page.dart';
import 'package:gagclone/authentication/signup_page.dart';
import 'package:gagclone/create_post/create_post_form_link.dart';
import 'package:gagclone/pages/notification_page.dart';
import 'package:gagclone/pages/profile_page.dart';
import 'package:gagclone/pages/search_page.dart';
import 'package:gagclone/pages/setting%20_page.dart';
import 'package:gagclone/tabs/ask_tab.dart';
import 'package:gagclone/tabs/fresh_tab.dart';
import 'package:gagclone/tabs/home_tab.dart';
import 'package:gagclone/tabs/top_tab.dart';
import 'package:gagclone/tabs/trending_tab.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import '../bloc/drawer_bloc/drawer_bloc.dart';
import '../bloc/drawer_bloc/drawer_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<AssetEntity> mediaList = [];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Transform.translate(
            offset: Offset(-15.0, 0.0),
            child: Image.asset(
              "assets/logo/app_bar_logo.png",
              width: 50,
              height: 40,
            )),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            icon: Icon(
              Icons.search,
            ),
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
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 60.0),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "By continuing you agree to 9GAG's ",
                                    style: commonTextStyle(
                                        Colors.black.withOpacity(0.4),
                                        FontWeight.bold,
                                        12.0,
                                        null),
                                  ),
                                  TextSpan(
                                    text: 'Terms of Services ',
                                    style: commonTextStyle(
                                        Colors.black.withOpacity(0.5),
                                        FontWeight.bold,
                                        12.0,
                                        TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                  TextSpan(
                                    text:
                                        "and acknowledge that you've read our ",
                                    style: commonTextStyle(
                                        Colors.black.withOpacity(0.4),
                                        FontWeight.bold,
                                        12.0,
                                        null),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: commonTextStyle(
                                        Colors.black.withOpacity(0.5),
                                        FontWeight.bold,
                                        12.0,
                                        TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5.0),
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Image.asset(
                                    "assets/logo/facebook.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "Continue with Facebook",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.0, null),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5.0),
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Image.asset(
                                    "assets/logo/google.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 55,
                                ),
                                Text(
                                  "Continue with Google",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.0, null),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5.0),
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Image.asset(
                                    "assets/logo/apple.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  "Continue with Apple",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.0, null),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 5.0),
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(26),
                              ),
                              child: Center(
                                child: Text(
                                  "Use email",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.0, null),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 5.0),
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(26),
                              ),
                              child: Center(
                                child: Text(
                                  "Notifications",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.0, null),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationPage()));
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 60.0),
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Already a number? ",
                                      style: commonTextStyle(Colors.black,
                                          FontWeight.bold, 14.0, null),
                                    ),
                                    TextSpan(
                                      text: 'Log in',
                                      style: commonTextStyle(Colors.black,
                                          FontWeight.bold, 14.0, null),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(
              Icons.notifications,
            ),
          ),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  constraints: BoxConstraints.loose(Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height / 2.5)),
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        constraints: BoxConstraints.loose(Size(
                                            MediaQuery.of(context).size.width,
                                            MediaQuery.of(context).size.height /
                                                2.3)),
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
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
                                                  height: 30,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 60.0),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              "By continuing you agree to 9GAG's ",
                                                          style: commonTextStyle(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.4),
                                                              FontWeight.bold,
                                                              12.0,
                                                              null),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              'Terms of Services ',
                                                          style: commonTextStyle(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.5),
                                                              FontWeight.bold,
                                                              12.0,
                                                              TextDecoration
                                                                  .underline),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {},
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "and acknowledge that you've read our ",
                                                          style: commonTextStyle(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.4),
                                                              FontWeight.bold,
                                                              12.0,
                                                              null),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              'Privacy Policy',
                                                          style: commonTextStyle(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.5),
                                                              FontWeight.bold,
                                                              12.0,
                                                              TextDecoration
                                                                  .underline),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {},
                                                        ),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 30.0,
                                                      vertical: 5.0),
                                                  width: double.infinity,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Image.asset(
                                                          "assets/logo/facebook.png",
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Text(
                                                        "Continue with Facebook",
                                                        style: commonTextStyle(
                                                            Colors.black,
                                                            FontWeight.bold,
                                                            16.0,
                                                            null),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 30.0,
                                                      vertical: 5.0),
                                                  width: double.infinity,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Image.asset(
                                                          "assets/logo/google.png",
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 55,
                                                      ),
                                                      Text(
                                                        "Continue with Google",
                                                        style: commonTextStyle(
                                                            Colors.black,
                                                            FontWeight.bold,
                                                            16.0,
                                                            null),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 30.0,
                                                      vertical: 5.0),
                                                  width: double.infinity,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Image.asset(
                                                          "assets/logo/apple.png",
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 60,
                                                      ),
                                                      Text(
                                                        "Continue with Apple",
                                                        style: commonTextStyle(
                                                            Colors.black,
                                                            FontWeight.bold,
                                                            16.0,
                                                            null),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SignupPage()));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30.0,
                                                            vertical: 5.0),
                                                    width: double.infinity,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              26),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Use email",
                                                        style: commonTextStyle(
                                                            Colors.black,
                                                            FontWeight.bold,
                                                            16.0,
                                                            null),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfilePage()));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30.0,
                                                            vertical: 5.0),
                                                    width: double.infinity,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              26),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Edit Profile",
                                                        style: commonTextStyle(
                                                            Colors.black,
                                                            FontWeight.bold,
                                                            16.0,
                                                            null),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30.0,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginPage()));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 60.0),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                "Already a number? ",
                                                            style:
                                                                commonTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    14.0,
                                                                    null),
                                                          ),
                                                          TextSpan(
                                                            text: 'Log in',
                                                            style:
                                                                commonTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    14.0,
                                                                    null),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap =
                                                                      () {},
                                                          ),
                                                        ],
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  child: Image.asset(
                                                    "assets/logo/app_logo.png",
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Text(
                                                  "GenixBit",
                                                  style: commonTextStyle(
                                                      Colors.black,
                                                      FontWeight.bold,
                                                      16.0,
                                                      null),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              child: Text(
                                                "PRO",
                                                style: commonTextStyle(
                                                    Colors.white,
                                                    FontWeight.bold,
                                                    14.0,
                                                    null),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        constraints: BoxConstraints.loose(Size(
                                            MediaQuery.of(context).size.width,
                                            MediaQuery.of(context).size.height /
                                                2.3)),
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
                                                  height: 30,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 60.0),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              "By continuing you agree to 9GAG's ",
                                                          style: commonTextStyle(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.4),
                                                              FontWeight.bold,
                                                              12.0,
                                                              null),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              'Terms of Services ',
                                                          style: commonTextStyle(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.5),
                                                              FontWeight.bold,
                                                              12.0,
                                                              TextDecoration
                                                                  .underline),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {},
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "and acknowledge that you've read our ",
                                                          style: commonTextStyle(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.4),
                                                              FontWeight.bold,
                                                              12.0,
                                                              null),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              'Privacy Policy',
                                                          style: commonTextStyle(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.5),
                                                              FontWeight.bold,
                                                              12.0,
                                                              TextDecoration
                                                                  .underline),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {},
                                                        ),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 30.0,
                                                      vertical: 5.0),
                                                  width: double.infinity,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Image.asset(
                                                          "assets/logo/facebook.png",
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Text(
                                                        "Continue with Facebook",
                                                        style: commonTextStyle(
                                                            Colors.black,
                                                            FontWeight.bold,
                                                            16.0,
                                                            null),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 30.0,
                                                      vertical: 5.0),
                                                  width: double.infinity,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Image.asset(
                                                          "assets/logo/google.png",
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 55,
                                                      ),
                                                      Text(
                                                        "Continue with Google",
                                                        style: commonTextStyle(
                                                            Colors.black,
                                                            FontWeight.bold,
                                                            16.0,
                                                            null),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 30.0,
                                                      vertical: 5.0),
                                                  width: double.infinity,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Image.asset(
                                                          "assets/logo/apple.png",
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 60,
                                                      ),
                                                      Text(
                                                        "Continue with Apple",
                                                        style: commonTextStyle(
                                                            Colors.black,
                                                            FontWeight.bold,
                                                            16.0,
                                                            null),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 30.0,
                                                      vertical: 5.0),
                                                  width: double.infinity,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Use email",
                                                      style: commonTextStyle(
                                                          Colors.black,
                                                          FontWeight.bold,
                                                          16.0,
                                                          null),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30.0,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 60.0),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              "Already a number? ",
                                                          style:
                                                              commonTextStyle(
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold,
                                                                  14.0,
                                                                  null),
                                                        ),
                                                        TextSpan(
                                                          text: 'Log in',
                                                          style:
                                                              commonTextStyle(
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold,
                                                                  14.0,
                                                                  null),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {},
                                                        ),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.bookmarks,
                                                size: 25,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 35,
                                              ),
                                              Text(
                                                "Saved",
                                                style: commonTextStyle(
                                                    Colors.black,
                                                    FontWeight.bold,
                                                    16.0,
                                                    null),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SettingPage()));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.settings,
                                                size: 25,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                "Setting",
                                                style: commonTextStyle(
                                                    Colors.black,
                                                    FontWeight.bold,
                                                    16.0,
                                                    null),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.feedback,
                                              size: 25,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 35,
                                            ),
                                            Text(
                                              "Send feedback",
                                              style: commonTextStyle(
                                                  Colors.black,
                                                  FontWeight.bold,
                                                  16.0,
                                                  null),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.dark_mode,
                                              size: 25,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              "Dark Mode",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: ClipRRect(
                child: ClipRRect(
                  child: Image.asset(
                    "assets/logo/app_logo.png",
                    width: 26,
                    height: 26,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ))
        ],
      ),
      drawer: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: Drawer(
                width: MediaQuery.sizeOf(context).width / 1.45,
                child: ListView(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: SafeArea(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color:
                                              Colors.grey.withOpacity(0.2)))),
                              child: const ListTile(
                                title: Text('Home'),
                                leading: Icon(Icons.home),
                              ),
                            ),
                            Container(
                              child: const ListTile(
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text(
                                  'Interests',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                            commonListTile("Anime & Manga", Icons.ac_unit,
                                Colors.yellow, Colors.red),
                            commonListTile("Latest News", Icons.ac_unit,
                                Colors.green, Colors.yellow),
                            commonListTile("Humor", Icons.ac_unit,
                                Colors.deepPurple, Colors.yellow),
                            commonListTile("Memes", Icons.ac_unit,
                                Colors.deepPurpleAccent, Colors.yellow),
                            commonListTile("Gaming", Icons.ac_unit,
                                Colors.orange, Colors.yellow),
                            commonListTile("WTF", Icons.ac_unit,
                                Colors.lightGreen, Colors.yellow),
                            commonListTile(
                                "Relationship & Dating",
                                Icons.ac_unit,
                                Colors.pinkAccent,
                                Colors.yellow),
                            commonListTile("Animals & Pets", Icons.ac_unit,
                                Colors.deepPurple, Colors.yellow),
                            commonListTile("Science & Tech", Icons.ac_unit,
                                Colors.red, Colors.yellow),
                            commonListTile("Comic", Icons.ac_unit, Colors.pink,
                                Colors.yellow),
                            commonListTile("Wholesome", Icons.ac_unit,
                                Colors.yellowAccent, Colors.red),
                            commonListTile("Sports", Icons.ac_unit,
                                Colors.redAccent, Colors.yellow),
                            commonListTile("Movies & TV", Icons.ac_unit,
                                Colors.greenAccent, Colors.yellow),
                            commonListTile("Cat", Icons.ac_unit,
                                Colors.orangeAccent, Colors.yellow),
                            commonListTile("Food & Drinks", Icons.ac_unit,
                                Colors.red, Colors.yellow),
                            commonListTile("Lifestyle", Icons.ac_unit,
                                Colors.blueAccent, Colors.yellow),
                            commonListTile("Superhero", Icons.ac_unit,
                                Colors.red, Colors.yellow),
                            commonListTile("Crypto", Icons.ac_unit, Colors.blue,
                                Colors.yellow),
                            commonListTile("Random", Icons.ac_unit, Colors.pink,
                                Colors.yellow),
                            commonListTile("Woah", Icons.ac_unit, Colors.orange,
                                Colors.yellow),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          );
        },
      ),
      body: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is DrawerMenuSelected) {
            if (state.selectMenuItem == 'Home') {
              return const Center(child: Text('Home Screen'));
            } else if (state.selectMenuItem == 'Settings') {
              return const Center(child: Text('Settings Screen'));
            }
          }
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                      width: MediaQuery.sizeOf(context).width,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TabBar(
                        // isScrollable: true,
                        // padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        controller: _tabController,
                        labelColor: Colors.black,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        unselectedLabelColor: Colors.grey,
                        dividerColor: Colors.white,
                        indicatorColor: Colors.black,
                        labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        // indicatorSize: TabBarIndicatorSize.tab,
                        tabs: const [
                          Tab(
                            text: "Ask",
                          ),
                          Tab(
                            text: "Home",
                          ),
                          Tab(
                            text: "Top",
                          ),
                          Tab(
                            text: "Trending",
                          ),
                          Tab(
                            text: "Fresh",
                          ),
                        ],
                      )),
                  Container(
                    height: 730,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        AskTab(),
                        HomeTab(),
                        TopTab(),
                        TrendingTab(),
                        FreshTab()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 60.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "By continuing you agree to 9GAG's ",
                                style: commonTextStyle(
                                    Colors.black.withOpacity(0.4),
                                    FontWeight.bold,
                                    12.0,
                                    null),
                              ),
                              TextSpan(
                                text: 'Terms of Services ',
                                style: commonTextStyle(
                                    Colors.black.withOpacity(0.5),
                                    FontWeight.bold,
                                    12.0,
                                    TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text: "and acknowledge that you've read our ",
                                style: commonTextStyle(
                                    Colors.black.withOpacity(0.4),
                                    FontWeight.bold,
                                    12.0,
                                    null),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: commonTextStyle(
                                    Colors.black.withOpacity(0.5),
                                    FontWeight.bold,
                                    12.0,
                                    TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 5.0),
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                "assets/logo/facebook.png",
                                width: 24,
                                height: 24,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              "Continue with Facebook",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.0, null),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 5.0),
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                "assets/logo/google.png",
                                width: 24,
                                height: 24,
                              ),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "Continue with Google",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.0, null),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 5.0),
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                "assets/logo/apple.png",
                                width: 24,
                                height: 24,
                              ),
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              "Continue with Apple",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.0, null),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5.0),
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Center(
                            child: Text(
                              "Use email",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.0, null),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
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
                                              future: _buildMediaThumbnail(mediaList[index]),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.done) {
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 2.0,vertical: 4.0),
                                                    child: snapshot.data,
                                                  );
                                                } else {
                                                  return Container(
                                                    width: 100.0,
                                                    height: 100.0,
                                                    child: Center(child: CircularProgressIndicator()),
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
                                        onTap:_openCamera,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10),
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
                                                    null),
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
                                                  padding: const EdgeInsets.only(
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
                                                    null),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      GestureDetector(
                                        onTap: (){
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
                                                "Create Post Form Link",
                                                style: commonTextStyle(
                                                    Colors.black,
                                                    FontWeight.bold,
                                                    14.00,
                                                    null),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5.0),
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Center(
                            child: Text(
                              "Add Post",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.0, null),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 60.0),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Already a number? ",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 14.0, null),
                                ),
                                TextSpan(
                                  text: 'Log in',
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 14.0, null),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
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
    );
  }

  TextStyle commonTextStyle(color, weight, size, decoration) {
    return TextStyle(
        color: color,
        fontWeight: weight,
        fontSize: size,
        decoration: decoration);
  }

  ListTile commonListTile(name, icon, color, iconColor) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      title: Text(
        name,
        style: commonTextStyle(Colors.black, FontWeight.bold, 14.0, null),
      ),
      leading: Container(
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5.00)),
        child: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
      trailing: const Icon(
        CupertinoIcons.pin,
        size: 20,
      ),
      // selected: state is DrawerMenuSelected && state.selectMenuItem == 'Home',
      // onTap: () {
      //   context.read<DrawerBloc>().add(const SelectMenuItem('Home'));
      //   Navigator.pop(context); // Close the drawer
      // },
    );
  }

  Future<Widget> _buildMediaThumbnail(AssetEntity asset) async {
    final thumbnail = await asset.thumbnailDataWithSize(ThumbnailSize(100, 100));
    if (asset.type == AssetType.video) {
      return Stack(
        children: [
          Image.memory(thumbnail!, fit: BoxFit.cover,width: 100,),
          Positioned(
            bottom: 5,
            right: 5,
            child: Icon(Icons.play_circle_outline, color: Colors.black),
          ),
        ],
      );
    } else {
      return Image.memory(thumbnail!,fit: BoxFit.cover,width: 100,);
    }
  }
}

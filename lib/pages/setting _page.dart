import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import '../common/toast.dart';
import '../services/authService.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _switchValue = false;

  final AuthService _authService = AuthService();

  final storage = FlutterSecureStorage();

  void _deleteAccount(BuildContext context) async {
    await _authService.deleteUser();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.grey,
            size: 22,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "General",
                      style: commonTextStyle(
                          Colors.grey, FontWeight.bold, 18.00, null),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Hide ads",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  CupertinoIcons.lock_fill,
                                  color: Colors.grey,
                                  size: 18.00,
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Hide promoted posts",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  CupertinoIcons.lock_fill,
                                  color: Colors.grey,
                                  size: 18.00,
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Show 'New Post' bubble",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  CupertinoIcons.lock_fill,
                                  color: Colors.grey,
                                  size: 18.00,
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Display",
                      style: commonTextStyle(
                          Colors.grey, FontWeight.bold, 18.00, null),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dark Mode",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Hide promoted posts",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  CupertinoIcons.lock_fill,
                                  color: Colors.grey,
                                  size: 18.00,
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contents you see",
                      style: commonTextStyle(
                          Colors.grey, FontWeight.bold, 18.00, null),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Adult content",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.00, null),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Safe browsing mode",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.00, null),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Hide offensive comments",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.00, null),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account",
                      style: commonTextStyle(
                          Colors.grey, FontWeight.bold, 18.00, null),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit profile",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Change password",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Linked account",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Push notification",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Privacy setting",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "General",
                      style: commonTextStyle(
                          Colors.grey, FontWeight.bold, 18.00, null),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Autoplay GIF's",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Always",
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.bold, 14.00, null),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Autoplay videos",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Always",
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.bold, 14.00, null),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Load GIF previews",
                                  style: commonTextStyle(Colors.grey,
                                      FontWeight.bold, 16.00, null),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  CupertinoIcons.lock_fill,
                                  color: Colors.grey,
                                  size: 18.00,
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Load video previews",
                                  style: commonTextStyle(Colors.grey,
                                      FontWeight.bold, 16.00, null),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  CupertinoIcons.lock_fill,
                                  color: Colors.grey,
                                  size: 18.00,
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Autoload HD images",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  CupertinoIcons.lock_fill,
                                  color: Colors.grey,
                                  size: 18.00,
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Always",
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.bold, 14.00, null),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Advanced",
                      style: commonTextStyle(
                          Colors.grey, FontWeight.bold, 18.00, null),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Expand long post",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.00, null),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Rotation lock",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Scroll with volume keys",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Language",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "9GAG uses your device's language",
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.bold, 14.00, null),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Clear cache",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "12.39 MB",
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.bold, 14.00, null),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Maximum cache size",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "128 MB",
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.bold, 14.00, null),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Check your network",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 16.00, null),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: commonTextStyle(
                          Colors.grey, FontWeight.bold, 18.00, null),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Help center",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Send feedback",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Share 9GAG",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Like us on Facebook",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Follow us on Twitter",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Copyright",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Privacy policy",
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00, null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "App version",
                                  style: commonTextStyle(Colors.black,
                                      FontWeight.bold, 16.00, null),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "8.10.62",
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.bold, 14.00, null),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.2),
                thickness: 15.00,
              ),
              GestureDetector(
                onTap: () async {
                  bool isLoggedIn = await _authService.isLoggedIn();
                  if (isLoggedIn) {
                    showCupertinoDialog(
                      context: context,
                      // barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Sign Out?",
                          style: commonTextStyletitle(),
                        ),
                        content: Text(
                          "Are You Sure?",
                          style: commonTextStyle16(),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo,
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width / 4,
                                        40)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: commonTextStyle18(),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width / 4,
                                        40)),
                                onPressed: () {
                                  _deleteAccount(context);
                                },
                                child: Text("Sign Out",
                                    style: commonTextStyle18()),
                              ),
                            ],
                          )
                        ],
                        elevation: 24.0,
                        backgroundColor: Colors.white,
                      ),
                    );
                  } else {
                    showToast(message: "No User available");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sign Out",
                        style: commonTextStyle(
                            Colors.red, FontWeight.bold, 16.00, null),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.00,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.2),
                thickness: 45.00,
              ),
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

  TextStyle commonTextStyletitle() {
    return TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);
  }

  TextStyle commonTextStyle18() {
    return TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
  }

  TextStyle commonTextStyle16() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }
}

class Thank_you extends StatefulWidget {
  const Thank_you({super.key});

  @override
  State<Thank_you> createState() => _Thank_youState();
}

class _Thank_youState extends State<Thank_you> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Lottie.asset("assets/lottie_file/login.json"),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../common/toast.dart';
import '../services/authService.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _switchValue = false;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerCollection =
      TextEditingController(text: 'My Funny Collection');
  TextEditingController _controllerGender =
      TextEditingController(text: "Unspecified");
  TextEditingController _controllerDate =
      TextEditingController(text: "Birthday");
  bool _isButtonEnabled = false;
  // bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;
  String? userName;
  String? userEmail;
  String? profileName;
  String? birthday;
  DatabaseReference reference = FirebaseDatabase.instance.ref("Profile");
  bool _isLoading = false;

  final AuthService _authService = AuthService();
  Future<Map<String, dynamic>?>? _userData;
  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
    _controllerName.addListener(() {
      setState(() {
        _isButtonEnabled = _controllerName.text.isNotEmpty;
      });
    });
    // listenToUserEmail();
    // listenToUserName();
    // listenToProfileName();
    // _fetchProfileImageUrl();
    // listenToBirthday();
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    await Future.delayed(Duration(seconds: 1));
    String? token = await _authService.getToken();
    if (token == null) {
      return {};
    } else {
      String? token = await _authService.getToken();
      print(token);
      final userData = await _authService.getUserData(token!);
      setState(() {
        _controllerName.text = userData!['username'];
        _controllerEmail.text = userData['email'];
        userData['BOD'] == null
            ? _controllerDate.text = "Birthday"
            : _controllerDate.text = userData['BOD'];
        userData['gender'] == null
            ? _controllerGender.text = "Unspecified"
            : _controllerGender.text = userData['gender'];
      });
      return {
        'name': userData!['username'],
        'email': userData['email'],
        'id': userData['_id'],
        // 'profilePhoto': userData['profilePhoto'],
      };
    }
  }

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  // Future _uploadImage() async {
  //   if (_imageFile != null) {
  //     try {
  //       await _authService.uploadProfilePhoto(_imageFile!);
  //       Navigator.pop(context);
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload successful')));
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed')));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image and enter a name')));
  //   }
  // }
  // Future<void> _uploadImage() async {
  //   if (_imageFile == null) return;
  //
  //   String fileName = _imageFile!.path;
  //   Reference ref =
  //       FirebaseStorage.instance.ref().child("profile_photos/$fileName");
  //
  //   try {
  //     UploadTask uploadTask = ref.putFile(_imageFile!);
  //     TaskSnapshot snapshot = await uploadTask;
  //     String downloadUrl = await snapshot.ref.getDownloadURL();
  //
  //     await FirebaseDatabase.instance
  //         .ref(
  //             'Profile Photo/${FirebaseAuth.instance.currentUser!.uid}/profile_photo')
  //         .set(downloadUrl)
  //         .then((_) {
  //       // _isLoading = false;
  //       showToast(message: "Upload successful");
  //       Navigator.pop(context);
  //       print("Upload successful, URL: $downloadUrl");
  //     });
  //   } catch (e) {
  //     print("Failed to upload image: $e");
  //   }
  // }

  String? imageUrl;
  // void _fetchProfileImageUrl() async {
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

  void listenToProfileName() async {
    bool isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      DatabaseReference reference = FirebaseDatabase.instance
          .ref("Profile")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("profileName");
      reference.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        setState(() {
          profileName = data as String?;
          _controllerName.text = profileName.toString();
        });
      });
    } else {
      profileName = "9GAG" as String?;
    }
  }

  void listenToBirthday() async {
    bool isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      DatabaseReference reference = FirebaseDatabase.instance
          .ref("Profile")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("birthday");
      reference.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        setState(() {
          birthday = data as String?;
          _controllerDate.text = birthday.toString();
        });
      });
    } else {
      birthday = "9GAG" as String?;
    }
  }

  void listenToUserName() async {
    bool isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      DatabaseReference reference = FirebaseDatabase.instance
          .ref("Profile")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("userName");
      reference.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        setState(() {
          userName = data as String?;
          _controllerEmail.text =
              userName.toString().isEmpty ? "Empty" : userName.toString();
        });
      });
    } else {
      userName = "9GAG" as String?;
    }
  }

  void listenToUserEmail() async {
    bool isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      DatabaseReference reference = FirebaseDatabase.instance
          .ref("Profile")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("email");
      reference.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        setState(() {
          userEmail = data as String?;
        });
      });
    } else {
      userEmail = "9GAG" as String?;
    }
  }

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
              child: Text(
                'Error loading user data',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.00,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'No user data available',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.00,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
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
                title: Text(
                  "Edit profile",
                  style: commonTextStyle(Colors.black, FontWeight.bold, 18.00),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        print(userEmail);
                        String username = _controllerName.text;
                        String email = _controllerEmail.text;
                        final String date = DateTime.now().toString();
                        String BOD =
                            _controllerDate.text.toString() == "Birthday"
                                ? "$date"
                                : _controllerDate.text.toString();
                        String gender =
                            _controllerGender.text.toString() == "Unspecified"
                                ? ""
                                : _controllerGender.text.toString();
                        print(userData['id']);
                        if(_imageFile == null){
                          _isLoading = false;
                          showToast(message: "Please pick the image");
                        }else{
                          _isLoading = true;
                          final result = await _authService.updateProfile(
                              userData['id'],
                              username,
                              email,
                              BOD,
                              date,
                              gender,
                              _imageFile!);

                          if (result != null) {
                            showToast(message: "Profile Updated.");
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (route) => false);
                          } else {
                            showToast(message: "something wrong");
                          }
                        }

                        // if (username.isEmpty) {
                        //   showToast(message: "User Name is empty");
                        // } else if (email.isEmpty) {
                        //   showToast(message: "Email is empty");
                        // } else {
                        //   Map<String, dynamic> userProfile = {
                        //     "profileName": _controllerName.text.toString(),
                        //     "userName": _controllerEmail.text.toString() == "null"
                        //         ? _controllerName.text.toString()
                        //         : _controllerEmail.text.toString(),
                        //     "email": userEmail,
                        //     "birthday" : _controllerDate.text.toString() == "Birthday" ? "$date" : _controllerDate.text.toString(),
                        //     "uid": FirebaseAuth.instance.currentUser!.uid,
                        //     "Date": date,
                        //   };
                        //   reference
                        //       .child(FirebaseAuth.instance.currentUser!.uid)
                        //       .set(userProfile)
                        //       .then((_) {
                        //     setState(() {
                        //       _isLoading = false;
                        //     });
                        //     showToast(message: "Saved");
                        //     Navigator.pop(context);
                        //   }).catchError((error) {
                        //     showToast(message: "Some error happend");
                        //   });
                        // }
                      },
                      child: Text(
                        "Save",
                        style: commonTextStyle(
                            Colors.black, FontWeight.bold, 14.00),
                      )),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: _isLoading
                      ? Container(
                          height: MediaQuery.sizeOf(context).height,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 4.0,
                          )),
                        )
                      : Column(
                          children: [
                            Divider(
                              color: Colors.grey.withOpacity(0.1),
                              thickness: 15.0,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    // barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        backgroundColor: Colors.white,
                                        content: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  1.3,
                                          height: 152.0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: Text(
                                                  "Remove Current profile pic",
                                                  style: commonTextStyle(
                                                      Colors.black,
                                                      FontWeight.bold,
                                                      14.00),
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          backgroundColor:
                                                              Colors.white,
                                                          content: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width /
                                                                1.3,
                                                            height: 111.0,
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
                                                                      "Sure to be a faceless?",
                                                                      style: commonTextStyle(
                                                                          Colors
                                                                              .black,
                                                                          FontWeight
                                                                              .w500,
                                                                          14.00),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 40.0,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Cancel",
                                                                          style: commonTextStyle(
                                                                              Colors.indigo,
                                                                              FontWeight.bold,
                                                                              14.00),
                                                                        )),
                                                                    SizedBox(
                                                                      width:
                                                                          20.0,
                                                                    ),
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Discard",
                                                                          style: commonTextStyle(
                                                                              Colors.indigo,
                                                                              FontWeight.bold,
                                                                              14.00),
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
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _pickImage(
                                                      ImageSource.camera);
                                                },
                                                child: Text(
                                                  "Take a photo",
                                                  style: commonTextStyle(
                                                      Colors.black,
                                                      FontWeight.bold,
                                                      14.00),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  _pickImage(
                                                      ImageSource.gallery);
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                },
                                                child: Text(
                                                  "Choose from gallery",
                                                  style: commonTextStyle(
                                                      Colors.black,
                                                      FontWeight.bold,
                                                      14.00),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Surprise me!",
                                                  style: commonTextStyle(
                                                      Colors.black,
                                                      FontWeight.bold,
                                                      14.00),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    child: Icon(Icons.person,
                                                        size: 30,
                                                        color: Colors.white),
                                                  ),
                                        // _imageFile != null
                                        //     ? Image.file(
                                        //         _imageFile!,
                                        //         width: 30,
                                        //         height: 30,
                                        //         fit: BoxFit.fill,
                                        //       )
                                        //     : imageUrl != null
                                        //         ?  userData['profilePhoto'] != null
                                        //     ? Image.network('http://192.168.171.52:5000/${userData['profilePhoto']}')
                                        //     : Placeholder(fallbackHeight: 200.0, fallbackWidth: double.infinity)
                                        // // CircleAvatar(
                                        // //             radius: 17,
                                        // //             backgroundImage:NetworkImage(userData['profilePhoto']),
                                        // //           )
                                        //         : CircleAvatar(
                                        //             radius: 18,
                                        //             backgroundColor:
                                        //                 Colors.grey,
                                        //             child: Icon(Icons.person,
                                        //                 size: 30,
                                        //                 color: Colors.white),
                                        //           ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.00,
                                    ),
                                    Text(
                                      "Change profile picture",
                                      style: commonTextStyle(
                                          Colors.black, FontWeight.bold, 16.00),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Icon(
                                      Icons.credit_card_rounded,
                                      color: Colors.grey,
                                      size: 26.00,
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.2,
                                    child: TextField(
                                      style: commonTextStyle(
                                          Colors.black, FontWeight.bold, 16.00),
                                      cursorColor: Colors.indigo,
                                      controller: _controllerName,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Icon(
                                      CupertinoIcons.person_crop_square_fill,
                                      color: Colors.grey,
                                      size: 26.00,
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.2,
                                    child: TextField(
                                      readOnly: true,
                                      style: commonTextStyle(
                                          Colors.black, FontWeight.bold, 16.00),
                                      cursorColor: Colors.indigo,
                                      controller: _controllerEmail,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.emoji_emotions_outlined,
                                      color: Colors.grey,
                                      size: 26.00,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.00,
                                  ),
                                  Text(
                                    "None",
                                    style: commonTextStyle(
                                        Colors.black, FontWeight.bold, 16.00),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.home,
                                      color: Colors.grey,
                                      size: 26.00,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.00,
                                  ),
                                  Text(
                                    "India",
                                    style: commonTextStyle(
                                        Colors.black, FontWeight.bold, 16.00),
                                  ),
                                  SizedBox(
                                    width: 5.00,
                                  ),
                                  Image.asset(
                                    "assets/profile/india_flag.png",
                                    height: 22.00,
                                    width: 22.00,
                                  )
                                ],
                              ),
                            ),
                            // GestureDetector(
                            //
                            //
                            //   child: Container(
                            //     color: Colors.white,
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //           horizontal: 10.0, vertical: 5.0),
                            //       child: Row(
                            //         children: [
                            //           Padding(
                            //               padding: const EdgeInsets.all(8.0),
                            //               child: Image.asset(
                            //                 "assets/profile/transgender.png",
                            //                 height: 26.00,
                            //                 width: 26.00,
                            //               )),
                            //           SizedBox(
                            //             width: 10.00,
                            //           ),
                            //           Text(
                            //             "Unspecified",
                            //             style: commonTextStyle(Colors.black,
                            //                 FontWeight.bold, 16.00),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // )
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Image.asset(
                                        "assets/profile/transgender.png",
                                        height: 26.00,
                                        width: 26.00,
                                      )),
                                  Container(
                                    height: 50.0,
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.2,
                                    child: TextField(
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
                                                  height: 170.0,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width /
                                                          1.3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          'Unspecified',
                                                          style:
                                                              commonTextStyle(
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold,
                                                                  14.00),
                                                        ),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      ListTile(
                                                        title: Text(
                                                          'Male',
                                                          style:
                                                              commonTextStyle(
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold,
                                                                  14.00),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            _controllerGender
                                                                .text = 'Male';
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      ListTile(
                                                        title: Text(
                                                          'Female',
                                                          style:
                                                              commonTextStyle(
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold,
                                                                  14.00),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            _controllerGender
                                                                    .text =
                                                                'Female';
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      readOnly: true,
                                      style: commonTextStyle(
                                          Colors.black, FontWeight.bold, 16.00),
                                      cursorColor: Colors.indigo,
                                      controller: _controllerGender,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.cake,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.2,
                                    child: TextField(
                                      style: commonTextStyle(
                                          Colors.black, FontWeight.bold, 16.00),
                                      cursorColor: Colors.indigo,
                                      controller: _controllerDate,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                      onTap: () async {
                                        DateTime? _picked =
                                            await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1946),
                                          lastDate: DateTime.now(),
                                        );
                                        if (_picked != null) {
                                          String formattedDate =
                                              DateFormat.yMMMMd('en_US')
                                                  .format(_picked);
                                          setState(() {
                                            _controllerDate.text =
                                                formattedDate;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Icon(
                                      CupertinoIcons.info_circle_fill,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.2,
                                    child: TextField(
                                      style: commonTextStyle(
                                          Colors.black, FontWeight.bold, 16.00),
                                      cursorColor: Colors.indigo,
                                      controller: _controllerCollection,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.1),
                              thickness: 15.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    transitionAnimationController:
                                        AnimationController(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      vsync: Navigator.of(context),
                                    ),
                                    backgroundColor: Colors.white,
                                    constraints: BoxConstraints.loose(Size(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height /
                                            1.6)),
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
                                              height: 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 35.0,
                                                            width: 35.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  width: 1.0),
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Text(
                                                            "Default",
                                                            style:
                                                                commonTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    16.00),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.check,
                                                    color: Colors.indigo,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 35.0,
                                                            width: 35.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  width: 1.0),
                                                              color: Colors.red,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Text(
                                                            "Orange",
                                                            style:
                                                                commonTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    16.00),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    CupertinoIcons.lock_fill,
                                                    color: Colors.grey,
                                                    size: 20.00,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 35.0,
                                                            width: 35.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  width: 1.0),
                                                              color: Colors
                                                                  .deepPurple,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Text(
                                                            "Purple",
                                                            style:
                                                                commonTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    16.00),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    CupertinoIcons.lock_fill,
                                                    color: Colors.grey,
                                                    size: 20.00,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 35.0,
                                                            width: 35.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  width: 1.0),
                                                              color:
                                                                  Colors.orange,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Text(
                                                            "Orange",
                                                            style:
                                                                commonTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    16.00),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    CupertinoIcons.lock_fill,
                                                    color: Colors.grey,
                                                    size: 20.00,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 35.0,
                                                            width: 35.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  width: 1.0),
                                                              color:
                                                                  Colors.pink,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Text(
                                                            "Pink",
                                                            style:
                                                                commonTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    16.00),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    CupertinoIcons.lock_fill,
                                                    color: Colors.grey,
                                                    size: 20.00,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 35.0,
                                                            width: 35.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  width: 1.0),
                                                              color:
                                                                  Colors.blue,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Text(
                                                            "Orange",
                                                            style:
                                                                commonTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    16.00),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    CupertinoIcons.lock_fill,
                                                    color: Colors.grey,
                                                    size: 20.00,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 35.0,
                                                            width: 35.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  width: 1.0),
                                                              color:
                                                                  Colors.green,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Text(
                                                            "Orange",
                                                            style:
                                                                commonTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    16.00),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    CupertinoIcons.lock_fill,
                                                    color: Colors.grey,
                                                    size: 20.00,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                color: Colors.white,
                                width: MediaQuery.sizeOf(context).width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Profile color",
                                                style: commonTextStyle(
                                                    Colors.black,
                                                    FontWeight.bold,
                                                    16.00),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 20.0,
                                                width: 20.0,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      width: 1.0),
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        backgroundColor: Colors.white,
                                        content: Container(
                                          height: 150.0,
                                          child: Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Looking for pro Plans?\nGood News!",
                                                      style: commonTextStyle(
                                                          Colors.black,
                                                          FontWeight.bold,
                                                          18.00),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                      "We're building something more a premium and exciting in the nearest future. Stay tuned!",
                                                      style: commonTextStyle(
                                                          Colors.black,
                                                          FontWeight.bold,
                                                          13.00),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "OK",
                                                          style:
                                                              commonTextStyle(
                                                                  Colors.indigo,
                                                                  FontWeight
                                                                      .bold,
                                                                  14.00),
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
                                color: Colors.white,
                                width: MediaQuery.sizeOf(context).width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Show PRO/PRO+ badge ",
                                                style: commonTextStyle(
                                                    Colors.black,
                                                    FontWeight.bold,
                                                    16.00),
                                              ),
                                              Icon(
                                                CupertinoIcons.lock_fill,
                                                color: Colors.grey,
                                                size: 20.00,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 35,
                                                child: FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Switch(
                                                      value: true,
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
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    transitionAnimationController:
                                        AnimationController(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      vsync: Navigator.of(context),
                                    ),
                                    backgroundColor: Colors.white,
                                    constraints: BoxConstraints.loose(Size(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height /
                                            1.6)),
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
                                              height: 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 15.0),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Show",
                                                        style: commonTextStyle(
                                                            Colors.black,
                                                            FontWeight.bold,
                                                            14.00),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.check,
                                                    color: Colors.indigo,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 15.0),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Hide",
                                                    style: commonTextStyle(
                                                        Colors.black,
                                                        FontWeight.bold,
                                                        14.00),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                        backgroundColor:
                                                            Colors.white,
                                                        content: Container(
                                                          height: 150.0,
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
                                                                      "Looking for pro Plans?\nGood News!",
                                                                      style: commonTextStyle(
                                                                          Colors
                                                                              .black,
                                                                          FontWeight
                                                                              .bold,
                                                                          18.00),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 8.0,
                                                                ),
                                                                Container(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "We're building something more a premium and exciting in the nearest future. Stay tuned!",
                                                                      style: commonTextStyle(
                                                                          Colors
                                                                              .black,
                                                                          FontWeight
                                                                              .bold,
                                                                          13.00),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10.0,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "OK",
                                                                          style: commonTextStyle(
                                                                              Colors.indigo,
                                                                              FontWeight.bold,
                                                                              14.00),
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
                                                color: Colors.white,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 15.0),
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Ninja mode",
                                                          style:
                                                              commonTextStyle(
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold,
                                                                  14.00),
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(
                                                      CupertinoIcons.lock_fill,
                                                      color: Colors.grey,
                                                      size: 20.00,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                color: Colors.white,
                                width: MediaQuery.sizeOf(context).width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Online status",
                                                style: commonTextStyle(
                                                    Colors.black,
                                                    FontWeight.bold,
                                                    16.00),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Show",
                                                style: commonTextStyle(
                                                    Colors.grey,
                                                    FontWeight.bold,
                                                    14.00),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15.0),
                              color: Colors.grey.withOpacity(0.2),
                              child: Center(
                                child: Text(
                                  "When you hide your online status, you won't be able to see online status of other users. Ninja mode allows you to stay hidden and still see other's online status",
                                  style: commonTextStyle(
                                      Colors.grey, FontWeight.bold, 13.00),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/profile/editProfile/email');
                              },
                              child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Change email",
                                        style: commonTextStyle(Colors.black,
                                            FontWeight.bold, 16.00),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.00,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/profile/editProfile/password');
                              },
                              child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Change password",
                                        style: commonTextStyle(Colors.black,
                                            FontWeight.bold, 16.00),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.1),
                              thickness: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Hide profile from search engine",
                                            style: commonTextStyle(Colors.black,
                                                FontWeight.bold, 16.00),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Switch(
                                                  value: false,
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
                          ],
                        ),
                ),
              ));
        }
      },
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

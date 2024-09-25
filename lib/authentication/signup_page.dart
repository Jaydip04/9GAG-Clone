import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagclone/authentication/login_page.dart';
import 'package:gagclone/authentication/services/firebase_auth_services.dart';
import 'package:lottie/lottie.dart';

import '../common/toast.dart';
import '../services/authService.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // DatabaseReference reference = FirebaseDatabase.instance.ref("Profile");

  final AuthService _authService = AuthService();

  bool isSigningUp = false;
  bool _isButtonEnabled = false;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      _passwordController.addListener(() {
        setState(() {
          _isButtonEnabled = _passwordController.text.isNotEmpty;
        });
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            color: Colors.grey,
            size: 22,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Sign Up",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00, null),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  keyboardType: TextInputType.name,
                  controller: _usernameController,
                  cursorColor: Colors.indigo,
                  style: commonTextStyle(
                      Colors.black, FontWeight.bold, 16.00, null),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    fillColor: Colors.transparent,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    hintText: "Full Name",
                    hintStyle: commonTextStyle(
                        Colors.grey, FontWeight.bold, 16.00, null),
                  )),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  cursorColor: Colors.indigo,
                  style: commonTextStyle(
                      Colors.black, FontWeight.bold, 16.00, null),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    fillColor: Colors.transparent,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    hintText: "Email address",
                    hintStyle: commonTextStyle(
                        Colors.grey, FontWeight.bold, 16.00, null),
                  )),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  cursorColor: Colors.indigo,
                  style: commonTextStyle(
                      Colors.black, FontWeight.bold, 16.00, null),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    fillColor: Colors.transparent,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0x1A090909), width: 1),
                    ),
                    hintText: "Password",
                    hintStyle: commonTextStyle(
                        Colors.grey, FontWeight.bold, 16.00, null),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("Terms of Services"),
                      Text("Privacy Policy")
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _passwordController.text.isEmpty
                              ? Colors.indigo.shade200
                              : Colors.indigo,
                        ),
                        onPressed: () async {
                          setState(() {
                            isSigningUp = true;
                            _isLoading = true;
                          });

                          String username = _usernameController.text;
                          String email = _emailController.text;
                          String password = _passwordController.text;

                          if (username.isEmpty) {
                            showToast(message: "User Name is empty");
                          } else if (email.isEmpty) {
                            showToast(message: "Email is empty");
                          } else if (password.isEmpty) {
                            showToast(message: "Password is empty");
                          } else {
                            bool success = await _authService.register(username, email, password);

                            if (success) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginPage()));
                              // Navigator.pushNamedAndRemoveUntil(context, '/signUp/login', (route) => false);
                            } else {
                              showToast(message: "something wrong");
                            }
                            // User? user = await _auth.signUpWithEmailAndPassword(email, password);

                            // final String date = DateTime.now().toString();
                            setState(() {
                              isSigningUp = false;
                              _isLoading = false;
                            });
                            //   if (user != null) {
                            //     Map<String, dynamic> userProfile = {
                            //       "profileName" : _usernameController.text.toString(),
                            //       "email" : _emailController.text.toString(),
                            //       "uid" : FirebaseAuth.instance.currentUser!.uid,
                            //       "Date" : date,
                            //     };
                            //     reference.child(FirebaseAuth.instance.currentUser!.uid).set(userProfile).then((_) {
                            //
                            //       // showToast(message: "User is successfully created");
                            //       Navigator.push(context, MaterialPageRoute(builder: (_) => Thank_you()));
                            //       // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                            //     }).catchError((error) {
                            //       showToast(message: "Some error happend");
                            //     });
                            //   } else {
                            //     showToast(message: "Some error happend");
                            //   }
                          }
                        },
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 4.0,
                              )
                            : Text(
                                "Sign up",
                                style: commonTextStyle(
                                    Colors.white, FontWeight.bold, 14.00, null),
                              ),
                      )
                    ],
                  )
                ],
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
          child: Lottie.asset("assets/lottie_file/thanks.json"),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagclone/authentication/services/firebase_auth_services.dart';
import 'package:gagclone/pages/home_page.dart';

import '../common/toast.dart';

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


  bool isSigningUp = false;
  bool _isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _isButtonEnabled = _emailController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _isButtonEnabled = _passwordController.text.isNotEmpty;
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
                  style: commonTextStyle(Colors.black, FontWeight.bold, 16.00, null),
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
                    hintStyle:commonTextStyle(Colors.grey, FontWeight.bold, 16.00, null),
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
                  style: commonTextStyle(Colors.black, FontWeight.bold, 16.00, null),
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
                    hintStyle: commonTextStyle(Colors.grey, FontWeight.bold, 16.00, null),
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
                  style: commonTextStyle(Colors.black, FontWeight.bold, 16.00, null),
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
                    hintStyle: commonTextStyle(Colors.grey, FontWeight.bold, 16.00, null),
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
                          backgroundColor: _emailController.text.isEmpty && _passwordController.text.isEmpty ? Colors.indigo.shade200 : Colors.indigo,
                        ),
                        onPressed: () async {
                          setState(() {
                            isSigningUp = true;
                          });

                          String username = _usernameController.text;
                          String email = _emailController.text;
                          String password = _passwordController.text;

                          if(username.isEmpty){
                            showToast(message: "User Name is empty");
                          } else if(email.isEmpty){
                            showToast(message: "Email is empty");
                          }else if(password.isEmpty){
                            showToast(message: "Password is empty");
                          }else{
                            User? user = await _auth.signUpWithEmailAndPassword(email, password);

                            setState(() {
                              isSigningUp = false;
                            });
                            if (user != null) {
                              showToast(message: "User is successfully created");
                              Navigator.of(context).push(_HomeRoute());
                            } else {
                              showToast(message: "Some error happend");
                            }
                          }
                        },
                        child: Text(
                          "Sign up",
                          style: commonTextStyle(
                              Colors.white, FontWeight.bold, 14.00, null),
                        ),
                      )
                    ],
                  )
                ],
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
  Route _HomeRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const HomePage(),
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
}

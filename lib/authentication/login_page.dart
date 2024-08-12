import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          "Login",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00, null),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(

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
                BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(
                        left: 10),
                    child: Image.asset(
                      "assets/logo/facebook.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(
                    width: 70,
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
                BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(
                        left: 10),
                    child: Image.asset(
                      "assets/logo/google.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(
                    width: 75,
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
                BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(
                        left: 10),
                    child: Image.asset(
                      "assets/logo/apple.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(
                    width: 80,
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
            SizedBox(height: 10.0,),
            Text("or",style: commonTextStyle(Colors.grey, FontWeight.bold, 16.00, null),),
            SizedBox(height: 10.0,),
            TextFormField(
                cursorColor: Colors.blue,
                style: commonTextStyle(Colors.black, FontWeight.bold, 16.00, null),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  fillColor: Colors.transparent,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  hintText: "Username or email address",
                  hintStyle: commonTextStyle(Colors.grey, FontWeight.bold, 16.00, null),
                )),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
                cursorColor: Colors.blue,
                style: commonTextStyle(Colors.black, FontWeight.bold, 16.00, null),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  fillColor: Colors.transparent,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
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
            GestureDetector(
              onTap: (){},
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text("Log in",style: commonTextStyle(Colors.white, FontWeight.bold, 16.00, null),),
                ),
              ),
            ),
            SizedBox(height: 20.00,),
            Text("Forgot password?",style: commonTextStyle(Colors.black, FontWeight.bold, 14.00, null),)
          ],
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

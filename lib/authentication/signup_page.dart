import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                    hintText: "Full Name",
                    hintStyle:commonTextStyle(Colors.grey, FontWeight.bold, 16.00, null),
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
                    hintText: "Email address",
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
                          backgroundColor: Colors.blue.shade200,
                        ),
                        onPressed: () {},
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
}

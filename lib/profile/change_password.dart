import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_profile_page.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerNewPassword = TextEditingController();
  TextEditingController _controllerConfirmPassword = TextEditingController();
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
          "Change password",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).push(_EditProfilePageRoute());
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (_) => EditProfilePage()));
              },
              child: Text(
                "Save",
                style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
              )),
        ],
      ),
      body:  SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade100,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              SizedBox(height: 20.00,),
              TextField(
                style: commonTextStyle(
                    Colors.black, FontWeight.bold, 16.00),
                cursorColor: Colors.indigo,
                controller: _controllerPassword,
                decoration: InputDecoration(
                  hintText: "Current password",
                    hintStyle: commonTextStyle(
                        Colors.grey, FontWeight.bold, 16.00),
                    prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none)),
              ),
              SizedBox(height: 20.00,),
              TextField(
                style: commonTextStyle(
                    Colors.black, FontWeight.bold, 16.00),
                cursorColor: Colors.indigo,
                controller: _controllerNewPassword,
                decoration: InputDecoration(
                    hintText: "New password",
                    hintStyle: commonTextStyle(
                        Colors.grey, FontWeight.bold, 16.00),
                    prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none)),
              ),
              TextField(
                style: commonTextStyle(
                    Colors.black, FontWeight.bold, 16.00),
                cursorColor: Colors.indigo,
                controller: _controllerConfirmPassword,
                decoration: InputDecoration(
                    hintText: "Confirm password",
                    hintStyle: commonTextStyle(
                        Colors.grey, FontWeight.bold, 16.00),
                    prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Route _EditProfilePageRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const EditProfilePage(),
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
        transitionDuration: Duration(milliseconds: 1000)
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

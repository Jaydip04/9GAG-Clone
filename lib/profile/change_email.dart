import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_profile_page.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  TextEditingController _controllerEmail =
  TextEditingController(text: 'genixbit2024@gmail.com');
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
          "Change email",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => EditProfilePage()));
              },
              child: Text(
                "Save",
                style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
              )),
        ],
      ),
      body: SingleChildScrollView(
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
                controller: _controllerEmail,
                decoration: InputDecoration(
                  hintText: "Email address",
                  hintStyle:   commonTextStyle(
                        Colors.grey, FontWeight.bold, 16.00),
                  prefixIcon: Icon(Icons.email,color: Colors.grey,),
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
  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(
      color: color,
      fontWeight: weight,
      fontSize: size,
    );
  }
}



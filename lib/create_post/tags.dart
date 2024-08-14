import 'package:flutter/material.dart';
import 'package:gagclone/create_post/create_post.dart';

class Tags extends StatefulWidget {
  const Tags({super.key});

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    controller1.addListener(() {
      setState(() {
        _isButtonEnabled = controller1.text.isNotEmpty;
      });
    });
    controller2.addListener(() {
      setState(() {
        _isButtonEnabled = controller1.text.isNotEmpty;
      });
    });controller3.addListener(() {
      setState(() {
        _isButtonEnabled = controller1.text.isNotEmpty;
      });
    });controller4.addListener(() {
      setState(() {
        _isButtonEnabled = controller1.text.isNotEmpty;
      });
    });controller5.addListener(() {
      setState(() {
        _isButtonEnabled = controller1.text.isNotEmpty;
      });
    });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "Add tags",
            style: commonTextStyle(Colors.black, FontWeight.bold, 18.00, null),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => CreatePost())),
                child: Text(
                  "OK",
                  style: commonTextStyle(
                      Colors.indigo, FontWeight.bold, 16.00, null),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 17.0),
                  child: Text(
                    "Add at least 1 tag",
                    style: commonTextStyle(
                        Colors.grey, FontWeight.bold, 14.00, null),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.3)))),
                  child: TextField(
                    controller: controller1,
                    style: commonTextStyle(
                        Colors.black, FontWeight.bold, 16.00, null),
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                        hintText: "Tag 1",
                        hintStyle: commonTextStyle(
                            Colors.grey, FontWeight.bold, 16.00, null),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: controller1.text.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.clear,color: Colors.grey,size: 18.00,),
                        onPressed: () {
                          controller1.clear(); // Clear the text
                          setState(() {}); // Update the UI to remove the clear button
                        },
                      )
                          : null,
                    )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.3)))),
                  child: TextField(
                    controller: controller2,
                    style: commonTextStyle(
                        Colors.black, FontWeight.bold, 16.00, null),
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                        hintText: "Tag 2",
                        hintStyle: commonTextStyle(
                            Colors.grey, FontWeight.bold, 16.00, null),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: controller2.text.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.clear,color: Colors.grey,size: 18.00,),
                        onPressed: () {
                          controller2.clear(); // Clear the text
                          setState(() {}); // Update the UI to remove the clear button
                        },
                      )
                          : null,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.3)))),
                  child: TextField(
                    controller: controller3,
                    style: commonTextStyle(
                        Colors.black, FontWeight.bold, 16.00, null),
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                        hintText: "Tag 3",
                        hintStyle: commonTextStyle(
                            Colors.grey, FontWeight.bold, 16.00, null),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: controller3.text.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.clear,color: Colors.grey,size: 18.00,),
                        onPressed: () {
                          controller3.clear(); // Clear the text
                          setState(() {}); // Update the UI to remove the clear button
                        },
                      )
                          : null,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.3)))),
                  child: TextField(
                    controller: controller4,
                    style: commonTextStyle(
                        Colors.black, FontWeight.bold, 16.00, null),
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                        hintText: "Tag 4",
                        hintStyle: commonTextStyle(
                            Colors.grey, FontWeight.bold, 16.00, null),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: controller4.text.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.clear,color: Colors.grey,size: 18.00,),
                        onPressed: () {
                          controller4.clear(); // Clear the text
                          setState(() {}); // Update the UI to remove the clear button
                        },
                      )
                          : null,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.3)))),
                  child: TextField(
                    controller: controller5,
                    style: commonTextStyle(
                        Colors.black, FontWeight.bold, 16.00, null),
                    cursorColor: Colors.indigo,
                    decoration: InputDecoration(
                        suffixIcon: controller5.text.isNotEmpty
                            ? IconButton(
                          icon: Icon(Icons.clear,color: Colors.grey,size: 18.00,),
                          onPressed: () {
                            controller5.clear(); // Clear the text
                            setState(() {}); // Update the UI to remove the clear button
                          },
                        )
                            : null,
                        hintText: "Tag 5",
                        hintStyle: commonTextStyle(
                            Colors.grey, FontWeight.bold, 16.00, null),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  TextStyle commonTextStyle(color, weight, size, decoration) {
    return TextStyle(
        color: color,
        fontWeight: weight,
        fontSize: size,
        decoration: decoration);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gagclone/create_post/create_post.dart';

class CreatePostFormLink extends StatefulWidget {
  const CreatePostFormLink({super.key});

  @override
  State<CreatePostFormLink> createState() => _CreatePostFormLinkState();
}

class _CreatePostFormLinkState extends State<CreatePostFormLink> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isButtonEnabled = _controller.text.isNotEmpty;
      });
    });
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
          "Create Post From Link",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00, null),
        ),
        actions: [
          TextButton(
              onPressed: _isButtonEnabled
                  ? () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CreatePost()));
                    }
                  : null,
              child: Text(
                "NEXT",
                style: commonTextStyle(
                    _controller.text.isNotEmpty ? Colors.indigo : Colors.grey,
                    FontWeight.bold,
                    16.00,
                    null),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.1)))),
                  child: TextField(
                    style: commonTextStyle(
                        Colors.black, FontWeight.bold, 16.00, null),
                    cursorColor: Colors.indigo,
                    controller: _controller,
                    decoration: InputDecoration(
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Enter a link of an image or video",
                  style: commonTextStyle(
                      Colors.grey, FontWeight.bold, 14.00, null),
                )
              ],
            ),
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

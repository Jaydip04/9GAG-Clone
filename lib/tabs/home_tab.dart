import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gagclone/common/post_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        commonContainerBG("olympics"),
                        SizedBox(
                          width: 10,
                        ),
                        commonContainerBG("deadpool"),
                        SizedBox(
                          width: 10,
                        ),
                        commonContainerBG("wolverine"),
                        SizedBox(
                          width: 10,
                        ),
                        commonContainerBG("trump"),
                        SizedBox(
                          width: 10,
                        ),
                        commonContainerBG("biden"),
                        SizedBox(
                          width: 10,
                        ),
                        commonContainerBG("stellar blade"),
                        SizedBox(
                          width: 10,
                        ),
                        commonContainerBG("latest news"),
                        SizedBox(
                          width: 10,
                        ),
                        commonContainerBG("most commented"),
                        SizedBox(
                          width: 10,
                        ),
                        commonContainerBG("weekly highlights"),
                      ],
                    ),
                  ),
                ),
                PostPage(),
              ],
            ),
          ),
        ),
      );
  }

  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(color: color, fontWeight: weight, fontSize: size);
  }

  Container commonContainerBG(name) {
    return Container(
      child: Text(
        name,
        style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.withOpacity(0.15)),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
    );
  }
}

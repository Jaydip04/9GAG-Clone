import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../common/post_page.dart';

class TopTab extends StatefulWidget {
  const TopTab({super.key});

  @override
  State<TopTab> createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 5.0,),
                Container(
                  height: MediaQuery.sizeOf(context).height/1.13,
                  child: PostPage(),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

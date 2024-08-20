import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this,animationDuration: Duration(milliseconds: 2000));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
              size: 22,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Notifications",
            style: commonTextStyle(Colors.black, FontWeight.bold, 18.00),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/notification/double_tick.png",
                  height: 30.0,
                  width: 30.0,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    unselectedLabelColor: Colors.grey,
                    dividerColor: Colors.white,
                    indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,

                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Mentions'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  height: MediaQuery.sizeOf(context).height/1.3,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Center(child: Text("No notification yet"),),
                      Center(child: Text("No notification yet"),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(
      color: color,
      fontWeight: weight,
      fontSize: size,
    );
  }
}

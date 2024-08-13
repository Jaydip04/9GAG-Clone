import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
          "Genixbit",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {},
              child: Text(
                "Edit profile",
                style: commonTextStyle(Colors.indigo, FontWeight.bold, 14.00),
              )),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.white,
                    constraints: BoxConstraints.loose(Size(
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height / 2.3)),
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      // <-- for border radius
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.link,
                                        color: Colors.grey,
                                      )),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    "Share Profile",
                                    style: commonTextStyle(
                                        Colors.black, FontWeight.bold, 14.00),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child:
                                          Icon(Icons.edit, color: Colors.grey)),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    "Edit profile",
                                    style: commonTextStyle(
                                        Colors.black, FontWeight.bold, 14.00),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            "assets/logo/app_logo.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Genixbit",
                              style: commonTextStyle(
                                  Colors.black, FontWeight.bold, 18.00),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Container(
                              child: Text(
                                "PRO",
                                style: commonTextStyle(
                                  Colors.white,
                                  FontWeight.bold,
                                  12.0,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5.0)),
                              padding: EdgeInsets.symmetric(horizontal: 3),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "0 days .",
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.bold, 14.00),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "1st day streak",
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.bold, 14.00),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Text(
                  "My Funny Collection",
                  style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
                ),
              ),
              Divider(),
              TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                unselectedLabelColor: Colors.grey,
                dividerColor: Colors.white,
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: 'Posts'),
                  Tab(text: 'Comments'),
                  Tab(text: 'Upvotes'),
                  Tab(text: 'Saved'),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                height: MediaQuery.sizeOf(context).height / 1.4,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        Text(
                          'No Posts',
                          style: commonTextStyle(
                              Colors.black, FontWeight.bold, 16.00),
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          "Let's make something creative for fun!",
                          style: commonTextStyle(
                              Colors.grey, FontWeight.bold, 14.00),
                        ),
                        SizedBox(height: 15.0,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                          width: 90.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.edit,color: Colors.white,),
                              Text("Post",style: commonTextStyle(Colors.white, FontWeight.bold, 14.00),)
                            ],
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Center(
                      child: Text("No commented posts"),
                    ),
                    Center(
                      child: Text("No upvoted posts"),
                    ),
                    Center(
                      child: Text("No saved posts"),
                    )
                  ],
                ),
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

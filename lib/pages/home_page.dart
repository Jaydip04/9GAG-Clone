import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagclone/pages/search_page.dart';
import 'package:gagclone/tabs/ask_tab.dart';
import 'package:gagclone/tabs/fresh_tab.dart';
import 'package:gagclone/tabs/home_tab.dart';
import 'package:gagclone/tabs/top_tab.dart';
import 'package:gagclone/tabs/trending_tab.dart';
import '../bloc/drawer_bloc/drawer_bloc.dart';
import '../bloc/drawer_bloc/drawer_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: 5, vsync: this, initialIndex: 1);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey),
          title: Transform.translate(
              offset: Offset(-15.0, 0.0),
              child: Image.asset(
                "assets/logo/app_bar_logo.png",
                width: 50,
                height: 40,
              )),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              icon: Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.account_circle,
              ),
            )
          ],
        ),
        drawer: BlocBuilder<DrawerBloc, DrawerState>(
          builder: (context, state) {
            return Container(
              color: Colors.white,
              child: Drawer(
                  width: MediaQuery.sizeOf(context).width / 1.45,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: SafeArea(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color:
                                                Colors.grey.withOpacity(0.2)))),
                                child: const ListTile(
                                  title: Text('Home'),
                                  leading: Icon(Icons.home),
                                ),
                              ),
                              Container(
                                child: const ListTile(
                                  visualDensity: VisualDensity(vertical: -4),
                                  title: Text(
                                    'Interests',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                              commonListTile("Anime & Manga", Icons.ac_unit,
                                  Colors.yellow, Colors.red),
                              commonListTile("Latest News", Icons.ac_unit,
                                  Colors.green, Colors.yellow),
                              commonListTile("Humor", Icons.ac_unit,
                                  Colors.deepPurple, Colors.yellow),
                              commonListTile("Memes", Icons.ac_unit,
                                  Colors.deepPurpleAccent, Colors.yellow),
                              commonListTile("Gaming", Icons.ac_unit,
                                  Colors.orange, Colors.yellow),
                              commonListTile("WTF", Icons.ac_unit,
                                  Colors.lightGreen, Colors.yellow),
                              commonListTile(
                                  "Relationship & Dating",
                                  Icons.ac_unit,
                                  Colors.pinkAccent,
                                  Colors.yellow),
                              commonListTile("Animals & Pets", Icons.ac_unit,
                                  Colors.deepPurple, Colors.yellow),
                              commonListTile("Science & Tech", Icons.ac_unit,
                                  Colors.red, Colors.yellow),
                              commonListTile("Comic", Icons.ac_unit,
                                  Colors.pink, Colors.yellow),
                              commonListTile("Wholesome", Icons.ac_unit,
                                  Colors.yellowAccent, Colors.red),
                              commonListTile("Sports", Icons.ac_unit,
                                  Colors.redAccent, Colors.yellow),
                              commonListTile("Movies & TV", Icons.ac_unit,
                                  Colors.greenAccent, Colors.yellow),
                              commonListTile("Cat", Icons.ac_unit,
                                  Colors.orangeAccent, Colors.yellow),
                              commonListTile("Food & Drinks", Icons.ac_unit,
                                  Colors.red, Colors.yellow),
                              commonListTile("Lifestyle", Icons.ac_unit,
                                  Colors.blueAccent, Colors.yellow),
                              commonListTile("Superhero", Icons.ac_unit,
                                  Colors.red, Colors.yellow),
                              commonListTile("Crypto", Icons.ac_unit,
                                  Colors.blue, Colors.yellow),
                              commonListTile("Random", Icons.ac_unit,
                                  Colors.pink, Colors.yellow),
                              commonListTile("Woah", Icons.ac_unit,
                                  Colors.orange, Colors.yellow),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            );
          },
        ),
        body: BlocBuilder<DrawerBloc, DrawerState>(
          builder: (context, state) {
            if (state is DrawerMenuSelected) {
              if (state.selectMenuItem == 'Home') {
                return const Center(child: Text('Home Screen'));
              } else if (state.selectMenuItem == 'Settings') {
                return const Center(child: Text('Settings Screen'));
              }
            }
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                color: Colors.white,
                child: ListView(
                    children: [
                      Container(
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.white,
                          child: TabBar(
                            isScrollable: true,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            controller: _tabController,
                            labelColor: Colors.black,
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                            unselectedLabelColor: Colors.grey,
                            dividerColor: Colors.white,
                            indicatorColor: Colors.black,
                            tabs: const [
                              Tab(
                                text: "Ask",
                              ),
                              Tab(
                                text: "Home",
                              ),
                              Tab(
                                text: "Top",
                              ),
                              Tab(
                                text: "Trending",
                              ),
                              Tab(
                                text: "Fresh",
                              ),
                            ],
                          )),
                      Container(
                        height: 730,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            AskTab(),
                            HomeTab(),
                            TopTab(),
                            TrendingTab(),
                            FreshTab()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            );
          },
        ));
  }

  ListTile commonListTile(name, icon, color, iconColor) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      leading: Container(
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5.00)),
        child: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
      trailing: const Icon(
        CupertinoIcons.pin,
        size: 20,
      ),
      // selected: state is DrawerMenuSelected && state.selectMenuItem == 'Home',
      // onTap: () {
      //   context.read<DrawerBloc>().add(const SelectMenuItem('Home'));
      //   Navigator.pop(context); // Close the drawer
      // },
    );
  }
}

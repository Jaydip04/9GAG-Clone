import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/drawer_bloc/drawer_bloc.dart';
import '../bloc/drawer_bloc/drawer_event.dart';
import '../bloc/drawer_bloc/drawer_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("9GAG"),
      ),
      drawer: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: Drawer(
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
                                      color: Colors.grey.withOpacity(0.2)))),
                          child: ListTile(
                            title: const Text('Home'),
                            leading: Icon(Icons.home),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            visualDensity: VisualDensity(vertical: -4),
                            title: const Text('Interests',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey),),
                          ),
                        ),
                        commonListTile(
                            "Anime & Manga", Icons.ac_unit, Colors.yellow,Colors.red),
                        commonListTile(
                            "Latest News", Icons.ac_unit, Colors.green,Colors.yellow),
                        commonListTile("Humor", Icons.ac_unit, Colors.deepPurple,Colors.yellow),
                        commonListTile("Memes", Icons.ac_unit, Colors.deepPurpleAccent,Colors.yellow),
                        commonListTile("Gaming", Icons.ac_unit, Colors.orange,Colors.yellow),
                        commonListTile("WTF", Icons.ac_unit, Colors.lightGreen,Colors.yellow),
                        commonListTile("Relationship & Dating", Icons.ac_unit,
                            Colors.pinkAccent,Colors.yellow),
                        commonListTile(
                            "Animals & Pets", Icons.ac_unit, Colors.deepPurple,Colors.yellow),
                        commonListTile(
                            "Science & Tech", Icons.ac_unit, Colors.red,Colors.yellow),
                        commonListTile("Comic", Icons.ac_unit, Colors.pink,Colors.yellow),
                        commonListTile("Wholesome", Icons.ac_unit, Colors.yellowAccent,Colors.red),
                        commonListTile("Sports", Icons.ac_unit, Colors.redAccent,Colors.yellow),
                        commonListTile(
                            "Movies & TV", Icons.ac_unit, Colors.greenAccent,Colors.yellow),
                        commonListTile("Cat", Icons.ac_unit, Colors.orangeAccent,Colors.yellow),
                        commonListTile(
                            "Food & Drinks", Icons.ac_unit, Colors.red,Colors.yellow),
                        commonListTile("Lifestyle", Icons.ac_unit, Colors.blueAccent,Colors.yellow),
                        commonListTile("Superhero", Icons.ac_unit, Colors.red,Colors.yellow),
                        commonListTile("Crypto", Icons.ac_unit, Colors.blue,Colors.yellow),
                        commonListTile("Random", Icons.ac_unit, Colors.pink,Colors.yellow),
                        commonListTile("Woah", Icons.ac_unit, Colors.orange,Colors.yellow),
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
          return const Center(child: Text('Select a menu item'));
        },
      ),
    );
  }

  ListTile commonListTile(name, icon, color,iconColor) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
      title: Text(
        name,
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      leading: Container(
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5.00)),
        child: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
      trailing: Icon(
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

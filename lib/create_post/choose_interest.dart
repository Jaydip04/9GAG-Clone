import 'package:flutter/material.dart';

class ChooseInterest extends StatefulWidget {
  const ChooseInterest({super.key});

  @override
  State<ChooseInterest> createState() => _ChooseInterestState();
}

class _ChooseInterestState extends State<ChooseInterest> {
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
          "Choose an interest",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00, null),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height/1.1,
          padding: EdgeInsets.only(bottom: 20.0),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: SafeArea(
                  child: Column(
                    children: [
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
                      commonListTile("Comic", Icons.ac_unit, Colors.pink,
                          Colors.yellow),
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
                      commonListTile("Crypto", Icons.ac_unit, Colors.blue,
                          Colors.yellow),
                      commonListTile("Random", Icons.ac_unit, Colors.pink,
                          Colors.yellow),
                      commonListTile("Woah", Icons.ac_unit, Colors.orange,
                          Colors.yellow),
                      commonListTile("Profile Only", Icons.accessibility, Colors.black,
                          Colors.white),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  ListTile commonListTile(name, icon, color, iconColor) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      title: Text(
        name,
        style: commonTextStyle(Colors.black, FontWeight.bold, 16.0, null),
      ),
      leading: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.00)),
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
      // selected: state is DrawerMenuSelected && state.selectMenuItem == 'Home',
      // onTap: () {
      //   context.read<DrawerBloc>().add(const SelectMenuItem('Home'));
      //   Navigator.pop(context); // Close the drawer
      // },
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

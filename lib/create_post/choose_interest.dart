import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagclone/create_post/create_post.dart';

class ChooseInterest extends StatefulWidget {
  const ChooseInterest({super.key});

  @override
  State<ChooseInterest> createState() => _ChooseInterestState();
}

class _ChooseInterestState extends State<ChooseInterest> {
  List<String> interest = [
    "Anime & Manga",
    "Latest News",
    "Humor",
    "Memes",
    "Gaming",
    "WTF",
    "Relationship & Dating",
    "Animals & Pets",
    "Science & Tech",
    "Comic",
    "Wholesome",
      "Sports",
    "Movies & TV",
    "Cat",
    "Food & Drinks",
    "Lifestyle",
    "Superhero",
    "Crypto",
    "Random",
    "Woah",
    "Profile Only"

  ];
  List icon = [
    Icons.ac_unit,
    Icons.accessibility,
    Icons.access_alarm,
    Icons.accessibility,
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time_filled_outlined,
    Icons.ac_unit,
    Icons.add_circle,
    Icons.add_chart_sharp,
    Icons.accessible,
    Icons.add_call,
    Icons.access_alarms_rounded,
    Icons.add_business_rounded,
    Icons.add_box_outlined,
    Icons.add_alert_sharp,
    Icons.add_alert_outlined,
    Icons.add_a_photo_rounded,
    Icons.adb_rounded,
    Icons.ad_units_sharp,
    Icons.account_tree_rounded,

  ];
  List iconColors = [
    Colors.red,
    Colors.orange,
    Colors.white,
    Colors.red,
    Colors.grey,
    Colors.white30,
    Colors.pink,
    Colors.green,
    Colors.deepPurple,
    Colors.purpleAccent,
    Colors.lightGreenAccent,
    Colors.cyanAccent,
    Colors.amber,
    Colors.pinkAccent,
    Colors.purple,
    Colors.lightGreenAccent,
    Colors.redAccent,
    Colors.teal,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.purple,
    Colors.indigo,
  ];
  List back = [
    Colors.yellow,
    Colors.blueAccent,
    Colors.black,
    Colors.yellow,
    Colors.white,
    Colors.red,
    Colors.yellow,
    Colors.redAccent,
    Colors.yellow,
    Colors.yellow,
    Colors.grey,
    Colors.black,
    Colors.blueAccent,
    Colors.yellow,
    Colors.yellow,
    Colors.black,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
  ];

  @override
  void initState() {
    super.initState();
    print(interest.length.toString());
  }
  String _interest = "";
  String _icon = "";
  String _url = "assets/logo/app_logo.png";
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
          height: MediaQuery.sizeOf(context).height/1.06,
          padding: EdgeInsets.only(bottom: 20.0),
          color: Colors.white,
          child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance
              .collection('interest')
              .doc("1")
              .collection("interest")
              .snapshots(), builder: (context,snapshot){
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            return docs.length == 0 ?
                Center(
                  child: Text("no intersets"),
                ) : ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context,index){
                  Map<String, dynamic> data =
                  docs[index].data() as Map<String, dynamic>;
                  return ListTile(
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
                    title: Text(
                      data["interest"],
                      style: commonTextStyle(Colors.black, FontWeight.bold, 16.0, null),
                    ),
                    leading: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: back[index], borderRadius: BorderRadius.circular(10.00)),
                      child: Icon(
                        icon[index],
                        color: iconColors[index],
                        size: 24,
                      ),
                    ),
                    onTap: (){
                      _interest = data["interest"];

                      Navigator.pop(context, {
                        'interestText': _interest,
                        'imageUrl': _url,
                      });
                    },
                    // onTap: () {
                    //   BlocProvider.of<ItemSelectionBloc>(context).add(SelectItemEvent(interest));
                    // },
                    // selected: state is DrawerMenuSelected && state.selectMenuItem == 'Home',
                    // onTap: () {
                    //   context.read<DrawerBloc>().add(const SelectMenuItem('Home'));
                    //   Navigator.pop(context); // Close the drawer
                    // },
                  );
                });
          })


          // ListView(
          //   children: <Widget>[
          //     Container(
          //       color: Colors.white,
          //       child: SafeArea(
          //         child: Column(
          //           children: [
          //             commonListTile("Anime & Manga", Icons.ac_unit,
          //                 Colors.yellow, Colors.red),
          //             commonListTile("Latest News", Icons.ac_unit,
          //                 Colors.green, Colors.yellow),
          //             commonListTile("Humor", Icons.ac_unit,
          //                 Colors.deepPurple, Colors.yellow),
          //             commonListTile("Memes", Icons.ac_unit,
          //                 Colors.deepPurpleAccent, Colors.yellow),
          //             commonListTile("Gaming", Icons.ac_unit,
          //                 Colors.orange, Colors.yellow),
          //             commonListTile("WTF", Icons.ac_unit,
          //                 Colors.lightGreen, Colors.yellow),
          //             commonListTile(
          //                 "Relationship & Dating",
          //                 Icons.ac_unit,
          //                 Colors.pinkAccent,
          //                 Colors.yellow),
          //             commonListTile("Animals & Pets", Icons.ac_unit,
          //                 Colors.deepPurple, Colors.yellow),
          //             commonListTile("Science & Tech", Icons.ac_unit,
          //                 Colors.red, Colors.yellow),
          //             commonListTile("Comic", Icons.ac_unit, Colors.pink,
          //                 Colors.yellow),
          //             commonListTile("Wholesome", Icons.ac_unit,
          //                 Colors.yellowAccent, Colors.red),
          //             commonListTile("Sports", Icons.ac_unit,
          //                 Colors.redAccent, Colors.yellow),
          //             commonListTile("Movies & TV", Icons.ac_unit,
          //                 Colors.greenAccent, Colors.yellow),
          //             commonListTile("Cat", Icons.ac_unit,
          //                 Colors.orangeAccent, Colors.yellow),
          //             commonListTile("Food & Drinks", Icons.ac_unit,
          //                 Colors.red, Colors.yellow),
          //             commonListTile("Lifestyle", Icons.ac_unit,
          //                 Colors.blueAccent, Colors.yellow),
          //             commonListTile("Superhero", Icons.ac_unit,
          //                 Colors.red, Colors.yellow),
          //             commonListTile("Crypto", Icons.ac_unit, Colors.blue,
          //                 Colors.yellow),
          //             commonListTile("Random", Icons.ac_unit, Colors.pink,
          //                 Colors.yellow),
          //             commonListTile("Woah", Icons.ac_unit, Colors.orange,
          //                 Colors.yellow),
          //             commonListTile("Profile Only", Icons.accessibility, Colors.black,
          //                 Colors.white),
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // ),
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

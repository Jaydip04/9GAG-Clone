import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AskTab extends StatelessWidget {
  const AskTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Relationship & Dating", "Why do people ghost??", "5h", "72"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Relationship & Dating", "What's deep philosophical thought, life recently taught you, that you believe you can explain to anyone who is ready to listen?", "1h", "71"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Random", "How to get rid of stomach fat.?", "1h", "26"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Random", "What are you sources of income?", "14h", "41"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Gaming", "What's the best PC game you've played so far this year?", "4h", "18"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Relationship & Dating", "What would you do if you found out a hot coworker likes you?", "2h", "8"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Latest News", "Larael lran coming war what do you think?", "10h", "28"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Anime & Manga", "I want to get into anime. Anything you guys recommend?", "7h", "10"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Anime & Manga", "I want to get into anime. Anything you guys recommend?", "7h", "10"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Relationship & Dating", "What's deep philosophical thought, life recently taught you, that you believe you can explain to anyone who is ready to listen?", "1h", "71"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Relationship & Dating", "What would you do if you found out a hot coworker likes you?", "2h", "8"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: commonRow("Latest News", "Larael lran coming war what do you think?", "10h", "28"),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(color: color, fontWeight: weight, fontSize: size);
  }

  Row commonRow(interests,comment,hours,commentNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(interests+" . ",
                                style: commonTextStyle(
                                    Colors.black, FontWeight.bold, 12.00)),
                            Text(hours,
                                style: commonTextStyle(
                                    Colors.grey, FontWeight.bold, 12.00)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: Colors.grey,
                              size: 20.00,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              commentNumber,
                              style: commonTextStyle(
                                  Colors.grey, FontWeight.normal, 12.00),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(comment,
                    style:
                        commonTextStyle(Colors.black, FontWeight.bold, 14.00)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

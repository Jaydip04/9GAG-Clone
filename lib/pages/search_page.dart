import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Container(
          height: 35,
          child: Center(
            child: TextField(
              cursorColor: Colors.white,
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                isDense: true, // Added this
                contentPadding: EdgeInsets.all(8),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.withOpacity(0.3),
                filled: true,
                hintText: "My Cousin Vinny",
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.3))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.3))),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text("Search here"),
      ),
    );
  }
}

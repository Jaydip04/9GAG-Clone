import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserUIDsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User UIDs'),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchAllUserUIDs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String uid = snapshot.data![index];
                return ListTile(
                  title: Text(uid),
                );
              },
            );
          }
        },
      ),
    );
  }
}

Future<List<String>> fetchAllUserUIDs() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    List<String> userUIDs = querySnapshot.docs.map((doc) => doc.id).toList();
    return userUIDs;
  } catch (e) {
    print('Error fetching user UIDs: $e');
    return [];
  }
}
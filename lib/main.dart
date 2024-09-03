import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagclone/authentication/login_page.dart';
import 'package:gagclone/authentication/signup_page.dart';
import 'package:gagclone/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:gagclone/pages/home_page.dart';
import 'package:gagclone/pages/setting%20_page.dart';
import 'package:gagclone/profile/edit_profile_page.dart';

import 'bloc/video/video_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC9PwfQ_NzEet3jsDjWHfPOluwk1MS9yjY",
        appId: "1:580067420849:android:2943bb277c9b1ca1961090",
        messagingSenderId: "580067420849",
        projectId: "gag-17c23",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DrawerBloc()),
          BlocProvider(create: (_) => VideoBloc()),
        ], child: HomePage(),
      )
    );
  }
}

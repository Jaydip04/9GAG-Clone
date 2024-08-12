import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagclone/authentication/login_page.dart';
import 'package:gagclone/authentication/signup_page.dart';
import 'package:gagclone/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:gagclone/pages/home_page.dart';
import 'package:gagclone/pages/setting%20_page.dart';

import 'bloc/video/video_bloc.dart';
import 'bloc/video/video_event.dart';

void main() {
  runApp(const MyApp());
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

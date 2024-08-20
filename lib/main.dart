import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagclone/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:gagclone/pages/home_page.dart';
import 'package:gagclone/pages/interests_page.dart';

import 'bloc/video/video_bloc.dart';

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
        ], child:InterestsPage(),
      )
    );
  }
}

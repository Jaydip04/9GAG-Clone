import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagclone/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:gagclone/pages/home_page.dart';
import 'package:gagclone/profile/profile_page.dart';
import 'bloc/video/video_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
    // final PushNotificationService _notificationService =
    //     PushNotificationService();
    // _notificationService.initialize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DrawerBloc()),
          BlocProvider(create: (_) => VideoBloc()),
        ],
        child: HomePage(),
      ),
    );
  }
}

// class PushNotificationService {
//   FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   Future initialize() async {
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//
//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//     });
//   }
//
//   Future<String?> getToken() async {
//     String? token = await _fcm.getToken();
//     print('Token: $token');
//     return token;
//   }
// }

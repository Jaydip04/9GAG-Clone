import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagclone/authentication/login_page.dart';
import 'package:gagclone/authentication/signup_page.dart';
import 'package:gagclone/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:gagclone/create_post/choose_interest.dart';
import 'package:gagclone/create_post/create_post.dart';
import 'package:gagclone/create_post/create_post_form_link.dart';
import 'package:gagclone/create_post/tags.dart';
import 'package:gagclone/pages/home_page.dart';
import 'package:gagclone/pages/interests_page.dart';
import 'package:gagclone/pages/notification_page.dart';
import 'package:gagclone/pages/search_page.dart';
import 'package:gagclone/pages/setting%20_page.dart';
import 'package:gagclone/profile/change_email.dart';
import 'package:gagclone/profile/change_password.dart';
import 'package:gagclone/profile/edit_profile_page.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DrawerBloc()),
        BlocProvider(create: (_) => VideoBloc()),
      ],
      child: MaterialApp(
        title: '9GAG',
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/search': (context) => SearchPage(),
          '/notification': (context) => NotificationPage(),
          '/interest': (context) => InterestsPage(),
          '/profile': (context) => ProfilePage(),
          '/profile/editProfile': (context) => EditProfilePage(),
          '/profile/editProfile/email': (context) => ChangeEmail(),
          '/profile/editProfile/password': (context) => ChangePassword(),
          '/login': (context) => LoginPage(),
          '/createPostFormLink': (context) => CreatePostFormLink(),
          '/signUp': (context) => SignupPage(),
          '/setting': (context) => SettingPage(),
          '/createPost': (context) => CreatePost(),
          '/createPost/chooseInterest': (context) => ChooseInterest(),
          '/createPost/tag': (context) => Tags(),
        },
        debugShowCheckedModeBanner: false,
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

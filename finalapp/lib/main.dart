import 'package:finalapp/screens/notifications.dart';
import 'package:finalapp/screens/profiles/change_password.dart';
import 'package:finalapp/screens/profiles/edit_profile.dart';
import 'package:finalapp/screens/explorer_screen.dart';
import 'package:finalapp/screens/feed_screen.dart';
import 'package:finalapp/screens/initials/firstpage.dart';
import 'package:finalapp/screens/initials/login.dart';
import 'package:finalapp/screens/initials/signup.dart';
import 'package:finalapp/screens/post_page.dart';
import 'package:finalapp/screens/profiles/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase/authentication.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: AuthMtds().inst().authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active)
          {
            if(snapshot.hasData)
            {
              return const Feed();
            }
            else if(snapshot.hasError)
            {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator( color: Colors.grey,),
            );
          }

          return const FirstPage();
        },
      ),
      routes:
      {
        '/first': (context) => const FirstPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignInPage(),
        '/post': (context) => PostPage(),
        '/search': (context) => Search(),
        '/feed': (context) => Feed(),
        '/profile': (context) => Profile(AuthMtds().userId()),
        '/edit_profile': (context) => EditProfile(),
        '/reset': (context) => Reset(),
        '/notif': (context) => FavoritesScreen(),
      },
    );
  }
}



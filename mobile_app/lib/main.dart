import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/home_screen.dart';

import 'empty_page.dart';

final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  FirebaseMessaging.instance.getToken().then((value){
    debugPrint("get-token: $value");
  });

  // Run in background when click it will take the user to home page
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
          debugPrint("onMessageOpenedApp: $message");
          Navigator.pushNamed(navigatorKey.currentState!.context, '/push-page', arguments: {
            'message': json.encode(message.data),
          });
  });

  // If app is closed or terminated
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) => {
        if(message != null){
         Navigator.pushNamed(navigatorKey.currentState!.context, '/push-page',
             arguments: {
        'message': json.encode(message.data),
        })
      }
  });

  FirebaseMessaging.onBackgroundMessage(_firsbaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firsbaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
  debugPrint("_firsbaseMessagingBackgroundHandler:  $message");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      navigatorKey: navigatorKey,
      routes: {
        '/': ((context) => const EmptyPage()),
        '/push-page': ((context) => const HomeScreen())
      },

    );
  }
}


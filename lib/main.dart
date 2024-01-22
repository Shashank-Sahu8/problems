import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Starting_Flow/2.Type_of_user.dart';
import 'package:provider/provider.dart';
import 'Auth_Files/firebase_options.dart';
import 'Starting_Flow/1.Splash Screen.dart';
import 'Theme/Theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => CheckProvider())],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: Provider.of<ThemeProvider>(context).themeData,
        debugShowCheckedModeBanner: false,
        home: splash_screen(),
      ),
    );
  }
}

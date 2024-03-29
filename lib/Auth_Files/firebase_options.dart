// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCM9QikHHTcxsrktWVkxStBADPsku6oXno',
    appId: '1:525063110523:web:4efc22cbfebfedc9a847de',
    messagingSenderId: '525063110523',
    projectId: 'project1power-4aef5',
    authDomain: 'project1power-4aef5.firebaseapp.com',
    storageBucket: 'project1power-4aef5.appspot.com',
    measurementId: 'G-0MN0CYD7XF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQpB8uoepKkkbuHB0gAJ_pKPTWDGO_P0I',
    appId: '1:525063110523:android:1d42387df3d31ca3a847de',
    messagingSenderId: '525063110523',
    projectId: 'project1power-4aef5',
    storageBucket: 'project1power-4aef5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCW_cmZA1VvBBmNTxvGC2HCq2MG28KKI0',
    appId: '1:525063110523:ios:64f87e5849e29fc2a847de',
    messagingSenderId: '525063110523',
    projectId: 'project1power-4aef5',
    storageBucket: 'project1power-4aef5.appspot.com',
    iosBundleId: 'com.example.projectPower',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCW_cmZA1VvBBmNTxvGC2HCq2MG28KKI0',
    appId: '1:525063110523:ios:2f90cdc527f901f0a847de',
    messagingSenderId: '525063110523',
    projectId: 'project1power-4aef5',
    storageBucket: 'project1power-4aef5.appspot.com',
    iosBundleId: 'com.example.projectPower.RunnerTests',
  );
}

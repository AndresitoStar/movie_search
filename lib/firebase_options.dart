// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzWIcUOYD_nnB4cbkXIZmgFjx0M9PDDrg',
    appId: '1:309215705690:android:ae5130b8f43f8c253d3663',
    messagingSenderId: '309215705690',
    projectId: 'media-catalog-5af13',
    databaseURL: 'https://media-catalog-5af13.firebaseio.com',
    storageBucket: 'media-catalog-5af13.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJ5IStXzNDkraidx-1bDVrd5X2voInXBg',
    appId: '1:309215705690:ios:12db8310ad1af7393d3663',
    messagingSenderId: '309215705690',
    projectId: 'media-catalog-5af13',
    databaseURL: 'https://media-catalog-5af13.firebaseio.com',
    storageBucket: 'media-catalog-5af13.firebasestorage.app',
    androidClientId: '309215705690-kvqthjokn7hvqsghikq04bauc6k3q4j3.apps.googleusercontent.com',
    iosClientId: '309215705690-r725ca14qfhfmnu76b3t47a6jd2bvt0n.apps.googleusercontent.com',
    iosBundleId: 'com.tko.movieSearch',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDcV8IsBtagBCAjFbCnXmv0EugQCHKtzIQ',
    appId: '1:309215705690:web:b723b1070a4846063d3663',
    messagingSenderId: '309215705690',
    projectId: 'media-catalog-5af13',
    authDomain: 'media-catalog-5af13.firebaseapp.com',
    databaseURL: 'https://media-catalog-5af13.firebaseio.com',
    storageBucket: 'media-catalog-5af13.firebasestorage.app',
    measurementId: 'G-1TQ5432YB7',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDcV8IsBtagBCAjFbCnXmv0EugQCHKtzIQ',
    appId: '1:309215705690:web:b723b1070a4846063d3663',
    messagingSenderId: '309215705690',
    projectId: 'media-catalog-5af13',
    authDomain: 'media-catalog-5af13.firebaseapp.com',
    databaseURL: 'https://media-catalog-5af13.firebaseio.com',
    storageBucket: 'media-catalog-5af13.firebasestorage.app',
    measurementId: 'G-1TQ5432YB7',
  );

}
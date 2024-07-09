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
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyByvYDp3Dp5QaDWh8YpoocSIt2omKYAa78',
    appId: '1:18411956446:web:d53f7a0543ef6975e87a4f',
    messagingSenderId: '18411956446',
    projectId: 'kailasoft-test',
    authDomain: 'kailasoft-test.firebaseapp.com',
    storageBucket: 'kailasoft-test.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtl4OVpMoMBngKtMb8Fe3PWQaniASZljg',
    appId: '1:18411956446:android:d5ae9dd2988ec0dee87a4f',
    messagingSenderId: '18411956446',
    projectId: 'kailasoft-test',
    storageBucket: 'kailasoft-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdWp_WyUPnnSNG5okMLZOiRopvKoWaAlo',
    appId: '1:18411956446:ios:37f8687015bdce7fe87a4f',
    messagingSenderId: '18411956446',
    projectId: 'kailasoft-test',
    storageBucket: 'kailasoft-test.appspot.com',
    iosBundleId: 'com.example.kailasoftTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdWp_WyUPnnSNG5okMLZOiRopvKoWaAlo',
    appId: '1:18411956446:ios:37f8687015bdce7fe87a4f',
    messagingSenderId: '18411956446',
    projectId: 'kailasoft-test',
    storageBucket: 'kailasoft-test.appspot.com',
    iosBundleId: 'com.example.kailasoftTask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyByvYDp3Dp5QaDWh8YpoocSIt2omKYAa78',
    appId: '1:18411956446:web:af92b6a2a61db163e87a4f',
    messagingSenderId: '18411956446',
    projectId: 'kailasoft-test',
    authDomain: 'kailasoft-test.firebaseapp.com',
    storageBucket: 'kailasoft-test.appspot.com',
  );
}

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
    apiKey: 'AIzaSyBU_Z9r_tsORTKiccqjK1P7prOioQ5ZLYk',
    appId: '1:217919930589:web:f45b94636e3bc8ef745b34',
    messagingSenderId: '217919930589',
    projectId: 'whatsapp-clone-a3d76',
    authDomain: 'whatsapp-clone-a3d76.firebaseapp.com',
    storageBucket: 'whatsapp-clone-a3d76.appspot.com',
    measurementId: 'G-M9LZXH388R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1J4yOejt7ldkOF_qCY_wcqeMrqN_oCEM',
    appId: '1:217919930589:android:93e26fd3a84f7037745b34',
    messagingSenderId: '217919930589',
    projectId: 'whatsapp-clone-a3d76',
    storageBucket: 'whatsapp-clone-a3d76.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkzEEr7j1BM1Lr63Eqt0o0r2e-5bVCKZs',
    appId: '1:217919930589:ios:421776389e3c97f3745b34',
    messagingSenderId: '217919930589',
    projectId: 'whatsapp-clone-a3d76',
    storageBucket: 'whatsapp-clone-a3d76.appspot.com',
    iosBundleId: 'com.example.whatsappClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkzEEr7j1BM1Lr63Eqt0o0r2e-5bVCKZs',
    appId: '1:217919930589:ios:421776389e3c97f3745b34',
    messagingSenderId: '217919930589',
    projectId: 'whatsapp-clone-a3d76',
    storageBucket: 'whatsapp-clone-a3d76.appspot.com',
    iosBundleId: 'com.example.whatsappClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBU_Z9r_tsORTKiccqjK1P7prOioQ5ZLYk',
    appId: '1:217919930589:web:85ab183cf4c9fb68745b34',
    messagingSenderId: '217919930589',
    projectId: 'whatsapp-clone-a3d76',
    authDomain: 'whatsapp-clone-a3d76.firebaseapp.com',
    storageBucket: 'whatsapp-clone-a3d76.appspot.com',
    measurementId: 'G-JVQ4GBEB8T',
  );
}

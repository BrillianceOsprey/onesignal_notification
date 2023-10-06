// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  OneSignal.initialize('ff6b41b9-fa9d-4a72-ba6b-bc8a57e25398');
  final permission = await OneSignal.Notifications
      .permissionNative(); // This will works ONLY if initialize is really initialized
  print('permission accepted :=> $permission');

  final isGranted = await OneSignal.Notifications.requestPermission(
      true); // If permission is already granted this never ever complete even initialize is really initialized
  print('permission granted :=> $isGranted');

  OneSignal.Notifications.addPermissionObserver((state) {
    print("Has permission $state");
  });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello world!'),
        ),
      ),
    );
  }
}

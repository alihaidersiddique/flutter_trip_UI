import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_trip_ui/pages/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: false,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(MyApp());
}

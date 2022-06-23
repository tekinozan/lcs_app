import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lcs_app/repositories/user_repository.dart';
import 'package:lcs_app/services/deep_link_service.dart';
import 'package:lcs_app/pages/nav_pages/reward.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.setMockInitialValues({});

  DeepLinkService.instance?.handleDynamicLinks();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    UserRepository.instance.listenToCurrentAuth();
    super.initState();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reward App',
      debugShowCheckedModeBanner: false,
      home: const RewardWidget(),
    );
  }
}

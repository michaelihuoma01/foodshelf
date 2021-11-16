import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:foodshelf/helpers/remote_config.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/route_generator.dart';
import 'package:foodshelf/screens/auth/login.dart';
import 'package:foodshelf/utility/brand_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final RemoteConfigService _remoteConfigService = getIt<RemoteConfigService>();

  // initRemoteConfig() async {
  //   await _remoteConfigService.initialise();
  //   print(_remoteConfigService.getBaseUrl);
  // }

  @override
  void initState() {
    super.initState();
    _initFirebase();
    // initRemoteConfig();
  }

  void _initFirebase() async {
    await Firebase.initializeApp();
    _setupCrashlytics();
  }

  void _setupCrashlytics() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await FirebaseCrashlytics.instance.sendUnsentReports();
    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
      print("--- crashlytics enabled");
    } else {
      print("--- crashlytics not enabled");
    }
    // if (kDebugMode) {
    //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    // } else {
    //   // Handle Crashlytics enabled status when not in Debug,
    //   // e.g. allow your users to opt-in to crash reporting.
    //   FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: BrandColors.colorAccent,
          cursorColor: BrandColors.colorAccent,
          focusColor: BrandColors.colorAccent,
          primaryColor: BrandColors.colorAccent),
      title: 'Food Shelf',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

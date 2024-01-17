import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tefas_app/constants/appthemes.dart';
import 'package:tefas_app/models/locale_data_model.dart';
import 'package:tefas_app/pages/intro_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(LocaleDataModelAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Hive.openBox<LocaleDataModel>("portfolio");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return DefaultTabController(
            length: 3,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              home: const IntroPage(),
            ),
          );
        });
  }
}

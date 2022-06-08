import 'package:flutter/material.dart';
import 'package:githublist/screen/user/user_list_main.dart';
import 'package:githublist/utility/colors_main.dart';
import 'package:githublist/utility/font_thai.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub User',
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          color: ColorsSTD.cMain,
          titleTextStyle: FontThai.text18WhiteBold,
        ),
        scaffoldBackgroundColor: ColorsSTD.cBG,
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          hintStyle: FontThai.text16WhiteNormal,
          contentPadding: const EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigo,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.indigo.shade900,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          trackVisibility: MaterialStateProperty.resolveWith((states) => false),
          thumbVisibility: MaterialStateProperty.resolveWith((states) => true),
          thickness: MaterialStateProperty.resolveWith((states) => 8),
        ),
      ),
      home: const UserListMain(),
    );
  }
}

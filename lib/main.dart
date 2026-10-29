import 'package:auto_tire/login_screen.dart';
import 'package:auto_tire/store/magazin_store.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // WidgetsFlutterBinding — pluginlar (shared_preferences) ishlashi uchun.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // ChangeNotifier — barcha sahifalar bitta magazin holatini eshitadi.
  final MagazinStore store = MagazinStore();

  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return MagazinScope(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        ),
        home: LoginScreen(),
      ),
    );
  }
}

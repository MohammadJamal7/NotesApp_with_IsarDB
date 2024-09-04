import 'package:flutter/material.dart';
import 'package:notes_app_with_isar/Pages/homepage.dart';
import 'package:provider/provider.dart';
import 'package:notes_app_with_isar/Themes/themesProvider.dart';
import 'Databases/notes_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotesDbService.initializeDb();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesDbService()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: themeProvider.getTheme(),
      home: const Home(),
    );
  }
}

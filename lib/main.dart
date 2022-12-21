import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:swara/models/favoriteModel.dart';
import 'package:swara/models/mostlyplayedModel.dart';
import 'package:swara/models/playlistmodel.dart';
import 'package:swara/models/recentlyplaylstModel.dart';
import 'package:swara/models/songModel.dart';
import 'package:swara/screens/splash_screen.dart';

Future<void> main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);

  Hive.registerAdapter(FavoriteAdapter());
  openFavoriteDatabase();

  Hive.registerAdapter(PlaylistsongzAdapter());
  openPlaylistDB();

  Hive.registerAdapter(MostlyPlayedAdapter());
  openMostPlayedDb();

  Hive.registerAdapter(RecentlyPlayedAdapter());
  openRecenlyPlayedDb();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: SplashScreen(),
    );
  }
}

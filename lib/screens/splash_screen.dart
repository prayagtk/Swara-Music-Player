import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swara/Navigation_bar.dart';
import 'package:swara/models/mostlyplayedModel.dart';
import 'package:swara/models/songModel.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final audioQuery = OnAudioQuery();
final box = SongBox.getinstance();

List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];
List<Audio> fullsongs = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    requestStoragePermision();
    splashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade800,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Image/swaralogo.png',
                height: 90,
                width: 90,
              ),
              Text(
                'Swara',
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  requestStoragePermision() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();

      fetchSongs = await audioQuery.querySongs();

      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      for (var elements in allSongs) {
        mostplayedBox.add(MostlyPlayed(
            songname: elements.title,
            artistname: elements.artist,
            duration: elements.duration,
            songurl: elements.uri,
            count: 0,
            id: elements.id));
      }

      allSongs.forEach((element) {
        box.add(Songs(
            songName: element.title,
            artist: element.artist,
            duration: element.duration,
            songurl: element.uri,
            id: element.id));
      });
    }
  }

  Future<void> splashScreen() async {
    await Future.delayed(Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NavigationScreen()));
  }
}

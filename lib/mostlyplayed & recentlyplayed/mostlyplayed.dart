import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swara/models/mostlyplayedModel.dart';
import 'package:swara/screens/player.dart';

class MostlyPlayedSongs extends StatefulWidget {
  const MostlyPlayedSongs({super.key});

  @override
  State<MostlyPlayedSongs> createState() => _MostlyPlayedSongsState();
}

class _MostlyPlayedSongsState extends State<MostlyPlayedSongs> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  List<Audio> songz = [];
  List<MostlyPlayed> mostlyplayeslist = [];
  @override
  void initState() {
    List<MostlyPlayed> songzlist = mostplayedBox.values.toList();

    int i = 0;
    for (var item in songzlist) {
      if (item.count > 4) {
        mostlyplayeslist.remove(item);
        mostlyplayeslist.insert(i, item);
        i++;
      }
    }

    for (var items in mostlyplayeslist) {
      songz.add(Audio.file(items.songurl!,
          metas: Metas(
              title: items.songname,
              artist: items.artistname,
              id: items.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade800,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: Text(
          'Mostly played',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
//---------------------------------Space----------------------------------------
          SizedBox(
            height: 10,
          ),
//------------------------------------------------------------------------------
          ValueListenableBuilder(
              valueListenable: mostplayedBox.listenable(),
              builder: (context, Box<MostlyPlayed> mstsonbox, child) {
                if (mostlyplayeslist.isEmpty) {
                  return Center(
                    child: Text(
                      'No songs played',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mostlyplayeslist.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          onTap: (() {
                            player.open(
                                Playlist(audios: songz, startIndex: index),
                                showNotification: true,
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplug,
                                loopMode: LoopMode.playlist);
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => MusicPlayer())));
                          }),
                          leading: QueryArtworkWidget(
                            id: mostlyplayeslist[index].id!,
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.cover,
                            artworkQuality: FilterQuality.high,
                            artworkBorder: BorderRadius.circular(50),
                            nullArtworkWidget: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Image.asset(
                                'assets/Image/StBrARCw_400x400.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            mostlyplayeslist[index].songname!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }));
                }
              }),
        ],
      ),
    );
  }
}

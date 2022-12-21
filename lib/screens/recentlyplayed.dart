import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swara/models/mostlyplayedModel.dart';
import 'package:swara/models/recentlyplaylstModel.dart';
import 'package:swara/screens/player.dart';

class RecentlyPlayedSongs extends StatefulWidget {
  const RecentlyPlayedSongs({super.key});

  @override
  State<RecentlyPlayedSongs> createState() => _RecentlyPlayedSongsState();
}

class _RecentlyPlayedSongsState extends State<RecentlyPlayedSongs> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Audio> rsongsz = [];
  @override
  void initState() {
    // TODO: implement initState
    List<RecentlyPlayed> rpsongs =
        recentlyplayedbox.values.toList().reversed.toList();

    for (var item in rpsongs) {
      rsongsz.add(Audio.file(item.songurl!,
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          )));
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
          'RecentlyPlayed',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: recentlyplayedbox.listenable(),
                builder: (context, Box<RecentlyPlayed> recentsongs, child) {
                  List<RecentlyPlayed> rsongs =
                      recentsongs.values.toList().reversed.toList();
                  if (rsongs.isEmpty) {
                    return Center(
                      child: Text(
                        "You have't played song",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: rsongs.length,
                      itemBuilder: (context, index) {
                        List<MostlyPlayed> almstSongz =
                            mostplayedBox.values.toList();
                        MostlyPlayed msSongs = almstSongz[index];
                        return ListTile(
                          onTap: () {
                            player.open(
                                Playlist(audios: rsongsz, startIndex: index),
                                showNotification: true,
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplug,
                                loopMode: LoopMode.playlist);
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MusicPlayer()));
                          },
                          leading: QueryArtworkWidget(
                            id: rsongs[index].id!,
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
                            rsongs[index].songname!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

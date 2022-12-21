import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swara/models/playlistmodel.dart';
import 'package:swara/models/songModel.dart';
import 'package:swara/screens/player.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class PlaylistSongs extends StatefulWidget {
  List<Songs> allPlaylistSongs = [];
  int playlistIndex;
  String playlistName;
  PlaylistSongs(
      {required this.allPlaylistSongs,
      required this.playlistIndex,
      required this.playlistName,
      super.key});

  @override
  State<PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<PlaylistSongs> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Audio> plstsongs = [];

  @override
  void initState() {
    // TODO: implement initState
    for (var song in widget.allPlaylistSongs) {
      plstsongs.add(Audio.file(song.songurl.toString(),
          metas: Metas(
              title: song.songName,
              artist: song.artist,
              id: song.id.toString())));
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
//-----------------------------(Appbar Title)-----------------------------------
          widget.playlistName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ValueListenableBuilder<Box<Playlistsongz>>(
          valueListenable: playlistBox.listenable(),
          builder: (context, value, child) {
            List<Playlistsongz> playlistSongs = playlistBox.values.toList();
            List<Songs>? songz =
                playlistSongs[widget.playlistIndex].playlistSongs;
            if (songz!.isEmpty) {
              return const Center(
                child: Text(
                  'Empty',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  return ListTile(
//--------------------------(Long Press)----------------------------------------
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              backgroundColor: Colors.purple.shade800,
                              title: Text(
                                'Remove From Playlist',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                'Are you sure?',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('cancel',
                                            style: TextStyle(
                                                color: Colors.white))),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            plstsongs.removeAt(index);
                                            songz.removeWhere((element) =>
                                                element.id == songz[index].id);
                                            playlistBox.putAt(
                                                widget.playlistIndex,
                                                Playlistsongz(
                                                    playlistName:
                                                        widget.playlistName,
                                                    playlistSongs: songz));
                                          });
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: Text('Delete',
                                            style:
                                                TextStyle(color: Colors.white)))
                                  ],
                                ),
                              ],
                            );
                          }));
                    },
//-------------------(On Tap[Navigating to Now Playing Screen])-----------------------------------------
                    onTap: () {
                      player.open(
                          Playlist(audios: plstsongs, startIndex: index),
                          showNotification: true,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => MusicPlayer()));
                    },
//-----------------------------(Title)------------------------------------------
                    title: Text(
                      songz[index].songName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
//--------------------------(leading part)--------------------------------------
                    leading: QueryArtworkWidget(
                      id: songz[index].id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(50),
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: ClipRRect(
                        child: Image.asset(
                          'assets/Image/StBrARCw_400x400.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
//------------------------------------------------------------------------------
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Divider();
                },
                itemCount: songz.length);
          },
        ),
      ),
    );
  }
}

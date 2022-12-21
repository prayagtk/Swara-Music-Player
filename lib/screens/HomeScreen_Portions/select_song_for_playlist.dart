import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:swara/models/playlistmodel.dart';
import 'package:swara/models/songModel.dart';
import 'package:swara/screens/splash_screen.dart';

class PlaylistSelection extends StatefulWidget {
  final songIndex;
  PlaylistSelection({required this.songIndex, super.key});

  @override
  State<PlaylistSelection> createState() => _PlaylistSelectionState();
}

class _PlaylistSelectionState extends State<PlaylistSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade800,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: Text(
          'Your Playlists',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ValueListenableBuilder(
            valueListenable: playlistBox.listenable(),
            builder: (context, Box<Playlistsongz> playlistboxz, child) {
              List<Playlistsongz> playlistsz = playlistboxz.values.toList();

              if (playlistboxz.isEmpty) {
                return Center(
                  child: Text(
                    'Empty',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: playlistsz.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.folder_open,
                          color: Colors.white,
                        ),
                        title: Text(playlistsz[index].playlistName.toString(),
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Playlistsongz? plsongs = playlistboxz.getAt(index);
                          List<Songs>? plNewSongs = plsongs!.playlistSongs;
                          Box<Songs> box = Hive.box(boxname);
                          List<Songs> AllDBSongz = box.values.toList();
                          bool isAllreadyAdded = plNewSongs!.any((element) =>
                              element.id == AllDBSongz[widget.songIndex].id);

                          if (!isAllreadyAdded) {
                            plNewSongs.add(Songs(
                                songName: AllDBSongz[widget.songIndex].songName,
                                artist: AllDBSongz[widget.songIndex].artist,
                                duration: AllDBSongz[widget.songIndex].duration,
                                songurl: AllDBSongz[widget.songIndex].songurl,
                                id: AllDBSongz[widget.songIndex].id));

                            playlistboxz.putAt(
                                index,
                                Playlistsongz(
                                    playlistName:
                                        playlistsz[index].playlistName,
                                    playlistSongs:
                                        playlistsz[index].playlistSongs));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  '${AllDBSongz[widget.songIndex].songName} Added To ${playlistsz[index].playlistName}',
                                  style: TextStyle(color: Colors.white),
                                )));
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  '${AllDBSongz[widget.songIndex].songName} is already added',
                                  style: TextStyle(color: Colors.white),
                                )));
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                      );
                    }),
              );
            }),
      ),
    );
  }
}

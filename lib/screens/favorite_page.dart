import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swara/models/favoriteModel.dart';
import 'package:swara/screens/player.dart';

class Favorite_page extends StatefulWidget {
  const Favorite_page({super.key});

  @override
  State<Favorite_page> createState() => _Favorite_pageState();
}

class _Favorite_pageState extends State<Favorite_page> {
  List<Audio> allsongs = [];

  AssetsAudioPlayer audioplyr = AssetsAudioPlayer.withId('0');

  @override
  void initState() {
    final favsongsdb = Hive.box<Favorite>(favBoxName).values.toList();
    for (var item in favsongsdb) {
      allsongs.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade800,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
//-------------------------(Box background immage section)----------------------
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    image: DecorationImage(
                        image: AssetImage('assets/Image/favorite_cover.jpg'),
                        fit: BoxFit.cover),
                  ),
//------------------------(Favorite text section)-------------------------------
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 145),
                        child: Text(
                          'Favorite',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 160),
                        child: Text(
                          'Songs',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ValueListenableBuilder<Box<Favorite>>(
                        valueListenable:
                            Hive.box<Favorite>(favBoxName).listenable(),
                        builder:
                            ((context, Box<Favorite> allDBFavSongs, child) {
                          List<Favorite> allDBsongs =
                              allDBFavSongs.values.toList();
                          //(If songs are not there)
                          if (favSongsDB.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 250),
                              child: Text(
                                'Empty',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          //(If the list is null)
                          if (favSongsDB == null) {}
                          return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return ListTile(
                                  onLongPress: () {
                                    removeFromFavorite(context, index);
                                  },
                                  onTap: () {
                                    audioplyr.open(
                                        Playlist(
                                            audios: allsongs,
                                            startIndex: index),
                                        showNotification: true,
                                        headPhoneStrategy:
                                            HeadPhoneStrategy.pauseOnUnplug,
                                        loopMode: LoopMode.playlist);
                                    setState(() {});
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return MusicPlayer();
                                    }));
                                  },
                                  title: Text(
                                    allDBsongs[index].songname!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  leading: QueryArtworkWidget(
                                    id: allDBsongs[index].id!,
                                    type: ArtworkType.AUDIO,
                                    artworkBorder: BorderRadius.circular(8),
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      child: Image.asset(
                                        'assets/Image/StBrARCw_400x400.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return Divider();
                              },
                              itemCount: allDBsongs.length);
                        })))
              ],
            ),
          ),
        ));
  }

//--------------------------(RemoveFromFavorite Function)-----------------------
  removeFromFavorite(BuildContext context, int index) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.purple.shade600,
            title: const Center(
              child: Text(
                'Remove from Favorites',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: const Text(
              'Are you sure?',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      allsongs.removeAt(index);
                      await favSongsDB.deleteAt(index);
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future showOptions(BuildContext ctx) async {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx1) {
          return Container(
            color: Color.fromARGB(255, 45, 6, 94),
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.purple.shade400,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//---------------------------------------------------------(Close Button)-------------------------------------------------------------------------
                  IconButton(
                      onPressed: () {
                        Navigator.of(ctx1).pop();
                      },
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      )),
//---------------------------------------------------------(Add Playlist)-----------------------------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(ctx1).pop();
                            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                              content: Text('Removed from favorite'),
                              margin: EdgeInsets.all(10),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red.shade300,
                              duration: Duration(seconds: 2),
                            ));
                          },
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Remove from favorite',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        });
  }
}

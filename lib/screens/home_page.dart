import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swara/Favorite%20functions/add_to_fav.dart';
import 'package:swara/models/favoriteModel.dart';
import 'package:swara/models/mostlyplayedModel.dart';
import 'package:swara/models/playlistmodel.dart';
import 'package:swara/models/recentlyplaylstModel.dart';
import 'package:swara/models/songModel.dart';
import 'package:swara/screens/HomeScreen_Portions/homeScreenLibrary.dart';
import 'package:swara/screens/add_to_playlist.dart';
import 'package:swara/screens/player.dart';
import 'package:swara/screens/search_screen.dart';
import 'package:swara/screens/HomeScreen_Portions/select_song_for_playlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isplaying;
  late bool playerVisibility;

  final box = SongBox.getinstance();

  List<Audio> convertaudios = [];
  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer.withId('0');

  @override
  void initState() {
    List<Songs> dbSongs = box.values.toList();
    for (var item in dbSongs) {
      convertaudios.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songName,
              artist: item.artist,
              id: item.id.toString())));
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade800,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//-------------------------------------------------------(Logo,Search button)-----------------------------------------------------------------------
                    Row(
                      children: [
                        Image.asset(
                          'assets/Image/swaralogo.png',
                          width: 30,
                          height: 30,
                        ),
                        const Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Swara',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return SearchScreen();
                                }));
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
//--------------------------------------------------------Sizebox----------------------------------------------------------------------------------
                    SizedBox(
                      height: 10,
                    ),
//-----------------------------------------------------(Search button)-----------------------------------------------------------------------------
                    Text(
                      'Welcome',
                      style: TextStyle(color: Colors.white),
                    ),
//-------------------------------------------------------sizebox-----------------------------------------------------------------------------------
                    SizedBox(
                      height: 10,
                    ),
//-------------------------------------------------------------------------------------------------------------------------------------------------
                    Text(
                      'Enjoy your favorite musics',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 28),
                    ),
                    //---------------------------------------------------------Size Box--------------------------------------------------------------------------------
                    SizedBox(
                      height: 20,
                    ),
//-----------------------------------------------------All songs List------------------------------------------------------------------------------
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ValueListenableBuilder<Box<Songs>>(
                      valueListenable: box.listenable(),
                      builder: (context, Box<Songs> allSongBox, child) {
                        List<Songs> allDbsongs = allSongBox.values.toList();
                        List<MostlyPlayed> mostPlayedSongz =
                            mostplayedBox.values.toList();

//--------------------------------(If songs arenot there)-----------------------
                        if (allDbsongs.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
//--------------------------------(If the list is null)-------------------------
                        if (allDbsongs == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
//------------------------------------------------------------------------------
                        return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              RecentlyPlayed rpsongs;
                              MostlyPlayed MPsongz = mostPlayedSongz[index];
                              Songs songzz = allDbsongs[index];
                              return ListTile(
                                  onTap: () {
                                    rpsongs = RecentlyPlayed(
                                        songname: songzz.songName,
                                        artist: songzz.artist,
                                        duration: songzz.duration,
                                        songurl: songzz.songurl,
                                        id: songzz.id);
                                    updateRecenltPlayed(rpsongs, index);
                                    _audioplayer.open(
                                      Playlist(
                                          audios: convertaudios,
                                          startIndex: index),
                                      showNotification: true,
                                      headPhoneStrategy:
                                          HeadPhoneStrategy.pauseOnUnplug,
                                      loopMode: LoopMode.playlist,
                                    );
                                    updatePlayedSongCount(MPsongz, index);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return MusicPlayer();
                                    }));
                                  },
                                  title: Text(
                                    songzz.songName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: QueryArtworkWidget(
                                    id: songzz.id,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.cover,
                                    artworkQuality: FilterQuality.high,
                                    size: 2000,
                                    quality: 100,
                                    artworkBorder: BorderRadius.circular(50),
                                    nullArtworkWidget: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      child: Image.asset(
                                        'assets/Image/StBrARCw_400x400.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor:
                                                Colors.purple.shade800,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            context: context,
                                            builder: ((context) {
                                              return SizedBox(
                                                height: 130,
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PlaylistSelection(
                                                                        songIndex:
                                                                            index)));
                                                      },
                                                      child: Text(
                                                        'Add To Playlist',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  AddToFav(index: index)
                                                ]),
                                              );
                                            }));
                                      },
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      )));
                              //),
                            },
                            separatorBuilder: (ctx, index) {
                              return Divider();
                            },
                            itemCount: allDbsongs.length);
                      }))
            ],
          ),
        ),
      ),
      bottomSheet: MiniPlayer(),
    );
  }
}

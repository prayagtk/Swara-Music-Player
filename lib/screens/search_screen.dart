import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swara/models/songModel.dart';
import 'package:swara/screens/player.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchcontroller = TextEditingController();
  AssetsAudioPlayer _audioplayer = AssetsAudioPlayer.withId('0');
  List<Audio> allsongs = [];
  final box = SongBox.getinstance();
  late List<Songs> dbSongs;

  @override
  void initState() {
    dbSongs = box.values.toList();
    for (var item in dbSongs) {
      allsongs.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songName,
              artist: item.artist,
              id: item.id.toString())));
    }
    super.initState();
  }

  late List<Songs> DBSongs = List.from(dbSongs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade800,
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back)),
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: searchcontroller,
                      onChanged: (value) => searchList(value),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(hintText: 'Search'),
                    ),
                  ),
                ],
              ),
            ),
//---------------------(search History)-----------------------------------------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: DBSongs.length == 0
                    ? Center(
                        child: Text(
                          'Not found',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (ctx, index) {
                          Songs songz = DBSongs[index];
                          return ListTile(
                              onTap: (() {
                                _audioplayer.open(
                                    Playlist(
                                        audios: allsongs, startIndex: index),
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
                              title: Text(
                                songz.songName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              leading: QueryArtworkWidget(
                                id: songz.id,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                artworkBorder: BorderRadius.circular(50),
                                nullArtworkWidget: ClipRRect(
                                  child: Image.asset(
                                    'assets/Image/StBrARCw_400x400.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ));
                        },
                        separatorBuilder: (ctx, index) {
                          return Divider();
                        },
                        itemCount: DBSongs.length),
              ),
            )
          ],
        ));
  }

  void searchList(String value) {
    setState(() {
      DBSongs = dbSongs
          .where((element) =>
              element.songName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      allsongs.clear();
      for (var item in DBSongs) {
        allsongs.add(
          Audio.file(
            item.songurl.toString(),
            metas: Metas(
              artist: item.artist,
              title: item.songName,
              id: item.id.toString(),
            ),
          ),
        );
      }
    });
  }
}

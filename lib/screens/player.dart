import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swara/Favorite%20functions/a_t_fav_player.dart';
import 'package:swara/models/mostlyplayedModel.dart';
import 'package:swara/models/recentlyplaylstModel.dart';
import 'package:swara/models/songModel.dart';
import 'package:swara/screens/add_to_playlist.dart';
import 'package:swara/screens/HomeScreen_Portions/select_song_for_playlist.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final player = AssetsAudioPlayer.withId('0');
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isRepeat = false;
  late List<Songs> dbSongs;
  final box = SongBox.getinstance();
  List<MostlyPlayed> mostlyPlayedSongz = mostplayedBox.values.toList();
  @override
  void initState() {
    dbSongs = box.values.toList();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(builder: (context, playing) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return PlaylistSelection(songIndex: playing.index);
                  }));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
//----------------------------------(body)--------------------------------------
        body: Stack(
          fit: StackFit.expand,
          children: [
//-------------------------------(Image)----------------------------------------
            QueryArtworkWidget(
              id: int.parse(playing.audio.audio.metas.id!),
              type: ArtworkType.AUDIO,
              nullArtworkWidget: ClipRRect(
                child: Image.asset('assets/Image/mostlyPlayed.jpeg'),
              ),
              artworkBorder: BorderRadius.circular(0),
              artworkFit: BoxFit.cover,
            ),
//-----------------------(color shading)----------------------------------------
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.0),
                  ],
                  stops: const [
                    0.0,
                    0.4,
                    0.6,
                  ],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.deepPurple.shade800.withOpacity(0.9)
                    ])),
              ),
            ),
            SafeArea(
                child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
//------------------------------------------------(Space between app bar & Music Controls)--------------------------------------------------
                  SizedBox(
                    height: 500,
                  ),
//------------------------------------------------(Song Name)--------------------------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 250,
                          child: Marquee(
                            blankSpace: 20,
                            velocity: 30,
                            text: player.getCurrentAudioTitle,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
//------------------------------------------------(Favorite Button)--------------------------------------------------------------
                        Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: AddToFavo(
                                index: dbSongs.indexWhere((element) =>
                                    element.songName ==
                                    playing.audio.audio.metas.title)))
                      ],
                    ),
                  ),
//------------------------------------------------(Sizedbox)--------------------
                  SizedBox(
                    height: 10,
                  ),
//------------------------------------------------(Audio Progress Bar)-----------------------------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: PlayerBuilder.realtimePlayingInfos(
                        player: player,
                        builder: (context, realtimePlayingInfos) {
                          final duration =
                              realtimePlayingInfos.current!.audio.duration;
                          final position = realtimePlayingInfos.currentPosition;

                          return ProgressBar(
                            progress: position,
                            total: duration,
                            timeLabelPadding: 15,
                            timeLabelTextStyle:
                                const TextStyle(color: Colors.white),
                            onSeek: (duration) => player.seek(duration),
                          );
                        }),
                  ),
//------------------------------------------------(Music Duration)----------------------------------------------------------------------------
                  Row(
                    children: [
//----------------------------------------------(Shuffle)------------------------------------------------------------------------------------
                      Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: IconButton(
                              onPressed: () {
                                setState(() {});
                                player.toggleShuffle();
                              },
                              icon: player.isShuffling.value
                                  ? Icon(
                                      Icons.shuffle_on_outlined,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.shuffle,
                                      color: Colors.white,
                                    ))),
//---------------------------------------------(Previous)-----------------------------------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: PlayerBuilder.isPlaying(
                          player: player,
                          builder: ((context, isPlaying) {
                            return IconButton(
                                icon: playing.index == 0
                                    ? Icon(
                                        Icons.skip_previous,
                                        color: Colors.white24,
                                      )
                                    : Icon(
                                        Icons.skip_previous,
                                        color: Colors.white,
                                      ),
                                onPressed: playing.index == 0
                                    ? () {}
                                    : () async {
                                        setState(() {});
                                        await player.previous();
                                        setState(() {});
                                        if (isPlaying == false) {
                                          player.pause();
                                          setState(() {});
                                        }
                                      });
                          }),
                        ),
                      ),
//---------------------------------------------(Play/Pause)---------------------------------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60.0),
                                color: Colors.black38,
                                border: Border.all(color: Colors.white)),
                            child: PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) {
                                  return IconButton(
                                    onPressed: () {
                                      player.playOrPause();
                                    },
                                    icon: Icon(isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    color: Colors.white,
                                  );
                                })),
                      ),
//--------------------------------------------------(Next)-----------------------------------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: PlayerBuilder.isPlaying(
                          player: player,
                          builder: (context, isPlaying) {
                            return IconButton(
                              onPressed: playing.index ==
                                      playing.playlist.audios.length - 1
                                  ? () {}
                                  : () async {
                                      setState(() {});
                                      await player.next();
                                      setState(() {});
                                      RecentlyPlayed rpsongz;
                                      MostlyPlayed MPsongz =
                                          mostlyPlayedSongz[playing.index];
                                      rpsongz = RecentlyPlayed(
                                          songname: dbSongs[playing.index + 1]
                                              .songName,
                                          artist:
                                              dbSongs[playing.index + 1].artist,
                                          duration: dbSongs[playing.index + 1]
                                              .duration,
                                          songurl: dbSongs[playing.index + 1]
                                              .songurl,
                                          id: dbSongs[playing.index + 1].id);
                                      updateRecenltPlayed(
                                          rpsongz, playing.index + 1);
                                      updatePlayedSongCount(
                                          MPsongz, playing.index + 1);

                                      if (isPlaying == false) {
                                        player.pause();
                                        //setState(() {});
                                      }
                                    },
                              icon: playing.index ==
                                      playing.playlist.audios.length - 1
                                  ? Icon(
                                      Icons.skip_next,
                                      color: Colors.white24,
                                    )
                                  : Icon(
                                      Icons.skip_next,
                                      color: Colors.white,
                                    ),
                            );
                          },
                        ),
                      ),
//--------------------------------------------------(Repeat)--------------------------------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: IconButton(
                            onPressed: () {
                              if (isRepeat) {
                                player.setLoopMode(LoopMode.none);
                                isRepeat = false;
                              } else {
                                player.setLoopMode(LoopMode.single);
                                isRepeat = true;
                              }
                              setState(() {});
                            },
                            icon: isRepeat
                                ? const Icon(
                                    Icons.repeat_one,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.repeat,
                                    color: Colors.white,
                                  )),
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      );
    });
  }
}

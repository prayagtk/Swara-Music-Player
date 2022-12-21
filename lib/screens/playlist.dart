import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:swara/models/playlistmodel.dart';
import 'package:swara/models/songModel.dart';
import 'package:swara/mostlyplayed%20&%20recentlyplayed/mostlyplayed.dart';
import 'package:swara/screens/Playlist_Portions/Playlist_songs.dart';
import 'package:swara/screens/recentlyplayed.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  TextEditingController _texteditingcontroller = TextEditingController();
  TextEditingController _updateController = TextEditingController();

  List<Playlistsongz> playlist = [];
  final formGlobalKey = GlobalKey<FormState>();
  final updateformglobalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade800,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
//--------------------------(Top playlist box)----------------------------------

                Center(
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image: AssetImage(
                                'assets/Image/pngtree-modern-double-color-futuristic-neon-background-image_351866.jpg'),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 70,
                        ),
                        Icon(
                          Icons.queue_music_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          'Playlist',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),

//------------------------------(Sizebox)---------------------------------------
                SizedBox(
                  height: 20,
                ),
//-----------------(MostlyPlayed & Recently Played)-----------------------------
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
//---------------------(Mostly Played)------------------------------------------
                      child: Container(
                        height: 150,
                        width: 180,
                        child: Card(
                            clipBehavior: Clip.antiAlias,
                            color: Colors.black12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Ink.image(
                                  image: AssetImage(
                                    'assets/Image/mostlyPlayed.jpeg',
                                  ),
                                  fit: BoxFit.cover,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  MostlyPlayedSongs())));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 105),
                                  child: Text(
                                    'MostlyPlayed',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
//----------------------(Recently Plaed)----------------------------------------
                    Container(
                      height: 150,
                      width: 180,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.black12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Ink.image(
                              image: AssetImage(
                                'assets/Image/mostlyPlayed.jpeg',
                              ),
                              fit: BoxFit.cover,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              RecentlyPlayedSongs())));
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 105),
                              child: Text(
                                'RecentlyPlayed',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
//--------------------------(Sizebox)-------------------------------------------
                SizedBox(
                  height: 20,
                ),
//---------------------(Custom Playlists)---------------------------------------
                ValueListenableBuilder<Box<Playlistsongz>>(
                    valueListenable: playlistBox.listenable(),
                    builder: ((context, Box<Playlistsongz> plylst_box, child) {
                      List<Playlistsongz> play_list =
                          plylst_box.values.toList();
                      if (playlistBox.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Text(
                            "You have no playlist !",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                PlaylistSongs(
                                                    allPlaylistSongs:
                                                        play_list[index]
                                                            .playlistSongs!,
                                                    playlistIndex: index,
                                                    playlistName:
                                                        play_list[index]
                                                            .playlistName!))));
                                  },
                                  title: Text(
                                    play_list[index].playlistName.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  leading: Icon(
                                    Icons.folder_open,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor:
                                              Colors.purple.shade800,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      List<Songs>?
                                                          existingSongz =
                                                          play_list[index]
                                                              .playlistSongs;
                                                      editName(
                                                          context,
                                                          index,
                                                          play_list[index]
                                                              .playlistName!,
                                                          existingSongz!);
                                                    },
                                                    child: Text(
                                                      'Update Name',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      deletePlaylist(
                                                          context, index);
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ]),
                                            );
                                          }));
                                    },
                                    icon: Icon(Icons.more_vert),
                                    color: Colors.white,
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return Divider();
                              },
                              itemCount: play_list.length),
                        );
                      }
                    }))
              ],
            ),
          ),
        ),
      ),
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------(Floating Action Button)------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPlaylist(context);
        },
        child: Icon(
          Icons.playlist_add,
          color: Colors.white,
        ),
      ),
    );
  }

//----------------------(Add_playlist)------------------------------------------
  Future<void> addPlaylist(BuildContext context) async {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Colors.purple.shade600,
            title: const Center(
              child: Text(
                'Add New Plalist',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content:
//-----------------------(Add Playlist)-----------------------------------------
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: formGlobalKey,
                        child: TextFormField(
                          controller: _texteditingcontroller,
                          cursorHeight: 25,
                          decoration: InputDecoration(
                              filled: true,
                              //fillColor: Color.fromARGB(199, 255, 255, 255),
                              hintText: 'Enter Name',
                              hintStyle: TextStyle(color: Colors.white)),
                          validator: (value) {
                            List<Playlistsongz> values =
                                playlistBox.values.toList();
                            bool isAllreadyadded = values
                                .where((element) =>
                                    element.playlistName == value!.trim())
                                .isNotEmpty;
                            if (value!.trim() == '') {
                              return 'Name required';
                            }
                            if (isAllreadyadded) {
                              return 'Name is all ready exist';
                            }
                            return null;
                          },
                        ))),
            actions: [
              TextButton(
                  onPressed: () {
                    final isValid = formGlobalKey.currentState!.validate();
                    if (isValid) {
                      playlistBox.add(Playlistsongz(
                          playlistName: _texteditingcontroller.text,
                          playlistSongs: []));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        }));
  }

//-----------------------------(functions)--------------------------------------
//---------------------------------------------(Update_playlist)-------------------------------------------------------------------------------
  editName(BuildContext context, int index, String existing_name,
      List<Songs> existSongs) async {
    showDialog(
        context: context,
        builder: ((context) {
          _updateController.text = existing_name;
          return AlertDialog(
            backgroundColor: Colors.purple.shade600,
            title: const Center(
              child: Text(
                'Enter New Name',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content:
//---------------------------------------------------------(Add Playlist)-----------------------------------------------------------------------
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: updateformglobalkey,
                      child: TextFormField(
                          controller: _updateController,
                          cursorHeight: 25,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white)),
                          validator: (value) {
                            List<Playlistsongz> values =
                                playlistBox.values.toList();
                            bool isAlreadyExist = values
                                .where((element) =>
                                    element.playlistName == value!.trim())
                                .isNotEmpty;
                            if (value!.trim() == '') {
                              return 'Name required';
                            }
                            return null;
                          }),
                    )),
            actions: [
              TextButton(
                  onPressed: () {
                    final isvalid =
                        updateformglobalkey.currentState!.validate();
                    if (isvalid) {
                      playlistBox.putAt(
                          index,
                          Playlistsongz(
                              playlistName: _updateController.text,
                              playlistSongs: existSongs));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        }));
  }

//---------------------------------------------(Delete conformation)------------------------------------------------------------------------
  Future<void> deletePlaylist(BuildContext context, int index) async {
    showDialog(
        context: context,
        builder: (ctx1) {
          return AlertDialog(
            backgroundColor: Colors.purple.shade600,
            title: const Center(
              child: Text(
                'Delete',
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
                    onPressed: () {
                      playlistBox.deleteAt(index);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
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
}

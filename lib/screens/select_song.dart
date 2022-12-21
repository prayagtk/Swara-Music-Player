//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SelectSong extends StatefulWidget {
  SelectSong({super.key});

  @override
  State<SelectSong> createState() => _SelectSongState();
}

class _SelectSongState extends State<SelectSong> {
  // IconData play_button = Icons.play_arrow_rounded;

  // AudioPlayer audioplayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  // bool isplaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade900,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: Text('Select a song'),
      ),
      body: ListView.separated(
          itemBuilder: (ctx, index) {
            return ListTile(
                onLongPress: () {},
                title: Text(
                  'Song Name',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Singer Name',
                  style: TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage("assets/Image/StBrARCw_400x400.jpg"),
                ),
                trailing: IconButton(
                    onPressed: () {
                      showOptions(ctx);
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    )));
          },
          separatorBuilder: (ctx, index) {
            return Divider();
          },
          itemCount: 10),
    );
  }

//------------------------------------------------------------------------------------------------------------------------------------------------
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
                            Navigator.of(ctx1).pop();
                            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                              content: Text('Successfully Added '),
                              margin: EdgeInsets.all(10),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 1),
                            ));
                          },
                          icon: Icon(
                            Icons.add_outlined,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Add to Playlist_name',
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

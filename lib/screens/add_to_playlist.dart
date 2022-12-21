import 'package:flutter/material.dart';

class AddToPlaylist extends StatefulWidget {
  const AddToPlaylist({super.key});

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade800,
      appBar: AppBar(
        title: Text('Add to Playlist'),
        backgroundColor: Colors.purple.shade900,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 10,
          itemBuilder: (context, index) {
            return GridTile(
              child: InkWell(
                child: Container(
                  //---------------------------------------------------(card radius)--------------------------------------------------------------------------
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //--------------------------------------------------(card color)--------------------------------------------------------------------------
                    color: Colors.red,
                    //--------------------------------------------------(Background Image)-------------------------------------------------------------------
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/premium-vector/music-note-futuristic-icon-vector_53876-164772.jpg?w=2000'),
                        fit: BoxFit.cover),
                    //-------------------------------------------------()----------------------------------------------------------------------------------
                  ),
                  //-------------------------------------------------(Box Decoration end)----------------------------------------------------------------
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      //-------------------------------------------------(SizeBox)--------------------------------------------------------------------------------------
                      SizedBox(
                        height: 120,
                      ),
                      //-------------------------------------------------(Playlist Name)--------------------------------------------------------------------------------
                      Text(
                        'Playlist Name',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Successfully Added'),
                    margin: EdgeInsets.all(10),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 1),
                  ));
                  ;
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreateNewPlalist(context);
        },
        child: Icon(
          Icons.playlist_add,
          color: Colors.white,
        ),
      ),
    );
  }

//--------------------------------------------------(New Playlist Window)--------------------------------------------------------------------------
  Future CreateNewPlalist(BuildContext ctx) async {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx1) {
          return Container(
            color: Color.fromARGB(255, 45, 6, 94),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.purple.shade400,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//---------------------------------------------------------(Close Button and Headding)-------------------------------------------------------------------------
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(ctx1).pop();
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: Text(
                          'Create New Playlist',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
//---------------------------------------------------------(Add Playlist)-----------------------------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(hintText: 'Playlist name'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 300),
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Create',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }
}

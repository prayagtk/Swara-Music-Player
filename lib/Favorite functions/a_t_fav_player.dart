import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:swara/models/favoriteModel.dart';
import 'package:swara/models/songModel.dart';

class AddToFavo extends StatefulWidget {
  int index;
  AddToFavo({required this.index, super.key});

  @override
  State<AddToFavo> createState() => _AddToFavoState();
}

class _AddToFavoState extends State<AddToFavo> {
  List<Favorite> fav = [];
  bool favorited = false;
  final box = SongBox.getinstance();
  late List<Songs> dbSongs = box.values.toList();

  @override
  void initState() {
    dbSongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fav = favSongsDB.values.toList();
    return fav
            .where(
                (element) => element.songname == dbSongs[widget.index].songName)
            .isEmpty
        ? IconButton(
            onPressed: () {
              favSongsDB.add(Favorite(
                  songname: dbSongs[widget.index].songName,
                  artist: dbSongs[widget.index].artist,
                  duration: dbSongs[widget.index].duration,
                  songurl: dbSongs[widget.index].songurl,
                  id: dbSongs[widget.index].id));
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  "Added to Favorites",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.green,
              ));
            },
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ))
        : IconButton(
            onPressed: () async {
              if (favSongsDB.length < 1) {
                favSongsDB.clear();
                setState(() {});
              } else {
                int currentIndex = fav.indexWhere(
                    (element) => element.id == dbSongs[widget.index].id);
                await favSongsDB.deleteAt(currentIndex);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    "Removed From Favorites",
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.red,
                ));
              }
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:swara/models/favoriteModel.dart';
import 'package:swara/models/songModel.dart';

class AddToFav extends StatefulWidget {
  int index;
  AddToFav({required this.index, super.key});

  @override
  State<AddToFav> createState() => _AddToFavState();
}

class _AddToFavState extends State<AddToFav> {
  List<Favorite> fav = [];
  bool favorited = false;
  final box = SongBox.getinstance();
  late List<Songs> dbsongs;
  @override
  void initState() {
    dbsongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fav = favSongsDB.values.toList();
    return fav
            .where(
                (element) => element.songname == dbsongs[widget.index].songName)
            .isEmpty
        ? TextButton(
            onPressed: () {
              favSongsDB.add(Favorite(
                  songname: dbsongs[widget.index].songName,
                  artist: dbsongs[widget.index].artist,
                  duration: dbsongs[widget.index].duration,
                  songurl: dbsongs[widget.index].songurl,
                  id: dbsongs[widget.index].id));
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Added to favorite',
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.green,
              ));
            },
            child: const Text('Add To Favorites',
                style: TextStyle(color: Colors.white)))
        : TextButton(
            onPressed: () async {
              if (favSongsDB.length < 1) {
                favSongsDB.clear();
                setState(() {});
              } else {
                int currentIndex = fav.indexWhere(
                    (element) => element.id == dbsongs[widget.index].id);
                await favSongsDB.deleteAt(currentIndex);
                setState(() {});
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: const Text(
                    'Removied From Favorites',
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: const Text('Remove from favorite',
                style: TextStyle(color: Colors.white)));
  }
}

import 'package:hive_flutter/adapters.dart';
part 'favoriteModel.g.dart';

@HiveType(typeId: 1)
class Favorite {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  Favorite(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.songurl,
      required this.id});
}

String favBoxName = 'FavoriteSongszz';

late Box<Favorite> favSongsDB;
openFavoriteDatabase() async {
  favSongsDB = await await Hive.openBox<Favorite>(favBoxName);
}

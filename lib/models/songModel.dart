import 'package:hive_flutter/adapters.dart';
part 'songModel.g.dart';

@HiveType(typeId: 0)
class Songs {
  @HiveField(0)
  String? songName;

  @HiveField(1)
  String? artist;

  @HiveField(2)
  int? duration;

  @HiveField(3)
  String? songurl;

  @HiveField(4)
  int id;

  Songs(
      {required this.songName,
      required this.artist,
      required this.duration,
      required this.songurl,
      required this.id});
}

String boxname = 'songz';

class SongBox {
  static Box<Songs>? _box;
  static Box<Songs> getinstance() {
    return _box ??= Hive.box(boxname);
  }
}

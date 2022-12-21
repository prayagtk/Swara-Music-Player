import 'package:hive_flutter/adapters.dart';
import 'package:swara/models/songModel.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 2)
class Playlistsongz {
  @HiveField(0)
  String? playlistName;

  @HiveField(1)
  List<Songs>? playlistSongs;

  Playlistsongz({required this.playlistName, required this.playlistSongs});
}

late Box<Playlistsongz> playlistBox;
openPlaylistDB() async {
  playlistBox = await Hive.openBox<Playlistsongz>('playlistDB');
}

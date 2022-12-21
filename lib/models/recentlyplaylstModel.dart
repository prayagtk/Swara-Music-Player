import 'package:hive_flutter/adapters.dart';
part 'recentlyplaylstModel.g.dart';

@HiveType(typeId: 4)
class RecentlyPlayed {
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

  RecentlyPlayed(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.songurl,
      required this.id});
}

late Box<RecentlyPlayed> recentlyplayedbox;
openRecenlyPlayedDb() async {
  recentlyplayedbox = await Hive.openBox('recenlyplayed');
}

updateRecenltPlayed(RecentlyPlayed value, index) {
  List<RecentlyPlayed> list = recentlyplayedbox.values.toList();

  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;

  if (isAlready == true) {
    recentlyplayedbox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    recentlyplayedbox.deleteAt(index);
    recentlyplayedbox.add(value);
  }
}

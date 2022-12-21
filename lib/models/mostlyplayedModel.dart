import 'package:hive_flutter/adapters.dart';

part 'mostlyplayedModel.g.dart';

@HiveType(typeId: 3)
class MostlyPlayed {
  @HiveField(0)
  String? songname;

  @HiveField(1)
  String? artistname;

  @HiveField(2)
  int? duration;

  @HiveField(3)
  String? songurl;

  @HiveField(4)
  int count;

  @HiveField(5)
  int? id;

  MostlyPlayed(
      {required this.songname,
      required this.artistname,
      required this.duration,
      required this.songurl,
      required this.count,
      required this.id});
}

late Box<MostlyPlayed> mostplayedBox;
openMostPlayedDb() async {
  mostplayedBox = await Hive.openBox('mostplayedsngz');
}

updatePlayedSongCount(MostlyPlayed value, int index) {
  int count = value.count;
  value.count = count + 1;
  mostplayedBox.put(index, value);
}

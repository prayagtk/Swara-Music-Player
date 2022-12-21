// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mostlyplayedModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MostlyPlayedAdapter extends TypeAdapter<MostlyPlayed> {
  @override
  final int typeId = 3;

  @override
  MostlyPlayed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostlyPlayed(
      songname: fields[0] as String?,
      artistname: fields[1] as String?,
      duration: fields[2] as int?,
      songurl: fields[3] as String?,
      count: fields[4] as int,
      id: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MostlyPlayed obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artistname)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songurl)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostlyPlayedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

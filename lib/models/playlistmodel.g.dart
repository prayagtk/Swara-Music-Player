// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistsongzAdapter extends TypeAdapter<Playlistsongz> {
  @override
  final int typeId = 2;

  @override
  Playlistsongz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlistsongz(
      playlistName: fields[0] as String?,
      playlistSongs: (fields[1] as List?)?.cast<Songs>(),
    );
  }

  @override
  void write(BinaryWriter writer, Playlistsongz obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.playlistSongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistsongzAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

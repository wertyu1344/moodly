// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmojiAdapter extends TypeAdapter<Emoji> {
  @override
  final int typeId = 1;

  @override
  Emoji read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Emoji(
      number: fields[0] as int,
      name: fields[1] as String,
      url: fields[2] as String,
      color: fields[3] as Color,
    );
  }

  @override
  void write(BinaryWriter writer, Emoji obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmojiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

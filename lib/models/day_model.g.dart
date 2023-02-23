// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayModelAdapter extends TypeAdapter<DayModel> {
  @override
  final int typeId = 0;

  @override
  DayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayModel(
      day: fields[1] as String,
      isRecorded: fields[0] as bool,
      month: fields[2] as int,
      year: fields[3] as String,
      emoji: fields[6] as Emoji,
      title: fields[7] as String,
      userEmail: fields[8] as String,
      imgPath: fields[4] as String?,
      voicePath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DayModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.isRecorded)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.imgPath)
      ..writeByte(5)
      ..write(obj.voicePath)
      ..writeByte(6)
      ..write(obj.emoji)
      ..writeByte(7)
      ..write(obj.title)
      ..writeByte(8)
      ..write(obj.userEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

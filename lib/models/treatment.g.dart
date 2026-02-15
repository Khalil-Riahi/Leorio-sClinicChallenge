// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TreatmentAdapter extends TypeAdapter<Treatment> {
  @override
  final int typeId = 2;

  @override
  Treatment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Treatment(
      patientKey: fields[0] as int,
      date: fields[1] as DateTime,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Treatment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.patientKey)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TreatmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

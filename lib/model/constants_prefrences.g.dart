// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constants_prefrences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConstantsPrefrencesAdapter extends TypeAdapter<ConstantsPrefrences> {
  @override
  final int typeId = 3;

  @override
  ConstantsPrefrences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConstantsPrefrences(
      showDontHaveSecurity: fields[0] as bool,
      biometricAuthentication: fields[1] as bool,
      introductionShown: fields[2] as bool,
      isGoogleMap: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ConstantsPrefrences obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.showDontHaveSecurity)
      ..writeByte(1)
      ..write(obj.biometricAuthentication)
      ..writeByte(2)
      ..write(obj.introductionShown)
      ..writeByte(3)
      ..write(obj.isGoogleMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConstantsPrefrencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

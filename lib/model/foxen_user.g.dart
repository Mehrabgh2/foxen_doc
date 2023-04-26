// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foxen_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoxenUserAdapter extends TypeAdapter<FoxenUser> {
  @override
  final int typeId = 0;

  @override
  FoxenUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoxenUser(
      token: fields[0] as String?,
      user: fields[1] as User?,
    );
  }

  @override
  void write(BinaryWriter writer, FoxenUser obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoxenUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      accountId: fields[1] as int?,
      firstname: fields[2] as String?,
      lastname: fields[3] as String?,
      username: fields[4] as String?,
      nationalcode: fields[5] as String?,
      email: fields[6] as UserProperties?,
      phone: fields[7] as UserProperties?,
      address: fields[8] as String?,
      roleId: fields[9] as int?,
      registertimestamp: fields[10] as String?,
      userType: fields[11] as String?,
      photo: fields[12] as String?,
      access: fields[13] as String?,
      itemPerPage: fields[14] as int?,
      restriction: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.accountId)
      ..writeByte(2)
      ..write(obj.firstname)
      ..writeByte(3)
      ..write(obj.lastname)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.nationalcode)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.roleId)
      ..writeByte(10)
      ..write(obj.registertimestamp)
      ..writeByte(11)
      ..write(obj.userType)
      ..writeByte(12)
      ..write(obj.photo)
      ..writeByte(13)
      ..write(obj.access)
      ..writeByte(14)
      ..write(obj.itemPerPage)
      ..writeByte(15)
      ..write(obj.restriction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserPropertiesAdapter extends TypeAdapter<UserProperties> {
  @override
  final int typeId = 2;

  @override
  UserProperties read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProperties(
      name: fields[0] as String?,
      isVerified: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProperties obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPropertiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

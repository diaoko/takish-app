// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 11;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as dynamic,
      name: fields[1] as String,
      fName: fields[2] as String,
      lName: fields[3] as String,
      userTypeId: fields[4] as dynamic,
      customerId: fields[5] as dynamic,
      mandoobId: fields[6] as dynamic,
      isActiveAppMobile: fields[7] as dynamic,
      userName: fields[8] as dynamic,
      password: fields[9] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.fName)
      ..writeByte(3)
      ..write(obj.lName)
      ..writeByte(4)
      ..write(obj.userTypeId)
      ..writeByte(5)
      ..write(obj.customerId)
      ..writeByte(6)
      ..write(obj.mandoobId)
      ..writeByte(7)
      ..write(obj.isActiveAppMobile)
      ..writeByte(8)
      ..write(obj.userName)
      ..writeByte(9)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

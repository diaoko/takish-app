// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketItemModelAdapter extends TypeAdapter<TicketItemModel> {
  @override
  final int typeId = 2;

  @override
  TicketItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketItemModel(
      id: fields[0] as int,
      titlePackage: fields[1] as String,
      eventDate: fields[2] as String,
      createDate: fields[3] as String,
      price: fields[4] as String,
      title: fields[5] as String,
      qrText: fields[6] as String,
      status: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TicketItemModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titlePackage)
      ..writeByte(2)
      ..write(obj.eventDate)
      ..writeByte(3)
      ..write(obj.createDate)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.qrText)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

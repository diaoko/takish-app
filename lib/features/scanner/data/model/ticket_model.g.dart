// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketModelAdapter extends TypeAdapter<TicketModel> {
  @override
  final int typeId = 1;

  @override
  TicketModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketModel(
      ticketIds: (fields[0] as List).cast<int>(),
      id: fields[1] as int,
      company: fields[2] as String,
      date: fields[3] as String,
      price: fields[4] as double,
      count: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TicketModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.ticketIds)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.company)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

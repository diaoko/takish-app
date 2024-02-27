
import 'package:hive/hive.dart';

import '../../../../core/utils/enums/ticket_status.dart';

part 'ticket_item_model.g.dart';

@HiveType(typeId: 2)
class TicketItemModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String titlePackage;

  @HiveField(2)
  String eventDate;

  @HiveField(3)
  String createDate;

  @HiveField(4)
  String price;

  @HiveField(5)
  String title;

  @HiveField(6)
  String qrText;

  @HiveField(7)
  int status;

  TicketItemModel({
    required this.id,
    required this.titlePackage,
    required this.eventDate,
    required this.createDate,
    required this.price,
    required this.title,
    required this.qrText,
    required this.status,
  });

  factory TicketItemModel.fromJson(Map<String, dynamic> json, String qrText) {
    return TicketItemModel(
      id: json['I'],
      titlePackage: json['T'],
      eventDate: json['ED'],
      createDate: json['CD'],
      price: json['P'],
      title: json['S'],
      qrText: qrText,
      status: TicketStatus.valid.value,
    );
  }
}
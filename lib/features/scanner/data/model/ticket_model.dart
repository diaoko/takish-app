
import 'package:hive/hive.dart';

part 'ticket_model.g.dart';

@HiveType(typeId: 1)
class TicketModel {
  @HiveField(0)
  List<int> ticketIds;

  @HiveField(1)
  int id;

  @HiveField(2)
  String company;

  @HiveField(3)
  String date;

  @HiveField(4)
  double price;

  @HiveField(5)
  int count;

  TicketModel({
    required this.ticketIds,
    required this.id,
    required this.company,
    required this.date,
    required this.price,
    required this.count,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketIds: List.castFrom<dynamic, int>(json['ticketIds']),
      id: json['id'],
      company: json['company'],
      date: json['date'],
      price: json['price'],
      count: json['count'],
    );
  }
}
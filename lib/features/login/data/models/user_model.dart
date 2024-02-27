
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 11)
class UserModel {
  @HiveField(0)
  dynamic id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String fName;

  @HiveField(3)
  String lName;

  @HiveField(4)
  dynamic userTypeId;

  @HiveField(5)
  dynamic customerId;

  @HiveField(6)
  dynamic mandoobId;

  @HiveField(7)
  dynamic isActiveAppMobile;

  @HiveField(8)
  dynamic userName;

  @HiveField(9)
  dynamic password;

  UserModel({
    required this.id,
    required this.name,
    required this.fName,
    required this.lName,
    required this.userTypeId,
    required this.customerId,
    required this.mandoobId,
    required this.isActiveAppMobile,
    required this.userName,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      fName: json['fname'].toString(),
      lName: json['lname'].toString(),
      userTypeId: json['userTypeId'].toString(),
      customerId: json['customerId'].toString(),
      mandoobId: json['mandoobId'].toString(),
      isActiveAppMobile: json['isActiveAppMobile'],
      userName: json['userName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'fName': fName,
        'lName': lName,
        'userTypeId': userTypeId,
        'customerId': customerId,
        'mandoobId': mandoobId,
        'isActiveAppMobile': isActiveAppMobile,
        'userName': userName,
        'password': password,
      };
}

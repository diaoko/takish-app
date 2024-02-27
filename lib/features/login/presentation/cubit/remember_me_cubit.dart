import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/storage_constants.dart';

class RememberMeCubit extends Cubit<bool?> {
  final Box<dynamic> currentUserBox;

  RememberMeCubit({required this.currentUserBox})
      : super(currentUserBox.get(HiveKeys.isRememberMe, defaultValue: true));

  void toggle(bool? value) {
    emit(value);
  }
}

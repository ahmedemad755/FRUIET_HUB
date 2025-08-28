import 'dart:convert';

import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/shared_prefs_singelton.dart';
import 'package:e_commerce/featchers/auth/data/models/user_model.dart';

UserModel getUser() {
  var jsonString = Prefs.getString(kUserData);
  var userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}

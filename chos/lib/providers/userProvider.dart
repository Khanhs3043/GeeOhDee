import 'package:flutter/material.dart';

import '../models/myUser.dart';

class UserProvider with ChangeNotifier{
  MyUser? user;
  UserProvider({this.user});

}
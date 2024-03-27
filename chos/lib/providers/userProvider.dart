import 'package:flutter/material.dart';

import '../models/dog.dart';
import '../models/myUser.dart';
import '../services/dogService.dart';

class UserProvider with ChangeNotifier{
  bool state = false;
  MyUser? user;
  UserProvider({this.user});
  List<String>? list5Url = [];
  List<Dog>? listDog = [];
  change(){
    state = !state;
    notifyListeners();
  }
  Future getMoreDogs()async{
    var list = await DogService.getDogBreeds();
    listDog?.addAll(list);
    print(listDog!.length);
    notifyListeners();
  }
}
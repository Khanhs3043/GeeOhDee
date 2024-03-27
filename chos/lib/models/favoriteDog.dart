import 'dog.dart';

class FavoriteDog{
  int? id;
  Dog dog;
  String userId;

  FavoriteDog({required this.dog, required this.userId});

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'dogId': dog.id,
      'userId': userId,
    };
  }
}
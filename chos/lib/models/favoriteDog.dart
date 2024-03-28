import 'dog.dart';

class FavoriteDog{
  int? id;
  Dog dog;
  String userId;

  FavoriteDog({required this.dog, required this.userId, this.id});
  factory FavoriteDog.fromJson(Map<String, dynamic> json) {
    return FavoriteDog(
      id: json['id'],
      dog: Dog.fromJson2(json),
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'dogId': dog.id,
      'userId': userId,
      'weight' : dog.weight,
      'height' : dog.height,
      'name' : dog.name,
      'bred_for' : dog.bredFor,
      'breed_group' : dog.breedGroup,
      'life_span' : dog.lifeSpan,
      'temperament' : dog.temperament,
      'origin' : dog.origin,
      'reference_image_id' : dog.referenceImageId,
    };
  }
}
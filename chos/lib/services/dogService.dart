import 'dart:convert';

import '../models/dog.dart';
import 'package:http/http.dart' as http;
class DogService {

  static const String apiUrl = 'https://api.thedogapi.com/v1';
  static const String apiKey = 'live_dSiqhOSyHmHpZoc88BgXD8jk6FhdmuYhSy07mCd1zESZ7s7LSpy1JcajPHFHXqCT';
  static const int limit = 20;


  static Future<List<Dog>> getDogBreeds(int page) async {
    var url = Uri.parse('$apiUrl/breeds?limit=$limit&page=$page');
    var response = await http.get(url, headers: {'x-api-key': apiKey});

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Dog> dogs = data.map((json) => Dog.fromJson(json)).toList();
      return dogs;
    } else {
      throw Exception('Failed to load dog breeds');
    }
  }

  static Future<Dog> getDogBreedById(int id) async {
    var url = Uri.parse('$apiUrl/breeds/$id');
    var response = await http.get(url, headers: {'x-api-key': apiKey});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return Dog.fromJson(data);
    } else {
      throw Exception('Failed to load dog breed');
    }
  }
  static Future<String?> getDogImageById(String referenceImageId) async {
    var url = Uri.parse('$apiUrl/images/$referenceImageId');
    var response = await http.get(url, headers: {'x-api-key': apiKey});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['url'];
    } else {
      return null;
    }
  }

  static Future<List<String>?> getDogImageByName(String name, int numOfImage) async {
    var url = Uri.parse('https://dog.ceo/api/breed/$name/images/random/$numOfImage');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> imageUrls = data['message'];
      List<String> listStringImage = imageUrls.map((url) => url.toString()).toList();
      return listStringImage;
    } else {
      return null;
    }
  }

  static Future<List<String>?> getRandomDogImage( int numOfImage) async {
    var url = Uri.parse('https://dog.ceo/api/breeds/image/random/$numOfImage');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> imageUrls = data['message'];
      print(data);
      List<String> listStringImage = imageUrls.map((url) => url.toString()).toList();
      return listStringImage;
    } else {
      return null;
    }
  }
}

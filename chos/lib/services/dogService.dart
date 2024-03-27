import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/dog.dart';
import 'package:http/http.dart' as http;
class DogService {

  static const String apiUrl = 'https://api.thedogapi.com/v1';
  static const String apiKey = 'live_dSiqhOSyHmHpZoc88BgXD8jk6FhdmuYhSy07mCd1zESZ7s7LSpy1JcajPHFHXqCT';
  static const int limit = 20;
  static int page =0;
  static String getImageStringByReferenceId(String id){
    return NetworkImage("https://cdn2.thedogapi.com/images/$id.jpg")==null?"https://cdn2.thedogapi.com/images/$id.png":"https://cdn2.thedogapi.com/images/$id.jpg";
  }
  static Future<String> getImageUrl(String id) async {
    String imageUrl = "https://cdn2.thedogapi.com/images/$id.jpg";
    try {
      final response = await http.head(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // URL hình ảnh hợp lệ, trả về URL này
        return imageUrl;
      } else {
        // URL hình ảnh không hợp lệ, thay đổi định dạng URL và trả về URL mới
        imageUrl = "https://cdn2.thedogapi.com/images/$id.png";
        return imageUrl;
      }
    } catch (e) {
      // Xử lý nếu có lỗi xảy ra trong quá trình kiểm tra URL hình ảnh
      print("Error checking image URL: $e");
      // Trả về URL ban đầu (định dạng .jpg)
      return imageUrl;
    }
  }
  static Future<List<Dog>?> searchDogByName(String query)async{
    var url = Uri.parse('https://api.thedogapi.com/v1/breeds/search?q=$query');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Dog>? dogs = data.map((json) => Dog.fromJson(json)).toList();
      return dogs;
    } else {
      throw Exception('Failed to load dog breeds');
    }
  }

  static Future<List<String>> getPicAboutBreed(int breedId) async {
    var url = Uri.parse('https://api.thedogapi.com/v1/images/search?breed_id=$breedId&limit=5');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<String> dogImages = [];
      for(var i in data){
        dogImages.add(i['url']);
      }
      return dogImages;
    } else {
      throw Exception('Failed to load dog breeds');
    }
  }
  static Future<List<Dog>> getDogBreeds() async {
    var url = Uri.parse('https://api.thedogapi.com/v1/breeds?page=$page&limit=$limit');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Dog> dogs = data.map((json) => Dog.fromJson(json)).toList();
      page +=1;
      print(page);
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

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';

class CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSource(this.client);

  Future<List<Category>> fetchCategories() async {
    //final uri = Uri.https('mcdiyae.github.io', '/api-eazee/categories.json');
    final uri = Uri.https('recipe-api-express.onrender.com', '/api/categories');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

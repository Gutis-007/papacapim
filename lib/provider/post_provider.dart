import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import 'dart:convert'; 

class PostProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> fetchFeed() async {
    final response = await _apiService.getFeed();
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      _posts = data.map((post) => Post.fromJson(post)).toList();
      notifyListeners();
    }
  }

  Future<void> createPost(String content) async {
    final response = await _apiService.createPost(content);
    if (response.statusCode == 201) {
      fetchFeed(); // Atualiza o feed após criar um post
    }
  }
}
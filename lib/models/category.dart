import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final Icon icon; 

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}
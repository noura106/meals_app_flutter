import 'package:flutter/material.dart';

class Category {
  final Color color;
  final String id;

  const Category({
    required this.id,
    this.color = Colors.orange,
  });
}

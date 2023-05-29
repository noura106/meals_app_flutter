import 'package:flutter/material.dart';

enum Complexity { Simple, Challenging, Hard }
enum Affordability { Affordable,Pricey, Luxurious}

class Meal {
  final String id;
  final List<String> categories;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    required this.id,
    required this.categories,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}

// Meal m1 = Meal(
//   id: id,
//   categories: categories,
//   title: title,
//   imageUrl: imageUrl,
//   ingredients: ingredients,
//   steps: steps,
//   duration: duration,
//   complexity: complexity,
//   affordability: affordability,
//   isGlutenFree: isGlutenFree,
//   isLactoseFree: isLactoseFree,
//   isVegan: isVegan,
//   isVegeterian: isVegetarian,
// );

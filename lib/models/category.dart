import 'package:flutter/material.dart';

class Category {
  final String title;
  final Color color;
  const Category(this.title, this.color);
}

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  sweets,
  carbs,
  spices,
  convenience,
  hygiene,
  other
}

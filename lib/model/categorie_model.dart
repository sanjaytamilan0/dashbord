import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
  });
}

class StockCategory {
  final int id;
  final String name;
  final IconData icon;
  final Color color;
  final List<Product> products;

  StockCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.products,
  });
}

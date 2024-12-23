
import 'package:dashboard/main.dart';
import 'package:dashboard/model/categorie_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class StockListView extends StatelessWidget {
  final List<StockCategory> categories;

  const StockListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return StockCategoryTile(category: categories[index]);
      },
    );
  }
}

class StockCategoryTile extends StatelessWidget {
  final StockCategory category;

  const StockCategoryTile({super.key, required this.category});

  void _showProductDetail(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScaleTransitionDialog(
          product: product,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 300, // Minimum width
          maxWidth: 600, // Maximum width for responsiveness
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              leading: Icon(category.icon, color: category.color),
              title: Text(
                category.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: category.products.length,
                  itemBuilder: (context, index) {
                    final product = category.products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Quantity: ${product.quantity}'),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: GestureDetector(
                          onTap: () => _showProductDetail(context, product),
                          child: const Text(
                            'View Detail',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScaleTransitionDialog extends StatelessWidget {
  final Product product;

  const ScaleTransitionDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info, size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Quantity: ${product.quantity}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}



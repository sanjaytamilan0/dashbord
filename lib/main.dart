import 'dart:math';

import 'package:dashboard/contact_us/contact_us.dart';
import 'package:dashboard/dashbord/dashbord.dart';
import 'package:dashboard/service/service.dart';
import 'package:dashboard/stock/stock.dart';
import 'package:flutter/material.dart';

import 'model/categorie_model.dart';


void main() {
  runApp(const StockManagementApp());
}

class StockManagementApp extends StatelessWidget {
  const StockManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<StockCategory> stockCategories = [
    StockCategory(
      id: 1,
      name: 'Electronics',
      icon: Icons.devices,
      color: Colors.blue,
      products: [
        Product(id: 1, name: 'Smartphone', quantity: Random().nextInt(100) + 1),
        Product(id: 2, name: 'Laptop', quantity: Random().nextInt(100) + 1),
        Product(id: 3, name: 'Smartwatch', quantity: Random().nextInt(100) + 1),
        Product(id: 4, name: 'Headphones', quantity: Random().nextInt(100) + 1),
      ],
    ),
    StockCategory(
      id: 2,
      name: 'Furniture',
      icon: Icons.chair,
      color: Colors.green,
      products: [
        Product(id: 5, name: 'Office Chair', quantity: Random().nextInt(100) + 1),
        Product(id: 6, name: 'Table', quantity: Random().nextInt(100) + 1),
        Product(id: 7, name: 'Bookshelf', quantity: Random().nextInt(100) + 1),
        Product(id: 8, name: 'Sofa', quantity: Random().nextInt(100) + 1),
      ],
    ),
    StockCategory(
      id: 3,
      name: 'Clothing',
      icon: Icons.checkroom,
      color: Colors.purple,
      products: [
        Product(id: 9, name: 'T-Shirt', quantity: Random().nextInt(100) + 1),
        Product(id: 10, name: 'Jacket', quantity: Random().nextInt(100) + 1),
        Product(id: 11, name: 'Jeans', quantity: Random().nextInt(100) + 1),
        Product(id: 12, name: 'Shoes', quantity: Random().nextInt(100) + 1),
      ],
    ),
    StockCategory(
      id: 4,
      name: 'Food',
      icon: Icons.fastfood,
      color: Colors.orange,
      products: [
        Product(id: 13, name: 'Snacks', quantity: Random().nextInt(100) + 1),
        Product(id: 14, name: 'Fruits', quantity: Random().nextInt(100) + 1),
        Product(id: 15, name: 'Vegetables', quantity: Random().nextInt(100) + 1),
        Product(id: 16, name: 'Beverages', quantity: Random().nextInt(100) + 1),
      ],
    ),
    StockCategory(
      id: 5,
      name: 'Books',
      icon: Icons.book,
      color: Colors.red,
      products: [
        Product(id: 17, name: 'Fiction', quantity: Random().nextInt(100) + 1),
        Product(id: 18, name: 'Non-fiction', quantity: Random().nextInt(100) + 1),
        Product(id: 19, name: 'Comics', quantity: Random().nextInt(100) + 1),
        Product(id: 20, name: 'Educational', quantity: Random().nextInt(100) + 1),
      ],
    ),
  ];


  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.add(DashboardView(categories: stockCategories));
    _pages.add(StockListView(categories: stockCategories));
    _pages.add(const ServicesView());
    _pages.add(const AboutUsView());
    _pages.add(const ContactView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavigationHeader(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class NavigationHeader extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const NavigationHeader({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'StockMaster',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                NavigationButton(
                  title: 'Dashboard',
                  isSelected: selectedIndex == 0,
                  onTap: () => onDestinationSelected(0),
                ),
                NavigationButton(
                  title: 'Stock',
                  isSelected: selectedIndex == 1,
                  onTap: () => onDestinationSelected(1),
                ),
                NavigationButton(
                  title: 'Services',
                  isSelected: selectedIndex == 2,
                  onTap: () => onDestinationSelected(2),
                ),
                NavigationButton(
                  title: 'About Us',
                  isSelected: selectedIndex == 3,
                  onTap: () => onDestinationSelected(3),
                ),
                NavigationButton(
                  title: 'Contact',
                  isSelected: selectedIndex == 4,
                  onTap: () => onDestinationSelected(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationButton extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : _isHovered
                ? Theme.of(context).colorScheme.surfaceVariant
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: widget.isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}



class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Us',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Leading the Way in Stock Management Solutions',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'StockMaster has been at the forefront of inventory management innovation for over a decade. '
                          'We provide cutting-edge solutions that help businesses of all sizes optimize their stock control '
                          'and supply chain operations.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    const AboutUsCard(
                      icon: Icons.visibility,
                      title: 'Our Vision',
                      description: 'To revolutionize inventory management through innovative technology and exceptional service.',
                    ),
                    const SizedBox(height: 16),
                    const AboutUsCard(
                      icon: Icons.rocket_launch,
                      title: 'Our Mission',
                      description: 'Empowering businesses with smart, efficient, and reliable stock management solutions.',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              const Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Facts',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        QuickFactTile(
                          icon: Icons.people,
                          fact: '1000+ Clients',
                        ),
                        QuickFactTile(
                          icon: Icons.location_on,
                          fact: '25+ Countries',
                        ),
                        QuickFactTile(
                          icon: Icons.access_time,
                          fact: '10+ Years Experience',
                        ),
                        QuickFactTile(
                          icon: Icons.verified,
                          fact: '99.9% Accuracy',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AboutUsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const AboutUsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class QuickFactTile extends StatelessWidget {
  final IconData icon;
  final String fact;

  const QuickFactTile({
    super.key,
    required this.icon,
    required this.fact,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(
            fact,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}




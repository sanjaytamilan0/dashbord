
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  int? selectedServiceIndex;

  // List of service details
  final List<Map<String, String>> services = [
    {
      'title': 'Inventory Management',
      'description': 'Track and manage your stock efficiently',
      'details': 'Here you can efficiently track your stock levels and manage inventory seamlessly.'
    },
    {
      'title': 'Analytics',
      'description': 'Detailed insights and reports',
      'details': 'Gain insights into your business with powerful analytics and comprehensive reports.'
    },
    {
      'title': 'Supply Chain',
      'description': 'Optimize your supply chain',
      'details': 'Streamline your supply chain processes for maximum efficiency and productivity.'
    },
    {
      'title': 'Support',
      'description': '24/7 customer support',
      'details': 'Access round-the-clock customer support for all your needs and concerns.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: selectedServiceIndex == null ? 1 : 1, // Adjust space for the grid
          child: GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: selectedServiceIndex == null ? 2 : 1,
            childAspectRatio: 2.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: List.generate(services.length, (index) {
              final service = services[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedServiceIndex = index;
                  });
                },
                child: ServiceCard(
                  icon: _getIconForIndex(index),
                  title: service['title']!,
                  description: service['description']!,
                ),
              );
            }),
          ),
        ),
        if (selectedServiceIndex != null)
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ServiceDetail(
                service: services[selectedServiceIndex!],
                onClose: () {
                  setState(() {
                    selectedServiceIndex = null;
                  });
                },
              ),
            ),
          ),
      ],
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.inventory_2;
      case 1:
        return Icons.analytics;
      case 2:
        return Icons.local_shipping;
      case 3:
        return Icons.support_agent;
      default:
        return Icons.help;
    }
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceDetail extends StatelessWidget {
  final Map<String, String> service;
  final VoidCallback onClose;

  const ServiceDetail({
    super.key,
    required this.service,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              service['title']!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              service['details']!,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}

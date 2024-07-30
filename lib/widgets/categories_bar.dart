import 'package:flutter/material.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            CategoryItem(
                icon: Icons.whatshot, label: 'Popular', selected: true),
            CategoryItem(icon: Icons.local_pizza, label: 'Western'),
            CategoryItem(icon: Icons.local_cafe, label: 'Drinks'),
            CategoryItem(icon: Icons.local_dining, label: 'Local'),
            CategoryItem(icon: Icons.cake, label: 'Dessert'),
            // Ajoutez d'autres catégories ici si nécessaire
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: selected ? Colors.yellow : Colors.grey[200],
            child: Icon(icon, color: selected ? Colors.black : Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

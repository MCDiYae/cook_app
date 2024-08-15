import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;

  const RecipePage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              
              background: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // Handle adding to favorites
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildSection('Ingredients', ingredients),
              _buildSection('Steps', steps),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 18)),
                    Expanded(child: Text(item, style: const TextStyle(fontSize: 16))),
                  ],
                ),
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
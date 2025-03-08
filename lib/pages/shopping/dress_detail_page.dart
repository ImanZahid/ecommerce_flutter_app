import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:flutter/material.dart';

//for AHMET to design and fix - just a dummy page

class DressDetailPage extends StatelessWidget {
  final DressModel dress;

  const DressDetailPage({super.key, required this.dress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dress.name)),
      body: Column(
        children: [
          Image.network(dress.image, height: 300, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              dress.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Text("\$${dress.price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 22, color: Colors.pink)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Added to cart!")),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text("Add to Cart"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
          ),
        ],
      ),
    );
  }
}
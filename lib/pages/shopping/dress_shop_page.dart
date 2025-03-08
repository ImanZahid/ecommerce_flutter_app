import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:ecommerce_flutter_app/pages/shopping/dress_detail_page.dart';
import 'package:flutter/material.dart';

class DressShopPage extends StatelessWidget {
    DressShopPage({super.key});

//fix this later
  final List<DressModel> dresses = [
    DressModel(name: "Red Gown", image: "", price: 49.99, quantity: 10),
    DressModel(name: "Blue Dress", image: "", price: 39.99, quantity: 10),
    DressModel(name: "Green Outfit", image: "", price: 59.99, quantity: 10),
    DressModel(name: "Yellow Summer Dress", image: "", price: 29.99, quantity: 10),
    DressModel(name: "Purple Evening Dress", image: "", price: 79.99, quantity: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dressing Shopping"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cart functionality coming soon!")),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: GridView.builder(
          itemCount: dresses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final dress = dresses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DressDetailPage(dress: dress),
                  ),
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          dress.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        dress.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("\$${dress.price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

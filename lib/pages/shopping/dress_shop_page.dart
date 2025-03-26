import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:ecommerce_flutter_app/pages/shopping/dress_detail_page.dart';
import 'package:ecommerce_flutter_app/pages/shopping/cart_page.dart'; // <-- make sure this import exists
import 'package:flutter/material.dart';

class DressShopPage extends StatefulWidget {
  DressShopPage({super.key});

  final List<DressModel> dresses = [
    DressModel(name: "Red Gown", image: "assets/images/surprise.gif", price: 49.99, quantity: 10),
    DressModel(name: "Blue Dress", image: "assets/images/surprise.gif", price: 39.99, quantity: 10),
    DressModel(name: "Green Outfit", image: "assets/images/surprise.gif", price: 59.99, quantity: 10),
    DressModel(name: "Yellow Summer Dress", image: "assets/images/surprise.gif", price: 29.99, quantity: 10),
    DressModel(name: "Purple Evening Dress", image: "assets/images/surprise.gif", price: 79.99, quantity: 10),
  ];

  @override
  _DressShopPageState createState() => _DressShopPageState();
}

class _DressShopPageState extends State<DressShopPage> {
  Map<int, bool> hoverStates = {};
  List<DressModel> cart = [];

  void addToCart(DressModel dress) {
    setState(() {
      cart.add(dress);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${dress.name} added to cart!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dress Shop", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${cart.length}",
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cartItems: cart,
                    onPurchase: () {
                      setState(() {
                        cart.clear();
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: widget.dresses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.80,
          ),
          itemBuilder: (context, index) {
            final dress = widget.dresses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DressDetailPage(
                      dress: dress,
                      onAddToCart: addToCart,
                    ),
                  ),
                );
              },
              child: MouseRegion(
                onEnter: (_) => onHover(index, true),
                onExit: (_) => onHover(index, false),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: hoverStates[index] == true ? 1.05 : 1.0,
                  child: Card(
                    elevation: hoverStates[index] == true ? 12 : 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Hero(
                              tag: dress.name,
                              child: dress.image.isNotEmpty
                                  ? Image.asset(
                                      dress.image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: const Center(
                                          child: Icon(Icons.image, size: 50, color: Colors.grey)),
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                          child: Text(
                            dress.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "\$${dress.price.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 14, color: Colors.green[700], fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Colors.blueAccent,
                            ),
                            onPressed: () {
                              addToCart(dress);
                            },
                            child: const Text("Buy Now", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void onHover(int index, bool isHovered) {
    setState(() {
      hoverStates[index] = isHovered;
    });
  }
}

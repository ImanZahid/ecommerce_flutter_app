import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<DressModel> cartItems;
  final VoidCallback onPurchase;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onPurchase,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<DressModel> localCart;

  @override
  void initState() {
    super.initState();
    // Copy incoming cart items to local list for reactivity
    localCart = List.from(widget.cartItems);
  }

  double get totalPrice => localCart.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: localCart.isEmpty
                ? const Center(
                    child: Text(
                      "Your cart is empty.",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: localCart.length,
                    itemBuilder: (context, index) {
                      final item = localCart[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(item.name),
                        subtitle: const Text("Color: -"),
                        trailing: Text(
                          "\$${item.price.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Total: \$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Clear both local and main cart
                    setState(() {
                      localCart.clear();
                    });
                    widget.onPurchase(); // Clear main cart

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Success"),
                        content: const Text("Purchase successful!"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text("Buy"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

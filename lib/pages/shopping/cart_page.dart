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
  Map<DressModel, int> itemQuantities = {};

  @override
  void initState() {
    super.initState();
    localCart = List.from(widget.cartItems);
    for (var item in localCart) {
      itemQuantities[item] = (itemQuantities[item] ?? 0) + 1;
    }
  }

  double get totalPrice {
    double sum = 0;
    itemQuantities.forEach((item, qty) {
      sum += item.price * qty;
    });
    return sum;
  }

  void increaseQuantity(DressModel item) {
    setState(() {
      itemQuantities[item] = (itemQuantities[item] ?? 0) + 1;
    });
  }

  void decreaseQuantity(DressModel item) {
    setState(() {
      final currentQty = itemQuantities[item] ?? 1;
      if (currentQty > 1) {
        itemQuantities[item] = currentQty - 1;
      } else {
        itemQuantities.remove(item);
        localCart.remove(item);
      }
    });
  }

  void clearCart() {
    setState(() {
      localCart.clear();
      itemQuantities.clear();
    });
    widget.onPurchase();
  }

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
                      final quantity = itemQuantities[item] ?? 1;
                      final itemTotal = item.price * quantity;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  const Text("Color: -", style: TextStyle(fontSize: 14, color: Colors.grey)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "\$${itemTotal.toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => decreaseQuantity(item),
                                      icon: const Icon(Icons.remove_circle_outline),
                                      iconSize: 20,
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      onPressed: () => increaseQuantity(item),
                                      icon: const Icon(Icons.add_circle_outline),
                                      iconSize: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
                    clearCart();
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

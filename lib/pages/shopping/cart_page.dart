// pages/shopping/cart_page.dart
import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CartPage extends StatefulWidget {
  /// List that comes from the shop; may contain duplicates
  final List<DressModel> cartItems;

  /// Callback executed after a successful purchase
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
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playSound() async {
    try {
      // Load and play the sound file
      await _audioPlayer.play(AssetSource('assets/images/success.mp3'));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  /// key => quantity for each product-color variant
  late Map<String, int> _qty;

  /// key => DressModel (used for UI rendering)
  late Map<String, DressModel> _itemByKey;

  /// Builds a unique key using product name + selected color index
  String _buildKey(DressModel d) => '${d.name}_${d.selectedColorIndex}';

  // ────────────────────────────────────────────────────────────────
  // LIFECYCLE
  // ────────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();

    _qty       = {};
    _itemByKey = {};

    // Group identical variants so they appear once with a qty counter
    for (final item in widget.cartItems) {
      final k = _buildKey(item);
      _qty[k]       = (_qty[k] ?? 0) + 1;
      _itemByKey[k] = item; // only first occurrence kept
    }
  }

  // ────────────────────────────────────────────────────────────────
  // HELPERS
  // ────────────────────────────────────────────────────────────────

  /// Calculates cart total every time UI rebuilds
  double get _totalPrice {
    double sum = 0;
    _qty.forEach((k, q) => sum += _itemByKey[k]!.price * q);
    return sum;
  }

  /// Increment quantity for a given key
  void _inc(String k) => setState(() => _qty[k] = _qty[k]! + 1);

  /// Decrement quantity or remove item if it reaches zero
  void _dec(String k) {
    setState(() {
      final newVal = _qty[k]! - 1;
      if (newVal > 0) {
        _qty[k] = newVal;
      } else {
        _qty.remove(k);
        _itemByKey.remove(k);
      }
    });
  }

  /// Empties the cart and triggers the parent callback
  void _clearCart() {
    setState(() {
      _qty.clear();
      _itemByKey.clear();
    });
    widget.onPurchase();
  }

  // ────────────────────────────────────────────────────────────────
  // UI
  // ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final keys = _itemByKey.keys.toList(); // one line per variant

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
          // Cart list ----------------------------------------------------------
          Expanded(
            child: keys.isEmpty
                ? const Center(
                    child: Text("Your cart is empty.",
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                  )
                : ListView.builder(
                    itemCount: keys.length,
                    itemBuilder: (_, index) {
                      final k        = keys[index];
                      final item     = _itemByKey[k]!;
                      final qty      = _qty[k]!;
                      final lineTot  = item.price * qty;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // product image -----------------------------------
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
                            // name + color badge -----------------------------
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  const Text("Color:",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: item
                                          .getColors()[item.selectedColorIndex],
                                      border: Border.all(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // price + qty controls ---------------------------
                            Column(
                              children: [
                                Text("\$${lineTot.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      iconSize: 20,
                                      onPressed: () => _dec(k),
                                    ),
                                    Text('$qty',
                                        style: const TextStyle(fontSize: 16)),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      iconSize: 20,
                                      onPressed: () => _inc(k),
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
          // Summary + Buy button ----------------------------------------------
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Total: \$${_totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  child: const Text("Buy"),
                  onPressed: () {
                    _playSound(); // Play sound
                    _clearCart();
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

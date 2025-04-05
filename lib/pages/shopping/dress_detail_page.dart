import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:flutter/material.dart';

class DressDetailPage extends StatefulWidget {
  final DressModel dress;
  final void Function(DressModel) onAddToCart;

  const DressDetailPage({
    super.key,
    required this.dress,
    required this.onAddToCart,
  });
  
  @override
  State<DressDetailPage> createState() => _DressDetailPageState();
}
class _DressDetailPageState extends State<DressDetailPage> {
  late final List<Color> colorOptions;
  
  @override
  void initState() {
    super.initState();
    colorOptions = widget.dress.colors;
    }

  int selectedColorIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 110, 15, 47),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero animation for image transition
            Hero(
              tag: widget.dress.name,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    colorOptions[selectedColorIndex],
                    BlendMode.modulate,
                    ),
                    child: Image.asset(
                      widget.dress.image,
                      width: screenWidth,
                      height: screenWidth,
                      fit: BoxFit.cover,
                      ),
                    ),
              ),
            ),
            
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedColorIndex = (selectedColorIndex - 1 + colorOptions.length) % colorOptions.length;
                    });
                  },
                  icon: const Icon(Icons.arrow_left, size: 32),
                ),
                Row(
                  children: List.generate(colorOptions.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColorIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == selectedColorIndex
                              ? colorOptions[index]
                              : colorOptions[index]/*.withOpacity(0.3)*/,
                            border: Border.all(
                              color: index == selectedColorIndex
                              ? Colors.black
                              : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                        ),
                      );
                    }),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedColorIndex = (selectedColorIndex + 1) % colorOptions.length;
                    });
                  },
                  icon: const Icon(Icons.arrow_right, size: 32),
                ),
              ],
            ),

            // Name, price and description
             Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dress.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${widget.dress.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "This is an amazing dress. It's perfect for any special occasion, and its comfortable fit makes it ideal for all-day wear. Get yours today!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final itemWithColor = DressModel(
                          name: widget.dress.name,
                          price: widget.dress.price,
                          image: widget.dress.image,
                          quantity: widget.dress.quantity,
                          colors: widget.dress.colors,
                          selectedColorIndex: selectedColorIndex,
                        );
                        widget.onAddToCart(itemWithColor);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${widget.dress.name} added to cart!"),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("Add to Cart"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.pinkAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

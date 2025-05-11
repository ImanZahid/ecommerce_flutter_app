import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:ecommerce_flutter_app/data/dress_data.dart';
import 'package:ecommerce_flutter_app/pages/shopping/dress_detail_page.dart';
import 'package:ecommerce_flutter_app/pages/shopping/cart_page.dart'; // <-- make sure this import exists
import 'package:flutter/material.dart';

class DressShopPage extends StatefulWidget {
  DressShopPage({super.key});
  final List<DressModel> dresses = dressdata;

  @override
  _DressShopPageState createState() => _DressShopPageState();
}

class _DressShopPageState extends State<DressShopPage> {
  Map<int, bool> hoverStates = {};
  List<DressModel> cart = [];
  bool showOnlySkirts = false; 

  late List<DressModel> displayItems;

  @override
  void initState() {
    super.initState();
    // Initialize with all items
    displayItems = widget.dresses;
  }

  void addToCart(DressModel dress) {
    setState(() {
      cart.add(dress);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("${dress.name} added to cart!")));
  }

  void filterItems() {
    setState(() {
      if (showOnlySkirts) {
        // Show only items with "Skirt" in their name
        displayItems =
            widget.dresses
                .where((dress) => dress.name.toLowerCase().contains('skirt'))
                .toList();
      } else {
        
        displayItems = widget.dresses;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            showOnlySkirts ? Icons.filter_list_alt : Icons.filter_list,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              showOnlySkirts = !showOnlySkirts;
              filterItems();
            });
            // Show a message indicating the filter status
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  showOnlySkirts ? "Showing only skirts" : "Showing all items",
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          tooltip: 'Filter Skirts',
        ),
        title: const Text(
          "Dress Shop",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 161, 25, 240),
        centerTitle: true,
        elevation: 10,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart, color: Colors.white),
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
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CartPage(
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 247, 247, 247),
              const Color.fromARGB(255, 214, 203, 221),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              displayItems.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No skirts found",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showOnlySkirts = false;
                              filterItems();
                            });
                          },
                          child: const Text("Show All Items"),
                        ),
                      ],
                    ),
                  )
                  : GridView.builder(
                    itemCount: displayItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final dress = displayItems[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => DressDetailPage(
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
                            scale: hoverStates[index] == true ? 1.01 : 1.0,
                            child: Card(
                              elevation: hoverStates[index] == true ? 10 : 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              color: Colors.white,
                              shadowColor: Colors.black /*.withOpacity(0.3)*/,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(18),
                                      ),
                                      child: Hero(
                                        tag: dress.name,
                                        child:
                                            dress.image.isNotEmpty
                                                ? ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                    dress.colors.first,
                                                    BlendMode.modulate,
                                                  ),
                                                  child: Image.asset(
                                                    dress.image,
                                                    width: double.infinity,
                                                    fit: BoxFit.contain,
                                                  ),
                                                )
                                                : Container(
                                                  width: double.infinity,
                                                  color: Colors.grey[300],
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.image,
                                                      size: 50,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      dress.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    child: Text(
                                      "\$${dress.price.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        backgroundColor: Colors.deepOrange,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                      ),
                                      onPressed: () {
                                        addToCart(dress);
                                      },
                                      child: const Text(
                                        "Buy Now",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
        },
      ),
    );
  }

  void onHover(int index, bool isHovered) {
    setState(() {
      hoverStates[index] = isHovered;
    });
  }
}

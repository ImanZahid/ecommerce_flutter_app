import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:ecommerce_flutter_app/pages/shopping/dress_detail_page.dart';
import 'package:ecommerce_flutter_app/pages/shopping/cart_page.dart'; // <-- make sure this import exists
import 'package:flutter/material.dart';

class DressShopPage extends StatefulWidget {
  DressShopPage({super.key});

  final List<DressModel> dresses = [
    DressModel(name: "Dress 1", image: "assets/images/dress1.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 160, 216, 6), const Color.fromARGB(255, 108, 196, 7), Colors.purple, const Color.fromARGB(255, 248, 35, 99)],),
    DressModel(name: "Dress 2", image: "assets/images/dress2.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 106, 106), const Color.fromARGB(255, 64, 224, 70), const Color.fromARGB(255, 62, 75, 255)], ),
    DressModel(name: "Dress 3", image: "assets/images/dress3.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 139, 179, 255), const Color.fromARGB(255, 97, 97, 97), Colors.white, const Color.fromARGB(255, 255, 72, 39)]),
    DressModel(name: "Dress 4", image: "assets/images/dress4.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 255, 255), Colors.blue, Colors.purple, const Color.fromARGB(255, 255, 116, 220)],),
    DressModel(name: "Dress 5", image: "assets/images/dress5.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 91, 255, 228), const Color.fromARGB(255, 239, 247, 127), const Color.fromARGB(255, 255, 147, 147)]),
    DressModel(name: "Top 1", image: "assets/images/top1.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 86, 122), Colors.white, const Color.fromARGB(255, 79, 100, 218)]),
    DressModel(name: "Top 2", image: "assets/images/top2.png", price: 39.99, quantity: 1,
      colors: [Colors.red, Colors.blue, Colors.purple],),
    DressModel(name: "Top 3", image: "assets/images/top3.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 255, 180, 180), const Color.fromARGB(255, 219, 255, 161)]),
    DressModel(name: "Top 4", image: "assets/images/top4.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 24, 78, 114), Colors.white, const Color.fromARGB(255, 255, 51, 51)]),
    DressModel(name: "Top 5", image: "assets/images/top5.png", price: 39.99, quantity: 1,
      colors: [Colors.white, Colors.red, Colors.blue, Colors.purple],),
    DressModel(name: "Bottom 1", image: "assets/images/bottom1.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 75, 255, 171), const Color.fromARGB(255, 255, 146, 73), Colors.white]),
    DressModel(name: "Bottom 2", image: "assets/images/bottom2.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 88, 88, 88), Colors.white, const Color.fromARGB(255, 52, 83, 221)]),
    DressModel(name: "Bottom 3", image: "assets/images/bottom3.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 6, 122, 255), const Color.fromARGB(255, 22, 48, 70), Colors.purple],),
    DressModel(name: "Bottom 4", image: "assets/images/bottom4.png", price: 39.99, quantity: 1,
      colors: [Colors.orange, const Color.fromARGB(255, 255, 35, 171), const Color.fromARGB(255, 23, 218, 23)]),
    DressModel(name: "Bottom 5", image: "assets/images/bottom5.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 16, 95), const Color.fromARGB(255, 38, 176, 255), const Color.fromARGB(255, 124, 25, 25)]),
    DressModel(name: "Shoe 1", image: "assets/images/shoes1.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 111, 190, 255), const Color.fromARGB(255, 0, 0, 0)],),
    DressModel(name: "Shoe 2", image: "assets/images/shoes2.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 255, 34, 89), const Color.fromARGB(255, 134, 173, 255)]),
    DressModel(name: "Shoe 3", image: "assets/images/shoes3.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 119, 48, 20), Colors.white, const Color.fromARGB(255, 177, 118, 255)]),
    DressModel(name: "Shoe 4", image: "assets/images/shoes4.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 189, 37, 26), const Color.fromARGB(255, 48, 48, 48), const Color.fromARGB(255, 255, 255, 255)],),
    DressModel(name: "Shoe 5", image: "assets/images/shoes5.png", price: 39.99, quantity: 1,
      colors: [Colors.white, const Color.fromARGB(255, 129, 80, 7), const Color.fromARGB(255, 85, 193, 255)]),
    //DressModel(name: "Mystery Item", image: "assets/images/surprise.gif", price: 79.99, quantity: 1),
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
        title: const Text("Dress Shop", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 161, 25, 240),
        centerTitle: true,
        elevation: 10,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart, color: Colors.white,),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 247, 247, 247), const Color.fromARGB(255, 214, 203, 221)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: widget.dresses.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
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
                    scale: hoverStates[index] == true ? 1.01 : 1.0,
                    child: Card(
                      elevation: hoverStates[index] == true ? 10 : 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: Colors.white,
                      shadowColor: Colors.black/*.withOpacity(0.3)*/,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                              child: Hero(
                                tag: dress.name,
                                child: dress.image.isNotEmpty ? ColorFiltered(
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
                                      child: Icon(Icons.image, size: 50, color: Colors.grey)),
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                            child: Text(
                              dress.name,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "\$${dress.price.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 16, color: Colors.green[700], fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), backgroundColor: Colors.deepOrange,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                              ),
                              onPressed: () {
                                addToCart(dress);
                              },
                              child: const Text("Buy Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle bottom navigation bar taps
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

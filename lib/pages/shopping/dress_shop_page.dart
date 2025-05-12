import 'package:ecommerce_flutter_app/domain/repositories/dress_repository.dart';
import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:ecommerce_flutter_app/data/dress_data.dart';
import 'package:ecommerce_flutter_app/firebase/firebase_manager.dart';
import 'package:ecommerce_flutter_app/pages/shopping/dress_detail_page.dart';
import 'package:ecommerce_flutter_app/pages/shopping/cart_page.dart'; // <-- make sure this import exists
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter_app/sqlite/sqlite_manager.dart';

class DressShopPage extends StatefulWidget {
  const DressShopPage({super.key});

  @override
  State<DressShopPage> createState() => _DressShopPageState();
}

class _DressShopPageState extends State<DressShopPage> {
  //int currentIndex = 0;
  Map<int, bool> hoverStates = {};
  List<DressModel> cart = [];
  bool showOnlySkirts = false;
  bool isLoading = true;

  List<DressModel> dresses = [];
  List<DressModel> displayItems = [];
  final DressRepository _dressRepository = DressRepository(firebaseFirestore: FirebaseManager().firestore);

  @override
  void initState() {
    super.initState();
    //check if we have dress data in the database, otherwise populate it first
    fetchDresses();
  }

  Future<void> fetchDresses() async {
    List<DressModel> dressStock = await _dressRepository.getDresses();
    if (dressStock.isEmpty) {
        //update database with the stock
        await _dressRepository.updateStock(dressdata);
        //assign the dressdata stock
        dressStock = dressdata;
    }
    setState(() {
      isLoading = false;
      dresses = dressStock;
      displayItems = dresses;
    });
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
        try {
          DatabaseHelper().getAllDressNames().then((dressesFromDb) {
            displayItems = dresses.where((dress) {
              return dressesFromDb.contains(dress.name);
            }).toList();
          });
        } catch (e) {
          print("Error while accessing the database: $e");
        }
      } else {
        displayItems = dresses;
      }
    });
  }

  void openDetailPage(DressModel dress) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DressDetailPage(
          dress: dress,
          onAddToCart: addToCart,
        ),
      ),
    );
  }

  Widget _buildLuxuryDress(DressModel dress, VoidCallback onTap, VoidCallback onAddToCart) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: const Color(0xFFFBE7C6),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.amber, width: 3),
      ),
      shadowColor: Colors.amberAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: dress.name,
              child: dress.image.isNotEmpty
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        dress.getColors().first,
                        BlendMode.modulate,
                      ),
                      child: Image.asset(
                        dress.image,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dress.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('\$${dress.price}',
                    style: const TextStyle(color: Colors.black87, fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.deepOrange),
                      onPressed: onAddToCart,
                    ),
                    const Text("Buy Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildStealDress(DressModel dress, VoidCallback onTap, VoidCallback onAddToCart) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: const Color(0xFFFFE5E5),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Colors.redAccent, width: 2),
      ),
      shadowColor: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: dress.name,
              child: dress.image.isNotEmpty
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        dress.getColors().first,
                        BlendMode.modulate,
                      ),
                      child: Image.asset(
                        dress.image,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dress.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('\$${dress.price}',
                    style: const TextStyle(color: Colors.red, fontSize: 15)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.red),
                      onPressed: onAddToCart,
                    ),
                    const Text("Buy Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }


  Widget _buildNormalDress(DressModel dress, VoidCallback onTap, VoidCallback onAddToCart) {
    return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: dress.name,
              child: dress.image.isNotEmpty
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        dress.getColors().first,
                        BlendMode.modulate,
                      ),
                      child: Image.asset(
                        dress.image,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dress.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${dress.price}', style: const TextStyle(color: Colors.grey)),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.add_shopping_cart), onPressed: onAddToCart),
                    const Text("Buy Now", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
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
                  showOnlySkirts ? "Showing only designer items" : "Showing all items",
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          tooltip: 'Filter Designer Items',
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
      body: isLoading? Center(child: CircularProgressIndicator()): Container(
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
                          Widget buildDressCard() {
                            if (dress.price >= 100) {
                              return _buildLuxuryDress(
                                dress,
                                () => openDetailPage(dress),
                                () => addToCart(dress),
                              );
                            } else if (dress.price <= 25) {
                              return _buildStealDress(
                                dress,
                                () => openDetailPage(dress),
                                () => addToCart(dress),
                              );
                            } else {
                              return _buildNormalDress(
                                dress,
                                () => openDetailPage(dress),
                                () => addToCart(dress),
                              );
                            }
                          }
                          return MouseRegion(
                            onEnter: (_) => onHover(index, true),
                            onExit: (_) => onHover(index, false),
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 200),
                              scale: hoverStates[index] == true ? 1.01 : 1.0,
                              child: buildDressCard(),
                            ),
                          );
                        }
                    /*itemBuilder: (context, index) {
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
                                                    dress.getColors().first,
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
                    },*/
                  ),
        ),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),/*
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),*/
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
        },
      ),*/
    );
  }

  void onHover(int index, bool isHovered) {
    setState(() {
      hoverStates[index] = isHovered;
    });
  }
}

import 'package:ecommerce_flutter_app/data/rating_data.dart';
import 'package:ecommerce_flutter_app/domain/repositories/dress_rating_repository.dart';
import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:ecommerce_flutter_app/domain/user/user_model.dart';
import 'package:ecommerce_flutter_app/firebase/firebase_manager.dart';
import 'package:ecommerce_flutter_app/domain/shopping/rating_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late final List<RatingModel> ratingsData;
  final DressRatingRepository _ratingRepository = DressRatingRepository(firebaseFirestore: FirebaseManager().firestore);
  late TextEditingController _commentController;
  int selectedColorIndex = 0;
  bool isLoading = true;
  String commentText = '';
  double selectedStar = 0;
  final String TEMP_USER = "TEMP_USER";
  late User? currentUser = FirebaseManager().auth.currentUser;
  late List<UserModel> ratingUsers = [];

  @override
  void initState() {
    super.initState();

    //get dressing ratings
    fetchDressRatings();
    colorOptions = widget.dress.getColors();
    _commentController = TextEditingController(text: commentText);
  }

  Future<void> fetchDressRatings() async {
    List<RatingModel> ratingsToFetch = await _ratingRepository.getDressRatings();
    if (ratingsToFetch.isEmpty) {
        //update database with the stock2
        await _ratingRepository.createDressRatings(ratings);
        //assign the dressdata stock
        ratingsData = ratings;
    }
    setState(() {
      isLoading = false;
      ratingsData = ratingsToFetch;
    });
  }

  void submitRating() {
    if (selectedStar > 0 && commentText.isNotEmpty) {
      setState(() async {
        RatingModel ratingModel = RatingModel(
          userId: FirebaseManager().auth.currentUser?.uid ?? TEMP_USER, //
          //GRAB THE NAME FROM THE DRESS TABLE
          dressId: widget.dress.name,
          star: selectedStar,
          comment: commentText,
        );
        await _ratingRepository.createDressRating(ratingModel);
        selectedStar = 0;
        commentText = '';
      });
    }
  }
  Widget _buildStarInput() {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            selectedStar > index
              ? Icons.star
              : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              selectedStar = index + 1;
            });
          },
        );
      }),
    );
    }

  Widget _buildStarDisplay(double rating) {
    return Row(
      children: List.generate(5, (index) {
        final value = index + 1;
        return Icon(
          rating >= value
            ? Icons.star
            : rating >= value - 0.5
              ? Icons.star_half
              : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }
  Widget _buildCommentsList() {
    final dressRatings = ratingsData.where((r) => r.dressId == widget.dress.name).toList();
    return Column(
      children: dressRatings.map((r) => Card(
        child: ListTile(
          title: Row(
            children: [
              _buildStarDisplay(r.star),
              const SizedBox(width: 8),
              Text(r.userId),
            ],
          ),
          subtitle: Text(r.comment),
        ),
      ))
    .toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) { //perfect
       return const Center(child: CircularProgressIndicator());
    }
    final screenWidth = MediaQuery.of(context).size.width;
    //GRAB THE NAME FROM THE DRESS TABLE
    final dressRatings = ratingsData.where((r) => r.dressId == widget.dress.name).toList();
    final double avgRating = dressRatings.isEmpty
        ? 0
        : dressRatings.map((r) => r.star).reduce((a, b) => a + b) / dressRatings.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 110, 15, 47),
        elevation: 0,
      ),
      body: isLoading? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStarDisplay(avgRating),
                      const SizedBox(width: 8),
                      Text("(${dressRatings.length} reviews)"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Made from quality materials. Made for people with taste. So get yours today!",
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
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildStarInput(), // New star input widget
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Your comment",
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) => setState(() => commentText = val),
                controller: _commentController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: submitRating,
                child: const Text("Submit Review"),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildCommentsList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

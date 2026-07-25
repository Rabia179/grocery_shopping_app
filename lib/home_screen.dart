import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;

  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> favoriteItems = [];

  bool isLoading = true;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Fetch products from Supabase
  Future<void> fetchProducts() async {
    try {
      final data = await supabase
          .from('products')
          .select();

      setState(() {
        products = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching products: $e');

      setState(() {
        isLoading = false;
      });
    }
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to cart 🛒'),
        backgroundColor: const Color(0xFF6B8E62),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void toggleFavorite(Map<String, dynamic> product) {
    setState(() {
      final alreadyFavorite = favoriteItems.any(
            (item) => item['name'] == product['name'],
      );

      if (alreadyFavorite) {
        favoriteItems.removeWhere(
              (item) => item['name'] == product['name'],
        );
      } else {
        favoriteItems.add(product);
      }
    });
  }

  bool isFavorite(Map<String, dynamic> product) {
    return favoriteItems.any(
          (item) => item['name'] == product['name'],
    );
  }

  Widget buildHome() {
    return isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : RefreshIndicator(
      onRefresh: fetchProducts,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              'Good Morning 👋',
              style: TextStyle(
                color: Color(0xFF6B6258),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'What are you looking for?',
              style: TextStyle(
                color: Color(0xFF3E342B),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Search
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Color(0xFF6B8E62),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Search for groceries...',
                      style: TextStyle(
                        color: Color(0xFF8A8178),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFDCE8D5),
                    Color(0xFFF5D9C8),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fresh & Healthy 🥬',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E342B),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Everything you need,\nall in one place.',
                    style: TextStyle(
                      color: Color(0xFF6B6258),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Popular Products',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E342B),
              ),
            ),

            const SizedBox(height: 15),

            products.isEmpty
                ? const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'No products found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF8A8178),
                  ),
                ),
              ),
            )
                : GridView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                final favorite = isFavorite(product);

                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl:
                                product['image_url'] ?? '',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) =>
                                const Center(
                                  child:
                                  CircularProgressIndicator(),
                                ),
                                errorWidget:
                                    (context, url, error) =>
                                const Center(
                                  child: Icon(
                                    Icons
                                        .image_not_supported,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration:
                                const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints:
                                  const BoxConstraints(
                                    minWidth: 38,
                                    minHeight: 38,
                                  ),
                                  onPressed: () {
                                    toggleFavorite(product);
                                  },
                                  icon: Icon(
                                    favorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: const Color(
                                      0xFFC47A63,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        product['name'] ?? '',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3E342B),
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        product['description'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF8A8178),
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rs. ${product['price']}',
                            style: const TextStyle(
                              color: Color(0xFF6B8E62),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color:
                              const Color(0xFFF5D9C8),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {
                                addToCart(product);
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Color(0xFF8C5A45),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getCurrentScreen() {
    switch (currentIndex) {
      case 1:
        return const SearchScreen();

      case 2:
        return CartScreen(
          cartItems: cartItems,
        );

      case 3:
        return FavoritesScreen(
          favoriteItems: favoriteItems,
        );

      case 4:
        return const ProfileScreen();

      default:
        return buildHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: getCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF6B8E62),
        unselectedItemColor: const Color(0xFFAAA29A),
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
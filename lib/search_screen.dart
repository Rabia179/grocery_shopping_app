import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final supabase = Supabase.instance.client;

  final TextEditingController searchController =
  TextEditingController();

  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> filteredProducts = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final data = await supabase
          .from('products')
          .select();

      setState(() {
        products = List<Map<String, dynamic>>.from(data);
        filteredProducts = products;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching products: $e');

      setState(() {
        isLoading = false;
      });
    }
  }

  void searchProducts(String query) {
    final results = products.where((product) {
      final name =
          product['name']?.toString().toLowerCase() ?? '';

      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF5),
        elevation: 0,
        title: const Text(
          'Search Products',
          style: TextStyle(
            color: Color(0xFF3E342B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Search Field
            TextField(
              controller: searchController,
              onChanged: searchProducts,
              decoration: InputDecoration(
                hintText: 'Search Apple, Milk, Bread...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF6B8E62),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Search Results
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(
                child: Text(
                  'No products found 😔',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF8A8178),
                  ),
                ),
              )
                  : GridView.builder(
                itemCount:
                filteredProducts.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.72,
                ),
                itemBuilder:
                    (context, index) {
                  final product =
                  filteredProducts[index];

                  return Container(
                    padding:
                    const EdgeInsets.all(10),
                    decoration:
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(
                          20),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(
                                15),
                            child:
                            CachedNetworkImage(
                              imageUrl:
                              product['image_url']
                                  ?.toString() ??
                                  '',
                              width:
                              double.infinity,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) =>
                              const Center(
                                child:
                                CircularProgressIndicator(),
                              ),
                              errorWidget:
                                  (context, url,
                                  error) =>
                              const Center(
                                child: Icon(
                                  Icons
                                      .image_not_supported,
                                  size: 45,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 10),

                        Text(
                          product['name']
                              ?.toString() ??
                              '',
                          style:
                          const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.bold,
                            color: Color(
                                0xFF3E342B),
                          ),
                        ),

                        const SizedBox(
                            height: 5),

                        Text(
                          'Rs. ${product['price'] ?? ''}',
                          style:
                          const TextStyle(
                            color: Color(
                                0xFF6B8E62),
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
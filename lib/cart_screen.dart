import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({
    super.key,
    required this.cartItems,
  });

  double get totalPrice {
    double total = 0;

    for (final item in cartItems) {
      total += double.tryParse(item['price'].toString()) ?? 0;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF5),
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Color(0xFF3E342B),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF3E342B),
        ),
      ),

      body: cartItems.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Color(0xFFB7C9AE),
            ),
            SizedBox(height: 15),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E342B),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add some fresh products!',
              style: TextStyle(
                color: Color(0xFF8A8178),
              ),
            ),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                return Container(
                  margin:
                  const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFE8F0E4),
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(15),
                          child: item['image_url'] != null &&
                              item['image_url']
                                  .toString()
                                  .isNotEmpty
                              ? Image.network(
                            item['image_url'],
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error,
                                stackTrace) {
                              return const Icon(
                                Icons
                                    .shopping_basket_outlined,
                                color: Color(
                                    0xFF6B8E62),
                                size: 35,
                              );
                            },
                          )
                              : const Icon(
                            Icons
                                .shopping_basket_outlined,
                            color:
                            Color(0xFF6B8E62),
                            size: 35,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] ?? '',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight:
                                FontWeight.bold,
                                color:
                                Color(0xFF3E342B),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Rs. ${item['price']}',
                              style:
                              const TextStyle(
                                color:
                                Color(0xFF6B8E62),
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Color(0xFFC47A63),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rs. ${totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6B8E62),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CheckoutScreen(
                                total: totalPrice,
                              ),
                        ),
                      );
                    },
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF6B8E62),
                      foregroundColor: Colors.white,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteItems;

  const FavoritesScreen({
    super.key,
    required this.favoriteItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF5),
        elevation: 0,
        title: const Text(
          'My Favorites ❤️',
          style: TextStyle(
            color: Color(0xFF3E342B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: favoriteItems.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 85,
              color: Color(0xFFC47A63),
            ),
            SizedBox(height: 15),
            Text(
              'No Favorites Yet',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E342B),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Save your favorite products here ❤️',
              style: TextStyle(
                color: Color(0xFF8A8178),
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item =
          favoriteItems[index];

          return Container(
            margin: const EdgeInsets.only(
              bottom: 15,
            ),
            padding:
            const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(15),
                  child: Image.network(
                    item['image_url'] ?? '',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error,
                        stackTrace) {
                      return Container(
                        width: 75,
                        height: 75,
                        color:
                        const Color(
                            0xFFE8F0E4),
                        child: const Icon(
                          Icons.image,
                          color:
                          Color(0xFF6B8E62),
                        ),
                      );
                    },
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
                        style:
                        const TextStyle(
                          fontSize: 17,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          Color(0xFF3E342B),
                        ),
                      ),
                      const SizedBox(
                          height: 5),
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

                const Icon(
                  Icons.favorite,
                  color: Color(0xFFC47A63),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
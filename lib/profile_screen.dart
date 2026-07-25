import 'package:flutter/material.dart';
import 'orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF5),
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF3E342B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),

            // Profile Avatar
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFDCE8D5),
                    Color(0xFFF5D9C8),
                  ],
                ),
              ),
              child: const Icon(
                Icons.person,
                size: 55,
                color: Color(0xFF6B6258),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Grocery Shopper',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E342B),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Welcome to your grocery app',
              style: TextStyle(
                color: Color(0xFF8A8178),
              ),
            ),

            const SizedBox(height: 30),

            // My Orders
            profileOption(
              context,
              icon: Icons.inventory_2_outlined,
              title: 'My Orders',
              subtitle:
              'View your previous orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const OrdersScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            // Favorites
            profileOption(
              context,
              icon: Icons.favorite_border,
              title: 'My Favorites',
              subtitle:
              'View your favorite products',
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Open Favorites from the bottom menu ❤️',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            // Cart
            profileOption(
              context,
              icon:
              Icons.shopping_cart_outlined,
              title: 'My Cart',
              subtitle:
              'Check products in your cart',
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Open Cart from the bottom menu 🛒',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            // About
            profileOption(
              context,
              icon: Icons.info_outline,
              title: 'About App',
              subtitle:
              'Grocery Shopping App',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName:
                  'Grocery Shopping App',
                  applicationVersion:
                  '1.0.0',
                  applicationIcon:
                  const Icon(
                    Icons.shopping_basket,
                    color:
                    Color(0xFF6B8E62),
                    size: 40,
                  ),
                  children: const [
                    Text(
                      'A simple and beautiful grocery shopping app powered by Flutter and Supabase.',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget profileOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius:
      BorderRadius.circular(20),
      child: Container(
        padding:
        const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration:
              BoxDecoration(
                color:
                const Color(0xFFE8F0E4),
                borderRadius:
                BorderRadius.circular(
                    15),
              ),
              child: Icon(
                icon,
                color:
                const Color(0xFF6B8E62),
                size: 27,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Text(
                    title,
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
                    subtitle,
                    style:
                    const TextStyle(
                      fontSize: 13,
                      color: Color(
                          0xFF8A8178),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color:
              Color(0xFFAAA29A),
            ),
          ],
        ),
      ),
    );
  }
}
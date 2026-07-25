import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() =>
      _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final supabase =
      Supabase.instance.client;

  List<Map<String, dynamic>> orders = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final data = await supabase
          .from('orders')
          .select()
          .order(
        'created_at',
        ascending: false,
      );

      setState(() {
        orders =
        List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } catch (e) {
      debugPrint(
        'Error fetching orders: $e',
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  Color statusColor(String status) {
    if (status.toLowerCase() ==
        'delivered') {
      return const Color(0xFF6B8E62);
    }

    if (status.toLowerCase() ==
        'cancelled') {
      return const Color(0xFFC47A63);
    }

    return const Color(0xFFD09A55);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFFFFBF5),

      appBar: AppBar(
        backgroundColor:
        const Color(0xFFFFFBF5),
        elevation: 0,

        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Color(0xFF3E342B),
            fontWeight:
            FontWeight.bold,
          ),
        ),

        iconTheme:
        const IconThemeData(
          color:
          Color(0xFF3E342B),
        ),
      ),

      body: isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : orders.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment
              .center,
          children: [
            Icon(
              Icons
                  .inventory_2_outlined,
              size: 85,
              color: Color(
                  0xFFB7C9AE),
            ),
            SizedBox(
                height: 15),
            Text(
              'No Orders Yet',
              style:
              TextStyle(
                fontSize: 21,
                fontWeight:
                FontWeight
                    .bold,
                color: Color(
                    0xFF3E342B),
              ),
            ),
            SizedBox(
                height: 8),
            Text(
              'Your orders will appear here.',
              style:
              TextStyle(
                color: Color(
                    0xFF8A8178),
              ),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh:
        fetchOrders,
        child:
        ListView.builder(
          padding:
          const EdgeInsets
              .all(20),
          itemCount:
          orders.length,
          itemBuilder:
              (context, index) {
            final order =
            orders[index];

            final status =
                order['status'] ??
                    'Pending';

            return Container(
              margin:
              const EdgeInsets
                  .only(
                bottom: 15,
              ),
              padding:
              const EdgeInsets
                  .all(18),
              decoration:
              BoxDecoration(
                color:
                Colors.white,
                borderRadius:
                BorderRadius
                    .circular(
                    20),
              ),
              child:
              Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text(
                        'Order #${order['id']}',
                        style:
                        const TextStyle(
                          fontSize:
                          17,
                          fontWeight:
                          FontWeight
                              .bold,
                          color:
                          Color(
                              0xFF3E342B),
                        ),
                      ),

                      Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal:
                          12,
                          vertical:
                          6,
                        ),
                        decoration:
                        BoxDecoration(
                          color:
                          statusColor(
                              status)
                              .withValues(
                              alpha:
                              0.15),
                          borderRadius:
                          BorderRadius
                              .circular(
                              20),
                        ),
                        child:
                        Text(
                          status,
                          style:
                          TextStyle(
                            color:
                            statusColor(
                                status),
                            fontWeight:
                            FontWeight
                                .bold,
                            fontSize:
                            12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 15),

                  Text(
                    order[
                    'customer_name'] ??
                        '',
                    style:
                    const TextStyle(
                      fontSize:
                      16,
                      fontWeight:
                      FontWeight
                          .w600,
                      color:
                      Color(
                          0xFF3E342B),
                    ),
                  ),

                  const SizedBox(
                      height: 6),

                  Text(
                    order[
                    'address'] ??
                        '',
                    style:
                    const TextStyle(
                      color:
                      Color(
                          0xFF8A8178),
                    ),
                  ),

                  const SizedBox(
                      height: 12),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text(
                        'Phone: ${order['phone'] ?? ''}',
                        style:
                        const TextStyle(
                          color:
                          Color(
                              0xFF8A8178),
                        ),
                      ),

                      Text(
                        'Rs. ${order['total'] ?? 0}',
                        style:
                        const TextStyle(
                          fontSize:
                          17,
                          fontWeight:
                          FontWeight
                              .bold,
                          color:
                          Color(
                              0xFF6B8E62),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/order_model.dart';
import '../../core/data/mock_data.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  isScrollable: true,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
                  ),
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.text2,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  dividerColor: Colors.transparent, // Removes the default tab underline
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Processing'),
                    Tab(text: 'Shipped'),
                    Tab(text: 'Delivered'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(MockData.orders), // All
            _buildOrderList(MockData.orders.where((o) => o?.status == 'processing').toList()),
            _buildOrderList(MockData.orders.where((o) => o?.status == 'shipped').toList()),
            _buildOrderList(MockData.orders.where((o) => o?.status == 'delivered').toList()),
            _buildOrderList(MockData.orders.where((o) => o?.status == 'cancelled').toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(List<OrderModel> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('📦', style: TextStyle(fontSize: 44)),
            SizedBox(height: 12),
            Text('No orders found', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.text2)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(orders[index]);
      },
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    Color statusBgColor;
    Color statusTextColor;
    String statusLabel;

    switch (order.status) {
      case 'delivered':
        statusBgColor = AppColors.primaryLight; statusTextColor = AppColors.primary; statusLabel = '✓ Delivered'; break;
      case 'shipped':
        statusBgColor = AppColors.goldLight; statusTextColor = AppColors.amber; statusLabel = '🚚 Shipped'; break;
      case 'processing':
        statusBgColor = const Color(0xFFEFF6FF); statusTextColor = const Color(0xFF1565C0); statusLabel = '⏳ Processing'; break;
      case 'cancelled':
      default:
        statusBgColor = const Color(0xFFFEF2F2); statusTextColor = AppColors.red; statusLabel = '✕ Cancelled'; break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.text1)),
                  Text(order.date, style: const TextStyle(color: AppColors.text3, fontSize: 12)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusBgColor, borderRadius: BorderRadius.circular(20)),
                child: Text(statusLabel, style: TextStyle(color: statusTextColor, fontSize: 11, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 54, height: 54,
                decoration: BoxDecoration(color: AppColors.surface2, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Text(order.itemEmoji, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.itemName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.text1)),
                    const Text('Qty 1', style: TextStyle(color: AppColors.text3, fontSize: 12)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹${order.total.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.text1)),
              if (order.status != 'cancelled')
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0)
                  ),
                  child: const Text('Track Package', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                )
            ],
          )
        ],
      ),
    );
  }
}

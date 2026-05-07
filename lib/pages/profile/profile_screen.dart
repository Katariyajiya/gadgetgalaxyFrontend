import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHero(),
            const SizedBox(height: 28),
            _buildStatsGrid(),
            const SizedBox(height: 24),
            _buildSectionTitle('Quick Actions'),
            _buildActionTile(Icons.inventory_2_outlined, 'My Orders', 'Track & manage your orders', onTap: () => Navigator.pushNamed(context, '/orders')),
            _buildActionTile(Icons.favorite_border, 'Wishlist', 'View saved products'),
            _buildActionTile(Icons.location_on_outlined, 'Saved Addresses', '3 addresses saved'),
            const SizedBox(height: 24),
            _buildSectionTitle('Account Settings'),
            _buildActionTile(Icons.lock_outline, 'Change Password', 'Last changed 3 months ago'),
            _buildActionTile(Icons.notifications_outlined, 'Notifications', 'Manage email & SMS alerts'),
            _buildActionTile(Icons.logout, 'Sign Out', 'Sign out of your account', isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHero() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF01305A), Color(0xFF023A7A)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.teal]),
              border: Border.all(color: Colors.cyan.withOpacity(0.4), width: 3),
            ),
            alignment: Alignment.center,
            child: const Text('JD', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('John Doe', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('john.doe@email.com', style: TextStyle(color: Color(0xFF90CAF9), fontSize: 13)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                  ),
                  child: const Text('⭐ Gold Member', style: TextStyle(color: Color(0xFFFFB74D), fontSize: 12, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {'num': '12', 'label': 'Orders'},
      {'num': '5', 'label': 'Wishlist'},
      {'num': '3', 'label': 'Reviews'},
      {'num': '₹2.3L', 'label': 'Spent'},
    ];

    return Row(
      children: stats.map((stat) => Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border1),
          ),
          child: Column(
            children: [
              Text(stat['num']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
              const SizedBox(height: 4),
              Text(stat['label']!, style: const TextStyle(fontSize: 12, color: AppColors.text2, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title.toUpperCase(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.text1, letterSpacing: 0.5)),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle, {bool isDestructive = false, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border1),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive ? const Color(0xFFFEF2F2) : AppColors.primaryLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: isDestructive ? AppColors.red : AppColors.primary, size: 20),
        ),
        title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isDestructive ? AppColors.red : AppColors.text1)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.text3)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.text3),
      ),
    );
  }
}
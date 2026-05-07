import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/product_model.dart';
import '../../core/data/mock_data.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Taking the first 3 products from our mock data for the comparison demo
    final compareItems = MockData.products.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Products'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Clear All', style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: compareItems.isEmpty
          ? _buildEmptyState()
          : _buildCompareGrid(compareItems),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('⇌', style: TextStyle(fontSize: 64, color: AppColors.text3)),
          const SizedBox(height: 16),
          const Text('No products to compare', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Add products from the home screen', style: TextStyle(color: AppColors.text2)),
        ],
      ),
    );
  }

  Widget _buildCompareGrid(List<Product> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border1),
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(
                  label: '',
                  cells: items.map((p) => _buildHeaderCell(p)).toList(),
                ),
                _buildRow(
                    label: 'Price',
                    cells: items.map((p) => Text('₹${p.price.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16))).toList()
                ),
                _buildRow(
                    label: 'Brand',
                    cells: items.map((p) => Text(p.brand, style: const TextStyle(fontWeight: FontWeight.w500))).toList()
                ),
                _buildRow(
                    label: 'Rating',
                    cells: items.map((p) => Text('⭐ ${p.rating}', style: const TextStyle(fontWeight: FontWeight.w500))).toList()
                ),
                _buildRow(
                    label: 'Category',
                    cells: items.map((p) => Text(p.category.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.text2))).toList()
                ),
                // Actions Row
                _buildRow(
                  label: '',
                  cells: items.map((p) => ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                    child: const Text('Add to Cart'),
                  )).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow({required String label, required List<Widget> cells}) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border1))),
      child: Row(
        children: [
          // Label Column
          Container(
            width: 100,
            padding: const EdgeInsets.all(16),
            color: AppColors.surface2,
            alignment: Alignment.centerLeft,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.text2)),
          ),
          // Data Columns
          ...cells.map((cell) => Container(
            width: 160,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: const BoxDecoration(border: Border(left: BorderSide(color: AppColors.border1))),
            child: cell,
          )),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(Product p) {
    return Column(
      children: [
        Text(p.emoji, style: const TextStyle(fontSize: 44)),
        const SizedBox(height: 8),
        Text(p.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 2),
      ],
    );
  }
}
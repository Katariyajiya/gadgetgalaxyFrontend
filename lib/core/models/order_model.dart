class OrderModel {
  final String id;
  final String date;
  final String status; // 'delivered', 'shipped', 'processing', 'cancelled'
  final double total;
  final String itemName;
  final String itemEmoji;

  OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.itemName,
    required this.itemEmoji,
  });
}
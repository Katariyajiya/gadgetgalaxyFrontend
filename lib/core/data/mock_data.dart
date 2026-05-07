import '../models/order_model.dart';
import '../models/product_model.dart';

class MockData {
  static final List<Product> products = [
    Product(id: 1, name: 'iPhone 16 Pro Max', brand: 'Apple', category: 'smartphones', price: 134900, oldPrice: 149900, rating: 4.9, reviews: 2841, emoji: '📱', badge: 'new'),
    Product(id: 2, name: 'Samsung Galaxy S25 Ultra', brand: 'Samsung', category: 'smartphones', price: 119999, oldPrice: 134999, rating: 4.8, reviews: 1932, emoji: '📱', badge: 'hot'),
    Product(id: 3, name: 'MacBook Air M3', brand: 'Apple', category: 'laptops', price: 114900, oldPrice: 124900, rating: 4.9, reviews: 3201, emoji: '💻', badge: 'new'),
    Product(id: 4, name: 'Dell XPS 15', brand: 'Dell', category: 'laptops', price: 149999, oldPrice: 169999, rating: 4.7, reviews: 876, emoji: '💻', badge: 'sale'),
    Product(id: 5, name: 'Sony WH-1000XM5', brand: 'Sony', category: 'audio', price: 29990, oldPrice: 34990, rating: 4.8, reviews: 5621, emoji: '🎧', badge: 'hot'),
    Product(id: 6, name: 'AirPods Pro 2nd Gen', brand: 'Apple', category: 'audio', price: 24900, oldPrice: 26900, rating: 4.8, reviews: 4231, emoji: '🎧', badge: 'new'),
  ];
  static final List<OrderModel> orders = [
    OrderModel(id: 'VLT-2025-8841', date: 'Apr 22, 2025', status: 'delivered', total: 119999, itemName: 'Samsung Galaxy S25 Ultra', itemEmoji: '📱'),
    OrderModel(id: 'VLT-2025-7712', date: 'Apr 18, 2025', status: 'shipped', total: 124399, itemName: 'MacBook Air M3', itemEmoji: '💻'),
    OrderModel(id: 'VLT-2025-6603', date: 'Apr 10, 2025', status: 'processing', total: 89900, itemName: 'Apple Watch Ultra 2', itemEmoji: '⌚'),
    OrderModel(id: 'VLT-2025-4401', date: 'Mar 14, 2025', status: 'cancelled', total: 49990, itemName: 'PlayStation 5 Slim', itemEmoji: '🎮'),
  ];
}
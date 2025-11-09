import 'package:flutter/foundation.dart';
import '../services/cart_service.dart';

class CartProvider with ChangeNotifier {
  final CartService _cartService = CartService();

  CartService get cartService => _cartService;

  List<CartItem> get items => _cartService.items;
  bool get isEmpty => _cartService.isEmpty;
  int get itemCount => _cartService.itemCount;
  int get totalQuantity =>
      _cartService.items.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => _cartService.subtotal;
  double get tax => _cartService.tax;
  double get total => _cartService.total;

  void addItem(CartItem item) {
    _cartService.addItem(item);
    notifyListeners();
  }

  void removeItemAt(int index) {
    _cartService.removeItemAt(index);
    notifyListeners();
  }

  void removeItemById(String id) {
    _cartService.removeItemById(id);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    _cartService.updateQuantity(index, quantity);
    notifyListeners();
  }

  void clearCart() {
    _cartService.clearCart();
    notifyListeners();
  }

  CartItem? getItemById(String id) {
    return _cartService.getItemById(id);
  }
}

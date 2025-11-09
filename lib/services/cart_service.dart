class CartItem {
  final String id;
  final String title;
  final String author;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  double get subtotal => price * quantity;

  CartItem copyWith({
    String? id,
    String? title,
    String? author,
    double? price,
    String? image,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  bool get isEmpty => _items.isEmpty;

  int get itemCount => _items.length;

  double get subtotal => _items.fold(0, (sum, item) => sum + item.subtotal);

  double get tax => subtotal * 0.1; // 10% tax

  double get total => subtotal + tax;

  /// Add item to cart or increase quantity if it already exists
  void addItem(CartItem item) {
    final existingItemIndex = _items.indexWhere((i) => i.id == item.id);

    if (existingItemIndex != -1) {
      // Item already exists, increase quantity
      _items[existingItemIndex].quantity += item.quantity;
    } else {
      // New item, add to cart
      _items.add(item);
    }
  }

  /// Remove item from cart by index
  void removeItemAt(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  /// Remove item from cart by ID
  void removeItemById(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  /// Update quantity of an item
  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length) {
      if (quantity <= 0) {
        removeItemAt(index);
      } else {
        _items[index].quantity = quantity;
      }
    }
  }

  /// Clear all items from cart
  void clearCart() {
    _items.clear();
  }

  /// Get item by ID
  CartItem? getItemById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Check if item exists in cart
  bool containsItem(String id) {
    return _items.any((item) => item.id == id);
  }
}

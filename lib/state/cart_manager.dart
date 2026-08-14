import '../models/drink.dart';

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  final Set<String> _favoriteDrinkIds = {};
  Set<String> get favoriteDrinkIds => _favoriteDrinkIds;

  bool isFavorite(String drinkId) => _favoriteDrinkIds.contains(drinkId);

  void toggleFavorite(String drinkId) {
    if (_favoriteDrinkIds.contains(drinkId)) {
      _favoriteDrinkIds.remove(drinkId);
    } else {
      _favoriteDrinkIds.add(drinkId);
    }
  }

  void addToCart(Drink drink) {
    int existingIndex = _items.indexWhere((item) => item.drink.id == drink.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(drink: drink));
    }
  }

  void removeFromCart(String drinkId) {
    _items.removeWhere((item) => item.drink.id == drinkId);
  }

  double get totalPrice {
    return _items.fold(
        0.0, (sum, item) => sum + (item.drink.price * item.quantity));
  }

  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
}

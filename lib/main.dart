// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(TwiceApp());
}

class TwiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TWICE Cafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: const Color(0xFFFF6B9D), // TWICE pink
        scaffoldBackgroundColor: const Color(0xFFFFF8F8),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF6B9D),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: HomePage(),
      routes: {
        '/cart': (context) => CartPage(),
      },
    );
  }
}

// Model class for drinks
class Drink {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Drink({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

// Cart item model
class CartItem {
  final Drink drink;
  int quantity;

  CartItem({required this.drink, this.quantity = 1});
}

// State manager (Cart & Favorites Singleton)
class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  // Track favorited drink IDs
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

// Home page with menu
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartManager cartManager = CartManager();

  // Sample drinks data
  final List<Drink> drinks = [
    Drink(
      id: '1',
      name: 'Feel Special',
      description:
          '「新女性」與「新男性」概念在五四運動後逐漸興起，女性不再只是家庭角色，也積極投入社會、職場與學術領域。同時，也有越來越多男性開始反思父權角色，兩性之間重新尋找價值感與合作空間。',
      price: 4.50,
      imageUrl: 'https://th.bing.com/th/id/OIG4.xhGYuFwcNwhvNFdZBjx4?pid=ImgGn',
    ),
    Drink(
      id: '2',
      name: 'Yes or Yes',
      description:
          '民國時期的「新女性」面臨傳統與現代的抉擇：是順從父母安排的婚姻，還是追求個人理想？許多知識女性選擇「Yes」給自己——投身教育、醫學、法律等專業領域，用行動證明女性同樣擁有選擇權與決定權。',
      price: 5.00,
      imageUrl: 'https://th.bing.com/th/id/OIG1.28nqb_vDTcBsFQSR53yd?pid=ImgGn',
    ),
    Drink(
      id: '3',
      name: 'Pink Lemonade',
      description:
          '五四時期的青年女性開始公開反對包辦婚姻，提倡自由戀愛。雜誌如《新青年》、《婦女雜誌》中，常見女性投稿抒發對愛情自由的渴望，象徵婚姻制度的變革與個人主體的覺醒。',
      price: 3.75,
      imageUrl:
          'https://th.bing.com/th/id/OIG4.sLo3WCN0dTZ93x4WM0Ol?w=1024&h=1024&rs=1&pid=ImgDetMain',
    ),
    Drink(
      id: '4',
      name: 'Breakthrough',
      description:
          '「男主外、女主內」的傳統性別分工，在近代社會逐漸被挑戰。家庭中女性不再僅是照顧者，也成為經濟支柱之一。這樣的角色轉變，在民國初年城市女性勞動者中已初見端倪。',
      price: 4.25,
      imageUrl:
          'https://th.bing.com/th/id/OIG2.2yRH91C1kO5OjwA66wPa?w=1024&h=1024&rs=1&pid=ImgDetMain',
    ),
    Drink(
      id: '5',
      name: 'Cheer Up',
      description:
          '日治時期的台灣，女性學生與知識分子積極參與政治與文化運動。像是1920年代的台灣文化協會活動中，女性也組織遊行、發表演講，展現女性集體力量與公民意識的崛起。',
      price: 4.75,
      imageUrl: 'https://th.bing.com/th/id/OIG4.vg6uLrvlypxZGcVaKhO5?pid=ImgGn',
    ),
    Drink(
      id: '6',
      name: 'Scientist',
      description:
          '清末與民初，女性逐步進入理工科領域，如北京女子高等師範學校設立數理組。她們面對的不只是學科挑戰，更是社會偏見。這些女性科學先驅，為後來的性別平權教育鋪下基石。',
      price: 4.00,
      imageUrl:
          'https://th.bing.com/th/id/OIG3.F5X_Nw8gHQLKJsmN8mSg?w=1024&h=1024&rs=1&pid=ImgDetMain',
    ),
    Drink(
      id: '7',
      name: 'Espresso',
      description:
          '民國初年的職業女性如醫生張竹君、律師鄭毓秀等，她們在男性主導的專業領域中，展現了如濃縮咖啡般強烈而純粹的專業能力。小小一杯，卻濃縮了無限的力量與堅持。',
      price: 3.50,
      imageUrl: 'https://th.bing.com/th/id/OIG2.VcXKWfq5lK6gq8AKpZE2?pid=ImgGn',
    ),
    Drink(
      id: '8',
      name: 'Doughnut',
      description:
          '傳統社會期待女性像甜甜圈一樣「甜美圓滿」，但現代性別觀念認為，無論男女都不應被框架在單一的性格期待中。每個人都有展現多元面向的權利，甜美與堅強可以並存。',
      price: 3.00,
      imageUrl: 'https://th.bing.com/th/id/OIG4.rIUOjPCwU1BOYSSQyqWC?pid=ImgGn',
    ),
    Drink(
      id: '9',
      name: 'Peach Soda',
      description:
          '日治時期台灣女性開始接觸西式教育，如淡水女學堂培養的女性，她們既保持東方溫婉特質，也吸收了西方的獨立精神。這種中西融合的新女性形象，為台灣性別文化注入了清新活力。',
      price: 3.75,
      imageUrl:
          'https://th.bing.com/th/id/OIG4.O3vjvTIm8t02E0kuzdXc?w=1024&h=1024&rs=1&pid=ImgDetMain',
    ),
    Drink(
      id: '10',
      name: 'Rainbow',
      description:
          '性別光譜如彩虹般多元，不只有傳統的男女二分。從古代的「男風」文化，到現代LGBTQ+族群的可見度提升，中華文化中一直存在著豐富的性別認同與表達方式，值得我們以開放心態理解與尊重。',
      price: 5.50,
      imageUrl:
          'https://th.bing.com/th/id/OIG2.L7ga3.AR1MRVaG5tYC4e?w=1024&h=1024&rs=1&pid=ImgDetMain',
    ),
    Drink(
      id: '11',
      name: 'Marshmallow',
      description:
          '傳統觀念認為溫柔體貼是女性專屬特質，但現代性別研究發現，照顧他人的能力不分性別。民國時期許多男性教育家如陶行知，同樣展現了如棉花糖般柔軟的關懷特質，打破了「男兒有淚不輕彈」的刻板印象。',
      price: 4.00,
      imageUrl:
          'https://th.bing.com/th/id/OIG4.Q8vzfVirMlqcUnLBhRZy?w=1024&h=1024&rs=1&pid=ImgDetMain',
    ),
    Drink(
      id: '12',
      name: 'Ice Cream',
      description:
          '1920年代的「摩登女郎」開始享受生活中的小確幸，如品嚐冰淇淋、看電影等娛樂活動。她們不再將享樂視為罪惡，而是認為女性同樣有權追求快樂與自我滿足，這種生活態度影響了後來的女性解放思想。',
      price: 3.75,
      imageUrl: 'https://th.bing.com/th/id/OIG2.WAzTBs37LGt1iegEG841?pid=ImgGn',
    ),
    Drink(
      id: '13',
      name: 'Jelly Jelly',
      description:
          '性別角色如果凍般具有流動性，不應被固化定型。五四運動期間，許多知識分子開始反思傳統性別框架，提倡「人格獨立」概念。無論男女，都應該有彈性地發展自己的個性，而非被社會期待束縛。',
      price: 2.00,
      imageUrl: 'https://th.bing.com/th/id/OIG4.js6k2h5.9670ObhiUXrI?pid=ImgGn',
    ),
    Drink(
      id: '14',
      name: 'Set Me Free',
      description:
          '隨著性別意識抬頭，越來越多人開始質疑社會對「正常性別表現」的期待。無論是女性拒絕溫婉形象，或男性展現情感脆弱，都是從性別框架中「掙脫」的自由實踐。',
      price: 4.50,
      imageUrl:
          'https://th.bing.com/th/id/OIG3.5L_G4O3EC.Fj7.5kanf6?w=1024&h=1024&rs=1&pid=ImgDetMain',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '♡TWICE Cafe ♡',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () async {
                  await Navigator.pushNamed(context, '/cart');
                  setState(() {});
                },
              ),
              if (cartManager.totalItems > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartManager.totalItems}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B9D), Color(0xFFFFB6C1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Welcome to TWICE Cafe!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Discover our special drinks inspired by TWICE',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Drinks grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: drinks.length,
                itemBuilder: (context, index) {
                  final drink = drinks[index];
                  return DrinkCard(
                    drink: drink,
                    isFavorite: cartManager.isFavorite(drink.id),
                    onToggleFavorite: () {
                      setState(() {
                        cartManager.toggleFavorite(drink.id);
                      });
                    },
                    onAddToCart: () {
                      setState(() {
                        cartManager.addToCart(drink);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${drink.name} added to cart!'),
                          backgroundColor: const Color(0xFFFF6B9D),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DrinkDetailPage(drink: drink),
                        ),
                      );
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Drink card widget with favorite button
class DrinkCard extends StatelessWidget {
  final Drink drink;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;
  final bool isFavorite;

  const DrinkCard({
    Key? key,
    required this.drink,
    required this.onAddToCart,
    required this.onTap,
    required this.onToggleFavorite,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + Favorite overlay
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      image: DecorationImage(
                        image: NetworkImage(drink.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onToggleFavorite,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Drink info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      drink.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${drink.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B9D),
                          ),
                        ),
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B9D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Drink detail page
class DrinkDetailPage extends StatefulWidget {
  final Drink drink;

  const DrinkDetailPage({Key? key, required this.drink}) : super(key: key);

  @override
  _DrinkDetailPageState createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  final CartManager cartManager = CartManager();

  @override
  Widget build(BuildContext context) {
    final isFavorite = cartManager.isFavorite(widget.drink.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drink.name),
        backgroundColor: const Color(0xFFFF6B9D),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                cartManager.toggleFavorite(widget.drink.id);
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.drink.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.drink.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '\$${widget.drink.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B9D),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.drink.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        cartManager.addToCart(widget.drink);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${widget.drink.name} added to cart!'),
                            backgroundColor: const Color(0xFFFF6B9D),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B9D),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Cart page
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartManager cartManager = CartManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: const Color(0xFFFF6B9D),
      ),
      body: cartManager.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B9D),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Start Shopping'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartManager.items.length,
                    itemBuilder: (context, index) {
                      final item = cartManager.items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(item.drink.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.drink.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${item.drink.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFFF6B9D),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Qty: ${item.quantity}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        cartManager
                                            .removeFromCart(item.drink.id);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${cartManager.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6B9D),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Order Placed!'),
                                content:
                                    const Text('Thank you for your order! 💕'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6B9D),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

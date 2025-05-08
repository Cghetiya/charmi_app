import 'package:flutter/material.dart';
import '../models/purse.dart';
import '../widgets/purse_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Purse> purseList = [
    Purse(name: 'Elegant Black Purse', price: 79.99, imageUrl: 'assets/images/image1.jpg'),
    Purse(name: 'Red Leather Tote', price: 109.99, imageUrl: 'assets/images/image2.jpg'),
    Purse(name: 'Minimal Nude Handbag', price: 89.50, imageUrl: 'assets/images/image3.jpg'),
    Purse(name: 'Office use purse', price: 69.99, imageUrl: 'assets/images/image4.jpg'),
    Purse(name: 'Elegant purse', price: 59.99, imageUrl: 'assets/images/image5.jpg'),
    Purse(name: 'City Tote Bag In Signature Canvas', price: 139.99, imageUrl: 'assets/images/image6.jpg'),
    Purse(name: 'Teri Shoulder Bag', price: 149.99, imageUrl: 'assets/images/image7.jpg'),
    Purse(name: 'Gallery Tote Bag', price: 89.99, imageUrl: 'assets/images/image8.jpg'),
    Purse(name: 'Quinn Bag', price: 79.99, imageUrl: 'assets/images/image9.jpg'),
    Purse(name: 'Ellie File Bag', price: 139.99, imageUrl: 'assets/images/image10.jpg'),
    Purse(name: 'Hadley Shoulder Bag', price: 129.99, imageUrl: 'assets/images/image11.jpg'),
    Purse(name: 'Andrea Carryall Bag', price: 79.99, imageUrl: 'assets/images/image12.jpg'),
    Purse(name: 'Elegant Black Purse', price: 159.99, imageUrl: 'assets/images/image13.jpg'),
    Purse(name: 'Nolita 19 With Rivets', price: 169.99, imageUrl: 'assets/images/image14.jpg'),
    Purse(name: 'Elegant Black Purse', price: 69.99, imageUrl: 'assets/images/image15.jpg'),
    Purse(name: 'Jamie Camera Bag', price: 49.99, imageUrl: 'assets/images/image16.jpg'),
  ];

  Map<Purse, int> cart = {};

  double get totalPrice =>
      cart.entries.fold(0, (sum, entry) => sum + entry.key.price * entry.value);

  void addToCart(Purse purse) {
    setState(() {
      if (cart.containsKey(purse)) {
        cart[purse] = cart[purse]! + 1;
      } else {
        cart[purse] = 1;
      }
    });
  }

  void openCartSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => buildCartSheet(context),
    );
  }

  Widget buildCartSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Cart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(),
          Expanded(
            child: cart.isEmpty
                ? Center(child: Text('Your cart is empty.'))
                : ListView(
              children: cart.entries.map((entry) {
                final purse = entry.key;
                final quantity = entry.value;
                return ListTile(
                  title: Text(purse.name),
                  subtitle: Text('\$${purse.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          setState(() {
                            if (cart[purse]! > 1) {
                              cart[purse] = cart[purse]! - 1;
                            } else {
                              cart.remove(purse);
                            }
                          });
                          Navigator.pop(context);
                          openCartSheet();
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setState(() {
                            cart[purse] = cart[purse]! + 1;
                          });
                          Navigator.pop(context);
                          openCartSheet();
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.pinkAccent),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Women\'s Purses'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: openCartSheet,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: purseList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 items per row
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.6, // Wider to handle text + button spacing
              ),
              itemBuilder: (context, index) {
                final purse = purseList[index];
                return PurseCard(
                  purse: purse,
                  onAdd: () => addToCart(purse),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.pink[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

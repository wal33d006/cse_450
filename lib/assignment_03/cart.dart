import 'package:cse_450/assignment_03/dish_list.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Dish> cart;
  final Function(List<Dish>) onCartUpdated;

  const CartPage({
    Key? key,
    required this.cart,
    required this.onCartUpdated,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // List<Dish> cart = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
            itemCount: widget.cart.length,
            itemBuilder: (context, index) {
              var dish = widget.cart[index];
              return ListTile(
                title: Text(dish.name),
                trailing: InkWell(
                  child: Icon(widget.cart.contains(dish) ? Icons.remove : Icons.add),
                  onTap: () {
                    // dish.addRemoveDish();
                    widget.cart.remove(dish);
                    widget.onCartUpdated(widget.cart);
                    setState(() {});
                  },
                ),
              );
            }),
      ),
    );
  }
}

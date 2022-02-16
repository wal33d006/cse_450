import 'package:cse_450/assignment_03/cart.dart';
import 'package:flutter/material.dart';

class DishListPage extends StatefulWidget {
  const DishListPage({Key? key}) : super(key: key);

  @override
  _DishListPageState createState() => _DishListPageState();
}

class _DishListPageState extends State<DishListPage> {
  List<Dish> mainList = [
    Dish(name: 'Dish 01'),
    Dish(name: 'Dish 02'),
    Dish(name: 'Dish 03'),
    Dish(name: 'Dish 04'),
    Dish(name: 'Dish 05'),
  ];

  List<Dish> cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
            itemCount: mainList.length,
            itemBuilder: (context, index) {
              var dish = mainList[index];
              return ListTile(
                title: Text(dish.name),
                trailing: InkWell(
                  child: Icon(cart.contains(dish) ? Icons.remove : Icons.add),
                  onTap: () async {
                    if (cart.contains(dish)) {
                      bool toBeRemoved = false;
                      toBeRemoved = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Do you want to remove ${dish.name}?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text('No')),
                                ],
                              ));
                      if (toBeRemoved) {
                        cart.remove(dish);
                      }
                    } else {
                      cart.add(dish);
                    }
                    setState(() {});
                  },
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CartPage(
                cart: cart,
                onCartUpdated: (value) {
                  cart = value;
                  setState(() {});
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Dish {
  final String name;

  // bool isAdded;

  Dish({required this.name});
//
// void addRemoveDish() {
//   isAdded = !isAdded;
// }
}

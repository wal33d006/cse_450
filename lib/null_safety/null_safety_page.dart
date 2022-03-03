import 'package:flutter/material.dart';

class NullSafetyPage extends StatefulWidget {
  final String name;

  const NullSafetyPage({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  _NullSafetyPageState createState() => _NullSafetyPageState();
}

class Address {
  final String zipCode;
  Address(this.zipCode);
}

class Waleed {
  String? name;
  Address? address;

  Waleed({this.name = "Waleed", this.address});
}

class _NullSafetyPageState extends State<NullSafetyPage> {
  String? a;

  Waleed? waleed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a = widget.name;
  }

  void hello() {
    // a = "4";
    // a = null;
    // if(waleed != null) {
    //
    // }
    waleed?.name = 'Hello';

    printText(a ?? '');
    var zip = waleed?.address?.zipCode;
    printText(zip ?? "");
    printAddress(waleed?.address);
    printText(waleed?.address?.zipCode ?? '');
    printText(waleed?.name != null ? "Name is not null" : "");
  }

  void printAddress(Address? address) {

  }

  void printText(String data) {
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(waleed?.name ?? ''),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          hello();
        },
      ),
    );
  }
}

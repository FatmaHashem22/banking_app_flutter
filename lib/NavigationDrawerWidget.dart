import 'package:banking_app/Transactions.dart';
import 'package:banking_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 40);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: Colors.purple,
      child: ListView(
        padding: padding,
        children: <Widget>[
          const SizedBox(
            height: 300,
          ),
          buildMenuItem(
              text: 'Customers List',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 0)),
          const SizedBox(
            height: 30,
          ),
          buildMenuItem(
              text: 'Transactions List',
              icon: Icons.currency_exchange,
              onClicked: () => selectedItem(context, 1)),
        ],
      ),
    ));
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(
      text,
      style: TextStyle(color: color),
    ),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Transactions()));
      break;
  }
}

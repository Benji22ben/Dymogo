import 'package:dymogo/constants.dart';
import 'package:dymogo/screens/register_screen/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: kPrimaryColor,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 100),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.account_circle_outlined,
              //Changer l'index pour la redirection voulue => Se référer à la fonction selectedItem()
              onClicked: () => selectedItem(context, 0),
            ),
            Divider(
                color: Colors.white70, thickness: 1, indent: 20, endIndent: 20),
            buildMenuItem(
              text: 'Reports',
              icon: Icons.add_location_sharp,
              //Changer l'index pour la redirection voulue => Se référer à la fonction selectedItem()
              onClicked: () => selectedItem(context, 0),
            ),
            Divider(
                color: Colors.white70, thickness: 1, indent: 20, endIndent: 20),
            buildMenuItem(
              text: 'Success',
              icon: Icons.dashboard_outlined,
              //Changer l'index pour la redirection voulue => Se référer à la fonction selectedItem()
              onClicked: () => selectedItem(context, 0),
            ),
            Divider(
                color: Colors.white70, thickness: 1, indent: 20, endIndent: 20),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              //Changer l'index pour la redirection voulue => Se référer à la fonction selectedItem()
              onClicked: () => selectedItem(context, 0),
            ),
            Divider(
                color: Colors.white70, thickness: 1, indent: 20, endIndent: 20),
            buildMenuItem(
              text: 'Privacy\nPoliticy',
              icon: Icons.article_rounded,
              //Changer l'index pour la redirection voulue => Se référer à la fonction selectedItem()
              onClicked: () => selectedItem(context, 0),
            ),
            Divider(
                color: Colors.white70, thickness: 1, indent: 20, endIndent: 20),
            const SizedBox(height: 220),
            Divider(
                color: Colors.white70, thickness: 1, indent: 20, endIndent: 20),
            buildMenuItem(
              text: 'Sign out',
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color, size: 35),
      title: Text(text, style: TextStyle(color: color, fontSize: 25)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      //Exemple de case : redirection page de register
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        ));
        break;
    }
  }
}

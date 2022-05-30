import 'package:dymogo/constants.dart';
import 'package:dymogo/views/home/home_screen.dart';
import 'package:dymogo/views/login/login_screen.dart';
import 'package:dymogo/views/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:dymogo/views/utilities/authProtect.dart';

class NavigationDrawerWidget extends StatelessWidget {
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
            const SizedBox(height: 200),
            Divider(
                color: Colors.white70, thickness: 1, indent: 20, endIndent: 20),
            FutureBuilder(
              future: AuthProtect.isTokenValid(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == false) {
                  return buildMenuItem(
                    text: 'Sign out',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 1),
                  );
                } else {
                  return buildMenuItem(
                    text: 'Sign in',
                    icon: Icons.login,
                    onClicked: () => selectedItem(context, 2),
                  );
                }
              },
            )
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

  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();

    switch (index) {
      //Exemple de case : redirection page de register
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        ));
        break;
      case 1:
        await storage.delete(key: "token").then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        authenticated: true,
                      )),
            ));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}

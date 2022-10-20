
import 'package:fitness_app/features/products/presentation/pages/product_category.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_string.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl ,
      child: Drawer(
        elevation: 0,
    
        child: ListView(
          padding: const EdgeInsets.only(top: 50),
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title:  const Text(AppString.productsString),
              onTap: () => {
                 Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  Category()))
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Profile'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: const Icon(Icons.border_color),
              title: const Text('Feedback'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      ),
    );
  }
}
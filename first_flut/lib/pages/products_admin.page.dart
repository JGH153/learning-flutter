import 'package:flutter/material.dart';

import './products.page.dart';

class ProductsAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Select'),
            ),
            ListTile(
              title: Text('Product list'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Products Admin'),
      ),
      body: Center(
        child: Text('Prod admin!'),
      ),
    );
  }
}

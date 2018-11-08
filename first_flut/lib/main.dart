import 'package:flutter/material.dart';

import './product_manager.dart';

main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('SuperList 1337'),
        ),
        body: Column(
          children: [
            ProductManager(startingProduct: 'Delicious product')
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/auth.page.dart';
import './pages/products_admin.page.dart';
import './pages/products.page.dart';
import './pages/product.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
        buttonColor: Colors.red,
      ),
      home: AuthPage(),
      routes: {
        '/products': (context) => ProductsPage(_products),
        '/admin': (context) => ProductsAdmin(_addProduct, _deleteProduct)
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'],
                _products[index]['image'],
                _products[index]['description'],
                _products[index]['price'],
                'Skøyen, Norge, Jorden, Melkeveien'),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => ProductsPage(_products),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import './pages/product.page.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;

  Products(this.products, {this.deleteProduct});

  _gotoDetailsPage(context, index) {
    return Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProductPage(
              products[index]['title'],
              products[index]['image'],
            ),
      ),
    ).then((bool shouldDelete) {
      if(shouldDelete) {
        deleteProduct(index);
      }
    });
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => _gotoDetailsPage(context, index),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductLists() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    } else {
      productCards = Center(
        child: Text('No Prods found, add above'),
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductLists();
  }
}

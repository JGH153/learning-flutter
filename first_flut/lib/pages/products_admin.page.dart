import 'package:flutter/material.dart';

import './tabs_admin/product_list.page.dart';
import './tabs_admin/products_edit.page.dart';

class ProductsAdmin extends StatelessWidget {
  final Function addProduct;
  final Function updateProduct;
  final Function deleteProduct;
  final List<Map<String, dynamic>> products;

  ProductsAdmin(this.addProduct, this.updateProduct, this.deleteProduct, this.products);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Select'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Product list'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Products Admin'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'Products',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(addProduct: addProduct),
            ProductListPage(products, updateProduct),
          ],
        ),
      ),
    );
  }
}

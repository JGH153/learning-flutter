import 'package:flutter/material.dart';

import './../../models/product.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex}) {
    print(product);
  }

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPage();
  }
}

class _ProductEditPage extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextFiled() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product title:'),
      initialValue: widget.product == null ? '' : widget.product.title,
      validator: (String value) {
        if (value.isEmpty || value.length < 2) {
          return 'Title is required and shold be 2+ chars long';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      initialValue: widget.product == null ? '' : widget.product.description,
      validator: (String value) {
        if (value.isEmpty || value.length < 3) {
          return 'Description is required and shold be 3+ chars long';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextFiled() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue:
          widget.product == null ? '' : widget.product.price.toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and shold be a number';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _BuildPageContent(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: targetWidth,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextFiled(),
              _buildDescriptionTextField(),
              _buildPriceTextFiled(),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('Save'),
                textColor: Colors.white,
                onPressed: _submitForm,
              ),
              // GestureDetector(
              //   onTap: _submitForm,
              //   child: Container(
              //     color: Colors.green,
              //     padding: EdgeInsets.all(5.0),
              //     child: Text('My Button'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.product == null) {
      widget.addProduct(Product(
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        image: _formData['image'],
      ));
    } else {
      widget.updateProduct(
          widget.productIndex,
          Product(
            title: _formData['title'],
            description: _formData['description'],
            price: _formData['price'],
            image: _formData['image'],
          ));
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final Widget pageContent = _BuildPageContent(context);
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}

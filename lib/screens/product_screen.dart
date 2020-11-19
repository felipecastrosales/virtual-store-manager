import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../blocs/product_bloc.dart';
import '../validators/product_validator.dart';
import '../widgets/images_widget.dart';

class ProductScreen extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot product;
  ProductScreen({this.categoryId, this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState(categoryId, product);
}

// ignore: prefer_mixin
class _ProductScreenState extends State<ProductScreen> with ProductValidator {
  final ProductBloc _productBloc;
  final _formKey = GlobalKey<FormState>();
  _ProductScreenState(String categoryId, DocumentSnapshot product)
      : _productBloc = ProductBloc(categoryId: categoryId, product: product);

  @override
  Widget build(BuildContext context) {
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
      );
    }

    final _fieldStyle = TextStyle(color: Colors.white, fontSize: 16);

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Produto'),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<Map>(
            stream: _productBloc.outData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return ListView(
                  padding: EdgeInsets.all(16),
                  children: <Widget>[
                    Text('Imagens', style: _fieldStyle),
                    ImagesWidget(
                      context: context,
                      initialValue: snapshot.data['images'],
                      onSaved: _productBloc.saveImages,
                      validator: validateImages,
                    ),
                    TextFormField(
                      initialValue: snapshot.data['title'],
                      style: _fieldStyle,
                      decoration: _buildDecoration('Título'),
                      onSaved: _productBloc.saveTitle,
                      validator: validateTitle,
                    ),
                    TextFormField(
                      initialValue: snapshot.data['description'],
                      style: _fieldStyle,
                      maxLines: 6,
                      decoration: _buildDecoration('Descrição'),
                      onSaved: _productBloc.saveDescription,
                      validator: validateDescription,
                    ),
                    TextFormField(
                      initialValue: snapshot.data['price']?.toStringAsFixed(2),
                      style: _fieldStyle,
                      decoration: _buildDecoration('Preço'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onSaved: _productBloc.savePrice,
                      validator: validatePrice,
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}

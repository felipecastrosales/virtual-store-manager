import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../tiles/category_tile.dart';

class ProductsTab extends StatefulWidget {
  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> 
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor)
            ),
          );
        } 
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            return CategoryTile(snapshot.data.documents[index]);
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

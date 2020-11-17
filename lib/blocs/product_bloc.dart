import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductBloc extends BlocBase {
  String categoryId;
  DocumentSnapshot product;
  ProductBloc({this.categoryId, this.product});

  @override
  void dispose() {}
}

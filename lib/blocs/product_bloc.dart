import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  Stream<Map> get outData => _dataController.stream;
  String categoryId;
  DocumentSnapshot product;
  Map<String, dynamic> unsavedData;
  ProductBloc({this.categoryId, this.product}) {
    if (product != null) {
      unsavedData = Map.of(product.data);
      unsavedData['images'] = List.of(product.data['images']);
      unsavedData['sizes'] = List.of(product.data['sizes']);
    } else {
      unsavedData = {
        'title': null,
        'description': null,
        'price': null,
        'images': [],
        'sizes': [],
      };
    }
    _dataController.add(unsavedData);
  }

  void saveImages(List images) {
    unsavedData['images'] = images;
  }

  void saveTitle(String title) {
    unsavedData['title'] = title;
  }

  void saveDescription(String description) {
    unsavedData['description'] = description;
  }

  void savePrice(String price) {
    unsavedData['price'] = double.parse(price);
  }
  
  @override
  void dispose() {
    _dataController.close();
  }
}

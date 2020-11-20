import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  final _titleController = BehaviorSubject<String>();
  final _imageController = BehaviorSubject();
  final _deleteController = BehaviorSubject<bool>();

  Stream<String> get outTile => _titleController.stream;
  Stream get outImage => _imageController.stream;
  Stream<bool> get outDelete => _deleteController.stream;

  DocumentSnapshot category;
  CategoryBloc(this.category) {
    if (category != null) {
      _titleController.add(category.data['title']);
      _imageController.add(category.data['icon']);
      _deleteController.add(true);
    } else {
      _deleteController.add(false);
    }
  }

  @override
  void dispose() {
    _titleController.close();
    _imageController.close();
    _deleteController.close();
  }
}

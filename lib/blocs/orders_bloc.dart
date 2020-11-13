import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

// ignore: constant_identifier_names
enum SortCriteria { READY_FIRST, READY_LAST }

class OrdersBloc extends BlocBase {
  final _ordersController = BehaviorSubject<List>();
  Stream<List> get outOrders => _ordersController.stream;
  final Firestore _firestore = Firestore.instance;
  final List<DocumentSnapshot> _orders = [];
  SortCriteria _criteria;

  OrdersBloc() {
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection('orders').snapshots().listen((snapshot) {
      // ignore: avoid_function_literals_in_foreach_calls
      snapshot.documentChanges.forEach((change) {
        var oid = change.document.documentID;
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(change.document);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.documentID == oid);
            _orders.add(change.document);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.documentID == oid);
            break;
        }
      });
      _sort();
    });
  }

  void setOrderCriteria(SortCriteria criteria) {
    criteria = criteria;
    _sort();
  }

  void _sort() {
    switch(_criteria) {
      case SortCriteria.READY_FIRST:
        _orders.sort((a, b) {
          int statusA = a.data['status'];
          int statusB = b.data['status'];
          if (statusA < statusB) {
            return 1;
          } else if (statusA > statusB) {
            return -1;
          } else {
            return 0;
          }
        });
        break;
      case SortCriteria.READY_LAST: 
        _orders.sort((a, b) {
          int statusA = a.data['status'];
          int statusB = b.data['status'];
          if (statusA > statusB) {
            return 1;
          } else if (statusA < statusB) {
            return -1;
          } else {
            return 0;
          }
        });
        break;
    }
    _ordersController.add(_orders);
  }

  @override
  void dispose() {
    _ordersController.close();
  }
}
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {
  final _usersController = BehaviorSubject<List>();
  final Map<String, Map<String, dynamic>> _users = {};
  final Firestore _firestore = Firestore.instance;

  Stream<List> get outUsers => _usersController.stream;

  UserBloc() {
    _addUsersListener();
  }

  void _addUsersListener() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        var uid = change.document.documentID;

        switch (change.type) {
          case DocumentChangeType.added:
            _users[uid] = change.document.data;
            _subscribeToOrders(uid);
            break;

          case DocumentChangeType.modified:
            _users[uid].addAll(change.document.data);
            _usersController.add(_users.values.toList());
            break;

          case DocumentChangeType.removed:
            _users.remove(uid);
            _unsubscribeToOrders(uid);
            _usersController.add(_users.values.toList());
            break;
        }
        ;
      });
    });
  }

  void _subscribeToOrders(String uid) {
    _users[uid]['subscription'] = _firestore
        .collection('users')
        .document(uid)
        .collection('orders')
        .snapshots()
        .listen((orders) async {
          
      var numOrders = orders.documents.length;
      var money = 0.0;

      for (var docSnap in orders.documents) {
        var order = await _firestore
            .collection('orders')
            .document(docSnap.documentID)
            .get();

        if (order.data == null) continue;

        money += order.data['totalPrice'];
      }

      _users[uid].addAll({
        'money': money,
        'orders': numOrders,
      });

      _usersController.add(_users.values.toList());
    });
  }

  void _unsubscribeToOrders(String uid) {
    _users[uid]['subscription'].cancel();
  }

  @override
  void dispose() {
    _usersController.close();
  }
}

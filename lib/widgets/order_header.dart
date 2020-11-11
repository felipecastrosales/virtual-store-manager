import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../blocs/user_bloc.dart';

class OrderHeader extends StatelessWidget {
  final DocumentSnapshot order;
  OrderHeader(this.order);
  
  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of<UserBloc>(context);
    final _user = _userBloc.getUser(order.data['clientId']);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${_user['name']}',
                style: TextStyle(fontSize: 20)),
              Text('${_user['address']}', style: TextStyle(fontSize: 16)),
            ]
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Produtos: R\$'
              '${order.data['productsPrice'].toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
            Text(
              'Total: R\$'
              '${order.data['totalPrice'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
              )
            ),
          ],
        ),
      ],
    );
  }
}

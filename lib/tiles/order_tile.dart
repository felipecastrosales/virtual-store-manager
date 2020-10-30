import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  final DocumentSnapshot order;
  OrderTile(data, {this.order});

  final states = [
    '',
    'Em preparação',
    'Em transporte',
    'Aguardando entrega',
    'Entregue'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ExpansionTile(
          title: Text(
            // ignore: lines_longer_than_80_chars
            '#${order.documentID.substring(order.documentID.length - 7, order.documentID.length)} - '
            '${states[order.data['status']]}',
            style: TextStyle(color: order.data['status'] != 4 
              ? Colors.grey[850]
              : Colors.green
            ),
          ),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OrderHeader(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: order.data['products'].map<Widget>((p) {
                        return ListTile(
                          // ignore: prefer_interpolation_to_compose_strings
                          title: Text(p['product']['title'] + ' ' + p['size']),
                          // ignore: prefer_interpolation_to_compose_strings
                          subtitle: Text(p['category'] + '/' + p['productId']),
                          trailing: Text(p['quantity'], 
                            style: TextStyle(fontSize: 20)),
                          contentPadding: EdgeInsets.zero,
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {},
                          child: Text('Excluir',
                              style: TextStyle(color: Colors.red)),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text('Regredir',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text('Avançar',
                              style: TextStyle(color: Colors.green)),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

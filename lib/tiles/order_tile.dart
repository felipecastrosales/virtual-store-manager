import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  final DocumentSnapshot order;
  OrderTile(this.order);

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
          key: Key(order.documentID),
          //initiallyExpanded: order.data['status'] != 4,
          title: Text(
            // ignore: lines_longer_than_80_chars
            '#${order.documentID.substring(order.documentID.length - 7, order.documentID.length)} - '
            '${states[order.data['status']]}',
            style: TextStyle(color: order.data['status'] != 4 
              ? Colors.grey[400]
              : Colors.green
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderHeader(order),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: order.data['products'].map<Widget>((p) {
                      return ListTile(
                        // ignore: prefer_interpolation_to_compose_strings
                        title: Text(p['product']['title'] + ' ' + p['size']),
                        // ignore: prefer_interpolation_to_compose_strings
                        subtitle: Text(p['category'] + '/' + p['productId']),
                        trailing: Text(p['quantity'].toString(), 
                          style: TextStyle(fontSize: 20)),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Firestore.instance
                            .collection('users')
                            .document(order['clientId'])
                            .collection('orders')
                            .document(order.documentID)
                            .delete();
                          order.reference.delete();
                        },
                        child: Text(
                          'Excluir',
                          style: TextStyle(color: Colors.red)),
                      ),
                      FlatButton(
                        onPressed: order.data['status'] > 1
                          ? () {order.reference.updateData(
                            {'status': order.data['status'] - 1});
                          } : null,
                        child: Text(
                          'Regredir',
                          style: TextStyle(color: Colors.grey)),
                      ),
                      FlatButton(
                        onPressed: order.data['status'] > 4
                          ? () {order.reference.updateData(
                            {'status': order.data['status'] + 1});
                          } : null,
                        child: Text(
                          'Avançar',
                          style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}

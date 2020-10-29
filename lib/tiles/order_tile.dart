import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ExpansionTile(
          title: Text(
            '#vs gt - Entregue',
            style: TextStyle(color: Colors.green),
          ),
          children: <Widget>[
            Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min, 
                    children: <Widget>[
                      ListTile(
                      title: Text('Camiseta'),
                      subtitle: Text('Camisetas/sgvejhenbrt'),
                      trailing: Text('2', style: TextStyle(fontSize: 20)),
                      contentPadding: EdgeInsets.zero,
                      ),
                    ]
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
              )
            ),
          ],
        ),
      ),
    );
  }
}

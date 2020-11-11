import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Felipe', style: TextStyle(fontSize: 20)),
              Text('Rua', style: TextStyle(fontSize: 16)),
            ]
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('Preço Produtos', style: TextStyle(fontSize: 18)),
            Text(
              'Total:', 
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
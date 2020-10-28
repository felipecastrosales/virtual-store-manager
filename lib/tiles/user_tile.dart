import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kLabelStyle = TextStyle(
      color: Colors.white,
    );

    return ListTile(
      title: Text('title', style: kLabelStyle),
      subtitle: Text('subtitle', style: kLabelStyle,),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Pedidos', style: kLabelStyle,),
          Text('Gasto', style: kLabelStyle),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final kLabelStyle = TextStyle(color: Colors.white);

    if (user.containsKey('money')) {
      return ListTile(
        title: Text(user['name'], style: kLabelStyle),
        subtitle: Text(user['email'], style: kLabelStyle),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ 
            Text('Pedidos: ${user['orders']}', style: kLabelStyle),
            Text('Gasto: R\$${user['money'].toStringAsFixed(2)}',
              style: kLabelStyle),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey, 
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  color: Colors.white.withAlpha(50),
                ),
              ),
            ),
            SizedBox(
              width: 50,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  color: Colors.white.withAlpha(50)),
              ),
            ),
          ],
        ),
      );
    }
  }
}

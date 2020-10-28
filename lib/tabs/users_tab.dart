import 'package:flutter/material.dart';
import '../tiles/user_tile.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            style: TextStyle(
              color: Colors.white70,
            ),
            decoration: InputDecoration(
                hintText: 'Pesquise clientes',
                hintStyle: TextStyle(color: Colors.white70),
                icon: Icon(Icons.search, color: Theme.of(context).accentColor),
                border: InputBorder.none),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return UserTile();
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: 5
          ),
        )
      ],
    );
  }
}

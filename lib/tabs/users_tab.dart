import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../blocs/user_bloc.dart';
import '../tiles/user_tile.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of<UserBloc>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            onChanged: _userBloc.onChangedSearch,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              hintText: 'Pesquise clientes',
              hintStyle: TextStyle(color: Colors.white70),
              icon: Icon(Icons.search, color: Theme.of(context).accentColor),
              border: InputBorder.none
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List>(
            stream: _userBloc.outUsers,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).accentColor)),
                );
              } else if (snapshot.data.length == 0) {
                  return Center(
                    child: Text('Nenhum usuário encontrado.',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 24)),
                  );
              } else {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return UserTile(snapshot.data[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: snapshot.data.length);
              }
            }
          ),
        )
      ],
    );
  }
}

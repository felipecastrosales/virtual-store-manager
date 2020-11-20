import 'package:flutter/material.dart';

class EditCategoryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: GestureDetector(
                child: CircleAvatar(

                ),
              ),
              title: TextField(

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text('Excluir'),
                  textColor: Colors.red,
                  onPressed: () {

                  },
                ),
                FlatButton(
                  child: Text('Salvar'),
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    
                  },
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
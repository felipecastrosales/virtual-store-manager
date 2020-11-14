import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot category;
  CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(category.data['icon']),
            backgroundColor: Colors.transparent,
          ),
          title: Text(
            category.data['title'],
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
              future: category.reference.collection('items').getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            doc.data['images'][0]
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(doc.data['title']),
                        trailing: Text(
                          'R\$${doc.data['price'].toStringAsFixed(2)}'
                        ),
                        onTap: (){},
                      );
                    }).toList()..add(
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.add, color: Theme.of(context).accentColor),
                        ),
                        title: Text('Adicionar'),
                        onTap: (){},
                      ),
                    )
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

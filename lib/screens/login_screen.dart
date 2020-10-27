import 'package:flutter/material.dart';
import '../widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(), // after: test without stack
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory_rounded,
                    color: Theme.of(context).accentColor,
                    size: 160,
                  ),
                  InputField(
                    icon: Icons.person_outline_rounded,
                    hint: 'Usuário',
                    obscure: false,
                  ),
                  InputField(
                    icon: Icons.lock_open_rounded,
                    hint: 'Senha',
                    obscure: true,
                  ),
                  SizedBox(
                    height: 32,
                    width: double.maxFinite,
                    child: Divider(
                      thickness: 1.5,
                      color: Theme.of(context).accentColor,
                      indent: 50,
                      endIndent: 50,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

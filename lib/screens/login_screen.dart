import 'package:flutter/material.dart';
import '../blocs/login_bloc.dart';
import '../widgets/input_field.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
          break;
        
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Erro'),
                content: Text('Você não possui os privilégios necessários')));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: StreamBuilder<LoginState>(
         stream: _loginBloc.outState,
         initialData: LoginState.LOADING,
         // ignore: missing_return
         builder: (context, snapshot) {
          switch (snapshot.data) {
            case LoginState.LOADING:
              return Center(
                child: CircularProgressIndicator(valueColor:
                  AlwaysStoppedAnimation(Theme.of(context).accentColor)));
            case LoginState.IDLE:
            case LoginState.SUCCESS:
            case LoginState.FAIL:
              return Stack(
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
                            stream: _loginBloc.outEmail,
                            onChanged: _loginBloc.changeEmail,
                          ),
                          InputField(
                           icon: Icons.lock_open_rounded,
                           hint: 'Senha',
                           obscure: true,
                           stream: _loginBloc.outPassword,
                           onChanged: _loginBloc.changePassword,
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
                          StreamBuilder<bool>(
                            stream: _loginBloc.outSubmitValid,
                            builder: (context, snapshot) {
                              return SizedBox(
                                height: 50,
                                child: RaisedButton(
                                  color: Theme.of(context).accentColor,
                                  child: Text(
                                    'Entrar', style: TextStyle(fontSize: 20)),
                                  textColor: Colors.white,
                                  disabledColor: Colors.greenAccent[800],
                                  onPressed: snapshot.hasData 
                                    ? _loginBloc.submit 
                                    : null,
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        }
      ),
    );
  }
}

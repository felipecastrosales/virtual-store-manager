import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../blocs/orders_bloc.dart';
import '../blocs/user_bloc.dart';
import '../tabs/orders_tab.dart';
import '../tabs/users_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;

  UserBloc _userBloc;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).accentColor,
          primaryColor: Colors.black,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.black),
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          unselectedItemColor: Colors.grey[100],
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontSize: 15),
          onTap: (toPage) {
            _pageController.animateToPage(toPage,
              duration: Duration(milliseconds: 200),
              curve: Curves.ease
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Produtos',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: BlocProvider<OrdersBloc>(
            bloc: _ordersBloc,
            child: PageView(
              controller: _pageController,
              onPageChanged: (toPage) {
                setState(() {
                  _page = toPage;
                });
              },
              children: <Widget>[
                UsersTab(),
                OrdersTab(),
                Container(color: Colors.green),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  // ignore: missing_return
  Widget _buildFloating() {
    switch (_page) {
      case 0:
        return null;
      case 1:
        return SpeedDial(
          child: Icon(Icons.sort, color: Colors.white),
          backgroundColor: Theme.of(context).accentColor,
          overlayOpacity: 0.4,
          overlayColor: Theme.of(context).primaryColor,
          children: [
            SpeedDialChild(
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
              ),
              label: 'Concluídos abaixo',
              labelStyle: TextStyle(
                fontSize: 14, color: Theme.of(context).primaryColor),
              onTap: () {
                _ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
              },
            ),
            SpeedDialChild(
              child: Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white,
              ),
              label: 'Concluídos acima',
              labelStyle: TextStyle(
                fontSize: 14, color: Theme.of(context).primaryColor),
              onTap: () {
                _ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
              },
            ),
          ],
        );
    }
  }
}

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
          unselectedItemColor: Colors.black87,
          selectedItemColor: Colors.black,
          onTap: (toPage) {
            _pageController.animateToPage(toPage,
                duration: Duration(milliseconds: 200),
                curve: Curves.decelerate);
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (toPage) {
          setState(() {
            _page = toPage;
          });
        },
        children: <Widget>[
          Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.green),
        ],
      ),
    );
  }
}

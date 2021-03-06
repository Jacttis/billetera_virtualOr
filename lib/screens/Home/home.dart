import 'package:billetera_virtual/screens/Home/Pages/Agregar/agregar.dart';
import 'package:billetera_virtual/screens/Home/Pages/Mas/masPage.dart';
import 'package:billetera_virtual/screens/Home/Pages/Cuenta/Cuenta.dart';
import 'package:billetera_virtual/screens/Home/Pages/Mas/masPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //State class
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final Cuenta _cuenta = Cuenta() ;
  final Agregar _agregar=Agregar();
  final MasPage _masPage=MasPage();

  Widget _showPage=new Cuenta();

  /*
   *Devuelve la pagina elegida
  * */
  Widget _pageChooser(int page){
    switch(page){
      case 0:return _cuenta;break;
      case 1:return _agregar;break;
      case 2:return _masPage;break;
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*
        * Barra de Navegacion
        * */
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          backgroundColor: Colors.deepPurple[400],
          color: Colors.deepPurple[400],
          items: <Widget>[

            Icon(Icons.account_balance_wallet, size: 30),
            Icon(Icons.add_circle, size: 30),
            Icon(Icons.more_horiz, size: 30,),
          ],

          /*
          * Funcion que Setea la pagina del icono seleccionado
          * */
          onTap: (index) {
            setState(() {
              _showPage  = _pageChooser(index);
            });
          },
        ),


        body: Container(
          padding: EdgeInsets.only(bottom: 10.40),
          decoration:BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.deepPurple[700],Colors.deepPurple[500],Colors.deepPurple[400]]

            ),
          ),
          child:_showPage,
          ),
        );
  }
}

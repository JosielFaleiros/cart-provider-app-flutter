import 'package:cart_app/screens/MyCart.dart';
import 'package:cart_app/screens/MyCatalog.dart';
import 'package:cart_app/screens/MyLogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/CartModel.dart';
import 'models/CatalogModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            print('ChangeNotifierProxyProvider<CatalogModel, CartModel> .update()');
            cart.catalog = catalog;
            return cart;
          },
        )
      ],
      child: MaterialApp(
        title: 'Cart with provider',
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}

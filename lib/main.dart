import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// Providers
import './providers/cart_provider.dart';
import './providers/category_provider.dart';
import './providers/product_provider.dart';


// Screens
import './screens/default_screen.dart';
import './screens/product_detail/product_detail_screen.dart';
import './screens/auth/auth_screen.dart';
import './screens/cart/cart_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CartProvider()
        ),
        ChangeNotifierProvider.value(
          value: CategoryProvider()
        ),
        ChangeNotifierProvider.value(
          value: ProductProvider()
        ),
      ],
      child: MaterialApp(
        title: 'MainDartTitle',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,

          buttonTheme: ButtonThemeData(
            minWidth: 20,
            height: 15
          )
        ),
        // initialRoute: '/',
        initialRoute: AuthScreen.routeName,
        routes: {
          AuthScreen.routeName : (ctx) => AuthScreen(),
          DefaultScreen.routeName : (ctx) => DefaultScreen(),
          ProductDetailScreen.routeName : (ctx) => ProductDetailScreen(),
          CartScreen.routeName : (ctx) => CartScreen(),
        },
      ),
    );
  }
}



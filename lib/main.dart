import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// Providers
import './providers/cart_provider.dart';
import './providers/category_provider.dart';
import './providers/product_provider.dart';
import './providers/auth_provider.dart';
import './providers/order_provider.dart';


// Screens
import './screens/default_screen.dart';
import './screens/product_detail/product_detail_screen.dart';
import './screens/auth/auth_screen.dart';
import './screens/cart/cart_screen.dart';
import './screens/order_details/order_details_screen.dart';
import './screens/order_address_details/order_address_details_screen.dart';
import './screens/create_new_address/create_new_address_screen.dart';
import './screens/my_orders/my_orders_screen.dart';
import './screens/single_order/single_order_screen.dart';


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
          value: AuthProvider()
        ),

        // ChangeNotifierProvider.value(
        //   value: CategoryProvider()
        // ),

        ChangeNotifierProxyProvider< AuthProvider, CategoryProvider > (
          create: ( ctx ) => CategoryProvider( null, null, [], [], []  ),
          update: ( _, authProvider, previousCategoryProvider ) => CategoryProvider(
            authProvider.token,
            authProvider.customerModel,
            previousCategoryProvider == null
              ? []
              : previousCategoryProvider.mainCategoryList,
            previousCategoryProvider == null
              ? []
              : previousCategoryProvider.specialCategoryOnHomePageList,
            previousCategoryProvider == null
              ? []
              : previousCategoryProvider.featureList,
          ),
        ),
        
        ChangeNotifierProxyProvider< AuthProvider, ProductProvider > (
          create: ( _ ) => ProductProvider(),
          update: ( _, authProvider, previousProductProvider ) => previousProductProvider!
          ..update(
            authProvider.token,
            authProvider.customerModel,
            previousProductProvider == null
              ? []
              : previousProductProvider.searchedProductsList,
            previousProductProvider == null
              ? false
              : previousProductProvider.isLoadingProducts,
            previousProductProvider == null
              ? false
              : previousProductProvider.isLoadingFavorites,
            previousProductProvider == null
              ? false
              : previousProductProvider.isFavoritesFetched,
            previousProductProvider == null
              ? []
              : previousProductProvider.favoriteProducts,
            previousProductProvider == null
              ? []
              : previousProductProvider.specialPriceItems,
            previousProductProvider == null
              ? []
              : previousProductProvider.mostPopularProductsList,
          ),
        ),

        ChangeNotifierProxyProvider< AuthProvider, OrderProvider > (
          create: ( ctx ) => OrderProvider(
             null, null, 
            ),
          update: ( _, authProvider, previousOrderProvider ) => OrderProvider(
            authProvider.token,
            authProvider.customerModel,
          ),
        ),



        ChangeNotifierProvider.value(
          value: CartProvider()
        ),

      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authData, _ ) => MaterialApp(
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
          // initialRoute: AuthScreen.routeName,
          home: authData.isAppInited 
            ? (authData.token != null) ? DefaultScreen() : AuthScreen()
            :  FutureBuilder(
                    future: authData.initialiseApp(),
                    builder: ( _, authResultSnapShot ) =>
                    authResultSnapShot.connectionState ==  ConnectionState.waiting
                      ? Center(child: CircularProgressIndicator(),)
                      : ( 
                          authData.token != null 
                        )
                          ? DefaultScreen()
                          : AuthScreen()
                  ),
 
          
           

          routes: {
            AuthScreen.routeName : (ctx) => AuthScreen(),
            DefaultScreen.routeName : (ctx) => DefaultScreen(),
            ProductDetailScreen.routeName : (ctx) => ProductDetailScreen(),
            CartScreen.routeName : (ctx) => CartScreen(),
            OrderDetailsScreen.routeName : (ctx) => OrderDetailsScreen(),
            OrderAddressDetailsScreen.routeName : (ctx) => OrderAddressDetailsScreen(),
            CreateNewAddressScreen.routeName : (ctx) => CreateNewAddressScreen(),
            MyOrdersScreen.routeName : (ctx) => MyOrdersScreen(),
            SingleOrderScreen.routeName: (ctx) => SingleOrderScreen(),
          },
        ),
      ) 
    );
  }
}



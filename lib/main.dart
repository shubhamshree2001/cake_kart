import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notification/configuration/local.dart';
import 'package:notification/controllers/user.dart';
import 'package:notification/pages/addressDetails.dart';
import 'package:notification/pages/addressDetailsCustom.dart';
import 'package:notification/pages/cart.dart';
import 'package:notification/pages/chalaan.dart';
import 'package:notification/pages/checkout.dart';
// import 'package:notification/pages/dryCheckout.dart';
// import 'package:notification/pages/dryCart.dart';
import 'package:notification/pages/customCheckOut.dart';
import 'package:notification/pages/details.dart';
import 'package:notification/pages/home.dart';
import 'package:notification/pages/login.dart';
import 'package:notification/pages/map.dart';
import 'package:notification/pages/map_preloader.dart';
import 'package:notification/pages/orderComplete.dart';
import 'package:notification/pages/orderDetails.dart';
import 'package:notification/pages/otp.dart';
import 'package:notification/pages/pastry.dart';
import 'package:notification/pages/dry.dart';
import 'package:notification/pages/premium.dart';
import 'package:notification/pages/receipt.dart';
import 'package:notification/pages/regular.dart';
import 'package:notification/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notification/pages/wakInOrderComplete.dart';
import 'package:notification/pages/walkInOrderDetails.dart';
import 'package:notification/providers/address.dart';
import 'package:notification/providers/cart.dart';
import 'package:notification/providers/categories.dart';
import 'package:notification/providers/category.dart';
import 'package:notification/providers/map.dart';
import 'package:notification/providers/walkInCategories.dart';
import 'package:notification/providers/dryProductCategories.dart';
import 'package:provider/provider.dart';
import 'package:notification/providers/imagesCategories.dart';

void main() async {
  // Register controllers4
  // Example:
  // Get.put(Controller);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color.fromRGBO(240, 240, 240, 1),
      ),
    );
    return ChangeNotifierProvider<CategoryProvider>(
      create: (_) => CategoryProvider(),
      child: ChangeNotifierProvider<CategoriesProvider>(
        create: (_) => CategoriesProvider(),
        child: ChangeNotifierProvider(
          create: (_) => DryProductsCategoriesProvider(),
          child: ChangeNotifierProvider(
            create: (_) => WalkInCategoriesProvider(),
            child: ChangeNotifierProvider(
              create: (_) => ImagesCategoriesProvider(),
              child: ChangeNotifierProvider<CartProvider>(
                create: (_) => CartProvider(),
                child: ChangeNotifierProvider<AddressProvider>(
                  create: (_) => AddressProvider(),
                  child: ChangeNotifierProvider(
                    create: (_) => MapProvider(),
                    child: GetMaterialApp(
                      title: LocalConfiguration.name,
                      debugShowCheckedModeBanner: false,
                      // Theme
                      theme: ThemeData(
                        fontFamily: 'Poppins',
                        primarySwatch: Colors.grey,
                        primaryColor: Colors.white,
                        accentColor: Colors.grey,
                        cursorColor: LocalConfiguration.dark,
                        textSelectionHandleColor: LocalConfiguration.dark,
                        textSelectionColor:
                            LocalConfiguration.dark.withOpacity(24 / 100),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        scaffoldBackgroundColor: Colors.white,
                      ),
                      home: StreamBuilder(
                        // ignore: deprecated_member_use
                        stream: FirebaseAuth.instance.onAuthStateChanged,
                        builder: (ctx, userSnapshot) {
                          if (userSnapshot.hasData)
                            return HomePage();
                          else
                            return LoginPage();
                        },
                      ),
                      getPages: [
                        // Register routes
                        // Example
                        // GetPage(name: '/', page: () => Widget()),
                        GetPage(name: '/', page: () => SplashPage()),
                        GetPage(
                            name: '/login',
                            page: () => LoginPage(),
                            transition: Transition.fadeIn),
                        GetPage(name: '/otp', page: () => OtpPage()),
                        GetPage(name: '/details', page: () => DetailsPage()),
                        GetPage(name: '/homePage', page: () => HomePage()),
                        GetPage(name: '/regular', page: () => RegularPage()),
                        GetPage(name: '/premium', page: () => PremiumPage()),
                        GetPage(name: '/pastry', page: () => PastryPage()),
                        GetPage(name: '/dry', page: () => DryPage()),
                        GetPage(name: '/cart', page: () => CartPage()),
                        GetPage(name: '/checkout', page: () => CheckoutPage()),
                        // GetPage(name: '/dryCart', page: () => DryCartPage()),
                        // GetPage(
                        // name: '/dryCheckout', page: () => DryCheckoutPage()),
                        GetPage(
                            name: '/addressDetails',
                            page: () => AddressDetailsPage()),
                        GetPage(
                            name: '/addressDetailsCustom',
                            page: () => AddressDetailsCustomPage()),
                        GetPage(
                            name: '/mapPreload',
                            page: () => MapPreloaderPage()),
                        GetPage(name: '/map', page: () => MapPage()),
                        GetPage(
                            name: '/customCheckout',
                            page: () => CustomCheckOutPage()),
                        GetPage(
                            name: '/orderDetails',
                            page: () => OrderDetailsPage()),
                        GetPage(
                            name: '/walkInOrderDetails',
                            page: () => WalkInOrderDetailsPage()),
                        GetPage(
                            name: '/orderComplete',
                            page: () => OrderComplete()),
                        GetPage(
                            name: "/WalkInOrderComplete",
                            page: () => WalkInOrderComplete()),
                        GetPage(name: '/chalaan', page: () => ChalaanPage()),
                        GetPage(name: '/receipt', page: () => ReceiptPage()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

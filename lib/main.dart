import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:sizzlr_customer_side/providers/authProvider.dart';
import 'package:sizzlr_customer_side/providers/canteenProvider.dart';
import 'package:sizzlr_customer_side/providers/cartProvider.dart';
import 'package:sizzlr_customer_side/providers/couponProvider.dart';
import 'package:sizzlr_customer_side/providers/viewCartLoaderProvider.dart';
import 'package:sizzlr_customer_side/screens/Authentication/LoginScreen.dart';
import 'package:sizzlr_customer_side/screens/Home/HomeScreen.dart';
import 'package:sizzlr_customer_side/screens/Home/ProfileScreen.dart';
import 'package:sizzlr_customer_side/screens/Home/components/components.dart';
import 'package:provider/provider.dart';
import 'constants/constants.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MediaQueryData windowData =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    windowData = windowData.copyWith(
      textScaleFactor: 1,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => CanteenProvider()),
        ChangeNotifierProvider(create: (_) => Coupon()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ViewCartLoader()),
      ],
      child: MediaQuery(
      data: windowData,
      child: MaterialApp(
        useInheritedMediaQuery: true,
        title: 'Sizzlr',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Color(0xFF27742D),
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            if (authProvider.user == null) {
              return LoginScreen();
            } else {
              Provider.of<CanteenProvider>(context, listen: false).getCanteens();
              return MyHomePage();
            }
          },
        ),
      ),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);

  List<Widget> _widgetOptions = <Widget>[
    Text('Index 0'),
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static Future<mongo.Db> connect() async {
      final db = await mongo.Db.create(mongoUri);
      await db.open();
      inspect(db);
      return db;
  }

  static Future<void> close(mongo.Db db) async {
    try {
      await db.close();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    connect();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Image.asset('assets/images/splash-green.png'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6)
                      ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Image.asset(
                          'assets/images/Insignia.png',
                          width: 24,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          '69',
                          style: TextStyle(color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
        leadingWidth: 70,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: Colors.black,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ]),
        child: BottomNavigationBar(
          unselectedLabelStyle:
              TextStyle(fontSize: 10, color: Color(0xFF868686)),
          selectedLabelStyle: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black),
          selectedIconTheme: IconThemeData(color: kPrimaryGreen),
          unselectedIconTheme: IconThemeData(color: Color(0xFF868686)),
          selectedItemColor: Colors.black,
          unselectedItemColor: Color(0xFF868686),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: _selectedIndex == 0
                    ? Icon(Icons.lunch_dining_rounded)
                    : Icon(Icons.lunch_dining_outlined),
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: _selectedIndex == 1
                    ? Icon(Icons.food_bank_rounded)
                    : Icon(Icons.food_bank_outlined),
              ),
              label: 'Order',
            ),
            // BottomNavigationBarItem(
            //   icon: Padding(
            //     padding: const EdgeInsets.only(bottom: 2.0),
            //     child: Icon(Icons.school),
            //   ),
            //   label: 'School',
            // ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: _selectedIndex == 2
                    ? Icon(Icons.person_rounded)
                    : Icon(Icons.person_outline),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

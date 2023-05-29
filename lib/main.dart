import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/categories_meal_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_deail_screen.dart';
import 'package:meal_app/screens/on_boarding_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/categories_screen.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

import 'providers/meal_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  Widget homeScreen =prefs.getBool('watched')?? false ? TabsScreen() :OnBoardingScreen();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (ctx) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx) =>  ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (ctx) =>  LanguageProvider(),
        ),
      ],
      child: MyApp(homeScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;
  MyApp(this.mainScreen);

  @override
  Widget build(BuildContext context) {
    var primaryColor= Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor= Provider.of<ThemeProvider>(context,listen: true).accentColor;
    var tm =Provider.of<ThemeProvider>(context,listen: true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary:accentColor),
        cardColor: Colors.white,
        shadowColor: Colors.white60,
        buttonColor: Colors.black87,

        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 23,
                fontFamily: 'Raleway',
              ),
            ),
      ),
      themeMode: tm,
      darkTheme: ThemeData(
        primarySwatch: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        unselectedWidgetColor: Colors.white,
      buttonColor: Colors.white70,

        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.white60,
              ),
              headline6: TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.bold,
                fontSize: 23,
                fontFamily: 'Raleway',
              ),
            ),
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => OnBoardingScreen(),
        TabsScreen.routName:  (ctx)=> TabsScreen(),
        CategoriesMealScreen.routeName: (context) => CategoriesMealScreen(),
        MealDetailsScreen.routName: (context) => MealDetailsScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemesScreen.routeName: (context) =>ThemesScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      body: null,
    );
  }
}

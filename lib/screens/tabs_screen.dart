import'package:flutter/material.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favourites_screens.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
class TabsScreen extends StatefulWidget{
  static const routName= 'tab_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {


  
  late List<Map<String,Object>> _pages;
  int _selectPageIndex=0;
  @override
  void initState() {
    Provider.of<MealProvider>(context,listen: false).getDate();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen: false).getThemeColor();
    Provider.of<LanguageProvider>(context,listen: false).getLan();



    super.initState();
  }
  void _selectpage(value){
    setState(() {
      _selectPageIndex=value;
    });

  }
  @override
  Widget build(BuildContext context) {

    var lan =Provider.of<LanguageProvider>(context,listen: true);
    _pages=[
      {
        'page': CategoriesScreen(),
        'title': lan.getTexts('categories')
      },
      {
        'page' : FavoritesScreen(),
        'title':  lan.getTexts('your_favorites')
      },
    ];
    return Directionality(
      textDirection:  lan.isEn ?TextDirection.ltr : TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPageIndex]['title'] as String),
        backgroundColor: Provider.of<ThemeProvider>(context,listen: true).primaryColor,
      ),
      body: _pages[_selectPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        items:
        [
       BottomNavigationBarItem(
        icon: Icon(Icons.category,),
         label: lan.getTexts('categories'),

       ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: lan.getTexts('your_favorites'),
          ),
        ],
        onTap:_selectpage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
      ),
      drawer: MainDrawer(),
    ),
  );
  }
}
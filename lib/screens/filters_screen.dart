import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:meal_app/providers/meal_provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';


class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final  bool  fromOnBoarding;

  FiltersScreen({this.fromOnBoarding=false});


  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);
    final Map<String,bool> currentFilters=Provider.of<MealProvider>(context,listen: true).filters;
    final Function saveFilters;

    return Directionality(
      textDirection:  lan.isEn ?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar:widget.fromOnBoarding ? AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
        ) :AppBar(
          title: Text(lan.getTexts('filters_appBar_title')),
          backgroundColor: Provider.of<ThemeProvider>(context,listen: true).primaryColor,

        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                lan.getTexts('filters_screen_title'),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SwitchListTile(
                      title: Text(lan.getTexts("Gluten-free")) ,
                      subtitle: Text(lan.getTexts("Gluten-free-sub")),
                      activeColor: Provider.of<ThemeProvider>(context,listen: true).primaryColor,
                      value: currentFilters['gluten']!,
                      //activeColor: Provider.of<ThemeProvider>(context,listen: true).accentColor,
                      inactiveTrackColor: Provider.of<ThemeProvider>(context,listen: true).tm ==ThemeMode.light ? null : Colors.black,
                      onChanged: (newValue) {
                        setState(() {
                          currentFilters['gluten'] = newValue;
                        });
                        Provider.of<MealProvider>(context,listen: false).setFilters();
                      }),
                  SwitchListTile(
                      title: Text(lan.getTexts("Lactose-free")),
                      subtitle: Text(lan.getTexts("Lactose-free_sub")),
                      activeColor: Provider.of<ThemeProvider>(context,listen: true).primaryColor,
                      inactiveTrackColor: Provider.of<ThemeProvider>(context,listen: true).tm ==ThemeMode.light ? null : Colors.black,
                      value: currentFilters['lactose']!,
                      onChanged: (newValue) {
                        setState(() {
                          currentFilters['lactose'] = newValue;
                        });
                        Provider.of<MealProvider>(context,listen: false).setFilters();
                      }),
                  SwitchListTile(
                      title: Text(
                        lan.getTexts("Vegetarian")
                      ),
                      subtitle: Text(lan.getTexts("Vegetarian-sub")),
                      activeColor: Provider.of<ThemeProvider>(context,listen: true).primaryColor,
                      inactiveTrackColor: Provider.of<ThemeProvider>(context,listen: true).tm ==ThemeMode.light ? null : Colors.black,
                      value: currentFilters['vegeterian']!,
                      onChanged: (newValue) {
                        setState(() {
                          currentFilters['vegeterian'] = newValue;
                        });
                        Provider.of<MealProvider>(context,listen: false).setFilters();
                      }),
                  SwitchListTile(
                    activeColor: Provider.of<ThemeProvider>(context,listen: true).primaryColor,
                      title: Text(lan.getTexts("Vegan")),
                      subtitle: Text(lan.getTexts("Vegan-sub")),
                      inactiveTrackColor: Provider.of<ThemeProvider>(context,listen: true).tm ==ThemeMode.light ? null : Colors.black,
                      value: currentFilters['vegan']!,
                      onChanged: (newValue) {
                        setState(() {
                          currentFilters['vegan'] = newValue;
                        });
                        Provider.of<MealProvider>(context,listen: false).setFilters();
                      }),
                  SizedBox(height: widget.fromOnBoarding? 80:0,),

                ],
              ),
            )
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}

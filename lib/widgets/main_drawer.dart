import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      String text, IconData icon, VoidCallback tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          color: Theme.of(ctx).textTheme.bodyText1!.color,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);
    return Directionality(
      textDirection: lan.isEn ?TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Provider.of<ThemeProvider>(context,listen: true).primaryColor,
              alignment: lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              child: Text(lan.getTexts("drawer_name"),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color:Provider.of<ThemeProvider>(context,listen: true).accentColor,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile(lan.getTexts('drawer_item1'), Icons.restaurant, () {
              Navigator.of(context).pushNamed(TabsScreen.routName);
            }, context),
            buildListTile(lan.getTexts('drawer_item2'), Icons.settings, () {
              Navigator.of(context).pushNamed(FiltersScreen.routeName);
            }, context),
            buildListTile(lan.getTexts('drawer_item3'), Icons.color_lens, () {
              Navigator.of(context).pushNamed(ThemesScreen.routeName);
            }, context),
            Divider(
              height: 10,
              color: Colors.black45,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 20, right: 22),
              child: Text(
                '',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: (lan.isEn ? 0 : 20),
                left: (lan.isEn ? 20 : 0),
                bottom: 2,
                top: 2,
              ),
              child: Row(
                children: [
                  Text(
                    lan.getTexts('drawer_switch_item2'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch(
                    value: Provider.of<LanguageProvider>(context,listen: false).isEn,
                    activeColor: Provider.of<ThemeProvider>(context,listen: true).primaryColor,
                    onChanged: (newValue){
                      value: Provider.of<LanguageProvider>(context,listen: false).changeLan(newValue);
                      Navigator.of(context).pop();
                    },
                 //   inactiveTrackColor:,
                  ),
                  Text(
                    lan.getTexts('drawer_switch_item1'),
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }
}

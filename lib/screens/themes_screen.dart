import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ThemesScreen extends StatelessWidget {
  static const routeName = '/themes';
  final bool fromOnBoarding;

  ThemesScreen({this.fromOnBoarding = false});

  Widget buildRadioListTile(
      ThemeMode themeVal, String txt, IconData icon, BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(
        icon,
        color: Theme.of(ctx).buttonColor,
      ),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (newThemVal) => Provider.of<ThemeProvider>(ctx, listen: false)
          .ThemeModeChange(newThemVal),
      activeColor: Provider.of<ThemeProvider>(ctx,listen: true).primaryColor,
      title: Text(txt),
    );
  }

  @override
  Widget build(BuildContext context) {

    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: fromOnBoarding
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
              )
            : AppBar(
                title: Text(lan.getTexts("theme_appBar_title")),
                backgroundColor:
                    Provider.of<ThemeProvider>(context, listen: true)
                        .primaryColor,
              ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  lan.getTexts("theme_screen_title"),
                  style: Theme.of(context).textTheme.headline6,
                )),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      lan.getTexts("theme_mode_title"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  buildRadioListTile(
                      ThemeMode.system,
                      lan.getTexts("System_default_theme"),
                      Icons.start,
                      context),
                  buildRadioListTile(
                      ThemeMode.light,
                      lan.getTexts("light_theme"),
                      Icons.wb_sunny_outlined,
                      context),
                  buildRadioListTile(ThemeMode.dark, lan.getTexts("dark_theme"),
                      Icons.dark_mode_outlined, context),
                  buildListTile1(context, lan.getTexts("primary")),
                  buildListTile2(context, lan.getTexts("accent")),
                  SizedBox(height: fromOnBoarding ? 80:0,),
                ],
              ),
            ),
          ],
        ),
        drawer: fromOnBoarding ?null :MainDrawer(),
      ),
    );
  }

  ListTile buildListTile1(BuildContext context, txt) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    return ListTile(
        title: Text(lan.getTexts("primary"),
            style: Theme.of(context).textTheme.headline6),
        trailing: CircleAvatar(
          backgroundColor: primaryColor,
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  elevation: 4,
                  titlePadding: EdgeInsets.all(0),
                  contentPadding: EdgeInsets.all(0),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: Provider.of<ThemeProvider>(ctx).primaryColor,
                      colorPickerWidth: 300.0,
                      pickerAreaHeightPercent: 0.7,
                      enableAlpha: false,
                      displayThumbColor: true,
                      showLabel: false,
                      onColorChanged: (newColor) =>
                          Provider.of<ThemeProvider>(ctx, listen: false)
                              .onChanged(newColor, 1),
                    ),
                  ),
                );
              });
        });
  }

  ListTile buildListTile2(BuildContext context, txt) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    return ListTile(
        title: Text(lan.getTexts("accent"),
            style: Theme.of(context).textTheme.headline6),
        trailing: CircleAvatar(
          backgroundColor: accentColor,
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  elevation: 4,
                  titlePadding: EdgeInsets.all(0),
                  contentPadding: EdgeInsets.all(0),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: Provider.of<ThemeProvider>(ctx).accentColor,
                      colorPickerWidth: 300.0,
                      pickerAreaHeightPercent: 0.7,
                      enableAlpha: false,
                      displayThumbColor: true,
                      showLabel: false,
                      onColorChanged: (newColor) =>
                          Provider.of<ThemeProvider>(ctx, listen: false)
                              .onChanged(newColor, 2),
                    ),
                  ),
                );
              });
        });
  }
}

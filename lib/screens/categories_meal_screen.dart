import 'package:flutter/material.dart';
import 'package:meal_app/1.1%20dummy_data.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';


class CategoriesMealScreen extends StatefulWidget {
  static const routeName = 'category_meals';


  @override
  _CategoriesMealScreenState createState() => _CategoriesMealScreenState();
}

class _CategoriesMealScreenState extends State<CategoriesMealScreen> {
  late List<Meal> displayedMeals;
   //late String categoryId;
    String ?categoryId;

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals = Provider
        .of<MealProvider>(context, listen: true)
        .availabeMeals;
    final routeArg = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, String>;
     categoryId = routeArg['id']!;
    displayedMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }


  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);
    bool isLandScape =MediaQuery.of(context).orientation==Orientation.landscape;
    var dw =MediaQuery.of(context).size.width;
    return Directionality(
      textDirection:  lan.isEn ?TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(title: Text(lan.getTexts('cat-$categoryId')), backgroundColor: Provider
              .of<ThemeProvider>(context, listen: true)
              .primaryColor, ),
          body:GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: dw<=400 ? 400 : 500 ,
              childAspectRatio:  isLandScape ?dw/(dw*0.9) : dw/ (dw*0.715) ,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,

            ),
            itemBuilder: (ctx, index) {

            return MealItem(
              id: displayedMeals[index].id,
              imagUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              //removeItem:  _removeMeal,
            );
          },
            itemCount: displayedMeals.length,

          )
      ),
    );
  }
}
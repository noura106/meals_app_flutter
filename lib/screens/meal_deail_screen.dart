import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/1.1 dummy_data.dart';
import 'package:provider/provider.dart';
import 'package:meal_app/providers/meal_provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routName = "meal_detail";

  Widget buildsectionTitle(context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    Color accentcolor = Theme.of(context).colorScheme.secondary;
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    List<String> liIngredientLi =
        lan.getTexts('ingredients-$mealId') as List<String>;
    var li_ingredients = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Card(
          color: accentcolor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              liIngredientLi[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
      itemCount: liIngredientLi.length,
    );
    List<String> stepstLi = lan.getTexts('steps-$mealId') as List<String>;
    var listeps = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text("# ${index + 1}"),
          ),
          title: Text(
            stepstLi[index],
            style: TextStyle(color: Colors.black),
          ),
        );
      },
      itemCount: stepstLi.length,
    );
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts('meal-$mealId')),
                background:Hero(
                  tag: mealId,
                  child: InteractiveViewer(
                    child:
                    FadeInImage(
                      image: NetworkImage(selectedMeal.imageUrl),
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/a2.png'),),
                  ),
                ) ,
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              if (isLandScape) Row(
                children: [
                  Column(
                    children: [
                      buildsectionTitle(context, "Ingredients"),
                      buildContainer(li_ingredients),
                    ],
                  ),
                  Column(
                    children: [
                      buildsectionTitle(context, "Steps"),
                      buildContainer(listeps),
                    ],
                  ),
                ],
              ),
              if (!isLandScape) buildsectionTitle(context, "Ingredients"),
              if (!isLandScape) buildContainer(li_ingredients),
              if (!isLandScape) buildsectionTitle(context, "Steps"),
              if (!isLandScape) buildContainer(listeps),
            ])),
          ],

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFvourite(mealId),
          child: Icon(Provider.of<MealProvider>(context, listen: true)
                  .isFavourite(mealId)
              ? Icons.star
              : Icons.star_border),
        ),
      ),
    );
  }
}

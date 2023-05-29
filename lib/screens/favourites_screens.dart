import 'package:flutter/material.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);
    var dw =MediaQuery.of(context).size.width;
    bool isLandScape =MediaQuery.of(context).orientation==Orientation.landscape;
    final List <Meal> favouriteMeals =Provider.of<MealProvider>(context,listen: true).favouriteMeals;
    if (favouriteMeals.isEmpty)
      {
        return Center(
          child: Text("you have no favourite yet_start add some now!"),
        );
      }
    else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw<=400 ? 400 : 500 ,
          childAspectRatio:  isLandScape ?dw/(dw*0.9) : dw/ (dw*0.715) ,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,

        ),
        itemBuilder:(ctx,index){
        return MealItem(
          id: favouriteMeals[index].id ,
          imagUrl: favouriteMeals[index].imageUrl,
          duration: favouriteMeals[index].duration,
          affordability: favouriteMeals[index].affordability,
          complexity: favouriteMeals[index].complexity,

        );
      },
        itemCount: favouriteMeals.length,
      );
    }

  }
}

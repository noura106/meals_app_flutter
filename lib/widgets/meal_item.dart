import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/screens/meal_deail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imagUrl;
   final int duration;
  final Complexity complexity;
  final Affordability affordability;
  //final Function removeItem;

  MealItem({
    required this.id,
    required this.imagUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
   // required this.removeItem,

  });

  String get complixityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return "Challenging";
        break;
      case Complexity.Hard:
        return "Hard";
        break;
      default:
        return 'unKnown';
        break;
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return "Luxurious";
        break;
      default:
        return 'unKnown';
        break;
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailsScreen.routName, arguments: id,)
        .then((resault) {
          //if (resault !=null ) removeItem(resault);

    });
  }



  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(
                    tag: id,
                    child: InteractiveViewer(
                      child: FadeInImage(
                        height :232,
                        width: double.infinity,
                        image: NetworkImage(imagUrl),
                        fit: BoxFit.cover,
                        placeholder: AssetImage('assets/images/a2.png'),),
                    ),
                  ) ,
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 220,
                    color: Colors.black45,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(lan.getTexts('meal-$id'),
                      style: TextStyle(fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule,color: Theme.of(context).buttonColor,),
                      SizedBox(width: 7,),
                      Text(lan.getTexts('$complexity'))
                    ],
                  ),
                  Row(

                    children: [
                      Icon(Icons.work,color: Theme.of(context).buttonColor),
                      SizedBox(width: 7,),
                      if(duration<=10)
                        Text("$duration" +lan.getTexts('min2')),
                      if(duration>10)
                        Text("$duration" +lan.getTexts('min')),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money,color: Theme.of(context).buttonColor),
                      SizedBox(width: 7,),
                      Text(lan.getTexts('$affordability'))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

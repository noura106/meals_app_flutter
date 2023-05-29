
import 'package:flutter/material.dart';
import 'package:meal_app/1.1 dummy_data.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/CtegoryItem.dart';




class CategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: GridView(
       padding: EdgeInsets.all(25),
         children: Provider.of<MealProvider>(context,listen: true).availabeCategory.map((catData) =>
         CategoryItem( catData.id, catData.color)
         ).toList(),
         gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
           maxCrossAxisExtent: 200,
           childAspectRatio: 3/2,
           crossAxisSpacing: 20,
           mainAxisSpacing: 20,


         ),
     ),
   );
  }

}
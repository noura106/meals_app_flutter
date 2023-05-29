import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/categories_meal_screen.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final Color color;

  void selectcategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesMealScreen.routeName,
      arguments: {
        'id': id,
      }
    );
  }

  CategoryItem( this.id, this.color);

  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () => selectcategory(context),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          lan.getTexts('cat-$id'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.4),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
